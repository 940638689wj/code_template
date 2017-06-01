<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
  <title>订单详情</title>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
	<header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/orderReturnInfo?type=${type}"></a>
        <h1 class="mui-title">订单详情</h1>
        <a class="mui-icon"></a>
    </header>
    </#if>
    <div class="mui-content">
        <div class="toptip">
            <!-- <div>提示：请在 15:00 内付款，否则该订单取消！</div> -->
        </div>
        <div class="order-address orderdetail-address">
            <span class="name">${orderReceiveInfo.receiveName!}</span>
            <span class="phone">${orderReceiveInfo.receiveTel!}</span>
            <address>${orderReceiveInfo.receiveAddrCombo!} </address>
        </div>
        <div class="sure-list">
        	<#if (goodsList?size>0)>
	            <h3><span class="goods"></span>商品清单</h3>
	            <ul>
	            	<#list goodsList as goods>
		                <li>
		                    <div class="name">
		                    	${goods.productName}
		                    	<#if goods.applyStatus?has_content>(${goods.applyType}${goods.applyStatus})</></#if>
		                    	</div>
		                    <div class="num"> 
		                    	<span>x</span>${goods.quantity}</div>
		                    <div class="price">￥${goods.productTotal}</div>
		                </li>
	                </#list>
	            </ul>
            </#if>
            <#if (dishList?size>0)>
	            <h3><span class="dishes"></span>菜品清单</h3>
	            <ul>
	            	<#list dishList as dish>
		                <li>
		                    <div class="name">
		                    	${dish.productName}
		                    	<#if dish.applyStatus?has_content>(${dish.applyType}${dish.applyStatus})</#if>
		                    </div>
		                    <div class="num">
		                    	<span>x</span>${dish.quantity}</div>
		                    <div class="price">￥${dish.productTotal}</div>
		                </li>
	                </#list>
	            </ul>
            </#if>
            <!--
            <dl>
                <dt>配送费</dt>
                <dd>￥${orderHeader.orderExpressAmt!}</dd>
            </dl>
            <P class="info">已使用***优惠</P> 
            -->
            <dl>
                <dt><span></span><span></span></dt>
                <dd>退款<span>￥${totalReturnAmt!}</span></dd>
            </dl>
        </div>

        <div class="borderbox">
            <div class="title">订单信息</div>
            <div class="order-info">
                <ul>
                    <li><p>订单号码：</p><span>${orderHeader.orderNumber!}</span></li>
                    <li><p>订单时间：</p><span>${orderHeader.createTime?datetime}</span></li>
                    <li><p>买家留言：</p><span>${orderHeader.orderRemark!"无"}</span></li>
                </ul>
            </div>
        </div>

		<div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in">
                        <!-- <div class="l orange">待付款</div> -->
                    </div>
                </div>
                <div class="button-wrap">
                    <a class="button" id="complain">投诉</a>
                </div>
            </div>
        </div>
    </div>

	<div class="show-abnormal-bg"></div>
    <div class="mui-abnormal">
        <div class="service">
            <div class="info">
                <h3>如需投诉请拨打以下客服热线：</h3>
                <div class="servicetell">
                    <p><a href="tel:010-00000000">010-00000000</a></p>
                    <p><a href="tel:010-00000000">010-00000000</a></p>
                </div>
                <P></P>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" class="cancelService">取消</a>
            </div>
        </div>
    </div>

</div>

<script>
    $(function(){
        $("#complain").on("click",function(){
            $(".show-abnormal-bg").addClass("mui-active");
            $(".mui-abnormal").addClass("mui-popup-in");
            document.ontouchmove = function () {
                return false;
            }
        })

        $("#submit,#change,.cancelService").on("click",function(){
            $(".show-abnormal-bg").removeClass("mui-active");
            $(".mui-abnormal").removeClass("mui-popup-in");
            document.ontouchmove = null;
        })

    }) 
</script>
</body>
</html>