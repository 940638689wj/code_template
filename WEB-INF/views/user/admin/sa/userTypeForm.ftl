<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/userType/userTypeList">会员类型</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if userType?? && userType?has_content>编辑会员类型<#else>新增会员类型</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/userType/save" method="post">
        <div id="edit-div" class="form-content">
        	<input type="hidden" name="userTypeId" value="${(userType.userTypeId)!}"/>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员类型名称：</label>
                    <div class="controls">
                        <input value="${(userType.userTypeName)!}" name="userTypeName" data-rules="{maxlength:20}" class="input-large control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">是否启用：</label>
                    <div class="controls">
                        <#assign radioValue="1"/>
                        <#if userType?has_content && (userType.statusCd)?has_content && userType.statusCd == 0>
                            <#assign radioValue="0"/>
                        </#if>

                        <label class="radio">
                            <input type="radio" name="statusCd" value="1"
                                   <#if radioValue=="1">checked="checked" </#if>/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0"
                                   <#if radioValue=="0">checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                <label class="control-label">是否默认：</label>
                	<div class="controls">
	                    <#assign radioValue="1"/>
	                    <#if userType?has_content && (userType.isDefault)?has_content && userType.isDefault == 0>
	                        <#assign radioValue="0"/>
	                    </#if>
	
	                    <label class="radio">
	                        <input type="radio" name="isDefault" value="1"
	                               <#if radioValue=="1">checked="checked" </#if>/>是
	                    </label>
	                    &nbsp;&nbsp;
	                    <label class="radio">
	                        <input type="radio" name="isDefault" value="0"
	                               <#if radioValue=="0">checked="checked" </#if>/>否
	                    </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="remark" class="control-row4 input-large">${(userType.remark)!}</textarea>
                    </div>
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
                    app.showSuccess("保存成功！")
                    window.location.href = "${ctx}/admin/sa/userType/userTypeList";
                }
            }
        }).render();
    });
    
    //点击重置的时候也把图片给重置掉
	$('button[type="reset"]').click(function() {
		$("[name='statusCd'][value=1]").attr("checked","checked");
		$("[name='isDefault'][value=1]").attr("checked","checked");
	});
</script>
</body>
</html>  