<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>登录</title>
</head>
<body>
<div class="login-page" <#if pcBackgroundSystemImage?? && pcBackgroundSystemImage?has_content> style="background-image: url(${pcBackgroundSystemImage!});"</#if>>
    <div class="layout">
        <div class="loginbox">
            <div class="tit">会员登录</div>
            <form>
                <div class="login-form">
                    <div class="item">
                        <input type="hidden" id="successUrl" name="successUrl" value="${successUrl!}"/>
                        <div class="hd">
                            <i class="login_icon"></i>
                            <input type="text" class="textfield login-input-user" placeholder="请输入手机号"
                                   name="loginName" id="loginName"/>
                        </div>
                    </div>
                    <div class="item">
                        <div class="hd">
                            <i class="password_icon"></i>
                            <input type="password" class="textfield login-input-psw" placeholder="请输入密码"
                                   name="password" id="password">
                        </div>
                    </div>
                    <div class="item">
                        <div class="hd">
                            <i class="verification_code"></i>
                            <input type="text" class="vcode-w" placeholder="请输入验证码"
                                   name="verifyCode" id="verifyCode">
                            <span class="vcpde" title="点击图片刷新">
                                        <img src="${ctx}/randomCaptcha" id="randomImage"
                                             style="cursor: pointer;"/>
                                    </span>
                        </div>
                    </div>

                    <div class="loginbtn">
                        <a href="javascript:void(0);" id="doLogin"><span>登 录</span></a>
                        <#--<a href="${ctx}/cas/index" class="vbtn" id="doLogin"><span>白 鹭 卡 会 员 登 录</span></a>-->
                    </div>

                    <div class="login-extra">
                        <a href="${ctx}/register" class="fll">免费注册</a>
                        <a href="${ctx}/forgotPaw" class="flr">忘记密码</a>
                    </div>
                </div>
                    <#--<div class="partylogin">-->
                        <#--<h3>合作网站账号登录</h3>-->
                        <#--<ul>-->
                            <#--<li>-->
                                <#--<a href="#">-->
                                    <#--<i class="ico ico-alipay"></i>-->
                                <#--</a>-->
                            <#--</li>-->
                            <#--<li>-->
                                <#--<a href="#">-->
                                    <#--<i class="ico ico-qq"></i>-->
                                <#--</a>-->
                            <#--</li>-->
                            <#--<li>-->
                                <#--<a href="#">-->
                                    <#--<i class="ico ico-sina"></i>-->
                                <#--</a>-->
                            <#--</li>-->
                        <#--</ul>-->
                    <#--</div>-->

            </form>
        </div>
    </div>
</div>
<script>
    var randomUrl = "${ctx}/randomCaptcha";
    $(function () {
        $('#loginName,#password,#verifyCode').bind('keypress',function(event){
            if(event.keyCode == "13"){
                $('#doLogin').trigger('click');
            }
        });

        $('#randomImage').click(function () {
            randomImage();
        });

        $("#doLogin").click(function () {
            if (!$("#loginName").val()) {
                layer.msg('请输入用户名/手机号!');
                return false;
            }

            if (!$("#password").val()) {
                layer.msg('请输入密码!');
                return false;
            }

            if ($("#password").val().length < 6 || $("#password").val().length > 16) {
                layer.msg('请输入6至16位长度的密码！');
                return false;
            }

            if (!$("#verifyCode").val()) {
                layer.msg('请输入验证码!');
                randomImage();
                return false;
            }

            $.post("${ctx}/login/login_post", {
                loginName: $("#loginName").val(),
                password: $("#password").val(),
                verifyCode: $("#verifyCode").val(),
                successUrl: $("#successUrl").val()
            }, function (data) {
                if (data && data.result == "true") {
                    if (data.successUrl) {
                        window.location.href = data.successUrl;
                    } else {
                        window.location.href = "${ctx}";
                    }
                } else {
                    layer.msg(data.message || "登录失败,请稍后再试!");
                    randomImage();
                }
            }, "json");
        });
    });

    //刷新验证码图片
    function randomImage() {
        $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
    }

</script>
</body>
</html>