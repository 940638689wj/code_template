<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>尾款支付</title>
    <script type="text/javascript" src="${staticPath}/js/vue.min.js"></script>
    <script type="text/javascript" src="${staticPath}/mobile/js/dateFormate1.js"></script>
    <script type="text/javascript" src="${staticPath}/mobile/js/sha1.js"></script>
	<style>
		[v-cloak] {
			display: none;
		}
	</style>
</head>
<body>
<div id='app' v-cloak>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/preSaleOrder/list"></a>
        <h1 class="mui-title">尾款支付</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r orange">{{orderStatus}}</div>
                            <div class="c">定金单号：{{masterOrderNumber}}</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div v-if='isExistAddr?true:false'>
            <div class="order-address orderdetail-address" v-if='isExistAddr?true:false'>
                <a href="#">
                    <span class="name">{{receiveName}}</span>
                    <span class="phone">{{receivePhone}}</span>
                    <address v-text="combAddr">{{combAddr}}</address>
                </a>
            </div>
		</div>
        <div v-if='isExistAddr?false:true'>
			<div class="order-address orderdetail-address" v-if='hasDefaultAddr?true:false'>
				<a href="/m/account/userAddress/selectAddressList?fromType=5&orderId=${orderId!}">
				<span class="name" v-text="address.receiverName"></span>
				<span class="phone" v-text="address.receiverTel"></span>
				<address v-text="nowCombAddr"></address>
				</a>
			</div>
			<input type="hidden" name="addrId" id="addrId" value="${addrId!}">
			<div class="order-address" v-show='hasDefaultAddr?false:true'>
				<a href="/m/account/userAddress/selectAddressList?fromType=5&orderId=${orderId!}">
					<address>您的收货信息为空，点此添加收货地址</address>
				</a>
			</div>
		</div>

        <div class="borderbox">
            <h3 class="title">商品清单</h3>
            <ul class="prd-list b-bottom">
                <li>
                    <div class="pic">
                        <img v-bind:src='defaultPic'>
                    </div>
                    <div class="r">
                        <p class="name">{{productName}}</p>
                        <p class="info"><span class="num"><i class="small">X</i>{{quantity}}</span></p>
                        <div class="price">
                            <div class="price-real">¥{{defaultPrice}}</div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="payment-info">
            <p><span class="fl gray"><h1>订单信息</h1></span></p>
            <p><span class="fl gray">尾款单号</span><span class="fr">{{orderNumber}}</span></p>
            <p><span class="fl gray">尾款期</span><span class="fr">{{payRemainTime}}</span></p>
            <p><span class="fl gray">尾款付款方式</span><span class="fr">{{payModel}}</span></p>
            <p><span class="fl gray">尾款付款状态</span><span class="fr">{{payStatus}}</span></p>
            <p><span class="fl gray">订单备注</span><span class="fr">{{remark}}</span></p>
            <p><span class="fl gray">已付定金</span><span class="fr orange">¥{{payForDpositAmt}}</span></p>
            <p><span class="fl gray">待付尾款</span><span class="fr orange">¥{{realAmt}}</span></p>
            <p v-if='isExistAddr?true:false'><span class="fl gray">快递公司</span><span class="fr orange" >{{expressName}}</span></p>
            <p><span class="fl gray">快递费用</span><span class="fr orange" v-if='isExistAddr?false:true'>{{nowExpressAmt}}</span>
                <span class="fr orange" v-if='isExistAddr?true:false'>¥{{expressAmt}}</span>
			</p>
            <p><span class="fl gray">应付总额</span><span class="fr orange">¥{{payAmt}}</span></p>
        </div>
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                	 <li class="itemlink" v-if="isExistAddr?false:true">
                        <div class="c">配送方式</div>
                        <div class="s">
                            <select v-model="form.expressId">
                                <option value="-1">请选择</option>
                                <option v-for="express in expressList" :value="express.expressId">{{express.expressName}}￥{{express.orderExpressAmt}}</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r">
                                <div class="mui-switch mui-switch-mini" onclick="balancePay()">
                                    <div class="mui-switch-handle"></div>
                                </div>
                            </div>
                            <div class="c">账户余额<span>¥{{userBalance}}</span></div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="fbbwrap fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap"></div>
                <div class="button-wrap bkno">
                    <a class="orderdetailbtn view" href="javascript:void(0)" onclick="cancelOrder()">取消订单</a>
                    <a class="orderdetailbtn" id="payOrder" href="javascript:void(0)">付尾款</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="J_ASSpec" class="actionsheet-spec" >
