<body class="page-list">
<script type="text/javascript" src="/static/js/vue.min.js"></script>
<script src="https://cdn.bootcss.com/babel-polyfill/6.23.0/polyfill.min.js"></script>
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>

<style>
	[v-cloak] {
		display: none;
	}
</style>
	<div id="main" v-cloak>
        <div class="checkout">
            <div class="checkout-tit">填写并核对订单信息</div>
            <div class="checkout-steps">
                <div class="step-wrap">
                    <div class="step-tit">
                        <h3>商品信息</h3>
                        <span class="extra-r flr"><a v-bind:href="detailUrl" class="link">返回团购详情</a></span>
                    </div>
                    <div class="shoptb">
                        <div class="shoptb-hd">
                            <table>
                                <tbody>
                                <tr>
                                    <td class="td-product">商品</td>
                                    <td class="td-price">单价</td>
                                    <td class="td-amount">数量</td>
                                    <td class="td-promote">优惠</td>
                                    <td class="td-total">小计</td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="shoptb-row">
                            <table>
                                <tbody>
                                <tr>
                                    <td class="td-product">
                                        <div class="first-column">
                                            <div class="img"><a href="#"><img v-bind:src="picUrl"></a></div>
                                            <div class="info">
                                                <div class="name"><a v-bind:href="detailUrl" target="_blank">{{promotionName}}</a></div>
												<div class="prop"><span v-for='(k,v) in sku'>{{v}}<em>{{k}}</em></span></div>
												<div class="prop"><span>{{promotionDesc}}</span></div>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="td-price">￥{{realPrice}}</td>
                                    <td class="td-amount">
                                		<span id='countBtn' class="amount-widget">
	                                		<span class="decrease" v-on:click="deNum"></span>
					                        <input class="textfield" type="number" v-model="buyNum" v-on:change="checkNum">
					                        <span class="increase" v-on:click="inNum"></span>
				                        </span>
                                    </td>
                                    <td class="td-promote"></td>
                                    <td class="td-total"><em>￥{{(realPrice*buyNum).toFixed(2)}} </em></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="step-wrap">
                    <div class="step-tit">
                        <h3>优惠信息</h3>
                    </div>
                    <div class="order-ft">
                        <div class="order-extra">
                            <div class="formList order-extra">
                               	<div class="item">
                                    <div class="hd">余额抵扣</div>
                                    <div class="bd">
                                        <input id="integral" type="checkbox" name="integral"><span class="infotext">当前可用余额￥{{userBalance}}，是否使用</span>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="hd">使用优惠券</div>
                                    <div class="bd">
                                        <select id='couponSelect' name='couponCodeId' v-on:change="onSelectedCoupon(event)" style="width:222px">
			                                <option value='0'>-- 不使用 --</option>
			                                <option v-for="item in couponList" v-bind:value="item.couponCodeId">{{item.promotionName}}：&nbsp;{{item.discountDesc}}</option>
		                            	</select>
                                        <p style="margin-top: 5px;">
                                            <input type="text" placeholder="输入优惠码" class="textfield" v-model='couponCode'>&nbsp;&nbsp;
                                            <a href="javascript:void(0)" class="v-btn" v-on:click="checkCouponCode">使用</a>
                                        </p>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="hd">使用红包</div>
                                    <div class="bd">
                                        <select id='redPacketSelect' v-on:change="onSelectedRedPacket(event)" style="width:222px">
                                        	<option value='0'>-- 不使用 --</option>
                                            <option v-for="item in redPacket" v-bind:value="item.couponCodeId">红包金额：￥{{item.couponCodeValue.toFixed(2)}}</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="hd">订单备注</div>
                                    <div class="bd">
                                        <input type="text" id="remark" placeholder='请输入订单备注' class="textfield">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="order-total">
                            <div class="row">
                                <div class="tit">商品总价：</div>
                                <div class="con">￥{{realPrice*buyNum}}</div>
                            </div>
                            <div class="row">
                                <div class="tit">优惠券抵扣：</div>
                                <div class="con">-￥{{discountValue}}</div>
                            </div>
                            <div class="row">
                                <div class="tit">红包抵扣：</div>
                                <div class="con">-￥{{redPacketValue}}</div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="trade-foot">
            <div class="trade-foot-detail">
                <div class="fc-price-info">
                    <span class="price-tit">应付总额：</span>
                    <span class="price-num">￥{{realPayAmt}}</span>
                </div>
            </div>
            <div class="inner" >
                <button id="balancepaymentBtn">提交订单</button>
            </div>
        </div>
    
	    <div id="payment" class="hidden">
	        <div class="paytypes">
	            <ul>
	                <li><a href="javascript:toPay('alipay')">支付宝支付</a></li>
	                <li><a href="javascript:toPay('unionpay')" v-show='isUnionpay'>银联支付</a></li>
	            </ul>
	        </div>
	    </div>

        <div id="payPassword" class="hidden">
            <div class="formList paypassword">
                <div class="item">
                    <div class="hd">输入支付密码：</div>
                    <div class="bd">
                        <input type="password" id='pwdInput' class="textfield" value=''>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"></div>
                    <div class="bd">
                        <a class="v-btn" href="javascript:" id="balanceBtn">确定</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type='text/javascript'>
