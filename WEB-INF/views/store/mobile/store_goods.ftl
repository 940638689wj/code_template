<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>商品列表</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/module.css" />
    <script type="text/javascript" src="${staticPath}js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">商品列表</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="borderbox">
                <ul class="prd-list store-list">
                	<#if list??>
                	<#list list as goods>
                    <li>
                        <a href="${ctx}/m/product/${goods.productId}">
                        <div class="pic">
                            <img src="${(goods.picUrl)!}">
                        </div>
                        <h3>${(goods.productName)!}</h3>
                        <p class="price mt24"><span class="price-real">￥<em>${(goods.defaultPrice)!}</em></span><span class="price-origin">${(goods.tagPrice)!}</span></p>
                        </a>
                    </li>
                    </#list>
                    </#if>
                </ul>
            </div>
    </div>
</body>
</html>