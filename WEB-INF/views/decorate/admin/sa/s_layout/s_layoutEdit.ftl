<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>首页模板</title>
    <link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
	<link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
	<link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
	<link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
	<link rel="stylesheet" href="${staticPath}/admin/css/yradmin.css" type="text/css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/yrmobile.css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/frames.css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/module.css"/>
    <link rel="stylesheet" href="${ctx}/static/decoration/mobile/css/decoration.css"/>
    <link rel="stylesheet" href="${ctx}/static/js/ztree/3.5.12/css/romaTree/zTreeStyle.css"/>
    <link rel="stylesheet" href="${ctx}/static/js/jsGrid/jsgrid.css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script src="${ctx}/static/mobile/js/zepto.js"></script>
	<script src="${ctx}/static/mobile/js/mui.min.js"></script>
	<script src="${ctx}/static/js/require.js"></script>
    <script>
        var args = {};
        (function () {
            var result = {},
                    params = location.search && location.search.substring(1),
                    arr = params.split("&");
            for(var i = 0; i < arr.length; i++){
                var t = arr[i].split("=");
                result[t[0]] = t[1];
            }
            args = result;
        })();
		
		//初始化requireJS
        var id = 0;
	    <#if decoration?? && decoration.id??>
	        id = "${(decoration.id)!}";
	    </#if>
	    var frameConfigUrl = "${ctx}/static/decoration/mobile/config/frameConfig.json";
	    if(id != 0){
	        frameConfigUrl = "${ctx}/admin/sa/mobile/layoutManage/getIsPushFrameJson/"+id;
	    }
	    var getLinkUrl = "/admin/links/getLinks";
	    var layoutDataUrl = "${ctx}/admin/sa/mobile/layoutManage/getLayoutJson/"+id;
	    var goodsCategoryDataUrl = "${ctx}/admin/sa/mobile/layoutManage/getGoodsCategory";
	    var goodsListDataUrl = "${ctx}/admin/sa/mobile/layoutManage/getGoodsList?decorationAreaCd="+${decorationAreaCd!};
	    window.UEDITOR_HOME_URL = "${ctx}/static/admin/js/ueditor/";
	    require.config({
	        baseUrl: '${ctx}/static/js'
	    });
	    require(["decoration/config"], function () {
	        require(["decoration/mobile/layoutEdit"]);
	    });
        
        //初始化
        $(function(){
        	var initCd = ${decorationAreaCd!};
        	if(initCd == 3){
        		$("#MS_").addClass("bui-tab-item-selected");
        	}else{
        		$("#S_").addClass("bui-tab-item-selected");
        	}
        	var decorationAreaCd;
	        var Height = getContentHeight();
	        $(".decoratebox").height(Height);
	        var tabItem = $(".nav-tabs li");
	        tabItem.on("click",function(){
	            var idx = $(this).index();
	            if(idx == 0){
	            	decorationAreaCd = 3;
	            }else{
	            	decorationAreaCd = 2;
	            }
	            window.location.href = "${ctx}/admin/sa/store/layoutManage/toEditLayout?decorationAreaCd="+decorationAreaCd;
	        });
	    })
	    
		//获取系统高度
	    function getContentHeight(titleDiv,topDiv,footDiv){
	        titleDiv = titleDiv || $('.title-bar');
	        topDiv = topDiv || $('.content-top');
	        footDiv = footDiv || $('.content-foot');
	        var totalHeight = $(window).height();
	        var titHeight = titleDiv.outerHeight() || 0;
	        var topHeight = topDiv.outerHeight() || 0;
	        var footHeight = footDiv.outerHeight() || 0;
	        return totalHeight - titHeight - topHeight - footHeight;
	    }
	    
	    //预览
	    function preview(){
	    	if(id > 0){
	    		previewType = 1;
	    	}else{
	    		previewType = 0;
	    	}
	    	window.open("${ctx}/admin/sa/mobile/layoutManage/toPreview/"+id+"?previewType="+previewType);
	    }
    </script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="nav-tabs">
            <li class="bui-tab-item" id="MS_"><span class="bui-tab-item-text">微店首页装修</span></li>
            <li class="bui-tab-item" id="S_"><span class="bui-tab-item-text">门店首页装修</span></li>
        </ul>
    </div>

    <div class="content-body">
    	<input type="hidden" id="decorationAreaCd" value="${decorationAreaCd!}">
        <div class="decoratebox">
            <div class="dcm-page">
                <div class="dcm-header">
                    <div class="dcm-header-btns">
                        <a id="MS_J_btn_save" href="javascript:void(0)">保存</a>
                        <a id="MS_J_btn_preview" href="javascript:void(0)">预览</a>
                        <a id="MS_J_btn_publish" href="javascript:void(0)">发布</a>
                    </div>
                </div>
                <div class="dcm-container">
                    <div class="dcm-sidebar">
                        <div class="dcm-side-menu">
                        </div>
                    </div>
                    <div class="dcm-main">
                        <div class="dcm-preview-wrap">
                            <div class="dcm-preview">
                                <div class="dcm-preview-box">
                                    <div class="dcm-preview-box-page">
                                        <!--<div data-frame="index_head"></div>-->
                                        <div class="container">
                                            <div class="containerwrap">

                                            </div>
                                            <!--<div data-frame="global_foot"></div>-->
                                        </div>
                                    </div>
                                </div>
                                <div class="dcm-preview-btn">
                                    <a href="javascript:preview();">预览页面</a>
                                </div>
                            </div>
                        </div>
                        <div class="dcm-setting-wrap">
                            <div class="dcm-setting">
                                <div class="dcm-setting-title">
                                    当前控件 ： <span class="title-txt"></span>
                                </div>
                                <div class="dcm-setting-body">
                                    <div class="setting-body-in"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>