<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>提交订单</title>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	        <h1 class="mui-title">提交订单</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="order-address">
        	<#if address?? && address?has_content>
            	<#assign addressDetail = address.getAddressFullName()/>
            </#if>
            <a href="javascript:void(0);" id="goAddressList">
                <input type="hidden" id="addressId" value="${(address.addrId)?default(-1)}"/>
                <span class="name">${(address.receiverName)!}</span>
                <span class="phone">${(address.receiverTel)!}</span>
                <address>${addressDetail!}</address>
            </a>
        </div>
        
        <input type="hidden" id="cityId" value="${cityId!}">
        <input type="hidden" id="totalWeight" value="${totalWeight!}">
        
    	<input type="hidden" id="promotionId" value="${promotionId!}" >
    	<input type="hidden" id="promotionDiscountId" value="${promotionDiscountId!}" >
        <div class="tbviewlist categorylist orderviewlist">
            <ul>
        		<#if userCanPromotionDTOList?? && userCanPromotionDTOList?has_content>
                <li>
                    <a id="promotion" class="itemlink" href="javascript:void(0);">
                        <div class="r"><#if promotionDesc??>${promotionDesc!}<#else>请选择</#if></div>
                        <div class="c">活动</div>
                    </a>
                </li>
                <#else>
                <li>
                    <a class="itemlink" href="javascript:void(0);">
                        <div class="r">您没有符合该订单使用的活动</div>
                        <div class="c">活动</div>
                    </a>
                </li>
        		</#if>
            </ul>
        </div>
        <input type="hidden" id="usePromotionValue" value="${usePromotionValue!}" >
        
    	<input type="hidden" id="couponDiscountId" value="${couponDiscountId!}" >
    	<input type="hidden" id="couponCodeId" value="${couponCodeId!}" >
        <div class="tbviewlist categorylist orderviewlist">
            <ul>
       			<#if userCanUseCouponDTOList?? && userCanUseCouponDTOList?has_content>
                <li>
                    <a id="distribution" class="itemlink" href="javascript:void(0);">
                        <div class="r"><#if discountDesc??>${discountDesc!}<#else>请选择</#if></div>
                        <div class="c">优惠券</div>
                    </a>
                </li>
                <#else>
                <li>
                    <a class="itemlink" href="javascript:void(0);">
                        <div class="r">您没有符合该订单使用的优惠券</div>
                        <div class="c">优惠券</div>
                    </a>
                </li>
		        </#if>
            </ul>
        </div>
        
        <input type="hidden" id="redPacketCodeId" value="${redPacketCodeId!}" >
        <input type="hidden" id="useRedPacketValue" value="${useRedPacketValue!}" >
        <input type="hidden" id="useRedPacketRealityValue" value="${useRedPacketRealityValue!}" >
        <div class="tbviewlist categorylist orderviewlist">
            <ul>
       			<#if userRedPacketList?? && userRedPacketList?has_content>
                <li>
                    <a id="redPacket" class="itemlink" href="javascript:void(0);">
                        <div class="r"><#if redPacketDesc??>${redPacketDesc!}<#else>请选择</#if></div>
                        <div class="c">红包</div>
                    </a>
                </li>
                <#else>
                <li>
                    <a class="itemlink" href="javascript:void(0);">
                        <div class="r">您没有红包</div>
                        <div class="c">红包</div>
                    </a>
                </li>
		        </#if>
            </ul>
        </div>
        
        <div class="borderbox">
            <div class="loginform categorylist">
                <ul>
                    <li>
                        <div class="hd">选择快递：</div>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap">
                                    <div class="gender">
                                        <select id="selectExpress">
                                        	<#if expressList?? && expressList?has_content>
                                        		<#list expressList as express>
                                        			<option value="${(express.expressId)!}" <#if express_index==0>selected</#if>>${(express.expressName)!}</option>
                                        		</#list>
                                        	</#if>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="sure-list">
        	<#if productList?? && productList?has_content>
        		<h3><span class="goods"></span>商品清单</h3>
        		<ul>
        		<#list productList as product>
        			<#assign oneProductTotal = product.firstAddedSalePrice * product.quantity>
        			<li>
	                    <div class="name"><#if product.promotionDesc?has_content><span>${(product.promotionDesc)!}</span></#if>${(product.productName)!}</div>
	                    <div class="num"><span>x</span>${(product.quantity)!}</div>
	                    <div class="price">￥${oneProductTotal!}</div>
	                </li>
        		</#list>
        		</ul>
        	</#if>
            <dl>
                <dt>配送费</dt>
                <dd>￥<span class="totalExpressAmt">${(totalExpressAmt)?default(0)}</span></dd>
                <input type="hidden" id="isExpressAmt" value="<#if isExpressAmt>true<#else>false</#if>"/>
            </dl>
            <dl>
                <dt>总计 ￥<span class="total">${total?default(0)}</span>优惠 ￥<span class="discountTotalAmt">${discountTotalAmt?default(0)}</span></dt>
                <dd>实付￥<span class="needPay realityPay">${needPay?default(0)}</span></dd>
            </dl>
        </div>

        <div class="tbviewlist categorylist orderviewlist">
            <ul>
                <li>
                    <div class="hd">买家留言:</div>
                    <div class="bd">
                        <input type="text" id="remark" placeholder="选填，可填写您的需求">
                    </div>
                </li>
            </ul>
        </div>
        
        <input type="hidden" id="useTotalScoreValue" value="" >
        <input type="hidden" id="scoreDiscountTotalValue" value="${scoreDiscountTotalValue!}" >
        <#if totalScpre??>
        <div class="borderbox ">
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink deductionTotal" href="javascript:void(0);">
                            <div class="r">
                                <div class="mui-switch mui-switch-mini ">
                                    <div class="mui-switch-handle"></div>
                                </div>
                            </div>
                            <div class="c">积分抵扣<span>可用${totalScpre!}积分抵扣¥${totalScoreValue!}(本次最多可抵扣¥${scoreDiscountTotalValue!})</span></div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        </#if>

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in content-cartwrap-in">
                        <div class="l" >已优惠￥<span class="discountTotalAmt">${discountTotalAmt?default(0)}</span></div>
                        <div class="r">
                            <div class="main-info"><i>合计：</i>￥<span class="needPay finalPay">${needPay?default(0)}</span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap">
                    <a class="button" id="paybtn">确定</a>
                </div>
            </div>
        </div>

        <div id="J_ASSpec" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">店铺优惠</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="c">不使用优惠券</div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="c">满20减2元</div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="c">满180减15元</div>
                            </label>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy" >确定</a>
                    </div>
                </div>
            </div>
        </div>

        <div id="methodpayment" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择支付方式</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                        <#if businessConfigTypeList?? && businessConfigTypeList?has_content>
                            <#list businessConfigTypeList?keys as key>
                                <#assign payName="" />
                                <#assign payWay="4" />
                                <#if key="config_alipay_mobile">
                                    <#assign payName="支付宝支付" />
                                    <#assign payWay="2" />
                                <#elseif key="config_unionpay_mobile">
                                    <#assign payName="银联支付" />
                                    <#assign payWay="4" />
                                <#elseif key="weixin_pay_config">
                                    <#assign payName="微信支付" />
                                    <#assign payWay="1" />
                                <#elseif key="userBalnce">
                                    <#assign payName="余额支付" />
                                    <#assign payWay="5" />
                                </#if>

                                <li>
                                    <a href="javascript:void(0);" onclick="submitOrder('${payWay}');" <#if payWay == "5">id="balancepaymentBtn"</#if>>${payName!}</a>
                                </li>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button canclePay">取消</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="userCoupon" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择优惠券</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                    	<li>
                            <label>
                                <input type="radio" name="paytype" value="-1">
                                <input type="hidden" class="couponDiscountId" value="-1">
                                <div class="c">不使用优惠券</div>
                            </label>
                        </li>
                        <#if userCanUseCouponDTOList?? && userCanUseCouponDTOList?has_content>
                            <#list userCanUseCouponDTOList as userCanUseCouponDTO>
                                <li>
                                	<label>
		                                <input type="radio" name="paytype" value="${(userCanUseCouponDTO.couponCodeId)!}">
		                                <input type="hidden" class="couponDiscountId" value="${(userCanUseCouponDTO.id)!}">
		                                <div class="c">${(userCanUseCouponDTO.discountDesc)!}</div>
		                            </label>
                                </li>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy" id="couponButton">确定</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="userPromition" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择活动</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                    	<li>
                            <label>
                                <input type="radio" name="paytype" value="-1">
                                <input type="hidden" class="promotionId" value="-1">
                                <div class="c">不使用活动</div>
                            </label>
                        </li>
                        <#if userCanPromotionDTOList?? && userCanPromotionDTOList?has_content>
                            <#list userCanPromotionDTOList as userCanPromotionDTO>
                                <li>
                                	<label>
		                                <input type="radio" name="paytype" value="${(userCanPromotionDTO.id)!}">
		                                <input type="hidden" class="promotionId" value="${(userCanPromotionDTO.promotionId)!}">
		                                <div class="c">${(userCanPromotionDTO.discountDesc)!}</div>
		                            </label>
                                </li>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy" id="promotionButton">确定</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="userRedPacket" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择红包</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                    	<li>
                            <label>
                                <input type="radio" name="paytype" value="-1">
                                <div class="c">不使用红包</div>
                            </label>
                        </li>
                        <#if userRedPacketList?? && userRedPacketList?has_content>
                            <#list userRedPacketList as userRedPacket>
                                <li>
                                	<label>
		                                <input type="radio" name="paytype" value="${(userRedPacket.couponCodeId)!}">
		                                <div class="c">${(userRedPacket.couponCodeValue)?default(0)}元</div>
		                            </label>
                                </li>
                            </#list>
                        </#if>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy" id="redPacketButton">确定</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="balancePayment" class="balance-payment">
            <h3>支付订单金额￥<span class="needPay finalPay">${needPay?default(0)}</span>元</h3>
            <div class="paymentwrap" <#if isPayPassword == 0>style="display:none;"</#if>>
                <div class="orderinfo">
                    <P>请输入支付密码</P>
                </div>
                <div class="pwd-box">
                    <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
                    <div class="fake-box">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                    </div>
                </div>
            </div>
            
            <div class="paymentwrap" <#if isPayPassword == 1>style="display:none;"</#if>>
                <div class="orderinfo">
                    <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="${ctx}/m/account/userChangePaw/changePaw_VerifyPhone?type=3" class="orange">设置支付密码</a>！</p>
                </div>
            </div>
            
            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button" id="balancePaymentSub">确定</a>
                        <a href="javascript:void(0)" class="button cancel" id="balancePaymentCancle">取消</a>
                    </div>
                </div>
            </div>
        </div>

    </div>
