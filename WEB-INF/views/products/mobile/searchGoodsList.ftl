<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>商品搜索结果页面</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
    <script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="javascript:window.location.href = '${ctx}/m/account/mstoreUser/toStoreManagement'"></a>
		            <h1 class="mui-title">商品</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
        <div class="mui-content">
            <div class="shelves-search">
                <div class="category-search">
                    <input type="text" placeholder="搜索您想要的商品" id="productName">
                    <button onclick="queryProduct()">搜索</button>
                </div>
            </div>
            
            <div class="prd-list-grid">
                <ul>
                	<#if list??>
	            	<#list list as item>
                    <li>
                        <a href="goods_detail.html">
                            <div class="pic"><img class="lazyload" src="/static/mobile/images/blank.gif" data-src="${item.picUrl!}" alt=""/></div>
                            <div class="intro">
                                <div class="name">${item.productName!}</div>
                                <div class="price">
                                    <div class="price-real">¥<em>${item.defaultPrice!}</em></div>
                                    <div class="price-origin">¥<em>${item.tagPrice!}</em></div>
                                </div>
                            </div>
                        </a>
                    </li>
                    </#list>
	            	</#if>
                </ul>
            </div>
        </div>
    </div>
    
    <script>
    	$(function(){
    		imgLazyLoad();
    		$("#productName").val("${q!}")
    	});
    
	    function imgLazyLoad(){
	        $("img.lazyload").css({
	            width : "100%",
	            height : "100%"
	        }).unveil(0, function () {
	            var img = $(this);
	            img.one("load", function () {
	                img.css({
	                    height : "auto",
	                    width : "auto"
	                });
	            });
	        });
	    }
    
    	function queryProduct(){
    		var mstoreId = ${mstoreId!};
    		var productName = $("#productName").val();
    		if(productName != ''){
    			window.location.href = '${ctx}/m/account/productmanager/searchMstoreProductsByKeyword/'+mstoreId+"?q="+productName;
    		}
    	}
    </script>
</body>
</html>