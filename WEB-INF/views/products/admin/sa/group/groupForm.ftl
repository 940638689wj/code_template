<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="breadcrumb" aria-disabled="false" aria-pressed="false">
                 <li aria-disabled="false" aria-pressed="false"><a href="${ctx}/admin/sa/group/list">商品分组管理</a><span class="divider">&gt;&gt;</span></li>
                 <li class="active"><#if productGroup?? && productGroup?has_content>编辑分组<#else>新增分组</#if></li>  
            </ul>
        </div>
    </div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/group/save" method="post">
    	<input type="hidden" name="productGroupId" value="${(productGroup.productGroupId)!}">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>分组名称：</label>
                    <div class="controls">
                        <input value="${(productGroup.groupName)!?html}" name="groupName" data-rules="{required:true,regexp:/^([\u4e00-\u9fa5]|[A-Za-z]|[0-9]){1,20}$/}" data-messages="{regexp:'请输入正确的分组名称！'}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>状态：</label>
                    <#assign groupStatusCd=0/>
	                <#if productGroup?? && productGroup?has_content && productGroup.statusCd == 1>
	                     <#assign groupStatusCd=1/>
	                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1" <#if groupStatusCd==1>checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0" <#if groupStatusCd==0>checked="checked" </#if>/>禁用
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

	// BUI框架提交保存
    $(function(){
        $("input[name='groupName']").on('keyup',function (){
            var _this = $("input[name='groupName']");
            var errorC = $(".x-field-error");
            _this.parent().find(".remoteError").remove();
            if(_this.val() !=null && _this.val() !="" && errorC !=undefined && errorC.length ==0){
                var errorStr ="<span class='x-field-error remoteError'><span class='x-icon x-icon-mini x-icon-error'>!</span><label class='x-field-error-text'>该名称已存在</label></span>";
                //不能为空！</label></span>';
                $.post("${ctx}/admin/sa/group/getGroupName",{"groupName":_this.val()},function (data){
                   if(data.result =="success"){
                       _this.parent().find(".remoteError").remove();
                       _this.parent().append(errorStr);
                       return false;
                   }else{
                       _this.parent().find(".remoteError").remove();
                   }
                });
            }
        });
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if(!data){
                    app.showError("保存失败！该名称已存在");
                    return false;
                }
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/group/list";
                }
            }
        });
        form.on('beforesubmit',function(){
            var errorC = $(".x-field-error");
            var errorE = $(".remoteError");
            if(errorC !=null && errorC.length !=0 || errorE !=null && errorE.length !=0){
                return false;
            }
        });
        form.render();
        

    });

    
</script>
</body>
</html>