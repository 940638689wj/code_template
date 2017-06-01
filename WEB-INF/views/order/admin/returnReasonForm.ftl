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
	        <li><a href="${ctx }/admin/sa/order/orderReturnReasonList">退货原因列表</a><span class="divider">&gt;&gt;</span></li>
	        <li class="active">编辑</li>
		</ul>
			<form id="J_Form" class="form-horizontal span24" action="${ctx}/admin/sa/order/editReturnInfo" method="post">
				<input type="hidden" name="codeId" <#if systemCode??> value="${systemCode.codeId!}" </#if>>
		   
		   <div class="control-group">
              <label class="control-label"><s>*</s>排序值：</label>
                <div class="controls">
		<input type="text" name="displayID" id="displayID" data-rules="{required:true}"<#if systemCode??> value="${systemCode.displayID!}"</#if> class="input-normal control-text"/>
             </div>
              </div>
              
              
              <div class="control-group">
              <label class="control-label">退换货原因：</label>
                <div class="controls">
                 <textarea class="input-large" type="text" name="codeCnName" id="codeCnName" <#if systemCode??>value="${systemCode.codeCnName!}"</#if>></textarea>
              </div>
             </div>
             	<div class="row form-actions actions-bar">
					<div class="span13 offset3">
						<button type="submit" class="button button-primary">保存</button>
						<button type="reset" class="button">重置</button>
					</div>
				</div>
			</form>
		</div>
	</div>
<script type="text/javascript">
  	 		BUI.use('bui/form',function (Form) {
			var form = new Form.HForm({
				srcNode : '#J_Form',
				submitType: 'ajax',
				dataType : 'json',
				callback: function (data) { 
				    if (data) {
 				    	BUI.Message.Alert('操作成功!',function(){
                             window.location.href='${ctx }/admin/sa/order/orderReturnReasonList';
                        });
				    }else{
				    	BUI.Message.Alert('排序已存在！','error');
				    }
				}
			});
		
			form.render();
		});
		      
         
		  
	
		  
</script>
</body>
</html>  