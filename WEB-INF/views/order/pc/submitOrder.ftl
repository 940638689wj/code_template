<#assign ctx = request.contextPath>
<#include "../../user/pc/include/addrSelect.ftl"/>
<div id="main">
    <div class="checkout">
        <div class="checkout-tit">填写并核对订单信息</div>
        <div class="checkout-steps">
            <div class="step-tit">
                <h3>收货人信息</h3>
                <span class="extra-r flr"><a href="javascript:void(0);" class="link" id="newaddressBtn">新增地址</a></span>
            </div>
            <div class="step-addr-wrap">
                <div class="step-addr">
                    <ul>
                    	<#if userReceiveAddressDTOList?? && userReceiveAddressDTOList?has_content>
                    		<#list userReceiveAddressDTOList as address>
                    			<#assign addressFullName = address.getAddressFullName()>
                    			<li>
		                            <div class="addr-item <#if address.isDefaultAddr == 1>item-selected</#if>" data-addrId="${(address.addrId)!}">${(address.receiverName)!}
		                                <b></b>
		                            </div>
		                            <div class="addr-detail">
		                                <span class="addr-name">${(address.receiverName)!}</span>
		                                <span class="addr-info">${addressFullName!}</span>
		                                <span class="addr-tel">${(address.receiverTel)!}</span>
		                                <#if address.isDefaultAddr == 1><span class="addr-default">默认地址</span></#if>
		                            </div>
		                            <div class="op-btns">
		                                <a href="javascript:void(0);" class="addrIsDefault" data-addrid="${(address.addrId)!}">设为默认地址</a>
		                                <a href="javascript:void(0);" class="addrEdit" data-addrid="${(address.addrId)!}">编辑</a>
		                                <a href="javascript:void(0);" class="addrDel" data-addrid="${(address.addrId)!}">删除</a>
		                            </div>
		                        </li>
                    		</#list>
                    	</#if>
                    </ul>
                </div>
                <div class="addr-switch">
                    <span>更多地址</span><b></b>
                </div>
            </div>
            
            <input type="hidden" id="cityId" value="${cityId!}">
        	<input type="hidden" id="totalWeight" value="${totalWeight!}">
        	<input type="hidden" id="isPayPassword" value="${isPayPassword?default(0)}">
        	
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>商品信息</h3>
                    <span class="extra-r flr"><a href="/cart/list" class="link">返回修改购物车</a></span>
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
                    
                	<#if productList?? && productList?has_content>
                    <div class="shoptb-row">
                        <table>
                            <tbody>
		                    <#list productList as product>
                            <tr>
                                <td class="td-product">
                                    <div class="first-column">
                                        <div class="img"><a href="${ctx}/product/${(product.masterProductId)!}"><img src="${(product.productPicUrl)!}"></a></div>
                                        <div class="info">
                                            <div class="name"><a href="${ctx}/product/${(product.masterProductId)!}" target="_blank">${(product.productName)!}</a></div>
                                            <div class="prop"><span>${(product.skuValue)!}</span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="td-price">¥${(product.firstAddedSalePrice)!}</td>
                                <td class="td-amount">${(product.quantity)!}</td>
                                <td class="td-promote"></td>
                                <td class="td-total"><em>¥${(product.subtotal)!} </em></td>
                            </tr>
		                    </#list>
                            </tbody>
                        </table>
                    </div>
                    </#if>
                </div>
            </div>
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>配送信息</h3>
                </div>
                <div class="formList">
                    <div class="item">
                        <div class="hd">选择快递</div>
                        <div class="bd">
                            <select id="selectExpress">
                            	<#if expressList?? && expressList?has_content>
                            		<#list expressList as express>
                            			<option <#if express_index == 0>selected</#if> value="${(express.expressId)!}">${(express.expressName)!}&nbsp;&nbsp;</option>
                            		</#list>
                            	</#if>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>优惠信息</h3>
                </div>
                <input type="hidden" id="promotionisExpressAmt" value="${promotionisExpressAmt!}">
				<input type="hidden" id="couponExpressAmt" value="${couponExpressAmt!}">
				<input type="hidden" id="usePromotionValue" value="${usePromotionValue!}" >
				<input type="hidden" id="couponDiscountId" value="${couponDiscountId!}" >
				<input type="hidden" id="couponCodeId" value="${couponCodeId!}" >
				<input type="hidden" id="discountTotalAmt" value="${discountTotalAmt?default(0)}" >
                <div class="order-ft">
                    <div class="order-extra">
                        <div class="formList order-extra">
                            <#--<div class="item">
                                <div class="hd">订单优惠</div>
                                <div class="bd">满500减30
                                </div>
                            </div>-->
                            <div class="item">
                                <div class="hd">使用活动</div>
                                <div class="bd">
                                    <select id="choosePromotion">
                                    	<option value="-1,-1">请选择活动</option>
                                        <#if userCanPromotionDTOList?? && userCanPromotionDTOList?has_content>
				                            <#list userCanPromotionDTOList as userCanPromotionDTO>
				                                <option value="${(userCanPromotionDTO.promotionId)!},${(userCanPromotionDTO.id)!}" <#if promotionId?has_content && promotionId == userCanPromotionDTO.promotionId?string>selected</#if>>${(userCanPromotionDTO.discountDesc)!}</option>
				                                </#list>
				                        </#if>
                                    </select>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">使用优惠券</div>
                                <div class="bd">
                                    <select id="choosePromotionCard">
                                        <option selected="" value="-1,-1">请选择优惠券</option>
                                        <#if userCanUseCouponDTOList?? && userCanUseCouponDTOList?has_content>
				                            <#list userCanUseCouponDTOList as userCanUseCouponDTO>
				                                <option value="${(userCanUseCouponDTO.couponCodeId)!},${(userCanUseCouponDTO.id)!}" <#if couponDiscountId?has_content && couponDiscountId == userCanUseCouponDTO.id?string>selected</#if>>${(userCanUseCouponDTO.discountDesc)!}</option>
		                                	</#list>
				                        </#if> 
                                    </select>
                                    <#--<p style="margin-top: 5px;">
                                        <input type="text" class="textfield">&nbsp;&nbsp;
                                        <a href="javascript:void(0)" class="v-btn">使用</a>
                                    </p>-->
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">使用红包</div>
                                <input type="hidden" id="redPacketCodeId" value="${redPacketCodeId!}" >
				                <input type="hidden" id="useRedPacketValue" value="${useRedPacketValue!}" >
				                <input type="hidden" id="useRedPacketRealityValue" value="${useRedPacketRealityValue!}" >
                                <div class="bd">
                                    <select id="chooseRedPacket">
                                    	<option value="-1">请选择红包</option>
                                        <#if userRedPacketList?? && userRedPacketList?has_content>
			                                <#list userRedPacketList as userRedPacket>
			                                	<option value="${(userRedPacket.couponCodeId)!}" <#if redPacketCodeId?has_content && redPacketCodeId == userRedPacket.couponCodeId?string>selected</#if>>${(userRedPacket.couponCodeValue)?default(0)}元</option>
			                                </#list>
		                                </#if>
                                    </select>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">积分抵扣</div>
                                <input type="hidden" id="useTotalScoreValue" value="" >
                         		<input type="hidden" id="scoreDiscountTotalValue" value="${scoreDiscountTotalValue?default(0)}" >
                                <div class="bd">
                                    <input id="integral" type="checkbox" name="integral">
                                    <span class="infotext">可用${totalScore?default(0)}积分抵扣¥${totalScoreValue?default(0)}(本次最多可抵扣¥${scoreDiscountTotalValue?default(0)})</span>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">订单备注</div>
                                <div class="bd">
                                	<input type="text" name="rk" disabled style="display:none">
                                    <input type="text" name="rk"  id="remark" class="textfield">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="order-total">
                        <div class="row">
                            <div class="tit">商品总价：</div>
                            <div class="con" id="productTotal">¥${productTotal?default(0)}</div>
                        </div>
                        <div class="row">
                            <div class="tit">促销折扣：</div>
                            <div class="con">-¥<span id="promotionValue">${usePromotionValue?default(0)}</span></div>
                        </div>
                        <div class="row">
                            <div class="tit">优惠券抵扣：</div>
                            <div class="con">-¥<span id="promotionCardValue">${discountValue?default(0)}</span></div>
                        </div>
                        <div class="row">
                            <div class="tit">红包抵扣：</div>
                            <div class="con">-¥<span id="redPacketValue">${useRedPacketValue?default(0)}</span></div>
                        </div>
                        <div class="row">
                            <div class="tit">快递费用：</div>
                            <input type="hidden" id="isExpressAmt" value="<#if isExpressAmt>true<#else>false</#if>"/>
                        	<input type="hidden" id="totalExpressAmt" value="${(totalExpressAmt)?default(0)}"/>
                            <div class="con">¥<span id="totalExpressAmtShow">${(totalExpressAmt)?default(0)}</span></div>
                        </div>
                        <div class="row">
                        <div class="tit">应付总额：</div>
                        <div class="con">
                            ¥<span id="needPay1">${needPay?default(0)}</span>
                        </div>
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
                <span class="price-num">¥<em id="needPay2">${needPay?default(0)}</em></span>
            </div>
            <#--
            <div class="fc-price-info">
                <span class="mr20">寄送至： 福建 厦门市 思明区   软件园2期观日路24号之二102</span>
                <span>收货人：杨毅强 139****7475</span>
            </div>-->
        </div>
        <div class="inner">
            <button id="btnBuy">提交订单</button>
        </div>
    </div>
