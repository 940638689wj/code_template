<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>重置支付密码</title>  
</head>
<body>
<input type='hidden' id="successUrl" value='${successUrl!}'>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/accountSecurity"></a>
	        <h1 class="mui-title">设置支付密码</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="loginform">
            <ul>
            	<li>
            		<span style="font-size:12px;">请先设置您的支付密码，保证资金安全</span>
            	</li>
            	<#if (user?? && user.password?has_content) || (user?? && user.payPassword?has_content)>
                    <input type="hidden" id="validate" value="1">
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" <#if payPwd?? && payPwd == 0>placeholder="当前登录密码" <#else>placeholder="当前支付密码"</#if> id="oldPassword" name="oldPassword"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>      
                </#if>      
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="支付密码必须是6位数字" id="password"  name="password"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="确认支付密码" id="rptPassword" name="rptPassword"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="btnbar">
            <button class="mui-btn mui-btn-block mui-btn-primary" id="submit">确认</button>
        </div>
    </div>

</div>
<script>
$(function(){

	if(${type}==0){
		window.location.href = "${ctx}/m/account/userChangePaw";
	}
	
	$("#submit").click(function(){
		var oldPassword = $("#oldPassword").val();
		var password = $("#password").val();
		var rptPassword = $("#rptPassword").val();
		var reg = new RegExp(/^\d{6}$/);
        var validate = $("#validate").val();
		if(validate!=null && !oldPassword){
			mui.toast("当前登录密码不可为空！");
		} 

		else if(!password){
			mui.toast("支付密码不可为空！");
		} 
		else if(${type}==1 && (password.length < 6 || password.length > 18)){
				mui.toast("登录密码长度为6至18位！");
		}
		
		else if(${type}==2 && !reg.test(password)){
				mui.toast("支付密码必须为6位数字！");
		}

		else if(!rptPassword){
			mui.toast("再次输入密码不可为空！");
		}
		else if(password != rptPassword){
			mui.toast("两次输入密码不同，请重新输入！");
		} else {
			var successUrl = $("#successUrl").val();
			$.post("${ctx}/m/account/accountSecurity/resetPayPaw", {
	    		password : password,
	    		oldPassword : oldPassword,
	    		type : ${type},
	    		successUrl : successUrl
	    	}, function(data){
	                if(data && data.result == "true"){
	                	mui.toast("修改成功！");
						if(data.submitOrderUrl !=null ){
                            window.location.href = "${ctx}"+data.submitOrderUrl;
						} else if(data.successUrl != null) {
							window.location.href = "${ctx}"+data.successUrl;
						} else {
                            window.location.href = "${ctx}/m/account";
                        }
	                }else if (data.result == "false"){
	                    mui.toast(data.message || "修改失败,请稍后再试!");
	                }
	        }, "json");
		}
	});
	
});
</script>
</body>
</html>