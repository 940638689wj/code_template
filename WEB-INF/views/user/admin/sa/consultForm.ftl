<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/user/consult">咨询管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">咨询编辑</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/user/consult/updateConsult">
        <input value="${(consultDetail.consultID)!}" name="consultID" type="hidden">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">咨询Id：</label>
                    <div class="controls">
                        <label>${(consultDetail.consultID)!}</label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">产品名称：</label>
                    <div class="controls">
                        <label>${(consultDetail.productName)!?html}</label>
                    <#--<input value="${(consultDetail.product.defaultSku.name)!}" name="product.defaultSku.name" id="consultProductName" type="hidden">-->
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">会员名称：</label>
                    <div class="controls">
                        <label>${(consultDetail.loginName)!?html}</label>
                    <#--<input value="${(consultDetail.customer.username)!}" name="customer.username" id="customerName" type="hidden">-->
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">咨询时间：</label>
                    <div class="controls">
                        <label>${(consultDetail.createTime)?string('yyyy-MM-dd HH:mm:ss')}</label>
                    <#--<input value="${(consultDetail.consultSubmitDate)!}" name="consultSubmitDate" id="consultSubmitDate" type="text"
                           class="input-normal control-text" readonly>-->
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>咨询内容：</label>
                    <div class="controls  control-row-auto">
                        <textarea name="consultText" class="input-large" type="text">${(consultDetail.content)!}</textarea>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>状态：</label>
                    <div id="statusType" class="controls" data-rules="{required:true}">
                        <input type="hidden" id="status" value="${(consultDetail.consultStatusCd)!'0'}" name="consultStatusCd">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">回复内容：</label>
                    <div class="controls  control-row-auto">
                        <textarea name="consultReplyText" class="input-large" type="text">${(consultDetail.replyContent)!}</textarea>
                    </div>
                </div>
            </div>
        </div>

        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
</div>
<script type="text/javascript">
    $(function(){
        var Select = BUI.Select,
                Data = BUI.Data;
        var item = [{text:"审核中", value: "1"},{text:"审核通过", value: "2"},{text:"审核拒绝", value: "3"}];
        var select = new Select.Select({
            render:'#statusType',
            valueField:'#status',
            items: item
        });
        select.render();

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    window.location.href="${ctx}/admin/sa/user/consult";
                }
            }
        }).render();
    });
</script>
</body>
</html>