</div>

<div id="payment" class="hidden">
    <div class="paytypes">
        <ul>
            <#if businessConfigTypeList?? && businessConfigTypeList?has_content>
                <#list businessConfigTypeList?keys as key>
                    <#assign payName="" />
                    <#assign payWay="4" />
                    <#if key="config_alipay_pc">
                        <#assign payName="支付宝支付" />
                        <#assign payWay="2" />
                    <#elseif key="config_unionpay_mobile">
                        <#assign payName="银联支付" />
                        <#assign payWay="4" />
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
<div id="payPassword"  class="hidden">
    <div class="formList paypassword">
    	<div id="inPayPas">
	        <div class="item">
	            <div class="hd">输入支付密码：</div>
	            <div class="bd">
	                <input type="password" id="password" class="textfield">
	            </div>
	        </div>
	        <div class="item">
	            <div class="hd"></div>
	            <div class="bd">
	                <a class="v-btn payBtn" href="#">确定</a>
	            </div>
	        </div>
    	</div>
        <div id="updPayPas">
            <p style="margin: 20px;text-align:center">您还未设置支付密码，为保障账户资金安全<br>请先
                <a href="javascript:;" class="red setPwd">设置支付密码</a>！
            </p>
        </div>
    </div>
</div>

<div id="setPayPassword"  class="hidden">
    <div class="formList paypassword">
        <div class="item">
            <div class="hd">手机号：</div>
            <div class="bd">
            	<#if phone?? && phone?has_content>
            		${phone!}
            		<input type="text" id="phone" placeholder="请输入手机号" class="textfield" value="${phone!}" style="display:none">
            	<#else>
	                <input type="text" id="phone" placeholder="请输入手机号" class="textfield">
            	</#if>
            </div>
        </div>
        <div class="item">
            <div class="hd">手机验证码：</div>
            <div class="bd">
                <input id="phoneVerifyCode" type="text" placeholder="请输入验证码" class="textfield dx-textfield" style="width:90px;">
                <a class="btn-action" href="javascript:void(0);" id="getTelephoneVerifyCode" style="padding:0 10px;height:39px;line-height:39px;vertical-align: middle;">获取短信验证码</a>
            </div>
        </div>
        <div class="item">
            <div class="hd">支付密码：</div>
            <div class="bd">
                <input type="password" id="payPwd" placeholder="请输入验支付密码" class="textfield">
            </div>
        </div>
        <div class="item">
            <div class="hd"></div>
            <div class="bd">
                <a class="v-btn" href="javascript:;" id="pPwdSub">确定</a>
            </div>
        </div>
    </div>
