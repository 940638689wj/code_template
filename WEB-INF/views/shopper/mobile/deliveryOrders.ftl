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
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/shopperIndex"></a>
	        <h1 class="mui-title">订单管理</h1>
	        <a class="mui-icon"></a>
	    </header>
    <div class="mui-content">
    	<div class="skutabbar">
            <ul>
                <li <#if type=='1'>class="selected"</#if>><a href="${ctx}/m/shopper/deliveryOrder?type=1">已完成</a></li>
                <li <#if type=='2'>class="selected"</#if>><a href="${ctx}/m/shopper/deliveryOrder?type=2">已取消</a></li>
                <li <#if type=='3'>class="selected"</#if>><a href="${ctx}/m/shopper/deliveryOrder?type=3">异常</a></li>
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
                    				异常
                    			<#else>
					             <#if order.orderStatusCd == 5>
					               	  已完成
					               	   <#elseif order.orderStatusCd == 6>
					               			取消订单
					            </#if>
					         </#if>
                    	</p></div>
                    <div class="info">
                        <p>下单时间：${(order.createTime?string('yyyy-MM-dd HH:mm:ss'))!}</p>
                        <p>派单时间：
                           <#if order.distributeTime??  && order.distributeTime?has_content>
	                    	${(order.distributeTime?string('yyyy-MM-dd HH:mm:ss'))!}
	                    </#if>
                        </p>
                         <p>送达时间：
                          <#if order.requiredEndTime??  && order.requiredEndTime?has_content>
	                    	${(order.requiredEndTime?string('yyyy-MM-dd HH:mm:ss'))!}
	                    </#if>
                         </p>
                    </div>
                    <div class="bt"><a class="btn" href="${ctx}/m/shopper/toDeliveryOrderDetail?orderId=${(order.orderId)!}">
                    			  <#if exceptionOrderMap?? && exceptionOrderMap[orderId]?? && exceptionOrderMap[orderId]?has_content>
                    				异常
                    			<#else>
					             <#if order.orderStatusCd == 5>
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