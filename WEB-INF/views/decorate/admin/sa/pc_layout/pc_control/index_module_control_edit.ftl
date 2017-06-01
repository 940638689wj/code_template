<#assign ctx = request.contextPath>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<#assign categoryControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].CATEGORY_RECOMMEND.type>
<#assign productControlScroll = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SCROLL_TYPE.type>
<#assign productControlModule3 = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE3_TYPE.type>
<#assign productControlModule4 = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE4_TYPE.type>
<#assign productControlSkuOffer = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SKU_OFFER_TYPE.type>
<#assign productControlCategoryScroll = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_CATEGORY_SCROLL_TYPE.type>
<#assign productControlModule6 = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE6_TYPE.type>
<#assign productControlNewRecommend = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_NEW_RECOMMEND_TYPE.type>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
    <title></title>
    <script type="text/javascript">

        function assetChange(fileName, lastFlag){
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
                fileElementId: "file_" + lastFlag,
                dataType: "json",
                method : 'post',
                success: function (data, statusCd) {
                    loadImage(data.assetUrl, lastFlag);
                },
                error: function (data, statusCd, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(assertUrl,lastFlag) {
            $("#imgPath_"+lastFlag).val(assertUrl);
            var imgDom = "<img style='width: 500px;' src='"+assertUrl+"'/>";
            if(lastFlag == "adImg"){
                imgDom = "<img style='width: 200px;' src='"+assertUrl+"'/>";
            }
            $("#imgArea_"+lastFlag).html(imgDom);
        }
    </script>
</head>
<body>
<#--<#if !isNew?? || !isNew>
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">控件模块</span></li>
        </ul>
    </div>
</#if>-->

<div id="productDesContent"  style="display: none;">
    <div class="form-content" name="productDesContent">
        <input type="hidden" name="productId" value="">
        <div class="row">
            <div class="control-group">
                <div class="controls control-row-auto">
                    <script type="text/plain" id="editProductInfoEditor" name="productInfo"></script>
                </div>
            </div>
        </div>
    </div>
</div>

<form class="form-horizontal" id="controlContainerForm" method="POST" action="edit">
    <input type="hidden" name="id" value="${(control.id)!}"/>
    <input type="hidden" name="type" value="${type?default(productControlType)}">
    <input type="hidden" name="showType" value="${(showType)?default('')}">
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
        <input type="hidden" name="statusCd" value="${(control.statusCd)!?default(1)}">
        <div class="controls" name="statusCd">
            <label class="radio" for="usedRadio"><input checked="checked" id="usedRadio" type="radio" value="1" name="statusRadio">启用</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="disabledRadio"><input <#if control??&&control.statusCd??&&control.statusCd == 0>checked="checked"</#if> id="disabledRadio" type="radio" value="0" name="statusRadio">禁用</label>
        </div>
    </div>
<#if showType?default('') == productControlScroll>
    <div class="control-group">
        <label class="control-label">背景图：</label>
        <div class="controls control-row-auto">
            <div class="file-btn">
                <button style="width: 130px;" class="button">选择背景图</button>
                <input id="file_titleImg" type="file" class="inp-file" name="file" onchange="javascript:assetChange(this.value,'titleImg');"/>
                <input id="imgPath_titleImg" value="${(controlDTO.titleImg)!}" name="titleImg" type="hidden" />
            </div>
            &nbsp;<span class="auxiliary-text">图片建议尺寸：1200*518 像素，视当前主题而定</span>
            <div id="imgArea_titleImg" class="zx-banner" style="width: 500px;margin-top: 10px;margin-bottom: 0px;">
                <#if (controlDTO.titleImg)?has_content>
                    <img src="${controlDTO.titleImg}" style="width: 500px;" alt=""/>
                <#else>
                    <b style="line-height: 50px;">背景图片预览</b>
                </#if>
            </div>
        </div>
    </div>
<#elseif showType?default('') == productControlModule6 || showType?default("") == productControlNewRecommend
|| showType?default("") == productControlModule3 || showType?default("") == productControlModule4>
    <div class="control-group">
        <label class="control-label"><s>*</s>是否显示标题图：</label>
        <#assign showTitleImg = "1">
        <#if (controlDTO.showTitleImg)?has_content>
            <#assign showTitleImg = (controlDTO.showTitleImg)?string("1","0")>
        </#if>
        <input type="hidden" name="showTitleImg" value="">
        <div class="controls" name="showTitleImg">
            <label class="radio" for="showTitleImgRadio"><input <#if showTitleImg == "1">checked="checked"</#if> id="showTitleImgRadio" type="radio" value="1" name="showOrHideTitleImgRadio">显示</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="hideTitleImgRadio"><input <#if showTitleImg == "0">checked="checked"</#if> id="hideTitleImgRadio" type="radio" value="0" name="showOrHideTitleImgRadio">不显示</label>
        </div>
        <div class="tips-wrap">
            <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                <div class="tips-content">提示：当有显示标题图时,不会显示标题文字。</div>
            </div>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">标题图链接：</label>
        <div class="controls"><input class="control-text input-large" type="text" name="titleLink" value="${(controlDTO.titleLink)!}"/></div>
    </div>
    <div class="control-group">
        <label class="control-label">标题图：</label>
        <div class="controls control-row-auto">
            <div class="file-btn">
                <button style="width: 130px;" class="button">选择标题图</button>
                <input id="file_titleImg" type="file" class="inp-file" name="file" onchange="javascript:assetChange(this.value,'titleImg');"/>
                <input id="imgPath_titleImg" value="${(controlDTO.titleImg)!}" name="titleImg" type="hidden" />
            </div>
            &nbsp;<span class="auxiliary-text">图片建议宽度：1200像素，视当前主题而定</span>
            <div id="imgArea_titleImg" class="zx-banner" style="width: 500px;margin-top: 10px;margin-bottom: 0px;">
                <#if (controlDTO.titleImg)?has_content>
                    <img src="${controlDTO.titleImg}" style="width: 500px;" alt=""/>
                <#else>
                    <b style="line-height: 50px;">标题图片预览</b>
                </#if>
            </div>
        </div>
    </div>
    <#if showType?default("") == productControlModule3 || showType?default("") == productControlModule4>
        <div class="control-group">
            <label class="control-label">左侧广告图链接：</label>
            <div class="controls"><input class="control-text input-large" type="text" name="adLink" value="${(controlDTO.adLink)!}"/></div>
        </div>
        <div class="control-group">
            <label class="control-label">左侧广告图：</label>
            <div class="controls control-row-auto">
                <div class="file-btn">
                    <button style="width: 130px;" class="button">选择左侧广告图</button>
                    <input id="file_adImg" type="file" class="inp-file" name="file" onchange="javascript:assetChange(this.value,'adImg');"/>
                    <input id="imgPath_adImg" type="hidden" value="${(controlDTO.adImg)!}" name="adImg">
                </div>
                &nbsp;<span class="auxiliary-text">图片建议尺寸：<#if showType?default("") == productControlModule4>450*600 像素<#else>330*550 像素</#if></span>
                <div id="imgArea_adImg" class="zx-banner" style="width: 200px;margin-top: 10px;margin-bottom: 0px;">
                    <#if (controlDTO.adImg)?has_content>
                        <img src="${controlDTO.adImg}" style="width: 200px;" alt=""/>
                    <#else>
                        <b style="line-height: 350px;">左侧广告图片预览</b>
                    </#if>
                </div>
            </div>
        </div>
        <#if showType?default("") == productControlModule4>
            <div class="control-group">
                <label class="control-label"><s>*</s>抓取商品信息：</label>
                <#assign autoGrabProductInfo = "0">
                <#if (controlDTO.autoGrabProductInfo)?has_content>
                    <#assign autoGrabProductInfo = (controlDTO.autoGrabProductInfo)?string("1","0")>
                </#if>
                <input type="hidden" name="autoGrabProductInfo" value="">
                <div class="controls" name="autoGrabProductInfo">
                    <label class="radio" for="autoGrabProductInfoRadio"><input <#if autoGrabProductInfo == "1">checked="checked"</#if> id="autoGrabProductInfoRadio" type="radio" value="1" name="autoGrabProductInfoRadio">抓取</label>&nbsp;&nbsp;&nbsp;
                    <label class="radio" for="autoGrabProductInfoRadio"><input <#if autoGrabProductInfo == "0">checked="checked"</#if> id="autoGrabProductInfoRadio" type="radio" value="0" name="autoGrabProductInfoRadio">不抓取</label>
                </div>
            </div>
        </#if>
    </#if>
</#if>
<#if type?default("") = productControlType>
    <div class="control-group">
        <label class="control-label">推荐商品：</label>
        <div class="controls"><button id="choiceProduct" type="button" class="button">选择商品</button></div>
        <div id="productGrid" style="padding-left: 42px;"></div>
    </div>
</#if>
<#if type?default("") = categoryControlType>
    <div class="control-group">
        <label class="control-label">选择类别：</label>
        <div class="controls">
            <select name="categoryId" data-rules="{required:true}">
                <#assign selectedCategoryId = (controlDTO.categoryId)?default(-1)?number>
                        <#if allParentCategoryList?has_content>
                <#list allParentCategoryList as parentCategory>
                    <#assign currentId = (parentCategory.id)?default(-1)/>
                    <#assign currentParentId=(parentCategory.defaultParentCategory.id)?default(-1)/>
                    <@showProductCategoryOptions  parentCategory 0 currentId currentParentId selectedCategoryId/>
                </#list>
            </#if>
            </select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">排序方式：</label>
        <div class="controls">
            <select name="sortType" data-rules="{required:true}">
                <option value="salesVolume" <#if (controlDTO.sortType)?? && controlDTO.sortType=="salesVolume">selected="selected"</#if>>按销量排序</option>
                <option value="time" <#if (controlDTO.sortType)?? && controlDTO.sortType=="time">selected="selected"</#if>>按时间排序</option>
                <option value="price" <#if (controlDTO.sortType)?? && controlDTO.sortType=="price">selected="selected"</#if>>按价格排序</option>
            </select>
        </div>
    </div>
</#if>

    <div class="actions-bar" style="padding-left: 45px;">
        <div class="form-action">
            <button class="button button-large button-primary">保存</button>
        </div>
    </div>

</form>
<script type="text/javascript">

	var editProductInfoEditor;
	
	//选择推荐商品
	var dialog = null;
	var editorDialog = null;
	var Overlay = BUI.Overlay
	dialog = new Overlay.Dialog({
	    title:'产品列表',
	    width: 850,
	    height: 460,
	    loader : {
	        url : '${ctx}/admin/sa/promotion/productDialog/list',
	        autoLoad : false, //不自动加载
	        lazyLoad : false //不延迟加载
	    },
	    buttons:[{
	        text:'选 择',
	        elCls : 'button button-primary',
	        handler : function(){
	            this.close();
	            productChoiceEvent(getSelectedRecords());
	        }
	    }],
	    mask:true
	});
	editorDialog = new Overlay.Dialog({
	    title:'产品描述',
	    width:700,
	    height:430,
	    contentId:'productDesContent',
	    success:function () {
	        var productInfo = editProductInfoEditor.getContent();
	        var productId = $("div[name='productDesContent']").find("input[name='productId']").val();
	        var productResult = productStore.getResult();
	        for(var i = 0; i < productResult.length; i++){
	            if(productResult[i]["id"] == productId){
	                productResult[i]["smallDesc"] = productInfo;
	            }
	        }
	        this.hide();
	    }
	});
	
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
	
	    $("#choiceProduct").click(function(){
	        dialog.get('loader').load();
	        dialog.show();
	    });
	
	    initProductGridEvent();
	
	    editProductInfoEditor = new UE.ui.Editor({initialFrameWidth: 650, initialFrameHeight: 250,allowDivTransToP:false});
	    editProductInfoEditor.render("editProductInfoEditor");
	});
	
	function collectData(){
	    var selectStatus = $("div[name='statusCd']").find("input[type='radio']:checked");
	    if(!selectStatus || !selectStatus.length){
	        BUI.Message.Alert("请选择控件状态!");
	        return false;
	    }
	    $("input[name='statusCd']").val(selectStatus.val());
	
	    var selectShowTitleImg = $("div[name='showTitleImg']").find("input[type='radio']:checked");
	    if(selectShowTitleImg && selectShowTitleImg.length){
	        $("input[name='showTitleImg']").val(selectShowTitleImg.val());
	    }
	
	    if($("div[name='autoGrabProductInfo']") && $("div[name='autoGrabProductInfo']").length){
	        var autoGrabProductInfo = $("div[name='autoGrabProductInfo']").find("input[type='radio']:checked");
	        if(autoGrabProductInfo && autoGrabProductInfo.length){
	            $("input[name='autoGrabProductInfo']").val(autoGrabProductInfo.val());
	        }
	    }
	
	    $("input[name='productIds']").val(productConditionIdArray.join(','));
	
	    var productResult = productStore.getResult();
	    if(productResult && productResult.length){
	        for(var i = 0; i < productResult.length; i++){
	            var product = productResult[i];
	            if(product["smallDesc"]){
	                var productInfo = product["smallDesc"];
	                var productInfoHidden = $("input[name='productIds']").clone();
	                productInfoHidden.attr("name", ("pInfo_" + product["id"]));
	                productInfoHidden.val(productInfo);
	                productInfoHidden.insertBefore($("input[name='productIds']"));
	            }
	        }
	    }
	    return true;
	}
	
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
    
	
	var productStore;
	var productGrid;
	var productConditionIdArray = [];
	var Grid = BUI.Grid,
	        Data = BUI.Data,
	        Store = Data.Store;
	
	function initProductGridEvent(){
	<#if type = productControlType && (controlDTO.productIds)?has_content>
	    <#list (controlDTO.productIds)?split(",") as productId>
	        productConditionIdArray.push(${productId});
	    </#list>
	</#if>
	    reloadProductCondition();
	}
	
	function buildProductGrid(){
	    productStore = new Store({
	        url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
	        autoLoad:false, //自动加载数据
	        params : { //配置初始请求的参数
	            sort : 'id desc',
	            "in_id" : productConditionIdArray.join(",")
	        },
	        pageSize : 5
	    });
	    productGrid = new Grid.Grid({
	        render:'#productGrid',
	        columns : productColumns,
	        store: productStore,
	        width: '100%',
	        // 底部工具栏
	        bbar:{
	            // pagingBar:表明包含分页栏
	            pagingBar:true
	        },
	        loadMask:true
	    });
	
	    //监听事件，删除一条记录
	    productGrid.on('cellclick',function(ev){
	        var sender = $(ev.domTarget); //点击的Dom
	        if(sender.hasClass('btn-del')){
	            var record = ev.record;
	            deleteProduct(record);
	        }
	        if(sender.hasClass("btn-edit")){
	            var record = ev.record;
	            $("div[name='productDesContent']").find("input[name='productId']").val(record.id);
	            if(record["smallDesc"]){
	                editProductInfoEditor.setContent(record["smallDesc"]);
	            } else {
	                editProductInfoEditor.setContent("");
	            }
	            editorDialog.show();
	        }
	    });
	
	    productGrid.render();
	}
	
	function deleteProduct(record){
	    BUI.Message.Confirm('确认移除记录？',function(){
	        var recordId = "," + record.productId + ",";
	        var originProductIdStr = "," + productConditionIdArray.join(",") + ",";
	        originProductIdStr = originProductIdStr.replace(recordId, ",");
	
	        var tempArray = originProductIdStr.split(',');
	        tempArray.pop();
	        tempArray.shift();
	        productConditionIdArray = tempArray;
	
	        reloadProductCondition();
	    },'question');
	}
	
	function reloadProductCondition(loadCallback){
	    if(!productStore){
	        buildProductGrid();
	        if(productConditionIdArray.length > 0){
	            productStore.load();
	        } else {
	            var records = productStore.getResult();
	            productStore.remove(records);
	        }
	    } else {
	        if(productConditionIdArray.length > 0){
	            var params = { //配置初始请求的参数
	                start : 0,
	                "in_id" : productConditionIdArray.join(",")
	            };
	            productStore.load(params);
	        } else {
	            var records = productStore.getResult();
	            productStore.remove(records);
	        }
	    }
	    productStore.on('load', function(ev){
	    <#if type = productControlType && (controlDTO.products)?has_content>
	        <#list (controlDTO.products) as productDTO>
	            var productId = '${(productDTO.productId)!}';
	            var productInfo = '${(productDTO.productInfo)!}';
	            if(productInfo && productInfo != ""){
	                var productResults = productStore.getResult();
	                for(var i = 0; i < productResults.length; i++){
	                    if(productResults[i]["id"] == productId){
	                        productResults[i]["smallDesc"] = productInfo;
	                    }
	                }
	            }
	        </#list>
	    </#if>
	    })
	}
	
	function productChoiceEvent(selectedProduct){
	    var oldProductStr = "";
	    oldProductStr = "," + productConditionIdArray.join(',') + ",";
	    for(var i = 0; i < selectedProduct.length; i++){
	        var id = selectedProduct[i].productId;
	        if(oldProductStr.indexOf("," + id + ",") < 0){
	            productConditionIdArray.push(id);
	        }
	    }
	    reloadProductCondition();
	}
</script>
</body>
</html>