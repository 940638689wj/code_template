<script type="text/javascript">
    var flag = false;
    var choiceProductDialog = null;
    var productStore;
    function createDialog(opt) {
        var selectType = opt.selectType ? opt.selectType : 1;//商品选择类型 1：多选 2：单选 （默认多选）
        var showSku = opt.showSku ? opt.showSku : 0;//商品选择类型 1：多选 2：单选 （默认多选）
        var choiceProductBtn = opt.choiceProductBtn ? opt.choiceProductBtn : '';//添加商品按钮选择器
        var disabledOpt = opt.disabledOpt ? opt.disabledOpt : false;//是否禁用操作栏
        var productIds = opt.productIds ? opt.productIds : [];//初始化商品id（逗号分割的字符串）
        var selector = opt.selector ? opt.selector : '';// 表格选择器


        var productGrid;

        var selectProductId = [];
        var paramStr = '?productTypeCd=1';

        if (selectType == 2) {
            paramStr += '&single=1';
        }

        if (showSku) {
            paramStr += '&showSku=1';
        }

        if(!flag){
            flag = true;
            BUI.use('bui/overlay', function (Overlay) {
                choiceProductDialog = new Overlay.Dialog({
                    title: '商品列表',
                    width: 838,
                    height: 460,
                    loader: {
                        url: '${ctx}/admin/sa/promotion/productDialog/productList' + paramStr,
                        autoLoad: false, //不自动加载
                        lazyLoad: false //不延迟加载
                    },
                    buttons: [{
                        text: '选 择',
                        elCls: 'button button-primary',
                        handler: function () {
                            this.close();
                            productChoiceEvent(getSelectedRecords());
                        }
                    }],
                    mask: true
                });
            });
        }

        /**
         * 构建商品表格
         *
         */
        var Grid = BUI.Grid;
        var Data = BUI.Data;
        var Store = Data.Store;
        var productColumns = [
            {title: '商品ID', dataIndex: 'productId', width: 80},
            {
                title: '商品名称',
                dataIndex: 'productName',
                width: 120,
                renderer: function (value) {
                    return app.grid.format.encodeHTML(value);
                }
            },
            {title: '吊牌价', dataIndex: 'tagPrice', width: 100},
            {title: '销售价', dataIndex: 'defaultPrice', width: 100},
            {
                title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
                if (disabledOpt) {
                    return ''
                } else {
                    return '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
                }
            }
            }
        ];



        function buildProductGrid() {
            var param = {};
            param.sort = 'id desc';
            if (selectType == 1) {
                param.in_id = selectProductId.join(',');
            } else if (selectType == 2) {
                param.in_id = selectProductId;
            }

            productStore = new Store({
                url: '${ctx}/admin/sa/promotion/productDialog/grid_json',
                autoLoad: false, //自动加载数据
                params: param,
                pageSize: 5
            });

            productGrid = new Grid.Grid({
                render: selector,
                columns: productColumns,
                store: productStore,
                // 底部工具栏
                bbar: {
                    // pagingBar:表明包含分页栏
                    pagingBar: false
                },
                loadMask: true
            });

            //监听事件，删除一条记录
            productGrid.on('cellclick', function (ev) {
                var sender = $(ev.domTarget); //点击的Dom
                if (sender.hasClass('btn-del')) {
                    var record = ev.record;
                    deleteProduct(record);
                }
            });

            productGrid.render();
        }

        //删除商品操作
        function deleteProduct(record) {
            BUI.Message.Confirm('确认删除记录？', function () {
                if (selectType == 1) {
                    var recordId = "," + record.productId + ",";
                    var originProductIdStr = "," + selectProductId.join(",") + ",";
                    originProductIdStr = originProductIdStr.replace(recordId, ",");

                    var tempArray = originProductIdStr.split(',');
                    tempArray.pop();
                    tempArray.shift();
                    selectProductId = tempArray;
                } else if (selectType == 2) {
                    selectProductId = '';
                }
                reloadProductCondition();
            }, 'question');
        }

        /**
         * 判断是否是添加操作还是编辑操作，在进行数据初始化
         */
        function initProductCondition() {

            $("body").on('click',choiceProductBtn, function () {
                choiceProductDialog.get('loader').load();
                choiceProductDialog.show();
            });

            var isNew = $('input[name="promotionId"]').val();//如果promotionId有就是编辑操作

            if (!isNew) {
                buildProductGrid();
            } else {
                selectProductId = productIds.split(',');
                buildProductGrid();

                var selectProductIdExist;
                if (selectType == 1) {
                    selectProductIdExist = selectProductId.length > 0;
                } else if (selectType == 2) {
                    selectProductIdExist = selectProductId;
                }

                if (selectProductIdExist) {
                    productStore.load();
                }
            }
        }

        //添加新的商品
        function productChoiceEvent(selectedProduct) {
            if (selectType == 1) {
                var oldProductStr = "";
                oldProductStr = "," + selectProductId.join(',') + ",";
                for (var i = 0; i < selectedProduct.length; i++) {
                    var id = selectedProduct[i].productId;
                    if (oldProductStr.indexOf("," + id + ",") < 0) {
                        selectProductId.push(id);
                    }
                }
            } else if (selectType == 2) {
                if (selectedProduct.length > 0) {
                    selectProductId = selectedProduct[0].productId;
                }
            }
            reloadProductCondition();

            //选择商品成功后的回调
            if(opt.choiceProductEvent) {
                opt.choiceProductEvent(selectProductId);
            }
        }

        //重新加载数据
        function reloadProductCondition() {

            var selectProductIdExist;
            if (selectType == 1) {
                selectProductIdExist = selectProductId.length > 0 ;
            } else if (selectType == 2) {
                selectProductIdExist = selectProductId;
                if(selectProductId.length == 0){
                    selectProductIdExist = false;
                }
            }

            if (!productStore) {
                buildProductGrid();
                if (selectProductIdExist) {
                    productStore.load();
                } else {
                    var records = productStore.getResult();
                    productStore.remove(records);
                }
            } else {
                var param = {};
                param.start = 0;
                if (selectType == 1) {
                    param.in_id = selectProductId.join(',');
                } else if (selectType == 2) {
                    param.in_id = selectProductId;
                }

                if (selectProductIdExist) {
                    productStore.load(param);
                } else {
                    var records = productStore.getResult();
                    productStore.remove(records);
                }
            }
        }

        initProductCondition();
//        $(function () {
//        })
    }

</script>