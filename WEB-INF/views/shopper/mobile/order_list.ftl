<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>订单管理</title>
</head>
<body>
	<div id="page">
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/index"></a>
	        <h1 class="mui-title">订单管理</h1>
	        <a class="mui-icon"></a>
	    </header>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li <#if type=='1'>class="selected"</#if>><a href="${ctx}/m/shopper/toOrderList?type=1">待接单</a></li>
                <li <#if type=='2'>class="selected"</#if>><a href="${ctx}/m/shopper/toOrderList?type=2">配送中</a></li>
                <li <#if type=='3'>class="selected"</#if>><a href="${ctx}/m/shopper/toOrderList?type=3">已完成</a></li>
            </ul>
        </div>
        <div class="orderList">
            <ul>
                <#if list??>
           		 <#list list as order>
           		 	 <#assign orderId = (order.orderId)!?string>
                <li>
                    <div class="hd"><p class="time">订单号：${order.orderNumber!}</p><p class="state">
                    	
			            		 <#if exceptionOrderMap?? && exceptionOrderMap[orderId]?? && exceptionOrderMap[orderId]?has_content>
                    				订单异常
                    			<#else>
			            		 <#if orderShopperOperationMap?? && orderShopperOperationMap[orderId]??>
			                		<#assign orderShopperOperation=orderShopperOperationMap[orderId]/>
							            <#if orderShopperOperation.dealStatusCd == 11>
							              待接收         
							            <#elseif orderShopperOperation.dealStatusCd == 12>
							                  待拣货    
							            <#elseif orderShopperOperation.dealStatusCd == 13>
							             	待配送             
							            <#elseif orderShopperOperation.dealStatusCd == 14  && order.orderStatusCd != 4  && order.orderStatusCd !=5>
							               		待送达  
							               <#elseif orderShopperOperation.dealStatusCd == 19>
							               		待处理
							            </#if>
			        			</#if>
			        			 <#if order.orderStatusCd == 4>
					             	待评价
					             <#elseif  order.orderStatusCd == 5>
					               	 已完成
					               	   <#elseif order.orderStatusCd == 6>
					               			用户取消订单
					            </#if>
					         </#if>
                    	</p></div>
                    <div class="info">
                        <p>下单时间：${(order.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</p>
                        <p>配送时间：${(order.distributeTime?string('yyyy-MM-dd HH:mm:ss'))!}</p>
                        <dl>
                            <dt>
                                <span class="green">取：</span>
                         		 <#if orderStoreMap?? && orderStoreMap[orderId]??>
			                		<#assign storeList=orderStoreMap[orderId]/>
			                		 <#list storeList as store>
			                		  		<#if store_has_next>
													<P>${(store.storeName)!?html}</P>
				                            	<p>${(store.fullAddress)!?html}</p>
				                    		 <br>
											<#else>
											 	<P>${(store.storeName)!?html}</P>
				                            	<p>${(store.fullAddress)!?html}</p>
										 </#if>
                                    </#list>
			        			</#if>
                            </dt>
                            <dd>
                                <span class="orange">送：</span>
                               <p>收货人姓名：${order.receiveName!}</p>
                            	  <p>收货人电话：${order.receiveTel!}</p>
				                  <p>收货人地址：${order.receiveAddrCombo!}</p>
                            </dd>
                        </dl>
                    </div>
                    <div class="bt"><a class="btn" href="${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}">
               
                    			 <#if exceptionOrderMap?? && exceptionOrderMap[orderId]?? && exceptionOrderMap[orderId]?has_content>
                   		 异常
                   	  <#else>
                    			<#if orderShopperOperationMap?? && orderShopperOperationMap[orderId]??>
			                		<#assign orderShopperOperation=orderShopperOperationMap[orderId]/>
							            <#if orderShopperOperation.dealStatusCd == 11 || orderShopperOperation.dealStatusCd == 12 || orderShopperOperation.dealStatusCd == 13 || (orderShopperOperation.dealStatusCd == 14 && order.orderStatusCd != 4 && order.orderStatusCd != 5)>
							             		 处理订单	     
							            </#if>
			        			</#if>
					            <#if order.orderStatusCd == 4 || order.orderStatusCd == 5>
					             	已完成
					             <#elseif order.orderStatusCd == 6>
					               	  取消订单
					            </#if>
					            </#if>
                    
                    </a></div>
                </li>
                 	 </#list>
            	</#if>
                
            </ul>
        </div>
    </div>
</div>




<script>  
 		function goto(url){
    		location.href = url;
    	}
</script>
    
</body>
</html>