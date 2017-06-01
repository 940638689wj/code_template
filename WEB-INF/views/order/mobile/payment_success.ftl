<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>提示</title>
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
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/spa/#/m/account/order/detail/${orderId!}"></a>
		            <h1 class="mui-title">提示</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content" >
            <div class="iconinfo">
                <i class="ico ico-success"></i>
                <strong>支付成功!</strong>
                <div class="btnbar">
                    <a class="mui-btn mui-btn-primary mui-btn-block pushCoupon" style="display: none;" href="javascript:;" >可领取优惠券</a>
                    <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/spa/#/m/account/order/detail/${orderId!}" >返回订单详情</a>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(function () {
            var flag = true;
            if (!flag) { return; }
            var data = {};
            data.pushTypeCd = 3;
            $.ajax({
                url: '${ctx}/m/account/order/pushCoupon',
                async: true,
                type: 'POST',
                dataType: 'json',
                data: data,
                beforeSend: function () {
                    flag = false;
                },
                success: function (result) {
                    flag = true;
                    if(result.result == 'success' && result.codeStr) {
                        $('.pushCoupon').show();
                        $('.pushCoupon').attr('href','/m/coupon/'+result.codeStr)
                    }
                },
                error: function (XMLHttpResponse) {
                    flag = true;
                    console.log('请求未成功');
                }
            });
        })
    </script>
</body>
</html>