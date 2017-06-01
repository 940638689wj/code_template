<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>密码管理</title>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            	<h1 class="mui-title">密码管理</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
  <div class="borderbox">
  			
           <div class="orderinfo">
                <P>请输入新的密码</P>
            </div>
            <div class="pwd-box">
                <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
                <div class="fake-box">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                </div>
            </div>
    </div>
    <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
<script>
    $(function(){
        var $input = $(".fake-box input");
        $("#pwd-input").on("input", function() {
            var pwd = $(this).val().trim();
            for (var i = 0, len = pwd.length; i < len; i++) {
                $input.eq("" + i + "").val(pwd[i]);
            }
            $input.each(function() {
                var index = $(this).index();
                if (index >= len) {
                    $(this).val("");
                }
            });
            if (len == 6) {
                //执行其他操作
                 location.href="${ctx}/m/account/toPawCon?paw="+pwd;
            }
        });
    })
</script>
</body>
</html>