<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>${(article.articleTitle)!}</title>
</head>
<body>
	 <!-- <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="javascript:history.back()">返回</a>
            <h1 class="mui-title">资讯详情</h1>
            <a class="mui-icon"></a>
        </header>

        <div class="mui-content">
            <div class="article-det">
                <h2 class="artcle-det-tit">${(article.articleTitle)!}</h2>
                <p class="article-det-time">${((article.articleCreateTime)?default('2013-11-11'))?string("yyyy-MM-dd")}</p>
                <div class="article-main">
                    <p>${(article.articleContent)!}</p>
                </div>
            </div>
        </div>
    </div> -->

	
	<#assign str=0>
        	<#if article?? && article?has_content&&article.articleIsPublication==true>
        		<#assign str=1>
        	<#else>
        		<#assign str=0>
        	</#if> 
        <#if str==1>	
	<div id="main">
        <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="${ctx}/">首页</a>
            <span class="divide">&gt;</span>
            <span>${(article.articleTitle)!}</span>
        </div>
        
        <div class="article-top">
            <h2>${(article.articleTitle)!}</h2>
            <p>发布时间：${((article.articleCreateTime)?default('2013-11-11'))?string("yyyy-MM-dd")}</p>
        </div>
        <div class="article-content">
            <p>${(article.articleContent)!}</p>
        </div>
     </div>
        <#else>
        <div id="main">
         <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="${ctx}/">首页</a>
        </div>
        <div class="article-top">
            <h2></h2>
            <p></p>
        </div>
        <div class="article-content">
            <p>文章不存在!</p>
        </div>
     </div>   
        </#if>
</body>
</html>