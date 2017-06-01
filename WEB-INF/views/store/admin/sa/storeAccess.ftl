<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
   <#include "${ctx}/includes/sa/header.ftl"/>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    
    <form id="changePassword_Form" class="form-horizontal" action="${ctx}/admin/sa/userStore/password/changePassword" method="post">
          	  <input type="hidden" id="storeId" name="storeId" value="${store.storeId}">
            <div id="edit-div" >
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>新密码：</label>
                        <div class="controls">
                            <input  name="loginPassword" type="password" id="loginPassword" class="control-text" data-rules="{required:true}"  >
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>重复输入新密码：</label>
                        <div class="controls">
                            <input name="newPasswordConfirm" id="newPasswordConfirm" class="control-text" type="password" data-rules="{required:true,equalTo:'#loginPassword'}"  >
                        </div>
                    </div>
                </div>
            </div>
            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
    </form>
</body>
<script type="text/javascript">
 		  $(function(){
		        var Form = BUI.Form
		        var form = new Form.Form({
		            srcNode: '#changePassword_Form',
		            submitType: 'ajax',
		            callback: function (data) {
		                if (app.ajaxHelper.handleAjaxMsg(data)) {
		                    app.showSuccess("保存成功！")
		                    $("#loginPassword").val('');
		                    $("#newPasswordConfirm").val('');
		                }
		            }
		        }).render();

    	});
</script>
</body>
</html>  