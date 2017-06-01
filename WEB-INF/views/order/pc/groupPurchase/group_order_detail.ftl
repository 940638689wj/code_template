<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>团购订单</title>
</head>
<body class="page-login">
<div class="center-layout">
<#include "../../../user/pc/include/menu.ftl"/>
    <div class="center-content">
        <div class="content-titel"><a href="/account/groupPurchaseOrder/list" class="flr">返回团购订单列表&gt;</a>
            <h3>订单中心<span><em>_</em>团购订单详情</span></h3></div>
        <div class="grouporder-state">
            当前状态：
                <#if (groupOrder.orderPropertyCd == 0)>
                    <#if (groupOrder.orderPayStatusCd == 1)>
                        <span>待付款</span>
                        <a class="btn-action" href="javascript:void(0);" id="payBtn">付款</a>
                        <a class="btn-action" href="javascript:void(0);" id="cancelBtn">取消订单</a>
                    <#else>
                        <#if (groupOrder.extraInfo.countCanUseCode > 0)>
                            <#if groupOrder.allowUseEndTime?datetime gt .now?datetime>
                                <span>可使用</span>
                            <#else>
                                <span>已过期</span>
                            </#if>
                        <#else>
                            <#if (groupOrder.orderReviewStatusCd == 1)>
                                <span>待评价</span>
                                <a class="btn-action" href="/account/order/review?orderId=${groupOrder.orderId!}">评价</a>
                            <#else>
                                <span>已完成</span>
                            </#if>
                        </#if>
                    </#if>
                <#else>
                    <span>已取消</span><a class="btn-action" href="javascript:void(0);" id="deleteBtn">删除订单</a>
                </#if>
        </div>
        <p class="title">订单信息</p>
        <div class="grouporder-info">
            <ul>
                <li><span>订单号：</span>
                    <p>${groupOrder.orderNumber!}</p></li>
                <li><span>下单时间：</span>
                    <p>${groupOrder.createTime?string('yyyy-MM-dd HH:mm:ss')}</p></li>
                <li><span>付款方式：</span>
                    <p>${groupOrder.payWay!}</p></li>
                <li><span>付款时间：</span>
                    <p>${(groupOrder.orderPayTime?string('yyyy-MM-dd HH:mm:ss'))!}</p></li>
                <li><span>买家留言：</span>
                    <p>${groupOrder.orderRemark!}</p></li>
            </ul>
        </div>
        <table class="orderdatatb">
            <thead>
            <tr>
            <tr>
                <th class="tal">团购信息</th>
                <th>单价</th>
                <th>数量</th>
                <th>小计</th>
            </tr>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="td-product">
                    <div class="first-column">
                        <div class="img"><a href="#"><img src="${groupOrder.picUrl!}"></a></div>
                        <div class="info">
                            <div class="name"><a href="/groupPurchase/detail/${groupOrder.promotionId!}"
                                                 target="_blank">${groupOrder.promotionName!}</a></div>
                            <div class="prop"><span>${groupOrder.groupCouponDesc!}</span></div>
                        </div>
                    </div>
                </td>
                <td>￥${(groupOrder.grouponPrice?string("#0.00"))!}</td>
                <td>${groupOrder.quantity!}</td>
                <td class="text-red">￥${(groupOrder.orderTotalAmt?string("#0.00"))!}</td>
            </tr>
            <tr>
               <td colspan="4" class="tar">
                <#if groupOrder.couponDesc??>
                    （优惠：<#list groupOrder.couponDesc as coupon>${coupon}&nbsp;</#list>）
                </#if>
                    <#--<span class="td-ml">总金额：<i class="text-red">¥${((groupOrder.orderTotalAmt-groupOrder.orderDiscountAmt)?string("#0.00"))!}</i></span><br>-->
                    <#--<span class="td-ml">优惠金额：<i class="text-red">¥${((groupOrder.orderDiscountAmt)?string("#0.00"))!}</i></span>-->
                    <ul>
                        <li>
                            <span class="label">商品总额：</span>
                            <span class="txt">&nbsp;¥${((groupOrder.orderTotalAmt-groupOrder.orderDiscountAmt)?string("#0.00"))!}</span>
                        </li>
                        <li>
                            <span class="label">余额支付：</span>
                            <span class="txt">-¥${((groupOrder.orderTotalAmt-groupOrder.orderPayAmt)?string("#0.00"))!}</span>
                        </li>
                        <li>
                            <span class="label">优惠金额：</span>
                            <span class="txt">-¥${((groupOrder.orderDiscountAmt)?string("#0.00"))!}</span>
                        </li>
                        <li class="text-red">
                            <span class="label">实付总额：</span>
                            <span class="txt count">¥${((groupOrder.orderPayAmt)?string("#0.00"))!}</span>
                        </li>
                    </ul>
                </td>
            </tr>
            </tbody>
        </table>

        <#if groupOrder.extraInfo.promotionCouponCodeList??>
            <#list groupOrder.extraInfo.promotionCouponCodeList as code><p class="title">团购券：${code.Coupon_Code} <#if (code.Coupon_Status_Cd == 2)><em>(已使用)</em></#if></p></#list>
        </#if>
    </div>
