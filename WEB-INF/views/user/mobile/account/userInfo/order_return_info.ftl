<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的退换货</title>
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
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">我的退换货</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <#if list??>
            <#list list as order>
            <div class="borderbox">
                <ul class="prd-list order-prd-list">
                    <li>
                    <div  onclick="goto('${ctx}/m/account/toOrderDetail?orderId=${(order.orderId)!}');">
                        <div class="hd">
                            <span class="c">${(order.lastUpdateTime?datetime)!}</span>
                            <span class="r">
                            	${DICT('ORDER_PROPERTY_CD',order.orderPropertyCd)!'退款中'}
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
                           	 共${order.orderItem?size}件商品，合计：<span>${(order.orderProductAmt?string.currency)!}</span>
                        </div>
                        </div>
                        <div class="cz">
                        <a class="mui-btn mui-btn-danger mui-btn-outlined" onclick="cancelReturnGoods('${(order.orderId)!}');">
                        	取消退换货
                        </a>
                        </div>
                    </li>
                </ul>
            </div>
            </#list>
            </#if>
             <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
    <script>
    	function goto(url){
    		location.href = url;
    	}
    	
    	//取消退换货
    	function cancelReturnGoods(orderId){
    		var btnArray = ['取消', '确认'];
    		mui.confirm('', '确认取消退换货？', btnArray, function(e) {
            if (e.index == 0) {
            } else {
            
            	$.post('${ctx}/m/account/cancelReturnGoods',{'orderId':orderId},function(data){
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