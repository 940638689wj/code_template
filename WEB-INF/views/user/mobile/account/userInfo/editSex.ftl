<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <meta charset="UTF-8">
    <title>编辑个人资料</title>
</head>
<body>
    <div id="page">
    	<#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	       		 <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/info/personalData"></a>
	            <h1 class="mui-title">编辑个人资料</h1> 
	            <a class="mui-icon"></a> 
	        </header>
	    </#if>
        <div class="mui-content">
            <ul class="tbviewlist">
                <li class="input-wrap1">
                	<div class="hd">性别</div>
                    <div class="bd">
                    	<input type="radio" value="0" id="sex" name="sex" checked="checked"<#if sex=="0">checked</#if>/>男
                    	<input type="radio" value="1" id="sex" name="sex"<#if sex=="1">checked</#if>/>女
                    </div>
                </li>
            </ul>
            <div class="mui-content-padded mt30 align-center">
                <button id="saveBtn" class="mui-btn mui-btn-primary mui-btn-block mb20">保存</button>
            </div>
        </div>
    </div>

<script type="text/javascript">
    $("#saveBtn").click(function() {
       		$.ajax({
	            type: "POST",
	            url: "${ctx}/m/account/info/save",
	            dataType: "json",
	            data:{sex:$("input[type='radio']:checked").val()},
	            success: function(data) {
	            	if(data.result=='success'){
	            	//	mui.toast("保存成功!");
	            		window.location.href="${ctx}/m/account/info/personalData";
	            	}
	            }
        });
     });  
    var submitBtn = function (){
    		$('#saveBtn').click();
    	}
</script>
</body>
</html>