</div>

<div id="newddress" class="hidden">
    <div class="reg-form">
        <ul>
            <li>
                <div class="hd">姓名</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="receiverName"></div>
                </div>
            </li>
            <li>
                <div class="hd">所在地区</div>
                <div class="bd">
                    <select id="receiverProvinceId"></select>
                    <select id="receiverCityId"><option value="">选择城市</option></select>
                    <select id="receiverCountyId"><option value="">选择县/区</option></select>
                </div>
            </li>
            <li>
                <div class="hd">街道</div>
                <div class="bd">
                    <textarea id="receiverAddr"></textarea>
                </div>
            </li>
            <li>
                <div class="hd">手机号码</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="receiverTel"></div>
                </div>
            </li>
            <li>
                <div class="bd">
                    <a href="javascript:void(0);" class="btn-action" id="addrSub">新增</a>
                    <input type="hidden" id="hideAddrId">
                    <input type="hidden" id="hideIsDefaultAddr" value="0">
                </div>
            </li>
        </ul>
    </div>
</div>

<script src="${ctx}/static/js/jquery.placeholder.min.js"></script>
<script>
    var flagSub = true;//防止表单多次提交
    var balancePay = false;//余额支付时候成功的标志，默认为false
    function submitOrder(payWay){
        var remark = $('#remark').val();//用户备注
        var totalScoreValue = $('#useTotalScoreValue').val();
        if(!totalScoreValue){
            totalScoreValue = 0;
        }

        var payAmt = parseFloat($('#needPay2').html().trim());
        var isPayPassword = $('#isPayPassword').val();
        var couponCodeId = $('#couponCodeId').val();//用户优惠券Id
        var couponDiscountId = $('#couponDiscountId').val();//优惠券折扣Id
        var redPacketCodeId = $('#redPacketCodeId').val();
        var value = $('#choosePromotion').val().split(",");
        var promotionDiscountId = value[1];
        var promotionId = value[0];
        var addrId = $('.addr-item').filter('.item-selected').data('addrid');
        var expressId = $('#selectExpress').val();

        <#--如果是余额支付(余额支付不成功)，且有设置支付密码，不执行下方操作，在弹出密码框中操作-->
        if(!balancePay && payWay == 5) {
        	if(isPayPassword == 0) {
        		$("#inPayPas").css("display", "none");
                $("#updPayPas").css("display", "block");
        	} else {
        		$("#inPayPas").css("display", "block");
                $("#updPayPas").css("display", "none");
        	}
            paypassword();
            return;
        }

        var data = {};
        data.remark = remark;
        data.payWay = payWay;
        data.payAmt = payAmt;
        data.originPlatformCd = '0';
        data.totalScoreValue = totalScoreValue;
        data.couponCodeId = couponCodeId;
        data.couponDiscountId = couponDiscountId;
        data.promotionId = promotionId;
        data.promotionDiscountId = promotionDiscountId;
        data.redPacketCodeId =redPacketCodeId;
        data.addrId = addrId;
        data.expressId = expressId;

        if(flagSub) {
            flagSub = false;
            submitForm("${ctx}/account/order/save",data);
        }
    }

    $(function(){
    	<#--清空备注，防止浏览器记录信息填充进来-->
    	$('#remark').val('');
		<#--鼠标进入与离开样式的变化-->
        $(".step-addr").on("mouseenter","li",function () {
            $(this).addClass("step-addr-selected");
        }).on("mouseleave","li",function () {
            $(this).removeClass("step-addr-selected");
        })
		
		<#--点击选择地址-->
        $(".step-addr").on("click",".addr-item",function(){
            var obj = $(this);
            $(".step-addr .addr-item").removeClass("item-selected");
            obj.addClass("item-selected");
        })
		
		<#--地址的展开和收起-->
        var propsbox = $(".step-addr"),openheight,
            closeheight = propsbox.find("li").eq(0).outerHeight(true);
        propsbox.height(closeheight).addClass("toggled");
        $(".addr-switch").on("click",function(){
            if(propsbox.hasClass("toggled")){
                $(".addr-switch").removeClass("switch-on");
                $(".addr-switch").find("span").html("收起地址");
                openheight = propsbox[0].scrollHeight;
                propsbox.animate({
                    height : openheight
                }, function() {
                    propsbox.removeClass("toggled");
                });

            }else{
                $(".addr-switch").addClass("switch-on");
                $(".addr-switch").find("span").html("更多地址");
                propsbox.animate({
                    height : closeheight
                }, function() {
                    propsbox.addClass("toggled");
                });
            }
        });
		
		<#--新增地址-->
        $("#newaddressBtn").on("click",function(){
        	$('#addrSub').html('新增');
        	selectAreaInit();
            newaddress('新增地址');
        })
        
        <#--更新保存地址-->
        $('#addrSub').on('click',function() {
        	if(!flagSub) return;
        	testAddrContent();
        });
        
        var newAddress;
	    function newaddress(str){
	        newAddress = layer.open({
	            type: 1,
	            title: str,
	            skin: 'layui-layer-rim',
	            shade: [0.6],
	            area: ['700px'],
	            content: $("#newddress")
	        });
	    }
        
        function testAddrContent() {
        	var addrId = $('#hideAddrId').val();
        	var receiverName = $('#receiverName').val().trim();
        	var receiverProvinceId = $('#receiverProvinceId').val();
        	var receiverCityId = $('#receiverCityId').val();
        	var receiverCountyId = $('#receiverCountyId').val();
        	var receiverAddr = $('#receiverAddr').val().trim();
        	var receiverTel = $('#receiverTel').val().trim();
        	var isDefaultAddr = $('#hideIsDefaultAddr').val();
        	
        	if(receiverName == '') {
        		layer.msg('收货人姓名不能为空！');
        		return;
        	} 
        	if(receiverName.length > 20) {
        		layer.msg('收货人姓名长度不能超过20！');
        		return;
        	}
        	if(receiverProvinceId == '') {
        		layer.msg('请选择省！');
        		return;
        	}
        	if(receiverCityId == '') {
        		layer.msg('请选择市！');
        		return;
        	}
        	if(receiverAddr == '') {
        		layer.msg('街道地址不能为空');
        		return;
        	}
        	if(receiverTel == '') {
        		layer.msg('收货人手机不能为空！');
        		return;
        	}
        	if(!(/^1[34578]\d{9}$/.test(receiverTel))) {
	            layer.msg("手机号码输入不正确！");
	            return;
	        }
	        
	        var data = {};
	        data.addrId =addrId;
	        data.receiverName = receiverName;
	        data.receiverProvinceId = receiverProvinceId;
	        data.receiverCityId = receiverCityId;
	        data.receiverCountyId = receiverCountyId;
	        data.receiverAddr = receiverAddr;
	        data.receiverTel = receiverTel;
	        data.isDefaultAddr = isDefaultAddr;
	        
	        addrUpdateOrAdd(data);
        }
        
        function addrUpdateOrAdd(data) {
        	flagSub = false;
        	$.ajax({
        		url  : '${ctx}/account/order/addrUpdateOrAdd',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
			        	layer.closeAll();
			        	selectAreaInit();
			        	addressList();
			        	layer.msg(result.message);
					} else {
						alert(result.message);
					}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        <#--地址弹出框的初始化-->
        function selectAreaInit() {
        	//选择省市区的初始化
	        addChangeEven("receiverProvinceId",["receiverCountyId"],["选择县/区"],"receiverCityId","选择城市");
	        addChangeEven("receiverCityId",[],[],"receiverCountyId","选择县/区");
	        findChildByParentId("receiverProvinceId", 0, "选择省");
	        $('#hideAddrId').val('');
	        $('#receiverName').val('');
	        $('#receiverAddr').val('');
	        $('#receiverTel').val('');
        }
	    
        
        <#--设为默认地址-->
        $('.step-addr').on('click','.addrIsDefault',function() {
        	var $this = $(this);
        	if(!flagSub) return;
        	layer.confirm('确定要设置该地址为默认地址吗?', {
                btn: ['确定','取消'] //按钮
            }, function(){
                addrIsDefault($this);
            }, function(){
                layer.closeAll();
            });
        });
        
        function addrIsDefault($this) {
        	flagSub = false;
        	var addrId = $this.data('addrid');
        	$.ajax({
        		url  : '${ctx}/account/order/addrIsDefault',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {'addrId':addrId},
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
			        	$('.step-addr .addr-default').remove();
			        	$this.parent().prev().append('<span class="addr-default">默认地址</span>');
			        	layer.msg('设置成功');
					}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        <#--编辑地址-->
        $('.step-addr').on('click','.addrEdit',function() {
        	var $this = $(this);
        	if(!flagSub) return;
        	addrEdit($this);
        });
        
        function addrEdit($this) {
        	flagSub = false;
        	var addrId = $this.data('addrid');
        	$.ajax({
        		url  : '${ctx}/account/order/addrEdit',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {'addrId':addrId},
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
    					$('#receiverName').val(result.data.receiverName);
    					$('#receiverTel').val(result.data.receiverTel);
    					$('#receiverAddr').val(result.data.receiverAddr);
    					findChildByParentId("receiverProvinceId", 0, "选择省");
				        $("#receiverProvinceId").val(result.data.receiverProvinceId);
			        	findChildByParentId("receiverCityId", result.data.receiverProvinceId, "选择城市");
				        $("#receiverCityId").val(result.data.receiverCityId);
				        findChildByParentId("receiverCountyId", result.data.receiverCityId, "选择县/区");
				        $("#receiverCountyId").val(result.data.receiverCountyId);
				        $('#hideAddrId').val(result.data.addrId);
				        $('#hideIsDefaultAddr').val(result.data.isDefaultAddr);
				        $('#addrSub').html('修改');
				        <#--打开弹出框-->
			        	newaddress('编辑地址');
					}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        <#--删除地址-->
        $('.step-addr').on('click','.addrDel',function() {
        	var $this = $(this);
        	if(!flagSub) return;
        	layer.confirm('确定要删除该地址吗?', {
                btn: ['确定','取消'] //按钮
            }, function(){
                addrDel($this);
            }, function(){
                layer.closeAll();
            });
        });
        
        function addrDel($this) {
        	flagSub = false;
        	var addrId = $this.data('addrid');
        	$.ajax({
        		url  : '${ctx}/account/order/addrDel',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {'addrId':addrId},
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
			        	$this.parents('li').remove();
			        	layer.msg('成功删除');
					}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        function addressList() {
        	flagSub = false;
        	$.ajax({
        		url  : '${ctx}/account/order/addressList',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {},
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
			        	addressListHtml(result.data)
					}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        function addressListHtml(data) {
        	var AddressFullName = '';
        	var countyName = '';
        	var li = '';
        	for(i = 0; i < data.length; i++) {
        		countyName = data[i].countyName ? '' : data[i].countyName;
        		AddressFullName = data[i].provinceName + data[i].cityName + countyName + data[i].receiverAddr;
        		
        		li +='<li>';
        		if(data[i].isDefaultAddr == 1) {
	                li +='    <div class="addr-item item-selected" data-addrId="'+data[i].addrId+'">'+data[i].receiverName;
                } else {
                	li +='    <div class="addr-item" data-addrId="'+data[i].addrId+'">'+data[i].receiverName;
                }
                li +='        <b></b>';
                li +='    </div>';
                li +='    <div class="addr-detail">';
                li +='        <span class="addr-name">'+data[i].receiverName+'</span>';
                li +='        <span class="addr-info">'+AddressFullName+'</span>';
                li +='        <span class="addr-tel">'+data[i].receiverTel+'</span>';
                if(data[i].isDefaultAddr == 1) {
                	li +='    <span class="addr-default">默认地址</span>';
                }
                li +='    </div>';
                li +='    <div class="op-btns">';
                li +='        <a href="javascript:void(0);" class="addrIsDefault" data-addrid="'+data[i].addrId+'">设为默认地址</a>';
                li +='       <a href="javascript:void(0);" class="addrEdit" data-addrid="'+data[i].addrId+'">编辑</a>';
                li +='        <a href="javascript:void(0);" class="addrDel" data-addrid="'+data[i].addrId+'">删除</a>';
                li +='    </div>';
                li +='</li>';
        	}
        	
        	$('.step-addr ul').html(li);
        }
        
        <#--选择快递公司-->
    	$('#selectExpress').on('change',function() {
    		if(!flagSub) { return; }
			var total = ${productTotal?default(0)};//商品总金额
			var cityId = $('#cityId').val();
			var totalWeight = $('#totalWeight').val();
			var expressId = $(this).val();
		    var discountTotalAmt = $('#discountTotalAmt').val();
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
        		url  : '${ctx}/account/order/selectExpress',
            	async : true,
            	type : "POST",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
						$('#totalExpressAmtShow').html(result.totalExpressAmt)
                    	$('#totalExpressAmt').val(result.totalExpressAmt);
    					var isExpressAmt = $('#isExpressAmt').val();
    					if(isExpressAmt != 'true') {//如果没包邮，那么改变邮费的时候就要修改对应的应支付金额
	    					$('#needPay1').html(result.realityPay);
	    					$('#needPay2').html(result.finalPay);
    					}
    					
    					<#--如果是有包邮，那么就改变对应哪个优惠的优惠值-->
    					if($('#promotionisExpressAmt').val() == 'true') {
							$('#promotionValue').html(result.totalExpressAmt);
						}
						if($('#couponExpressAmt').val() == 'true') {
							$('#promotionCardValue').html(result.totalExpressAmt);
						}
    				} else {
    					layer.msg(result.message);
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
    	}

		<#--提交订单-->
        $("#btnBuy").on("click",function(){
	        var addrId = $('.addr-item').filter('.item-selected').data('addrid');
	        if(!addrId) {
	        	layer.msg('请选择收货地址！');
	        	return;
	        }
            payment();
        })

		<#--选择余额支付-->
        $("#balancePayment").on("click",function(){
            paypassword();
        })
        
        <#--点击确认支付，使用余额支付-->
        $("#payPassword .payBtn").on("click",function() {
        	if(!flagSub) {
        		return;
        	} 
        	flagSub = false;
        	$.ajax({
        		url  : '${ctx}/m/account/order/testPayPwd',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"payPassword" : $("input[type='password']").val()},
    			success : function(result) {
    				flagSub = true;
    				if(result.result == 'success') {
    					balancePay = true;
    					submitOrder(5);
    				} else {
    					layer.msg(result.message);
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flagSub = true;
    				console.log("请求未成功");
    			}
        	});
        })
        
        $('#payPassword').on('click','.setPwd',function() {
        	layer.open({
	            type: 1,
	            title: '设置支付密码',
	            skin: 'layui-layer-rim',
	            shade: [0.6],
	            area: ['360px','300px'],
	            content: $("#setPayPassword")
	        });
    	});
    	
    	$('#pPwdSub').on('click',function() {
    		testPayPassword();
    	});
    	
    	$('#getTelephoneVerifyCode').on('click',function() {
    		sendSmsMsg();
    	});
    })
	
	<#--弹出选择支付方式-->
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

	<#--填写支付密码-->
    var payPassword;
    function paypassword(){
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px','200px'],
            content: $("#payPassword")
        });
    }
    
    <#--设置支付密码-->
    var setPayPassword;
    function setPayPassword(){
        setPayPassword = layer.open({
            type: 1,
            title: '设置支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px','300px'],
            content: $("#setPayPassword")
        });
    }

    <#--模拟表单提交-->
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
    
    <#-- 验证设置支付密码-->
    function testPayPassword() {
    	var phone = $('#phone').val();
    	var phoneVerifyCode = $('#phoneVerifyCode').val();
    	var payPwd = $('#payPwd').val();
    	
        if(phoneVerifyCode == '') {
        	layer.msg("手机验证码不能为空！");
    		return;
        }
        if(phone == '') {
    		layer.msg("手机号不能为空！");
    		return;
    	}
    	if(!(/^1[34578]\d{9}$/.test(phone))) {
            layer.msg("手机号输入不正确！");
            return;
        }
        if(payPwd == '') {
        	layer.msg("支付密码不能为空！");
    		return;
        }
        if(!(/\d{6}$/.test(payPwd))) {
            layer.msg("支付密码只能是6为数字！");
            return;
        }
    	var data = {};
    	data.phone = phone;
    	data.phoneVerifyCode = phoneVerifyCode;
    	data.payPassword = payPwd;
    	
    	setPPwd(data);
    }
    
    <#--设置支付密码-->
    function setPPwd(data) {
    	if(!flagSub) {
    		return;
    	}
    	flagSub=false;
    	$.ajax({
        	url  : '${ctx}/account/userSetPPwd/setPPwd',
        	async : true,
        	type : "POST",
			dataType : "json",
			data : data,
			success : function(result) {
				flagSub=true;
				if(result.result == 'success') {
					$('#isPayPassword').val('1');
					layer.closeAll();
					layer.msg(result.message);
				} else {
					layer.msg(result.message);
				}
			},
			error:function(XMLHttpResponse ){
				flagSub=true;
				console.log("请求未成功");
			}
        });
    }
    
    <#-- 抵扣操作 -->
    $('#integral').on('click',function(){
    	var hasChk = $('#integral').is(':checked');
		if(hasChk){
	        var realityPay = parseFloat($('#needPay1').html().trim());//实际支付金额
    		var scoreDiscountTotalValue = parseFloat($('#scoreDiscountTotalValue').val());//本次最多可抵扣的金额
    		if(scoreDiscountTotalValue <= realityPay ) {
    			$('#useTotalScoreValue').val(scoreDiscountTotalValue);
    		} else {
    			$('#useTotalScoreValue').val(realityPay);
    		}
		}else{
		   $('#useTotalScoreValue').val('');
		}
        $('#scoreValue').html($('#useTotalScoreValue').val());
		clickCheckBox();
    });
    
        
    /*选择积分抵扣*/
    function clickCheckBox() {
    	if(!flagSub) {
    		return;
    	}
    	flagSub=false;
    	
    	var realityPay = $('#needPay1').html().trim();//实际支付金额
    	var useTotalScoreValue = $('#useTotalScoreValue').val();//使用积分抵扣金额
    	$.ajax({
        	url  : '${ctx}/account/order/chooseScore',
        	async : true,
        	type : "GET",
			dataType : "json",
			data : {"useTotalScoreValue":useTotalScoreValue,"realityPay":realityPay},
			success : function(result) {
				flagSub=true;
				if(result) {
					$('#needPay2').html(result.realityPay);// 修改最终合计
				}
			},
			error:function(XMLHttpResponse ){
				flagSub=true;
				console.log("请求未成功");
			}
        });
    }
        
   <#-- 活动操作 -->
   $('#choosePromotion').on('change',function(){
       var value = $('#choosePromotion').val().split(",");;
       var promotionDiscountId = value[1];
       var promotionId = value[0];
        
       var totalExpressAmt = $('#totalExpressAmt').val();
       var couponDiscountId = $('#couponDiscountId').val();
       var couponCodeId = $('#couponCodeId').val();
       var total = ${productTotal?default(0)};//商品总金额
       var usePromotionValue = $("#usePromotionValue").val();//获取使用活动后的优惠金额
        
       var data = {};
       data.promotionDiscountId = promotionDiscountId;
       data.promotionId = promotionId;
       data.couponDiscountId = couponDiscountId;
       data.couponCodeId = couponCodeId;
       data.total = total;
       data.usePromotionValue = usePromotionValue;
       data.totalExpressAmt = totalExpressAmt;
        
       if(promotionDiscountId && flagSub) {
       		choosePromotion(data);
       }
    });
    
    /*选择活动操作*/
    function choosePromotion(data) {
    	$('#integral').prop('checked',false);
    	flagSub=false;
    	$.ajax({
        	url  : '${ctx}/account/order/choosePromotion',
        	async : true,
        	type : "GET",
			dataType : "json",
			data : data,
			success : function(result) {
				flagSub=true;
				if(result) {
					$('#needPay1').html(result.total);// 修改合计
					$('#needPay2').html(result.total);// 修改合计
					$('#promotionValue').html(result.promotionValue); //修改活动优惠金额
					
					if(result.promotionisExpressAmt) {
						$('#promotionisExpressAmt').val(result.promotionisExpressAmt);
					}
					
					restoreRedPack();
					$('#discountTotalAmt').val(result.discountTotalAmt);
					$('#promotionId').val(data.promotionId);
					$('#promotionDiscountId').val(data.promotionDiscountId);
					$('#isExpressAmt').val(result.isExpressAmt);
					$('#usePromotionValue').val(result.promotionValue);
				}
			},
			error:function(XMLHttpResponse ){
				flagSub=true;
				console.log("请求未成功");
			}
        });
    } 
    
   <#-- 优惠卷操作 -->
   $('#choosePromotionCard').on('change',function(){
        var value = $('#choosePromotionCard').val().split(",");;
        var couponCodeId = value[0];
        var couponDiscountId = value[1];
        var totalExpressAmt = $('#totalExpressAmt').val();
        var total = ${productTotal?default(0)};//商品总金额
        var usePromotionValue = $("#usePromotionValue").val();//获取使用活动后的优惠金额
        var choosePromotionValue = $('#choosePromotion').val().split(",");;
       	var promotionDiscountId = choosePromotionValue[1];
        var isExpressAmt = $('#isExpressAmt').val();//是否包邮，防止活动中使用，优惠券又使用
        
        var data = {};
        data.couponDiscountId = couponDiscountId;
        data.couponCodeId = couponCodeId;
        data.total = total;
        data.usePromotionValue = usePromotionValue;
        data.totalExpressAmt = totalExpressAmt;
        data.isExpressAmt = isExpressAmt;
        data.promotionDiscountId = promotionDiscountId;
        
        if(couponCodeId && flagSub) {
        	chooseCoupon(data);
        }
      
    });  
    
    /*选择优惠券操作*/
    function chooseCoupon(data) {
    	$('#integral').prop('checked',false);
    	flagSub=false;
    	$.ajax({
        	url  : '${ctx}/account/order/chooseCoupon',
        	async : true,
        	type : "GET",
			dataType : "json",
			data : data,
			success : function(result) {
				flagSub=true;
				if(result) {
					$('#needPay1').html(result.total);// 修改合计
					$('#needPay2').html(result.total);// 修改合计
					$('#promotionCardValue').html(result.discountValue);
					if(result.couponExpressAmt) {
						$('#couponExpressAmt').val(result.couponExpressAmt);
					}
					restoreRedPack();
					$('#discountTotalAmt').val(result.discountTotalAmt);
					$('#couponDiscountId').val(data.couponDiscountId);
        			$('#couponCodeId').val(data.couponCodeId);
        			$('#isExpressAmt').val(result.isExpressAmt);
				}
			},
			error:function(XMLHttpResponse ){
				flagSub=true;
				console.log("请求未成功");
			}
        });
    }
    
   <#-- 红包操作 -->
   $('#chooseRedPacket').on('change',function(){
        var redPacketCodeId = $('#chooseRedPacket').val();
        var totalExpressAmt = $('#totalExpressAmt').val();
        var total = ${productTotal?default(0)};//商品总金额
        var discountTotalAmt = $('#discountTotalAmt').val();
        var isExpressAmt = $('#isExpressAmt').val();
        var useRedPacketRealityValue = $('#useRedPacketRealityValue').val();//获取使用红包的实际金额
        var data = {};
        data.redPacketCodeId = redPacketCodeId;
        data.totalExpressAmt =totalExpressAmt;
        data.total = total;
        data.discountTotalAmt = discountTotalAmt;
        data.isExpressAmt = isExpressAmt;
        data.useRedPacketRealityValue = useRedPacketRealityValue;
        if(redPacketCodeId && flagSub) {
        	chooseRedPacket(data);
        }
    });  
    
    /*选择红包操作*/
    function chooseRedPacket(data) {
        $('#integral').prop('checked',false);
    	flagSub=false;
    	$.ajax({
        	url  : '${ctx}/account/order/chooseRedPacket',
        	async : true,
        	type : "GET",
			dataType : "json",
			data : data,
			success : function(result) {
				flagSub=true;
				if(result) {
					$('#needPay1').html(result.total);// 修改合计
					$('#needPay2').html(result.total);// 修改合计
					$('#redPacketValue').html(result.useRedPacketRealityValue); //修改红包优惠金额
					$('#discountTotalAmt').val(result.discountTotalAmt);
					$('#useRedPacketRealityValue').val(result.useRedPacketRealityValue);//红包实际抵扣的金额
					$('#redPacketCodeId').val(data.redPacketCodeId);
				}
			},
			error:function(XMLHttpResponse ){
				flagSub=true;
				console.log("请求未成功");
			}
        });
    } 
    
    function sendSmsMsg(){
        var phone = $("#phone").val();

        if(phone == '') {
    		layer.msg("手机号不能为空！");
    		return;
    	}
    	if(!(/^1[34578]\d{9}$/.test(phone))) {
            layer.msg("手机号输入不正确！");
            return;
        }

        $.post("/account/userSetPPwd/sendPhoneVerifyCode",{'phone':phone},function() {
	        $("#getTelephoneVerifyCode").unbind();
	        var times = 60;
	        var timer = setInterval(function () {
	            if (--times <= 0) {
	                $("#getTelephoneVerifyCode").text("发送验证码");
	                clearInterval(timer);
	                $("#getTelephoneVerifyCode").bind("click", sendSmsMsg);
	                $("#getTelephoneVerifyCode").removeClass().addClass("btn-action");
	            } else {
	                $("#getTelephoneVerifyCode").text("重新获取" + times + "s");
	            }
	        }, 1000);
	        window.onunload = function () {
	            clearInterval(timer);
	        };
        });
    }

    
    <#--还原红包选项-->
    function restoreRedPack() {
    	var redPacketCodeId = $('#redPacketCodeId').val();
    	if(redPacketCodeId != '' || redPacketCodeId != -1) {
    		$('#chooseRedPacket').find('option[value="-1"]').attr('selected','selected');
    		$('#redPacketValue').html("0");
    		$('#useRedPacketRealityValue').val(0);//红包实际抵扣的金额
    	}
    }
    
</script>