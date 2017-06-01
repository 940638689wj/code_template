<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>充值失败</title>

    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/global.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mobile.css" />

    <script type="text/javascript" src="${ctx}/static/mobile/js/zepto.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mobile.js"></script>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
		            <h1 class="mui-title">充值失败</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content" >
            <div class="iconinfo">
                <i class="ico ico-error"></i>
                <strong>充值失败</strong>
                <#if paymentError?? && paymentError?has_content><strong>${paymentError!}</strong></#if>
                <div class="btnbar">
                    <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m/account" >返回个人中心</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>