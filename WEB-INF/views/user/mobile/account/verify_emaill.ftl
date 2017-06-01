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
	        <h1 class="mui-title">验证邮箱</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="loginform">
            <ul>
            	<li>
            		<span style="font-size:12px;">验证邮箱可以加强账号安全性，您可以使用已验证邮箱快速找回密码。</span>
            	</li>
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="输入当前密码" id="password" name="password"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>            
                <li>
                    
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" placeholder="输入邮箱地址" id="emaill" name="password"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input id="verifyCode" type="number" placeholder="验证码" name="verifyCode" value=""><span class="delete"></span></div>
                            <div><img src="${ctx}/randomCaptcha" id="randomImage" style="height:30px;cursor: pointer;"/></div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="btnbar">
            <button class="mui-btn mui-btn-block mui-btn-primary" id="submit">下一步</button>
        </div>
    </div>

</div>
<script>
$(function(){
	var randomUrl = "${ctx}/randomCaptcha"; 
	$('#randomImage').click(function(){
    	randomImage();
	 });
	
	
	$("#submit").click(function(){
		var password = $("#password").val();
		var emaill = $("#emaill").val();
		var verifyCode = $("#verifyCode").val();
		if(!password){
			mui.toast("登录密码不能为空!");
			return false;
		}
		if(!emaill){
			mui.toast("邮箱不能为空");
			return false;
		}else if(!isEmail(emaill)){
			mui.toast("邮箱格式错误,请重新输入");
			return false;
		}
		if(!verifyCode){
                mui.toast('请输入验证码!');
                randomImage();
                return false;
            }
			
			$.post("${ctx}/m/account/accountSecurity/set_email", {
	    		password : password,
	    		emaill : emaill,
	    		verifyCode : verifyCode
	    		
	    	}, function(data){
	                if(data && data.result == "true"){
	                	mui.toast("验证成功！");
                        window.location.href = "${ctx}/m/account";
                        
	                }else if (data.result == "false"){
	                    mui.toast(data.message || "验证失败,请稍后再试!");
	                }
	        }, "json");
		
	});
	
});
//邮箱验证
function isEmail(str){
 var reg=/^([a-zA-Z0-9_-])+@([a-zA-Z0-9_-])+((.[a-zA-Z0-9_-]{2,3}){1,2})$/;
 return reg.test(str);
}
//刷新验证码图片
function randomImage(){
    $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
}
</script>
</body>
</html>