</div>
<script>
    var flagSub = true;//防止表单多次提交
    var balancePayment = $("#balancePayment");
    var blancePay = false;//余额支付时候成功的标志，默认为false
    function submitOrder(payWay){
        var remark = $('#remark').val();//用户备注
        var totalScoreValue = $('#useTotalScoreValue').val();
        var payAmt = $('.finalPay').html().trim();
        var isPayPassword = ${isPayPassword?default(0)};
        var couponCodeId = $('#couponCodeId').val();//用户优惠券Id
        var couponDiscountId = $('#couponDiscountId').val();//优惠券折扣Id
        //var selectDay = $('#selectDay').val();
        //var selectTime = $('#selectTime').val().split("-");
        //var startExpressTimeStr = selectDay + " " + selectTime[0] + ":00";
	    //var endExpressTimeStr = selectDay + " " + selectTime[1] + ":00";
	    var redPacketCodeId = $('#redPacketCodeId').val();//用户红包Id
	    var promotionId = $('#promotionId').val();//活动Id
        var promotionDiscountId = $('#promotionDiscountId').val();//活动规则Id
        var expressId = $('#selectExpress').val();//快递公司Id
        var addrId = $('#addressId').val();//收货地址Id
        <#--如果是余额支付(余额支付不成功)，在弹出密码框中操作-->
        if(!blancePay && payWay == 5) {
        	paymentshow();
        	return;
        }
        if(!addrId) {
        	mui.toast("地址不能为空！");
        	return;
        }
		
        var data = {};
        data.remark = remark;
        data.payWay = payWay;
        <#--data.payAmt = '${needPay?default(0)}';-->
        data.payAmt = payAmt;
        data.originPlatformCd = '1';
        data.totalScoreValue = totalScoreValue;
        data.couponCodeId = couponCodeId;
        data.couponDiscountId = couponDiscountId;
        //data.startExpressTimeStr = startExpressTimeStr;
        //data.endExpressTimeStr = endExpressTimeStr;
        data.redPacketCodeId =redPacketCodeId;
        data.promotionId = promotionId;
        data.promotionDiscountId = promotionDiscountId;
        data.expressId = expressId;
        data.addrId = addrId;

        if(flagSub) {
            flagSub = false;
            submitForm("${ctx}/m/account/order/save",data);
        }
    }
    
    //显示支付密码框
    function paymentshow(){
        balancePayment.css({
            top : "100%",
            opacity : 0,
            display : "block"
        }).animate({
            opacity : 1,
            translateY:"-"+balancePayment.height() +"px"
        },{
            duration : 200,
            easing : "ease-in-out"
        });
    }

	//隐藏支付密码框
    function paymenthide(){
        balancePayment.animate({
            opacity : 0,
            translateY:0
        },{
            duration : 200,
            easing : "ease-in-out",
            complete : function () {
                balancePayment.hide();
            }
        });
    }

    $(function(){
    	$('#goAddressList').on('click',function() {
    		setCookie('addressType','1');
    		window.location.href="${ctx}/m/account/userAddress";
    	});
    	<#--选择快递公司-->
    	$('#selectExpress').on('change',function() {
    		if(!flagSub) { return; }
			var total = ${productTotal?default(0)};//商品总金额
			var cityId = $('#cityId').val();
			var totalWeight = $('#totalWeight').val();
			var expressId = $(this).val();
		    var discountTotalAmt = $('.discountTotalAmt').html().trim();
		    var useTotalScoreValue = $('#useTotalScoreValue').val();
		    
		    var data = {};
		    data.total = total;
		    data.cityId = cityId;
		    data.totalWeight = totalWeight;
		    data.expressId = expressId;
		    data.discountTotalAmt = discountTotalAmt;
		    data.useTotalScoreValue = useTotalScoreValue;
		    
			selectExpress(data);
    	});
    	
    	function selectExpress(data) {
    		flagSub = false;
    		$.ajax({
        		url  : '${ctx}/m/account/order/selectExpress',
            	async : true,
            	type : "POST",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
    					var oldTotalExpressAmt = $('.totalExpressAmt').html().trim();
    					$('.totalExpressAmt').html(result.totalExpressAmt)
						$('.total').html(result.total);
    					var isExpressAmt = $('#isExpressAmt').val();
    					if(isExpressAmt != 'true') {
	    					$('.realityPay').html(result.realityPay);
	    					$('.finalPay').html(result.finalPay);
    					} else {
	    					$('.discountTotalAmt').html((parseFloat(data.discountTotalAmt) + (parseFloat(result.totalExpressAmt) - parseFloat(oldTotalExpressAmt))).toFixed(2));
    					}
    				} else {
    					mui.toast(result.message);
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
    	}
    	
    	<#--
    	function renderTimeList(selectDateText){
	        if(selectDateText == "今天"){
	            $("#selectTime").empty();
	            $.each(todayTimeList, function(i, row){
	                $("#selectTime").append("<option value='"+row+"'>"+row+"</option>");
	            });
	        }else {
	            $("#selectTime").empty();
	            $.each(tomorrowTimeList, function(i, row){
	                $("#selectTime").append("<option value='"+row+"'>"+row+"</option>");
	            });
	        }
	    }
    	-->
    	
        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
                specAS = $("#J_ASSpec"), // 优惠券 弹出框内容
                methodPayment = $("#methodpayment"),    // 支付方式 弹出框内容
                userPromition = $("#userPromition"),//活动
				userCoupon = $("#userCoupon"),//优惠券
				userRedPacket = $("#userRedPacket");//红包
        
        <#-- 选择活动 弹出框 -->
        $("#promotion").on("click", function () {
            showSpecAS(userPromition);
        });
        <#-- 关闭活动 弹出框 -->
        userPromition.find(".close").on("click", function () {
            hideSpecAS(userPromition);
        });
        <#-- 活动弹出框 确定 -->
        $("#promotionButton").on("click", function () {
            hideSpecAS(userPromition);
            var promotionDiscountId = userPromition.find("input:checked").val();
            var promotionId = userPromition.find("input:checked").parent().find('.promotionId').val();
            var totalExpressAmt = $('.totalExpressAmt').html().trim();
            var couponDiscountId = $('#couponDiscountId').val();
            var couponCodeId = $('#couponCodeId').val();
            var total = ${productTotal?default(0)};//商品总金额
            var usePromotionValue = $("#usePromotionValue").val();//获取使用活动后的优惠金额
            //var useRedPacketValue = $("#useRedPacketValue").val();//获取使用红包后的优惠金额
            
            var data = {};
            data.promotionDiscountId = promotionDiscountId;
            data.promotionId = promotionId;
            data.couponDiscountId = couponDiscountId;
            data.couponCodeId = couponCodeId;
            data.total = total;
            data.usePromotionValue = usePromotionValue;
            data.totalExpressAmt = totalExpressAmt;
            //data.useRedPacketValue = useRedPacketValue;
            
            if(promotionDiscountId && flagSub) {
            	choosePromotion(data);
            }
            
            /* 确认订单页面-输入优惠码和选择优惠券互斥 (优惠码和其他优惠券不能同用)
            if(couponDiscountId != '-1' && couponCodeId != '-1'){
            	$("#preGenerate").val("");
            	$("#preGenerate").attr("disabled","disabled");
            }else{
            	$("#preGenerate").removeAttr("disabled");
            }*/
        });
        
        <#-- 选择优惠券 弹出框 -->
        $("#distribution").on("click", function () {
            showSpecAS(userCoupon);
        });
        <#-- 关闭优惠券 弹出框 -->
        userCoupon.find(".close").on("click", function () {
            hideSpecAS(userCoupon);
        });
        <#-- 优惠券弹出框 确定 -->
        $("#couponButton").on("click", function () {
            hideSpecAS(userCoupon);
            var couponCodeId = userCoupon.find("input:checked").val();
            var couponDiscountId = userCoupon.find("input:checked").parent().find('.couponDiscountId').val()
            var totalExpressAmt = $('.totalExpressAmt').html().trim();
            //$('#couponDiscountId').val(couponDiscountId);
            //$('#couponCodeId').val(couponCodeId);
            var total = ${productTotal?default(0)};//商品总金额
            var usePromotionValue = $("#usePromotionValue").val();//获取使用活动后的优惠金额
            var promotionDiscountId = $('#promotionDiscountId').val();
            //var useRedPacketValue = $("#useRedPacketValue").val();//获取使用红包后的优惠金额
            var isExpressAmt = $('#isExpressAmt').val();//是否包邮，防止活动中使用，优惠券又使用
            
            var data = {};
            data.couponDiscountId = couponDiscountId;
            data.couponCodeId = couponCodeId;
            data.total = total;
            data.usePromotionValue = usePromotionValue;
            data.totalExpressAmt = totalExpressAmt;
            //data.useRedPacketValue = useRedPacketValue;
            data.isExpressAmt = isExpressAmt;
            data.promotionDiscountId = promotionDiscountId;
            
            if(couponCodeId && flagSub) {
            	chooseCoupon(data);
            }
            
            /* 确认订单页面-输入优惠码和选择优惠券互斥 (优惠码和其他优惠券不能同用)
            if(couponDiscountId != '-1' && couponCodeId != '-1'){
            	$("#preGenerate").val("");
            	$("#preGenerate").attr("disabled","disabled");
            }else{
            	$("#preGenerate").removeAttr("disabled");
            }*/
        });
        
        <#-- 选择红包 弹出框 -->
        $("#redPacket").on("click", function () {
            showSpecAS(userRedPacket);
        });
        <#-- 关闭红包 弹出框 -->
        userRedPacket.find(".close").on("click", function () {
            hideSpecAS(userRedPacket);
        });
        <#-- 红包弹出框 确定 -->
        $("#redPacketButton").on("click", function () {
            hideSpecAS(userRedPacket);
            var redPacketCodeId = userRedPacket.find("input:checked").val();
            var totalExpressAmt = $('.totalExpressAmt').html().trim();
            //$('#redPacketCodeId').val(redPacketCodeId);
            var total = ${productTotal?default(0)};//商品总金额
            var discountTotalAmt = $('.discountTotalAmt').html().trim();
            //var useRedPacketValue = $("#useRedPacketValue").val();//获取使用红包后的优惠金额
            var isExpressAmt = $('#isExpressAmt').val();//是否包邮，确保优惠金额的计算
            var useRedPacketRealityValue = $("#useRedPacketRealityValue").val();
            
            var data = {};
            data.redPacketCodeId = redPacketCodeId;
            data.totalExpressAmt =totalExpressAmt;
            data.total = total;
            data.discountTotalAmt = discountTotalAmt;
            //data.useRedPacketValue = useRedPacketValue;
            data.isExpressAmt = isExpressAmt;
            data.useRedPacketRealityValue = useRedPacketRealityValue;
            
            if(redPacketCodeId && flagSub) {
            	chooseRedPacket(data);
            }
            
		});
		
        <#-- 选择支付方式 弹出框 -->
        $("#paybtn").on("click", function () {
            showSpecAS(methodPayment);
        });
        methodPayment.find(".close").on("click", function () {
            hideSpecAS(methodPayment);
        });
        $(".canclePay").on("click", function () {
            hideSpecAS(methodPayment);
        });
        
        <#-- 抵扣操作 -->
        $(".deductionTotal").on('toggle',function() {
        	switchDisable();
        	switchOpen();
        });
        
        <#-- 余额支付 -->
        var $input = $(".fake-box input");
        var payPassword = "";
        $("#pwd-input").on("input", function() {
            var pwd = $(this).val().trim();
            for (var i = 0, len = pwd.length; i < len; i++) {
                $input.eq("" + i + "").val(pwd[i]);
                payPassword = pwd;
            }
            $input.each(function() {
                var index = $(this).index();
                if (index >= len) {
                    $(this).val("");
                }
            });
            if (len == 6) {
                
            }
        });

        //$("#balancepaymentBtn").on("click", function () {
          //  paymentshow();
        //});
        
        <#--确认余额支付-->
        $("#balancePaymentSub").on("click",function() {
        	if(payPassword.length != 6) {
        		mui.toast('支付密码为6位数字！');
        		return;
        	}
        	if(!flagSub) {
        		return;
        	} 
        	flagSub = false;
        	$.ajax({
        		url  : '${ctx}/m/account/order/testPayPwd',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"payPassword" : payPassword},
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
    					mui.toast('支付成功！');
    					blancePay = true;
    					submitOrder(5);
    				} else {
    					mui.toast(result.message);
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        });

		<#--取消余额支付-->
        $("#balancePaymentCancle").on("click", function () {
            paymenthide();
        });
        
		//显示弹出框
        function showSpecAS(obj){
            specASMask.show().animate({opacity:1},{
                duration:80,
                complete: function () {
                    obj.css({
                        top : "100%",
                        opacity : 0,
                        display : "block"
                    }).animate({
                        opacity : 1,
                        translateY:"-"+obj.height() +"px"
                    },{
                        duration : 200,
                        easing : "ease-in-out"
                    });
                }
            });
        }

		//隐藏弹出框
        function hideSpecAS(obj,callback){
            obj.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    obj.hide();
                    specASMask.animate({opacity:0},{
                        duration : 80,
                        complete: function () {
                            specASMask.hide();
                            if(typeof callback == "function") callback.call();
                        }
                    });
                }
            });
        }
        
        /*开关操作*/
        function switchDisable() {
        	var isActive =  $(".deductionTotal").find(".mui-active");
        	//开
        	if(isActive.length != 0) {
        		var realityPay = parseFloat($('.realityPay').html().trim());//实际支付金额
        		var scoreDiscountTotalValue = parseFloat($('#scoreDiscountTotalValue').val());//本次最多可抵扣的金额
        		if(scoreDiscountTotalValue <= realityPay ) {
        			$('#useTotalScoreValue').val(scoreDiscountTotalValue);
        		} else {
        			$('#useTotalScoreValue').val(realityPay);
        		}
        		
        	} else {
        		$('#useTotalScoreValue').val("");
        	}
        }
        
        /*选择积分抵扣*/
        function switchOpen() {
        	if(!flagSub) {
        		rerturn;
        	}
        	flagSub=false;
        	var realityPay = $('.realityPay').html().trim();//实际支付金额
        	var useTotalScoreValue = $('#useTotalScoreValue').val();//使用积分抵扣金额
        	$.ajax({
            	url  : '${ctx}/m/account/order/chooseScore',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"useTotalScoreValue":useTotalScoreValue,"realityPay":realityPay},
    			success : function(result) {
    				flagSub=true;
    				if(result) {
    					$('.finalPay').html(result.realityPay);// 修改最终合计
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub=true;
    				console.log("请求未成功");
    			}
            });
        }
        
        /*选择活动操作*/
        function choosePromotion(data) {
        	flagSub=false;
        	$.ajax({
            	url  : '${ctx}/m/account/order/choosePromotion',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				flagSub=true;
    				if(result) {
    					$('.needPay').html(result.total);// 修改合计
    					$('.discountTotalAmt').html(result.discountTotalAmt); //修改优惠金额
    					$('#promotion').find('.r').html(result.promotionDesc);//修改活动描述
    					$('#promotionId').val(data.promotionId);
    					$('#promotionDiscountId').val(data.promotionDiscountId);
    					$('#isExpressAmt').val(result.isExpressAmt);
    					$('#usePromotionValue').val(result.promotionValue);
            			//$('#couponCodeId').val(data.couponCodeId);
    					
    					restoreRedPack();
    					$('.deductionTotal').find('.mui-switch-mini').each(function() {//把所有的抵扣方式恢复到未选择状态
	        				if($(this).hasClass('mui-active')) {
	        					$(this).removeClass('mui-active');
	        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
	        					$('#useTotalScoreValue').val("");
	        				} 
	        			});
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub=true;
    				console.log("请求未成功");
    			}
            });
        }
        
        /*选择优惠券操作*/
        function chooseCoupon(data) {
        	flagSub=false;
        	$.ajax({
            	url  : '${ctx}/m/account/order/chooseCoupon',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				flagSub=true;
    				if(result) {
    					$('.needPay').html(result.total);// 修改合计
    					$('.discountTotalAmt').html(result.discountTotalAmt); //修改优惠金额
    					$('#distribution').find('.r').html(result.discountDesc);//修改优惠券描述
    					$('#couponDiscountId').val(data.couponDiscountId);
            			$('#couponCodeId').val(data.couponCodeId);
            			$('#isExpressAmt').val(result.isExpressAmt);
            			
            			restoreRedPack();
    					$('.deductionTotal').find('.mui-switch-mini').each(function() {//把所有的抵扣方式恢复到未选择状态
	        				if($(this).hasClass('mui-active')) {
	        					$(this).removeClass('mui-active');
	        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
	        					$('#useTotalScoreValue').val("");
	        				} 
	        			});
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub=true;
    				console.log("请求未成功");
    			}
            });
        }
        
        /*选择红包操作*/
        function chooseRedPacket(data) {
        	flagSub=false;
        	$.ajax({
            	url  : '${ctx}/m/account/order/chooseRedPacket',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				flagSub=true;
    				if(result) {
    					$('.needPay').html(result.total);// 修改合计
    					$('.discountTotalAmt').html(result.discountTotalAmt); //修改优惠金额
    					$('#redPacket').find('.r').html(result.redPacketDesc);//修改红包描述
    					//$("#useRedPacketValue").val(result.useRedPacketValue);//修改红包优惠金额
    					$('#redPacketCodeId').val(data.redPacketCodeId);
    					$('#useRedPacketRealityValue').val(result.useRedPacketRealityValue);//红包实际的优惠金额
    					
    					$('.deductionTotal').find('.mui-switch-mini').each(function() {//把所有的抵扣方式恢复到未选择状态
	        				if($(this).hasClass('mui-active')) {
	        					$(this).removeClass('mui-active');
	        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
	        					$('#useTotalScoreValue').val("");
	        				} 
	        			});
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub=true;
    				console.log("请求未成功");
    			}
            });
        }
        
        function selectDay(e) {
        	if(e.val == 1) {
        		
        	} else {
        	
        	}
        }
        
        //还原红包的选项
        function restoreRedPack() {
    		var redPacketCodeId = $('#redPacketCodeId').val();
    		if(redPacketCodeId != null || redPacketCodeId != -1) {
    			$('#redPacket .r').html("请选择");
    			$('#useRedPacketRealityValue').val('');
    		}
    	}
    })

    //模拟表单提交
    function submitForm(action,data){
        var div = $("<div style='display: none'><form id='_help-my-form'></form></div>");
        $("body").append(div);
        var helpForm = $("#_help-my-form");
        helpForm.attr("action",action);
        helpForm.attr("method","post");
        $.each(data, function(key, value){
            var inputObj = $("<input name='"+key+"' value='"+value+"'/>");
            helpForm.append(inputObj);
        });
        helpForm.submit();
    }
    
    //设置Cookie
    function setCookie(name, value) {	     
	    document.cookie=name+'='+encodeURIComponent(value) + ';path=/'; 
	}
	//获取cookie
	function getCookie(name) {
	    var arr=document.cookie.split('; ');
	    var i=0;
	    for(i=0;i<arr.length;i++)
	    {
	        var arr2=arr[i].split('=');
	         
	        if(arr2[0]==name)
	        {  
	            var getC = decodeURIComponent(arr2[1]);
	            return getC;
	        }
	    }
	     
	    return '';
	}
</script>
</body>
</html>