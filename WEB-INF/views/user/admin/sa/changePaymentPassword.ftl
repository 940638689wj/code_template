<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="content-body">
        <form id="b_Form" class="form-horizontal" action="${ctx}/admin/sa/user/changePaymentPassword" method="post">
        	<input type="hidden" name="userId" value="${userInfoDTO.userId}"/>

            <div class="form-content mb0">
                <div class="row">
                    <label class="control-label"><s>*</s>新支付密码：</label>
                    <div class="controls">
                        <input type="password" name="password" id="pwd" class="control-text">
                    </div>
                </div>
                <div class="row">
                    <label class="control-label"><s>*</s>重复支付密码：</label>
                    <div class="controls">
                        <input type="password" class="control-text" name="passwordNew" id="newPayPasswordConfirm1">
                    </div>
                </div>
            </div>
		    <div class="row form-actions actions-bar">
		        <div class="span13">
		            <button type="submit" class="button button-primary">保存</button>
		            <button type="reset" class="button">重置</button>
		        </div>
		    </div>
        </form>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function() {
        BUI.use('common/page');
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#b_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("密码修改成功！");
                    $("#pwd").val('');
                    $("#newPayPasswordConfirm1").val('');
                }
            }
        }).render();
        form.on('beforesubmit', function () {
        	var password = $("#pwd").val();
        	var rpassword = $("#newPayPasswordConfirm1").val();
        	var reg = new RegExp(/^\d{6}$/);
        	if(password==null && password==""){
        		app.showSuccess("请输入密码！");
        		return false;
        	}
        	if(!reg.test(password)){
        		app.showSuccess("请输入6位数字组成的密码！");
        		return false;
        	}
        	if(password!=rpassword){
        		app.showSuccess("两次输入的密码不一致！");
        		return false;
        	}
            return true;
        });
    });
</script>
</body>
</html>  