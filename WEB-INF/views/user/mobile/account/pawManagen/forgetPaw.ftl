<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign canLoginByAlipay = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByAliPayMobile()>
<#assign canLoginByQQ = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByQQ()>
<#assign canLoginByWeibo = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeibo()>
<#assign canLoginByWeiXin = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeiXin()>
<!doctype html>
<html>
<head>
    <title>忘记密码</title>
</head>
<body>
<div id="page">

    <#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="javascript:history.back();"></a>
		        <h1 class="mui-title">忘记密码</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>

    <div class="mui-content">
        <div class="loginform verification-code">
            <form action="" method="post" id="loginForm">
                <input type="hidden" id="successUrl" name="successUrl" value="${successUrl!}">
                <ul>
                    <li class="input-wrap">
                        <div class="bd">
                            <input id="loginName" type="text" placeholder="手机号码" name="loginName" value="">
                        </div>
                        <span class="delete"></span>
                    </li>
                    <li>
                        <div class="bd">
                            <input id="telephoneVerifyCode" type="text" placeholder="验证码" name="telephoneVerifyCode" value="">
                        </div>
                        <div class="hd"><a href="javascript:void(0);" id="getTelephoneVerifyCode" class="btn-action">获取手机验证码</a></div>
                    </li>
                </ul>
                <div class="loginbtnbar">
		            <button type="button" class="mui-btn mui-btn-block mui-btn-primary" id="doLogin">提交</button>
		            <#--<p class="fl"><a href="#">免费注册</a></p>
		            <p class="fr"><a href="#">忘记密码</a></p>-->
		        </div>
            </form>
        </div>
</div>
<#include "${ctx}/includes/mobile/globalmenu.ftl"/>
<script type="text/javascript">
	var code="";
    var randomUrl = "${ctx}/randomCaptcha";
    $(function(){

        $("#getTelephoneVerifyCode").click(function(){
            sendSmsMsg();
        });

        $("#doLogin").click(function(){
            var loginName = $("#loginName").val();
            if (!checkTelephone(loginName)) {
                return;
            }

            var telephoneVerifyCode = $("#telephoneVerifyCode").val();
            if(!telephoneVerifyCode || telephoneVerifyCode == ""){
                mui.toast('请输入手机验证码!');
                return false;
            }
            if(telephoneVerifyCode==code){
            	location.href="${ctx}/m/account/toPawNew";
            }else{
            	mui.toast('验证码错误，请重新获取！');
            }
        });
    });

    function sendSmsMsg(){
        var loginName = $("#loginName").val();
        if (!checkTelephone(loginName)) {
            return;
        }

        $.post("${ctx}/m/account/sendCode",{telephone:loginName}, function(resultData){
        	code=resultData.code;
            if(resultData && resultData.result == "true"){
                $("#getTelephoneVerifyCode").unbind();
                var times = 60;
                var timer = setInterval(function () {
                    if (--times <= 0) {
                        $("#getTelephoneVerifyCode").text("获取验证码");
                        clearInterval(timer);
                        $("#getTelephoneVerifyCode").bind("click", sendSmsMsg);
                        $("#getTelephoneVerifyCode").removeClass().addClass("btn-action");
                    } else {
                        $("#getTelephoneVerifyCode").text(times + "秒后再次获取");
                    }
                }, 1000);
                window.onunload = function () {
                    clearInterval(timer);
                };
            }else{
                mui.toast(resultData.message || "获取验证码失败,请稍后再试!");
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
</script>
</body>
</html>