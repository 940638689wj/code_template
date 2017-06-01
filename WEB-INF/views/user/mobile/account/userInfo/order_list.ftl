<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的订单</title>
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
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
	            <h1 class="mui-title">我的订单</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="tabbar">
                <ul>
                	<li <#if type=='0'>class="selected"</#if> ><a href="${ctx}/m/account/toOrderList?type=0">全部</a></li>
                    <li <#if type=='1'>class="selected"</#if> ><a href="${ctx}/m/account/toOrderList?type=1">待付款</a></li>
                    <li <#if type=='2'>class="selected"</#if> ><a href="${ctx}/m/account/toOrderList?type=2">待发货</a></li>
                    <li <#if type=='3'>class="selected"</#if> ><a href="${ctx}/m/account/toOrderList?type=3">待收货</a></li>
                    <li <#if type=='4'>class="selected"</#if> ><a href="${ctx}/m/account/toOrderList?type=4">待评价</a></li>
                </ul>
            </div>
            <#if list??>
            <#list list as order>
            <div class="borderbox">
                <ul class="prd-list order-prd-list">
                    <li>
                    <div  onclick="goto('${ctx}/m/account/toOrderDetail?orderId=${(order.orderId)!}');">
                        <div class="hd">
                            <span class="c">${(order.lastUpdateTime?datetime)!}</span>
                            <span class="r">
                            <#if order.orderPayStatusCd==1>
                            ${DICT('ORDER_STATUS_CD','1')}
                            <#elseif order.orderStatusCd==10||order.orderStatusCd==11||order.orderStatusCd==20||order.orderStatusCd==21||order.orderStatusCd==22>
                            ${DICT('ORDER_STATUS_CD','20')}
                            <#else>
                            ${DICT('ORDER_STATUS_CD','${(order.orderStatusCd)!}')}
                            </#if>
                            </span>
                        </div>
                        <#list order.orderItem as item>
                        <div class="info">
                        <a href="#">
                            <div class="pic"><img src="${(item.productPicUrl)!}"></div>
                            <h3>${(item.productName)!}</h3>
                            <p class="price"><span class="price-real">${(item.salePrice?string.currency)!}/件</span></p>
                            <p class="spec">数量：${(item.quantity)!}</p>
                        </a>
                        </div>
                        </#list>
                        <div class="ft">
                           	 共${order.orderItem?size}件商品，合计：<span>${(order.orderPayAmt?string.currency)!}</span>
                        </div>
                        </div>
                        <div class="cz">
                        	<#if order.orderPayStatusCd==1>
                        	<a class="mui-btn mui-btn-outlined" onclick="cancelOrder('${(order.orderId)!}');">取消订单</a>
                        	<a class="mui-btn mui-btn-danger mui-btn-outlined" onclick="goto('${ctx}/m/account/order/goToOrderPayment?orderNumber=${(order.orderNumber)!}');">点击付款</a>
                        	<#elseif order.orderStatusCd==10||order.orderStatusCd==11||order.orderStatusCd==20||order.orderStatusCd==21||order.orderStatusCd==22>
                        	<a class="mui-btn mui-btn-outlined" onclick="goto('${ctx}/m/account/toReturnGoods?orderId=${(order.orderId)!}')">退换申请</a>
                        	<#elseif order.orderStatusCd==3>
                            <a class="mui-btn mui-btn-danger mui-btn-outlined" onclick="confirmReceipt('${(order.orderId)!}')">确认收货</a>
                        	<#elseif order.orderStatusCd==4>
                        	<a class="mui-btn mui-btn-outlined" onclick="goto('${ctx}/m/account/toReturnGoods?orderId=${(order.orderId)!}')">退换申请</a>
                            <a class="mui-btn mui-btn-danger mui-btn-outlined" onclick="goto('${ctx}/m/account/toComment?orderId=${(order.orderId)!}')">评价</a>
                        	</#if>
                        </div>
                    </li>
                </ul>
            </div>
            </#list>
            </#if>
             <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
      <div id="J_ASSpec" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">选择支付方式</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                        <li>
                            <label>
                                <input type="radio" name="paytype" value="1">
                                <div class="c"><i class="payico payico-vouchers"></i>银联支付</div>
                            </label>	
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype" value="2">
                                <div class="c"><i class="payico payico-alipay"></i>支付宝支付</div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype" value="3">
                                <div class="c"><i class="payico payico-wechat"></i>微信支付</div>
                            </label>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="fbbwrap nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy">确定</a>
                    </div>
                </div>
            </div>
    </div>
    <script>
    
    	function goto(url){
    		location.href = url;
    	}
    	//确认订单
    	function confirmReceipt(orderId){
    		var con="";
    		var btnArray = ['取消', '确认'];
    		mui.confirm( '是否确定要收货吗？', btnArray, function(e) {
             if(e.index == 1) {
             	if(con==''||con==null){
             		con="aa";
           		 console.log("测试2");
	              $.post('${ctx}/m/account/confirmReceipt',{orderId:orderId},function(data){
	    			if(data){
	    				mui.toast('交易完成');
	    				window.location.href="${ctx}/m/account/toComment?orderId="+orderId;
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
            }
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
	    				location.href='${ctx}/m/account';
	    			}else{
	    				mui.toast('操作失败');
	    			}
	    		});
            }
        });
    	}
   
    </script>
</body>
</html>