<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<div>
<div class="container">


<div class="orderstatus clearfix">
    <ul class="toolbar" id="orderInfoViewContainer">
        <li class="status-info">
           	 订单号：${(storeOrder.orderNumber)!}
        </li>
        <#if orderStoreOperation?? &&  orderStoreOperation.dealStatusCd?? && orderStoreOperation.dealStatusCd?has_content &&  orderStoreOperation.dealStatusCd == 1 && storeOrder.orderStatusCd !=5 && storeOrder.orderStatusCd !=6>
            <li><button class="button" onclick="orderdistribution('${storeOrder.orderId}')">配货</button></li>
        </#if>
         <#if store.storeTypeCd?? && store.storeTypeCd?has_content && store.storeTypeCd ==2>
	        <#if orderStoreOperation?? &&  orderStoreOperation.dealStatusCd?? && orderStoreOperation.dealStatusCd?has_content && orderStoreOperation.dealStatusCd == 2 &&  storeOrder.orderStatusCd?? && storeOrder.orderStatusCd !=5 && storeOrder.orderStatusCd !=6 && storeOrder.orderTypeCd?? && storeOrder.orderTypeCd?has_content && storeOrder.orderTypeCd ==1 && storeOrder.orderStatusCd !=5 && !(orderReceiveInfo.orderDistrbuteTypeCd?has_content)>
	            <li><button class="button" onclick="ordersend('${storeOrder.orderId!}')">送货</button></li>
	        </#if>
            </#if>
          <#if orderStoreOperation?? &&  orderStoreOperation.dealStatusCd?? && orderStoreOperation.dealStatusCd?has_content && orderStoreOperation.dealStatusCd == 3 &&  storeOrder.orderStatusCd?? && storeOrder.orderStatusCd !=5 && storeOrder.orderStatusCd !=6>
            <li><button class="button" onclick="orderDelivery('${storeOrder.orderId!}')">订单送达</button></li>
        </#if>
        
        <li>
            <button class="button button-primary" onclick="toPrint()">打印订单</button>
        </li>
    </ul>
</div>

<table cellspacing="0" class="table table-info">
    <caption>订单信息</caption>
    <tbody>
    <tr>
        <th>订单号：</th>
        <td>${(storeOrder.orderNumber)!}</td>
        <th>下单时间：</th>
        <td>
        	<#if storeOrder.createTime??>${storeOrder.createTime?string("yyyy-MM-dd HH:mm:ss")}</#if>
        </td>
    </tr>
    <tr>
        <th>商品数量：</th>
        <td>${itemCount!}</td>
        <th>送货方：</th>
        <td>
        ${((orderReceiveInfo.orderDistrbuteTypeCd == 1)?string('自己配送','总店配选'))!}
        </td>
    </tr>
    </tbody>
</table>
<table cellspacing="0" class="table table-info">
    <caption>收货人信息</caption>
    <tbody>
        <tr>
            <th>收件人：</th>
            <td id="firstNameViewContainer">
            	${(orderReceiveInfo.receiveName)!}
            </td>
            <th>配送状态：</th>
            <td>
            	 <#if orderStoreOperation?? && orderStoreOperation.dealStatusCd?? &&  orderStoreOperation.dealStatusCd?has_content >
            			 <#if orderStoreOperation.dealStatusCd == 1 && storeOrder.orderStatusCd !=5 & storeOrder.orderStatusCd !=6>
            			 	待配货
            			 	<#elseif orderStoreOperation.dealStatusCd == 2 && storeOrder.orderStatusCd !=5 & storeOrder.orderStatusCd !=6>
            			 		待送货
            			 	<#elseif orderStoreOperation.dealStatusCd == 3 && storeOrder.orderStatusCd !=5 & storeOrder.orderStatusCd !=6 >
            			 		待收货
            			 		<#elseif orderStoreOperation.dealStatusCd == 9 && storeOrder.orderStatusCd !=5 & storeOrder.orderStatusCd !=6>
            			 		订单异常
            			 </#if>
            	</#if>
            	 <#if storeOrder.orderStatusCd?? &&  storeOrder.orderStatusCd?has_content >
            	 		 <#if storeOrder.orderStatusCd == 6>
            			 	已取消
            			 </#if>
            			  <#if storeOrder.orderStatusCd == 5>
            			 	已完成
            			 </#if>
            	 	</#if>
            	
          </td>
        </tr>
        <tr>
            <th>联系手机：</th>
            <td>
           		${(orderReceiveInfo.receiveTel)!""}
            </td>
           
 			<th>收货地址：</th>
            <td>
            	${(orderReceiveInfo.receiveAddrCombo)!""}
            </td>

        </tr>
        <tr>
            <th>要求送达时间：</th>
            <td>
            	<#if storeOrder.requiredEndTime?? && storeOrder.requiredEndTime?has_content>${storeOrder.requiredEndTime?string("yyyy-MM-dd HH:mm:ss")}</#if>
            </td>
            <th>备注：</th>
            <td>
     			${(storeOrder.orderRemark)!""}
            </td>
        </tr>
    </tbody>
</table>
<div>
<#include "commonProductInfo.ftl"/>
</div>

<table cellspacing="0" class="table table-info">
    <caption>订单金额</caption>
    <tbody>
    <tr>
        <th>商品总价：</th>
        <td>￥${(orderProductAmt)!0.0}</td>
    </tr>
    </tbody>
