<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>自定义专区</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
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
	<!--
    <div id="page">
    	<#if showTitle?? && showTitle>
    		<#if customAreaDTO.headerFooter?? && customAreaDTO.headerFooter == 1>
		        <header class="mui-bar mui-bar-nav">
		            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">自定义专区</h1>
		            <a class="mui-icon"></a>
		        </header>
		    </#if>
		</#if>
		
        <div class="mui-content">
            <div class="article-det">
            	<#if customAreaDTO.headerFooter?? && customAreaDTO.headerFooter == 1>
	                <h2 class="artcle-det-tit">${(customAreaDTO.title)!}</h2>
	                <p class="article-det-time">${(customAreaDTO.createTime?datetime)!}</p>
	            </#if>
                <div class="article-main">
                    <img src="images/inbanner.jpg" alt="">
                    <p>${(customAreaDTO.content)!}</p>
                </div>
            </div>
        </div>
    </div>
  	-->
    <div id="main">
    <#if showTitle?? && showTitle>
    		<#if customAreaDTO.headerFooter?? && customAreaDTO.headerFooter == 1>
        <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="#">首页</a>
            <span class="divide">&gt;</span>
            <span>自定义专区</span>
        </div>
        </#if>
	</#if>
        <div class="article-top">
        <#if customAreaDTO.headerFooter?? && customAreaDTO.headerFooter == 1>
            <h2>${(customAreaDTO.title)!}</h2>
            <p>发布时间：${(customAreaDTO.createTime?datetime)!}</p>
        </#if>
        </div>
        <div class="article-content">
            <p>${(customAreaDTO.content)!}</p>
        </div>
    </div>
</body>
</html>