<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>提示</title>
</head>
<body>
    <div id="page">
	    <div class="mui-content">
	        <div class="iconinfo">
	            <i class="ico ico-success"></i>
	            <strong>支付成功!</strong>
	            <div class="btnbar">
	                <a class="mui-btn mui-btn-primary mui-btn-block w45 fl" href="${ctx}/m/groupPurchase/list">继续团购</a>
	                <a class="mui-btn mui-btn-primary mui-btn-block w45 fr" href="${ctx}/m/account/groupPurchaseOrder/detail?orderId=${orderId!}">查看订单</a>
	            </div>
	        </div>
	    </div>
	</div>
</body>
</html>