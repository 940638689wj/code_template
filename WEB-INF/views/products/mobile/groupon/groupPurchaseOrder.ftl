<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<html>
<head>
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
	        <a class="mui-icon mui-icon-left-nav" href="javaScript:history.go(-1);"></a>
	        <h1 class="mui-title">确认订单</h1>
	        <a class="mui-icon"></a>
	    </header>
	    <div class="mui-content">
	        <div class="borderbox">
	            <div class="tbviewlist categorylist">
	                <ul>
	                    <li>
	                        <a href="javascript:void(0);">
	                            <div class="r">{{realPrice}}</div>
	                            <div class="c">{{promotionName}}</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	            <div class="group-ordernum">
	                <ul>
	                    <li>
	                        <div class="r">
	                            <div class="number-widget">
	                                <div class="number-minus" v-on:click="deNum"></div>
			                        <input class="number-text" type="number" v-model="buyNum" v-on:change="checkNum">
			                        <div class="number-plus" v-on:click="inNum"></div>
	                            </div>
	                        </div>
	                        <div class="c">购买数量</div>
	                    </li>
	                </ul>
	            </div>
	        </div>
	
	        <div class="borderbox">
	            <div class="tbviewlist categorylist">
	                <ul>
	                    <li class="itemlink">
	                        <div class="c">优惠券</div>
	                        <div class="s">
	                            <select id='couponSelect' name='couponCodeId' v-on:change="onSelectedCoupon(event)">
		                                <option value='0'>不使用</option>
		                                <option v-for="item in couponList" v-bind:value="item.couponCodeId">{{item.discountDesc}}</option>
	                            </select>
	                        </div>
	                    </li>
	                    <li>
	                        <div class="hd">使用优惠码:</div>
	                        <div class="bd">
	                            <div class="info">
	                                <div class="wrap">
	                                    <input v-model='couponCode' type="text" placeholder="输入优惠码">
	                                </div>
	                                <a class="btn" id='couponCodeBtn' v-on:click="checkCouponCode">使用</a>
	                            </div>
	                        </div>
	                    </li>
	                </ul>
	            </div>
	        </div>
	
	        <div class="borderbox">
	            <div class="tbviewlist categorylist">
	                <ul>
	                    <li class="itemlink">
	                        <div class="c">红包</div>
	                        <div class="s">
	                            <select id='redPacketSelect' v-on:change="onSelectedRedPacket(event)">
	                                <option value='0'>不使用</option>
	                                <option v-for="item in redPacket" v-bind:value="item.couponCodeId">红包金额：￥{{item.couponCodeValue.toFixed(2)}}</option>
	                            </select>
	                        </div>
	                    </li>
	                    <li>
	                        <a href="javascript:void(0);">
	                            <div class="r">小计￥{{payAmt}} - 已优惠{{discountAmt}}</div>
	                            <div class="c">合计</div>
	                        </a>
	                    </li>
	                </ul>
	            </div>
	        </div>
	
	        <div class="borderbox">
	            <div class="tbviewlist categorylist">
	                <ul>
	                    <li>
	                        <div class="hd">订单备注:</div>
	                        <div class="bd">
	                            <input type="text" id="remark" placeholder="选填：对本次交易的说明">
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
	                            <div class="main-info"><i>实付：</i><span>¥{{realPayAmt}}</span></div>
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
	                                <a href="javascript:void(0)" onclick="toPay('wechatpay')">微信支付</a>
	                            </li>
	                            <li v-show='isUnionpay'>
	                                <a href="javascript:void(0)" onclick="toPay('unionpay')">银联支付</a>
	                            </li>
	                            <li v-show='isWxBrowser?false:true'>
	                                <a href="javascript:void(0)" onclick="toPay('alipay')">支付宝</a>
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
	                    <div class="title">支付订单金额<span class="orange">￥{{balancePayAmt}}</span>元</div>
	                </div>
	                <div class="paymentwrap">
	                    <div class="orderinfo">
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
<script type='text/javascript'>
var buyNum = ${buyNum!};
var promotionId = ${promotionId!};

