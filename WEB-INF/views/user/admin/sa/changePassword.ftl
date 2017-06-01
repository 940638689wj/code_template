<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="content-body">
        <form id="a_Form" class="form-horizontal" action="${ctx}/admin/sa/user/changePassword" method="post">
        	<input type="hidden" name="userId" value="${userInfoDTO.userId}"/>

            <div class="form-content mb0">
                <div class="row">
                    <label class="control-label"><s>*</s>新密码：</label>
                    <div class="controls">
                        <input type="password" name="password" id="f1"
                               data-rules="{required:true,minlength:6,passwordRule:true}" class="control-text">
                    </div>
                </div>
                <div class="row">
                    <label class="control-label"><s>*</s>重复密码：</label>
                    <div class="controls">
                        <input type="password" class="control-text" name="passwordNew"
                               data-rules="{required:true,equalTo:'#f1',minlength:6,passwordRule:true}" id="newPayPasswordConfirm">
                    </div>
                </div>
            </div>
		    <div class="row form-actions actions-bar">
		        <div class="span13">
		            <button id="save" type="submit" class="button button-primary">保存</button>
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
        var Form = BUI.Form;
        Form.Rules.add({
            name: 'passwordRule',  //规则名称
            msg: '请输入6至12位数字加字母的组合!',//默认显示的错误信息
            validator: function (value, baseValue, formatMsg, group) { //验证函数，验证值、基准值、格式化后的错误信息、goup控件
                if (!(/^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$/.test(value))) {
                    return formatMsg;
                }
                return false;
            }
        });
        var form = new Form.Form({
            srcNode: '#a_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("密码修改成功！");
                    $("#f1").val('');
                    $("#newPayPasswordConfirm").val('');
                }
            }
        }).render();
        form.on('beforesubmit', function () {
            return true;
        });
    })
</script>
</body>
</html>  