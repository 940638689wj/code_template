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
                    <div class="hd">性别</div>
                    <div class="bd">
                        <div class="info gender">
                            <div class="input-wrap">
                                <select id="sexCd" name="sexCd">
                                    <option value="0" <#if sexCd==0>selected="selected"</#if>>男</option>
                                    <option value="1" <#if sexCd==1>selected="selected"</#if>>女</option>
                                </select>
                            </div>
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
$(function(){
	
	$("#submit").click(function(){
		$.post("${ctx}/m/account/userInfo/updateUser", {
	    		sexCd : $("#sexCd").val()
	    	},
	    	function(data){
	    		if(data.result=="success"){
				    location.href = "${ctx}/m/account/userInfo";
	    		}
	    	},"json");
	});
		
});
</script>
</body>
</html>