var app = new Vue({
		el : '#app',
		data : {
			promotionName : '',			<#--团购名-->
			realPrice : '',				<#--团购价-->
			realStock : '',				<#--真实库存-->
			personQuotaNum : '', 		<#--限购数-->
			buyNum : parseInt(buyNum),	<#--购买数量-->
			payAmt : '',				<#--小计-->
			discountAmt : '0.00',		<#--优惠金额（红包+优惠券）-->
			realPayAmt : '',			<#--实际支付金额-->
			userBalance : '',			<#--用户余额-->
			redPacket : [],				<#--红包-->
			redPacketValue : '0.00',	<#--红包金额-->
			discountValue : '0.00',		<#--优惠券金额-->
			couponList : []	,			<#--优惠券-->
			couponCode : '',
			hasPayPwd : false,
			isBalancePay : false,
			isUnionpay : false,
			isWxBrowser : false,
			balancePayAmt: 0
		},	
		methods : {
			<#--数量变化-->
			deNum : function(){
				this.buyNum = eval(parseInt(this.buyNum)-1);
				this.checkNum();
			},
			inNum : function(){
				this.buyNum = eval(parseInt(this.buyNum)+1);
				this.checkNum();
			},
			<#--校验数量并重算金额-->
			checkNum : function(){
				if(this.buyNum > this.personQuotaNum){
					this.buyNum = 1;
					mui.alert('该团购每人有限制次数，您还可以购买'+this.personQuotaNum+'次'); 
				}
				this.buyNum <= 0?this.buyNum = 1:'';
				this.buyNum > this.realStock?this.buyNum = this.realStock:'';
				if(parseInt(this.buyNum) == 1){
					$(".number-minus").addClass("disabled")
				}else{
					$(".number-minus").removeClass("disabled")
				}
				if(parseInt(this.buyNum) == this.realStock){
					$(".number-plus").addClass("disabled");
				}else{
					$(".number-plus").removeClass("disabled");
				}
				//重置红包及优惠
				$('#redPacketSelect')[0].options[0].selected = true;
				$('#couponSelect')[0].options[0].selected = true;
				this.discountAmt = '0.00';
				this.redPacketValue = '0.00';
				this.discountValue	= '0.00';
				//重新计算金额
				reCountAmt();
				//获取优惠券
				getCoupon();
				if($("#couponCodeBtn").hasClass('active')){
	        		$("#couponCodeBtn").removeClass('active')
	        	}
			},
			<#--监听红包变动并重算金额-->
			onSelectedRedPacket(event) {
	        	var redPacketId = parseInt(event.target.value);
	        	var selectedIndex = event.target.selectedIndex-1;
	        	if(redPacketId != 0){	//判断是否第一个选项：不使用
	        		this.redPacketValue = this.redPacket[selectedIndex].couponCodeValue;
	        	}else{
	        		this.redPacketValue = 0;
	        	}
	        	reCountAmt();
	        },
	        <#--监听优惠券变动并重算金额-->
	        onSelectedCoupon(event){
	        	var couponCodeId = parseInt(event.target.value);
	        	var selectedIndex = event.target.selectedIndex-1;
	        	if(couponCodeId != 0){	//判断是否第一个选项：不使用
	        		var value = this.couponList[selectedIndex].discountValue;
	        		var couponType = this.couponList[selectedIndex].discountTypeCd;
	        		switch(couponType){
		        		case 1: 
		        			this.discountValue = value;
		        			break;
	        			case 2:
	        				this.discountValue = eval((1-value)*this.buyNum*this.realPrice);
	        				break;
	    				case 3:
	    					this.discountValue = value;
		        			break;
	        			default:
	        				mui.toast('该优惠券无法使用');
		        			$('#couponSelect')[0].options[0].selected = true;
		        			this.discountValue = 0;
		        			break;
	        		}
	        	}else{
	        		this.discountValue = 0;
	        	}
	        	reCountAmt();
	        },
	        checkCouponCode(){
	        	if($("#couponCodeBtn").hasClass('active')){
	        		mui.toast('您已经使用过优惠券了！');
	        		return false;
	        	}
	        	var reg = /^\d{10,}$/
	        	if(!reg.test(this.couponCode.trim())){
	        		mui.toast('优惠券有误！');
	        		return false;
	        	}else{
	        		var _url = '/m/account/groupPurchaseOrder/checkCouponCode?couponCode='+this.couponCode.trim()+'&productId='+productId+'&productAmt='+app.buyNum*app.realPrice;
					$.get(_url,function(data){
			    		if(data.result=='success'){
			    			//将获取到的优惠券添加到原有的优惠券中
			    			app.couponList.push(data.data);	
			    			setTimeout(function(){$("#couponSelect option:last-child").attr('selected','selected')},200);
			    			$("#couponCodeBtn").addClass('active');
			    			switch(data.data.discountTypeCd){
				        		case 1: 
				        			app.discountValue = data.data.discountValue;
				        			break;
			        			case 2:
			        				app.discountValue = eval((1-value)*this.buyNum*this.realPrice);
			        				break;
			    				case 3:
			    					app.discountValue = data.data.discountValue;
				        			break;
			        			default:
			        				mui.toast('该优惠券无法使用');
				        			$('#couponSelect')[0].options[0].selected = true;
				        			app.discountValue = 0;
				        			break;
			        		}
			        		reCountAmt();
			    		}else{
			    			mui.alert(data.message);
			    		}
			    	});	
	        	}
	        },
	        subOrder(){
	        	if(this.hasPayPwd){
	        	
	        	}else{
	        		setPayPwd();
	        	}
	        }
		}
	});
	
	//获取优惠券
	function getCoupon(){
		var _url = '/m/account/groupPurchaseOrder/jsonCoupon?productId='+productId+'&productAmt='+app.buyNum*app.realPrice;
    	$.get(_url,function(data){
    		if(data.result=='success'){
    			app.couponList = data.data == null?[]:data.data;
    			return true;
    		}else{
    			mui.alert(data.message);
    		}
    	});
	}
	
	//重新计算金额
	function reCountAmt(){
		for(var i=0;i<2;i++){	//计算两遍防止出错
			app.discountAmt = eval(parseFloat(app.redPacketValue) + parseFloat(app.discountValue)).toFixed(2);//计算优惠金额
			app.payAmt = eval(app.buyNum * app.realPrice - app.discountAmt).toFixed(2);		//计算小计：数量*单价-优惠
			app.realPayAmt = app.payAmt;	//实付
			//改变数量时保留余额支付
			$(".mui-switch").click();
		}
	}
	
	var payPwdFlag;
	var productId;
	var fullBalanceFlag = true;
	
	//页面加载后初始化数据
	$(function(){
	    var ua = navigator.userAgent.toLowerCase();  
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {  
	        app.isWxBrowser = true;	//判断是否微信浏览器
	    } 
		$.ajax({
			url : '${ctx}/m/account/groupPurchaseOrder/jsonGrouponPayData?promotionId='+promotionId,
			type : 'get',
			success : function(data){
				app.promotionName = data.promotionName;
				app.skuCustomAttr = data.grouponDesc;
				app.realPrice = data.grouponPrice.toFixed(2);
				app.realStock = data.realStock;
				app.personQuotaNum = data.personQuotaNum - data.currentUserNum;
				app.userBalance = data.userBalance.toFixed(2);
				if(app.userBalance == 0) $(".mui-switch").addClass('mui-disabled');
				app.redPacket = data.redPacket;
				reCountAmt();
				app.hasPayPwd = data.payPassword == null || data.payPassword == '' ?false:true;
				productId = data.productId;
				getCoupon();
				if(data.payWays.indexOf('unionpay')>=0)app.isUnionpay = true;
				if(app.buyNum > app.personQuotaNum){
					if(data.personQuotaNum <= data.currentUserNum){ //购买次数已经等于限购数
						mui.alert('您购买的次数已经达到限购数，已经无法购买',function(){
							window.location.href = '/m/groupPurchase/list';
						})
					}else{
						mui.toast("您选择的数量已经超过限购数，已将购买数量重置为1");
						app.buyNum = 1;
						reCountAmt();
					}
				}
			}
		});
	});
	
	//计算余额支付后的金额
	function balancePay(){
		if($(".mui-switch").hasClass('mui-active')){
			app.isBalancePay = true;
			//如果余额大于应付金额，则余额完全抵扣金额，输入密码直接付款
			//如果余额小于应付金额，则实付金额等于小计-余额
			var _payAmt = eval(app.realPayAmt - app.userBalance);//应付金额
			if(_payAmt < 0){
				app.balancePayAmt = app.realPayAmt;
				app.realPayAmt = '0.00';
			}else{
				app.balancePayAmt = app.userBalance;
				app.realPayAmt = _payAmt.toFixed(2);
			}
		}else{
			app.isBalancePay = false;
			app.realPayAmt = app.payAmt;	//实付
		}
	}

