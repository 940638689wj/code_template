<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-bar">
            <ul class="bui-tab nav-tabs">
                <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">成本核算总公式</span></li>
            </ul>
        </div>
    </div>
    <div class="content-top">
        <div class="title-text">计算公式输入</div>
        <div class="mb25">
            <div class="tips-wrap tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i
                    class="icon icon-white icon-volume-up"></i></span>
                <div class="tips-content">说明：建议填写可以抵用的订单优惠或红包或优惠券的最大值</div>
            </div>
        </div>
        <form class="form-horizontal search-form mb0" method="get">
            <div class="content-body">
                <div class="row mb10">
                    <div class="control-group pull-left span11">
                        <label class="control-label"><s>*</s>商品销售价：</label>
                        <div class="controls control-row-auto">
                            <input class="control-text" id="defaultPrice"/>元
                        </div>
                    </div>

                    <div class="pull-left">
                        销售折扣：
                        <label>
                            <input type="radio" name="discount" value="1" checked="checked" id="amount">
                            <input class="input-small control-text" name="" value="" id="discountPrice"/> 元
                        </label>
                        <label class="ml">
                            <input type="radio" name="discount" id="percent" value="0">
                            <input class="input-small control-text" name="" value="" id="discountPercent"/> %
                        </label>
                    </div>
                </div>
                <div class="row mb10">
                    <div class="control-group pull-left span11">
                        <label class="control-label">商品成本价：</label>
                        <div class="controls control-row-auto">
                            <input type="text" class="control-text" id="tagPrice"/>元
                        </div>
                    </div>

                    <div class="pull-left">
                        订单优惠/抵用红包/优惠券：
                        <input type="text" class="control-text" id="coupon"/>元
                    </div>
                </div>
                <div class="row mb10" style="display: none" id="calculation">
                    <div class="control-group ml">
                        <label class="control-label">利润:</label>
                        <div class="controls control-row-auto">

                            <span id="profit"></span>
                        </div>
                    </div>
                </div>
                <div class="row form-actions actions-bar">
                    <div class="span13">
                        <button onclick="calculate();" type="button" class="button button-primary">计算</button>
                        <button type="reset" class="button">重置</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    function calculate() {
        var defaultPrice = $("#defaultPrice").val();
        var discountPrice = $("#discountPrice").val();
        if (document.getElementById("percent").checked) {
            var discountPercent = $("#discountPercent").val();
            discountPrice = (defaultPrice * discountPercent / 100).toFixed(2);
        }
        var tagPrice = $("#tagPrice").val();
        var coupon = $("#coupon").val();

        var profit = (defaultPrice - discountPrice - tagPrice - coupon).toFixed(2);

        var discountPriceStr = "";
        var tagPriceStr = "";
        var couponStr = "";
        if (defaultPrice != null) {

            if (discountPrice != 0) {
                discountPriceStr = "-" + discountPrice;
            }
            if (tagPrice != 0) {
                tagPriceStr = "-" + tagPrice;
            }
            if (coupon != 0) {
                couponStr = "-" + coupon;
            }
        }

        $("#profit").html('<font color=\"red\">' + profit + '</font>' + "=" + defaultPrice + discountPriceStr + tagPriceStr + couponStr + "（利润&nbsp;=&nbsp;商品销售价&nbsp;-&nbsp;销售折扣&nbsp;-&nbsp;商品成本价&nbsp;-&nbsp;订单优惠/抵用红包/优惠券）");

        $("#calculation").show();
    }

</script>
</body>
</html>