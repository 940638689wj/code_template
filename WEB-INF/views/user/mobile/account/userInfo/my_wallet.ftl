<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的钱包</title>
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
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">我的钱包</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="balance-top vouchers-top">
                <a href="${ctx}/m/account/list?type=0&price=${(userConsumeCalc.userBalance)!}">
                    <h3>购酒券<span>(元)</span></h3>
                    <p>${(userConsumeCalc.userBalance?string.currency)!'￥0.00'}</p>
                </a>
            </div>
            <div class="borderbox">
                <ul class="tbviewlist paytypes">
                    <li class="mc-info-link">
                        <a class="itemlink" href="${ctx}/m/account/toRedEnvelope?type=0">
                            <div class="r">${(userConsumeCalc.redPacketBalance?string.currency)!'0'}</div>
                            <div class="c"><i class="payico payico-envelope"></i>红包</div>
                        </a>
                    </li>
                    <li class="mc-info-link">
                        <a class="itemlink" href="${ctx}/m/account/toRebate?type=0">
                            <div class="r">${(userConsumeCalc.userRebateDevelopSaleAmt?string.currency)!'0'}</div>
                            <div class="c"><i class="payico payico-rebate"></i>返利</div>
                        </a>
                    </li>
                    <li class="mc-info-link">
                        <a class="itemlink" href="${ctx}/m/account/toCredit?type=0">
                            <div class="r">${(userConsumeCalc.totalScore)!'0'}</div>
                            <div class="c"><i class="payico payico-integral"></i>积分</div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/toPawManagen">
                                <div class="c">密码管理</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
 	<#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
</body>
</html>