//跳转到设置支付密码页面
function setPayPwd(){
    var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl='+encodeURIComponent(location.href);
    window.location.href = _url;
}
<#----------------------------------------------支付处理---------------------------------------------------->
$(function(){
    var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
            }).appendTo(document.body),
            specAS = $("#J_ASSpec");
    $("#balancepaymentBtn").on("click", function () {
	        //balancePay();
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
        if(fullBalanceFlag == false) app.isBalancePay = true;
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
			$.post('${ctx}/m/account/groupPurchaseOrder/checkPayPwd',{payPwd:payPwd},function(data){
				if(data.result=='success'){
					if(app.realPayAmt == 0){
						//如果余额支付且余额足够，则直接支付
						var couponCodeId = $("#couponSelect").val();
						var redPacketId = $("#redPacketSelect").val();
						var remark = $("#remark").val();
						$('#wait').addClass('mui-progressbar-infinite');
						$.ajax({
							url:'${ctx}/m/account/groupPurchaseOrder/dealGroupPurchaseOrder',
							type:'post',
							data:{
								promotionId:promotionId,
								buyNum:app.buyNum,
								couponCodeId:couponCodeId,
								redPacketId:redPacketId,
								remark:remark,
								payWay:'balancePay'
							},
							dataType:'json',
							success:function(data){
								paymenthide();
								clearPwd();
								if(data.result=='success'){
									mui.toast('支付成功!');
									location.href = "${ctx}/m/account/groupPurchaseOrder/toPaySuccessPage?orderId="+data.data;
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
	var couponCodeId = $("#couponSelect").val();
	var redPacketId = $("#redPacketSelect").val();
	var remark = $("#remark").val();
	$.ajax({
		url:'${ctx}/m/account/groupPurchaseOrder/dealGroupPurchaseOrder',
		type:'post',
		data:{
			promotionId:promotionId,
			buyNum:app.buyNum,
			couponCodeId:couponCodeId,
			redPacketId:redPacketId,
			remark:remark,
			payWay:payWay
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

function clearPwd(){
	$("#pwd-input").val('');
	$('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
}
</script>
</body>
</html>