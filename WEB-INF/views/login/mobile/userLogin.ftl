<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign canLoginByAlipay = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByAliPayMobile()>
<#assign canLoginByQQ = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByQQ()>
<#assign canLoginByWeibo = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeibo()>
<#assign canLoginByWeiXin = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeiXin()>
<!doctype html>
<html>
<head>
    <title>登录</title>
</head>
<body>

<div id="page" class="login">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m"></a>
	        <h1 class="mui-title">登录</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <#--<div class="welcometop">
            <div class="hd" style="background-image: url(../../../../static/mobile/images/logo.png);"></div>
            <p class="text">亲爱的用户，欢迎您！</p>
        </div>-->
        <div class="loginform loginlbd">
        	<input type="hidden" id="successUrl" name="successUrl" value="${successUrl!}">
            <ul>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" placeholder="手机号码" name="loginName" id="loginName"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="password" placeholder="请输入密码" name="password" id="password"><span class="delete"></span></div>
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
            <!--<button class="mui-btn mui-btn-block mui-btn-primary mui-disabled">登录</button>-->
            <button class="mui-btn mui-btn-block mui-btn-primary"  id="doLogin">登录</button>
        </div>
        <div class="loginForget">
            <p class="fl"><a href="${ctx}/m/register">免费注册</a></p>
            <p class="fr"><a href="${ctx}/m/forgotPaw">忘记密码</a></p>
        </div>
        <div class="partylogin">
            <h3><span>第三方账号快捷登录</span></h3>
            <ul>
                <li>
                    <a href="${ctx}/m/thirdparty/wx_login?successUrl=${successUrl!}">
                        <i class="ico ico-wechat"></i>
                    </a>
                </li>
            </ul>
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

        $("#doLogin").click(function(){
        	if(!$("#loginName").val()){
                mui.toast('请输入手机号!');
                return false;
            }
            
            if(!$("#password").val()){
                mui.toast('请输入密码!');
                return false;
            }
            if($("#password").val().length < 6 || $("#password").val().length > 12 ){
            	mui.toast('请输入6至12位长度的密码！');
            	return false;
            }
            if(!$("#verifyCode").val()){
                mui.toast('请输入验证码!');
                randomImage();
                return false;
            }

            $.post("${ctx}/m/login/login_post", {
            	loginName : $("#loginName").val(),
            	password : $("#password").val(),
            	verifyCode : $("#verifyCode").val(),
            	successUrl : $("#successUrl").val()
            }, function(data){
                if(data && data.result == "true"){
                    if(data.successUrl){
                        window.location.href = data.successUrl;
                    }else{
                        window.location.href = "${ctx}/m";
                    }
                }else{
                    mui.toast(data.message || "登录失败,请稍后再试!");
                    randomImage();
                }
            }, "json");
        });
    });

    //刷新验证码图片
    function randomImage(){
        $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
    }

</script>
</body>
</html>