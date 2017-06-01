<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>提现</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">提现</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="balance-top withdrawal-bg">
                <h3>余额<span>(元)</span></h3>
                <p>${availableAmt}</p>
                <a href="${ctx}/m/account/withdrawal/toWithdrawalApplication?price=${(availableAmt)!}&type=1" class="btn">提现</a>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a href="javascript:void(0);">
                                <div class="r" style="font-size: 15px;">¥${checkingAmt !0.00}</div>
                                <div class="c">审核中</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a href="javascript:void(0);">
                                <div class="r" style="font-size: 15px;">¥${payingAmt !0.00}</div>
                                <div class="c">打款中</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a href="javascript:void(0);">
                                <div class="r" style="font-size: 15px;">¥${withdrewgAmt !0.00}</div>
                                <div class="c">已提金额</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/withdrawalDetail">
                                <div class="c">提现明细</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/toWithdrawalRule">
                                <div class="c">提现规则</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</body>
</html>