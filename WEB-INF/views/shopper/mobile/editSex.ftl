<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑个人资料</title>
</head>
<body>
	<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/personalData"></a>
	        <h1 class="mui-title">编辑个人资料</h1>
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
                                <select id="sex" name="sex">
                                    <option value="0" <#if sex=="0">selected="selected"</#if>>男</option>
                                    <option value="1"  <#if sex=="1">selected="selected"</#if>>女</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="btnbar">
            <button id="saveBtn" class="mui-btn mui-btn-block mui-btn-primary">提交</button>
        </div>
    </div>
</div>

<script type="text/javascript">
    $("#saveBtn").click(function() {
       		$.ajax({
	            type: "POST",
	            url: "${ctx}/m/shopper/save",
	            dataType: "json",
	            data:{sex:$("#sex").val()},
	            success: function(data) {
	            	if(data.result=='success'){
	            		window.location.href="${ctx}/m/shopper/personalData";
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