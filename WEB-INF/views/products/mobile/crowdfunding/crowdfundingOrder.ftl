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
	        <h1 class="mui-title">众筹参与订单确认</h1>
	        <a class="mui-icon"></a>
	    </header>
	    <div class="mui-content">
	        <div class="borderbox">
	            <h3 class="title">商品清单</h3>
	            <ul class="prd-list b-bottom">
	                <li>
	                    <div class="pic">
	                        <img v-bind:src="picUrl">
	                    </div>
	                    <div class="r">
	                        <p class="name">{{promotionName}}</p>
	                        <p class="participant">总需<i>{{requireNum}}</i>人次参与，还剩<i>{{remainPeopleNum}}</i>人次</p>
	                        <div class="price">
	                            <div class="number-widget">
			                        <div class="number-minus disabled" v-on:click="deNum"></div>
			                        <input class="number-text" type="number" v-model="buyNum" v-on:change="checkNum">
			                        <div class="number-plus" v-on:click="inNum"></div>
	                            </div>
	                            <div class="price-real">¥<em>{{perAmt}}</em></div>
	                        </div>
	                    </div>
	                </li>
	            </ul>
	        </div>
	
	        <div class="borderbox">
	            <div class="tbviewlist categorylist">
	                <ul>
	                    <li>
	                        <a href="javascript:void(0);">
	                            <div class="r">
	                                <div class="mui-switch mui-switch-mini">
	                                    <div class="mui-switch-handle" onclick="balancePay()"></div>
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
	                            <div class="main-info"><i>众筹金额总计：</i><span>¥{{totalAmt}}</span></div>
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
var promotionId = ${promotionId!};
var buyNum = ${buyNum!}

var app = new Vue({
		el : '#app',
		data : {
			promotionName : '',			<#--众筹名-->
			requireNum : 0,
			remainPeopleNum : 0,
			personNumLimit : 0, 		<#--限购数-->
			buyNum : buyNum,
			perAmt : 0.00,
			picUrl : '',
			userBalance : 0.00,
			totalAmt : 0.00,			
			userBalance : '',			<#--用户余额-->
			hasPayPwd : false,
			isBalancePay : false,
			isUnionpay : false,
			isWxBrowser : false,
			balancePayAmt: 0,
			currentUserNum:0
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
				if(eval(parseInt(this.buyNum) + parseInt(this.currentUserNum) > parseInt(this.personNumLimit))){
					this.buyNum = 1;
					mui.alert('您购买的数量已经超过每人限购数：'+this.personNumLimit+'！');
					return false;
				}
				this.buyNum <= 0?this.buyNum = 1:'';
				this.buyNum > this.remainPeopleNum?this.buyNum = this.remainPeopleNum:'';
				if(parseInt(this.buyNum) == 1){
					$(".number-minus").addClass("disabled")
				}else{
					$(".number-minus").removeClass("disabled")
				}
				if(parseInt(this.buyNum) == this.remainPeopleNum){
					$(".number-plus").addClass("disabled");
				}else{
					$(".number-plus").removeClass("disabled");
				}
				app.totalAmt = eval(app.buyNum * app.perAmt).toFixed(2);
				balancePay();
			},
	        subOrder : function (){
                paymenthide();
	        	if(this.hasPayPwd){
                    payPwdCheck($("#pwd-input").val())
	        	}else{
	        		setPayPwd();
	        	}
	        }
		}
	});
	
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
			url : '${ctx}/m/account/crowdfundingOrder/jsonPayData?promotionId='+promotionId,
			type : 'get',
			success : function(data){
                app.remainPeopleNum = eval(data.requireNum - data.currentPeopleNum).toFixed(0);
                if(app.remainPeopleNum <=0){
                    mui.alert("该众筹商品已售罄",'','确定',function(){
                        location.href = "${ctx}/m/crowdfunding/list";
					});
                }
                app.promotionName = data.promotionName;
                app.requireNum = data.requireNum.toFixed(0);
				app.perAmt = data.perAmt.toFixed(2);
				app.personNumLimit = data.personalJoinLimit;
				app.picUrl = data.picUrl;
				app.userBalance = data.userBalance.toFixed(2);
				app.totalAmt = eval(app.buyNum * app.perAmt).toFixed(2);
				if(data.payWays.indexOf('unionpay')>=0)app.isUnionpay = true;
				app.hasPayPwd = data.payPassword == null || data.payPassword == '' ?false:true;
				app.currentUserNum = data.currentUserNum;
				if(app.userBalance == 0) $(".mui-switch").addClass('mui-disabled');
			}
		});
	});
	
	//计算余额支付后的金额
	function balancePay(){
		if($(".mui-switch").hasClass('mui-active')){
			app.isBalancePay = true;
			app.balancePayAmt = parseFloat(app.totalAmt) > parseFloat(app.userBalance)?app.userBalance:app.totalAmt;
		}else{
			app.isBalancePay = false;
		}
	}
	
	
	//跳转到设置支付密码页面
	function setPayPwd(){
		var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl='+encodeURIComponent(window.location.href);
		window.location.href = _url;
	}
	
	function hasBalanceCheck(){
    	mui('.mui-content .mui-switch')['switch']();
    }
<#----------------------------------------------支付处理---------------------------------------------------->
$(function(){

    $("#balancepaymentBtn").on("click", function () {
        if(app.checkNum() == false) return false;
//		console.log(app.checkNum())
        if(app.buyNum<=0) return false;
    	if(eval(parseInt(app.buyNum) + parseInt(app.currentUserNum)) > parseInt(app.personNumLimit)){
			mui.alert('您购买的次数已经超过限购数，无法购买！'); 
		}else{
            balancePay();
	        paymentshow();
		}
    });

    specAS.find(".close").on("click", function () {
        paymenthide();
    });

    $(".cancelBtn,.cancel").on("click", function () {
        paymenthide();
    });

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
            paymenthide();
            payPwdCheck($(this).val())
        }
    });
});

function payPwdCheck(pwd) {
    //SHA1加密
    var payPwd = CryptoJS.SHA1(pwd).toString();

    //执行其他操作
    $.post('${ctx}/m/account/groupPurchaseOrder/checkPayPwd',{payPwd:payPwd},function(data){
        if(data.result=='success'){
            if(parseFloat(app.totalAmt) < parseFloat(app.userBalance)){
                //如果余额支付且余额足够，则直接支付
                var couponCodeId = $("#couponSelect").val();
                var redPacketId = $("#redPacketSelect").val();
                var remark = $("#remark").val();
                $('#wait').addClass('mui-progressbar-infinite');
                $.ajax({
                    url:'${ctx}/m/account/crowdfundingOrder/dealCrowdfundOrder',
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
                        clearPwd();
                        if(data.result=='success'){
                            mui.toast('支付成功!');
                            location.href = "${ctx}/m/account/crowdfundingOrder/toPaySuccessPage?orderId="+data.data;
                        }else{
                            mui.alert(data.message);
                        }
                    },
                    error:function(){
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
		url:'${ctx}/m/account/crowdfundingOrder/dealCrowdfundOrder',
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
			paymenthide();
			clearPwd();
			if(data.result=='success'){
				window.location.href = '${ctx}/m/account/order/goToOrderPayment?payWay='+data.data.payWay+'&orderNumber='+data.data.orderNumber;
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
}

function clearPwd(){
	$("#pwd-input").val('');
	$('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
}




var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
        }).appendTo(document.body),
        specAS = $("#J_ASSpec");

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
</script>
</body>
</html>