<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign canLoginByAlipay = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByAliPayMobile()>
<#assign canLoginByQQ = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByQQ()>
<#assign canLoginByWeibo = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeibo()>
<#assign canLoginByWeiXin = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeiXin()>
<!doctype html>
<html>
<head>
    <title>绑定手机号</title>
</head>
<body>
<div id="page">

    <#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="javascript:history.back();"></a>
		        <h1 class="mui-title">绑定手机号</h1>
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
                            <input id="loginName" type="number" placeholder="手机号码" name="loginName" value="">
                        </div>
                        <span class="delete"></span>
                    </li>

                    <li>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap">
                                    <input id="verifyCode" type="number" placeholder="图形验证码" name="verifyCode" value=""></span>
                                </div>
                                <div class="code">
                                    <img src="${ctx}/randomCaptcha" id="randomImage" style="height:30px;cursor: pointer;"/>
                                </div>
                            </div>
                        </div>
                    </li>

                    <li>
                        <div class="bd">
                            <input id="telephoneVerifyCode" type="number" placeholder="手机验证码" name="telephoneVerifyCode" value="">
                        </div>
                        <div class="hd">
                            <a href="javascript:void(0);" id="getTelephoneVerifyCode" class="btn-action">发送验证码</a>
                        </div>
                    </li>
                </ul>
            </form>
        </div>

        <div class="loginbtnbar">
            <button type="button" class="mui-btn mui-btn-block mui-btn-primary" id="doLogin">提交</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    var randomUrl = "${ctx}/randomCaptcha";
    $(function(){
        $("#getTelephoneVerifyCode").click(function(){
            sendSmsMsg();
        });

        $('#randomImage').click(function(){
            randomImage();
        });

        $("#doLogin").click(function(){
            var loginName = $("#loginName").val();
            if (!checkTelephone(loginName)) {
                return;
            }

            var verifyCode = $("#verifyCode").val();
            if(!verifyCode || verifyCode == ""){
                mui.toast('请输入验证码！');
                randomImage();
                return false;
            }

            var telephoneVerifyCode = $("#telephoneVerifyCode").val();
            if(!telephoneVerifyCode || telephoneVerifyCode == ""){
                mui.toast('请输入动态密码!');
                return false;
            }

            var data = {};
            data.telephoneVerifyCode = telephoneVerifyCode;
            data.verifyCode = verifyCode;
            data.telephone = loginName;
            data.toBinding = 1;
            data.successUrl = $("#successUrl").val();
            $.post("${ctx}/m/login/bindingThirdPartyUser", data, function(resultData){
                console.log(resultData)
                if(resultData && resultData.result == "true"){
                    if(resultData.successUrl){
                        window.location.href = resultData.successUrl;
                    }else{
                        window.location.href = "${ctx}/m";
                    }
                }else{
                    mui.toast(resultData.message || "绑定失败,请稍后再试!");
                    randomImage();
                }
            }, "json");
        });
    });

    function sendSmsMsg(){
        var verifyCode = $("#verifyCode").val();
        if(!verifyCode || verifyCode == ""){
            mui.toast('请输入验证码！');
            randomImage();
            return false;
        }

        var loginName = $("#loginName").val();
        if (!checkTelephone(loginName)) {
            return;
        }

        var param = {};
        param.verifyCode = verifyCode;
        param.phone = loginName;
        param.toBinding = 1;
        $.post("${ctx}/m/register/sendTelephoneVerifyCode", param, function(data){
            if(data && data.result == "true"){
                $("#getTelephoneVerifyCode").unbind();
                var times = 60;
                var timer = setInterval(function () {
                    if (--times <= 0) {
                        $("#getTelephoneVerifyCode").text("发送验证码");
                        clearInterval(timer);
                        $("#getTelephoneVerifyCode").bind("click", sendSmsMsg);
                        $("#getTelephoneVerifyCode").removeClass().addClass("btn-action");
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