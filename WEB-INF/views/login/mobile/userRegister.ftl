<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign canLoginByAlipay = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByAliPayMobile()>
<#assign canLoginByQQ = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByQQ()>
<#assign canLoginByWeibo = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeibo()>
<#assign canLoginByWeiXin = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeiXin()>
<!doctype html>
<html>
<head>
    <title>注册</title>
</head>
<body>
<div id="page">

    <#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="javascript:history.back();"></a>
		        <h1 class="mui-title">免费注册</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>

    <div class="mui-content">
        <div class="loginform verification-code">
            <form action="" method="post" id="loginForm">
                <ul>
                	<li>
                		<div class="bd">
	                        <div class="info">
	                            <div class="input-wrap"><input id="phone" type="number" placeholder="请输入手机号" name="phone" value=""><span class="delete"></span></div>
	                        </div>
	                    </div>
                    </li>
                    <li>
                    	<div class="bd">
	                        <div class="info">
	                            <div class="input-wrap"><input id="verifyCode" type="number" placeholder="图形验证码" name="verifyCode" value=""></span></div>
	                            <div class="code"><img src="${ctx}/randomCaptcha" id="randomImage" style="height:30px;cursor: pointer;"/></div>
	                        </div>
	                    </div>
                    </li>
                    <li>
                    	<div class="bd">
	                        <div class="info">
	                            <div class="input-wrap"><input id="telephoneVerifyCode" type="number" placeholder="手机验证码" name="telephoneVerifyCode" value=""><span class="delete"></span></div>
	                            <div class="toobtain disabled"><a href="javascript:void(0);" id="getTelephoneVerifyCode" class="btn-action">发送验证码</a></div>
	                        </div>
	                    </div>
                    </li>
                    <li>
                    	<div class="bd">
	                        <div class="info">
	                            <div class="input-wrap"><input id="password" type="password" placeholder="输入密码(密码为6-12位数字加字母组合)" name="password" value=""><span class="delete"></span></div>
	                        </div>
	                    </div>
                    </li>
                    <li>
                    	<div class="bd">
	                        <div class="info">
	                            <div class="input-wrap"><input id="rptPassword" type="password" placeholder="重复输入密码(密码为6-12位数字加字母组合)" name="rptPassword" value=""><span class="delete"></span></div>
	                        </div>
	                    </div>
                    </li>
                </ul>
            </form>
        </div>

        <div class="btnbar">
            <button type="button" class="mui-btn mui-btn-block mui-btn-primary" id="doRegister">确认	</button>
        </div>
		<div class="loginForget">
            <p class="fl"><a href="${ctx}/m/login">返回登录</a></p>
            <p class="fr"><a href="${ctx}/m/view/0.html">注册协议</a></p>
        </div>
    </div>
</div>

<script type="text/javascript">
    var randomUrl = "${ctx}/randomCaptcha";
    $(function(){
        <#if message?? && message?has_content>mui.toast('${message!}');</#if>

        $('#randomImage').click(function(){
            randomImage();
        });

        $("#getTelephoneVerifyCode").click(function(){
            sendSmsMsg();
        });

        $("#doRegister").click(function(){
            //var loginName = $("#loginName").val();
        	var password = $("#password").val();
        	var rptPassword = $("#rptPassword").val();
            var verifyCode = $("#verifyCode").val();
            var phone = $("#phone").val();
            var telephoneVerifyCode = $("#telephoneVerifyCode").val();
            var vpassword =  new RegExp("^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$");
            //if(!loginName){
            //    mui.toast('请输入会员账号！');
            //    return false;
            //}
            if (!checkTelephone(phone)) {
                return;
            }
            
            if(!verifyCode){
                mui.toast('请输入验证码！');
                randomImage();
                return false;
            }
            
            if(!telephoneVerifyCode || telephoneVerifyCode == ""){
                mui.toast('请输入短信验证码！');
                return false;
            }
            
            if(!password){
                mui.toast('请输入密码！');
                return false;
            }
            if(!vpassword.test(password)){
            	mui.toast("请输入6至12位数字加字母的组合!");
            	return false;
            }
            if(password.length < 6 || password.length > 12){
            	mui.toast('请输入6-12位长度的密码！');
            	return false;
            }
            
            if(!rptPassword){
                mui.toast('请输入重复密码！');
                return false;
            }
            
            if (password != rptPassword) {
                mui.toast('两次输入密码不同！');
                return false;
            }

            var param = {};
            //param.loginName = loginName;
            param.password = password;
            param.verifyCode = verifyCode;
            param.telephoneVerifyCode = telephoneVerifyCode;
            param.phone = phone;
            $.post("${ctx}/m/register/register_post", param, function(data){
                if(data && data.result == "true"){
                	mui.toast(data.message || "注册成功!");
                	window.location.href = "${ctx}/m/login";
                }else{
                    mui.toast(data.message || "注册失败,请稍后再试!");
                    randomImage();
                }
            }, "json");
        });
    });

    function sendSmsMsg(){
        var verifyCode = $("#verifyCode").val();
        var phone = $("#phone").val();
        
        if(!verifyCode || verifyCode == ""){
            mui.toast('请输入验证码！');
            randomImage();
            return false;
        }

        if (!checkTelephone(phone)) {
            return;
        }

        var param = {};
        param.verifyCode = verifyCode;
        param.phone = phone;
        $.post("${ctx}/m/register/sendTelephoneVerifyCode", param, function(data){
            if(data && data.result == "true"){
                $("#getTelephoneVerifyCode").unbind();
                var times = 60;
                var timer = setInterval(function () {
                    if (--times <= 0) {
                        $("#getTelephoneVerifyCode").text("发送验证码");
                        clearInterval(timer);
                        $("#getTelephoneVerifyCode").bind("click", sendSmsMsg);
                        //$("#getTelephoneVerifyCode").removeClass().addClass("btn-action");
                    } else {
                        $("#getTelephoneVerifyCode").text("重新获取" + times + "s");
                    }
                }, 1000);
                window.onunload = function () {
                    clearInterval(timer);
                };
            }else{
                mui.toast(data.message || "获取短信验证码失败,请稍后再试!");
                $('#randomImage').trigger("click");
            }
        }, "json");
    }

    // 校验手机号码格式
    function checkTelephone(telephone) {
        var mobileReg = new RegExp("^(1[0-9]{10})$");
        if (!telephone) {
            mui.toast('请填写手机号!');
            return false;
        }
        if (!mobileReg.test(telephone)) {
            mui.toast('手机号格式不正确!');
            return false;
        }
        return true;
    }

    //刷新验证码图片
    function randomImage(){
        $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
    }

</script>
</body>
</html>