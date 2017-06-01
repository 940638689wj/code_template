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
                <P>请再次输入密码</P>
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
                if(paw!=pwd){
                	var btnArray = ['确认'];
		    		mui.alert('', '两次密码输入不一致，请重新设置!', btnArray, function(e) {
		            		location.href="${ctx}/m/account/toPawManagen";
		            	});
                }else{
                	$.post('${ctx}/m/account/setPaw',{paw:paw},function(data){
                		if(data){
                			mui.alert('', '设置成功', btnArray, function(e) {
		            		location.href="${ctx}/m/account/toPawManagen";
		            	});
                		}else{
                			mui.tosta('设置失败');
                		}
                	});
                }
            }
        });
    })
</script>
</body>
</html>