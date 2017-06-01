<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>身份验证</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userChangePaw"></a>
	        <h1 class="mui-title">身份验证</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <p class="inputNum">已绑手机： ${(phone)!}</p>
        <div class="loginform">
            <ul>
                <li>
                    <div class="hd">验证码</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input id="phoneVerifyCode" type="number" placeholder="短信验证码" name="phoneVerifyCode" value=""><span class="delete"></span></div>
                            <div class="toobtain disabled"><a href="javascript:void(0);" id="getPhoneVerifyCode" class="btn-action">发送验证码</a></div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="btnbar">
            <a class="mui-btn mui-btn-block mui-btn-primary" href="javascript:void(0)" id="nextStep">下一步</a>
        </div>
    </div>

</div>
<script>
$(function(){
	
	if(${type}==0){
		window.location.href = "${ctx}/m/account/userChangePaw";
	}
	
	//发送短信验证码
	$("#getPhoneVerifyCode").click(function(){
        $.post("${ctx}/m/account/userChangePaw/sendPhoneVerifyCode");
        $("#getPhoneVerifyCode").unbind();
        var times = 60;
        var timer = setInterval(function () {
            if (--times <= 0) {
                $("#getPhoneVerifyCode").text("发送验证码");
                clearInterval(timer);
                $("#getPhoneVerifyCode").bind("click", sendSmsMsg);
                $("#getPhoneVerifyCode").removeClass().addClass("btn-action");
            } else {
                $("#getPhoneVerifyCode").text("重新获取" + times + "s");
            }
        }, 1000);
        window.onunload = function () {
            clearInterval(timer);
        };
    });
    
    //短信验证码校验
    $("#nextStep").click(function(){
    	//空判断
		if(!$("#phoneVerifyCode").val()){
			mui.toast("请输入验证码");
		} else {
	    	$.post("${ctx}/m/account/userChangePaw/checkPhoneVerifyCode", {
	    		phoneVerifyCode : $('#phoneVerifyCode').val()
	    	}, function(data){
	                if(data && data.result == "true"){
	                	window.location.href = "${ctx}/m/account/userChangePaw/changePaw_Reset?type=${type}";
	                }else if (data.result == "false"){
	                    mui.toast(data.message || "发送失败,请稍后再试!");
	                }
	        }, "json");
        }
    });
    
});
</script>
</body>
</html>