</div>


<div id="payment" class="hidden">
    <div class="paytypes">
        <ul>
            <li><a href="#" id="balancePay">余额支付</a></li>
            <li><a href="#" id="alipay">支付宝支付</a></li>
        <#--<li><a href="#">银联支付</a></li>-->
        </ul>
    </div>
</div>

<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>
<script>
    var orderId = ${groupOrder.orderId?default(0)}
    $(function(){
        <#--订单支付-->
        $('#payBtn').click(function () {
            $.get('/account/groupPurchaseOrder/jsonRepayData', {orderId: orderId}, function (data) {
                if (new Date(data.enableEndTime) < new Date()) {
                    layer.alert("该团购活动已经结束，无法购买！")
                    return false;
                }
                if (data.realSaleCnt >= data.grouponMaxSaleNum) {
                    layer.alert("库存不足，无法购买！")
                    return false;
                }
                if (data.currentUserNum >= data.grouponPersonQuotaNum) {
                    layer.alert("您购买的次数已经超过限购数，无法购买！")
                    return false;
                }
                data.orderPayAmt > data.extraInfo.userBalance ? $('#balancePay').hide() : $('#balancePay').show();
                payment();
            })
        });

        <#--删除订单-->
        $('#deleteBtn').click(function () {
            layer.confirm('是否确认删除订单？',function () {
                $.get('/account/groupPurchaseOrder/deleteOrder', {orderId: orderId}, function (data) {
                    if (data.result == 'success') {
                        layer.msg('删除成功！');
                        location.href = '/account/groupPurchaseOrder/list';
                    } else {
                        layer.alert(data.message);
                    }
                });
            })
        });

        <#--取消订单-->
        $('#cancelBtn').click(function () {
            layer.prompt({title: '请输入取消原因', formType: 2}, function (text, index) {
                layer.close(index);
                $.get('/account/groupPurchaseOrder/cancelGroupOrder', {orderId: orderId, reason: text}, function (data) {
                    if (data.result == 'success') {
                        layer.msg('取消成功！');
                        location.reload();
                    } else {
                        layer.alert(data.message);
                    }
                });
            });
        });

        $('#balancePay').click(function () {
            layer.closeAll();
            layer.prompt({title: '请输入支付密码', formType: 1}, function(text, index){
                layer.close(index);
                passwordCheck(text)
            });
        });

        $("#alipay").click(function () {
            layer.closeAll();
            toPay("alipay");
        });

    });

    //支付弹框
    function payment() {
        layer.open({
            type: 1,
            title: '选择支付方式',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px'],
            content: $("#payment")
        });
    }

    //处理支付
    function toPay(payWay) {
        $.ajax({
            url: '/account/groupPurchaseOrder/dealRepayOrder',
            type: 'post',
            data: {
                orderId: orderId,
                payWay: payWay
            },
            dataType: 'json',
            success: function (data) {
                if (data.result == 'success') {
                    if (payWay == 'balancePay') {
                        layer.alert('支付成功！', function () {
                            location.reload();
                        });
                    } else {
                        window.location.href = '/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
                    }
                } else {
                    layer.alert(data.message);
                }
            },
            error: function () {
                layer.alert('网络出错，请稍后再试！');
            }
        });
    }

    //校验密码
    function passwordCheck(payPwd){
        var reg = /^\d{6}$/;
        if (reg.test(payPwd)) {
            //SHA1加密
            var payPwd = CryptoJS.SHA1(payPwd).toString();
            //执行其他操作
            $.post('/m/account/groupPurchaseOrder/checkPayPwd', {payPwd: payPwd}, function (data) {
                if (data.result == 'success') {
                    toPay("balancePay");
                } else {
                    layer.msg('支付密码错误！');
                }
            })
        } else {
            layer.close(payPassword);
            layer.msg('密码错误！');
        }
    }

</script>
</body>
</html>