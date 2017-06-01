<#assign ctx = request.contextPath>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<#assign productControlTab = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_TAB_TYPE.type>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        function assetChange(fileName, targetFileId){
            if(fileName == null || fileName.trim().length <= 0){
                BUI.Message.Alert("请选择文件!");
                return false;
            }

            var suffixIndex = fileName.lastIndexOf('.');
            if(suffixIndex <= 0){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            var suffix = fileName.substr(suffixIndex + 1);

            if(suffix.trim().length <= 0 ||
                    ("jpg" != suffix.trim().toLowerCase() && "png" != suffix.trim().toLowerCase())){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            $.ajaxFileUpload({
                url:'${ctx}/common/staticAsset/upload/decorateControl',
                secureuri: false,
                fileElementId: targetFileId,
                dataType: "json",
                method : 'post',
                success: function (data, statusCd) {
                    loadImage(data.assetUrl, targetFileId);
                },
                error: function (data, statusCd, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(assertUrl,targetFileId) {
            var targetFileDom = $("#"+ targetFileId);
            var targetFileType = $(targetFileDom).attr("data-file-type");
            var width = $(targetFileDom).parents(".tabContent").find(("." + targetFileType)).width();
            var imageDom = "<img style='width: "+width+"' src='"+assertUrl+"' alt=''/>";
            $(targetFileDom).parents(".tabContent").find(("." + targetFileType)).html(imageDom);
        }
    </script>
</head>
<body>
<form class="form-horizontal" id="controlContainerForm" method="POST" action="edit">
    <input type="hidden" name="id" value="${(control.id)!}"/>
    <input type="hidden" name="type" value="${type?default(productControlType)}">
    <input type="hidden" name="showType" value="${(showType)?default(productControlTab)}">
    <input type="hidden" name="productIds" value="">
    <div class="control-group">
        <label class="control-label"><s>*</s>控件标题：</label>
        <div class="controls"><input class="control-text input-large" type="text" value="${(control.name)!?html}" name="name" data-rules="{required:true}"/></div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>是否显示标题：</label>
    <#assign nameStatus = "1">
    <#if (control.showName)??>
        <#assign nameStatus = (control.showName)?string("1","0")>
    </#if>
        <div class="controls">
            <label class="radio" for="showNameRadio"><input  <#if nameStatus == "1">checked="checked"</#if> id="showNameRadio" type="radio" value="1" name="showName">显示</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="hideNameRadio"><input  <#if nameStatus == "0">checked="checked"</#if> id="hideNameRadio" type="radio" value="0" name="showName">隐藏</label>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>控件排序：</label>
        <div class="controls">
            <input value="${(control.sort)?default('0')}" name="sort" data-rules="{required:true,min:0,number:true}" class="input-normal control-text">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>是否启用：</label>
        <#assign status = (control.statusCd)?default(1)>
        <input type="hidden" name="statusCd" value="${(control.statusCd)!?default(1)}">
        <div class="controls" name="statusCd">
            <label class="radio" for="usedRadio"><input <#if status == 1>checked="checked"</#if> id="usedRadio" type="radio" value="1">启用</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="disabledRadio"><input <#if status == 0>checked="checked"</#if> id="disabledRadio" type="radio" value="0">禁用</label>
        </div>
    </div>
    <hr/>
    <div id="addTabControlRow" class="row" style="padding-left: 10px;">
        <div class="control-group">
            <label class="control-label"><button id="addTabControlBtn" type="button" class="button">新增页签</button></label>
        </div>
    </div>
    <div class="row" id="tabControlContainerModel" style="display: none;padding-bottom: 10px;padding-top:10px;padding-left:30px;">
        <input type="hidden" data-param-name="tabId" value="">
        <input type="hidden" data-param-name="productIds" value="">
        <div class="panel panel-small" name="tabContainer" style="width: auto;">
            <div class="panel-header" style="background-color: #f4f4ef;padding-left: 10px;">
                <h3 style="margin-bottom: auto;font-weight:bold;height: 25px;font-size:15px;padding-top:5px;">
                    <span name="tabNameHeader" style="padding-left: 10px;">名称</span>
                    <span class="pull-right">
                        <button type="button" class="button button-small" onclick="javascript:togglePanelBody(this);"><i name="expandOrMinBtn" class="icon-minus"></i><span name="expandOrMin">收起</span></button>
                        <button type="button" class="button button-small" name="deletePackageBtn" onclick="javascript:deleteTab(this);"><i class="icon-remove"></i>删除</button>
                    </span>
                </h3>
            </div>
            <div class="panel-body" style="padding-top:15px;padding-left:35px;">
                <div class="control-group">
                    <div class="control-label control-label-auto">
                        <input type="text" data-param-name="seq" style="width: 105px;" class="control-text input-small" placeholder="排序值"/>
                    </div>
                    <div class="controls">
                        <input type="text" data-param-name="name" class="control-text input-large" placeholder="名称" onchange="javascript:changeTabName(this);"/>
                        <input type="text" data-param-name="link" class="control-text input-large" placeholder="链接" style="margin-left: 6px;"/>
                    </div>
                </div>
                <div class="control-group">
                    <div class="control-label control-label-auto">
                        <div class="file-btn">
                            <input type="hidden" data-param-name="mainImg.picUrl" value="">
                            <button style="width: 120px;" class="button">上传大图</button>
                            <input type="file" class="inp-file" name="file" data-file-type="mainImg"/>
                        </div>
                    </div>
                    <div class="controls control-row1">
                        <input type="text" data-param-name="mainImg.linkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                    </div>
                    <div class="bui-clear"></div>
                    <p class="auxiliary-text">建议图片大小：400*330 像素</p>
                    <div class="zx-banner mainImg" style="width: 400px;margin-top: 10px;">
                        <b style="line-height: 100px;">图片预览</b>
                    </div>
                </div>
                <div class="control-group">
                    <div class="control-label control-label-auto">
                        <div class="file-btn">
                            <input type="hidden" data-param-name="leftBottomImg.picUrl" value="">
                            <button style="width: 120px;" class="button">上传左下小图</button>
                            <input type="file" class="inp-file" name="file" data-file-type="leftBottomImg"/>
                        </div>
                    </div>
                    <div class="controls control-row1">
                        <input type="text" data-param-name="leftBottomImg.linkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                    </div>
                    <div class="bui-clear"></div>
                    <p class="auxiliary-text">建议图片大小：200*240 像素</p>
                    <div class="zx-banner leftBottomImg" style="width: 200px;margin-top: 10px;">
                        <b style="line-height: 100px;">图片预览</b>
                    </div>
                </div>
                <div class="control-group">
                    <div class="control-label control-label-auto">
                        <div class="file-btn">
                            <input type="hidden" data-param-name="rightBottomImg.picUrl" value="">
                            <button style="width: 120px;" class="button">上传右下小图</button>
                            <input type="file" class="inp-file" name="file" data-file-type="rightBottomImg"/>
                        </div>
                    </div>
                    <div class="controls control-row1">
                        <input type="text" data-param-name="rightBottomImg.linkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                    </div>
                    <div class="bui-clear"></div>
                    <p class="auxiliary-text">建议图片大小：200*240 像素</p>
                    <div class="zx-banner rightBottomImg" style="width: 200px;margin-top: 10px;">
                        <b style="line-height: 100px;">图片预览</b>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label"></label>
                    <div class="controls control-row-auto" style="height: 15px;">
                        <button type="button" class="button" onclick="javascript:choiceProduct(this);">选择商品</button>
                    </div>
                </div>
                <hr/>
                <div id="productGrid" style="padding-bottom: 10px;"></div>
            </div>
        </div>
    </div>
    <div class="actions-bar" style="padding-left: 45px;">
        <div class="form-action">
            <button class="button button-large button-primary">保存</button>
        </div>
    </div>
</form>
<script type="text/javascript">

    var TabGridPrefix = "tabGrid_";
    var allTabGrid = {};
    var allTabProductId = {};

    function choiceProduct(obj){
        var _self = obj;
        var tabId = $(_self).parents("div[name='tabContainer']").parent().find("input[data-param-name='tabId']").val();
        var Overlay = BUI.Overlay;
        var dialog = new Overlay.Dialog({
            title:'产品列表',
            width: 850,
            height: 460,
            closeAction: 'destroy',
            loader : {
                url : '${ctx}/admin/sa/promotion/productDialog/list',
                autoLoad : false, //不自动加载
                lazyLoad : false //不延迟加载
            },
            buttons:[{
                text:'选 择',
                elCls : 'button button-primary',
                handler : function(){
                    var selectedProducts = getSelectedRecords();
                    this.close();
                    productChoiceEvent(tabId, selectedProducts);
                }
            }],
            mask:true
        });

        dialog.get('loader').load();
        dialog.show();
    }

    function initAddTabEvent(){
        $("#addTabControlBtn").on('click',function(){
            addOneTabInfo();
        });
    }

    $(function(){

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#controlContainerForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("控件保存成功!");
                    var controlId = data['data']["id"];
                    var controlName = data['data']["name"];
                    var controlType = data['data']["type"];
                    var controlShowType = data['data']['showType'];
                    <#if isNew?? && isNew>
                        window.parent.parent.fillControlContent(controlId, controlName, controlType, controlShowType);
                        window.parent.location.href = window.parent.parent.toChildIFrameRefresh();
                    <#else>
                        window.parent.fillControlContent(controlId, controlName, controlType, controlShowType);
                        window.location.reload();
                    </#if>
                }
            }
        });
        form.on('beforesubmit', function(){
            return collectData(); //收集数据，以JSON字符串的形式传输
        });
        form.render();

        initAddTabEvent();
        initTabData();
    });

    function collectData(){
        var selectStatus = $("div[name='statusCd']").find("input[type='radio']:checked");
        if(!selectStatus || !selectStatus.length){
            BUI.Message.Alert("请选择控件状态!");
            return false;
        }
        $("input[name='statusCd']").val(selectStatus.val());

        var tabContentObjs = $(".tabContent");
        var tabContentCount = tabContentObjs.length;
        for(var i = 0; i < tabContentCount; i++){
            var mainImg = $(tabContentObjs[i]).find(".mainImg").find("img").attr("src");
            $(tabContentObjs[i]).find("input[data-param-name='mainImg.picUrl']").val(mainImg);
            var leftBottomImg = $(tabContentObjs[i]).find(".leftBottomImg").find("img").attr("src");
            $(tabContentObjs[i]).find("input[data-param-name='leftBottomImg.picUrl']").val(leftBottomImg);
            var rightBottomImg = $(tabContentObjs[i]).find(".rightBottomImg").find("img").attr("src");
            $(tabContentObjs[i]).find("input[data-param-name='rightBottomImg.picUrl']").val(rightBottomImg);
            var tabId = $(tabContentObjs[i]).find("input[data-param-name='tabId']").val();
            if(tabId){
                var productIds = getTabProductId(tabId);
                $(tabContentObjs[i]).find("input[data-param-name='productIds']").val(productIds);
                $(tabContentObjs[i]).find("input[data-param-name]").each(function(){
                    var paramAttr = $(this).attr("data-param-name");
                    var paramName = ("tabs[" + i + "]." + paramAttr);
                    $(this).attr("name", paramName);
                });
            }
        }
        return true;
    }

    function initTabData(){
        <#if type = productControlType && (controlDTO.tabs)?has_content>
            <#list controlDTO.tabs as tab>
                var tabContainer = addOneTabInfo();
                togglePanelBody(tabContainer.find(".panel-header").find("button[type='button']:first"));
                tabContainer.find("input[data-param-name='seq']").val('${(tab.seq)!}');
                tabContainer.find("input[data-param-name='name']").val('${(tab.name)!?html}');
                tabContainer.find("input[data-param-name='link']").val('${(tab.link)!}');
                changeTabName(tabContainer.find("input[data-param-name='name']"));
                tabContainer.find("input[data-param-name='mainImg.linkUrl']").val('${(tab.mainImg.linkUrl)!}');
                tabContainer.find("input[data-param-name='leftBottomImg.linkUrl']").val('${(tab.leftBottomImg.linkUrl)!}');
                tabContainer.find("input[data-param-name='rightBottomImg.linkUrl']").val('${(tab.rightBottomImg.linkUrl)!}');
                loadImage("${(tab.mainImg.picUrl)!}", tabContainer.find("input[data-file-type='mainImg']").attr("id"));
                loadImage("${(tab.leftBottomImg.picUrl)!}", tabContainer.find("input[data-file-type='leftBottomImg']").attr("id"));
                loadImage("${(tab.rightBottomImg.picUrl)!}", tabContainer.find("input[data-file-type='rightBottomImg']").attr("id"));
                var tabId = tabContainer.find("input[data-param-name='tabId']").val();
                <#if (tab.productIds)?has_content>
                    <#list (tab.productIds)?split(",") as productId>
                        var tabProductIds = getTabProductId(tabId);
                        var oldProductStr = "";
                        oldProductStr = "," + tabProductIds.join(',') + ",";
                        if(oldProductStr.indexOf(",${productId},") < 0){
                            tabProductIds.push('${productId}');
                        }
                        allTabProductId[(TabGridPrefix + tabId)] = tabProductIds;
                    </#list>
                </#if>
                reloadProductCondition(tabId);
            </#list>
        </#if>
    }

    function reloadProductCondition(tabId){
        var tabProductGrid = getTabGrid(tabId);
        var tabProductIds = getTabProductId(tabId);
        if(tabProductGrid){
            var tabProductStore = tabProductGrid.get("store");
            if(tabProductStore && tabProductIds.length > 0){
                var params = { //配置初始请求的参数
                    start : 0,
                    "in_id" : tabProductIds.join(",")
                };
                tabProductStore.load(params);
            }
        }
    }

    var Grid = BUI.Grid,
            Data = BUI.Data,
            Store = Data.Store;

    function togglePanelBody(obj){
        var _self = obj;
        var panelBody = $(_self).parents("div[name='tabContainer']").children(".panel-body");
        panelBody.toggle();
        if(panelBody.is(":visible") == false){
            $(_self).find("i[name='expandOrMinBtn']").removeClass("icon-minus");
            $(_self).find("i[name='expandOrMinBtn']").addClass("icon-plus");
            $(_self).find("span[name='expandOrMin']").text("展开");
        } else {
            $(_self).find("i[name='expandOrMinBtn']").removeClass("icon-plus");
            $(_self).find("i[name='expandOrMinBtn']").addClass("icon-minus");
            $(_self).find("span[name='expandOrMin']").text("收起");
        };
        return false;
    }

    function deleteTab(obj){
        var _self = obj;
        var container = $(_self).parents("div[name='tabContainer']").parent();
        var tabId = container.find("input[data-param-name='tabId']").val();
        var key = TabGridPrefix + tabId;
        if(allTabProductId[key] != null){
            delete allTabProductId[key];
        }
        if(allTabGrid[key] != null){
            delete allTabGrid[key];
        }
        container.remove();
    }

    function changeTabName(obj){
        var _self = obj;
        var container = $(_self).parents("div[name='tabContainer']").parent();

        var newTabName = $(_self).val();
        newTabName = newTabName ? newTabName.replace(/(^\s*)|(\s*$)/g, "") : "";
        if(newTabName == ""){
            newTabName = "名称";
        }

        var tabNameHeaderContainer = container.find("span[name='tabNameHeader']");
        if(tabNameHeaderContainer){
            tabNameHeaderContainer.text(newTabName);
        }
    }

    function addOneTabInfo() {
        var newTabContainer = $("#tabControlContainerModel").clone();
        newTabContainer.addClass("tabContent");
        newTabContainer.insertAfter($("#addTabControlRow"));

        var tabId = generateTabId();
        newTabContainer.attr("id", ("tabControlContainer_" + tabId));
        newTabContainer.find("input[data-param-name='tabId']").val(tabId);
        newTabContainer.find("#productGrid").attr("id", "productGrid_" + tabId);

        newTabContainer.find("input[name='file']").each(function(){
            var fileType = $(this).attr("data-file-type");
            $(this).attr("id", (fileType + "_" + tabId));
        });

        newTabContainer.find("input[name='file']").live('change', function(){
            assetChange($(this).val(), $(this).attr("id"));
        });
        newTabContainer.show();

        buildProductGrid(tabId);

        return newTabContainer;
    }

    function generateTabId() {
        var returnTabId = null;
        while(returnTabId == null){
            var tabId = parseInt(Math.random() * (600 - 10) + 10);
            var isRepeat = false;
            $("input[data-param-name='tabId']").each(function(){
                var pId = $(this).val();
                if(pId && pId != ""){
                    pId = parseInt(pId);
                    if(tabId == pId){
                        isRepeat = true;
                        return false;
                    }
                }
            });
            if(!isRepeat){
                returnTabId = tabId;
            }
        }
        return returnTabId;
    }

    function buildProductGrid(tabId){

        //产品表格
        var productColumns = [
	        {title: '商品ID', dataIndex: 'productId', width: "12%"},
	        {
	            title: '商品名称',
	            dataIndex: 'productName',
	            width: 120,
	            renderer: function (value) {
	                return app.grid.format.encodeHTML(value);
	            }
	        },
	        {title: '品牌名称', dataIndex: 'brandName', width: "14%"},
	        {title: '分类名称', dataIndex: 'categoryName', width: "14%"},
	        {title: '成本价', dataIndex: 'tagPrice', width: "12%"},
	        {title: '销售价', dataIndex: 'defaultPrice', width: "12%"},
	        {title: '库存', dataIndex: 'realStock', width: "12%"},
	        {title: '操作',dataIndex:'',width:"12%",renderer : function(value,obj){
	            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
	            return delStr;
	    	}}
	    ];


        var productConditionIdArray = getTabProductId(tabId);

        var productStore = new Store({
            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : productConditionIdArray.join(",")
            }
        });
        var productGrid = new Grid.Grid({
            render:'#productGrid_' + tabId,
            columns : productColumns,
            store: productStore,
            width: '100%',
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:false
            },
            loadMask:true
        });

        //监听事件，删除一条记录
        productGrid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                deleteProduct(tabId, record);
            }
        });

        productGrid.render();

        if(productConditionIdArray.length > 0){
            productStore.load();
        }

        var tabGridKey = TabGridPrefix + tabId;
        allTabGrid[tabGridKey] = productGrid;
    }

    function getTabProductId(tabId) {
        var key = TabGridPrefix + tabId;
        return allTabProductId[key] != null ? allTabProductId[key] : [];
    }

    function getTabGrid(tabId){
        var key = TabGridPrefix + tabId;
        return allTabGrid[key] != null ? allTabGrid[key] : null;
    }

    function deleteProduct(tabId, record){
        BUI.Message.Confirm('确认移除记录？',function(){
            var tabGrid = getTabGrid(tabId);
            var tabGridStore = tabGrid.get('store');
            var tabProductId = getTabProductId(tabId);
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + tabProductId.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            tabProductId = tempArray;
            allTabProductId[(TabGridPrefix + tabId)] = tabProductId;
            tabGridStore.remove(record);
        },'question');
    }

    function productChoiceEvent(tabId, selectedProduct){

        var tabGrid = getTabGrid(tabId);
        if(tabGrid == null){
            return;
        }
        var tabGridStore = tabGrid.get('store');
        var tabProductIdArray = getTabProductId(tabId);

        var oldProductStr = "";
        oldProductStr = "," + tabProductIdArray.join(',') + ",";

        BUI.each(selectedProduct, function(product){
            var id = product.productId;
            if(oldProductStr.indexOf("," + id + ",") < 0){
                tabProductIdArray.push(id);
            }
            allTabProductId[(TabGridPrefix + tabId)] = tabProductIdArray;
            var count = tabGridStore.getCount();
            //添加记录到倒数第二个，同时防止添加重复的记录
            product.productNum = 1;
            tabGridStore.addAt(product, count, false, function(obj1,obj2){
                return obj1.id == obj2.id;
            });
        });
        reloadProductCondition(tabId);
    }
</script>
</body>
</html>