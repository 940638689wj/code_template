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
                    <div class="hd">会员名</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" id="userName" name="userName" value="${userName!}" ><span class="delete"></span></div>
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
     		var userName = $('#userName').val();
	    	if(userName==""){
	    		mui.toast("名字不能为空！");
	            return;
	    	}else if(userName.length > 50) {
	    		mui.toast("名字长度不能超过50！");
	            return;
	    	}
       		$.ajax({
	            type: "POST",
	            url: "${ctx}/m/shopper/save",
	            dataType: "json",
	            data: {userName:userName},
	            success: function(data) {
	            	if(data.result=='success'){
	            		window.location.href="${ctx}/m/shopper/personalData";
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