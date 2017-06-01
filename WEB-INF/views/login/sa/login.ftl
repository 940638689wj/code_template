<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>总部管理后台</title>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/theme-01.css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
	    <script>
        if (window.top!=window.self){
            var toUrl = '${ctx}/admin/sa/main.html';
            window.top.location.href = toUrl;
        }

        var randomUrl = "/randomCaptcha";

        $(function(){
            var systemDomObj = $("input[name='system']");
            if(systemDomObj){
                var system = systemDomObj.val();
                if(system){
                    randomUrl = "/randomCaptcha?system=" + system;
                }
            }
            $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
        });

         function RandomCode(){
            var newSrc = randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1));
            $("#randomImage").attr("src", newSrc);
        }

        $(function(){
            $('#sub').click(function(){
                var username=$('#username').val();
                var password=$('#password').val();
                var code=$('#randomCode').val();
                if(username==""){
                    $('#error').html("");
                    $('#error').append("<h1 style='font-size: 14px;color: red'>请输入用户名！</h1>");
                    return false;
                }
                if(password==""){
                    $('#error').html("");
                    $('#error').append("<h1 style='font-size: 14px;color: red'>请输入密码！</h1>");
                    return false;
                }
                if(code==""){
                    $('#error').html("");
                    $('#error').append("<h1 style='font-size: 14px;color: red'>请输入验证码！</h1>");
                    return false;
                }
                $('#jForm').submit();
            })
        })

        function keyLogin(){
            if(event.keyCode==13){
                $('#sub').click();
            }
        }
    </script>
</head>

<body class="page-login">
<div class="loginWrap">
    <div class="loginlogo"><img src="${ctx}/static/admin/images/system_text.png" alt="总部后台管理系统"></div>
    <div class="loginbox">
        <h1>欢迎登录</h1>
        <form method="POST" id="jForm" action="${ctx}/admin/sa/login_admin_post">
            <ul class="loginform">
                <li>
                    <div class="txt">
                        <input type="text" name="j_username" value="" id="username" autofocus="autofocus" placeholder="用户名">
                    </div>
                </li>
                <li>
                    <div class="txt">
                        <input type="password" name="j_password" id="password" placeholder="密码">
                    </div>
                </li>
                <li>
                    <div class="txt txt-vcode"><input type="text" name="randomCode" id="randomCode" placeholder="输入验证码"></div>
                    <div class="vcodebox"><div class="vcode"><img src="" id="randomImage" style="cursor: pointer;" onclick="RandomCode()"/></div></div>
                </li>
            </ul>

            <div class="loginbtn"><button id="sub">登录</button></div>
            <#if errorMsg?? && errorMsg?has_content>
                <div class="prompt-infor">${errorMsg!}</div>
            </#if>
        </form>
    </div>
</div>
<div class="copyright">Copyright ©2006 厦门逸锐信息科技有限公司</div>

</body>
</html>