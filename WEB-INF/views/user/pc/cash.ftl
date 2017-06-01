<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>账户提现</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
</head>
<body class="page-login">
<#include "include/header.ftl"/>
<div id="page">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>我的钱包<span><em>_</em>账户提现</span></h3></div>
                <div class="nodata-content">
                    账户提现模块正在开发，请敬请期待……
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#menu_cash").addClass("current");
        $(".card-box").on('click', function () {
            $(this).toggleClass('flipped');
        });
    });
</script>
</body>
</html>