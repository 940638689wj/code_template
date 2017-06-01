<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>重置密码</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/accountSecurity"></a>
	        <h1 class="mui-title">修改登录密码</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="loginform">
            <ul>
            	<li>
            		<span style="font-size:12px;">定期更换密码可以让您的账户更加安全。请确保登录密码与支付密码不同！</span>
            	</li>
            	<#if user?? && user.password?has_content>
				<input type="hidden" id="validate" value="1">
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="当前登录密码" id="oldPassword" name="oldPassword"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>       
                </#if>     
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="新登录密码" id="password" name="password"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="确认登录密码" id="rptPassword" name="rptPassword"><span class="delete"></span></div>
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
		var vpassword =  new RegExp("^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$");
		var validate = $("#validate").val();
		if(validate!=null && !oldPassword){
			mui.toast("当前登录密码不可为空！");
		} 

		else if(!password){
			mui.toast("密码不可为空！");
		} 
		else if(${type}==1 && !vpassword.test(password)){
				mui.toast("请输入6至12位数字加字母的组合!");
		}
		else if(${type}==1 && (password.length < 6 || password.length > 12)){
				mui.toast("登录密码长度为6至12位！");
		}
		else if(${type}==2 && password.length != 6){
				mui.toast("请输入6-12位长度的密码！");
		}

		else if(!rptPassword){
			mui.toast("请输入重复密码！");
		}
		else if(password != rptPassword){
			mui.toast("两次输入密码不同，请重新输入！");
		} else {
			$.post("${ctx}/m/account/accountSecurity/resetPaw", {
	    		password : password,
	    		oldPassword : oldPassword,
	    		type : ${type}
	    	}, function(data){
	                if(data && data.result == "true"){
	                	mui.toast("修改成功！");
						if(data.successUrl !=null ){
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