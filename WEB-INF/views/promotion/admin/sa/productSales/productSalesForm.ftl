<#assign ctx = request.contextPath>

<#if type?? && type?has_content>
    <#assign promotionTypeStr = Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_DISCOUNT_TYPE.getFriendlyType()>
    <#if Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_REDUCE_TYPE.getType() == type>
        <#assign promotionTypeStr = Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_REDUCE_TYPE.getFriendlyType()>
    <#elseif Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_SPIKE_TYPE.getType() == type>
        <#assign promotionTypeStr = Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_SPIKE_TYPE.getFriendlyType()>
    </#if>
</#if>
<#assign isAllProductJoin = 1>
<#if promotion?? && promotion?has_content && !promotion.isAllProductJoin>
    <#if productType == 1>
        <#assign isAllProductJoin = 2>
    <#elseif productType == 2>
        <#assign isAllProductJoin = 3>
    </#if>
</#if>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">

    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list?type=${type!}">${promotionTypeStr!}促销</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew>新增<#else>编辑</#if>${promotionTypeStr!}促销</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="save" method="post">
        <input type="hidden" name="promotionId" value="${(promotion.promotionId)!}"/>
        <input type="hidden" name="promotionTypeCd" value="${type!}">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>促销名称：</label>
                    <div class="controls">
                        <input value="${(promotion.promotionName)!?html}" name="promotionName"
                               data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">促销描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="promotionDesc"
                                  class="control-row4 input-large">${(promotion.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                <#assign statusCd='1'/>
                <#if promotion?? && promotion?has_content && promotion.statusCd == 0>
                    <#assign statusCd='0'/>
                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1" <#if statusCd=="1">checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0" <#if statusCd=="0">checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>有效日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                    <#if (promotion.enableStartTime)?has_content>
                        <input disabled type="text" id="enableStartTime" class="calendar calendar-time control-text"
                               name="enableStartTime" data-rules="{required:true}"
                               value="${(promotion.enableStartTime)?string('yyyy-MM-dd HH:mm:ss')}">
                    <#else>
                        <input type="text" id="enableStartTime" class="calendar calendar-time control-text"
                               name="enableStartTime" data-rules="{required:true,minDate:'${.now}'}" value="">
                    </#if>
                        <span>至</span>
                    <#if (promotion.enableEndTime)?has_content>
                        <input disabled type="text" class="calendar calendar-time control-text" name="enableEndTime"
                               data-rules="{required:true}"
                               value="${(promotion.enableEndTime)?string('yyyy-MM-dd HH:mm:ss')}">
                    <#else>
                        <input type="text" class="calendar calendar-time control-text" name="enableEndTime"
                               data-rules="{required:true,minDate:'${.now}'}" value="">
                    </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员级别：</label>
                    <div class="controls control-row-auto">
                    <#assign isAllUserLevel = (promotion.isAllUserLevelJoin)?default(true)/>
                        <label class="checkbox">
                            <input <#if promotion??>disabled</#if> <#if isAllUserLevel> checked="checked" </#if>
                                   id="allUserLevel" name="allUserLevel" value='1' type="checkbox">
                            全选
                        </label><br>

                    <#if userLevelList?? && (userLevelList?size > 0)>
                        <#assign temp = 1>
                        <#list userLevelList as userLevel>
                            <#assign userLevelId = (userLevel.userLevelId)?string>
                            <#assign userLevelSelect = false/>
                            <#if (userLevelXrefMap[userLevelId])??>
                                <#assign userLevelSelect = true/>
                            </#if>

                            <label class="checkbox">
                                <input <#if promotion??>disabled</#if> name="userLevel" <#if userLevelSelect>
                                       checked='checked' </#if> type="checkbox" value="${(userLevel.userLevelId)!}">
                            ${(userLevel.userLevelName)!}
                            </label>&nbsp;&nbsp;

                            <#if temp % 6 == 0>
                                <br>
                            </#if>
                            <#assign temp = temp + 1 >
                        </#list>
                    </#if>
                    </div>
                </div>
            </div>
            <div id="edit-div" class="well">
            <#assign isAllProduct = (promotion.isAllProductJoin)?default(true)/>
                <input type="hidden" name="selectProductIds" id="selectProductIds" value="${productIds!}">
                <input type="hidden" id="productIds" value="<#if isAllProductJoin == 2>${productIds!}</#if>">
                <input type="hidden" id="categorys" name="categorys" value="">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="width:120px;">
                            <input <#if promotion??>disabled</#if> name="activityProducts"
                                   type="radio" <#if isAllProductJoin == 1> checked="checked" </#if>
                                   id="conditionRule_ALL" value="1"/>&nbsp;所有商品
                        </label>
                        <div class="controls control-row-auto" style="display: none;">
                            <input type="text" value="ALL" class="input-normal control-text">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group subTotalCondition">
                        <label class="control-label" style="width:120px;">
                            <input <#if promotion??>disabled</#if> name="activityProducts" <#if isAllProductJoin == 3>
                                   checked="checked" </#if> type="radio" id="conditionRule_category" value="3"/>&nbsp;商品分类
                        </label>
                    </div>
                </div>
                <div class="row hide" id="categoryInfo">
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="width:120px;">
                            <input <#if promotion??>disabled</#if> name="activityProducts" <#if isAllProductJoin == 2>
                                   checked="checked" </#if> type="radio" id="conditionRule_product" value="2"/>&nbsp;指定商品
                        </label>
                    </div>
                </div>
                <div class="row hide" id="productInfo">
                    <ul class="toolbar">
                        <li>
                            <button id="choiceProductBtn" type="button" class="button button-info">
                                <i class="icon icon-white icon-envelope"></i> 选择商品
                            </button>
                        </li>
                    </ul>
                    <hr>
                    <div class="search-grid-container">
                        <div id="productGrid"></div>
                    </div>
                </div>
            </div>
        <#assign isVersatile = false>
        <#if promotion?? && promotion?has_content>
            <#assign isVersatile = true>
        </#if>

            <div id="edit-div" class="well">
            <#if (!isVersatile && Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_DISCOUNT_TYPE.getType() == type) ||
            (isVersatile && promotion.promotionTypeCd == Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_DISCOUNT_TYPE.getType())>
                <div class="row">
                    <div class="control-group percentOffExecution">
                        <label class="control-label" style="width:120px;">
                            <input <#if promotion??>disabled</#if> checked="checked" type="radio" name="discunt"/>&nbsp;商品打&nbsp;
                        </label>
                        <div class="controls control-row-auto">
                            <input <#if promotion??>disabled</#if> type="text" value="${conditionValue!}"
                                   name="conditionValue" id="execution_percent" class="input-normal control-text">&nbsp;折出售
                        </div>
                    </div>
                </div>
            </#if>
            <#if (!isVersatile && Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_REDUCE_TYPE.getType() == type) ||
            isVersatile && promotion.promotionTypeCd == Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_REDUCE_TYPE.getType()>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="width:120px;">
                            <input <#if promotion??>disabled</#if> checked="checked" type="radio" name="reduce"/>商品减去固定价格
                        </label>
                        <div class="controls control-row-auto">
                            <input <#if promotion??>disabled</#if> type="text" value="${conditionValue!}"
                                   name="conditionValue" id="execution_amount" class="input-normal control-text">&nbsp;出售
                        </div>
                    </div>
                </div>
            </#if>
            <#if (!isVersatile && Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_SPIKE_TYPE.getType() == type) ||
            isVersatile && promotion.promotionTypeCd == Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_SPIKE_TYPE.getType()>
                <div class="row">
                    <div class="control-group percentOffExecution">
                        <label class="control-label" style="width:120px;">
                            <input <#if promotion??>disabled</#if> checked="checked" type="radio" name="spike"/>&nbsp;商品以固定价格&nbsp;
                        </label>
                        <div class="controls control-row-auto">
                            <input <#if promotion??>disabled</#if> type="text" value="${conditionValue!}"
                                   name="conditionValue" id="execution_fixPrice" class="input-normal control-text">&nbsp;元出售
                        </div>
                    </div>
                </div>
            </#if>
            </div>
            <div class="row form-actions actions-bar">
                <div class="span13 offset3 ">
                    <button type="submit" class="button button-primary" id="save">保存</button>
                    <button type="reset" class="button">重置</button>
                </div>
            </div>
    </form>
</div>

<script type="text/javascript">
    var dialogregion = null;
    var choiceProductDialog = null;
    var selectProductIds = [];

    BUI.use('bui/overlay', function (Overlay) {
        choiceProductDialog = new Overlay.Dialog({
            title: '商品列表',
            width: 838,
            height: 460,
            loader: {
                url: '${ctx}/admin/sa/promotion/productDialog/list?productTypeCd=1',
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

    /**
     * 构建商品表格
     *
     */
    var Grid = BUI.Grid,
            Data = BUI.Data,
            Store = Data.Store;
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
    <#--编辑时不能删除商品-->
    <#if isNew>
        {
            title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
            return delStr;
        }
        }
    </#if>
    ];

    var productStore;
    var productGrid;
    function buildProductGrid() {
        productStore = new Store({
            url: '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad: false, //自动加载数据
            params: { //配置初始请求的参数
                sort: 'id desc',
                "in_id": selectProductIds.join(","),
            },
            pageSize: 5
        });

        productGrid = new Grid.Grid({
            render: '#productGrid',
            columns: productColumns,
            store: productStore,
            // 底部工具栏
            bbar: {
                // pagingBar:表明包含分页栏
                pagingBar: true
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
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + selectProductIds.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            selectProductIds = tempArray;

            reloadProductCondition();
        }, 'question');
    }

    /**
     * 初始化
     */

    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initProductCondition() {
        var isNew = $('input[name="promotionId"]').val();//如果promotionId有就是编辑操作

        if (!isNew) {
            buildProductGrid();
        } else {
        <#if productIds?? && productIds?has_content>
            <#assign ids = "'" +productIds+"'">
            var productIds = ${ids};
            selectProductIds = productIds.split(',');
        </#if>
            buildProductGrid();

            if (selectProductIds.length > 0) {
                productStore.load();
            }
        }
    }
    //添加新的商品时，去除重复商品
    function productChoiceEvent(selectedProduct) {

        var oldProductStr = "";
        oldProductStr = "," + selectProductIds.join(',') + ",";
        for (var i = 0; i < selectedProduct.length; i++) {
            var id = selectedProduct[i].productId;
            if (oldProductStr.indexOf("," + id + ",") < 0) {
                selectProductIds.push(id);
            }
        }

        reloadProductCondition();
    }
    //重新加载数据
    function reloadProductCondition() {
        if (!productStore) {
            buildProductGrid();
            if (selectProductIds.length > 0) {
                productStore.load();
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        } else {
            if (selectProductIds.length > 0) {
                var params = { //配置初始请求的参数
                    start: 0,
                    "in_id": selectProductIds.join(",")
                };
                productStore.load(params);
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        }
    }

    var productCategoryIds;
    <#--初始化商品树形结构-->
    function initProductCategory() {
        var isAPJ = '${isAllProductJoin}';
        if (isAPJ == '3') {
        <#if categoryIds??>
            productCategoryIds = '${categoryIds!}';
        </#if>
            loadProductCategoryHtml(productCategoryIds)
        }
    }

    <#--加载商品类别树形结构-->
    function loadProductCategoryHtml(productCategoryIds) {
        $.ajax({
            url: "${ctx}/admin/sa/promotionProductCategoryController/grid_json",
            data: {categoryIds: productCategoryIds},
            type: "get",
            dataType: 'html',
            success: function (data) {
                $("#categoryInfo").html(data);
            }
        });
    }

    //延时启用保存按钮
    function remainTime() {
        //打开提交按钮
        btn = document.getElementById('save');
        btn.disabled = false;
    }
    $(function () {
        $("#allUserLevel").on('change', function () {
            $("input[name='userLevel']").prop("checked", this.checked);
        });
        $("input[name='userLevel']").on('change', function () {
            var $subs = $("input[name='userLevel']");
            $("#allUserLevel").prop("checked", $subs.length == $subs.filter(":checked").length ? true : false);
        });
    <#if isAllUserLevel>
        $("#allUserLevel").trigger('change');
    </#if>

        //改变商品单选
        $("input[name='activityProducts']").on('change', function () {
            if ($(this).filter(':checked').attr('id') == 'conditionRule_ALL') {
                $('#productInfo').hide();
                $('#categoryInfo').hide();
            } else if ($(this).filter(':checked').attr('id') == 'conditionRule_product') {
                $('#productInfo').show();//显示商品列表
                $('#categoryInfo').hide();//隐藏商品类别树形结构
                $('#productGrid').empty();//清空商品列表数据
                selectProductIds = $('#productIds').val() == '' ? [] : $('#productIds').val().split(',');//把所选择的商品Id存放到对应的类型隐藏域中
                productColumn();
                buildProductGrid();//重新加载数据
                if (selectProductIds.length > 0) {
                    productStore.load();
                }
            } else if ($(this).filter(':checked').attr('id') == 'conditionRule_category') {
                $('#productInfo').hide();
                loadProductCategoryHtml(productCategoryIds);
                $('#categoryInfo').show();//显示商品类别树形结构
            }
        });

    <#--显示商品弹出框-->
        $("#choiceProductBtn").on('click', function () {
        <#--编辑时不能选择商品-->
        <#if promtoion??>
            return;
        </#if>
            choiceProductDialog.get('loader').load();
            choiceProductDialog.show();
        });

    <#if isAllProductJoin == 2>
        $('#productInfo').show();//显示商品列表
    <#elseif isAllProductJoin == 3>
        $('#categoryInfo').show();//显示商品类别列表
    </#if>

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                setTimeout("remainTime()", 1100);
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/productSales/list?type=${type!}";
                }
            }
        });

        //表单提交前的验证
        form.on('beforesubmit', function () {
            var goOn = true;
            var discountReg = new RegExp(/^([1-9])(\.\d*[1-9])?$/);
            var numReg = new RegExp(/^([1-9]\d{0,15}|0)(\.\d*[1-9])?$/);
            promotionTypeCd
            var promotionTypeCd = $("input[name='promotionTypeCd']").val();
            var conditionValue = $("input[name='conditionValue']").val().trim();
            btn = document.getElementById('save');
            btn.disabled = true;
            if (promotionTypeCd == ${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_DISCOUNT_TYPE.getType()}) {
                if (conditionValue == '') {
                    app.showError('折扣额不能为空!');
                    //数据返回,延迟打开提交按钮,避免重复显示提示信息！
                    setTimeout("remainTime()", 1100);
                    return false;
                }
                if (conditionValue.match(discountReg) == null) {
                    app.showError('请输入正确的折扣额,且折扣额为大于0小余10!');
                    setTimeout("remainTime()", 1100);
                    return false;
                }
            } else {
                if (conditionValue == '') {
                    app.showError('金额不能为空!');
                    setTimeout("remainTime()", 1100);
                    return false;
                }
                if (conditionValue.match(numReg) == null) {
                    app.showError('请输入正确的金额,且金额不能超过16位数!!');
                    setTimeout("remainTime()", 1100);
                    return false;
                }
            }

            if (!goOn) {
                return false;
            }

            var selectUserLevelCount = $("input[name='userLevel']").filter(":checked").length;
            if (selectUserLevelCount < 1) {
                app.showError('请选择会员级别!');
                setTimeout("remainTime()", 1100);
                return false;
            }

            var conditionRuleId = $($("input[name='activityProducts']").filter(":checked").get(0)).attr('id');
            if (conditionRuleId == 'conditionRule_category') {
                // 指定商品类别
                var selectCategorys = getCheckedCategoryIds();
                if (selectCategorys.length < 1) {
                    app.showError('请选择商品类别!');
                    setTimeout("remainTime()", 1100);
                    return false;
                }
                $('#categorys').val(selectCategorys.join(','));
            }

            if (conditionRuleId == 'conditionRule_product') {
                // 指定商品
                if (selectProductIds.length < 1) {
                    app.showError('请选择商品!');
                    setTimeout("remainTime()", 1100);
                    return false;
                }
                $('#selectProductIds').val(selectProductIds.join(','));
            }

            return true;
        })
        form.render();

        initProductCondition();
        initProductCategory();

        //重置按钮
        $('.actions-bar button[type="reset"]').click(function () {
            //如果是编辑操作,只重置启用状态
        <#if couponDTO??>
            $('.controls input[name="statusCd"][value="${(couponDTO.statusCd)!default(1)}"]').attr("checked", true);
            return;
        </#if>
            $('.controls input[name="statusCd"][value="1"]').attr("checked", true);
            $('.controls input[name="promotionTypeCd"][value="54"]').attr("checked", true);
        });

        function productColumn() {
            productColumns = [
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
            <#--编辑时不能删除商品-->
            <#if isNew>
                {
                    title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
                    var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
                    return delStr;
                }
                }
            </#if>
            ];
        }
    });

</script>
</body>
</html>