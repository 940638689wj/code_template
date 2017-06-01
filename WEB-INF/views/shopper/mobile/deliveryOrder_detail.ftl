<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <title>订单详情</title>
</head>
<body>
    <div id="page">
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	        <h1 class="mui-title">
		        	我的派送单
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
				                     <p>姓名：${(store.contacts)!}</p>
									 <!-- <p>姓名：${(store.storeContact)!}</p> -->
									 <p>电话：${(store.telephone)!}</p>
				                     <br>
				              </#list>
                        </dt>
                        <dd>
                            <span class="orange">送：</span>
                         	<p>${order.receiveAddrCombo!}</p>
                            <p>姓名：${order.receiveName!}</p>
                            <p>电话：${order.receiveTel!}</p>
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
					             <#if order.orderStatusCd == 4 || order.orderStatusCd == 5>
					              		已完成,用户已评价
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
                    <div class="bd"> ${ordertWeight?string("#.##")}
                                                    kg</div>
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
	    			if(data){
	    				location.href='${ctx}/m/shopper/toOrderList?type=2';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
    		
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