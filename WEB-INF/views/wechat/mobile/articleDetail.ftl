<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>${(article.articleTitle)!}</title>
</head>
<body>
	 <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="" href="javascript:history.back()">&nbsp;</a>
            <h1 class="mui-title">${(article.articleTitle)!}</h1>
            <a class="mui-icon"></a>
        </header>

        <div class="mui-content">
            <div class="article-det">
                <#--<h2 class="artcle-det-tit">${(article.articleTitle)!}</h2>-->
                <#--<p class="article-det-time">${(article.createTime)?string("yyyy-MM-dd")}</p>-->
                <div class="article-main">
                    <p>${(article.description)!}</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>