<!--微信支付-->
<div class="payment-method" v-show='isBalancePay?false:true'>
    <div class="close"></div>
    <div class="prod-info">
        <div class="title">请选择支付方式</div>
    </div>
    <div class="spec-list">
        <div class="spec-list-wrap">
            <ul class="tbviewlist paytypes">
                <li v-show='isWxBrowser'>
                    <a href="#" onclick="toPay('wechatpay')">微信支付</a>
                </li>
                <li v-show='isUnionpay'>
                    <a href="#" onclick="toPay('unionpay')">银联支付</a>
                </li>
                <li v-show='isWxBrowser?false:true'>
                    <a href="#" onclick="toPay('alipay')">支付宝支付</a>
                </li>
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
        <div class="title">支付订单金额<span class="orange">￥{{payAmt}}</span>元</div>
    </div>
    <div class="paymentwrap">
        <div class="orderinfo">
            <P>请{{hasPayPwd?'输入支付密码':'设置'}}</P>
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
                <a href="javascript:void(0)" class="button" v-on:click='subOrder'>确定</a>
                <a href="javascript:void(0)" class="button cancel">取消</a>
            </div>
        </div>
    </div>
</div>

</div>
<script>
var orderId = ${orderId!};
var app = new Vue({
		el : '#app',

		data : {
			form:{
			expressId:-1,
			addrId:-1,
			productId:-1
			},
			<#--快递列表-->
			expressList:[],
            expressName:'',
			<#--快递费用-->
			expressAmt:'0.00',
			totalWeight:0,
			<#--应付总额-->
			payAmt:'',
			<#--尾款时间-->
			payRemainTime:'',
			<#--已付定金-->
			payForDpositAmt:'',
			orderNumber:'',
			masterOrderNumber:'',
			<#--应付总额-->
			totalAmt:'',
			realAmt:'',
			defaultPic:'',
			productName:'',
			defaultPrice:'',
			quantity:'',
			createTime:'',
			payModel:'',
			payStatus:'',
			orderStatus:'',
			remark:'',
			balancePayAmt:0,
			realPayAmt:'',
			userBalance:'',
			address:'',
            nowCombAddr:'',
            combAddr:'',
            receivePhone:'',
            receiveName:'',
			<#--是否地址已选择-->
            isExistAddr:false,
			isUnionpay : false,
			isWxBrowser : false,
			isForDeposit: true,
			isBalancePay: false,
			hasBalancePay:false,
			hasPayPwd: false,
			hasDefaultAddr:false,
			isInTime:true

		},
		computed: {
			nowExpressAmt:function(){
				if(!this.expressList){return 0}
				for(var i = 0; i < this.expressList.length; i++) {
            		if(this.expressList[i].expressId == this.form.expressId) {
            			this.payAmt=(parseFloat(this.expressList[i].orderExpressAmt)+parseFloat(this.realAmt)).toFixed(2);
                        this.expressAmt= (this.expressList[i].orderExpressAmt).toFixed(2);
            			return "¥"+(this.expressList[i].orderExpressAmt).toFixed(2);
            		}
            	}
			}
		},
		methods : {
			subOrder: function(){
	        	if(this.hasPayPwd){
	        		var pwd = $("#pwd-input").val();
	        		if(pwd.length==6){
	        			mui.toast("订单已提交，请稍等!");
	        		}else if(pwd.length>0 && pwd.length< 6){
	        			mui.toast("请输入6位数的密码!");
	        		}else{
	        			mui.toast("请输入密码!");
	        		}
	        	}else{
	        		setPayPwd();
	        	}
	        }
		}

	});

	$(function(){
	    var ua = navigator.userAgent.toLowerCase();
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {
	        app.isWxBrowser = true;	//判断是否微信浏览器
	    }
		$.ajax({
			url : '${ctx}/m/account/preSaleOrder/submitOrderForRemain_json?orderId='+orderId,
			type : 'get',
			success : function(data){

				app.orderNumber=data.orderDetail.orderNumber;
				app.masterOrderNumber = data.orderDetail.masterOrderNumber;
				app.totalAmt=(data.orderDetail.orderTotalAmt).toFixed(2);
				app.payForDpositAmt=(data.orderDetail.payForDpositAmt).toFixed(2);
				app.realAmt=(eval(data.orderDetail.orderPayAmt) - eval(data.orderDetail.orderExpressAmt)).toFixed(2);
				app.payAmt=eval(data.orderDetail.orderPayAmt).toFixed(2);
				app.defaultPic=data.orderDetail.productPicUrl;
				app.productName=data.orderDetail.productName;
				app.defaultPrice=(data.orderDetail.salePrice).toFixed(2);
				app.quantity=data.orderDetail.quantity;
				app.createTime=Format(ConvertJSONDateToJSDateObject(data.orderDetail.createTime),"yyyy-MM-dd HH:mm");
				app.payRemainTime=Format(ConvertJSONDateToJSDateObject(data.orderDetail.allowPayRemainderStartTime),"MM.dd")+
								"--"+Format(ConvertJSONDateToJSDateObject(data.orderDetail.allowPayRemainderEndTime),"MM.dd");
				app.payModel=data.orderDetail.orderPayModelDesc;
				app.orderStatus=data.orderDetail.orderStatusDesc;
				app.payStatus = data.orderDetail.orderPayStatusDesc;
				app.remark=data.orderDetail.remark;
				app.userBalance = (data.userBalance).toFixed(2);
				if(eval(data.userBalance)<=0){
					$(".mui-switch").addClass("mui-disabled");
				}
				app.realPayAmt = (eval(data.orderDetail.orderPayAmt)- eval(data.orderDetail.orderExpressAmt)).toFixed(2);
				app.balancePayAmt =eval(data.orderDetail.orderTotalAmt - data.orderDetail.orderPayAmt).toFixed(2);
				app.isInTime = data.isInTime;
				app.form.productId=data.orderDetail.masterProductId;
				if(data.expressName!=null){
                    app.expressName=data.expressName;
					app.expressAmt = (data.orderDetail.orderExpressAmt).toFixed(2);
				}
				app.hasPayPwd = data.payPassword == null || data.payPassword == '' ?false:true;
				if(data.payWays.indexOf('unionpay')>=0)app.isUnionpay = true;
				if(data.totalWeight!=null){
					app.totalWeight = data.totalWeight;
				}
				getAddr();//加载收货地址
			}
		});
	});

	 //转换JSON数据中的时间为标准时间
	function ConvertJSONDateToJSDateObject(JSONDateString) {
	    var date = new Date(parseInt(JSONDateString));
	    return date;
	}
	 $(function(){
        var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        $("#payOrder").on("click", function () {
        	if(app.isInTime){
        		//var addrId = $("#addrId").val();
				if(!app.isExistAddr){
                    if(app.form.addrId==-2){
                        mui.toast("该收货地址暂不支持配送，请重新选择!");
                        return false;
                    }
                    if(app.form.addrId==-1){
                        mui.toast("收货地址不能为空!");
                        return false;
                    }
                    if(app.form.expressId==-1){
                        mui.toast("请选择快递!");
                        return false;
                    }
				}
        		paymentshow();
        	}else{
        		mui.toast("不在付款时间内,暂时无法支付！");
        	}

        });
        specAS.find(".close").on("click", function () {
            paymenthide();
        });

        $(".cancelBtn,.cancel").on("click", function () {
            paymenthide();
        });

        function paymentshow(){
        	//clearPwd();
            paymentMask.show().animate({opacity:1},{
                duration:80,
                complete: function () {
                    specAS.css({
                        top : "100%",
                        opacity : 0,
                        display : "block"
                    }).animate({
                        opacity : 1,
                        translateY:"-"+specAS.height() +"px"
                    },{
                        duration : 200,
                        easing : "ease-in-out"
                    });
                }
            });
            $(document).bind("touchmove",function(e){
                e.preventDefault();
            });
            $('.actionsheet-spec .spec-list')[0].addEventListener('touchmove', function(e) {
                e.stopPropagation();
            }, false);
        }

        function paymenthide(callback){
            specAS.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    specAS.hide();
                    paymentMask.animate({opacity:0},{
                        duration : 80,
                        complete: function () {
                            paymentMask.hide();
                            if(typeof callback == "function") callback.call();
                        }
                    });
                }
            });
            $(document).unbind("touchmove");
        }

        var $input = $(".fake-box input");
    $("#pwd-input").on("input", function() {
        var pwd = $(this).val().trim();
        for (var i = 0, len = pwd.length; i < len; i++) {
            $input.eq("" + i + "").val(pwd[i]);
        }
        $input.each(function() {
            var index = $(this).index();
            if (index >= len) {
                $(this).val("");
            }
        });
        if (len == 6) {
        	//SHA1加密
        	var payPwd = CryptoJS.SHA1($(this).val()).toString();

            //执行其他操作
			$.post('${ctx}/m/account/preSaleOrder/check_PayPwd',{payPwd:payPwd},function(data){
				if(data.result=='success'){
					if(eval(parseFloat(app.userBalance)) >= eval(parseFloat(app.payAmt))){
						//如果余额支付且余额足够，则直接支付
						var addrId = $("#addrId").val();
						$('#wait').addClass('mui-progressbar-infinite');
						$.ajax({
							url:'${ctx}/m/account/preSaleOrder/dealPreSaleOrder',
							type:'post',
							data:{
								"orderId":orderId,
								"payWay":"balancePay",
								"addrId":app.form.addrId,
								"expressId":app.form.expressId
							},
							dataType:'json',
							success:function(data){
								paymenthide();
								clearPwd();
								if(data.result=='success'){
									mui.toast('支付成功!');
									location.href = "${ctx}/m/account/preSaleOrder/toPaySuccessPage?orderId="+data.data;
								}else{
									mui.alert(data.message);
									location.href="${ctx}/m/account/preSaleOrder/submitOrderForRemain?orderId="+orderId;
								}
							},
							error:function(){
								paymenthide();
								clearPwd();
								mui.alert('网络出错，请稍后再试！');
							}
						});
					}else{
						//如果余额支付但余额不足，则再次弹出微信支付框
						app.isBalancePay = false;
						fullBalanceFlag = false;
						mui.toast('余额不足，请选择支付方式！');
						paymentshow();
					}

				}else{
					mui.toast('支付密码错误！');
					clearPwd();
				}
			})
        }
    });

	});



    //计算余额支付后的金额
	function balancePay(){
		if($(".mui-switch").hasClass('mui-active')){
			app.isBalancePay = true;
			var payAmt = eval(app.userBalance - app.payAmt);//应付金额
			if(payAmt < 0){
				app.realPayAmt = app.userBalance;
				app.hasBalancePay = true;
			}else{
                app.realPayAmt = 0.00;
				app.hasBalancePay = true;
			}
			if(app.userBalance <=0){
				app.hasBalancePay = false;
			}
		}else{
			app.isBalancePay = false;
			app.hasBalancePay = false;
		}
	}

    function toPay(payWay){
	switch(payWay){
		case 'wechatpay':
			payWay = app.hasBalancePay?'wechatpay_balance':'wechatpay';
			break;
		case 'alipay':
			payWay = app.hasBalancePay?'alipay_balance':'alipay';
			break;
		case 'unionpay':
			payWay = app.hasBalancePay?'unionpay_balance':'unionpay';
			break;
	}
	//如果余额支付且余额足够，则直接支付
	var addrId = $("#addrId").val();
	$.ajax({
		url:'${ctx}/m/account/preSaleOrder/dealPreSaleOrder',
		type:'post',
		data:{
			"orderId":orderId,
			"payWay":payWay,
			//"type":"downPayment",
			"addrId":app.form.addrId,
			"expressId":app.form.expressId
		},
		dataType:'json',
		success:function(data){
			//paymenthide();
			clearPwd();
			if(data.result=='success'){
				window.location.href = '${ctx}/m/account/order/goToOrderPayment?payWay='+data.data.payWay+'&orderNumber='+data.data.orderNumber;
			}else{
				mui.alert(data.message);
			}
		},
		error:function(){
			//paymenthide();
			clearPwd();
			mui.alert('网络出错，请稍后再试！');
		}
	});
}
//跳转到设置支付密码页面
function setPayPwd(){
	var addrId = $("#addrId").val();
	var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=m%2faccount%2fpreSaleOrder%2fsubmitOrderForRemain%3forderId%3d'+orderId+'%26addrId%3d'+addrId;
	window.location.href = _url;
}

