<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>提交订单</title>
	<style>
	    [v-cloak] {
	        display: none !important;
	    }
	</style>
</head>
<body>
<div id="page" v-cloak>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        <h1 class="mui-title">确认订单</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="exchangetab">
            <ul>
                <li><a href="/m/account/order/submitOrder">快递配送</a></li>
                <li class="selected"><a href="/m/account/order/submitOrderTake">上门自提</a></li>
            </ul>
        </div>

		<div class="tbviewlist categorylist orderviewlist">
            <ul>
                <li class="itemlink">
                    <div class="c">选择提货门店</div>
                    <div class="s">
                        <select v-model="form.storeId">
                            <option value="-1">请选择</option>
                            <option v-for="store in result.storeList" :value="store.storeId">{{store.storeName}}</option>
                        </select>
                    </div>
                </li>
                <li>
                    <a id="deliveryTimeBtn" class="itemlink" href="javascript:void(0);">
                        <div class="r">请选择</div>
                        <div class="c">选择提货时间</div>
                    </a>
                </li>
            </ul>
        </div>

        <div class="borderbox mb0">
            <h3 class="title">商品清单</h3>
            <ul class="prd-list b-bottom">
                <li v-for="(cart,index) in result.cartList">
                    <div class="pic">
                        <img :src="cart.productPicUrl">
                    </div>
                    <div class="r">
                        <p class="name">{{cart.productName}}</p>
                        <p class="info"><span class="num"><i class="small">X</i>{{cart.quantity}}</span><span
                                class="specifications">{{cart.skuValue}}</span></p>
                        <div class="select"
                             v-if="cart.productPriceUserLevelXrefList && cart.productPriceUserLevelXrefList.length > 0">
                            <select v-model="productPriceIndex[index]">
                                <option v-for="(puxref,index) in cart.productPriceUserLevelXrefList" :value="index">
                                    {{puxref.desc}}
                                </option>
                            </select>
                        </div>
                        <div class="price" v-if="!cart.productPriceUserLevelXrefList">
                            <div class="price-real"><span v-if="cart.promotionDesc">({{cart.promotionDesc}})</span>¥{{cart.firstAddedSalePrice}}</div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>

        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                    <li v-if="conditionOneIsUse == 1">
                        <a class="itemlink" href="/m/account/invoice/chooseInvoiceList?type=2">
                            <div class="r" v-if="!result.invoice">不开发票</div>
                            <div class="r" v-if="result.invoice">{{result.invoice.companyName}}</div>
                            <div class="c">发票信息</div>
                        </a>
                    </li>
                    <li>
                        <div class="hd">买家留言:</div>
                        <div class="bd">
                            <input type="text" placeholder="选填：对本次交易的说明" v-model="form.orderRemark">
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                	<li class="itemlink">
                        <div class="c">活动</div>
                        <div class="s">
                            <select v-if="result.promotionList && result.promotionList.length > 0" v-model="form.promotionDiscountId">
                            	<option value="-1">不使用</option>
                            	<option v-for="promotion in result.promotionList" :value="promotion.id">{{promotion.discountDesc}}</option>
                            </select>
                        </div>
                    </li>
                    <li class="itemlink">
                        <div class="c">优惠券</div>
                        <div class="s">
                            <select v-if="result.couponList && result.couponList.length > 0" v-model="form.couponCodeId" id="couponSelect">
                            	<option value="-1">不使用</option>
                            	<option v-for="coupon in result.couponList" :value="coupon.couponCodeId">{{coupon.discountDesc}}</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <div class="hd">使用优惠码:</div>
                        <div class="bd">
                            <div class="info">
                                <div class="wrap">
                                    <input v-model='couponCode' type="text" placeholder="请输入优惠码">
                                </div>
                                <a class="btn" v-if="couponCode == ''" @click="useCouponCode">使用</a>
                                <a class="btn active" v-if="couponCode != ''" @click="useCouponCode">使用</a>
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
                            <select v-if="result.redPacketList && result.redPacketList.length > 0" v-model="form.redPacketCodeId">
                            	<option value="-1">不使用</option>
                            	<option v-for="redPacket in result.redPacketList" :value="redPacket.couponCodeId">{{redPacket.couponCodeValue}}元红包</option>
                            </select>
                        </div>
                    </li>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r"><span v-if="productPriceAmt != 0">现金￥{{productPriceAmt}}</span> <span v-if="discountAmt != 0">- 优惠￥{{discountAmt}}</span>
                            <span v-if="expressAmt != 0">+ 运费￥{{expressAmt}}</span></div>
                            <div class="c">合计</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="borderbox" id="userBlance" v-show="result.userBlance">
            <div class="tbviewlist categorylist">
                <ul>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r">
                                <div class="mui-switch mui-switch-mini mui-active" id="toggleBlance">
                                    <div class="mui-switch-handle"></div>
                                </div>
                            </div>
                            <div class="c">账户余额<span class="userBlanceText">¥{{result.userBlance}}</span></div>
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
                            <div class="main-info"><i>实付：</i><span v-if="realityPay - userBlanceValue>= 0">¥{{(realityPay - userBlanceValue).toFixed(2)}}<span v-if="productScoreAmt != 0">+积分{{productScoreAmt}}</span></span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap">
                    <a class="button" id="balancepaymentBtn">确定</a>
                </div>
            </div>
        </div>
        
        <!--自提门店-->
        <div id="deliveryTime" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">提货时间</div>
            </div>
            <div class="ctimewap">
                <div class="ctimewap-left">
                    <div id="ctimewapleftScroll" class="mui-scroll-wrapper">
                        <div class="mui-scroll">
                            <ul class="ctime-date" v-if="result.storeDate" id="storeDate">
                                <li v-for="(value,key,index) in result.storeDate" :class="{selected:dataIndex==index}" @click="selectDate(key,value,index)">{{value}}</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="ctimewap-right">
                    <div id="ctimewaprightScroll" class="mui-scroll-wrapper">
                        <div class="mui-scroll">
                            <ul class="ctime-time" v-if="result.storeList && result.storeList.length > 0">
                                <li v-show="store">
                                    <label @click="selectTime(1,store.deliveryTimeAmStart+'-'+store.deliveryTimeAmEnd)">
                                        <input type="radio" name="paytype">
                                        <div class="c">{{store.deliveryTimeAmStart}}-{{store.deliveryTimeAmEnd}}</div>
                                    </label>
                                </li>
                                <li v-show="store">
                                    <label @click="selectTime(2,store.deliveryTimePmStart+'-'+store.deliveryTimePmEnd)">
                                        <input type="radio" name="paytype">
                                        <div class="c">{{store.deliveryTimePmStart}}-{{store.deliveryTimePmEnd}}</div>
                                    </label>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button selectExpressBtn">确定</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="J_ASSpec" class="actionsheet-spec">
            <!--微信支付-->
            <div class="payment-method" v-show="showPayType">
                <div class="close"></div>
                <div class="prod-info">
                    <div class="title">请选择支付方式</div>
                </div>
                <div class="spec-list">
                    <div class="spec-list-wrap">
                        <ul class="tbviewlist paytypes">
                        	<li v-for="(value,key) in result.payTypeList">
                                <a href="javascript:;" v-if="key == 'config_alipay_mobile'" @click="pay(2)">支付宝支付</a>
                                <a href="javascript:;" v-if="key == 'config_unionpay_mobile'" @click="pay(4)">银联支付</a>
                                <a href="javascript:;" v-if="key == 'weixin_pay_config'" @click="pay(1)">微信支付</a>
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
            <div class="ye-payment" v-show="!showPayType">
                <div class="prod-info">
                    <div class="title">支付订单金额<span class="orange">￥{{this.userBlanceValue}}</span>元</div>
                </div>
                <div class="paymentwrap">
                    <div class="orderinfo" v-show="result.isPayPassword">
                        <P>请输入支付密码</P>
                    </div>
                    <div class="pwd-box" v-show="result.isPayPassword">
                        <input type="tel" maxlength="6" class="pwd-input" id="pwd-input" v-model="payPassword">
                        <div class="fake-box">
                            <input type="password" readonly="">
                            <input type="password" readonly="">
                            <input type="password" readonly="">
                            <input type="password" readonly="">
                            <input type="password" readonly="">
                            <input type="password" readonly="">
                        </div>
                    </div>
                    <div class="orderinfo" v-show="!result.isPayPassword">
                        <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=/m/account/order/submitOrderTake" class="textcolor">设置支付密码</a>！</p>
                    </div>
                </div>

                <div class="fbbwrap-total nofixed">
                    <div class="ftbtnbar">
                        <div class="button-wrap button-wrap-expand">
                            <a href="javascript:void(0)" class="button" @click="pwdSubmit">确定</a>
                            <a href="javascript:void(0)" class="button cancel">取消</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    var vm = new Vue({
        el: "#page",
        data: {
            flag: true,
            result: {},
            form: {
        		<#--商品价格的类型-->
                productPriceType: '',
                <#--发票Id-->
                invoiceId : -1,
                <#--支付金额-->
                payAmt : 0,
                <#--买家留言-->
                orderRemark : '',
                <#--支付类型-->
                payWay : -1,
                <#--使用的余额-->
                userBlanceValue : 0,
                <#--平台类型-->
                originPlatformCd : 1,
                <#--使用活动Id-->
                promotionId : -1,
                <#--使用活动折扣Id-->
                promotionDiscountId : -1,
                <#--使用优惠券Id-->
                couponCodeId : -1,
                <#--使用优惠券折扣Id-->
                couponDiscountId : -1,
                <#--使用红包Id-->
                redPacketCodeId : -1,
                <#--搭配套餐Id-->
                combinationId : '',
                <#--搭配套餐数量-->
                combinationNum : '',
                <#--门店Id-->
                storeId : -1,
                <#--提货起始时间-->
                storeStartDateTime : '',
                <#--提货结束时间-->
                storeEndDateTime : ''
            },
            <#--商品价格的下标-->
            productPriceIndex: [],
            <#--支付密码-->
            payPassword : '',
            <#--支付密码是否正确-->
            isPayPwd : false,
            <#--是否显示支付方式弹出框-->
            showPayType : true,
            <#--开关状态-->
            switchStatus : true,
            <#--是否需要运费-->
            isFreight : false,
            <#--是否使用了优惠码-->
            isUseCouponCode : false,
            <#--使用的优惠码-->
        	couponCode : '',
        	<#--标识选择的时间-->
        	dataIndex : 0,
        	<#--提货日期-->
        	storeDate : '',
        	<#--提货开始时间-->
        	storeStartTime : '',
        	<#--提货结束时间-->
        	storeEndTime : '',
        	<#--提货日期描述-->
        	storeDateDesc : '',
        	<#--提货时间描述-->
        	storeDateTimeDesc : '',
        	<#--发票是否显示 1显示，0不显示-->
        	conditionOneIsUse : 0,
        	<#--发票是否必填 1必填，0不是必填-->
        	conditionOneIsRequired : 0,
        },
        computed: {
        	<#--选中的自提门店-->
        	store : function () {
        		if(this.form.storeId != -1 && this.result.storeList && this.result.storeList.length > 0) {
        			for(var i = 0; i < this.result.storeList.length; i++) {
        				if(this.form.storeId == this.result.storeList[i].storeId) {
        					return this.result.storeList[i];
        				}
        			}
        		}
        		return '';
        	},
        	<#--商品支付方式的处理-->
            productPriceTypeInfo : function () {
                var list = [];
                var str = '';
                if(!this.result.cartList) { return list; }
                for (var i = 0; i < this.result.cartList.length; i++) {
                    var pIndex = this.productPriceIndex[i];
                    if (pIndex >= 0) {
                        list[i] = this.result.cartList[i].productPriceUserLevelXrefList[pIndex];
                    } else {
                        list[i] = {cash: this.result.cartList[i].firstAddedSalePrice, score: 0, type:0};
                    }
                    list[i].quantity = this.result.cartList[i].quantity;
                    
                  	if(i == 0) {
	                    str += list[i].type;
                  	} else {
                  		str += ','+list[i].type;
                  	}
                }
                this.form.productPriceType = str;
                return list;
            },
            <#--商品总金额-->
            productPriceAmt : function() {
            	var productPriceAmt = 0;
            	if(!this.productPriceTypeInfo) { return 0; }
            	for(var i = 0; i < this.productPriceTypeInfo.length; i++) {
            		productPriceAmt = parseFloat(productPriceAmt)+parseFloat(this.productPriceTypeInfo[i].cash) * parseFloat(this.productPriceTypeInfo[i].quantity);
            	}
            	return productPriceAmt.toFixed(2);
            },
            <#--总积分-->
            productScoreAmt : function() {
            	var productScoreAmt = 0;
            	if(!this.productPriceTypeInfo) { return 0; }
            	for(var i = 0; i < this.productPriceTypeInfo.length; i++) {
            		productScoreAmt = parseFloat(productScoreAmt) + parseFloat(this.productPriceTypeInfo[i].score) * parseFloat(this.productPriceTypeInfo[i].quantity);
            	}
            	return productScoreAmt.toFixed(2);
            },
            <#--使用的活动优惠金额-->
            usePromotionValue : function () {
            	this.isFreight = false;
            	if(this.form.promotionDiscountId != -1 && this.result.promotionList && this.result.promotionList.length) {
            		for(var i = 0; i < this.result.promotionList.length; i++) {
            			if(this.result.promotionList[i].id == this.form.promotionDiscountId) {
            				this.form.promotionId = this.result.promotionList[i].promotionId;
            				return this.countDiacount(this.productPriceAmt, this.result.promotionList[i].discountTypeCd, this.result.promotionList[i].discountValue);
            			}
            		}
            	}
            	return 0;
            },
            <#--使用的优惠券优惠金额-->
            useCouponValue : function () {
            	if(this.form.couponCodeId != -1 && this.result.couponList && this.result.couponList.length) {
            		for(var i = 0; i < this.result.couponList.length; i++) {
            			if(this.result.couponList[i].couponCodeId == this.form.couponCodeId) {
            				this.form.couponDiscountId = this.result.couponList[i].id;
            				var needMoney = (parseFloat(this.productPriceAmt) - parseFloat(this.usePromotionValue)).toFixed(2);
            				return this.countDiacount(needMoney, this.result.couponList[i].discountTypeCd, this.result.couponList[i].discountValue);
            			}
            		}
            	}
            	return 0;
            },
            <#--使用的红包优惠金额-->
            useRedpackValue : function () {
            	if(this.form.redPacketCodeId != -1 && this.result.redPacketList && this.result.redPacketList.length > 0) {
            		for(var i = 0; i < this.result.redPacketList.length; i++) {
            			if(this.result.redPacketList[i].couponCodeId == this.form.redPacketCodeId) {
            				return this.result.redPacketList[i].couponCodeValue;
            			}
            		}
            	}
            	return 0;
            },
            <#--总优惠金额-->
            discountAmt : function () {
            	return (parseFloat(this.usePromotionValue) + parseFloat(this.useCouponValue) + parseFloat(this.useRedpackValue)).toFixed(2);
            },
            <#--运费-->
            expressAmt : function () {
            	return 0;
            },
            <#--实际支付金额-->
            realityPay : function () {
            	var realityPay = 0;
            	realityPay = (parseFloat(this.productPriceAmt) - parseFloat(this.discountAmt)).toFixed(2);
            	if(realityPay < 0) {
            		realityPay = 0;
            	}
                realityPay = parseFloat((parseFloat(realityPay) + parseFloat(this.expressAmt)).toFixed(2));//运费单独算
            	this.form.payAmt = realityPay;
            	return realityPay;
            },
            <#--使用的余额-->
            userBlanceValue : function () {
            	var userBlanceValue = 0;
            	if(!this.switchStatus || !this.result.userBlance) {
            		this.showPayType = true;
                    this.isPayPwd = true;//没有选择余额抵扣或者没有余额，就不显示支付密码弹出框
            		return 0;
            	}
            	if(this.result.userBlance < this.form.payAmt) {//如果余额小于支付的金额
            		this.showPayType = true;
            		this.form.userBlanceValue = this.result.userBlance;
            		return this.result.userBlance;
            	} else {
            		this.showPayType = false;
            		this.form.userBlanceValue = this.form.payAmt;
            		return this.form.payAmt;
            	}
            }
            
        },
        methods: {
        	<#--选择日期-->
        	selectDate : function (key,value,i) {
        		if(key) {
        			this.storeDate = key;
        			this.dataIndex = i;
        			this.storeDateDesc = value;
        		}
        		this.storeDateTime();
        	},
        	<#--选择时间,并得出完整的时间-->
        	selectTime : function (i,timeDesc) {
        		if(!this.store) { return; }
        		if(i == 1) {
        			this.storeStartTime = this.store.deliveryTimeAmStart + ":00";
        			this.storeEndTime = this.store.deliveryTimeAmEnd + ":00";
        		} else {
        			this.storeStartTime = this.store.deliveryTimePmStart + ":00";
        			this.storeEndTime = this.store.deliveryTimePmEnd + ":00";
        		}
        		this.storeDateTimeDesc = timeDesc;
        		this.storeDateTime();
        	},
        	<#--处理完整的时间-->
        	storeDateTime : function () {
        		if(!this.storeDate || !this.storeStartTime || !this.storeEndTime) {
        			return;
        		}
        		this.form.storeStartDateTime = this.storeDate + ' ' + this.storeStartTime;
        		this.form.storeEndDateTime = this.storeDate + ' ' + this.storeEndTime;
        	},
        	<#--支付密码的验证-->
        	pwdSubmit : function () {
        		if(!this.payPassword) {
        			mui.toast("请输入支付密码！");
        			return;
        		}
        		if (!this.flag) { return; }
	            $.ajax({
	                url: '${ctx}/m/account/order/testPayPwd',
	                async: true,
	                type: 'GET',
	                dataType: 'json',
	                data: {'payPassword':vm.payPassword},
	                beforeSend: function () {
	                    this.flag = false;
	                },
	                success: function (result) {
                        if(result.result == 'success') {
                            vm.flag = true;
                            vm.isPayPwd = true;
                            vm.pay(5);
                        } else {
                            vm.isPayPwd = false;
                            mui.toast(result.message);
                        }
	                },
	                error: function (XMLHttpResponse) {
	                    vm.flag = true;
	                    console.log('请求未成功');
	                }
	            });
        	},
        	<#--订单支付-->
        	pay : function (payType) {
        		if(!payType) { mui.toast('请选择支付方式！') }
        		if(payType != 5) {//记录不是余额支付的支付类型
        			this.form.payWay = payType;
        		} else if(this.form.payWay == -1 || this.form.payWay == 0){//如果直接使用余额支付，则记录
					this.form.payWay = payType;        		
        		}
        		if(!this.isPayPwd) {
        			this.showPayType = false;
        			return;
        		}
                if(!vm.flag) {
                    return;
                }
                vm.flag = false;
        		this.submitForm('/m/account/order/save', this.form);
        	},
        	<#--数据的验证-->
        	testForm : function () {
        		if (this.form.storeId == -1) {
		            mui.toast('请选择自提门店！');
		            return false;
		        }
		        if (!this.form.storeStartDateTime || !this.form.storeEndDateTime) {
		            mui.toast('请选择自提时间！');
		            return false;
		        }
		        if(this.form.payWay == -1) {
		        	mui.toast('请选择一种支付方式！');
		            return false;
		        }
		        if (this.realityPay < 0) {
		            mui.toast('请重刷页面！');
		            return false;
		        }
		        if(this.conditionOneIsUse == 1 && this.conditionOneIsRequired ==1 && this.form.invoiceId == -1) {
		        	mui.toast('请选择发票！');
		            return false;
		        }
		
		        return true;
        	},
        	<#--表单提交-->
        	submitForm : function (action, data) {
        		var div = $("<div style='display: none'><form id='_help-my-form'></form></div>");
	            $("body").append(div);
	            var helpForm = $("#_help-my-form");
	            helpForm.attr("action", action);
	            helpForm.attr("method", "post");
	            $.each(data, function (key, value) {
	                var inputObj = $("<input name='" + key + "' value='" + value + "'/>");
	                helpForm.append(inputObj);
	            });
	            helpForm.submit();
        	},
        	<#--计算优惠的金额-->
        	countDiacount : function (needMomey,type, value) {
        		switch(type) {
                    case 1:
                        if (parseFloat(needMomey) < parseFloat(value)) {
                            return needMomey;
                        } else {
                            return value;
                        }
                    case 2:
                        value = (parseFloat(needMomey) * (parseFloat(1) - parseFloat(value))).toFixed(2);
                        if (parseFloat(needMomey) < parseFloat(value)) {
                            return needMomey;
                        } else {
                            return value;
                        }
        			case 4:
        				if(!this.isFreight) {
        					mui.toast('只能使用一个包邮活动！');
        					return 0;
        				}
        				this.isFreight = false; 
        				return 0;
        		}
        	},
        	<#--使用优惠码操作-->
        	useCouponCode : function () {
        		if(this.isUseCouponCode){
	        		mui.toast('您已经使用过优惠码了！');
	        		return;
	        	}
        		if(!this.couponCode) {
        			mui.toast('请填写优惠码！');
        			return;
        		}
	        	var reg = /^\d{10,}$/
	        	if(!reg.test(this.couponCode.trim())){
	        		mui.toast('优惠码有误！');
	        		return;
	        	}
	        	
	        	var _url = '/m/account/order/checkCouponCode?couponCode='+this.couponCode.trim()+'&productIds='+this.result.productIds+'&productAmt='+this.productPriceAmt;
				$.get(_url,function(data){
		    		if(data.result=='success'){
		    			//将获取到的优惠券添加到原有的优惠券中
		    			vm.result.couponList.push(data.data);	
		    			vm.form.couponCodeId = data.data.couponCodeId;
		    			//setTimeout(function(){$("#couponSelect option:last-child").attr('selected','selected')},200);
		    			vm.isUseCouponCode = true;
		    		}else{
		    			mui.toast(data.message);
		    		}
		    	});	
        	}
        },
        created: function () {
            if (!this.flag) { return; }
            $.ajax({
                url: '${ctx}/m/account/order/submitOrder/grid_json',
                async: true,
                type: 'GET',
                dataType: 'json',
                beforeSend: function () {
                    this.flag = false;
                },
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        vm.result = result;
                        <#--初始化商品价格数组的数据-->
                        for (var i = 0; i < result.cartList.length; i++){
                            if(result.cartList[i].productPriceUserLevelXrefList){
                                vm.productPriceIndex.push(0);
                            } else {
                                vm.productPriceIndex.push(-1);
                            }
                        }
                        <#--初始化发票Id-->
                        if(result.invoice) {
                        	vm.form.invoiceId = result.invoice.invoiceId;
                        }
                        <#--初始化是否为搭配套餐-->
                        if(result.combinationId && result.combinationNum) {
                        	vm.form.combinationId = result.combinationId;
                        	vm.form.combinationNum = result.combinationNum;
                        }
                        <#--下单的配置-->
                        if(result.conditionOneIsUse) {
	                        vm.conditionOneIsUse = result.conditionOneIsUse;
                        }
                        if(result.conditionOneIsRequired) {
	                        vm.conditionOneIsRequired = result.conditionOneIsRequired;
                        }
                    } else {
                        mui.alert('无购买数据，请重新下单！','','',function() {
                            window.location.href = '/m/products/0.html';
                        });
                        return;
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log('请求未成功');
                }
            });
        }
    })

    if (getCookie('orderId')) {
        window.location.href = "${ctx}/m/account/orderHeader#/orderHeaderDetail/" + getCookie('orderId');
    }
    $(function () {
		<#--使用余额-->
        $('#toggleBlance').on('toggle', function () {
            toggleBlance($(this));
        });
        $('#toggleBlance').trigger('toggle');
        
		function toggleBlance(e) {
            var isActive = e.filter(".mui-active");
            if (isActive.length != 0) {
            	vm.switchStatus = true;
                vm.isPayPwd = false;
            } else {
                vm.form.userBlanceValue = 0;
                vm.isPayPwd = true;
                vm.switchStatus = false;
            }
        }

        var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        $("#balancepaymentBtn").on("click", function () {
        	vm.form.payWay = 0;//初始化支付类型
        	if(!vm.testForm()) { return; }
            paymentshow();
        });
        specAS.find(".close").on("click", function () {
            paymenthide();
        });

        $(".cancelBtn,.cancel").on("click", function () {
            paymenthide();
        });

        function paymentshow() {
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

            }
        });
        
        /*提货时间*/
        var dTime = $("#deliveryTime");
        $("#deliveryTimeBtn").on("click", function () {
        	if(!vm.store) {
        		mui.toast('请先选择一个自提门店！');
        		return;
        	}
            deliveryTimeshow();
        	<#--初始化配送日期-->
            if(vm.result.storeDate) {
            	for(var i in vm.result.storeDate ) {
                	vm.storeDate = i;
                	vm.storeDateDesc = vm.result.storeDate[i];
                	return;
            	}
            }
        });

        dTime.find(".close").on("click", function () {
            deliveryTimehide();
        });
        
        $('.selectExpressBtn').on('click',function () {
        	$('#deliveryTimeBtn .r').html(vm.storeDateDesc + ' ' + vm.storeDateTimeDesc);
        	deliveryTimehide();
        });

        function deliveryTimeshow(){
            paymentMask.show().animate({opacity:1},{
                duration:80,
                complete: function () {
                    dTime.css({
                        top : "100%",
                        opacity : 0,
                        display : "block"
                    }).animate({
                        opacity : 1,
                        translateY:"-"+dTime.height() +"px"
                    },{
                        duration : 200,
                        easing : "ease-in-out"
                    });
                }
            });
            $(document).bind("touchmove",function(e){
                e.preventDefault();
            });
        }

        function deliveryTimehide(callback){
            dTime.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    dTime.hide();
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

    })

    mui('#ctimewapleftScroll').scroll();
    mui('#ctimewaprightScroll').scroll();

    //设置Cookie
    function setCookie(name, value) {
        document.cookie = name + '=' + encodeURIComponent(value) + ';path=/';
    }

    //获取cookie
    function getCookie(name) {
        var arr = document.cookie.split('; ');
        var i = 0;
        for (i = 0; i < arr.length; i++) {
            var arr2 = arr[i].split('=');

            if (arr2[0] == name) {
                var getC = decodeURIComponent(arr2[1]);
                return getC;
            }
        }

        return '';
    }
</script>
</body>
</html>