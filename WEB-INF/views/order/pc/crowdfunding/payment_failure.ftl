<#assign ctx = request.contextPath>

<div id="main">
    <div class="reg-form">
        <div class="pageinfo">
            <div class="infotitle">
                <s class="ico ico-error"></s>支付失败！
            </div>
            <div class="infocontent">
            ${paymentError!}
            </div>
        </div>

        <div class="infobtnbar">
            <a class="btn-action" href="${ctx}/index.html">继续购物</a>
            <a class="btn-action" href="${ctx}/account/crowdfundingOrder/detail?orderId=${orderId!}">查看订单</a>
        </div>
    </div>
</div>