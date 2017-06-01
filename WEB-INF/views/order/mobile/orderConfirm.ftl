<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign onLinePayType = 0>
<#assign userCanUseCouponType = 0>
<#assign totalScoreType = 0>
<#assign redPacketBalanceType = 0>
<#assign userBalanceType = 0>
<#assign userRebateDevelopSaleAmtType = 0>
<#assign mStoreIncomeType = 0>
<#if allowPayTypeList?? && allowPayTypeList?has_content>
	<#list allowPayTypeList as allowPayType>
		<#if allowPayType==1>
			<#assign userBalanceType = 1>
		</#if>
		<#if allowPayType==2>
			<#assign onLinePayType = 1>
		</#if>
		<#if allowPayType==4>
			<#assign userCanUseCouponType = 1>
		</#if>
		<#if allowPayType==5>
			<#assign totalScoreType = 1>
		</#if>
		<#if allowPayType==6>
			<#assign redPacketBalanceType = 1>
		</#if>
		<#if allowPayType==7>
			<#assign userRebateDevelopSaleAmtType = 1>
		</#if>
		<#if allowPayType==8>
			<#assign mStoreIncomeType = 1>
		</#if>
	</#list>
</#if>

<!doctype html>
<html lang="en">
<head>
    <title>确认订单</title>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a href="${ctx}/m/cart/list" class="mui-icon mui-icon-left-nav"></a>
		            <h1 class="mui-title">确认订单</h1>
	            <a class="mui-icon"></a>
	        </header>
       	</#if>
		<input type="hidden" id="payMode" value="1"/>
		<input type="hidden" id="combinationPromotionId" value="${combinationPromotionId!}"/>
		<input type="hidden" id="isQuotaNum" value="${isQuatoNum!}"/>
        <div class="mui-content">
        	<#assign isAddress=0/>
        	<#if userReceiveAddressDTO?? && userReceiveAddressDTO?has_content>
            	<#assign address = userReceiveAddressDTO.getAddressFullName()/>
            	<#assign isAddress=1/>
            </#if>
            <#if isAddress==1>
	            <div class="order-address addr-item">
	            	<input type="hidden" id="addressId" value="<#if userReceiveAddressDTO??>${(userReceiveAddressDTO.addrId)!}</#if>"/>
	                <span class="name"><#if userReceiveAddressDTO??>${(userReceiveAddressDTO.receiverName)!}</#if></span>
	                <span class="phone"><#if userReceiveAddressDTO??>${(userReceiveAddressDTO.receiverTel)!}</#if></span>
	                
	                <address id="address">${address}</address>
	            </div>
            </#if>
            <#if isAddress==0>
	            <div class="order-address addr-item addr-item-empty">
	                <a href="${ctx}/m/account/address/addUserAddress?addressType=1">
	                <address>您的收货信息为空，点此添加收货地址</address>
	                </a>
	            </div>
            </#if>
            
            <div class="borderbox">
                <ul class="prd-list order-prd-list sure-prd-list">
                    <li>
                        <div class="hd">
                            <span class="c">${storeValue!?html}</span>
                        </div>
						
						<#if cartAndCouponDTOList?? && cartAndCouponDTOList?has_content>
							<#list cartAndCouponDTOList as cartAndCouponDTO>
								<#if cartAndCouponDTO.promotionTypeCd?? && cartAndCouponDTO.promotionTypeCd?has_content>
	                            	<#if cartAndCouponDTO.promotionTypeCd == 54 || cartAndCouponDTO.promotionTypeCd == 55>
	                                	<#if cartAndCouponDTO.discountTypeCd ==2 >
	                                		<#assign discountTypeValue="满折" discountTypeClass="keepfolding">
	                                	<#else>
	                                		<#assign discountTypeValue="满减" discountTypeClass="fullreduction">
	                                	</#if>
	                            	<#else>
	                            		<#if cartAndCouponDTO.promotionTypeCd == 1>
	                            			<#assign discountTypeValue="满折" discountTypeClass="keepfolding">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 2>
	                            			<#assign discountTypeValue="满减" discountTypeClass="fullreduction">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 3>
	                            			<#assign discountTypeValue="满赠" discountTypeClass="hidegift">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 5>
	                            			<#assign discountTypeValue="包邮" discountTypeClass="hidegift">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 4>
	                            			<#assign discountSpan = "<span>限时特价</span>">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 51>
	                            			<#assign discountSpan = "<span>秒杀</span>">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 52>
	                            			<#assign discountSpan = "<span>组合销售</span>">
	                            		<#elseif cartAndCouponDTO.promotionTypeCd == 53>
	                            			<#assign discountSpan = "<span>团购</span>">
	                            		</#if>
	                            	</#if>
                            	</#if>
								<div class="info">
		                            <div class="itemsinfo">
		                            <a href="#">
		                                <div class="pic"><img src="${(cartAndCouponDTO.productPicUrl)!}"></div>
		                                <h3>${discountSpan!}${(cartAndCouponDTO.productName)!}</h3>
		                                <p class="price"><span class="price-real">￥<em>${(cartAndCouponDTO.firstAddedSalePrice)!}</em>/件</span></p>
		                                <p class="spec">数量：${(cartAndCouponDTO.quantity)!}</p>
	                                	<#if cartAndCouponDTO.promotionTypeCd?? && discountTypeValue??>
	                                	<div class="information">
		                                    <div class="content">
		                                        <span class="${discountTypeClass}">${discountTypeValue}</span>
		                                        <p>${(cartAndCouponDTO.promotionDiscountDesc)!?html}</p>
		                                    </div>
		                                </div>
		                                </#if>
		                            </a>
		                            </div>
		                        </div>
		                        <#if cartAndCouponDTO.promotionGiftXrefDTOList?? && cartAndCouponDTO.promotionGiftXrefDTOList?has_content>
                                	<#list cartAndCouponDTO.promotionGiftXrefDTOList as promotionGiftXrefDTO>
                                	<div class="info">
			                            <div class="itemsinfo">
				                            <a href="#">
				                                <div class="pic"><img src="${(promotionGiftXrefDTO.productPicUrl)!}"></div>
				                                <h3>${(promotionGiftXrefDTO.productName)!}</h3>
				                                <p class="price"><span class="price-real">￥<em>${(promotionGiftXrefDTO.defaultPrice)!}</em>/件</span></p>
				                                <p class="spec">数量：1</p>
		                                		<div class="information">
				                                    <div class="content">
				                                        <span class="hidegift">赠品</span>
				                                    </div>
				                                </div>
				                             </a>
				                         </div>
				                     </div>   
                                	</#list>
                                </#if>
							</#list>
						</#if>
                    </li>
                </ul>
                <#if pinkageDesc??>
	                <div class="payment-info bggray">
	                    <h3>提示信息</h3>
	                    <p class="gray">${pinkageDesc!}</p>
	                </div>
                </#if>
            	<input type="hidden" id="paymentTimesDiscountValue" value="${paymentTimesDiscountValue!}">
                <#if paymentTimes??>
	                <div class="payment-info bggray">
	                    <p class="gray">您是第 ${paymentTimes!}次在商城中下单，可减免金额：￥ ${paymentTimesDiscountValue!} 元</p>
	                </div>
                </#if>
                <div class="tbviewlist">
                    <ul>
                    	<!--
                        <li class="mc-info-link">
                            <a class="itemlink" href="javascript:void(0);" id="distribution">
                                <div class="r">顺丰快递</div>
                                <div class="c">配送方式</div>
                            </a>
                        </li>
                        -->
                        
                        <#if promotionSalesDTOList?? && promotionSalesDTOList?has_content>
	                        <li class="mc-info-link">
	                            <a class="itemlink" href="#" id="orderPromotion">
	                                <div class="r">${promotionDesc?default("请选择")}</div>
	                                <div class="c">活动</div>
	                            </a>
	                        </li>
                        </#if>
                        
                        <#if userCanUseCouponDTOList?? && userCanUseCouponDTOList?has_content && userCanUseCouponType = 1>
	                        <li class="mc-info-link">
	                            <a class="itemlink" href="#" id="distribution">
	                                <div class="r">${discountDesc?default("请选择")}</div>
	                                <div class="c">优惠券</div>
	                            </a>
	                        </li>
                        </#if>
                    </ul>
                </div>
                
                <!-- 2016.9.1 By caobr 确认订单页面增加预生成优惠码输入框 start -->
                <#if IsCouponAndPromotion?? && IsCouponAndPromotion && userCanUseCouponType = 1>
                <div class="tbviewlist">
                    <ul>
	                	<li class="mc-info-link">
	                		<div class="hd">使用优惠码:</div>
	                        <div class="bd" style="-webkit-box-flex: 1;">
	                        	<div class="r" id="discountDesc"></div>
	                            <div class="c" style="white-space: nowrap; overflow: hidden; display: block; -ms-text-overflow: ellipsis; text-overflow: ellipsis;">
	                            	<input type="text" id="preGenerate" placeholder="填写您获得的优惠码">
	                            </div>
	                        </div>
                        </li>
                    </ul>
                </div>
                </#if>
                <!-- 2016.9.1 By caobr 确认订单页面增加预生成优惠码输入框 end -->
                
                <ul class="tbviewlist tbviewlist-order">
                    <li>
                        <div class="hd">买家留言:</div>
                        <div class="bd">
                            <input type="text" id="remark" placeholder="选填，可填写您的需求">
                        </div>
                    </li>
                </ul>
                <ul class="prd-list order-prd-list">
                    <li>
                        <div class="ft">
                        	<input type="hidden" id="totals" value="${totals?default(0)}">
                            共${totalNum?default(0)}件商品，合计：<span>￥${totals?default(0)}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul class="deduction">
                    	<#if userConsumeCalc?? && userConsumeCalc?has_content>
							<#if userConsumeCalc.totalScore?default(0) gt 0 && totalScoreType==1>
								<li class="mc-info-link">
		                            <a class="itemlink totalScoreValue deductionTotal" href="javascript:void(0);">
		                                <div class="r">
		                                    <div class="mui-switch mui-switch-mini">
		                                        <div class="mui-switch-handle"></div>
		                                    </div>
		                                </div>
		                                <input type="hidden" class="nowValue" id="totalScoreValue">
		                                <input type="hidden" class="in_it" value="${totalScoreValue!}">
		                                <div class="c">积分抵扣<span>可用${userConsumeCalc.totalScore!}积分抵扣¥${totalScoreValue!}</span></div>
		                            </a>
		                        </li>
							</#if>
							<#if userConsumeCalc.redPacketBalance?default(0) gt 0 && redPacketBalanceType==1>
								<li class="mc-info-link">
		                            <a class="itemlink redPacketBalance deductionTotal" href="javascript:void(0);">
		                                <div class="r">
		                                    <div class="mui-switch mui-switch-mini">
		                                        <div class="mui-switch-handle"></div>
		                                    </div>
		                                </div>
		                                <input type="hidden" class="nowValue" id="redPacketBalance">
		                                <input type="hidden" class="in_it" value="${userConsumeCalc.redPacketBalance!}">
		                                <div class="c">红包抵扣<span>可抵扣¥${userConsumeCalc.redPacketBalance!}</span></div>
		                            </a>
		                        </li>
							</#if>
							<#if userConsumeCalc.userBalance?default(0) gt 0 && userBalanceType==1>
								<li class="mc-info-link">
		                            <a class="itemlink UserBalance deductionTotal" href="javascript:void(0);">
		                                <div class="r">
		                                    <div class="mui-switch mui-switch-mini ">
		                                        <div class="mui-switch-handle"></div>
		                                    </div>
		                                </div>
		                                <input type="hidden" class="nowValue" id="userBalance">
		                                <input type="hidden" class="in_it" value="${userConsumeCalc.userBalance!}">
		                                <div class="c">购酒券抵扣<span>可抵扣¥${userConsumeCalc.userBalance!}</span></div>
		                            </a>
		                        </li>
							</#if>
							<#if userConsumeCalc.userRebateDevelopSaleAmt?default(0) gt 0 && userRebateDevelopSaleAmtType==1>
								<li class="mc-info-link">
		                            <a class="itemlink userRebateDevelopSaleAmt deductionTotal" href="javascript:void(0);">
		                                <div class="r">
		                                    <div class="mui-switch mui-switch-mini ">
		                                        <div class="mui-switch-handle"></div>
		                                    </div>
		                                </div>
		                                <input type="hidden" class="nowValue" id="userRebateDevelopSaleAmt">
		                                <input type="hidden" class="in_it" value="${userConsumeCalc.userRebateDevelopSaleAmt!}">
		                                <div class="c">分销收入抵扣<span>可抵扣¥${userConsumeCalc.userRebateDevelopSaleAmt!}</span></div>
		                            </a>
		                        </li>
							</#if>
                    	</#if>
                    	<#if mStoreIncome?? && mStoreIncome?has_content && mStoreIncomeType==1>
							<li class="mc-info-link">
	                            <a class="itemlink mStoreIncome deductionTotal" href="javascript:void(0);">
	                                <div class="r">
	                                    <div class="mui-switch mui-switch-mini ">
	                                        <div class="mui-switch-handle"></div>
	                                    </div>
	                                </div>
	                                <input type="hidden" class="nowValue" id="mStoreIncome">
	                                <input type="hidden" class="in_it" value="${mStoreIncome!}">
	                                <div class="c">微店收入抵扣<span>可抵扣¥${mStoreIncome!}</span></div>
	                            </a>
	                        </li>
						</#if>
                        <li class="mc-info-link" id="invoice">
                            <a class="itemlink" href="#">
                            	<#assign isInvoice = 0 />
                            	<#if userInvoiceManage?? && userInvoiceManage?has_content>
                            		<#assign isInvoice = 1 />
                            		<div class="r">
                            			<#if userInvoiceManage.invoiceForCd == 1>个人发票<#else>单位发票</#if> ${(userInvoiceManage.companyName)!?html}
                            		</div>
                            		<input type="hidden" id="invoiceId" value="${userInvoiceManage.invoiceId!}">
                            	</#if>
                            	<#if isInvoice == 0>
                            		<input type="hidden" id="invoiceId" value="-1">
                            		<div class="r">不需要</div>
                            	</#if>
                                
                                <div class="c">发票</div>
                            </a>
                        </li>
                        <#if invoiceAddressDTO?? && invoiceAddressDTO?has_content>
                        	<#assign invoiceAddress = invoiceAddressDTO.provinceName+" "+invoiceAddressDTO.cityName+" "+invoiceAddressDTO.countyName+invoiceAddressDTO.receiverAddr/>
                        	<li class="mc-info-link invoiceh">
	                            <a class="itemlink" href="${ctx}/m/account/address/chooseAddressList?addressType=2" >
	                                <div class="c">发票收货地址</div>
	                                <div class="order-address addr-item" style="clear: both;">
	                                	<input type="hidden" id="invoiceAddressId" value="${(invoiceAddressDTO.addrId)!}"/>
	                                    <span class="name">${(invoiceAddressDTO.receiverName)!}</span>
	                                    <span class="phone">${(invoiceAddressDTO.receiverTel)!}</span>
	                                    <address>${invoiceAddress!}</address>
	                                </div>
	                            </a>
	                        </li>
                        </#if>
                        
                        <#if onLinePayType == 1>
	                        <li class="mc-info-link">
	                            <a class="itemlink" href="#" id="payMethod">
	                                <div class="r">请选择</div>
	                                <div class="c">支付方式</div>
	                            </a>
	                        </li>
                        </#if>
                    </ul>
                </div>
            </div>
        </div>

        <div class="fbbwrap fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in">
                        <div class="r">
                        	<input type="hidden" id="preGenerateCode">
                        	<input type="hidden" id="usePromotionValue" value="${usePromotionValue?default(0)}"/>
                        	<input type="hidden" id="useCouponValue" value="${useCouponValue?default(0)}"/>
                            <input type="hidden" id="hideCoutal" value="<#if couponTotal?? >${couponTotal?default(0)}</#if>"/>
                            <div class="main-info">合计：<span>¥ <em>${couponTotal?default(0)}</em></span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap cash-buttons">
                    <a class="button button-wrap-disabled" id="submitOrder" href="javascript:void(0)"><span>提交订单</span></a>
                </div>
            </div>
        </div>

        <div id="J_ASSpec" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">优惠券列表</div>
                <input type="hidden" id="couponCodeId" value="${couponCodeId!}"/>
                <input type="hidden" id="couponDiscountId" value="${couponDiscountId!}"/>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                	<#if userCanUseCouponDTOList??>
                		<ul class="tbviewlist paytypes">
                		<#list userCanUseCouponDTOList as userCanUseCouponDTO>
                			<#assign discountTypeValue="满减" discountTypeClass="fullreduction">
                        	<#if userCanUseCouponDTO.discountTypeCd ==2 >
                        		<#assign discountTypeValue="满折" discountTypeClass="keepfolding">
                        	</#if>
                        	<li>
	                            <label>
	                                <input type="radio" name="paytype" value="${userCanUseCouponDTO.id!}">
	                                <input type="hidden" class="couponCodeId" value="${userCanUseCouponDTO.couponCodeId!}"/>
	                                <div class="l">
	                                    <div class="lable ${discountTypeClass}">${discountTypeValue}</div>
	                                    <div class="prompt">${userCanUseCouponDTO.promotionName!}(${userCanUseCouponDTO.discountDesc!})</div>
	                                </div>
	                            </label>
	                        </li>
                		</#list>
                			<li>
	                            <label>
	                            <input type="radio" name="paytype" value="-1"/>
	                            <input type="hidden" class="couponCodeId" value="-1"/>
	                            <div class="r"></div>
	                            <div class="c"></i>不选择优惠券</div>
	                        	</label>
	                        </li>
                		</ul>
                	</#if>
                </div>
            </div>

            <div class="fbbwrap nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy couponBtn">确定</a>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="J_ASSpec1" class="actionsheet-spec">
            <div class="close closePromotion"></div>
            <div class="prod-info">
                <div class="title">活动列表</div>
                <input type="hidden" id="promotionId" value="${promotionId!}"/>
                <input type="hidden" id="promotionRuleId" value="${promotionRuleId!}"/>
                <input type="hidden" id="conditionId" value="${conditionId!}"/>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                	<#if promotionSalesDTOList?? && promotionSalesDTOList?has_content>
                		<ul class="tbviewlist paytypes">
                		<#list promotionSalesDTOList as promotionSalesDTO>
                			<#assign discountTypeValue="满减" discountTypeClass="fullreduction">
                        	<#if promotionSalesDTO.promotionTypeCd ==2 >
                        		<#assign discountTypeValue="满折" discountTypeClass="keepfolding">
                        	<#elseif promotionSalesDTO.promotionTypeCd ==3>
                        		<#assign discountTypeValue="满赠" discountTypeClass="hidegift">
                        	<#elseif promotionSalesDTO.promotionTypeCd ==4>
                        		<#assign discountTypeValue="包邮" discountTypeClass="hidegift">
                        	</#if>
                        	<li>
	                            <label>
	                                <input type="radio" name="paytype" value="${promotionSalesDTO.promotionId!}">
	                                <input type="hidden" class="promotionId" value="${promotionSalesDTO.promotionId!}"/>
	                                <input type="hidden" class="conditionId" value="${promotionSalesDTO.conditionId!}"/>
	                                <input type="hidden" class="promotionRuleId" value="${promotionSalesDTO.id!}"/>
	                                <div class="l">
	                                    <div class="lable ${discountTypeClass}">${discountTypeValue}</div>
	                                    <div class="prompt">${promotionSalesDTO.discountDesc!}</div>
	                                </div>
	                            </label>
	                        </li>
                		</#list>
                			<li>
	                            <label>
	                            <input type="radio" name="paytype" value="-1"/>
	                            <input type="hidden" class="promotionId" value="-1"/>
                                <input type="hidden" class="conditionId" value="-1"/>
                                <input type="hidden" class="promotionRuleId" value="-1"/>
	                            <div class="r"></div>
	                            <div class="c"></i>不选择活动</div>
	                        	</label>
	                        </li>
                		</ul>
                	</#if>
                </div>
            </div>

            <div class="fbbwrap nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button btn-buy promotionBtn">确定</a>
                    </div>
                </div>
            </div>
        </div>
    <div id="J_ASSpec2" class="actionsheet-spec">
        <div class="close closePay"></div>
        <div class="prod-info">
            <div class="title">支付方式</div>
            <input type="hidden" id="payWay" value="-1"/>
        </div>
        <div class="spec-list">
            <div class="spec-list-wrap">
                <ul class="tbviewlist paytypes">
                	<#if businessConfigTypeList?? && businessConfigTypeList?has_content>
                		<#list businessConfigTypeList?keys as key>
                			<#assign payClass="payico-alipay" />
                			<#if key="config_alipay_mobile">
                				<#assign payClass="payico-alipay" />
                			<#elseif key="config_unionpay_mobile">
                				<#assign payClass="payico-bankcard" />
                			<#elseif key="weixin_pay_config">
                				<#assign payClass="payico-wechat" />
                			</#if>
                    		<li>
	                            <label>
	                                <input type="radio" name="paytype" value="${key}">
	                                <div class="r"></div>
	                                <div class="c"><i class="payico ${payClass}"></i>${businessConfigTypeList[key]!}</div>
	                            </label>
	                        </li>
                		
                		</#list>
                	</#if>
                </ul>
            </div>
        </div>

        <div class="fbbwrap nofixed">
            <div class="ftbtnbar">
                <div class="button-wrap button-wrap-expand">
                    <a href="javascript:void(0)" class="button btn-buy payBtn">确定</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
    	<#if isUserPromotion??>
    		mui.toast('您所选商品中的一些活动未满足条件，已自动删除该活动！');
    	</#if>
    	var flag=true;//设置一个标记
        var flagSub = true;//防止表单多次提交
        /*2016.9.18 By caobr cookie中保存的优惠码*/
        $("#preGenerate").val(getCookie("preGenerateCode"));
        /*2016.9.18 By caobr cookie中保存的优惠码*/
        
        $('#remark').val(getCookie('remark'));//如果cookie中有用于留言，则显示
        loadPayWay();//获取cookie中的支付方式，加载
        
    	//changeClass();
        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        
        //选择优惠券
        $("#distribution").on("click", function () {
        	
       		/* 2016.9.1 By caobr 确认订单页面-输入优惠码和选择优惠券互斥 (优惠码和其他优惠券不能同用) start*/
      		var preGenerate = $("#preGenerate").val();
      		if(preGenerate && $.trim(preGenerate)){
      			$('#J_ASSpec input[type=radio]:checked').removeAttr("checked");
      			$('#J_ASSpec').find("input[type=radio]").attr("disabled","disabled");
      		}else{
       			$('#J_ASSpec').find("input[type=radio]").removeAttr("disabled");
       		}
       		/* 2016.9.1 By caobr 确认订单-输入优惠码和选择优惠券互斥 (优惠码和其他优惠券不能同用) end*/
        	
       		specAS = $("#J_ASSpec");
            showSpecAS();
        });
        specAS.find(".close").on("click", function () {
            hideSpecAS();
        });
		//确认
        $(".couponBtn").on("click", function () {
        	if(!flag) { return; }
            hideSpecAS();
            var couponDiscountId = $('#J_ASSpec').find("input:checked").val();
            var couponCodeId = $('#J_ASSpec').find("input:checked").parent().find('.couponCodeId').val()
            $('#couponDiscountId').val(couponDiscountId);
            $('#couponCodeId').val(couponCodeId);
            var total = $("#totals").val();//商品总金额
            var usePromotionValue = $("#usePromotionValue").val().trim();//获取隐藏域中，使用活动后的优惠金额
            
            var paymentTimesDiscountValue = $("#paymentTimesDiscountValue").val();//获取减免的金额
            
            if(couponCodeId) {
            	chooseCoupon(couponDiscountId,couponCodeId,total,usePromotionValue,paymentTimesDiscountValue);
            }
            
            /* 2016.9.1 By caobr 确认订单页面-输入优惠码和选择优惠券互斥 (优惠码和其他优惠券不能同用) start*/
            if(couponDiscountId != '-1' && couponCodeId != '-1'){
            	$("#preGenerate").val("");
            	$("#preGenerate").attr("disabled","disabled");
            }else{
            	$("#preGenerate").removeAttr("disabled");
            }
            /* 2016.9.1 By caobr 确认订单页面-输入优惠码和选择优惠券互斥 (优惠码和其他优惠券不能同用) end*/
            
        });
        
        $("#preGenerate").blur(function(){
        	var payAmt = nowTotal();//订单实际支付总额，订单实际支付总额=订单总额-优惠总额-红包-积分-购酒劵
        	$("#discountDesc").html('');
        	$('#couponDiscountId').val('');
        	$('#couponCodeId').val('');
        	$("#useCouponValue").val(0);
        	//重新计算合计金额
			$('.fbbwrap-total .main-info').find('em').html(nowTotal());
			
        	$("#preGenerateCode").val('');
        	
        	var preGenerate = $("#preGenerate").val();
        	if(!preGenerate || !$.trim(preGenerate)){
        		return;
        	};
        	$.ajax({
            	url  : '${ctx}/m/account/order/getPromotionDiscountRuleByCouponCode',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"preGenerate" : preGenerate,"payAmt":payAmt},
    			success : function(data) {
    				if(!data) {
    					return;
    				}
    				if(data.result && data.result == 'warning'){
    					mui.toast(data.message);
    					$("#preGenerate").val('');
    					return;
    				}else{
    					var p = data.p;
    					
    					$("#preGenerateCode").val(p.couponCode);
    					if(p.id){
    						$('#couponDiscountId').val(p.id);
    					}
    					if(p.couponCodeId){
    						$('#couponCodeId').val(p.couponCodeId);
    					}
    					$("#discountDesc").html(p.discountDesc?p.discountDesc:'');
    					
    					
    					if(p.discountValue){
    						//修改使用优惠券后的优惠金额
    						$("#useCouponValue").val(p.discountValue);
    						$('.fbbwrap-total .main-info').find('em').html(nowTotal());
    					}
    					
    					setCookie("preGenerateCode", preGenerate);
    				}
    			}
            });
        });
        /* 2016.9.18 By caobr */
        $("#preGenerate").focus().blur();
        
        //选择支付方式
        $("#payMethod").on("click", function () {
        specAS = $("#J_ASSpec2");
            showSpecAS();
        });
        $('.closePay').click(function() {
        	hideSpecAS();
        });
		//确认
        $(".payBtn").on("click", function () {
        	if(!flag) { return; }
            hideSpecAS();
            var payWay = $('#J_ASSpec2').find("input:checked").val() ? $('#J_ASSpec2').find("input:checked").val() : -1 ;
            var payName = $('#J_ASSpec2').find("input:checked").parent().find('.c').text()? $('#J_ASSpec2').find("input:checked").parent().find('.c').text() : '';
            $('#payWay').val(payWay);
            $('#payMethod').find('.r').html(payName);
            setCookie("payWay", payWay);
            submitOrderButton(nowTotal());
        });
        
        //选择活动
        $("#orderPromotion").on("click", function () {
        specAS = $("#J_ASSpec1");
            showSpecAS();
        });
        $('.closePromotion').click(function() {
        	hideSpecAS();
        });
		//确认
        $(".promotionBtn").on("click", function () {
        	if(!flag) { return; }
            hideSpecAS();
            var promotionId = $('#J_ASSpec1').find("input:checked").parent().find('.promotionId').val();
            var promotionRuleId = $('#J_ASSpec1').find("input:checked").parent().find('.promotionRuleId').val();
            promotionRuleId = promotionRuleId ? promotionRuleId : '';
            var conditionId = $('#J_ASSpec1').find("input:checked").parent().find('.conditionId').val();
            conditionId = conditionId ? conditionId : '';
            
            $('#promotionId').val(promotionId);
            $('#promotionRuleId').val(promotionRuleId);
            $('#conditionId').val(conditionId);
            var total = $("#totals").val();//商品总金额
            var useCouponValue = $("#useCouponValue").val().trim();//获取隐藏域中，使用优惠券后的优惠金额
            
            var paymentTimesDiscountValue = $("#paymentTimesDiscountValue").val();//获取减免的金额
            
            if(promotionId) {
            	choosePromotion(promotionId, promotionRuleId, conditionId, total, useCouponValue, paymentTimesDiscountValue);
            }
        });
        
        //选择优惠券操作
        function chooseCoupon(couponDiscountId,couponCodeId,total,usePromotionValue,paymentTimesDiscountValue) {
        	flag=false;
        	$.ajax({
            	url  : '${ctx}/m/account/order/chooseCoupon',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"couponDiscountId" : couponDiscountId,"couponCodeId" : couponCodeId,"total" : total,"usePromotionValue" : usePromotionValue,"paymentTimesDiscountValue":paymentTimesDiscountValue},
    			success : function(result) {
    				flag=true;
    				if(result) {
    					$('.fbbwrap-total .main-info').find('em').html(result.total);// 修改合计
    					$("#hideCoutal").val(result.total);   //修改隐藏域合计的值
    					$('#useCouponValue').val(result.useCouponValue); //修改使用优惠券后的优惠金额
    					$('#distribution').find('.r').html(result.discountDesc);//修改优惠券描述
    					$('.deduction').find('.mui-switch-mini').each(function() {//把所有的抵扣方式恢复到未选择状态
        				if($(this).hasClass('mui-active')) {
        					$(this).removeClass('mui-active');
        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
        					$(this).parent().parent().find('.nowValue').val('');
        				} else if($(this).hasClass('mui-disabled')) {
        					$(this).removeClass('mui-disabled');
        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
        					$(this).parent().parent().find('.nowValue').val('');
        				}
        				submitOrderButton(nowTotal());
        			});
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flag=true;
    				console.log("请求未成功");
    			}
            });
        }
        
        //选择活动操作
        function choosePromotion(promotionId, promotionRuleId, conditionId, total, useCouponValue,paymentTimesDiscountValue) {
        	flag=false;
        	$.ajax({
            	url  : '${ctx}/m/account/order/choosePromotion',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"promotionId" : promotionId,"promotionRuleId" : promotionRuleId,"conditionId" : conditionId,"total" : total,"useCouponValue" : useCouponValue,"paymentTimesDiscountValue":paymentTimesDiscountValue},
    			success : function(result) {
    				flag=true;
    				if(result) {
    					if(result.message) {
    						$("#isQuotaNum").val('1');//用于判断所选订单活动中的限购数是否满足商品的数量,有值代表不满足
    						mui.alert(result.message);
    					}else{
    						$("#isQuotaNum").val('');
    					}
    					
    					$('.fbbwrap-total .main-info').find('em').html(result.total);// 修改合计
    					$("#hideCoutal").val(result.total);   //修改隐藏域的值
    					$('#usePromotionValue').val(result.promotionValue); //修改使用活动后的优惠金额
    					$('#orderPromotion').find('.r').html(result.promotionDesc);//修改优惠券描述
    					$('.deduction').find('.mui-switch-mini').each(function() {//把所有的抵扣方式恢复到未选择状态
        				if($(this).hasClass('mui-active')) {
        					$(this).removeClass('mui-active');
        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
        					$(this).parent().parent().find('.nowValue').val('');
        				} else if($(this).hasClass('mui-disabled')) {
        					$(this).removeClass('mui-disabled');
        					$(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
        					$(this).parent().parent().find('.nowValue').val('');
        				}
        				submitOrderButton(nowTotal());
        			});
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flag=true;
    				console.log("请求未成功");
    			}
            });
        }

        <#if totalScoreValue1?? && totalScoreValue1?has_content>
        	$('.borderbox .totalScoreValue .r .mui-switch').addClass('mui-active');
        	$('.borderbox .totalScoreValue .mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(16px, 0px);');
        	$("#totalScoreValue").val(${totalScoreValue1!});
        </#if>
        <#if redPacketBalance1?? && redPacketBalance1?has_content>
	        $('.borderbox .redPacketBalance .r .mui-switch').addClass('mui-active');
	        $('.borderbox .redPacketBalance .mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(16px, 0px);');
	        $("#redPacketBalance").val(${redPacketBalance1!});
        </#if>
        <#if userBalance1?? && userBalance1?has_content>
	        $('.borderbox .UserBalance .r .mui-switch').addClass('mui-active');
	        $('.borderbox .UserBalance .mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(16px, 0px);');
	        $("#userBalance").val(${userBalance1!});
        </#if>
        <#if userRebateDevelopSaleAmt1?? && userRebateDevelopSaleAmt1?has_content>
	        $('.borderbox .userRebateDevelopSaleAmt .r .mui-switch').addClass('mui-active');
	        $('.borderbox .userRebateDevelopSaleAmt .mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(16px, 0px);');
	        $("#userRebateDevelopSaleAmt").val(${userRebateDevelopSaleAmt1!});
        </#if>
        <#if mStoreIncome1?? && mStoreIncome1?has_content>
	        $('.borderbox .mStoreIncome .r .mui-switch').addClass('mui-active');
	        $('.borderbox .mStoreIncome .mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(16px, 0px);');
	        $("#mStoreIncome").val(${mStoreIncome1!});
        </#if>
      	<#if hidecouTotal?? && hidecouTotal?has_content >
        	$('.fbbwrap-total .main-info').find('em').html(${hidecouTotal?default(0)});// 修改合计
      	</#if>
      	

        //抵扣操作
        $(".deductionTotal").on('toggle',function() {
        	switchDisable($(this));
        	switchOpen();
        });
        
           
        //根据地址和支付方式，改变提交订单按钮的样式。(防止页面来回跳转，按钮样式显示不对的问题)
        submitOrderButton(nowTotal());
        if(nowTotal() > 0) {
			$('#payMethod').parent().show();//显示支付方式
		} else {
			$('#payWay').val(-1);
			$('#payMethod').parent().hide();//隐藏支付方式
			
			//刷新页面时，判断支付的金额是否小余0；是就执行对应3种抵扣样式的改变；
			$('.deduction').find('.mui-switch-mini').each(function() {//把关的按钮禁用掉
				if(!$(this).hasClass('mui-active')) {
					$(this).addClass('mui-disabled');
				}
			});
		}
        
        //提交订单
        $('#submitOrder').on('click',function() {
        	var addressId= $('#addressId').val();
        	var invoiceId = $('#invoiceId').val();
        	var invoiceAddressId = $('#invoiceAddressId').val()?$('#invoiceAddressId').val() : '';//发票收货地址
        	var couponDiscountId = $('#couponDiscountId').val()?$('#couponDiscountId').val() : '' ;//优惠券折扣规则Id
        	var couponCodeId = $('#couponCodeId').val()?$('#couponCodeId').val() : '' ;//优惠券使用Id
        	
        	/* 2016.9.1 By caobr 优惠码值 start*/
        	//var preGenerate = $('#preGenerate').val()?$('#preGenerate').val() : '';
        	/* 2016.9.1 By caobr 优惠码值 end*/
        	
        	var promotionId = $('#promotionId').val()?$('#promotionId').val() : '';//活动Id
        	var promotionRuleId = $('#promotionRuleId').val()?$('#promotionRuleId').val() : '';//活动规则Id
        	var conditionId = $('#conditionId').val()?$('#conditionId').val() : '';//活动条件Id
        	var combinationPromotionId = $('#combinationPromotionId').val()?$('#combinationPromotionId').val() : '';//组合销售活动Id
        	
        	var payMode = $('#payMode').val();//支付类型（目前默认线上支付值为1）
        	var payWay = $('#payWay').val();//支付方式
        	switch(payWay){
        		case 'config_alipay_mobile': payWay = 2;break;//支付宝
        		case 'config_unionpay_mobile': payWay = 4;break;//银联
        		case 'weixin_pay_config': payWay = 1;break;//微信
        		default : payway = -1;
        	
        	}
        	var payAmt = nowTotal();//订单实际支付总额，订单实际支付总额=订单总额-优惠总额-红包-积分-购酒劵
        	var remark = $('#remark').val();//用户备注
        	
        	var totalScoreValue = $('#totalScoreValue').val()?$('#totalScoreValue').val() : '';//积分
        	var userBalance = $('#userBalance').val()?$('#userBalance').val() : ''//红包
        	var redPacketBalance = $('#redPacketBalance').val()?$('#redPacketBalance').val() : '';//购酒券
        	var userRebateDevelopSaleAmt = $('#userRebateDevelopSaleAmt').val()?$('#userRebateDevelopSaleAmt').val() : '';//分销收入
        	var mStoreIncome = $('#mStoreIncome').val()?$('#mStoreIncome').val() : '';//微店收入
        	
        	if(!addressId) {
        		mui.toast('请选择收货地址');
        		return;
        	}
        	
        	if(remark.length > 255) {
        		mui.toast('用户备注不能超过255个字');
        		return;
        	}
        	
        	if(payAmt > 0 && (payWay == -1 || !payWay)) {
        		mui.toast('请选择支付方式');
        		return;
        	}
        	//按钮样式为disabled时，点击无效果
        	if($(this).is('.button-wrap-disabled')) {
        		return;
        	}
        	
        	var data = {};
        	data.addressId = addressId;
        	data.invoiceId = invoiceId;
        	data.invoiceAddressId = invoiceAddressId;
        	data.couponDiscountId = couponDiscountId;
        	data.couponCodeId = couponCodeId;
        	data.payMode = payMode;
        	data.payWay = payWay;
        	data.payAmt = payAmt;
        	data.remark = remark;
        	data.totalScoreValue = totalScoreValue;
        	data.userBalance = userBalance;
        	data.redPacketBalance = redPacketBalance;
        	data.promotionId = promotionId;
        	data.promotionRuleId = promotionRuleId;
        	data.conditionId = conditionId;
        	data.userRebateDevelopSaleAmt = userRebateDevelopSaleAmt;
        	data.mStoreIncome = mStoreIncome;
        	data.combinationPromotionId = combinationPromotionId;
        	
        	// 2016.9.1 By caobr 预生成的优惠码
        	//data.preGenerate = preGenerate;
        	
        	if(flagSub) {
        		flagSub = false;
	        	submitForm("${ctx}/m/account/order/save",data);
        	}
        });
        
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
        
        //开关操作
        function switchDisable(ev) {
        	var isActive =  ev.find(".mui-active");
        	var isDisabled =  ev.find(".mui-disabled");
        	if(isDisabled.length == 1) { return; }
        	var surplusTotal = nowTotal();//剩余的总额
        	var init = parseFloat(ev.find('.in_it').val());
        	//开
        	if(isActive.length != 0) {
        		var endTotal = parseFloat((surplusTotal-init).toFixed(2));//剩余的总额-目前要使用的抵扣金额
        		if(endTotal <= 0) {
        			ev.find('.nowValue').val(surplusTotal);//目前使用的抵扣金额，大于剩余总额，就把剩余的总额存放到nowValue中
        			$('.deduction').find('.mui-switch-mini').each(function() {//把所有为开的抵扣方式禁用掉，并清除nowValue中的数据
        				if(!$(this).hasClass('mui-active')) {
        					$(this).addClass('mui-disabled');
        					$(this).parent().parent().find('.nowValue').val('');
        				}
        			});
        		} else {
        			ev.find('.nowValue').val(init);
        		}
        	//	$('.fbbwrap-total .main-info').find('em').html(endTotal);// 修改合计
        	} else {//关
        		ev.find('.nowValue').val('');
        		var total = parseFloat($('#hideCoutal').val());//获取使用优惠券后要支付的总金额
        		$('.deduction').find('.mui-active').each(function() {
        			var initValue = parseFloat($(this).parent().parent().find('.in_it').val());
        			var surplusMoney = total - initValue;//剩余总额
        			if(surplusMoney >= 0) {
        			  total = surplusMoney;
        				$(this).parent().parent().find('.nowValue').val(initValue);
        			} else {
        				$(this).parent().parent().find('.nowValue').val(total);
        				$('.deduction').find('.mui-switch-mini').each(function() {
        				if(!$(this).hasClass('mui-active')) {
        					$(this).addClass('mui-disabled');
        					$(this).parent().parent().find('.nowValue').val('');
        				}
        			});
       	    	}
        			
        		});
        		if(nowTotal() > 0) {
        			$('.deduction').find('.mui-disabled').each(function() {
        				$(this).removeClass('mui-disabled');
    				});
        		}
        	}
        	if(nowTotal() > 0) {
				$('#payMethod').parent().show();//显示支付方式
    		} else {
    			$('#payWay').val(-1);
    			$('#payMethod').parent().hide();//隐藏支付方式
    		}
    		//提交订单按钮样式
    		submitOrderButton(nowTotal());
        }
        //提交开关 积分，红包，购酒卷
       function switchOpen(){
            var hideCoutal = $('#hideCoutal').val();  //隐藏域的选择优惠券后的值
            var totalScoreValue = $('#totalScoreValue').val()?$('#totalScoreValue').val() : '';//积分
        	var userBalance = $('#userBalance').val()?$('#userBalance').val() : ''//红包
        	var redPacketBalance = $('#redPacketBalance').val()?$('#redPacketBalance').val() : '';//购酒券
        	var userRebateDevelopSaleAmt = $('#userRebateDevelopSaleAmt').val()?$('#userRebateDevelopSaleAmt').val() : '';//分销收入
        	var mStoreIncome = $('#mStoreIncome').val()?$('#mStoreIncome').val() : '';//微店收入
        	var couTotal = $('.fbbwrap-total .main-info').find('em').html(); //使用优惠券或活动后的值
        	
        	/* 2016.9.12 By caobr */
        	var isPreGenerateCode = $("#preGenerateCode").val();
        	if(isPreGenerateCode){
        		//预生成优惠码优惠金额
        		var preGenerateCodeDiscount = $("#useCouponValue").val();
        		hideCoutal -= preGenerateCodeDiscount;
        	}
        	/* 2016.9.12 By caobr */
        	
        	var data = {};
        	data.hideCoutal = hideCoutal;
        	data.totalScoreValue = totalScoreValue;
        	data.userBalance = userBalance;
        	data.redPacketBalance = redPacketBalance;
        	data.userRebateDevelopSaleAmt = userRebateDevelopSaleAmt;
        	data.mStoreIncome = mStoreIncome;
        	data.couTotal = couTotal;
        	
        	$.ajax({
            	url  : '${ctx}/m/account/order/chooseDikou',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				if(result) {
    				$('.fbbwrap-total .main-info').find('em').html(result.couTotal);// 修改合计
    				}
    			},
    			error:function(XMLHttpResponse ){
    				console.log("请求未成功");
    			}
            });
       
        
       } 
        
        
        //根据商品、地址和支付方式，改变提交订单按钮的样式。
        function submitOrderButton(nowTotal) {
        	var addId = $('#addressId').val();
        	var payWay = $('#payWay').val();
        	var prdList = $('.prd-list').find('.info');//获取订单中的商品列表
        	var isQuotaNum =  $("#isQuotaNum").val();//获取所选订单活动中的商品是否满足该活动中的商品限购数,该值存在就说明不满足
        	
        	//如果没有商品（或者该订单中的商品不满足所选的订单活动的商品限购数），那么提交订单按钮就禁用掉
        	if(prdList.length == 0 || isQuotaNum) {
        		$('#submitOrder').removeClass('button-wrap-active').addClass('button-wrap-disabled');
        		return false;
        	}
        	
        	if(addId) {
        		if (nowTotal <= 0) {
        			$('#submitOrder').removeClass('button-wrap-disabled').addClass('button-wrap-active');
        		} else if(payWay != -1 && payWay ) {
        			$('#submitOrder').removeClass('button-wrap-disabled').addClass('button-wrap-active');
        		} else {
        			$('#submitOrder').removeClass('button-wrap-active').addClass('button-wrap-disabled');
        		}
        	} else {
        		$('#submitOrder').removeClass('button-wrap-active').addClass('button-wrap-disabled');
        	}
        }
        
        //获取使用抵扣券后的剩余金额
        function nowTotal() {
        	//var total = parseFloat($('.fbbwrap-total .main-info').find('em').html());//获取要支付的总金额
        	var total = parseFloat($("#hideCoutal").val());
        	$('.deduction').find('.mui-active').each(function() {
        		var nowValue = $(this).parent().parent().find('.nowValue').val();//获取选择抵扣方式后的抵扣金额
        		nowValue = nowValue?parseFloat(nowValue) : 0 ;
        		total -= nowValue;
        	});
        	
        	var isPreGenerateCode = $("#preGenerateCode").val();
        	if(isPreGenerateCode){
        		//预生成优惠码优惠金额
        		var preGenerateCodeDiscount = $("#useCouponValue").val();
        		total -= preGenerateCodeDiscount;
        	}
        	
        	return parseFloat(total.toFixed(2));
        }
        
		//显示列表
        function showSpecAS(){
            specASMask.show().animate({opacity:1},{
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
        }

		//隐藏列表
        function hideSpecAS(callback){
            specAS.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    specAS.hide();
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
        
        //留言操作
        $('#remark').change(function() {
        	var remark = $(this).val();
        	setCookie('remark',remark);
        });
        
        
        //跳转到选择地址列表
        $('#address').on('click',function() {
        	window.location.href = "${ctx}/m/account/address/chooseAddressList?addressType=1";
        })
        
        //跳转到选择发票列表
        $('#invoice').click(function() {
        	window.location.href = "${ctx}/m/account/invoice/chooseInvoiceList";
        });
        
    })
    //添加属性样式
     function changeClass(){
	    $('.borderbox .totalScoreValue .r .mui-switch').addClass('mui-active');
	    $('.borderbox .totalScoreValue .mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(16px, 0px);');
	}  
	
	//加载支付方式，如果之前有选择字符方式，那么就使用在方式
	function loadPayWay() {
		var payWay = getCookie('payWay');
		if(payWay != -1 || payWay != '') {
			$('#J_ASSpec2').find('input[value="' + payWay + '"]').attr('checked',true);
			var payName = $('#J_ASSpec2').find('input[value="' + payWay + '"]').parent().find('.c').text();
            $('#payWay').val(payWay);
            $('#payMethod').find('.r').html(payName);
		}
	}
   
    //设置Cookie
    function setCookie(name, value) 
	{	     
	    document.cookie=name+'='+encodeURIComponent(value) + ';path=/'; 
	}
	
	//获取cookie
	function getCookie(name)
	{
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
