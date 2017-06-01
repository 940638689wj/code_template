<#assign ctx = request.contextPath>
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
                <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">审核开关</span></li>
            </ul>
        </div>
    </div>
    <form name="auditForm" id="auditForm" action="${ctx}/admin/sa/auditSetting/editAudit" method="POST">
        <div class="content-body">
            <h3 class="label-title">
                <span>票券审核</span>
            </h3>
            <p>
                <label>
                    <input type="checkbox" name="couponAudit" value="1"
                           <#if couponAudit??&&couponAudit='1'>checked="checked"</#if>/>&nbsp;
                    优惠券审核
                </label>
            </p>
            <p>
                <label>
                    <input type="checkbox" name="grouponAudit" value="1"
                           <#if grouponAudit??&&grouponAudit='1'>checked="checked"</#if>/>&nbsp;
                    团购审核
                </label>
            </p>
            <p>
                <label>
                    <input type="checkbox" name="pickupCouponAudit" value="1"
                           <#if pickupCouponAudit??&&pickupCouponAudit='1'>checked="checked"</#if>/>&nbsp;
                    提货券审核
                </label>
            </p>

            <h3 class="label-title">
                <span>订单审核</span>
            </h3>
            <p>
                <label>
                    <input type="checkbox" name="orderPriceAudit" value="1"
                           <#if orderPriceAudit??&&orderPriceAudit='1'>checked="checked"</#if>>&nbsp;
                    订单价格变动审核
                </label>
            </p>
            <p>
                <label>
                    <input type="checkbox" name="reserveOrderPriceAudit" value="1"
                           <#if reserveOrderPriceAudit??&&reserveOrderPriceAudit='1'>checked="checked"</#if>/>&nbsp;
                    预售订单价格变动审核
                </label>
            </p>
            <p>
                <label for="orderPriceAudit">
                    <input type="checkbox" name="returnAudit" value="1"
                           <#if returnAudit??&&returnAudit='1'>checked="checked"</#if>/>&nbsp;
                    退款审核
                </label>
            </p>

            <h3 class="label-title">
                <span>商品审核</span>
            </h3>
            <p>
                <label>
                    <input type="checkbox" name="productPriceAudit" value="1"
                           <#if productPriceAudit??&&productPriceAudit='1'>checked="checked"</#if>/>&nbsp;
                    商品价格审核
                </label>
            </p>
            <p>
                <label>
                    <input type="checkbox" name="productPutawayAudit" value="1"
                           <#if productPutawayAudit??&&productPutawayAudit='1'>checked="checked"</#if>/>&nbsp;
                    商品上架审核
                </label>
            </p>


            <h3 class="label-title">
                <span>会员审核</span>
            </h3>
            <p>
                <label>
                    <input type="checkbox" name="rechargeAudit" value="1"
                           <#if rechargeAudit??&&rechargeAudit='1'>checked="checked"</#if>/>&nbsp;
                    会员金额审核
                </label>
            </p>
            <p>
                <label>
                    <input type="checkbox" name="scoreAudit" value="1"
                           <#if scoreAudit??&&scoreAudit='1'>checked="checked"</#if>/>&nbsp;
                    会员积分审核
                </label>
            </p>
            <#--<p>
                <label>
                    <input type="checkbox" name="distributorAudit" value="1"
                           <#if distributorAudit??&&distributorAudit='1'>checked="checked"</#if>/>&nbsp;
                    分销会员审核
                </label>
            </p>-->

            <#--<h3 class="label-title">
                <span>对账单结算审核</span>
            </h3>
            <p>
                <label>
                    <input type="checkbox" name="statementBalanceAudit" value="1"
                           <#if statementBalanceAudit??&&statementBalanceAudit='1'>checked="checked"</#if>/>&nbsp;
                    对账单结算审核
                </label>
            </p>-->

            <div class="row form-actions actions-bar">
                <div class="span13">
                    <button type="submit" id="save" class="button button-primary">保存</button>
                    <button type="reset" class="button">重置</button>
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    $(function () {
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#auditForm',
            submitType: 'ajax',
            dataType: 'json',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                }
                setTimeout("remainTime()", 1200);
            }
        }).render();

        form.on('beforesubmit', function () {
            $("#save").attr('disabled', true);
        });
    });

    function remainTime() {
        $("#save").attr('disabled', false);
    }

</script>
</body>
</html>