function clearPwd(){
	$("#pwd-input").val('');
	$('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
}

function getAddr(){
	var addrId = $("#addrId").val();
	$.ajax({
			url : '${ctx}/m/account/preSaleOrder/getAddr',
			type : 'GET',
			dataType:'json',
			data:{"addrId":addrId,"orderId":orderId},
			success : function(data){
				if(data.combAddr!=null && data.combAddr!=''){
                    app.isExistAddr =data.isExistAddr;
                    app.combAddr = data.combAddr;
                    app.receivePhone = data.receivePhone;
                    app.receiveName = data.receiveName;
				}
				if(data.addr!=null){
                    app.address=data.addr;
					app.nowCombAddr=data.nowCombAddr;
					getExpressList(data.addr.addrId);
					$("#addrId").val(data.addr.addrId);
					app.hasDefaultAddr=true;
					app.form.addrId=data.addr.addrId
					checkAddr();
				}
			},
			error:function(){
                mui.alert('网络出错，请稍后再试！');
			}
	});
}

function getExpressList(addrId){
		$.ajax({
            url: '${ctx}/m/account/preSaleOrder/getExpressList',
            async: true,
            type: 'GET',
            dataType: 'json',
            data: {'addrId': addrId, 'weight': app.totalWeight},
            success: function (result) {
                if (result.result == 'success') {
                    app.expressList = result.data.orderExpressList;
                }
            },
            error: function (XMLHttpResponse) {
                console.log('请求未成功');
            }
        })
	}

function checkAddr(){
		if(app.form.addrId == -1){
			return false;
		}
		$.ajax({
                url: '/m/account/preSaleOrder/testAddress',
                async: true,
                type: "GET",
                dataType: "json",
                data: {"addrId": app.form.addrId, "productId": app.form.productId},
                success: function (result) {
                    if (result.result != 'success') {
                        app.form.addrId = -2;
                        mui.alert(result.message);
                    }
                },
                error: function (XMLHttpResponse) {
                    console.log("请求未成功");
                }
            });
}

function cancelOrder(){
	var btnArray = ['确认', '关闭'];
    mui.confirm('', '确认要取消该订单？', btnArray, function(e) {
        if (e.index == 0) {
        	$.ajax({
				url:'${ctx}/m/account/preSaleOrder/cancelOrder',
				type:'post',
				data:{
					"orderId":orderId
				},
				dataType:'json',
				success:function(data){
					if(data.result=='success'){
						mui.toast('订单已取消');
						location.href='${ctx}/m/account/preSaleOrder/detail/'+orderId;
					}else{
						mui.toast(data);
					}
				},
				error:function(){
					mui.alert('网络出错，请稍后再试！');
				}
			});
        }
    });
}
</script>
</body>
</html>