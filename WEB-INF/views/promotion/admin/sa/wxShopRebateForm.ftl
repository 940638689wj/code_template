<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
    	<li><a href="${ctx}/admin/sa/userPromotion/wxRebate">微店返利设置</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew??&&isNew>编辑返利规则<#else>新加返利规则</#if></li>
    </ul>
    <div class="actions-bar"></div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/userPromotion/save/orgRebate" method="post">
        <input type="hidden" name="largeAreaId" id="largeAreaId" value="<#if orgRebate??&&orgRebate?has_content>${orgRebate.largeAreaOrgId!}</#if>" />
        <input type="hidden" name="BranchId" id="BranchId" value="<#if orgRebate??&&orgRebate?has_content>${orgRebate.branchCompanyOrgId!}</#if>" />
        <input type="hidden" name="officeId" id="officeId" value="<#if orgRebate??&&orgRebate?has_content>${orgRebate.officeOrgId!}</#if>" />
    <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                <label>大区：</label>
                	<select style="width:100px" id="selectLargeArea">
        				<option value="">选择大区</option>
        			<#if largeAreaList?? && largeAreaList?has_content>
        				<#list largeAreaList as largeArea>
        				<option value="${largeArea.orgId}" id="lar_${largeArea.orgId}">${largeArea.orgFullName}</option>
        			</#list>
        			</#if>
        			</select>
        		<label>分公司：</label>
        			<select style="width:100px" id="selectBranch">
        		<option value="">选择分公司</option>
        			</select>
        		<label>办事处：</label>
        			<select style="width:100px" id="selectOffice">
        		<option value="">选择办事处</option>
        			</select>
                <input type="button" id="btnOrg" value="添加" style="width:60px" />
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                   <div class="content-body" style="width:300px;">
                		<table cellspacing="0" class="table table-bordered">
                    		<thead>
                    			<tr>
                        			<th>大区</th>
                        			<th>分公司</th>
                        			<th>办事处</th>
                    			</tr>
                    		</thead>
                        		<tr>
		                            <td id="selectLargeAreaShow"><#if orgRebate??&&orgRebate?has_content>${orgRebate.largeAreaOrgFullName}<#else>-</#if></td>
		                            <td id="selectBranchShow"><#if orgRebate??&&orgRebate?has_content>${orgRebate.branchCompanyOrgFullName}<#else>-</#if></td>
		                            <td id="selectOfficeShow"><#if orgRebate??&&orgRebate?has_content>${orgRebate.officeOrgFullName}<#else>-</#if></td>
                        		</tr>
                		</table>
            	</div>
              </div>
            </div>
            <div class="row" style="padding-top:30px;">
                <div class="control-group">
                    <label>有效时间：</label>
					<input type="text" class="calendar control-text" name="startDate" id="startDate" value="${((orgRebate.startDate)?string("yyyy-MM-dd"))!}" /> 至 <input type="text" class="calendar control-text" name="endDate" id="endDate" value="${((orgRebate.endDate)?string("yyyy-MM-dd"))!}" /> 
                </div>
            </div>
			<div class="row" style="padding-top:30px;">
				<div class="control-group">
					<label>佣金比例：</label>
					<input type="text" class="input-small control-text" data-rules="{required:true,regexp:/^-?\d+(\.\d+)?$/}" data-messages="{regexp:'输入不正确'}" name="rebatePercent" id="rebatePercent" value="${(orgRebate.rebatePercent)!}" />&nbsp;%
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
        $("#selectLargeArea").on('change', function(){
            var selectLargeArea = $(this).val();
            $("#largeAreaId").val(selectLargeArea);
            if(selectLargeArea && selectLargeArea != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/org/findChildOrgList',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectLargeArea},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectBranch", "选择分公司");
                            cleanSelectContent("selectOffice", "选择办事处");
							
                            $.each(data.rows, function(i, row){
                                $("#selectBranch").append("<option value='"+row.orgId+"' id='branch_"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectBranch", "选择分公司");
                            cleanSelectContent("selectOffice", "选择办事处");
                        }
                    }
                });
            }else{
                $('#selectBranch').empty();
                cleanSelectContent("selectBranch", "选择分公司");
                cleanSelectContent("selectOffice", "选择办事处");
            }
        });
        
        $("#selectBranch").on('change', function(){
            var selectBranch = $(this).val();
            $("#BranchId").val(selectBranch);
            if(selectBranch && selectBranch != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/org/findChildOrgList',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectBranch},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectOffice", "选择办事处");

                            $.each(data.rows, function(i, row){
                                $("#selectOffice").append("<option value='"+row.orgId+"' id='office_"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectOffice", "选择办事处");
                        }
                    }
                });
            }else{
                $('#selectOffice').empty();
                cleanSelectContent("selectOffice", "选择办事处");
            }
        });
        
        $("#selectOffice").on('change', function(){
            $("#officeId").val($(this).val());
        });
        
        
        function cleanSelectContent(selectId, remark){
        	$('#'+selectId+'').empty();
        	$('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    		}
    		
    	$("#btnOrg").click(function(){
    		var selectLargeArea = $('#selectLargeArea').val();
    		var selectBranch = $('#selectBranch').val();
    		var selectOffice = $('#selectOffice').val();
    		if(selectLargeArea!="" && selectLargeArea!=null){
    			var selectLargeAreaHtml = $("#lar_"+selectLargeArea).html();
    			$('#selectLargeAreaShow').html(selectLargeAreaHtml);
    		}
    		else{
    			$('#selectLargeAreaShow').html("-");
    		}
    		if(selectBranch!="" && selectBranch!=null){
    			var selectBranchHtml = $("#branch_"+selectBranch).html();
    			$('#selectBranchShow').html(selectBranchHtml);
    		}
    		else{
    			$('#selectBranchShow').html("-");
    		}
    		if(selectOffice!="" && selectOffice!=null){
    			var selectOfficeHtml = $("#office_"+selectOffice).html();
    			$('#selectOfficeShow').html(selectOfficeHtml);
    		}else{
    			$('#selectOfficeShow').html("-");
    		}
    	});
    });

	    $(function(){
	        var Form = BUI.Form
	        var form = new Form.Form({
	            srcNode: '#J_Form',
	            submitType: 'ajax',
	            callback: function (data) {
	                if (app.ajaxHelper.handleAjaxMsg(data)) {
	                    app.showSuccess("保存成功！")
	                    setTimeout("window.location.href='${ctx}/admin/sa/userPromotion/wxRebate'",1000);  
	                }
	            }
	        }).render();
        
        form.on('beforesubmit', function(){
        	var largeArea = $('#selectLargeAreaShow').html();
        	var branch = $('#selectBranchShow').html();
        	var office = $('#selectOfficeShow').html();
        	var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;;
        	if(largeArea=="-"||largeArea==""||branch=="-"||branch==""||office=="-"||office==""){
        		BUI.Message.Alert("请添加区域");
        		return false;
        	}
        	var startDate=$("#startDate").val();
            var endDate=$("#endDate").val();
            var rebatePercent=$("#rebatePercent").val();
	            if(startDate =="" || startDate==null){
	                    BUI.Message.Alert("开始时间不能为空");
	                    return false;
	            }
                if(endDate =="" || endDate==null){
                    BUI.Message.Alert("结束时间不能为空");
                    return false;
                }

            if(endDate !="" && startDate !=""){
                var start_=new Date(startDate.replace("-", "/").replace("-", "/"));
                var end_=new Date(endDate.replace("-", "/").replace("-", "/"));
                var now =new Date();

                if(start_ > end_){
                    BUI.Message.Alert("结束时间不得小于开始时间!");
                    return false;
                }
                if(now > end_){
                    BUI.Message.Alert("结束时间不得小于当前时间!");
                    return false;
                }
                if(rebatePercent==""){
                    BUI.Message.Alert("佣金比例不能为空");
                    return false;
                }
                if(!exp.test(rebatePercent)){
                    BUI.Message.Alert("佣金请填写数字!");
                    return false;
                }
            }	
        	
        });
    });
</script>
 </body>
 </html>