<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/entityCard?cardTypeCd=${cardTypeCd!}"><#if cardTypeCd == 1>
            现金卡<#elseif cardTypeCd == 2>积分卡</#if></a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if entityCard?has_content>编辑<#else>添加</#if><#if cardTypeCd == 1>现金卡<#elseif cardTypeCd == 2>积分卡</#if></li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/entityCard/save" method="post">
        <div id="edit-div" class="form-content">
            <input type="hidden" name="id" value="${(entityCard.id)!}"/>
            <input type="hidden" name="cardTypeCd" value="${(cardTypeCd)!}"/>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>

                    <div class="controls">
                        <input value="${(entityCard.name)!}" name="name" id="name"
                               data-rules="{required:true,maxlength:30}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">描述：</label>

                    <div class="controls">
                        <textarea value="${(entityCard.description)!}" name="description" id="description"
                                  data-rules="{maxlength:255}"
                                  class="input-normal control-row1"></textarea>
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
                                   <#if entityCard?has_content && entityCard.statusCd == 0 >checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>有效使用日期：</label>
                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                    <input name="start" id="start" data-tip="{text : '起始日期'}" data-rules="{required:true}"
                           <#if entityCard?has_content>value="${(entityCard.startDate)!?date}"</#if>
                           data-messages="{required:'起始日期不能为空'}" class="input-small calendar" type="text"><label>&nbsp;至&nbsp;</label>
                    <input name="end" id="end" data-tip="{text : '结束日期'}" data-rules="{required:true}"
                           <#if entityCard?has_content>value="${(entityCard.endDate)!?date}"</#if>
                           data-messages="{required:'结束日期不能为空'}" class="input-small calendar" type="text">
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>生成数量：</label>
                    <div class="controls">
                        <input value="${(entityCard.cardCodeNum)!}" name="cardCodeNum" id="cardCodeNum" type="text"
                               data-rules="{required:true,maxlength:9,regexp: /^\+?[1-9]\d*$/}"
                               data-messages="{regexp:'请输入大于0的整数！'}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>积分：</label>
                    <div class="controls">
                        <input value="${(entityCard.value)!}" name="value" id="value" type="text"
                               data-rules="{required:true,number:true,min:0.01,max:999999999}"
                               class="input-normal control-text"/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>卡号前缀：</label>
                    <div class="controls">
                        <input value="${(entityCard.cardCodePrefix)!}" name="cardCodePrefix" id="cardCodePrefix"
                               type="text"
                               data-rules="{required:true,maxlength:255}"
                               <#if entityCard?has_content>disabled="disabled"</#if>
                               class="input-normal control-text"/>&nbsp;&nbsp;&nbsp;&nbsp;卡号前缀设置后不允许再修改!
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
                    window.location.href = "${ctx}/admin/sa/entityCard?cardTypeCd=" + "${cardTypeCd!}";
                }
            }
        }).render();

        /**
         * 重置按钮优化
         */
        $('button[type="reset"]').click(function () {
            $('#description').html('${(entityCard.description)!}');
            $('input[name="statusCd"]:first').attr('checked', true);
        <#if entityCard?has_content && entityCard.statusCd == 0 >
            $('input[name="statusCd"]:last').attr('checked', true);
        </#if>

        });

    });
</script>
</body>
</html>