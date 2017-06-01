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
			<div id="tab">			
			</div>
		<!-- ul class="breadcrumb">
	        <li><a href="${ctx }/admin/sa/order/orderReturnReasonList">退货地址</a><span class="divider">&gt;&gt;</span></li>
	        <li class="active"></li>
		</ul -->
			<form id="J_Form" class="form-horizontal span24" action="${ctx}/admin/sa/order/setReturnInfoArea" method="post">
				<input type="hidden" name="id" <#if orderReturnName??> value="${orderReturnName.configId!}" </#if>>
		   
		   <div class="control-group">
              <label class="control-label"><s>*</s>收货人：</label>
                <div class="controls">
			<input type="text" name="orderReturnName"  data-rules="{required:true}"<#if orderReturnName??> value="${orderReturnName.configValue!}"</#if> class="input-normal control-text"/>
             </div>
              </div>

                <div class="control-group">
                    <label class="control-label"><s>*</s>所在地区：</label>
                    <div class="controls">
                        <select name="orderReturnProvince" id="orderReturnProvince" data-rules="{required:true}">
                            <option value="" >请选择</option>
							<#if provinces?has_content>
							<#list provinces as province>
                                <option value="${province.id}"<#if orderReturnProvince?has_content && orderReturnProvince.configValue == province.id?string>selected</#if>>${province.areaName}</option>
							</#list>
							</#if>
                        </select>
                        <select name="orderReturnCity" data-rules="{required:true}" id="orderReturnCity">
                            <#if citys?has_content>
                                <#list citys as city>
                                    <option value="${city.id}"<#if orderReturnCity?has_content && orderReturnCity.configValue == city.id?string>selected</#if> >${city.areaName}</option>
                                </#list>
                            </#if>
                        </select>
                        <select name="orderReturnArea" id="orderReturnArea" data-rules="{required:true}">
                            <#if areas?has_content>
                                <#list areas as area>
                                    <option value="${area.id}"<#if orderReturnArea?has_content && orderReturnArea.configValue == area.id?string>selected</#if> >${area.areaName}</option>
                                </#list>
                            </#if>
                        </select>
					</div>
                </div>
                <div class="control-group">
                    <label class="control-label"><s></s></label>
                    <div class="controls">
                        <input type="text" placeholder="详细地址" <#if orderReturnAddressExtend??> value="${orderReturnAddressExtend.configValue!}"</#if> name="orderReturnAddressExtend"  data-rules="{required:true}" class="input-normal control-text"/>
                    </div>
                </div>


                <div class="control-group">
                    <label class="control-label"><s>*</s>电话：</label>
                    <div class="controls">
                        <input type="text" name="orderReturnPhone"  <#if orderReturnPhone??> value="${orderReturnPhone.configValue!}"</#if> data-rules="{required:true}" class="input-normal control-text"/>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label"><s>*</s>邮政编码：</label>
                    <div class="controls">
                        <input type="text" name="orderReturnPostcode" <#if orderReturnPostcode??> value="${orderReturnPostcode.configValue!}"</#if> data-rules="{required:true}" class="input-normal control-text"/>
                    </div>
                </div>

              
              <div class="control-group">
              <label class="control-label">备注：</label>
                <div class="controls">
                 <textarea class="input-large" type="text" name="orderReturnRemark" <#if orderReturnRemark??> value="${orderReturnRemark.configValue!}"</#if> ></textarea>
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
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'退款地址编辑',value:'0'}
        ]
    });
	tab.setSelected(tab.getItemAt(0));
	
  	 		BUI.use('bui/form',function (Form) {
			var form = new Form.HForm({
				srcNode : '#J_Form',
				submitType: 'ajax',
				dataType : 'json',
				callback: function (data) { 
				    if (data) {
 				    	BUI.Message.Alert('操作成功!',function(){
                             window.location.href='${ctx }/admin/sa/order/orderReturnArea';
                        });
				    }else{
				    	BUI.Message.Alert('操作失败！','error');
				    }
				}
			});
		
			form.render();
		});
		      
         $(function(){
             $('#orderReturnProvince').change(function(){
                 $.ajax({
                     url:"${ctx }/admin/sa/order/findChildCitys",
                     type:"post",
                     dataType:"json",
                     data:{"id":$('#orderReturnProvince').val()},
                     success:function(data){
                         $('#orderReturnCity').empty();
                         $('#orderReturnArea').empty();
                         $('#orderReturnCity').append("<option value='' >请选择</option>");
                         if(data != null){
                             $.each(data, function(i, row){
                                 $('#orderReturnCity').append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                             });
						 }


					 }

				 })

			 });
		 });


            $(function(){
                $('#orderReturnCity').change(function(){
                    $.ajax({
                        url:"${ctx }/admin/sa/order/findChildCitys",
                        type:"post",
                        dataType:"json",
                        data:{"id":$('#orderReturnCity').val()},
                        success:function(data){
                            $('#orderReturnArea').empty();
                            if(data != null){
                                $.each(data, function(i, row){
                                    $('#orderReturnArea').append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                                });
                            }


                        }

                    })

                });
            });

            $(function(){
                $("input[name='orderReturnPhone']").blur(function(){
                    var phone = $("input[name='orderReturnPhone']").val();
                    if(!(/^1[3|4|5|8][0-9]\d{4,8}$/.test(phone))){
                        BUI.Message.Alert('请输入正确的手机号');
                        $("input[name='orderReturnPhone']").val('');
                        return false;
                    }
                });

            });



</script>
</body>
</html>  