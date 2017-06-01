<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的返利</title>
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
	            <h1 class="mui-title">我的返利</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="balance-top hbHeight" style="background-image:url(${staticPath}/images/my_rebate_bg.png);">
                <h3>返利<span>(元)</span></h3>
                <p>${(userConsumeCalc.userRebateDevelopSaleAmt?string.currency)!'￥0.00'}</p>
                <a class="withdrawalBtn returnBtn" href="${ctx}/m/account/withdrawal/toWithdrawalApplication?price=${(userConsumeCalc.userRebateDevelopSaleAmt)!'0'}&type=2">提现</a>
            </div>
            <div class="tabbar">
                <ul>
                    <li <#if type==0>class="selected" </#if> ><a href="${ctx}/m/account/toRebate?type=0">全部</a></li>
                    <li <#if type==1>class="selected" </#if> ><a href="${ctx}/m/account/toRebate?type=1">收入</a></li>
                    <li <#if type==2>class="selected" </#if> ><a href="${ctx}/m/account/toRebate?type=2">支出</a></li>
                </ul>
            </div>
            <div class="borderbox balance-list">
                <ul>
                <#if list?? && list?has_content>
                	<#list list as item>
                		<li>
	                    	<#if item.rebateType=='withdrawal'>
	                        	<div class="r">-${(item.rebateAmt?string.currency)!}</div>
	                        	<div class="l">提现</div>
	                        <#elseif item.distributionTypeCd == 4>
	                        	<div class="r">-${(item.rebateAmt?string.currency)!}</div>
	                        	<div class="l">${(item.distributionTypeName)!}</div>
	                        <#else>
	                        	<div class="r">+${(item.rebateAmt?string.currency)!}</div>
	                        	<div class="l">${(item.distributionTypeName)!}</div>
	                       	</#if>
	                        <p>${(item.createTime?datetime)!}</p>
	                    </li>
                	</#list>
                </#if>
                
                
                </ul>
            </div>
        </div>
 <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
</body>
</html>