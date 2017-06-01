<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title>定金支付</title>
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body>
<div :controller="app" class="ms-controller">
    <div id="main">
        <div class="checkout">
            <div class="checkout-tit">定金支付</div>
            <div class="checkout-steps">
                <div class="step-wrap noborder">
                    <div class="step-tit">
                        <h3>商品信息</h3>
                    </div>
                    <div class="shoptb">
                        <div class="shoptb-hd">
                            <table>
                                <tbody>
                                <tr>
                                    <td class="td-product">商品</td>
                                    <td class="td-price">单价</td>
                                    <td class="td-amount">数量</td>
                                    <td class="td-total">定金小计</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="shoptb-row">
                            <table>
                                <tbody id="productData">
                                <tr>
                                    <td class="td-product">
                                        <div class="first-column">
                                            <div class="img"><a :attr="{href: '/product/' + orderDetail.masterProductId}"><img :attr="{src:orderDetail.productPicUrl}"></a></div>
                                            <div class="info">
                                                <div class="name"><a :attr="{href: '/product/' + orderDetail.masterProductId}" target="_blank">{{orderDetail.productName}}</a></div>
                                                <div class="prop" :if="orderDetail.skuDesc !=null && orderDetail.skuDesc !=''"><span>{{orderDetail.skuDesc}}</span>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="td-price">￥{{orderDetail.salePrice}}</td>
                                    <td class="td-amount">{{orderDetail.quantity}}</td>
                                    <td class="td-total"><em>￥{{orderDetail.orderTotalAmt}} </em></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="step-wrap">
                    <div class="order-ft">
                    	<div class="order-extra">
                            <div class="formList order-extra">
                                <div class="item">
                                    <div class="hd">余额支付</div>
                                    <div class="bd">
                                        <input id="balancePay" type="checkbox" name="integral"><span class="infotext">当前余额￥<span id="userBalance">{{userBalance}}</span>，是否使用</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="order-total">
                            <div class="row">
                                <div class="tit">应付订金：</div>
                                <div class="con" id="preAmt">￥{{orderDetail.orderTotalAmt}}</div>
                            </div>
                            <div class="row">
                                <div class="tit">尾款：</div>
                                <div class="con" id="remainAmt">￥{{orderDetail.salePrice - orderDetail.orderTotalAmt}}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="trade-foot">
            <div class="trade-foot-detail">
                <div class="fc-price-info">
                    <span class="price-tit">应付订金：</span>
                   	<span class="price-num" id="payAmt">￥{{orderPayAmt}}</span>
                   	<span :if="orderDetail.orderTotalAmt -orderDetail.orderPayAmt > 0">(余额已支付￥{{orderDetail.orderTotalAmt -orderDetail.orderPayAmt}})</span>
                </div>
            </div>
            <div class="inner">
                <button id="btnBuy">支付订金</button>
            </div>
        </div>
    </div>
	<input type="hidden" id="orderId" value="${orderId!}">
    <div id="payment" class="hidden">
        <div class="paytypes">
            <ul>
                <li ms-for="($key,$val) in @payTypeList">
                    <a href="javascript:;" ms-if="$key == 'config_alipay_pc'" ms-click="alipay()">支付宝支付</a>
                    <a href="javascript:;" ms-if="$key == 'config_unionpay_pc'" ms-click="unionpay()">银联支付</a>
                    <a href="javascript:;" ms-if="$key == 'weixin_pay_config'" ms-click="wxpay()">微信支付</a>
                </li>
            </ul>
        </div>
    </div>
    <div id="payPassword"  class="hidden">
        <div class="formList paypassword">
            <div class="item">
                <div class="hd">输入支付密码：</div>
                <div class="bd">
                    <input type="password" class="textfield">
                </div>
            </div>
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <a class="v-btn" href="#">确定</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script> 
<script>
	var vm = avalon.define({
        $id: 'app',
        // ---数据---
        orderDetail:'',
        userBalance:0.00,
        orderPayAmt:'',
        <#--是否在支付时间内-->
        isInTime:false,
        <#--是否余额参与支付-->
        hasBalancePay:false,
        hasPwd:false,
        <#--支付方式-->
        payTypeList:[],
        // ---方法---
        // 加载订单数据
        getOrderDetail: function () {
            var orderId = $("#orderId").val();
			$.ajax({
					url : '${ctx}/account/preSaleOrder/payForDeposit_Json?orderId='+orderId,
					type : 'get',
					success : function(data){
						if(data!=null){
							vm.orderDetail = data.orderDetail;
							vm.orderPayAmt = data.orderDetail.orderPayAmt;
							vm.payTypeList = data.onlinePayTypeList;
							vm.userBalance = data.userBalance;
							if(data.userBalance<=0){
								$("#balancePay").attr("disabled","true");
							}
							vm.isInTime = data.isInTime;
							if(data.payPassword!=null && data.payPassword!=''){
								vm.hasPwd = data.payPassword;
							}
							
						}
					}
			});
        },
        alipay: function(){
        	if(vm.hasBalancePay){
        		vm.toPay("alipay_balance");
        	}else{
        		vm.toPay("alipay");
        	}
        },
        unionpay: function(){
        	if(vm.hasBalancePay){
        		vm.toPay("unionpay_balance");
        	}else{
        		vm.toPay("unionpay");
        	}
	        	
        },
        wxpay: function(){
        	if(vm.hasBalancePay){
        		vm.toPay("wechatpay_balance");
        	}else{
        		vm.toPay("wechatpay");
        	}
        },
        toPay: function(payWay){
        		var orderId = vm.orderDetail.orderId;
	        	$.ajax({
				url:'${ctx}/account/preSaleOrder/dealPreSaleOrder',
				type:'post',
				data:{
					"orderId":orderId,
					"payWay":payWay,
					"type":"downPaymentForList",
					"originPlatformCd":"0"
				},
				dataType:'json',
				success:function(data){
					if(data.result=='success'){
						if(payWay=="balancePay"){
							layer.alert('支付成功！', function () {
                             window.location.href ='/account/preSaleOrder/toPreSaleOrderList';
                        	});
						}else{
							window.location.href = '/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
						}
					}else{
						layer.alert(data.message);
					}
				},
				error:function(){
					layer.alert('网络出错，请稍后再试！');
				}
			});
        },
        payment: function (){
	        layer.open({
	            type: 1,
	            title: '选择支付方式',
	            skin: 'layui-layer-rim',
	            shade: [0.6],
	            area: ['360px'],
	            content: $("#payment")
	        });
    	}
        
    });
	
