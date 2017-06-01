<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/userDefinedField">会员自定义信息</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if userDefinedField?has_content>编辑<#else>添加</#if>自定义信息</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/userDefinedField/save" method="post">
        <div id="edit-div" class="form-content">
            <input type="hidden" name="id" value="${(userDefinedField.id)!}"/>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>字段名称：</label>

                    <div class="controls">
                        <input value="${(userDefinedField.fieldName)!}" name="fieldName"
                               data-rules="{required:true,maxlength:30}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>字段类型：</label>

                    <div class="controls">
                        <select name="fieldTypeCd" id="fieldTypeCd">
                        <#list fieldTypeList as fieldType>
                            <option value="${fieldType.codeId!}"
                                    <#if userDefinedField?has_content && userDefinedField.fieldTypeCd+"" == fieldType.codeId>selected="selected"</#if>
                            >${fieldType.codeCnName!}</option>
                        </#list>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>排序值：</label>
                    <div class="controls">
                        <input value="${(userDefinedField.sortValue)!}" name="sortValue" id="sortValue" type="text"
                               data-rules="{required:true,maxlength:9,regexp: /^\+?[1-9]\d*$/}"
                               data-messages="{regexp:'请输入大于0的整数！'}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1"
                                   checked="checked"/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0"
                                   <#if userDefinedField?has_content && userDefinedField.statusCd == 0 >checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>是否必填：</label>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="isRequired" value="1"
                                   checked="checked"/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="isRequired" value="0"
                                   <#if userDefinedField?has_content && userDefinedField.isRequired == 0>checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="actions-bar">
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
                    window.location.href = "${ctx}/admin/sa/userDefinedField";
                }
            }
        }).render();

        /**
         * 重置按钮优化
         */
        $('button[type="reset"]').click(function () {
            $('input[name="statusCd"]:first').attr('checked', true);
            $('input[name="isRequired"]:first').attr('checked', true);
        <#if userDefinedField?has_content>
            <#if userDefinedField.statusCd == 0>
                $('input[name="statusCd"]:last').attr('checked', true);
            </#if>
            <#if userDefinedField.isRequired == 0>
                $('input[name="isRequired"]:last').attr('checked', true);
            </#if>
        </#if>
        });

    });
</script>
</body>
</html>