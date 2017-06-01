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
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/shopperIndex"></a>
	        <h1 class="mui-title">重置密码</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
    	 <div class="mui-content">
        <p class="inputNum">已绑手机： ${phone!}</p>
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
            <button class="mui-btn mui-btn-block mui-btn-primary" id="submit">提交</button>
        </div>
    </div>

</div>
<script>
$(function(){
	//发送短信验证码
	$("#getPhoneVerifyCode").click(function(){
        $.post("${ctx}/m/shopper/sendPhoneVerifyCode");
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
    $("#submit").click(function(){
    	//空判断
    	var phoneVerifyCode = $("#phoneVerifyCode").val();
    	var password = $("#password").val();
		var rptPassword = $("#rptPassword").val();
		if(!phoneVerifyCode){
			mui.toast("请输入验证码！");
		} 
		else if(!password){
			mui.toast("密码不可为空！");
		} 
		else if(!rptPassword){
			mui.toast("再次输入密码不可为空！");
		}
		else if(password != rptPassword){
			mui.toast("两次输入密码不同，请重新输入！");
		}
		else if(password.length<6||password.length>16){
			mui.toast("密码最少为6位,不应超过16位！");
        }else {
			$.post("${ctx}/m/shopper/resetPaw", {
				phoneVerifyCode : $('#phoneVerifyCode').val(),
	    		password : password
	    	}, function(data){
	                if(data && data.result == "true"){
	                	mui.toast("修改成功！");
	                	window.location.href = "${ctx}/m/shopper/shopperIndex";
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