<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>错误提示</title>
</head>
<body>

<div id="page">
    <div class="layout">
        <div class="pageinfo pageinfo500">
            <div class="errorpage erropage500">
                <div class="erroinfo500">
                    <#if errorType?? && errorType?has_content>
                        <h1>${errorType!}</h1>
                    </#if>

                    <#if errorText?? && errorText?has_content>
                        <p>可能因为：<br>${errorText!}</p>
                    </#if>

                    <#if goToUrl?? && goToUrl?has_content>
                        <p>您可以：稍后再试或<a href="${goToUrl}" class="btn-action">${goToUrlText!}</a></p>
                    <#else>
                        <p>您可以：稍后再试或<a href="${ctx}/index.html" class="btn-action">返回首页</a></p>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

