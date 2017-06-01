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
	            <a class="mui-icon" ></a>
	        </header>
	    </#if>
        <div class="mui-content">
            <ul class="tbviewlist">
                <li class="input-wrap">
                	<div class="hd">出生日期</div>
                    <div class="bd">
                    	<input type="text" class="calendar control-text" name="birthday" id="birthday" placeholder="1999-01-01" value="${birthday!}" />
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
    var birthday = $("#birthday").val();
      if(birthday==""){mui.toast("请填写生日！"); return;}
      
       if(!checkDate(birthday)){return;}
       		$.ajax({
	            type: "POST",
	            url: "${ctx}/m/account/info/save",
	            dataType: "json",
	            data: {birthday:birthday},
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
    	

var DATE_FORMAT =  /^(\d{4})-(0\d{1}|1[0-2])-(0\d{1}|[12]\d{1}|3[01])$/;
function checkDate(birthday){
 if(DATE_FORMAT.test(birthday)){
   return true;
  } else {
    mui.toast("生日格式不正确！"); return;
  }
  }
     	
</script>
</body>
</html>