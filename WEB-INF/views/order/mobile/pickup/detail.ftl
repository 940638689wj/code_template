<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>订单详情</title>
</head>
<body>
<div id="app">
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/pickupOrder/list?type=${type!}"></a>
        <h1 class="mui-title">提货订单详情</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
	<div class="mui-content">
	        <div class="tbviewlist categorylist">
	            <ul>
	                <li>
	                    <a href="javascript:void(0);">
	                        <div class="r orange"><#if orderReceiveInfo.orderDistrbuteTypeCd == 2>待自提<#elseif type == 4>已完成<#elseif type == 1>待付款<#elseif type == 2>待发货<#elseif type ==3>待收货<#elseif type==5>已取消</#if></div>
	                        <div class="c">订单号：${(orderHeader.orderNumber)!}</div>
	                    </a>
	                </li>
	            </ul>
	        </div>
	        <#if orderReceiveInfo?? && orderReceiveInfo.orderDistrbuteTypeCd?has_content && orderReceiveInfo.orderDistrbuteTypeCd == 2>
		        <div class="order-address orderdetail-address">
		            <address>提货门店：${(storeDTO.storeName)!}</address>
		            <address>提货地址：${(storeDTO.detailAddress)!}</address>
		            <address>电话:${(storeDTO.telephone)!}</address>
		        </div>
	        <#else>
		        <div class="order-address orderdetail-address">
		            <address>收货人:${(orderReceiveInfo.receiveName)!}</address>
		            <address>联系方式:${(orderReceiveInfo.receiveTel)!}</address>
		            <address>收货地址：${(orderReceiveInfo.receiveAddrCombo)!}</address>
		        </div>	        	
	        </#if>
	        <div class="redeemlist">
	            <ul>
	                <li>
	                    <div class="r"><a class="code" href="#middlePopover"></a></div>
	                    <div class="c">订单号：${(orderHeader.orderNumber)!}</div>
	                </li>
	            </ul>
	        </div>
	        
	        <div class="borderbox mb0">
        <h3 class="title">商品清单</h3>
        <ul class="prd-list b-bottom">
        <#if goodsList?? && goodsList?has_content>
            <#list goodsList as goods>
                <li>
                    <div class="pic">
                        <img src="${(goods.productPicUrl)!}">
                    </div>
                    <div class="r">
                        <p class="name">${goods.productName!}</p>
                        <p class="info"><span class="num"><i class="small">X</i>${goods.quantity!}</span><span class="specifications"></span></p>
                        <div class="price">
                            <div class="price-real">¥${goods.productTotal!}</div>
                        </div>
                    </div>
                </li>
            </#list>
        </#if>
        </ul>
    </div>
	        <div class="payment-info">
	            <p><span class="fl gray">运费</span><span class="fr">¥${(orderHeader.orderExpressAmt)!0}</span></p></span></p>
	        </div>
	        <div class="payment-info">
	            <p><span class="fl gray">下单时间</span><span class="fr">${createTime!}</span></p>
				<p><span class="fl gray">付款时间</span><span class="fr">${(orderHeader.orderPayTime?string('yyyy-MM-dd HH:mm:ss'))!}</span></p>
	        </div>
	
	        <div class="fbbwrap fbbwrap-total">
	            <div class="ftbtnbar">
	                <div class="content-wrap"></div>
	                <div class="button-wrap bkno">
						<#if orderHeader.orderStatusCd ==1>
                            <a class="orderdetailbtn" @click="rePay(${(orderHeader.orderId)!})">付款</a>
                            <a class="orderdetailbtn" @click="cancelOrder(${(orderHeader.orderId)!})">取消订单</a>
						</#if>
						<#if orderHeader.orderStatusCd == 3 && orderReceiveInfo.orderDistrbuteTypeCd == 1>
	                   		 <a class="orderdetailbtn" @click="confirmOrder(${(orderHeader.orderId)!})">确认收货</a>
						</#if>
						<#if orderHeader.orderStatusCd == 6><a class="orderdetailbtn" @click="deleteOrder(${(orderHeader.orderId)!})">删除订单</a></#if>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <div id="middlePopover" class="mui-popover codeshowbox">
	        <div class="mui-popover-arrow"></div>
	        <div class="codeshow"><img src="${ctx}/qrCode/generate?content=${content!}"></div>
	    </div>
    <div id="J_ASSpec" class="actionsheet-spec">
        <!--微信支付-->
        <div class="payment-method" v-show='isBalancePay?false:true'>
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择支付方式</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                        <li v-for="(value,key) in bussinessConfigTypeList">
                            <a href="javascript:void(0)" onclick="toPay('alipay')"
                               v-if="key == 'config_alipay_mobile'">支付宝支付</a>
                            <a href="javascript:void(0)" onclick="toPay('unionpay')"
                               v-if="key == 'config_unionpay_mobile'">银联支付</a>
                            <a href="javascript:void(0)" onclick="toPay('wechatpay')"
                               v-if="key == 'weixin_pay_config'">微信支付</a>
                            <a href="javascript:void(0)" @click="isBalancePay = true"
                               v-if="key == 'userBalnce'">余额支付</a>
                        </li>

                        <#--
                        <li v-show='isWxBrowser'>
                            <a href="javascript:void(0)" onclick="toPay('wechatpay')">微信支付</a>
                        </li>
                        <li id="balancePay">
                            <a href="javascript:void(0)" @click="isBalancePay = true">余额支付</a>
                        </li>
                        <li v-show='isWxBrowser?false:true'>
                            <a href="javascript:void(0)" onclick="toPay('alipay')">支付宝</a>
                        </li>
                        -->
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button cancelBtn">取消</a>
                    </div>
                </div>
            </div>
        </div>

        <!--余额支付-->
        <div class="ye-payment" v-show='isBalancePay'>
            <div class="prod-info">
                <div class="title">支付订单金额<span class="orange">￥{{balancePayAmt}}</span>元</div>
            </div>
            <div class="paymentwrap">
                <div class="orderinfo">
                    <p v-show="hasPayPwd">当前余额￥{{userBalance}}</p>
                    <P>请{{hasPayPwd?'输入':'设置'}}支付密码</P>
                </div>
                <div class="pwd-box">
                    <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
                    <div class="fake-box" v-show='hasPayPwd'>
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                    </div>
                </div>
                <div class="orderinfo" v-show='hasPayPwd?false:true'>
                    <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="javaScript:setPayPwd()" class="textcolor">设置支付密码</a>！</p>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button" onclick="checkPayPwd()">确定</a>
                        <a href="javascript:void(0)" class="button cancel">取消</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="show-abnormal-bg" id="returnDlg1"></div>
  </div>
