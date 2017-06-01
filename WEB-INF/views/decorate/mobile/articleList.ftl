<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<#assign  mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!doctype html>
<html lang="en">
<head>
    <title>文章列表</title>
</head>
<body>
	 <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav"></a>
            <h1 class="mui-title">${(articleType.codeCnName)?default("资讯列表")}</h1>
            <a class="mui-icon"></a>
        </header>

        <div class="mui-content">
            <div class="noticelist">
                <ul>
                	 <#assign articleList = pageDTO.content>
            <#if articleList?? && (articleList?size > 0)>
                <#list articleList as article>
                    <li>
                        <a href="${mobileUrl!}/article/${article.articleId}">
                            <h3>${(article.articleTitle)!?html}</h3>
                            <p><span class="fl">${(article.articleAuthor)!?html}</span><span class="fr">${((article.articleCreateTime)?default('2013-11-11'))?string("yyyy-MM-dd")}</span></p>
                        </a>
                    </li>
                   </#list>
            </#if>
                </ul>
                 <@pager1 pageDTO "/m/article/list.html" ""/>
            </div>
        </div>
    </div>

        
	


</body>
</html>