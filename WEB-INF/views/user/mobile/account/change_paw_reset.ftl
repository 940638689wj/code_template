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
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userChangePaw/changePaw_VerifyPhone?type=${type}"></a>
	        <h1 class="mui-title">重置密码</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="loginform">
            <ul>
                <li>
                    <div class="hd w3">新密码</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="请输入新密码" id="password" name="password"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">确认密码</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="请再次输入新密码" id="rptPassword" name="rptPassword"><span class="delete"></span></div>
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
		var password = $("#password").val();
		var rptPassword = $("#rptPassword").val();
		
		if(!password){
			mui.toast("密码不可为空！");
		} 
		else if(${type}==1 && (password.length < 6 || password.length > 18)){
				mui.toast("登录密码长度为6至18位！");
		}
		else if(${type}==2 && password.length != 6){
				mui.toast("支付密码必须为6位！");
		}
		else if(!rptPassword){
			mui.toast("再次输入密码不可为空！");
		}
		else if(password != rptPassword){
			mui.toast("两次输入密码不同，请重新输入！");
		} else {
			$.post("${ctx}/m/account/userChangePaw/resetPaw", {
	    		password : password,
	    		type : ${type}
	    	}, function(data){
	                if(data && data.result == "true"){
	                	mui.toast("修改成功！");
						if(data.submitOrderUrl !=null ){
                            window.location.href = "${ctx}"+data.submitOrderUrl;
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