</div>
<script type="text/javascript" src="${ctx}/static/mobile/js/sha1.js"></script>
<script>
	mui('body').on('shown', '.mui-popover', function(e) {
		console.log( e.detail.id);//detail为当前popover元素
	});
	mui('body').on('hidden', '.mui-popover', function(e) {
		console.log(e.detail.id);//detail为当前popover元素
	});
	var app = new Vue({
		el:"#app",
		data: {
            bussinessConfigTypeList: {},
            hasPayPwd: false,
            isBalancePay: false,
            balancePayAmt: 0,
            userBalance: 0,
            currentOrderId:${orderHeader.orderId?default(0)},
            reasonDetailDesc: '',
            applyReasonCd: 0,
            isWxBrowser: 0
		},
		computed:{
			isWxBroser: function(){
                var ua = navigator.userAgent.toLowerCase();
                return ua.match(/MicroMessenger/i) == "micromessenger"
			}
		},
		methods: {
			rePay : function(){
                $.get('${ctx}/account/pickupOrder/repayJson', {orderId: app.currentOrderId}, function (data) {
                    if(new Date(data.allowUseEndTime) < new Date()){
                        mui.alert("该提购券已过期，无法购买！");
                        return false;
                    }
                    app.bussinessConfigTypeList = data.bussinessConfigTypeList;
                    app.balancePayAmt = data.orderPayAmt;
                    app.userBalance = data.userBalance;
                    if(data.payPassword != null && data.payPassword != '') app.hasPayPwd = true;
                    paymentshow();

                })
			},
			confirmOrder: function(){
                var btnArray = ['取消', '确认'];
                mui.confirm('', '是否确定收货?', btnArray, function(e) {
                    if (e.index == 0) {
                    } else {
                        $.post('${ctx}/m/account/pickupOrder/confirmReceipt',{orderId:app.currentOrderId},function(data){
                            if(data.result == 'success'){
                                mui.toast('交易完成');
                                location.reload();
                            }else{
                                mui.toast('操作失败');
                            }
                        });
                    }
                });
			},
            cancelOrder: function(){
                mui.prompt('', '', '请输入取消原因', ['取消', '确认'], function (e) {
                    if (e.index == 1) {
						alert(this.currentOrderId);
						alert("1111111111111111")
                        $.get('${ctx}/account/pickupOrder/cancelPickOrder', {orderId: app.currentOrderId, reason: e.value}, function (data) {
                            if (data.result == 'success') {
                                mui.toast('取消成功！');
                                location.reload();
                            } else {
                                mui.alert(data.message);
                            }
                        });
                    }
                });
			},
			deleteOrder: function(){
                mui.confirm('','是否确认删除订单？',['取消','确认'], function (e) {
                    if (e.index == 1) {
                        $.get('${ctx}/account/pickupOrder/deletePickOrder', {orderId: app.currentOrderId}, function (data) {
                            if (data.result == 'success') {
                                mui.toast('删除成功！');
                                location.href = "${ctx}/m/account/pickupOrder/list?type=${type!}"
                            } else {
                                mui.alert(data.message);
                            }
                        });
                    }
                })
			}

		}
	});


    function setPayPwd() {
        var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=' + encodeURIComponent(window.location.href);
        window.location.href = _url;
    }

    var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
            }).appendTo(document.body),
            specAS = $("#J_ASSpec");

    specAS.find(".close").on("click", function () {
        paymenthide();
    });

    $(".cancelBtn,.cancel").on("click", function () {
        paymenthide();
    });
	//显示支付框
    function paymentshow() {
        clearPwd();
        paymentMask.show().animate({opacity: 1}, {
            duration: 80,
            complete: function () {
                specAS.css({
                    top: "100%",
                    opacity: 0,
                    display: "block"
                }).animate({
                    opacity: 1,
                    translateY: "-" + specAS.height() + "px"
                }, {
                    duration: 200,
                    easing: "ease-in-out"
                });
            }
        });
        $(document).bind("touchmove", function (e) {
            e.preventDefault();
        });
        $('.actionsheet-spec .spec-list')[0].addEventListener('touchmove', function (e) {
            e.stopPropagation();
        }, false);
    }

    function paymenthide(callback) {
        app.isBalancePay = false;
        specAS.animate({
            opacity: 0,
            translateY: 0
        }, {
            duration: 200,
            easing: "ease-in-out",
            complete: function () {
                specAS.hide();
                paymentMask.animate({opacity: 0}, {
                    duration: 80,
                    complete: function () {
                        paymentMask.hide();
                        if (typeof callback == "function") callback.call();
                    }
                });
            }
        });
        $(document).unbind("touchmove");
    }

    var $input = $(".fake-box input");
    $("#pwd-input").on("input", function () {
        var pwd = $(this).val().trim();
        for (var i = 0, len = pwd.length; i < len; i++) {
            $input.eq("" + i + "").val(pwd[i]);
        }
        $input.each(function () {
            var index = $(this).index();
            if (index >= len) {
                $(this).val("");
            }
        });
        if (len == 6) {
            checkPayPwd();
        }
    });

    function checkPayPwd() {
        var pwd = $("#pwd-input").val().trim();
        if (!/^\d{6}$/.test(pwd)) {
            mui.toast('支付密码错误！');
            clearPwd();
            return false
        }
        //SHA1加密
        var payPwd = CryptoJS.SHA1(pwd).toString();

        //执行其他操作
        $.post('${ctx}/m/account/groupPurchaseOrder/checkPayPwd', {payPwd: payPwd}, function (data) {
            if (data.result == 'success') {
                toPay('balancePay');
            } else {
                mui.toast('支付密码错误！');
                clearPwd();
            }
        })
    }

    //处理支付
    function toPay(payWay) {
        $.ajax({
            url: '${ctx}/account/pickupOrder/repayOrder',
            type: 'post',
            data: {
                orderId: app.currentOrderId,
                payWay: payWay
            },
            dataType: 'json',
            success: function (data) {
                if (data.result == 'success') {
                    if (payWay == 'balancePay') {
                        mui.toast('支付成功！');
                        location.reload();
                    } else {
                        window.location.href = '/m/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
                    }
                } else {
                    mui.alert(data.message);
                }
            },
            error: function () {
                mui.alert('网络出错，请稍后再试！');
            }
        });
    }

    function clearPwd() {
        $("#pwd-input").val('');
        $('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
    }
</script>
	</body>
	</html>
