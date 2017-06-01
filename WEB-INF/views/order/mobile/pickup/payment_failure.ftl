<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>提示</title>
</head>
<body>
    <div id="page">
        <div class="mui-content" >
            <div class="iconinfo">
                <i class="ico ico-error"></i>
                <strong>支付失败</strong>
				<#if paymentError?? && paymentError?has_content><strong>${paymentError!}</strong></#if>
                <div class="btnbar">
                    <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m/account/pickupOrder/detail?orderId=${orderId!}" >返回订单详情</a>
                </div>
            </div>
        </div>
	</div>
</body>
</html>