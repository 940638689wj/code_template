<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的客户</title>
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
	            <h1 class="mui-title">我的客户</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="client">
                <ul>
                	<#if custList?? && custList?size gt 0>
                		<#assign count=0 >
                		<#list custList as item>
                			<#assign count=count+1 >
		                    <li>
		                        <div class="num">${count}</div>
		                        <div class="head" style="background-image: url(<#if (item.headPortraitUrl)??>${(item.headPortraitUrl)!?html}<#else>${staticResourcePath}/images/userhead.jpg</#if>);"></div>
		                        <div class="info">
		                            <h3>${(item.userName)!?html}</h3>
		                            <p>消费次数：<span>${(item.consumeCnt)!0}</span></p>
		                            <p>消费总额：<em>${(item.consumeAmt)!0}</em></p>
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

<script>



</script>
</body>
</html>