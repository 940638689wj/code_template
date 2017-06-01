<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>
    <#if orderShopperOperation?? >
		<#if orderShopperOperation.dealStatusCd == 12>
			出发拣货        
		<#elseif orderShopperOperation.dealStatusCd == 13>
			开始配送             
		<#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4>
			订单送达
		<#elseif orderShopperOperation.dealStatusCd == 19>
			订单异常
		</#if>
	</#if>
		        			
	<#if order.orderStatusCd == 4>
		订单完成
	</#if>
    </title>

</head>
<body>
    <div id="page">
    <#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	        <h1 class="mui-title">
	        <#if orderShopperOperation?? >
				<#if orderShopperOperation.dealStatusCd == 12>
					出发拣货        
				<#elseif orderShopperOperation.dealStatusCd == 13>
					开始配送             
				<#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4>
					订单送达
				<#elseif orderShopperOperation.dealStatusCd == 19>
					订单异常
				</#if>
			</#if>
				        			
			<#if order.orderStatusCd == 4>
				订单完成
			</#if>
			</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="dblist">
            <ul>
                <li>
                    <dl>
                        <dt>
				                 <P>订单号：${order.orderNumber!}</P>
				                  <p>下单时间：${(order.createTime?string('yyyy-MM-dd HH-mm-ss'))!}</p>
                        		  <p>配送时间：${(order.distributeTime?string('yyyy-MM-dd HH-mm-ss'))!}</p>
				                  <p>配送费：${order.orderExpressAmt!}</p>
				                    <#list storeList as store>
				                    	  <#if store_has_next>
												   <P>拣货门店：${(store.storeName)!?html}</P>
				                     			<p>门店联系人电话：${(store.telephone)!}</p>
				                    		 <br>
											<#else>
											   <P>拣货门店：${(store.storeName)!?html}</P>
				                     			<p>门店联系人电话：${(store.telephone)!}</p>
										 </#if>
				                  
				                              、 	  </#list>
				                  <p>收货人姓名：${order.receiveName!}</p>
                            	  <p>收货人电话：${order.receiveTel!}</p>
				                  <p>收货人地址：${order.receiveAddrCombo!}</p>
				                  <p>产品名称：<#if order.orderItems??>
		   							 <#assign orderItems= order.orderItems/>
		   							 	<#list orderItems as orderItem>
		   							 	    <#if orderItem_has_next>
												${orderItem.productName?default("")?html}×${orderItem.quantity!},
											<#else>
												 ${orderItem.productName?default("")?html}×${orderItem.quantity!}
										 </#if>
		                    			 	
		                    	   		</#list>
								 </#if>
						 		</p>
						 		  <p>
						 		  <#if orderShopperOperation??>
							            <#if orderShopperOperation.dealStatusCd == 12>
							                  <p class="state">订单状态： 待拣货</p>          
							            <#elseif orderShopperOperation.dealStatusCd == 13>
							               <p class="state">订单状态：待配送</p>               
							            <#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4>
							                <p class="state">订单状态：    待送达</p>  
							               <#elseif orderShopperOperation.dealStatusCd == 19>
							               <p class="state">订单状态：    待处理</p>    
							            </#if>
			        			</#if>
			        			 <#if order.orderStatusCd == 4>
					             	  <p class="state">订单状态：    待评价</p>  
					             <#elseif order.orderStatusCd == 5>
					               	  <p class="state">订单状态：    已完成,用户已评价</p>   
					               	   <#elseif order.orderStatusCd == 6>
					               	  <p class="state">订单状态：    用户取消订单</p>   
					            </#if>
						 		  </p>
                           		
                        </dt>
                      
                    </dl>
                </li>
            </ul>
        </div>
      
    

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
              
               					 <#if orderShopperOperation?? >
               					 	
							            <#if orderShopperOperation.dealStatusCd == 12>
							                   <div class="button-wrap button-wrap-expand"> <a href="javascript:void(0)" onclick="departurePicking('${(order.orderId)!}')" class="button">出发拣货</a> </div>
							            <#elseif orderShopperOperation.dealStatusCd == 13>
							                     <div class="button-wrap button-wrap-expand">  <a href="javascript:void(0)" onclick="startDistribution('${(order.orderId)!}')" class="button">开始配送</a>   </div>    
							            <#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4>
							                	 <div class="button-wrap button-wrap-expand"> <a href="javascript:void(0)" onclick="orderDelivery('${(order.orderId)!}')" class="button">订单送达</a>    </div>
							              <#elseif orderShopperOperation.dealStatusCd == 19>
							                     	等待客服处理。 
							            </#if>
							              
			        			</#if>
			        			
			        			 <#if 		order.orderStatusCd == 4>
							                	订单已完成，等待用户评价。
							            
							            </#if>
                   
             
                 				<#if orderShopperOperation?? >
							            <#if orderShopperOperation.dealStatusCd == 12>
							                   <div class="button-wrap button-wrap-expand">
                    								<a href="javascript:void(0)" class="button cancel" onclick="exceptionOrder()">订单异常</a>
                								</div>
							            <#elseif orderShopperOperation.dealStatusCd == 13>
							                      <div class="button-wrap button-wrap-expand">
                    								<a href="javascript:void(0)" class="button cancel" onclick="exceptionOrder()">订单异常</a>
                								</div>   
							            <#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4>
							                	  <div class="button-wrap button-wrap-expand">
                    								<a href="javascript:void(0)" class="button cancel" onclick="exceptionOrder()">订单异常</a>
                								</div>   
							              <#elseif orderShopperOperation.dealStatusCd == 19>
							                      <br><div class="button-wrap button-wrap-expand"><a href="${ctx}/m/shopper/toOrderList?type=0" class="button">返回订单中心</a></div>  
							            </#if>
			        			</#if>
			        			
			        			 <#if 		order.orderStatusCd == 4>
							                 <br><div class="button-wrap button-wrap-expand"><a href="${ctx}/m/shopper/toOrderList?type=0" class="button">返回订单中心</a></div>  
							            
							            </#if>
             
            </div>
        </div>
    </div>

    <div class="show-abnormal-bg"></div>
    <div class="mui-abnormal">
        <div class="ordercancel">
            <div class="info">
                <h3>订单异常原因：</h3>
                <div class="selectbox">
                    <select name="orderProblemId" id="orderProblemId">
	                    <#list orderProblems as e>
	                            <option value="${e.id}">${e.orderProblemDesc}</option>
	                     </#list>
                    </select>
                </div>
                <h3>备注：</h3>
                <textarea name="content"></textarea>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" id="submit" onclick="updateOrderExceptionInfo('${(order.orderId)!}')">提交</a>
                <a href="javascript:void(0);" id="change">取消</a>
            </div>
        </div>
    </div>