</table>

	<div id="orderassignment" class="hide">
  		 <div class="form-content">
  			<input type="hidden" name="distributeOrderId" id="distributeOrderId"/>
        	<div class="auditRefused" style="font-size:15px">是否愿意配货？</div>
       </div>
    </div>
    
    
    <div id="orderSend" class="hide">
    	  <div class="form-content">
    	  		<input type="hidden" name="orderId" id="orderId"/>
        		<div class="auditRefused" style="font-size:15px">是否愿意送货？</div>
          </div>
    </div>
   
    
    <div id="orderDelivery" class="hide">
    	  <div class="form-content">
    	  		<input type="hidden" name="deliveryOrderId" id="deliveryOrderId"/>
        		<div class="auditRefused" style="font-size:15px">订单是否已送达？</div>
          </div>
    </div>
<script>

		 $.fn.status=function(key){
			var Status={1:'待分配',2:'待送货',3:'待收货',6:'已取消',9:'订单异常'};
			return Status[key];
		}
		function toPrint(){
            window.open("${ctx}/admin/store/order/print?id=${storeOrder.orderId}");
        }

		 function orderdistribution(orderId){
		 	  var orderPayStatusCd;
			 <#if storeOrder.orderPayStatusCd?? &&  storeOrder.orderPayStatusCd?has_content >
			 	 orderPayStatusCd = '${storeOrder.orderPayStatusCd!}';
			 </#if>
		  
		 	if(orderPayStatusCd && orderPayStatusCd == '1'){//未支付提醒
           		BUI.Message.Confirm('订单未支付，确定分配？',function(){
					$("#distributeOrderId").val(orderId);
	        		dialogorderdistribution.show();
				},'question');
               }else{
               		$("#distributeOrderId").val(orderId);
	        		dialogorderdistribution.show();
               }
	    	
	     }
	     
	    function ordersend(orderId){
		 	$("#orderId").val(orderId);
			dialogordersend.show();
    	}
		
		
		 BUI.use('bui/overlay',function(Overlay){ 
		 	 dialogordersend = new Overlay.Dialog({
		 	title:'送货',
            width:240,
            height:160,
            mask:true,
            buttons:[
                {
                    text:'是',
                    elCls : 'button button-primary',
                    handler : function(){
                        orderConfirmSendBatch();
                    }
                },{
                    text:'否',
                    elCls : 'button',
                    handler : function(){
                    	orderCancelSendBatch();
                        this.close();
                    }
                }
            ],
            contentId : 'orderSend'
        });
		 
		 	dialogorderdistribution = new Overlay.Dialog({
            title:'订单分配',
            width:240,
            height:160,
            mask:true,
            buttons:[
                {
                    text:'确认',
                    elCls : 'button button-primary',
                    handler : function(){
                       distributeBatch();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'orderassignment'
        });
        
        	dialogorderdelivery = new Overlay.Dialog({
            title:'订单送达',
            width:240,
            height:160,
            mask:true,
            buttons:[
                {
                    text:'确认',
                    elCls : 'button button-primary',
                    handler : function(){
                       deliveryBatch();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'orderDelivery'
        });
        
		 
		 });
		 
		 
		 function distributeBatch(){
			$.ajax({
			    url : "${ctx}/admin/store/order/distributeOrder",
			    type : "post",
			    async : false,
			    data : {orderId: $("#distributeOrderId").val()},
			    success : function(data){
			    	if(data.result == "success"){
                           BUI.Message.Alert("分配成功",function(){
			        		window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=${store.storeId}';
		    				});
                        }else{
                            BUI.Message.Alert(data.message);
                        }
			    }
			});
		}
		
		function orderConfirmSendBatch(){
		    $.ajax({
		    	url : "${ctx}/admin/store/order/orderConfirmSendBatch",
		    	type : "post",
		    	async : false,
		    	data : {orderId: $("#orderId").val()},
		    	success : function(data){
		    		BUI.Message.Alert("订单确认送货成功！",function(){
		    		    window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=${store.storeId}';
		    		}
		    		);
		    	}
		    });	
		}
		
		function orderCancelSendBatch(){
	    $.ajax({
	    	url : "${ctx}/admin/store/order/orderCancelSendBatch",
	    	type : "post",
	    	async : false,
	    	data : {orderId: $("#orderId").val()},
	    	success : function(data){
	    		BUI.Message.Alert("订单已取消送货！",function(){
	    		    window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=${store.storeId}';
	    		}
	    		);
	    	}
	    });	
	}
	
		
			function deliveryBatch(){
		$.ajax({
		    url : "${ctx}/admin/store/order/deliveryOrder",
		    type : "post",
		    async : false,
		    data : {orderId: $("#deliveryOrderId").val()},
		    success : function(data){
		    	BUI.Message.Alert("订单确认送达成功",function(){
			        window.location.href = '${ctx}/admin/store/order/storeOrderList?storeId=${store.storeId}';
		    	}
		    	);
		    }
		    
		});

	}
		
		 function orderDelivery(orderId){
			 $("#deliveryOrderId").val(orderId);
			dialogorderdelivery.show();
   		 }
	



</script>

<object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>
</object>
<script src="${ctx!}/static/js/lodop/LodopFuncs.js"></script>
<script src="${ctx!}/static/js/lodop/print.js?v=201506291435"></script>
<script src="/static/js/printOrder.js"></script>