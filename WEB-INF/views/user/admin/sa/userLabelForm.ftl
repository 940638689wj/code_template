<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/userLabel/userLabelList"></a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if userLabel?? && userLabel?has_content>编辑会员标签<#else>新增会员标签</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/userLabel/save" method="post">
        <div id="edit-div" class="form-content">
            <input type="hidden" name="id" value="${(userLabel.id)!}"/>
        	<input type="hidden" name="userId" value="${(userId)!}"/>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>标签名称：</label>
                    <div class="controls">
                        <input value="${(userLabel.name)!}" name="name" data-rules="{maxlength:20}" class="input-large control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">是否启用：</label>
                    <div class="controls">
                        <#assign radioValue="1"/>
                        <#if userLabel?has_content && (userLabel.statusCd)?has_content && userLabel.statusCd == 0>
                            <#assign radioValue="0"/>
                        </#if>

                        <label class="radio">
                            <input type="radio" name="statusCd" value="1"
                                   <#if radioValue=="1">checked="checked"</#if> />是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0"
                                   <#if radioValue=="0">checked="checked" </#if>/>否
                        </label>
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

<script type="text/javascript">
    $(function () {
       var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    if(data.userId==null){
                    	window.location.href = "${ctx}/admin/sa/userLabel/userLableList";
                    }else{
                    	window.location.href = "${ctx}/admin/sa/user/userList";
                    }
                }
            }
        }).render();
    });
    

	$('button[type="reset"]').click(function() {
		$("[name='statusCd'][value=1]").attr("checked","checked");
		
	});
</script>
</body>
</html>  