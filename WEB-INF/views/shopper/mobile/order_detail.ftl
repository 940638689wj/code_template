<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>
    <#if exceptionOrderLst?has_content>订单异常<#else>
    	<#if orderShopperOperation?? >
			<#if orderShopperOperation.dealStatusCd == 11>
					接收订单
			<#elseif orderShopperOperation.dealStatusCd == 12>
					出发拣货        
			<#elseif orderShopperOperation.dealStatusCd == 13>
					开始配送             
			<#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4 && order.orderStatusCd != 5> 
					订单送达
			</#if>
		</#if>
		<#if order.orderStatusCd == 5>
				 订单完成
		</#if>
	</#if>
    </title>
</head>
<body>
    <div id="page">
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	        <h1 class="mui-title">
		        		<#if exceptionOrderLst?has_content>订单异常<#else>
		        	<#if orderShopperOperation?? >
						<#if orderShopperOperation.dealStatusCd == 11>
		    					接收订单
						<#elseif orderShopperOperation.dealStatusCd == 12>
								出发拣货        
						<#elseif orderShopperOperation.dealStatusCd == 13>
								开始配送             
						<#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4 && order.orderStatusCd != 5>
								订单送达
						</#if>
					</#if>
					<#if order.orderStatusCd == 4 || order.orderStatusCd == 5>
							 订单完成
					</#if>
				</#if>
	        </h1>
	        <a class="mui-icon"></a>
	    </header>
    <div class="mui-content">
        <div class="dblist">
            <ul>
                <li>
                    <dl>
                        <dt>
                            <span class="green">取：</span>
                             <#list storeList as store>
				                     <P>${(store.storeName)!?html}</P>
				                     <p>${(store.fullAddress)!?html}</p>
				                     <!-- <p>姓名：${(store.storeContact)!}</p> -->
				                     <p>姓名：${(store.contacts)!}</p>
				                     <p>电话：${(store.telephone)!}</p>
				                     <br>
				            </#list>
                        </dt>
                          <dd>
                                <span class="orange">送：</span>
                               <p>收货人姓名：${order.receiveName!}</p>
                            	  <p>收货人电话：${order.receiveTel!}</p>
				                  <p>收货人地址：${order.receiveAddrCombo!}</p>
                            </dd>
                       
                    </dl>
                </li>
            </ul>
        </div>
        <div class="loginform dborderlist">
            <ul>
                <li>
                    <div class="hd">配餐要求：</div>
                    <div class="bd">
                    	 			<#if order.cateringRemark??  && order.cateringRemark?has_content>
	                    		${order.cateringRemark!}
	                    		<#else>
	                    		无
	                    </#if>
                    </div>
                </li>
                <li>
                    <div class="hd">期望取货：</div>
                    <div class="bd"><#if order.requiredEndTime?? && order.requiredEndTime?has_content>${order.requiredEndTime?string("yyyy-MM-dd HH:mm:ss")}之前</#if></div>
                </li>
                <li>
                    <div class="hd">配送时效：</div>
                    <div class="bd"> 
                    			<#if orderShopperOperation?? >
							            <#if orderShopperOperation.dealStatusCd == 11>
							                  		接单后提供
							            <#else>
							                   ${datePoor!}  
							            </#if>
			        			</#if>
			        </div>
                </li>
            </ul>
        </div>
        <div class="loginform dborderlist">
            <ul>
            	 <li>
                    <div class="hd">订单状态：</div>
                    <div class="bd">
                   <#if exceptionOrderLst?has_content>客服人工处理<#else>
                    	  <#if orderShopperOperation??>
                    	  				<#if orderShopperOperation.dealStatusCd == 11>
                    	  					待接收
							            <#elseif orderShopperOperation.dealStatusCd == 12>
							               	 待拣货      
							            <#elseif orderShopperOperation.dealStatusCd == 13>
							              	待配送             
							            <#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4 && order.orderStatusCd != 5>
							                	待送达
							            </#if>
			        			</#if>
			        			 <#if order.orderStatusCd == 4>
					             	待评价
					             <#elseif order.orderStatusCd == 5>
					             		 <#if order.orderReviewStatusCd == 1>
					             			待评价
					             		<#elseif order.orderReviewStatusCd == 2>
					             			已完成，用户已评价
					             	 	</#if>
					               	<#elseif order.orderStatusCd == 6>
					               	用户取消订单
					            </#if>
					              </#if>
                    
                    </div>
                </li>
                <li>
                    <div class="hd">订单备注：</div>
                    <div class="bd"> 
                    		<#if order?has_content&&order.orderRemark?has_content>
                    	 	${(order.orderRemark)!?html}
                    	   </#if>
                   </div>
                </li>
                <li>
                    <div class="hd">订单重量：</div>
                    <div class="bd">
                      ${ordertWeight?string("#.##")}kg</div>
                </li>
                <li>
                    <div class="hd">物品明细：</div>
                    <div class="bd">
                    			<#if order.orderItems??>
		   							 <#assign orderItems= order.orderItems/>
		   							 	<#list orderItems as orderItem>
		   							 	    <#if orderItem_has_next>
												${orderItem.productName?default("")?html}×${orderItem.quantity!},
											<#else>
												 ${orderItem.productName?default("")?html}×${orderItem.quantity!}
										 </#if>
		                    			 	
		                    	   		</#list>
								 </#if>
                    	</div>
                    		
                </li>
            </ul>
        </div>
        <div class="loginform dborderlist">
            <ul>
                <li>
                    <div class="hd">订单编号：</div>
                    <div class="bd">${order.orderNumber!}</div>
                </li>
            </ul>
        </div>
        <div class="loginform dborderlist">
            <ul>
                <li>
                    <div class="hd">运费：</div>
                    <div class="bd">￥${order.orderExpressAmt!}</div>
                </li>
            </ul>
        </div>

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
            	 <#if exceptionOrderLst?has_content><div class="button-wrap button-wrap-expand"><a href="${ctx}/m/shopper/toOrderList?type=1" class="button">返回订单中心</a></div>  <#else>
            			 <#if  shopper?? && shopper.workStatusCd?has_content && shopper.workStatusCd !=0>
		           		 
		           
            			<#if orderShopperOperation?? >
            	   
               					 	   <#if orderShopperOperation.dealStatusCd == 11 && order.orderStatusCd != 6>
               					 	 
               					 	   		  <div class="button-wrap button-wrap-expand">
                  					  				<a href="javascript:void(0)" onclick="acceptOrder('${(order.orderId)!}')" class="button">接收订单</a>
                								</div>
							            <#elseif orderShopperOperation.dealStatusCd == 12 && order.orderStatusCd != 6>
							                   <div class="button-wrap button-wrap-expand"> <a href="javascript:void(0)" onclick="departurePicking('${(order.orderId)!}')" class="button">出发拣货</a> </div>
							            <#elseif orderShopperOperation.dealStatusCd == 13 && order.orderStatusCd != 6>
							                     <div class="button-wrap button-wrap-expand">  <a href="javascript:void(0)" onclick="startDistribution('${(order.orderId)!}')" class="button">开始配送</a>   </div>    
							            <#elseif orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4 && order.orderStatusCd != 5 && order.orderStatusCd != 6>
							                	 <div class="button-wrap button-wrap-expand"> <a href="javascript:void(0)" onclick="orderDelivery('${(order.orderId)!}')" class="button">订单送达</a>    </div>
							            </#if>
							              
			        			</#if>
			        			
                 				<#if orderShopperOperation?? >
							            <#if orderShopperOperation.dealStatusCd == 11 || orderShopperOperation.dealStatusCd == 12 || orderShopperOperation.dealStatusCd == 13 || (orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4 && order.orderStatusCd != 5 && order.orderStatusCd != 6)>
							                   <div class="button-wrap button-wrap-expand">
                    								<a href="javascript:void(0)" class="button cancel" onclick="exceptionOrder()">订单异常</a>
                								</div>
							            </#if>
			        			</#if>
			        		  <#else>
		           	  
		           </#if>
			        			
			        			     <#if  order.orderStatusCd == 5>
							                 <div class="button-wrap button-wrap-expand"><a href="${ctx}/m/shopper/toOrderList?type=1" class="button">返回订单中心</a></div>  
							            
							          </#if>
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
    	
    	//接收订单
    	function acceptOrder(orderId){
	           $.post('${ctx}/m/shopper/acceptOrder',{orderId:orderId},function(data){
	           		 	 var obj = eval("("+data+")");  
	           		 if(obj && obj.result == "true"){
                		location.href='${ctx}/m/shopper/toOrderList?type=2';
		                }else{
		                    mui.toast(obj.message);
		                }
	    		});
    		
    	}
    	
    	//出发拣货
    	function departurePicking(orderId){
	           $.post('${ctx}/m/shopper/departurePicking',{orderId:orderId},function(data){
	           				 var obj = eval("("+data+")");  
	           		 if(obj && obj.result == "true"){
                		location.href='${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}';
		                }else{
		                    mui.toast(obj.message);
		                }
	    		});
    		
    	}
    	
    	//开始配送
    	function startDistribution(orderId){
	           $.post('${ctx}/m/shopper/startDistribution',{orderId:orderId},function(data){
	           			 var obj = eval("("+data+")");  
	           		 if(obj && obj.result == "true"){
                			location.href='${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}';
		                }else{
		                    mui.toast(obj.message);
		                }
	    		});
    		
    	}
    	
    	//订单送达
    	function orderDelivery(orderId){
	           $.post('${ctx}/m/shopper/orderDelivery',{orderId:orderId},function(data){
	           		  var obj = eval("("+data+")");  
	           		 if(obj && obj.result == "true"){
                			location.href='${ctx}/m/shopper/toOrderList?type=3';
		                }else{
		                    mui.toast(obj.message);
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
    	   if($("#orderProblemId").val()==''){
    	    mui.toast('请选择异常！！');
    	    return false;
    	   }
    		$.post('${ctx}/m/shopper/updateOrderExceptionInfo',{orderId:orderId,orderProblemId:$("#orderProblemId").val(),content:$("#content").val()},function(data){
    				  var obj = eval("("+data+")");  
    				 if(obj && obj.result == "true"){
                			  location.href='${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}';
		                }else{
		                    mui.toast(obj.message);
		                }
	        });
    	}
       </script>
</body>
</html>