<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile">
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<!doctype html>
<html lang="en">
<head>
	<title>核对预售信息</title>
	<script type="text/javascript" src="${ctx}/static/js/vue.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/mobile/js/sha1.js"></script>
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
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        <h1 class="mui-title">核对预售信息</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
    	<input type="hidden" id="productId" value="" />
    	<input type="hidden" id="promotionId" value="" />
    	<input type="hidden" id="productId" value="" />
        <div class="borderbox">
            <h3 class="title">商品清单</h3>
            <ul class="prd-list b-bottom">
                <li>
                    <div class="pic">
                        <img v-bind:src='defaultPic'>
                    </div>
                    <div class="r">
                        <p class="name">{{productName}}</p>
                        <p class="info"><span class="num"><i class="small">X</i>${quantity!}</span><!--<span class="specifications">规格：1L</span>--></p>
                        <div class="price">
                            <div class="price-real">¥{{defaultPrice}}<em></em></div>
                        </div>
                    </div>
                </li>
            </ul>
            <div class="tbviewlist categorylist">
                <li>
                    <div class="hd">买家留言:</div>
                    <div class="bd">
                        <input type="text" id="remark" placeholder="">
                    </div>
                </li>
                </ul>
            </div>
        </div>
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
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

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in content-cartwrap-in">
                        <div class="r">
                            <div class="main-info"><i>定金：</i><span>¥{{realPayAmt}}</span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap">
                    <a class="button" id="balancepaymentBtn">确定</a>
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
                    <div class="title">支付订单消耗余额<span class="orange">￥{{totalAmt}}</span>元</div>
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

    </div>
</div>
</div>
<script>
var promotionId = ${promotionId!};
var productId = ${productId!};//当前选中sku对应的商品Id
var quantity = ${quantity!};

var app = new Vue({
		el : '#app',
		data : {
			defaultPic:'',
			productName:'',
			defaultPrice:'',
			totalAmt:'',
			userBalance:'',
			realPayAmt:'',
			isInTime:false,
			hasPayPwd : false,
			isBalancePay : false,
			isUnionpay : false,
			isWxBrowser : false,
			balancePayAmt: 0
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
			url : '${ctx}/m/account/preSaleOrder/preSaleOrderInfo?productId='+productId+'&promotionId='+promotionId,
			type : 'get',
			success : function(data){
				app.defaultPic=data.defaultPic;
				app.productName = data.product.productName;
				app.defaultPrice = (data.product.defaultPrice).toFixed(2);
				app.totalAmt = eval(data.preSaleInfo.price * quantity).toFixed(2);
				app.userBalance = (data.userBalance).toFixed(2);
				if(eval(data.userBalance)<=0){
					$(".mui-switch").addClass("mui-disabled");
				}
				app.realPayAmt = eval(data.preSaleInfo.price * quantity).toFixed(2);
				app.isInTime = data.isInTime;
				app.hasPayPwd = data.payPassword == null || data.payPassword == '' ?false:true;
				if(data.payWays.indexOf('unionpay')>=0)app.isUnionpay = true;
			}
		});
	});
    $(function(){
        var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        $("#balancepaymentBtn").on("click", function () {
			if(!app.isInTime){
				mui.toast("不在预售定金期内!");
				return;
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
					if(eval(parseFloat(app.userBalance)) >= eval(parseFloat(app.totalAmt))){
						//如果余额支付且余额足够，则直接支付
						var remark = $("#remark").val();
						$('#wait').addClass('mui-progressbar-infinite');
						$.ajax({
							url:'${ctx}/m/account/preSaleOrder/dealPreSaleOrder',
							type:'post',
							data:{
								"promotionId":promotionId,
								"quantity":quantity,
								"productId":productId,
								"remark":remark,
								"payWay":"balancePay",
								"type":"downPayment",
								"originPlatformCd":"1"
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

    })
    
    //计算余额支付后的金额
	function balancePay(){
		if($(".mui-switch").hasClass('mui-active')){
			app.isBalancePay = true;
			var payAmt = eval(app.userBalance - app.realPayAmt);//应付金额
			if(payAmt < 0){
				app.realPayAmt = (app.realPayAmt-app.userBalance).toFixed(2);
			}else{
                app.realPayAmt = 0.00;
            }
		}else{
            app.realPayAmt=app.totalAmt;
			app.isBalancePay = false;
		}
	}
    
    function toPay(payWay){
	switch(payWay){
		case 'wechatpay':
			//如果选中余额，就是余额部分支付
			payWay = $(".mui-switch").hasClass('mui-active')?'wechatpay_balance':'wechatpay';
			break;
		case 'alipay':
			//如果选中余额，就是余额部分支付
			payWay = $(".mui-switch").hasClass('mui-active')?'alipay_balance':'alipay';
			break;
		case 'unionpay':
			//如果选中余额，就是余额部分支付
			payWay = $(".mui-switch").hasClass('mui-active')?'unionpay_balance':'unionpay';
			break;						
	}
	//如果余额支付且余额足够，则直接支付
	var remark = $("#remark").val();
	$.ajax({
		url:'${ctx}/m/account/preSaleOrder/dealPreSaleOrder',
		type:'post',
		data:{
			"promotionId":promotionId,
			"quantity":quantity,
			"productId":productId,
			"remark":remark,
			"payWay":payWay,
			"type":"downPayment",
			"originPlatformCd":"1"
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
		var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=m%2faccount%2fpreSaleOrder%2fsubmitOrder%3fproductId%3d'+productId+'%26promotionId%3d'+promotionId+'%26quantity%3d'+quantity;
		window.location.href = _url;
	}

    function clearPwd(){
		$("#pwd-input").val('');
		$('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
	}
</script>
</body>
</html>