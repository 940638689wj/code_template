<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign canLoginByAlipay = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByAliPayMobile()>
<#assign canLoginByQQ = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByQQ()>
<#assign canLoginByWeibo = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeibo()>
<#assign canLoginByWeiXin = Static["cn.yr.chile.common.helper.BusinessConfigHelper"].canLoginByWeiXin()>
<!doctype html>
<html lang="en">
<head>
    <title>确认订单</title>
</head>
<body>
    <div id="page">
    	<#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
	            <h1 class="mui-title">确认订单</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="borderbox">
                <div class="bindnumber">您还未进行绑定，请绑定手机号</div>
                <div class="loginform verification-code confirm-login">
                    <ul>
	                    <li class="input-wrap">
	                        <div class="bd">
	                            <input id="loginName" type="text" placeholder="手机号码" name="loginName" value="">
	                        </div>
	                        <span class="delete"></span>
	                    </li>
	                    <li>
	                        <div class="bd"> <input id="verifyCode" type="text" placeholder="验证码" name="verifyCode" value=""></div>
	                        <div class="hd"><img src="${ctx}/randomCaptcha" id="randomImage" style="height:30px;cursor: pointer;"/></div>
	                    </li>
	                    <li>
	                        <div class="bd">
	                            <input id="telephoneVerifyCode" type="text" placeholder="动态密码" name="telephoneVerifyCode" value="">
	                        </div>
	                        <div class="hd"><a href="javascript:void(0);" id="getTelephoneVerifyCode" class="btn-action">获取动态密码</a></div>
	                    </li>
	                    <li><button class="mui-btn mui-btn-block mui-btn-primary" id="doLogin">登录</button></li>
	                </ul>
                </div>
            </div>
            <div class="order-address addr-item addr-item-empty">
                <a href="#">
                <address>您的收货信息为空，点此添加收货地址</address>
                </a>
            </div>
            <div class="borderbox">
                <ul class="prd-list order-prd-list sure-prd-list">
                    <li>
                        <div class="hd">
                            <span class="c">${storeValue!?html}</span>
                        </div>

						<#if cartDtoList?? && cartDtoList?has_content>
							<#list cartDtoList as cartDto>
								<#if cartDto.promotionTypeCd?? && cartDto.promotionTypeCd?has_content>
                            		<#if cartDto.promotionTypeCd == 1>
                            			<#assign discountTypeValue="满折" discountTypeClass="keepfolding">
                            		<#elseif cartDto.promotionTypeCd == 2>
                            			<#assign discountTypeValue="满减" discountTypeClass="fullreduction">
                            		<#elseif cartDto.promotionTypeCd == 3>
                            			<#assign discountTypeValue="满赠" discountTypeClass="hidegift">
                            		<#elseif cartDto.promotionTypeCd == 5>
                            			<#assign discountTypeValue="包邮" discountTypeClass="hidegift">
                            		<#elseif cartDto.promotionTypeCd == 4>
                            			<#assign discountSpan = "<span>限时特价</span>">
                            		<#elseif cartDto.promotionTypeCd == 51>
                            			<#assign discountSpan = "<span>秒杀</span>">
                            		<#elseif cartDto.promotionTypeCd == 52>
                            			<#assign discountSpan = "<span>组合销售</span>">
                            		<#elseif cartDto.promotionTypeCd == 53>
                            			<#assign discountSpan = "<span>团购</span>">
                            		</#if>
                        		</#if>
								<div class="info">
		                            <div class="itemsinfo">
		                            <a href="#">
		                                <div class="pic"><img src="${(cartDto.productPicUrl)!}"></div>
		                                <h3>${discountSpan!}${(cartDto.productName)!}</h3>
		                                <p class="price"><span class="price-real">￥<em>${(cartDto.firstAddedSalePrice)!}</em>/件</span></p>
		                                <p class="spec">数量：${(cartDto.quantity)!}</p>
		                                <#if discountTypeValue??>
	                                		<div class="information">
			                                    <div class="content">
			                                        <span class="${discountTypeClass}">${discountTypeValue}</span>
			                                        <p>${(cartDto.promotionDiscountDesc)!?html}</p>
			                                    </div>
			                                </div>
	                                	</#if>
		                            </a>
		                            </div>
		                        </div>
		                        <#if cartDto.promotionGiftXrefDTOList?? && cartDto.promotionGiftXrefDTOList?has_content>
                                	<#list cartDto.promotionGiftXrefDTOList as promotionGiftXrefDTO>
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
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="#">
                                <div class="r">请选择</div>
                                <div class="c">优惠券</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="#">
                                <div class="r">请选择</div>
                                <div class="c">活动</div>
                            </a>
                        </li>
                    </ul>
                </div>
                <ul class="tbviewlist tbviewlist-order">
                    <li>
                        <div class="hd">买家留言:</div>
                        <div class="bd">
                            <input type="text" placeholder="选填，可填写您的需求">
                        </div>
                    </li>
                </ul>
                <ul class="prd-list order-prd-list">
                    <li>
                        <div class="ft">
                            共${totalNum!}件商品，合计：<span>￥${totalMoney!}</span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="javascript:void(0);">
                                <div class="r">
                                    <div class="mui-switch mui-switch-mini ">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </div>
                                <div class="c">积分抵扣<span>可用0积分抵扣¥0</span></div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="javascript:void(0);">
                                <div class="r">
                                    <div class="mui-switch mui-switch-mini ">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </div>
                                <div class="c">红包抵扣<span>可抵扣¥0</span></div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="javascript:void(0);">
                                <div class="r">
                                    <div class="mui-switch mui-switch-mini ">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </div>
                                <div class="c">购酒券抵扣<span>可抵扣¥0</span></div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="#">
                                <div class="r">不需要</div>
                                <div class="c">发票</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="#">
                                <div class="r"></div>
                                <div class="c">支付方式</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="fbbwrap fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in">
                        <div class="r">
                            <div class="main-info">合计：<span>¥ <em>${totalMoney!}</em></span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap cash-buttons">
                    <a class="button button-wrap-disabled" href="javascript:void(0)"><span>提交订单</span></a>
                </div>
            </div>
        </div>
    </div>
