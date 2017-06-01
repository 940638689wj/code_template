<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">密码修改</span>
                </li>
            </ul>
        </div>
    </div>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/adminUser/changePassword" method="post">
    <div id="edit-div" class="form-content">

        <div class="row">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>原密码：</label>
                    <div class="controls">
                        <input class="control-text"  name="oldPassword" type="password" data-rules="{required:true}"  >
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>新密码：</label>
                    <div class="controls">
                        <input  class="control-text" name="password" type="password" id="f1" data-rules="{required:true}"  >
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>确认密码：</label>
                    <div class="controls">
                        <input class="control-text" name="confirmPassword" type="password" data-rules="{required:true,equalTo:'#f1'}"  >
                    </div>
                </div>
            </div>
    </div>
    <div class="actions-bar">
        <button type="submit" id="save" class="button button-primary">保存</button>
        <button type="reset" class="button">重置</button>
    </div>
    </form>
</div>
<script type="text/javascript">
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                }
            setTimeout("remainTime()",1200);
            }
        }).render();
        
		form.on('beforesubmit', function(){
			$("#save").attr('disabled',true);
	    });
    });
    
    function remainTime(){
        $("#save").attr('disabled',false);
    }
    
</script>
 </body>
 </html>