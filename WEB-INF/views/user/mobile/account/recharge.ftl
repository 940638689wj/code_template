<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>充值</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">充值</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <div class="balance-top">
            <h3>当前余额：${userBalance!}元</h3>
            <input type="text" placeholder="请输入充值金额" id="rechargeAmt">
        </div>
        <div class="borderbox">
            <h3 class="title">选择支付方式</h3>
            <div class="tbviewlist">
                <ul>
                <#if businessConfigTypeList?? && businessConfigTypeList?has_content>
                    <#list businessConfigTypeList?keys as key>
                        <#assign payName="" />
                        <#assign payWay="4" />
                        <#assign payClass="payico-alipay" />
                        <#if key="config_alipay_mobile">
                            <#assign payName="支付宝支付" />
                            <#assign payWay="2" />
                            <#assign payClass="payico-alipay" />
                     <#--  
                     		<#elseif key="config_unionpay_mobile">
                            <#assign payName="银联支付" />
                            <#assign payWay="4" />
                            <#assign payClass="payico-unionpay" />
                      --> 
                        <#elseif key="weixin_pay_config">
                            <#assign payName="微信支付" />
                            <#assign payWay="1" />
                            <#assign payClass="payico-wechat" />
                        </#if>

                        <li>
                            <a class="itemlink" href="javascript:submitRecharge(${payWay})">
                                <div class="c"><i class="payico ${payClass}"></i>${payName}</div>
                            </a>
                        </li>
                    </#list>
                </#if>

                </ul>
            </div>
        </div>
    </div>
	 <p class="loginForget"><span class="fr"><a class="orange" href="${ctx}/m/account/userBalanceDetail">余额收支明细</a></span></p>
</div>
<script>
    function submitRecharge(payWay) {
        var rechargeAmt = $("#rechargeAmt").val();
        if (!rechargeAmt) {
            mui.toast("请输入充值金额！");
            return false;
        }
        $.post("${ctx}/m/account/userRechargeDetail/submitRecharge", {
            payWay: payWay,
            rechargeAmt: rechargeAmt
        }, function (data) {
            if (data.result == "true") {
                window.location.href = "${ctx}/m/account/recharge/goToPayment.html?localSerialNum=" + data.localSerialNum + "&payWay=" + payWay;
            } else{
                mui.toast("充值失败，请稍后再试！");
            }
        }, "json");
    }
</script>
</body>
</html>