<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的评价</title>
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
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
		            <h1 class="mui-title">我的评价</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="tabbar">
                <ul>
                    <li class="selected"><a href="${ctx}/m/account/toEvaluation">已评价</a></li>
                    <li><a href="${ctx}/m/account/toNotEvaluation">待评价</a></li>
                </ul>
            </div>
            <div class="borderbox">
                <ul class="prd-list browse-lst prize-lst">
                <#if list??>
                <#list list as order>
                	<#list order.orderItem as item>
                    <li>
                        <div class="clearbox" onclick="goto('${ctx}/m/product/${item.productId}');">
                            <div class="pic">
                                <img src="${(item.productPicUrl)!}">
                            </div>
                            <h3>${(item.productName)!}K</h3>
                            <div class="source">
                                <p><span class="rateit" data-rateit-value="4" data-rateit-readonly="true" data-rateit-starwidth="25" data-rateit-starheight="20"></span></p>
                                <!--<em><a href="#">追加评价</a></em> -->
                            </div>
                        </div>
                  <#list item.productReviews as review>
                        <div class="comments-text">
                        	${(review.reviewContent)!}
                        </div>
                        <p class="comments-time">${(review.reviewTime?date)!}</p>
                        <#if review.productReviewPicInfos??>
                         <div class="comments-img">
                        <#list review.productReviewPicInfos as pic>
                            <div class="imgItems"><img src="${(pic.picUrl)!}"></div>
                        </#list>
                        </div>
                        </#if>
                        <#if review.replyContent??>
                        <div class="answer">商家回复：${(review.replyContent)!}</div>
                        </#if>
                       </#list>
                    </li>
                    </#list>
                    </#list>
                    </#if>
                </ul>
            </div>
        </div>
        	<#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
    
 <script>   
 function goto(url){
		location.href = url;
	}
 </script>
</body>
</html>