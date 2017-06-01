<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>${articleTitle!}</title>
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
	            <h1 class="mui-title">${articleTitle!}</h1>
	            <a class="mui-icon"></a>
	        </header>
		</#if>
        <div class="mui-content">
            <div class="noticelist">
                <ul>
                	<#if articleList??>
	                	<#list articleList as list>
	                    	<li>
	                    		<a href="${(list.articleUrl)!}">
		                            <h3>${(list.articleTitle)!}</h3>
		                            <p><span class="fl">${(list.articleAuthor)!}</span><span class="fr">${(list.createTime?date)!}</span></p>
		                        </a>
		                    </li>
	                    </#list>
                	<#else>
                		<li>暂无${articleTitle!}信息</li>
                	</#if>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>