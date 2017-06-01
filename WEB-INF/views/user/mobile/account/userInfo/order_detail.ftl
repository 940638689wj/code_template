<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>订单详情</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
    <script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a href="${ctx}/m/account" class="mui-icon mui-icon-left-nav"></a>
	            <h1 class="mui-title">订单详情</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="orderstatus">
                <div class="steps">
                    <ul>
                        <li class="<#if order.orderPayStatusCd!=1> step-active</#if>">
                            <b class="stepline"></b>
                            <div class="stepind step1">提交订单</div>
                        </li>
                        <li class="<#if order.orderStatusCd==3||order.orderStatusCd==4||order.orderStatusCd==5||order.orderStatusCd==6> step-active</#if> ">
                            <b class="stepline"></b>
                            <div class="stepind step2">配送中</div>
                        </li>
                        <li class="step-last<#if order.orderStatusCd==4||order.orderStatusCd==5||order.orderStatusCd==6> step-active</#if> ">
                            <b class="stepline"></b>
                            <div class="stepind step3">签收成功</div>
                        </li>
                    </ul>
                </div>     
                                          
            </div>
            <div class="borderbox">
                <div class="order-info">
                    <ul>
                        <li><p>订单状态:</p><span class="orange">
                        <input type="hidden" id="trialOpinion" value="${(orderreturnInfo.trialOpinion)!}">
                        <input type="hidden" id="leaderOpinion" value="${(orderreturnInfo.leaderOpinion)!}">
                        <#if order.orderPropertyCd==0>
                        	<#if order.orderPayStatusCd==1>
                            ${DICT('ORDER_STATUS_CD','1')}
                            <#elseif order.orderStatusCd==10||order.orderStatusCd==11||order.orderStatusCd==20||order.orderStatusCd==21||order.orderStatusCd==22>
                            ${DICT('ORDER_STATUS_CD','20')}
                            <#else>
                            ${DICT('ORDER_STATUS_CD','${(order.orderStatusCd)!}')}
                            </#if>
                        <#else>
                            <#switch order.orderPropertyCd>
	                            <#case 10> 申请退款中
	                            	<#break>
	                            <#case 11> 已初审 <em onclick="trialOpinion()"> 查看</em>
	                            	<#break>
	                           	<#case 12> 已退款
	                            	<#break>
	                            <#case 13> 已拒绝退款 <em onclick="leaderOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 20> 申请退货中
	                            	<#break>
	                            <#case 21> 已初审 <em onclick="trialOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 22> 已退货
	                            	<#break>
	                            <#case 23> 已拒绝退货 <em onclick="leaderOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 30> 申请退款退货中
	                            	<#break>
	                            <#case 31> 已初审 <em onclick="trialOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 32> 已退款退货
	                            	<#break>
	                            <#case 33> 已拒绝退款退货 <em onclick="leaderOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 40> 申请换货中
	                            	<#break>
	                            <#case 41> 已初审 <em onclick="trialOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 42> 已换货
	                            	<#break>
	                            <#case 43> 已拒绝换货 <em onclick="leaderOpinion()"> 查看</em>
	                            	<#break>
	                            <#case 99> 已取消
	                            	<#break>
                            </#switch>
                        </#if>
                        </span></li>
                        <li><p>送至:</p><span>${(orderInfo.receiveAddrCombo)!''}</span></li>
                        <li><p>收货人:</p><span>${(orderInfo.receiveName)!}  ${(orderInfo.receiveTel)!}</span></li>
                        <li><p>配送方式:</p><span>顺丰快递</span></li>
                    </ul>
                </div>
            </div>

            <div class="borderbox">
                <div class="payment-info">
                    <h3>买家留言</h3>
                    <p class="gray">${(order.orderRemark)!}</p>
                </div>
            </div>

            <div class="borderbox">
                <ul class="prd-list order-prd-list sure-prd-list">
                    <li>
                    <#if order.orderItem??>
                        <div class="hd">
                            <span class="c">商品信息</span>
                        </div>
                        <#list order.orderItem as item>
                        <div class="info">
                        <div class="itemsinfo">
                        <a href="${ctx}/m/product/${item.productId}">
                            <div class="pic"><img src="${(item.productPicUrl)!}"></div>
                            <h3>${(item.productName)!}</h3>
                            <p class="price"><span class="price-real">${(item.salePrice?string.currency)!}/件</span></p>
                            <p class="spec">数量：${(item.quantity)!}</p>
                        </a>
                        </div>
                        <div class="aftersales"><a class="orderdetailbtn view" onclick="goto('${ctx}/m/account/toReturnGoods?orderId=${(order.orderId)!}&type=2')">申请售后</a></div>
                        </div>
                        </#list>
                    </li>
                    </#if>
                </ul>
            </div>
            <#if orderInfo??>
             <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a href="javascript:void(0);">
                            	<#if orderInfo.invoiceTypeCd??>
                            	<#else>
                                <div class="r">不开发票</div>
                                </#if>
                                <div class="c">发票信息</div>
                            </a>
                        </li>
                    </ul>
                </div>
                	<#if orderInfo.invoiceTypeCd??>
                 <div class="order-info">
                    <ul>
	                     <#if orderInfo.invoiceTitle??><li> <p> <span class="fl gray"> 发票抬头:</span><span class="fr"> ${(orderInfo.invoiceTitle)!}</span></p></li></#if>
	                     <#if orderInfo.invoiceTypeCd??><li> <p> <span class="fl gray"> 发票类型:</span><span class="fr"> ${DICT('INVOICE_TYPE_CD','${(orderInfo.invoiceTypeCd)!}')}</span></p></li></#if>
	                     <#if orderInfo.invoiceForCd??><li> <p> <span class="fl gray"> 发票对象:</span><span class="fr"> ${DICT('INVOICE_FOR_CD','${(orderInfo.invoiceForCd)!}')}</span></p></li></#if>
	                     <#if orderInfo.invoiceReceiveName??><li> <p> <span class="fl gray"> 发票收货人:</span><span class="fr"> ${(orderInfo.invoiceReceiveName)!}</span></p></li></#if>
	                     <#if orderInfo.invoiceReceiveTel??><li> <p> <span class="fl gray"> 发票收货人联系方式:</span><span class="fr"> ${(orderInfo.invoiceReceiveTel)!}</span></p></li></#if>
	                     <#if orderInfo.invoiceReceiveAddr??><li> <p> <span class="fl gray"> 发票收货地址:</span><span class="fr"> ${(orderInfo.invoiceReceiveAddr)!}</span></p></li></#if>
	                     <#if orderInfo.invoiceNumber??><li> <p> <span class="fl gray"> 发票单号:</span><span class="fr"> ${(orderInfo.invoiceNumber)!}</span></p></li></#if>
                    </ul>
                </div>
                </#if>
            </div>
            </#if>
            <div class="borderbox">
                <div class="payment-info">
                    <h3>支付信息</h3>
                    <p><span class="fl gray">支付方式:</span><span class="fr">
                    	${DICT('ORDER_PAY_WAY_CD','${(order.orderPayWayCd)!}')}
                    </span></p>
                    <p><span class="fl gray">商品总额:</span><span class="fr">${(order.orderTotalAmt?string.currency)!'0'}</span></p>
                    <p><span class="fl gray">卡券优惠:</span><span class="fr">${(order.orderDiscountAmt?string.currency)!'0'}</span></p>
                    <p><span class="fl gray">运费:</span><span class="fr">${(order.orderExpressAmt?string.currency)!'0'}</span></p>
                    <p><span class="fl gray">实付金额:</span><span class="fr orange">${(order.orderPayAmt?string.currency)!'0'}</span></p>
                </div>
            </div>

            <div class="borderbox">
                <div class="order-info">
                    <ul>
                        <li><p>订单编号:</p><span class="gray">${(order.orderNumber)!}</span></li>
                        <li><p>下单时间:</p><span class="gray">${(order.createTime?datetime)!}</span></li>
                        <li><p>付款时间:</p><span class="gray"><#if orderPayamtOfPay??>${(orderPayamtOfPay.payamtTime?datetime)!}</#if></span></li>
                        <li><p>发货时间:</p><span class="gray"></span></li>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap fbbwrap-total">
                <div class="ftbtnbar">
                    <div class="content-wrap"></div>
                    <div class="button-wrap">
                     <#if order.orderPropertyCd==0>
                      <#if order.orderPayStatusCd==1>
                      		<a class="orderdetailbtn view" onclick="cancelOrder('${(order.orderId)!}');">取消订单</a>
                        	<a class="orderdetailbtn " onclick="goto('${ctx}/m/account/order/goToOrderPayment?orderNumber=${(order.orderNumber)!}');">点击付款</a>
                        	<#elseif order.orderStatusCd==10||order.orderStatusCd==11||order.orderStatusCd==20||order.orderStatusCd==21||order.orderStatusCd==22>
                        	<a class="orderdetailbtn view" onclick="goto('${ctx}/m/account/toReturnGoods?orderId=${(order.orderId)!}')">退换申请</a>
                        	<#elseif order.orderStatusCd==3>
                        	<a class="orderdetailbtn view" onclick="goto('http://www.kuaidi100.com/chaxun?com=shunfeng&nu=${(orderInfo.Express_No)!}');">查看物流</a>
                            <a class="orderdetailbtn " onclick="confirmReceipt('${(order.orderId)!}')">确认收货</a>
                        	<#elseif order.orderStatusCd==4>
                        	<a class="orderdetailbtn view" onclick="goto('${ctx}/m/account/toReturnGoods?orderId=${(order.orderId)!}')">退换申请</a>
                           <a class="orderdetailbtn" onclick="goto('${ctx}/m/account/toComment?orderId=${(order.orderId)!}')">评价</a>
                        </#if>
                        <#else>
                        	<a class="orderdetailbtn " onclick="cancelReturnGoods('${(order.orderId)!}');">取消退货</a>
                       </#if>
                    </div>
                </div>
            </div>
        </div>

    </div>
     <script>
     
     function goto(url){
    		location.href = url;
    	}
    	//确认收货
    	function confirmReceipt(orderId){
    		var btnArray = ['取消', '确认'];
    		mui.confirm('', '是否确认收货？', btnArray, function(e) {
            if (e.index == 0) {
            } else {
	              $.post('${ctx}/m/account/confirmReceipt',{orderId:orderId},function(data){
	    			if(data){
	    				mui.toast('交易完成');
	    				location.href='${ctx}/m/account';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
            }
        });
    		
    	}
    	
    	//取消退换货
    	function cancelReturnGoods(orderId){
    		var btnArray = ['取消', '确认'];
    		mui.confirm('', '确认取消退换货？', btnArray, function(e) {
            if (e.index == 0) {
            } else {
	              $.post('${ctx}/m/account/cancelReturnGoods',{orderId:orderId},function(data){
	    			if(data){
	    				mui.toast('取消成功');
	    				location.href='${ctx}/m/account';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
            }
        });
    		
    	}
    	//取消订单
     function cancelOrder(orderId){
    		var btnArray = ['取消', '确认'];
    		mui.confirm('', '是否确定要取消订单吗？', btnArray, function(e) {
            if (e.index == 0) {
            } else {
	              $.post('${ctx}/m/account/cancelOrder',{orderId:orderId},function(data){
	    			if(data){
	    				mui.toast('取消成功');
	    				location.href=location.href;
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
            }
        });
    	}
    
    function trialOpinion() {
    	mui.alert($('#trialOpinion').val());
    }
	function leaderOpinion() {
    	mui.alert($('#leaderOpinion').val());
    }
    </script>
</body>
</html>