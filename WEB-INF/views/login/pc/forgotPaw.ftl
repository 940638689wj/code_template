<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>忘记密码</title>
</head>
<body>
<div id="main">
	<div class="reg-step">
        <ul>
            <li class="current"><div class="step"><i class="icon-one"></i><p>重置密码</p></div></li>
            <li><div class="step"><i class="icon-two"></i><p>完成</p></div></li>
        </ul>
    </div>
    <div class="reg-form">
        <form action="" method="post" id="forgotPawForm">
            <ul>
                <li>
                    <div class="hd">手机号码:<span>*</span></div>
                    <div class="bd">
                        <div class="item"><input id="phone" name="phone" type="text" class="textfield"><i class="righ" style="display: none"></i></div>
                        <div class="validform"><p class="text-red"></p></div>
                    </div>
                </li>
                <li>
                    <div class="hd">验证码<span>*</span></div>
                    <div class="bd">
                        <div class="item">
                            <input id="verifyCode" name="verifyCode" type="text" class="textfield v-textfield">
                            <div class="vcode"><img src="${ctx}/randomCaptcha" id="randomImage"/></div>
                            <div class="in">看不清?<span class="text-red" id="nextImage">换一张</span></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">短信验证码<span>*</span></div>
                    <div class="bd">
                        <div class="item">
                            <input id="telephoneVerifyCode" name="telephoneVerifyCode" type="text"
                                   class="textfield dx-textfield">
                            <a class="v-button" href="javascript:void(0);" id="getTelephoneVerifyCode">获取短信验证码</a>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">新密码<span>*</span></div>
                    <div class="bd">
                        <div class="item"><input id="password" name="password" type="password" class="textfield"></div>
                        <div class="validform"><p class="text-red"></p></div>
                    </div>
                </li>
                <li>
                    <div class="hd">确认密码<span>*</span></div>
                    <div class="bd">
                        <div class="item"><input id="rptPassword" name="rptPassword" type="password" class="textfield">
                        </div>
                        <div class="validform"><p class="text-red"></p></div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <a href="javascript:void(0);" class="btn-action" id="doForgotPaw">确认</a>
                    </div>
                </li>
            </ul>
        </form>
    </div>
</div>
<script type="text/javascript">
    var randomUrl = "${ctx}/randomCaptcha";
    $(function () {
        <#if message?? && message?has_content>layer.msg('${message!}');</#if>

        $('#randomImage').click(function () {
            randomImage();
        });

        $('#nextImage').click(function () {
            randomImage();
        });

        $("#getTelephoneVerifyCode").click(function () {
            sendSmsMsg();
        });

        $("#doForgotPaw").click(function () {
            var password = $("#password").val();
            var rptPassword = $("#rptPassword").val();
            var verifyCode = $("#verifyCode").val();
            var phone = $("#phone").val();
            var telephoneVerifyCode = $("#telephoneVerifyCode").val();
            var vpassword =  new RegExp("^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$");

			if (!checkTelephone(phone)) {
                return;
            }
            
            if (!verifyCode) {
                layer.msg('请输入验证码!');
                randomImage();
                return false;
            }
           
            if (!telephoneVerifyCode || telephoneVerifyCode == "") {
                layer.msg('请输入短信验证码!');
                return false;
            }
            
            if(!password){
                layer.msg('请输入新密码！');
                return false;
            }
            if(!vpassword.test(password)){
            	layer.msg("请输入6至12位数字加字母的组合!");
            	return false;
            }
            if(password.length < 6 || password.length > 12){
            	layer.msg('请输入6-12位长度的密码！');
            	return false;
            }
            
            
            if (!rptPassword) {
                layer.msg('请输入重复密码!');
                return false;
            }
            if (password != rptPassword) {
                layer.msg('两次输入密码不同!');
                return false;
            }

            var param = {};
            param.password = password;
            param.verifyCode = verifyCode;
            param.telephoneVerifyCode = telephoneVerifyCode;
            param.phone = phone;
            $.post("${ctx}/forgotPaw/forgotPaw_post", param, function (data) {
                if (data && data.result == "true") {
                    layer.msg(data.message || "修改成功!");
                    window.location.href = "${ctx}/forgotPaw/forgotPawSuccess";
                } else {
                    layer.msg(data.message || "修改失败,请稍后再试!");
                    randomImage();
                }
            }, "json");
        });
    });

    function sendSmsMsg() {
        var verifyCode = $("#verifyCode").val();
        var phone = $("#phone").val();
		
		if (!checkTelephone(phone)) {
            return;
        }
        if (!verifyCode || verifyCode == "") {
            layer.msg('请输入验证码!');
            randomImage();
            return false;
        }


        var param = {};
        param.verifyCode = verifyCode;
        param.phone = phone;
        $.post("${ctx}/forgotPaw/sendTelephoneVerifyCode", param, function (data) {
            if (data && data.result == "true") {
                $("#getTelephoneVerifyCode").unbind();
                var times = 60;
                var timer = setInterval(function () {
                    if (--times <= 0) {
                        $("#getTelephoneVerifyCode").text("获取短信验证码");
                        clearInterval(timer);
                        $("#getTelephoneVerifyCode").bind("click", sendSmsMsg);
                        //$("#getTelephoneVerifyCode").addClass("btn-action");
                    } else {
                        $("#getTelephoneVerifyCode").text("重新获取" + times + "s");
                    }
                }, 1000);
                window.onunload = function () {
                    clearInterval(timer);
                };
            } else {
                layer.msg(data.message || "获取短信验证码失败,请稍后再试!");
                $('#randomImage').trigger("click");
            }
        }, "json");
    }

    // 校验手机号码格式
    function checkTelephone(telephone) {
        var mobileReg = new RegExp("^(1[0-9]{10})$");
        if (!telephone) {
            layer.msg('请填写手机号!');
            return false;
        }
        if (!mobileReg.test(telephone)) {
            layer.msg('手机号格式不正确!');
            return false;
        }
        return true;
    }

    //刷新验证码图片
    function randomImage() {
        $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
    }

</script>
</body>
</html>