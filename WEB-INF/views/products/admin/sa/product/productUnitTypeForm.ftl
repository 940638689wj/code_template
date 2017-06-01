<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">	
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/productManage/unitTypeList">商品单位维护</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">新建商品单位</li>
    </ul>
 <form id="J_Form" name="J_Form" class="form-horizontal" action="${ctx}/admin/sa/productManage/unit/save" method="post"> 
     <div class="form-content">
			<div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>单位编码</label>
                    <div class="controls">             
                    	<input type="text" id="unitEnName" name="unitEnName" value="" data-rules="{required:true}"  class="input-normal control-text" placeholder="请输入单位编码">    
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>单位名称</label>
                    <div class="controls">             
                    	<input type="text" id="unitCnName" name="unitCnName" value="" data-rules="{required:true}"  class="input-normal control-text" placeholder="请输入单位名称">    
                    </div>
                </div>
            </div>
		    <div class="actions-bar">
		        <button type="submit" class="button button-primary">保存</button>
		        <button type="reset" class="button">重置</button>
		    </div>
	
</form>
		
<script type="text/javascript">
	$(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    app.page.open({
                        href:"${ctx}/admin/sa/productManage/unitTypeList",
                        isClose: true,
                        reload: true
                    })
                }
            }
        }).render();
    });
</script>