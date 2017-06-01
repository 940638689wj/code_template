<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>修改密码</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
	        <h1 class="mui-title">账户安全</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="borderbox">
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/accountSecurity/changePaw_Reset?type=1">
                            <div class="c">登录密码</div>
                        </a>
                    </li>
 	
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/accountSecurity/changePaw_Reset?type=2">
                            <div class="c">支付密码</div>
                        </a>
                    </li>                    
                </ul>
            </div>
        </div>
    </div>

</div>
<script>
</script>
</body>
</html>