var buyNum = ${buyNum!};
var promotionId = ${promotionId!};

var app = new Vue({
		el : '#main',
		data : {
			promotionName : '-',			<#--团购名-->
			sku : [],
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
			balancePayAmt: 0,
			detailUrl : '/groupPurchase/detail/'+promotionId,
			promotionDesc:'-',
			picUrl:''
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
					layer.alert('该团购每人限购'+this.personQuotaNum+',请重新选择数量！'); 
				}
				this.buyNum <= 0?this.buyNum = 1:'';
				this.buyNum > this.realStock?this.buyNum = this.realStock:'';
				if(parseInt(this.buyNum) == 1){
					$("#countBtn .decrease").addClass("decrease-disabled")
				}else{
					$("#countBtn .decrease").removeClass("decrease-disabled")
				}
				if(parseInt(this.buyNum) == this.realStock){
					$("#countBtn .increase").addClass("increase-disabled");
				}else{
					$("#countBtn .increase").removeClass("increase-disabled");
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
	        				layer.msg('该优惠券无法使用', {icon: 5});
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
	        	var reg = /^\d{10,}$/
	        	if(!reg.test(this.couponCode.trim())){
	        		layer.msg('优惠券有误！');
	        		return false;
	        	}else{
	        		var _url = '/m/account/groupPurchaseOrder/checkCouponCode?couponCode='+this.couponCode.trim()+'&productId='+productId+'&productAmt='+app.buyNum*app.realPrice;
					$.get(_url,function(data){
			    		if(data.result=='success'){
			    			//将获取到的优惠券添加到原有的优惠券中
			    			app.couponList.push(data.data);	
			    			setTimeout(function(){$("#couponSelect option:last-child").attr('selected','selected')},200);
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
			        				layer.msg('该优惠券无法使用', {icon: 5});
				        			$('#couponSelect')[0].options[0].selected = true;
				        			app.discountValue = 0;
				        			break;
			        		}
			        		reCountAmt();
			    		}else{
			    			layer.alert(data.message);
			    		}
			    	});	
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
    			layer.alert(data.message);
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
			balancePay();
		}
	}
	
	var payPwdFlag;
	var productId;
	var fullBalanceFlag = true;
	
	//页面加载后初始化数据
	$(function(){
		$("#integral").click(function(){
			$("#integral").toggleClass('mui-active');
			balancePay();
		});

	    var ua = navigator.userAgent.toLowerCase();  
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {  
	        app.isWxBrowser = true;	//判断是否微信浏览器
	    } 
		$.ajax({
			url : '/account/groupPurchaseOrder/jsonGrouponPayData?promotionId='+promotionId,
			type : 'get',
			success : function(data){
//			    console.log(data);
				app.picUrl = data.picUrl;
				app.promotionDesc = data.grouponDesc;
				app.promotionName = data.promotionName;
				app.skuCustomAttr = data.grouponDesc;
				app.realPrice = data.grouponPrice.toFixed(2);
				app.realStock = data.realStock;
				app.sku = data.sku;
				app.personQuotaNum = data.personQuotaNum - data.currentUserNum;
				app.userBalance = data.userBalance.toFixed(2);
				if(app.userBalance == 0) $('#integral').attr('disabled',true);
				app.redPacket = data.redPacket;
				app.hasPayPwd = data.payPassword == null || data.payPassword == '' ?false:true;
				productId = data.productId;
				getCoupon();
				if(data.payWays.indexOf('unionpay')>=0)app.isUnionpay = true;
				if(app.buyNum > app.personQuotaNum){
					if(data.personQuotaNum <= data.currentUserNum){ //购买次数已经等于限购数\
						layer.msg('您购买的次数已经达到限购数，已经无法购买',function(){
							$("#balancepaymentBtn").addClass("disabled");
							window.location.href = '/groupPurchase/list';
						})
                        return false;
					}else{
						layer.msg("您选择的数量已经超过限购数!", {icon: 5});
						app.buyNum = 1;
					}
				}
				reCountAmt();
			}
		});
	});
	
	//计算余额支付后的金额
	function balancePay(){
		if($("#integral").hasClass('mui-active')){
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
        var _url = '/account/userChangePaw?type=2&successUrl=' + encodeURIComponent(window.location.href);
		window.location.href = _url;
	}
<#----------------------------------------------支付处理---------------------------------------------------->
$(function(){
    $("#balancepaymentBtn").on("click", function () {
    	if($(this).hasClass("disabled")){
    		return false;
    	}
        if($("#integral").hasClass('mui-active')){
			if(app.hasPayPwd){
//                layer.prompt({title: '请输入支付密码', formType: 1}, function(text, index){
//                    layer.close(index);
//                    passwordCheck(text)
//                });
                paypassword();
			}else{
				//如果没有支付密码，需要先跳转到设置支付密码页面
				layer.confirm('请先设置支付密码',function(){
                    setPayPwd();
                });
			}
        }else{
	        payment();
        }
    });

    $('#balanceBtn').click(function(){
        passwordCheck($('#pwdInput').val());
    });

    var payPassword;

    function paypassword() {
        $("#payPassword input").val('');
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px', '200px'],
            content: $("#payPassword")
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
	function passwordCheck(payPwd){
        layer.close(payPassword);
		var reg = /^\d{6}$/;
    	if(reg.test(payPwd)){
    		//SHA1加密
        	var payPwd = CryptoJS.SHA1(payPwd).toString();
        	
            //执行其他操作
			$.post('/m/account/groupPurchaseOrder/checkPayPwd',{payPwd:payPwd},function(data){
				if(data.result=='success'){
					if(app.realPayAmt == 0){
						//如果余额支付且余额足够，则直接支付
						var couponCodeId = $("#couponSelect").val();
						var redPacketId = $("#redPacketSelect").val();
						var remark = $("#remark").val();
						$('#wait').addClass('mui-progressbar-infinite');
						$.ajax({
							url:'/m/account/groupPurchaseOrder/dealGroupPurchaseOrder',
							type:'post',
							data:{
								promotionId:promotionId,
								buyNum:app.buyNum,
								couponCodeId:couponCodeId,
								redPacketId:redPacketId,
								remark:remark,
								payWay:'balancePay',
								terminal:'pc'
							},
							dataType:'json',
							success:function(data){
								if(data.result=='success'){
									layer.msg('支付成功!');
									location.href = "/account/groupPurchaseOrder/toPaySuccessPage?orderId="+data.data;
								}else{
									layer.alert(data.message);
								}
							},
							error:function(){
								layer.alert('网络出错，请稍后再试！');
							}
						});
					}else{
						//如果余额支付但余额不足，则再次弹出微信支付框
//                        layer.close(index);
						app.isBalancePay = false;
						fullBalanceFlag = false;
						payment();
					}
				
				}else{
					layer.msg('支付密码错误！');
				}
			})
    	}else{
	    	layer.msg('密码错误！');
    	}
    }
})

function toPay(payWay){
	switch(payWay){
		case 'wechatpay':
			//如果选中余额，就是余额部分支付
			payWay = $("#integral").hasClass('mui-active')?'wechatpay_balance':'wechatpay';
			break;
		case 'alipay':
			//如果选中余额，就是余额部分支付
			payWay = $("#integral").hasClass('mui-active')?'alipay_balance':'alipay';
			break;
		case 'unionpay':
			//如果选中余额，就是余额部分支付
			payWay = $("#integral").hasClass('mui-active')?'unionpay_balance':'unionpay';
			break;						
	}
	//如果余额支付且余额足够，则直接支付
	var couponCodeId = $("#couponSelect").val();
	var redPacketId = $("#redPacketSelect").val();
	var remark = $("#remark").val();
	$.ajax({
		url:'/m/account/groupPurchaseOrder/dealGroupPurchaseOrder',
		type:'post',
		data:{
			promotionId:promotionId,
			buyNum:app.buyNum,
			couponCodeId:couponCodeId,
			redPacketId:redPacketId,
			remark:remark,
			payWay:payWay,
            terminal:'pc'
		},
		dataType:'json',
		success:function(data){
			if(data.result=='success'){
				window.location.href = '/account/order/goToOrderPayment?payWay='+data.data.payWay+'&orderNumber='+data.data.orderNumber;
			}else{
				layer.alert(data.message);
			}
		},
		error:function(){
			layer.alert('网络出错，请稍后再试！');
		}
	});
}
</script>
</body>
