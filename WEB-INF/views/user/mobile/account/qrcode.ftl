<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>店铺二维码</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">店铺二维码</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
        <div class="mui-content">
            <div class="sis-qrcode"><img src="${ctx}/m/qrcode/getQrImg?userId=${userId}"></div>
            <div class="sis-qrcode-info">
                <div class="pic" style="background-image: url(${headUrl!})"></div>
                <h3>${userName!}</h3>
                <p>扫一扫二维码，一起欢乐购</p>
            </div>
        </div>
    </div>
</body>
</html>