// 初始化 回调
    vm.$watch('onReady', function () {
        vm.getOrderDetail();
    });
    
    $("#btnBuy").on("click",function(){
        	if(!vm.isInTime){
				layer.alert("不在预售定金期内!");
				return;
			}
        	var balancePay = $("#balancePay").is(':checked');
        	if(balancePay){
        		vm.hasBalancePay = true;
	        		if(!vm.hasPwd){
	        			layer.confirm('请先设置支付密码',function(){
	                        setPayPwd();
	                    });
	        		}else{
	        			paypassword();
	        		}
	        	if(eval(vm.userBalance)<=0){
	        		vm.hasBalancePay = false;
	        	}
        	}else{
        		vm.payment();
        	}
        })
        
        //校验密码
    $('#payPassword .v-btn').click(function () {
        layer.close(payPassword);
        var reg = /^\d{6}$/;
        var payPwd = $("#payPassword input").val();
        if (reg.test(payPwd)) {
            //SHA1加密
            var payPwd = CryptoJS.SHA1(payPwd).toString();
            //执行其他操作
            $.post('/account/preSaleOrder/check_PayPwd', {payPwd: payPwd}, function (data) {
                if (data.result == 'success') {
                	if(eval(vm.orderPayAmt) > eval(vm.userBalance)){
                		layer.msg("当前余额不足,请选择其他支付方式!");
	        			setTimeout("payment()",500);
                	}else{
                		vm.toPay("balancePay");
                	}
                } else {
                    layer.msg('支付密码错误！');
                    $("#payPassword input").val('');
                }
            })
        } else {
            layer.close(payPassword);
            $("#payPassword input").val('');
            layer.msg('密码错误！');
        }
    })
	//跳转到设置支付密码页面
    function setPayPwd() {
        var _url = '/account/userChangePaw?type=2&successUrl=' + encodeURIComponent(window.location.href);
        window.location.href = _url;
    }
</script>
<script>
    $(function(){
        $(".topshopcart").hover(getCartContent, removeCartContent);

        $("#newaddressBtn").on("click",function(){
            newaddress();
        })

    })
    function getCartContent(){
        $(".topshopcart").addClass("cart-hover");
    }
    function removeCartContent(){
        $(".topshopcart").removeClass("cart-hover");
    }

    var newAddress;
    function newaddress(){
        newAddress = layer.open({
            type: 1,
            title: '新增地址',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['720px'],
            content: $("#newddress")
        });
    }

    function payment(){
        layer.open({
            type: 1,
            title: '选择支付方式',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px'],
            content: $("#payment")
        });
    }

    var payPassword;
    function paypassword(){
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px','200px'],
            content: $("#payPassword")
        });
    }
</script>
</body>
</html>