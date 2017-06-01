<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>提现</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userBalanceDetail"></a>
	        <h1 class="mui-title">提现</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="iconinfo">
            <i class="ico ico-info"></i>
            <strong>很抱歉当前功能正在开发，<br>暂时无法操作！</strong>
            <div class="btnbar">
                <a href="${ctx}/m/account/userBalanceDetail" class="mui-btn mui-btn-block mui-btn-primary">返回</a>
            </div>
        </div>
    </div>

</div>
<script>
</script>
</body>
</html>