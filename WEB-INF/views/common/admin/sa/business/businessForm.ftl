<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                dataType: 'Json',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("业务信息保存成功！");
                        window.location.href = "${ctx}/admin/sa/common/businessconfig/typeList?flag=${flag?default("1")}";
                    }
                }
            }).render();
            
            // 重置后选择启用
	        $("button[type='reset']").click(function(){
	        	$("input[name='active']:first").attr("checked",true);
	        });
        });
    </script>
</head>
<body>
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="${ctx}/admin/sa/common/businessconfig/typeList?flag=${flag?default("1")}">业务列表</a> <span class="divider">&gt;&gt;</span></li>
            <li class="active">编辑业务参数</li>
        </ul>
        <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/common/businessconfig/updateBusiness" method="post">
            <input type="hidden" name="businessConfigTypeId" value="${(configType.businessConfigTypeId)!}"/>
            <div id="edit-div" class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label control-row-auto"><s>*</s>业务名称：</label>
                        <div class="controls">
                            <input value="${(configType.businessConfigTypeName)!?html}" name="name" data-rules="{required:true}" class="input-large control-text">
                        </div>
                    </div>
                </div>

                <#if businessConfigList?? && businessConfigList?has_content>
                    <#list businessConfigList as config>
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label control-row-auto">
                                    <#if config?has_content && config.isRequired?has_content && config.isRequired><s>*</s></#if>${(config.businessConfigKeyLabel)!?html}：
                                </label>
                                <div class="controls">
                                    <input type="hidden" name="configId" value="${(config.businessConfigId)!}">

                                    <#if config.businessConfigKey?? && config.businessConfigKey=="key_weixin_login">
                                        <label class="radio">
                                            <input type="radio" name="configValue" value="1" <#if config.businessConfigValue?? && config.businessConfigValue=="1">checked="checked" </#if>/>已开启
                                        </label>
                                        &nbsp;&nbsp;
                                        <label class="radio">
                                            <input type="radio" name="configValue" value="0" <#if config.businessConfigValue?? && config.businessConfigValue=="0">checked="checked" </#if>/>未开启
                                        </label>
                                    <#else>
                                        <input value="${(config.businessConfigValue)!?html}" name="configValue" <#if config?has_content && config.required?has_content && config.required?string=="true">data-rules="{required:true}"</#if> class="input-large control-text">
                                    </#if>
                                </div>

                                <#if config?has_content && config.remark?has_content>(${(config.remark)!})</#if>
                            </div>
                        </div>
                    </#list>
                </#if>

                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>状态：</label>
                        <#assign defaultStatus="0"/>
                        <#if configType?has_content && configType.isActive>
                            <#assign defaultStatus="1"/>
                        </#if>

                        <div class="controls">
                            <label class="radio">
                                <input type="radio" name="active" value="1" <#if defaultStatus=="1">checked="checked" </#if>/>启用
                            </label>
                            &nbsp;&nbsp;
                            <label class="radio">
                                <input type="radio" name="active" value="0" <#if defaultStatus=="0">checked="checked" </#if>/>禁用
                            </label>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-actions actions-bar">
                <div class="span13 offset3 ">
                    <button type="submit" class="button button-primary">保存</button>
                    <button type="reset" class="button">重置</button>
                </div>
            </div>
        </form>
    </div>
</body>
</html>