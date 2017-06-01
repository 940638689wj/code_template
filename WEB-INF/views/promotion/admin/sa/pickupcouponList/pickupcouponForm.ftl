<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
</head>
<script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>

<body>
<div class="container">

    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/pickupcouponList?statusCd=${statusCd!1}">提货券列表</a><span
                class="divider">&gt;&gt;</span></li>
        <li class="active"><#if pickupcouponListDTO?has_content>编辑<#else>添加</#if>提货券</li>
    </ul>

    <form id="J_Form" class="form-horizontal">
        <div id="edit-div" class="form-content">
            <input type="hidden" name="pickupCouponId" id="pickupCouponId"
                   value="${(pickupcouponListDTO.pickupCouponId)!}"/>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input value="${(pickupcouponListDTO.pickupCouponName)!}" name="pickupCouponName"
                               id="pickupCouponName"
                               data-rules="{required:true,maxlength:30}" class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">描述：</label>
                    <div class="controls">
                        <textarea name="pickupCouponDesc" id="pickupCouponDesc" data-rules="{maxlength:255}"
                                  class="input-normal control-row1">${(pickupcouponListDTO.pickupCouponDesc)!}</textarea>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>金额：</label>
                    <div class="controls">
                        <input value="${(pickupcouponListDTO.pickupAmt)!}" name="pickupAmt" id="pickupAmt"
                               <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>readonly="true"</#if>
                               data-rules="{required:true,number:true,min:0}" class="input-normal control-text"/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>生成数量：</label>
                    <div class="controls">
                        <input value="${(pickupcouponListDTO.pickupCnt)!}" name="pickupCnt" id="pickupCnt"
                               <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>readonly="true"</#if>
                               data-rules="{required:true,regexp: /^\+?[1-9]\d*$/}"
                               data-messages="{regexp:'请输入大于0的整数！'}"
                               class="input-normal control-text"/>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label">提货门店：</label>
                <div class="controls">
                <#list storeList as store>
                    <label class="radio" for="">
                        <input type="radio" name="pickupStoreId" value="${(store.storeId)!}"
                               <#if pickupcouponListDTO?has_content && pickupcouponListDTO.pickupStoreId == store.storeId>checked="checked"</#if>
                        <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if>/>
                    ${(store.storeName)!}
                    </label>&nbsp;&nbsp;&nbsp;
                </#list>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>卡号段：</label>
                    <div class="controls">
                        <input value="${(pickupcouponListDTO.cardPrefix)!}" name="cardPrefix" id="cardPrefix"
                               <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>readonly="true"</#if>
                               data-rules="{required:true,regexp: /^\+?[0-9]\d{2}$/}"
                               data-messages="{regexp:'请输入3位数字！'}" class="input-normal control-text"/>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>有效使用日期：</label>
                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                	<#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>
                		<input disabled name="allowUseStart" id="allowUseStart" data-tip="{text : '起始日期'}" value="${(pickupcouponListDTO.allowUseStartTime)!?date}"
                		data-messages="{required:'起始日期不能为空'}" class="input-small calendar" type="text"/>
                		<input disabled name="allowUseEnd" id="allowUseEnd" data-tip="{text : '结束日期'}" data-rules="{required:true}"
                           value="${(pickupcouponListDTO.allowUseEndTime)!?date}"
                           data-messages="{required:'结束日期不能为空'}" class="input-small calendar" type="text"/>
                	<#else>
                		<input name="allowUseStart" id="allowUseStart" data-tip="{text : '起始日期'}"
                           <#if pickupcouponListDTO?has_content>value="${(pickupcouponListDTO.allowUseStartTime)!?date}"</#if>
                           data-messages="{required:'起始日期不能为空'}" class="input-small calendar" type="text"/>
                    <label>&nbsp;至&nbsp;</label>
                    <input name="allowUseEnd" id="allowUseEnd" data-tip="{text : '结束日期'}" data-rules="{required:true}"
                           <#if pickupcouponListDTO?has_content>value="${(pickupcouponListDTO.allowUseEndTime)!?date}"</#if>
                           data-messages="{required:'结束日期不能为空'}" class="input-small calendar" type="text"/>
                	</#if>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1"
                                   <#if pickupcouponListDTO?has_content && pickupcouponListDTO.statusCd == 1 >checked="checked" </#if>/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0"
                                   <#if !pickupcouponListDTO?has_content ||
                                   (pickupcouponListDTO?has_content && pickupcouponListDTO.statusCd == 0) >checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="well control-group">
                <div class="row" id="packageInfo">
                    <ul class="toolbar">
                        <li>
                            <button onclick="addPackage()" type="button" class="button button-info"
                                    <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if> >
                                <i class="icon icon-white icon-envelope"></i> 新增套餐礼包
                            </button>
                        </li>
                    </ul>

                    <div class="pickupPackage">
                        <hr/>
                        <div class="row">
                            <h3 style="float: left;" class="pickupPackageTitle">套餐礼包1&nbsp;&nbsp;&nbsp;&nbsp;</h3>
                            <div style="float: right;">
                                <button type="button" class="button button-primary showHidePackage">收起</button>
                                <button type="button" class="button delPackage"
                                    <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if>
                                        style="display: none;">删除</button>
                            </div>
                        </div>
                        <hr/>
                        <div class="packageContent">
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>套餐礼包名称：</label>
                                    <div class="controls">
                                        <input value="" name="packageName" class="input-normal <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>readonly="true"</#if> control-text"/>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>套餐礼包图片：</label>
                                    <div class="controls control-row-auto" style="margin-bottom: 20px;">
                                        <div class="cover-area">
                                            <div class="file-btn">
                                                <button class="button button-primary" <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if> >上传</button>
                                                <input id="file_packagePic1" class="inp-file"
                                                       <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if>
                                                       name="file" type="file"/>
                                            </div>
                                            <button class="button delPackagePic" type="button" <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if> >删除
                                            </button>
                                        <#--<p class="upload-tip">图片建议尺寸：600像素 * 370像素</p>-->

                                            <div id="imgshow_packagePic1" class="mt5 imgshow_packagePic"
                                                 <#if !(packagePic1?has_content)>style="display:none;"</#if>>
                                                <input type="hidden" id="packagePic1Url" name="packagePicUrl"
                                                       value="<#if packagePic1?has_content>${packagePic1}</#if>"
                                                       class="input-normal control-text">
                                                <img id="packagePic1" class="pull-left packagePic" width="100px"
                                                     height="100px"
                                                     src="<#if packagePic1?has_content>${packagePic1}</#if>">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label">套餐礼包描述：</label>
                                    <div class="controls control-row-auto packageDesc">
                                        <script type="text/plain" id="packageDesc1" <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>readonly="true"</#if>
                                                name="packageDesc">${(pickupcouponListDTO.packageDesc)!}</script>
                                    </div>
                                </div>
                            </div>

                            <div class="well control-group productChoiceList">
                                <input type="hidden" name="productIds" value="">
                                <div class="row">
                                    <ul class="toolbar">
                                        <li>
                                            <button id="choiceProductBtn1" type="button"
                                                    class="button button-info choiceProductBtn"
                                                    onclick="showProductDialog(this)"
                                                    <#if promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1>disabled="ture"</#if>
                                                    <#if pickupcouponListDTO?? && pickupcouponListDTO.auditStatusCd?? && pickupcouponListDTO.auditStatusCd==1>disabled="true"</#if>>
                                                <i class="icon icon-white icon-envelope"></i> 选择商品
                                            </button>
                                        </li>
                                    </ul>
                                    <hr/>
                                    <div class="search-grid-container">
                                        <div id="productGrid1" class="productGrid"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <br/>
                    </div>

                </div>
            </div>

            <div class="actions-bar">
                <button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            </div>

        </div>
    </form>
