<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html>
<head>
    <title>登录</title>
</head>
<body>

<div id="page" class="login">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	    	<a class="mui-icon"></a>
	        <h1 class="mui-title">登录</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="loginform loginlbd">
        	<input type="hidden" id="successUrl" name="successUrl" value="${successUrl!}">
            <ul>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" placeholder="请输入账号" name="loginName" id="loginName"><span class="delete"></span></div>
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
            </ul>
        </div>
        <div class="btnbar">
            <button class="mui-btn mui-btn-block mui-btn-primary"  id="doLogin">登录</button>
        </div>
    </div>
</div>

 <script type="text/javascript">
    $(function(){
        <#if message?? && message?has_content>mui.toast('${message!}');</#if>
        $("#doLogin").click(function(){
        	if(!$("#loginName").val()){
                mui.toast('请输入配送员名!');
                return false;
            }
            if(!$("#password").val()){
                mui.toast('请输入密码!');
                return false;
            }
            $.post("${ctx}/m/shopper/login/", {
            	loginName : $("#loginName").val(),
            	password : $("#password").val(),
            	successUrl : $("#successUrl").val()
            }, function(data){
                if(data && data.result == "true"){
                	if(data.successUrl){
                        window.location.href = data.successUrl;
                    }else{
                        window.location.href = "${ctx}/m/shopper";
                    }
                }else{
                    mui.toast(data.message || "登录失败,请稍后再试!");
                }
            }, "json");
        });
    });

</script>
</body>
</html>