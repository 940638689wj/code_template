<#assign ctx = request.contextPath>


<div id="main">
    <div class="reg-form">
        <div class="pageinfo">
            <div class="infotitle">
                <s class="ico ico-success"></s>订单已提交，请您耐心等待发货。
            </div>
        </div>

        <div class="infobtnbar">
            <a class="btn-action" href="${ctx}/index.html">继续购物</a>
            <a class="btn-action pushCoupon" style="display: none;" href="javascript:;">可领取优惠券</a>
            <a class="btn-action" href="${ctx}/account/order/toDetail?orderId=${orderId!}">查看订单详情</a>
        </div>
    </div>
</div>
<script>
    $(function () {
        var flag = true;
        if (!flag) { return; }
        var data = {};
        data.pushTypeCd = 3;
        $.ajax({
            url: '${ctx}/account/order/pushCoupon',
            async: true,
            type: 'POST',
            dataType: 'json',
            data: data,
            beforeSend: function () {
                flag = false;
            },
            success: function (result) {
                flag = true;
                if(result.result == 'success' && result.codeStr) {
                    $('.pushCoupon').show();
                    $('.pushCoupon').attr('href','/coupon/'+result.codeStr)
                }
            },
            error: function (XMLHttpResponse) {
                flag = true;
                console.log('请求未成功');
            }
        });
    })
</script>