</div>
 <script>
     
     	 $(function(){
	        $("#change").on("click",function(){
	            $(".show-abnormal-bg").removeClass("mui-active");
	            $(".mui-abnormal").removeClass("mui-popup-in");
	            document.ontouchmove = null;
	        })
    	})
    	 function goto(url){
    		location.href = url;
    	}
    	
    	//出发拣货
    	function departurePicking(orderId){
	           $.post('${ctx}/m/shopper/departurePicking',{orderId:orderId},function(data){
	    			if(data){
	    				location.href='${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
    		
    	}
    	
    	//开始配送
    	function startDistribution(orderId){
	           $.post('${ctx}/m/shopper/startDistribution',{orderId:orderId},function(data){
	    			if(data){
	    				location.href='${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
    		
    	}
    	
    	//订单送达
    	function orderDelivery(orderId){
	           $.post('${ctx}/m/shopper/orderDelivery',{orderId:orderId},function(data){
	    			if(data){
	    				location.href='${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
    		
    	}
    	//订单异常
    	function exceptionOrder(){
	        $(".show-abnormal-bg").addClass("mui-active");
            $(".mui-abnormal").addClass("mui-popup-in");
            document.ontouchmove = function () {
                return false;
            }
    	}
    	
    	function updateOrderExceptionInfo(orderId){
    		$.post('${ctx}/m/shopper/updateOrderExceptionInfo',{orderId:orderId,orderProblemId:$("#orderProblemId").val(),content:$("#content").val()},function(data){
	    			if(data){
	    				$(".show-abnormal-bg").removeClass("mui-active");
	            		$(".mui-abnormal").removeClass("mui-popup-in");
	           			 document.ontouchmove = null;
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
    	}
       </script>
</body>
</html>