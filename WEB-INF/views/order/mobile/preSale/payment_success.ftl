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
                <a class="mui-btn mui-btn-primary mui-btn-block w45 fl" href="${ctx}/m/index">继续购买</a>
                <a class="mui-btn mui-btn-primary mui-btn-block w45 fr" href="${ctx}/m/account/preSaleOrder/list">查看订单</a>
            </div>
        </div>
    </div>
</div>
</body>
</html>