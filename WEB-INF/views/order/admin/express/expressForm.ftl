<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>

    <script src="${staticPath}/js/printOrder.js"></script>
</head>
<body>
<div class="container">
    <div class="row">
        <ul class="breadcrumb">
            <li><a href="${ctx}/admin/sa/order/express/expressList">设置物流</a><span class="divider">&gt;&gt;</span>
            </li>
            <li class="active"><#if express?has_content>编辑<#else>添加</#if>物流</li>
        </ul>
        <form id="J_Form" class="form-horizontal span24" action="${ctx}/admin/sa/order/express/addOrEditExpress"
              method="post">
            <input type="hidden" name="expressId" value="${(express.expressId)!}">
            <div class="control-group">
                <label class="control-label"><s>*</s>快递名称：</label>
                <div class="controls">
                    <input type="text" name="expressName" id="expressName" data-rules="{required:true}"
                           value="${(express.expressName)!}" class="input-normal control-text"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>快递编码：</label>
                <div class="controls">
                    <input type="text" name="expressCode" id="expressCode" value="${(express.expressCode)!}"
                           data-rules="{required:true}" class="input-normal control-text"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>外部Id：</label>
                <div class="controls">
                    <input type="text" name="outId" id="outId" value="${(express.outId)!}" data-rules="{required:true}"
                           class="input-normal control-text"/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>运费模板：</label>
                <div class="controls">
                    <select name="expressTemplateId" id="expressTemplateId" data-rules="{required:true}">
                        <option value="">请选择</option>
                    <#list expressTemplates as expressTemplate>
                        <option value="${expressTemplate.templateId!}"
                            <#if express?has_content && express.expressTemplateId == expressTemplate.templateId>
                                selected="selected" </#if>>${expressTemplate.templateName!}</option>
                    </#list>
                    </select>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>状态：</label>
                <div class="controls bui-form-group" data-rules="{checkRange:1}" data-messages="{checkRange:'至少勾选一项！'}">
                    <label class="radio">
                        <input type="radio" name="expressStatusCd" value="1" checked="checked"/>启用
                    </label>
                    &nbsp;&nbsp;
                    <label class="radio">
                        <input type="radio" name="expressStatusCd" value="0"
                               <#if express?has_content && express.expressStatusCd == 0>checked="checked"</#if>/>禁用
                    </label>
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
<script type="text/javascript">
    BUI.use('bui/form', function (Form) {
        var form = new Form.HForm({
            srcNode: '#J_Form',
            submitType: 'ajax',
            dataType: 'json',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("操作成功");
                    window.location.href = '${ctx }/admin/sa/order/express/expressList';
                }
            }
        });
        form.render();
    });


</script>
</body>
</html>  