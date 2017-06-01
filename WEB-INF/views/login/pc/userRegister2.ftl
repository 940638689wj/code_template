<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>注册</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body>
<div id="main">
    <div class="reg-step">
        <ul>
            <li class="current"><div class="step"><i class="icon-one"></i><p>设置账号</p></div></li>
            <li class="current"><div class="step"><i class="icon-two"></i><p>完成</p></div></li>
        </ul>
    </div>

    <div class="reg-form">
        <div class="pageinfo">
            <div class="infotitle"><s class="ico ico-success"></s>恭喜您成功注册！</div>
            <#--<div class="infotitle"><s class="ico ico-error"></s>恭喜您成功注册！</div>-->
            <div class="infocontent">
                <p><span id="time"></span>秒后自动返回登录页面</p>
                <p><a class="link" href="${ctx}/login">无法返回点击这里</a></p>
            </div>
        </div>
    </div>
    <#--<div class="pageinfo">-->
        <#--<div class="infotitle"><s class="ico ico-success"></s>恭喜您成功注册！</div>-->
        <#--<div class="infocontent">-->
            <#--<br/>-->
            <#--<p><span id="time"></span>秒后自动返回登录页面</p>-->
            <#--<p><a class="link" href="${ctx}/login">无法返回点击这里</a></p>-->
        <#--</div>-->
    <#--</div>-->
</div>
<script>
    $(function(){
        var times = 3 ;
        var timer = setInterval(function () {
            if (--times <= 0) {
                window.location.href = "${ctx}/login";
            } else {
                $("#time").html(times);
            }
        }, 1000);
    });
</script>
</body>
</html>