</div>

<#include "${ctx}/includes/sa/uploadImage.ftl"/>
<script>
    var selectProductIds = [];
    function showProductDialog(obj) {
        var choiceProductDialog = new BUI.Overlay.Dialog({
            title: '商品列表',
            width: 1000,
            height: 460,
            closeAction: 'destroy',
            loader: {
                url: '${ctx}/admin/sa/promotion/productDialog/productList?showSku=1',
                autoLoad: false, //不自动加载
                lazyLoad: false //不延迟加载
            },
            buttons: [{
                text: '选 择',
                elCls: 'button button-primary',
                handler: function () {
                    var ownProductIds = $(obj).parents(".productChoiceList").find("input[name=productIds]");
                    if (ownProductIds.val()) {
                        selectProductIds = ownProductIds.val().split(",");
                    } else {
                        selectProductIds = [];
                    }
                    productChoiceEvent(getSelectedRecords());
                    if (selectProductIds.length != 0) {
                        ownProductIds.val(selectProductIds.join(","));
                    }
                    var idStr = $(obj).attr("id");
                    $("#productGrid" + idStr.charAt(idStr.length - 1)).html($("#productGrid1").find(".bui-grid:last"));
                    this.close();
                }
            }],
            mask: true
        });
        choiceProductDialog.get('loader').load();
        choiceProductDialog.show();

        //构建商品表格
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
            {title: '品牌名称', dataIndex: 'brandName', width: 120},
            {title: '类别名称', dataIndex: 'categoryName', width: 120},
            {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
            {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
            {title: '商品库存', dataIndex: 'realStock', width: 120},
            {title: '更新时间', dataIndex: 'lastUpdateTime', width: 180, renderer: BUI.Grid.Format.datetimeRenderer},
            {
                title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
                return '<span class="grid-command btn-del" onclick="delPro(' + obj.productId + ',this)">删除</span>';
            }
            }
        ];

        var productStore;
        var productGrid;

        function buildProductGrid() {
            productStore = new Store({
                url: '${ctx}/admin/sa/promotion/productDialog/grid_json',
                autoLoad: false, //自动加载数据
                params: { //配置初始请求的参数
                    sort: 'id desc',
                    "in_id": selectProductIds.join(",")
                },
                pageSize: 5
            });
            productGrid = new Grid.Grid({
                render: '#productGrid1',
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

        //判断是否是添加操作还是编辑操作，在进行数据初始化
        function initProductCondition() {
            var isNew = $('#promotionId').val();//如果promotionId有就是编辑操作

            if (!isNew) {
                buildProductGrid();
            } else {
                //将选择商品置灰
                //$("#choiceProductBtn").addClass('disabled');
            <#if productIds?? && productIds?has_content>
                <#assign pids = "'" +productIds+"'">
                var productIds = ${pids};
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
    }
	
	
		//延迟使用保存按钮
		function remainTime(){
		//打开提交按钮
		btn=document.getElementById('save');
		btn.disabled=false;
	}

    var count = 2;//套餐礼包编号
    var msg_editor = [];//富文本框
    var titleNum = 2; //套餐标题编号

    $(function () {
        <#if !(pickupcouponListDTO?has_content)>
            $("input[name=pickupStoreId]:first").attr("checked", true);
        </#if>

    <#--富文本编辑器初始化-->
        msg_editor.push( new UE.ui.Editor({initialFrameWidth: 1000, initialFrameHeight: 200}));
        msg_editor[0].render("packageDesc1");
        uploadAndDel($('.pickupPackage:first'), 'packagePic1');
        showHidePackage($('.pickupPackage:first'));

        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
            }
        }).render();

	
		
        //提交表单，未使用bui提交
        form.on('beforesubmit', function () {
        	btn=document.getElementById('save');
			btn.disabled=true;
        	
            //表单验证packageDesc
            var today = new Date();
            today.setDate(today.getDate() - 1);
            var allowUseStart = Date.parse(($("#allowUseStart").val() + "").replace(new RegExp("\\-", "gi"), "/"));
            if (allowUseStart < today) {
                app.showError('有效使用日期不得小于当天！');
                setTimeout("remainTime()",1100);
                return false;
            }

            //构造参数
            var param = {};
            //id存在为修改，不存在为添加
            if ($("#pickupCouponId").val()) {
                param.pickupCouponId = $("#pickupCouponId").val();
            }
            param.pickupCouponName = $('#pickupCouponName').val();
            param.pickupCouponDesc = $('#pickupCouponDesc').val();
            param.pickupAmt = $('#pickupAmt').val();
            param.pickupCnt = $('#pickupCnt').val();
            param.pickupStoreId = $('input[name="pickupStoreId"]:checked').val();
            param.cardPrefix = $('#cardPrefix').val();
            param.allowUseStart = $('#allowUseStart').val();
            param.allowUseEnd = $('#allowUseEnd').val();
            param.cardPrefix = $('#cardPrefix').val();
            param.statusCd = $('input[name="statusCd"]:checked').val();
            param.cardPrefix = $('#cardPrefix').val();
            param.cardPrefix = $('#cardPrefix').val();

            //构造礼包参数
            var pickupcouponPackageList = [];
            var pickupPackageFlag = true;
            $('.pickupPackage').each(function () {
                var idStr = $(this).find('.packagePic').attr('id');
                var pickupPackageCount = idStr.charAt(idStr.length - 1);

                var pickupPackage = {};
                var packageName = $(this).find('input[name="packageName"]').val();
                if (!packageName) {
                    app.showError('套餐' + pickupPackageCount + ' 名称不能为空');
                    setTimeout("remainTime()",1100);
                    pickupPackageFlag = false;
                    return false;
                }
                pickupPackage.packageName = packageName;
                var packagePicUrl = $(this).find('input[name="packagePicUrl"]').val();
                if (!packagePicUrl) {
                    app.showError('套餐' + pickupPackageCount + ' 图片不能为空');
                    setTimeout("remainTime()",1100);
                    pickupPackageFlag = false;
                    return false;
                }
                pickupPackage.packagePicUrl = packagePicUrl;
                pickupPackage.packageDesc = msg_editor[pickupPackageCount - 1].getContent();
                var productIds = $(this).find('input[name="productIds"]').val().split(',');
                if (productIds.length == 0 || productIds[0] == '') {
                    app.showError('套餐' + pickupPackageCount + ' 商品不能为空');
                    setTimeout("remainTime()",1100);
                    pickupPackageFlag = false;
                    return false;
                }
                var pickupPackageProductXrefList = [];
                for (var i =0;i< productIds.length;i++) {
                    pickupPackageProductXrefList.push({productId: productIds[i]});
                }
                pickupPackage.pickupPackageProductXrefList = pickupPackageProductXrefList;
                pickupcouponPackageList.push(pickupPackage);
//                pickupPackageCount++;
            });
            if (!pickupPackageFlag) {
                return false;
            }
            param.pickupcouponPackageList = pickupcouponPackageList;

            //提交表单
            $.ajax({
                type: "POST",
                url: "${ctx}/admin/sa/pickupcouponList/save",
                data: JSON.stringify(param),//将对象序列化成JSON字符串
                dataType: "json",
                contentType: 'application/json;charset=utf-8', //设置请求头信息
                success: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        if ($("#pickupCouponId").val()) {
                            app.showSuccess("修改成功");
                        } else {
                            app.showSuccess("新建成功");
                        }
                        window.location.href = '${ctx}/admin/sa/pickupcouponList?statusCd=1';
                    }
                }
            });
            return false;
        });

        //编辑时回显礼
    <#if pickupcouponListDTO?has_content>
        <#list pickupcouponListDTO.pickupcouponPackageList as pickupcouponPackage>
            <#if pickupcouponPackage_index != 0>
                addPackage();
            </#if>
            $("input[name=packageName]:last").val("${(pickupcouponPackage.packageName)!}");
            $("input[name=packagePicUrl]:last").val("${(pickupcouponPackage.packagePicUrl)!}");
            $(".packagePic:last").attr("src", "${(pickupcouponPackage.packagePicUrl)!}");
            $(".imgshow_packagePic:last").show();
            setTimeout('msg_editor[${pickupcouponPackage_index}].setContent("${(pickupcouponPackage.packageDesc)!}");', 1000);
            selectProductIds = [];
            <#list pickupcouponPackage.pickupPackageProductXrefList as pickupPackageProductXref>
                selectProductIds.push(${(pickupPackageProductXref.productId)!});
            </#list>
            $("input[name=productIds]:last").val(selectProductIds.join());
        </#list>
    </#if>

        //编辑回显商品
        $(".choiceProductBtn").each(function () {
            $(this).click();
            $(".bui-dialog").hide();
            setTimeout('$(".bui-dialog .bui-stdmod-footer button").click();', 1000);
        });

    });

    function addPackage() {
        //拷贝第一个礼包
        var newPackage = $(".pickupPackage:first").clone();
        newPackage.find('.delPackage').show();
        //清空拷贝的数据
        newPackage.find('input[name="packageName"]').val('');
        newPackage.find('input[name="packagePic1Url"]').val('');
        newPackage.find('.mt5').hide();
        newPackage.find('.packagePic').attr('src', '');
        //删除按钮
        newPackage.find('.delPackage').click(function () {
            newPackage.remove();
            var allPackAge = $(".pickupPackage");
            if(allPackAge.length>0){
            	for(var i=1; i<=allPackAge.length;i++){
            		$(allPackAge[i-1]).find('.pickupPackageTitle').html('套餐礼包' + i);
            	}
            	titleNum--;
            }
        });
        //若第一个礼包为收起状态，将新增的展开
        if (newPackage.find('.showHidePackage').html() == '展开') {
            newPackage.find('.showHidePackage').html('收起');
            newPackage.find('.packageContent').show();
        }
        //生成套餐礼包编号
        newPackage.find('.pickupPackageTitle').html('套餐礼包' + titleNum);
        //修改所有id
        var id = 'packagePic' + count;
        newPackage.find('input[name="productIds"]').val('');
        newPackage.find('input[name="file"]').attr('id', 'file_packagePic' + count);
        newPackage.find('.mt5').attr('id', 'imgshow_packagePic' + count);
        newPackage.find('input[name="packagePicUrl"]').attr('id', 'packagePic' + count + 'Url');
        newPackage.find('.packagePic').attr('id', 'packagePic' + count);
        newPackage.find('input[name="packageDesc"]').attr('id', 'packageDesc' + count);
        newPackage.find('.choiceProductBtn').attr('id', 'choiceProductBtn' + count);
        newPackage.find('.productGrid').attr('id', 'productGrid' + count);
        newPackage.find('.productGrid').empty();
        //重新初始化富文本
    <#--var str = '';-->
        newPackage.find('.packageDesc').html('<script type="text/plain" id="packageDesc' + count + '" name="packageDesc"><\/script>');
        //挂载标签
        $("#packageInfo").append(newPackage);

        msg_editor.push(new UE.ui.Editor({initialFrameWidth: 1000, initialFrameHeight: 200}));
        msg_editor[count - 1].render("packageDesc" + count);
        //绑定按钮事件
        uploadAndDel(newPackage, id);
        showHidePackage(newPackage);
        count++;
        titleNum++;
    }

    function uploadAndDel(obj, id) {
        obj.find('input[name="file"]').change(function () {
            assetChange($(this).val(), id);
        });
        obj.find('.delPackagePic').click(function () {
            delItem(id);
        });
    }

    function showHidePackage(obj) {
        //礼包的收起和展开
        obj.find(".showHidePackage:last").click(function () {
            var pageContent = $(this).parents('.pickupPackage').find('.packageContent');
            if ($(this).html() == '收起') {
                $(this).html('展开');
                pageContent.hide(300);
            } else if ($(this).html() == '展开') {
                $(this).html('收起');
                pageContent.show(300);
            }
        });
    }

    // 删除商品
    function delPro(productId, obj) {
        BUI.Message.Confirm("删除商品？", function () {
            var par = $(obj).parents(".productChoiceList");
            var ownProductIds = par.find("input[name=productIds]");
            selectProductIds = ownProductIds.val().split(",");
            for (var i = 0; i < selectProductIds.length; i++) {
                if (selectProductIds[i] == productId) {
                    selectProductIds.splice(i, 1);
                    break;
                }
            }
            ownProductIds.val(selectProductIds.join(","));
            reloadProductCondition();
            var idStr = par.find(".choiceProductBtn").attr("id");
            $("#productGrid" + idStr.charAt(idStr.length - 1)).html($("#productGrid1").find(".bui-grid:last"));
        });


        //构建商品表格
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
            {title: '品牌名称', dataIndex: 'brandName', width: 120},
            {title: '类别名称', dataIndex: 'categoryName', width: 120},
            {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
            {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
            {title: '商品库存', dataIndex: 'defaultPrice', width: 120},
            {title: '更新时间', dataIndex: 'lastUpdateTime', width: 180, renderer: BUI.Grid.Format.datetimeRenderer},
            {
                title: '操作', dataIndex: '', width: 120, renderer: function (value, obj) {
                return '<span class="grid-command btn-del" onclick="delPro(' + obj.productId + ',this)">删除</span>';
            }
            }
        ];

        var productStore;
        var productGrid;

        function buildProductGrid() {
            productStore = new Store({
                url: '${ctx}/admin/sa/promotion/productDialog/grid_json',
                autoLoad: false, //自动加载数据
                params: { //配置初始请求的参数
                    sort: 'id desc',
                    "in_id": selectProductIds.join(",")
                },
                pageSize: 5
            });
            productGrid = new Grid.Grid({
                render: '#productGrid1',
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

    }

</script>
</body>
</html>