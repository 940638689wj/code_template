<#assign ctx = request.contextPath>

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>分类订单</title>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">分类订单</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <div class="borderbox">
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/pickupOrder/list?type=0">
                            <div class="c">提货券订单</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/groupPurchaseOrder/list">
                            <div class="c">团购订单</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/preSaleOrder/list">
                            <div class="c">预售订单</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/crowdfundingOrder/list.html">
                            <div class="c">我的众筹</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="/spa/#/m/account/order/list/3/0">
                            <div class="c">白鹭卡订单</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>

</div>
</body>
</html>