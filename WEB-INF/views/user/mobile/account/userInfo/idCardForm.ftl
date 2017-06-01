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
                <li class="input-wrap">
                	<div class="hd">身份证号</div>
                    <div class="bd">
                    	<input type="text" id="idCard" name="idCard"<#--placeholder=""--> value="${identityId!}" maxlength="18">
                    </div>
                    <span class="delete"></span>
                </li>
            </ul>
            <div class="mui-content-padded mt30 align-center">
                <button id="saveBtn" class="mui-btn mui-btn-primary mui-btn-block mb20">保存</button>
            </div>
        </div>
    </div>

<script type="text/javascript">
    $("#saveBtn").click(function() {
    	var idCard = $('#idCard').val();
    	var reg = /^(\d{15}$|^\d{18}$|^\d{17}(\d|X|x))$/;
    	if(!reg.test(idCard)){
    		mui.toast("身份证不正确！");
            return;
    	}
       		$.ajax({
	            type: "POST",
	            url: "${ctx}/m/account/info/save",
	            dataType: "json",
	            data: {idCard:idCard},
	            success: function(data) {
	            	if(data.result=='success'){
	            	//	mui.toast("保存成功!");
	            		window.location.href="${ctx}/m/account/info/personalData";
	            	}
	            }
        });
     });
     $(function(){
        $(".input-wrap").each(function () {
            var wrap = $(this),
                    input = wrap.find("input"),
                    del = wrap.find(".delete");
            del.on("click", function () {
                input.val("").focus();
                del.hide();
            });
            input.on("input propertychange", function () {
                if($.trim(this.value) != ""){
                    del.show();
                }else{
                    del.hide();
                }
            });
        });
    });
  	var submitBtn = function (){
    		$('#saveBtn').click();
    	}
    
</script>
</body>
</html>