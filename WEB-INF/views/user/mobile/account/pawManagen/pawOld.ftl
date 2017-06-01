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
                <P>请输入原来的密码</P>
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
            <div class="mui-content-padded">
                <P class="forger">忘记支付密码？<a href="${ctx}/m/account/toForgetPaw">快速找回</a></P>
            </div>
            <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
  <script>
    $(function(){
    	var paw='${(paw)!'0'}';
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
                if(paw==pwd){
                	location.href="${ctx}/m/account/toPawNew";
                }else{
                	mui.toast('密码错误');
                }
            }
        });
    })
</script>
</body>
</html>