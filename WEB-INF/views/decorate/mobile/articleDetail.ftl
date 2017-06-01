<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>${(article.articleTitle)!}</title>
</head>
<body>
		<#assign str=0>
        <#if article?? && article?has_content&&article.articleIsPublication==true>
        	<#assign str=1>
        <#else>
        	<#assign str=0>
        </#if>        	
     <#if str==1>
	 <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m"></a>
            <h1 class="mui-title">${(article.articleTitle)!}</h1>
            <a class="mui-icon"></a>
        </header>

        <div class="mui-content">
        	
            <div class="article-det">
                <h2 class="artcle-det-tit">${(article.articleTitle)!}</h2>
                <p class="article-det-time">发布时间:${((article.articleCreateTime)?default('2013-11-11'))?string("yyyy-MM-dd")}</p>
                <div class="article-main">
                    <p>${(article.articleContent)!}</p>
                </div>
            </div>            
        </div>
    </div>
    <#else>
     <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m"></a>
            <h1 class="mui-title"></h1>
            <a class="mui-icon"></a>
        </header>

        <div class="mui-content">
        	
            <div class="article-det">
                <h2 class="artcle-det-tit"></h2>
                <p class="article-det-time"></p>
                <div class="article-main">
                    <p>文章不存在!</p>
                </div>
            </div>            
        </div>
    </div>
      </#if>
</body>
</html>