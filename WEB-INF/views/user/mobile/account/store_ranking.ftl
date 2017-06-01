<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>店铺排名</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1);"></a>
	            <h1 class="mui-title">店铺排名</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="client mb10">
                <ul>
                    <li>
                        <div class="num"></div>
                        <div class="head" style="background-image: url(<#if (headPortraitUrl)??>${(headPortraitUrl)!?html}<#else>${staticResourcePath}/images/userhead.jpg</#if>);"></div>
                        <div class="info nomargin">
                            <h3>${userName!?html}</h3>
                            <p>第${userMstoreRanking!?html}名</p>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="client">
                <ul>
                	<#if rankingList?? && rankingList?size gt 0>
                		<#assign count=0 >
	                	<#list rankingList as item>
	                		<#assign count=count+1 >
		                    <li>
		                        <div class="num">${count}</div>
		                        <div class="head" style="background-image: url(<#if (item.headPortraitUrl)??>${(item.headPortraitUrl)!?html}<#else>${staticResourcePath}/images/userhead.jpg</#if>);"></div>
		                        <div class="info nomargin">
		                            <h3>${(item.userName)!?html}</h3>
		                            <p>第${(item.ranking)!?html}名</p>
		                        </div>
		                    </li>
	                    </#list>
                    </#if>
                </ul>
            </div>
        </div>
    <div class="gotop">
        <a href="javascript:void(0);">
        <span class="iconfont">&#xf0aa</span>
        <p>置顶</p>
        </a>
    </div>
    </div>
</body>
</html>