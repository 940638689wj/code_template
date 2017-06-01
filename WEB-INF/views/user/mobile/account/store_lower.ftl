<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>下级微店排名</title>
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
	            <h1 class="mui-title">下级微店排名</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="storeTitle"><span class="fl">佣金收益排名</span><span class="fr">佣金收益(元)</span></div>
            <div class="client">
                <ul>
                	<#if lowerList?? && lowerList?size gt 0>
                		<#assign count=0 >
                		<#list lowerList as item>
	                		<#assign count=count+1 >
	                		<#if (item.userId)??>
			                    <li>
			                        <div class="num">${count}</div>
			                        <div class="head" style="background-image: url(<#if (item.headPortraitUrl)??>${(item.headPortraitUrl)!?html}<#else>${staticResourcePath}/images/userhead.jpg</#if>);"></div>
			                        <div class="info nomargin">
			                            <h3>${(item.userName)!?html}</h3>
			                            <p>总排名:${(item.ranking)!0}<span class="fr orange">${(item.totalSalesAmt)!0}</span></p>
			                        </div>
			                    </li>
	                		</#if>
                		</#list>
                    </#if>
                </ul>
            </div>
        </div>
    <div class="gotop">
        <a href="#page">
        <span class="iconfont">&#xf0aa</span>
        <p>置顶</p>
        </a>
    </div>
    </div>

<script>



</script>
</body>
</html>