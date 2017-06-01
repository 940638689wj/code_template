<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>支付定金</title>
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
        <h1 class="mui-title">支付定金</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r orange" v-html="">{{orderStatus}}</div>
                            <div class="c">订单号：{{orderNumber}}</div>
                        </a>
                    </li>
                </ul>
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
            <p><span class="fl gray">下单时间</span><span class="fr">{{createTime}}</span></p>
            <p><span class="fl gray" v-html='isForDeposit?"定金付款方式":"尾款付款方式"'></span>
            <span class="fr">{{payModel}}</span></p>
            <p><span class="fl gray" v-html='isForDeposit?"定金付款状态":"尾款付款状态"'></span>
            <span class="fr">{{payStatus}}</span></p>
            <p><span class="fl gray" >添加备注</span><span class="fr">{{remark}}</span></p>
            <p v-show='isNeedPay?true:false'><span class="fl gray" v-html='isForDeposit?"待付定金":"待付尾款"'></span>
	           <span class="fr orange" v-show='isShowBalancePayAmt?true:false'>(余额已支付¥{{balancePayAmt}})</span>
	           <span class="fr orange">¥{{realAmt}}</span></p>
	        
	        <p v-show='isNeedPay?false:true'><span class="fl gray" v-html='isForDeposit?"已付定金":"已付尾款"'></span>
	           <span class="fr orange" v-show='isShowBalancePayAmt?true:false'>(余额已支付¥{{balancePayAmt}})</span>
	           <span class="fr orange">¥{{realAmt}}</span></p>
        </div>
        <div class="borderbox">
            <div class="tbviewlist categorylist">
		        <ul>
			        <li>
			            <a href="javascript:void(0);">
			                <div class="r">
			                    <div class="mui-switch mui-switch-mini" id="balanceSwitch" onclick="isbalancePay()">
			                        <div class="mui-switch-handle"></div>
			                    </div>
			                </div>
			                <div class="c">账户余额¥<span>{{userBalance}}</span></div>
			            </a>
			        </li>
			     </ul>
	        </div>
	    </div>
        <div class="fbbwrap fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap"></div>
                <div class="button-wrap bkno">
                    <a class="orderdetailbtn view" href="javascript:void(0)" v-show='isShowCancelOrder?true:false' onclick="cancelOrder()">取消订单</a>
                    <div v-show='isNeedPay?true:false'>
                    <a class="orderdetailbtn" id="paybtn" href="javascript:void(0)" v-show='isForDeposit?true:false'>付定金</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
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
                <li v-show='isWxBrowser'>
                    <a href="#" onclick="wxpay()">微信支付</a>
                </li>
                <li v-show='isUnionpay'>
                    <a href="#" onclick="unionpay()">银联支付</a>
                </li>
                <li v-show='isWxBrowser?false:true'>
                    <a href="#" onclick="alipay()">支付宝支付</a>
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
        <div class="title">支付订单金额<span class="orange">￥{{realAmt}}</span>元</div>
    </div>
    <div class="paymentwrap">
        <div class="orderinfo">
            <P>请{{hasPassword?'输入支付密码':'设置'}}</P>
        </div>
        <div class="pwd-box">
            <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
            <div class="fake-box" v-show='hasPassword'>
                <input type="password" readonly="">
                <input type="password" readonly="">
                <input type="password" readonly="">
                <input type="password" readonly="">
                <input type="password" readonly="">
                <input type="password" readonly="">
            </div>
        </div>
        <div class="orderinfo" v-show='hasPassword?false:true'>
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
			orderNumber:'',
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
			userBalance:'0.00',
			balancePayAmt:0,
			<#--是否在付款时间内-->
			isInTime:false,
			isUnionpay : false,
			isWxBrowser : false,
			isForDeposit: true,
			isShowBalancePayAmt:false,
			isShowCancelOrder:false,
			isNeedPay:true,
			<#--是否使用余额支付-->
			isBalancePay:false,
			<#--是否有余额参与支付-->
			hasBalancePay:false,
			hasPassword:false
		},
		methods:{
			subOrder: function(){
	        	if(this.hasPassword){
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
			url : '${ctx}/m/account/preSaleOrder/detail_json?orderId='+orderId,
			type : 'get',
			success : function(data){
				app.orderNumber=data.orderDetail.orderNumber;
				app.totalAmt=(data.orderDetail.orderTotalAmt).toFixed(2);
				app.realAmt=(data.orderDetail.orderPayAmt).toFixed(2);
				app.defaultPic=data.orderDetail.productPicUrl;
				app.productName=data.orderDetail.productName;
				app.defaultPrice=(data.orderDetail.salePrice).toFixed(2);
				app.quantity=data.orderDetail.quantity;
				app.createTime=Format(ConvertJSONDateToJSDateObject(data.orderDetail.createTime),"yyyy-MM-dd HH:mm");
				app.payModel=data.orderDetail.orderPayModelDesc;
				app.orderStatus=data.orderDetail.orderStatusDesc;
				app.payStatus = data.orderDetail.orderPayStatusDesc;
				app.remark=data.orderDetail.remark;
				app.balancePayAmt =eval(data.orderDetail.orderTotalAmt - data.orderDetail.orderPayAmt).toFixed(2);
				app.userBalance = (data.userBalance).toFixed(2);
				if(eval(data.userBalance)<=0){
					$(".mui-switch").addClass("mui-disabled");
				}
				app.isInTime = data.isInTime;
				if(data.orderDetail.orderType==2){//判断定是定金订单还是尾款订单
					app.isForDeposit = false;
				};
				if(data.orderDetail.orderType==1 && eval(data.orderDetail.orderTotalAmt - data.orderDetail.orderPayAmt)>0){
					app.isShowBalancePayAmt = true;
				};
				if(data.orderDetail.orderStatusCd ==1){
					app.isShowCancelOrder = true;
				};
				if(data.orderDetail.orderStatusCd !=1){
					app.isNeedPay = false;
				};
				if(data.payPassword!=null && data.payPassword!=''){
					app.hasPassword=true;
				}
			}
		});
	});
	
	function isbalancePay(){
		var balsnceSwitch = $("#balanceSwitch");
		if(balsnceSwitch.hasClass('mui-active')){
			app.isBalancePay = true;
			if(eval(app.userBalance)>0){
				app.hasBalancePay = true;
			}
		}else{
			app.isBalancePay = false;
			app.hasBalancePay = false;
		}
		
	}
	
	function wxpay(){
		if(app.hasBalancePay){
			toPay("wechatpay_balance");
		}else{
			toPay("wechatpay");
		}
	}
	function unionpay(){
		if(app.hasBalancePay){
			toPay("unionpay_balance");
		}else{
			toPay("unionpay");
		}
	}
	function alipay(){
		if(app.hasBalancePay){
			toPay("alipay_balance");
		}else{
			toPay("alipay");
		}
	}
	
	 //转换JSON数据中的时间为标准时间
	function ConvertJSONDateToJSDateObject(JSONDateString) {
	    var date = new Date(parseInt(JSONDateString));
	    return date;
	}
	 $(function(){
        var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        $("#paybtn").on("click", function () {
        	if(!app.isInTime){
        		mui.toast("不在预售定金期内！")
        		return false;
        	}
            	paymentshow();
        });
        specAS.find(".close").on("click", function () {
            paymenthide();
        });

        $(".cancelBtn,.cancel").on("click", function () {
            paymenthide();
        });

        function paymentshow(){
        	clearPwd();
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
					if(eval(app.userBalance)<eval(app.realAmt)){
						mui.toast('余额不足,请选用其他支付方式！');
						app.isBalancePay = false;
						paymentshow();
					}else{
						toPay("balancePay");
					}
					
				}else{
					mui.toast('支付密码错误！');
					clearPwd();
				}
			})
        }
    });
	});
	
	function clearPwd(){
		$("#pwd-input").val('');
		$('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
	}
	//跳转到设置支付密码页面
	function setPayPwd(){
		var addrId = $("#addrId").val();
		var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=m%2faccount%2fpreSaleOrder%2fdetail%2f'+orderId;
		window.location.href = _url;
	}
	
	function toPay(payWay){
		$.ajax({
			url:'${ctx}/m/account/preSaleOrder/dealPreSaleOrder',
			type:'post',
			data:{
				"orderId":orderId,
				"payWay":payWay,
				"type":"downPaymentForList"
			},
			dataType:'json',
			success:function(data){
				if(data.result=='success'){
					if(payWay=="balancePay"){
						mui.toast('支付成功!');
						window.location.href = "${ctx}/m/account/preSaleOrder/toPaySuccessPage?orderId="+data.data;
					}else{
						window.location.href = '${ctx}/m/account/order/goToOrderPayment?payWay='+data.data.payWay+'&orderNumber='+data.data.orderNumber;
					}
				}else{
					mui.alert(data.message);
				}
			},
			error:function(){
				mui.alert('网络出错，请稍后再试！');
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
							mui.alert(data.message);
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