<script>
	var randomUrl = "${ctx}/randomCaptcha";
    $(function(){
       $('#randomImage').click(function(){
            $("#randomImage").attr("src", randomUrl + (randomUrl.indexOf("?") > -1 ? "&" : "?") + Math.floor(Math.random() * ( 1000 + 1)));
        });

        $("#getTelephoneVerifyCode").click(function(){
            sendSmsMsg();
        });

        $("#doLogin").click(function(){
        	var loginName = $("#loginName").val();
            if (!checkTelephone(loginName)) {
                return;
            }
            
            var verifyCode = $("#verifyCode").val();
            if(!verifyCode || verifyCode == ""){
                mui.toast('请输入验证码!');
                return false;
            }

            var telephoneVerifyCode = $("#telephoneVerifyCode").val();
            if(!telephoneVerifyCode || telephoneVerifyCode == ""){
                mui.toast('请输入动态密码!');
                return false;
            }

            var data = {};
            data.verifyCode = verifyCode;
            data.telephoneVerifyCode = telephoneVerifyCode;
            data.telephone = loginName;
            data.successUrl = $("#successUrl").val();
            $.post("${ctx}/m/login/login_post", data, function(resultData){
                console.log(resultData)
                if(resultData && resultData.result == "true"){
                var productId = getUrlParams['productId'];// 从地址中获取：商品Id
                var quantity = getUrlParams['quantity'];// 从地址中获取：商品数量
                var promotionId = getUrlParams['promotionId'];// 从地址中获取：活动Id
                promotionId = promotionId ? promotionId : '';
                var promotionDiscountRuleId = getUrlParams['promotionDiscountRuleId'];// 从地址中获取：活动规则Id
                promotionDiscountRuleId = promotionDiscountRuleId ? promotionDiscountRuleId : '' ;
                var promoCouponCodeId = getUrlParams['promoCouponCodeId'];// 从地址中获取：用户使用的优惠券Id
                promoCouponCodeId = promoCouponCodeId ? promoCouponCodeId : '';
                var conditionId = getUrlParams['conditionId'];// 从地址中获取：条件Id
                conditionId = conditionId ? conditionId : '';
                    if(productId && quantity){
                        window.location.href = "${ctx}/m/cart/buyNow?productId=" + productId + "&quantity=" + quantity+"&promotionId="+promotionId+"&promotionDiscountRuleId="+promotionDiscountRuleId+"&promoCouponCodeId="+promoCouponCodeId+"&conditionId="+conditionId;
                    }else if(promotionId && !promoCouponCodeId && !conditionId) {
                    	window.location.href = "${ctx}/m/promotion/combination/" + promotionId;
                    }else{
                        window.location.href = "${ctx}/m/cart/buyCart";
                    }
                }else{
                    mui.toast(resultData.message || "登录失败,请稍后再试!");
                }
            }, "json");
        });
    });

    function sendSmsMsg(){
        var verifyCode = $("#verifyCode").val();
        if(!verifyCode || verifyCode == ""){
            mui.toast('请输入验证码!');
            return false;
        }

        var loginName = $("#loginName").val();
        if (!checkTelephone(loginName)) {
            return;
        }

        var data = {};
        data.verifyCode = verifyCode;
        data.telephone = loginName;
        $.post("${ctx}/m/login/sendTelephoneVerifyCode", data, function(resultData){
            if(resultData && resultData.result == "true"){
                $("#getTelephoneVerifyCode").unbind();
                var times = 60;
                var timer = setInterval(function () {
                    if (--times <= 0) {
                        $("#getTelephoneVerifyCode").text("获取动态密码");
                        clearInterval(timer);
                        $("#getTelephoneVerifyCode").bind("click", sendSmsMsg);
                        $("#getTelephoneVerifyCode").removeClass().addClass("btn-action");
                    } else {
                        $("#getTelephoneVerifyCode").text(times + "秒后再次获取");
                    }
                }, 1000);
                window.onunload = function () {
                    clearInterval(timer);
                };
            }else{
                mui.toast(resultData.message || "获取动态密码失败,请稍后再试!");
                $('#randomImage').trigger("click");
            }
        }, "json");
    }

    // 校验手机号码格式
    function checkTelephone(telephone) {
        var mobileReg = new RegExp("^(1[0-9]{10})$");
        if (!telephone) {
            mui.toast('请填写手机号!');
            return false;
        }
        if (!mobileReg.test(telephone)) {
            mui.toast('手机号格式不正确!');
            return false;
        }
        return true;
    }
</script>
</body>
</html>