<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>支付订单</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
    <script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
	            <h1 class="mui-title">支付订单</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="borderbox infolist">
                <p>订单抵扣总金额(元)</p>
                <#assign discountTotal = 0>
                <#assign discountText = "">
                <#if totalScoreValue?? && totalScoreValue?has_content>
                	<#assign discountTotal = discountTotal + totalScoreValue>
                	<#assign discountText = discountText +"积分">
                </#if>
                <#if userBalance?? && userBalance?has_content>
                	<#assign discountTotal = discountTotal + userBalance>
                	<#assign discountText = discountText +"购酒券">
                </#if>
                <#if redPacketBalance?? && redPacketBalance?has_content>
                	<#assign discountTotal = discountTotal + redPacketBalance>
                	<#assign discountText = discountText +"红包">
                </#if>
                <#if userRebateDevelopSaleAmt?? && userRebateDevelopSaleAmt?has_content>
                	<#assign discountTotal = discountTotal + userRebateDevelopSaleAmt>
                	<#assign discountText = discountText +"分销收入">
                </#if>
                <#if mStoreIncome?? && mStoreIncome?has_content>
                	<#assign discountTotal = discountTotal + mStoreIncome>
                	<#assign discountText = discountText +"微店收入">
                </#if>
                <h3>${discountTotal}</h3>
            </div>
            <div class="orderinfo">
                <P>您选择了${discountText}支付，为保障用户资金安全，<br>
                    请输入支付密码进行验证！
                </P>
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
            <div class="mui-content-padded">
                <button type="button" class="mui-btn mui-btn-primary mui-btn-block mb20 mui-disabled" id="conPay">确认支付</button>
                <P class="forger">忘记支付密码？<a href="${ctx}/m/account/toForgetPaw">快速找回</a></P>
            </div>
        </div>
       
    </div>
	<input type="hidden" id="addressId" value="${addressId!}">
	<input type="hidden" id="invoiceId" value="${invoiceId!}">
	<input type="hidden" id="invoiceAddressId" value="${invoiceAddressId!}">
	<input type="hidden" id="payMode" value="${payMode!}">
	<input type="hidden" id="payWay" value="${payWay!}">
	<input type="hidden" id="payAmt" value="${payAmt!}">
	<input type="hidden" id="couponCodeId" value="${couponCodeId!}">
	<input type="hidden" id="couponDiscountId" value="${couponDiscountId!}">
	<input type="hidden" id="remark" value="${remark!}">
	<input type="hidden" id="totalScoreValue" value="${totalScoreValue!}">
	<input type="hidden" id="userBalance" value="${userBalance!}">
	<input type="hidden" id="redPacketBalance" value="${redPacketBalance!}">
	<input type="hidden" id="promotionId" value="${promotionId!}">
	<input type="hidden" id="promotionRuleId" value="${promotionRuleId!}">
	<input type="hidden" id="conditionId" value="${conditionId!}">
	<input type="hidden" id="userRebateDevelopSaleAmt" value="${userRebateDevelopSaleAmt!}">
	<input type="hidden" id="mStoreIncome" value="${mStoreIncome!}">
	<input type="hidden" id="combinationPromotionId" value="${combinationPromotionId!}">
<script>
    $(function(){
    	var flag = true;
        var $input = $(".fake-box input");
        var pwd = "";
        $("#pwd-input").on("input", function() {
            pwd = $(this).val().trim();
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
                $('#conPay').removeClass("mui-disabled");
            }
        });
        
        //支付
        $('#conPay').click(function() {
        	var btnDisabled = $(this).is('.mui-disabled');
        	if(btnDisabled) {
        		return;
        	}
        	
			if(flag) {
				flag = false;//防止多次提交
				$.ajax({
	        		url  : '${ctx}/m/account/order/testPayPwd',
	            	async : true,
	            	type : "POST",
	    			dataType : "json",
	    			data : {"payPassword":pwd},
	    			success : function(result) {
	    				flag = true;
	    				if(result.result == 'success') {
	    					mui.toast('支付完成！！');
	    					saveOrder();
	    				} else {
	    					mui.toast(result.message);
	    				}
	    			},
	    			error:function(XMLHttpResponse ){
	    				flag = true;
	    				console.log("请求未成功");
	    			}
	        	});
			}
        });
        //提交订单
        function saveOrder() {
	        var data = {};
	    	data.addressId = $('#addressId').val();//地址
	    	data.invoiceId = $('#invoiceId').val();//发票
	    	data.invoiceAddressId = $('#invoiceAddressId').val();//发票地址
	    	data.couponDiscountId = $('#couponDiscountId').val();//优惠券折扣规则Id
	    	data.couponCodeId = $('#couponCodeId').val();//优惠券使用Id
	    	data.payMode = $('#payMode').val();//支付类型（目前默认线上支付值为1）
	    	data.payWay = $('#payWay').val();//支付方式
	    	data.payAmt = $('#payAmt').val();//订单实际支付总额
	    	data.remark = $('#remark').val();//用户备注
	    	data.totalScoreValue = $('#totalScoreValue').val();//积分
	    	data.userBalance = $('#userBalance').val();//红包
	    	data.redPacketBalance = $('#redPacketBalance').val();//购酒券
	    	data.promotionId = $('#promotionId').val();//活动Id
	    	data.promotionRuleId = $('#promotionRuleId').val();//活动规则Id
	    	data.conditionId = $('#conditionId').val();//活动条件Id
	    	data.userRebateDevelopSaleAmt = $('#userRebateDevelopSaleAmt').val();//分销收入抵扣
	    	data.mStoreIncome = $('#mStoreIncome').val();//微店收入抵扣
	    	data.combinationPromotionId = $('#combinationPromotionId').val();//组合销售活动Id
	    	
	    	submitForm("${ctx}/m/account/order/payment",data)
        }
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
        
    })
</script>
</body>
</html>