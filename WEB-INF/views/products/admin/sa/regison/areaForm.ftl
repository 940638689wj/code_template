<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list">区域管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if area?has_content && area.id?has_content>编辑普通区域<#else>新增区域</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/regisonProductManage/save" method="post">
        <input type="hidden" name="id" value="${(area.id)!}"/>
        <div id="productOptionForm" class="form-content">
        	
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>区域名称：</label>
                    <div class="controls">
                        <input value="${(area.areaName)!}" name="areaName" id="areaName" type="text" data-rules="{required:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">排序值：</label>
                    <div class="controls">
                        <input value="${(area.sort)!}" name="sort" id="sort" type="text" data-rules="{min:0,number:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                <#if u?? && u?has_content>
                    <label class="control-label">上级：</label>
                       <div class="controls">
            				<select name="countyId" id="countyId">
			            		<option value="">选择区/县</option>
			            		<#if upperList?? && upperList?has_content>
			                	<#list upperList as upper>
			                    <option value="${(upper.id)!}" <#if area??&&area?has_content><#if upper.id==parentAreaId>selected="selected"</#if></#if>>${(upper.areaName)!}</option>
			                	</#list>
			            		</#if>
							</select>
					 	</div>
				</#if>
					 	<#if i?? && i?has_content>
						   	<div class="controls">
								 <select name="town" id="town">
						            <option value="">选择镇</option>
						        </select>
						   	</div>
						</#if>
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
	// BUI框架提交保存
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/regisonProductManage/list";
                }else{
                	//app.showFailure("保存失败！");
                }
            }
        }).render();
        
        
       $("#countyId").on('change', function(){
	            var countyId = $(this).val();
	            $("#countyId").val(countyId);
	            if(countyId!=null && countyId!=""){
	                $.ajax({
	                    url : '${ctx}/admin/sa/regisonProductManage/findChildByParentId',
	                    dataType : 'json',
	                    type: 'GET',
	                    data : {parentId: countyId},
	                    success : function(data){
	                        if(data.rowCount!=null && data.rowCount >0){
	                            cleanSelectContent("town", "选择镇");
	                            $.each(data.rows, function(i, row){
	                                $("#town").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
	                            });
	                        }else{
	                            cleanSelectContent("town", "选择镇");
	                        }
	                    }
	                });
	            }else{
	                $('#town').empty();
	                cleanSelectContent("town", "选择镇 ");
	            }
	        });
	   function cleanSelectContent(selectId, remark){
	        $('#'+selectId+'').empty();
	        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
	    }
    });
    
</script>
</body>
</html>