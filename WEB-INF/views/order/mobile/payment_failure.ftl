<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>支付订单</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/spa/#/m/account/order/detail/${orderId!}"></a>
		            <h1 class="mui-title">支付订单</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content" >
            <div class="iconinfo">
                <i class="ico ico-error"></i>
                <strong>支付失败</strong>
                <#if paymentError?? && paymentError?has_content><strong>${paymentError!}</strong></#if>
                <div class="btnbar">
                    <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m/account/toOrderDetail?orderId=${orderId!}" >返回订单详情</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>