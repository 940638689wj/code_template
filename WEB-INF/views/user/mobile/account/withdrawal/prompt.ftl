<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>提示</title>
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
	            <h1 class="mui-title">提示</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content" >
            <div class="iconinfo">
           		<#if type=='1'>
                <i class="ico ico-success"></i>
                <strong>提现申请成功</strong>
                <strong>请耐心等待审批!</strong>
               <#else>
                <i class="ico ico-error"></i>
                <strong>提现申请失败</strong>
                <strong></strong>
               </#if>
                
                <div class="btnbar">
                    <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m/account" >返回首页</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>