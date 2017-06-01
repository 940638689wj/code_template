<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>修改个人资料</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userInfo"></a>
        <h1 class="mui-title">修改个人资料</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <div class="loginform">
            <ul>
                <li>
                    <div class="hd">昵称</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" value="${(nickName)!}" id="nickName"
                                                           name="nickName"><span class="delete"></span></div>
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
    $(function () {

        $("#submit").click(function () {
            $.post("${ctx}/m/account/userInfo/updateUser", {
                        nickName: $("#nickName").val()
                    },
                    function (data) {
                        if (data.result == "success") {
                            location.href = "${ctx}/m/account/userInfo";
                        }
                    }, "json");
        });

    });
</script>
</body>
</html>