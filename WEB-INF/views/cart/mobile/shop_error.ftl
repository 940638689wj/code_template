<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>错误提示</title>
</head>
<body>
    <div id="page">
         <#if showTitle?? && showTitle>
		      <header class="mui-bar mui-bar-nav">
		           <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            	<h1 class="mui-title">温馨提示</h1>
		       	   <a class="mui-icon"></a>
		      </header>
       	</#if>

        <div class="mui-content" >
            <div class="iconinfo">
                <i class="ico ico-error"></i>
                <#if errorType?? && errorType?has_content><strong>${errorType!}</strong></#if>
                <#if errorText?? && errorText?has_content><strong>${errorText!}</strong></#if>
                <div class="btnbar">
                    <#if goToUrl?? && goToUrl?has_content>
                        <a class="mui-btn mui-btn-primary mui-btn-block" href="${goToUrl}" >${goToUrlText!}</a>
                    <#else>
                        <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m" >返回首页</a>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</body>
</html>