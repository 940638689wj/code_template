<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的优惠券</title>
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
	            <h1 class="mui-title">我的优惠券</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
        <div class="mui-content">
            <div class="couponlist">
                <ul>
                <#if list??>
                <#list list as item>
                    <li <#if item.couponStatusCd==1 && item.enableEndTime?date gt .now?date>
	                    	<#if item_index%3==1>
	                    	class="threshold01"
	                    	<#elseif item_index%3==2>
	                    	class="threshold02"
	                    	<#else>
	                    	class="threshold03"
	                    	</#if>
	                    <#else>
	                    class="disabled"
	                    </#if> >
                        <div class="hd">
                            <div class="price">
                                <p>￥<em>${item.discountValue!'0.00'}</em></p>
                                <span>${(item.discountDesc)!'无金额门槛'}</span>
                            </div>
                            <div class="info">
                                <h3>${(item.promotionName)!}</h3>
                                <p>${(item.discountDesc)!}</p>
                            </div>
                        </div>
                        <div class="ft">
                            <p class="status">
                            <#if item.enableEndTime?date lt .now?date>
                                  	已过期
                            <#else>
                            ${DICT('COUPON_STATUS_CD','${(item.couponStatusCd)!}')}
                            </#if>
                            </p>
                            <p class="time">有效期至：${(item.enableEndTime?date)!}</p>
                        </div>
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