<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>团购订单详情</title>
</head>
<body>
<div id="app">
    <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/groupPurchaseOrder/list"></a>
            <h1 class="mui-title">团购详情</h1>
            <a class="mui-icon"></a>
        </header>
        <div class="mui-content">
            <div class="borderbox">
                <ul class="prd-list b-bottom">
                    <li>
                        <div class="pic">
                            <img src="${groupOrder.picUrl!}">
                        </div>
                        <div class="r">
                            <p class="name">${groupOrder.promotionName!}</p>
                            <p class="info"><span class="num"><i class="small">X</i>${groupOrder.quantity!}</span><span
                                    class="specifications"></span></p>
                            <div class="price">
                                <div class="price-real">¥${(groupOrder.orderTotalAmt?string("#0.00"))!}</div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="borderbox">
            <#if groupOrder.extraInfo.promotionCouponCodeList??  && groupOrder.extraInfo.promotionCouponCodeList?size gt 0>
                <div class="tbviewlist categorylist">
                    <ul>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">有效期：${groupOrder.allowUseEndTime?string('yyyy-MM-dd HH:mm:ss')}</div>
                                <div class="c">团购券</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </#if>
                <div class="redeemlist">
                    <ul>
                    <#if groupOrder.extraInfo.promotionCouponCodeList??>
                        <#list groupOrder.extraInfo.promotionCouponCodeList as code>
                            <li>
                                <div class="r"><a class="code" href="#middlePopover_${(code.couponCodeId)!}"></a>
                                </div>
                                <div class="c">${(code.Coupon_Code)!}&nbsp;&nbsp;
                                    <span>
                                        <#if code.Coupon_Status_Cd==1>未使用
                                        <#else>已使用
                                        </#if></span>
                                </div>
                            </li>
                        </#list>
                    </#if>
                    </ul>
                </div>
            </div>

            <div class="payment-info">
                <p><span class="fl gray">订单号</span><span class="fr">${(groupOrder.orderNumber)!}</span></p>
                <p><span class="fl gray">原价</span><span
                        class="fr">¥${(groupOrder.orderTotalAmt?string("#0.00"))!}</span></p>
                <p><span class="fl gray">优惠券</span><span
                        class="fr">-¥${(groupOrder.orderDiscountAmt?string("#0.00"))!}</span></p>
                <p><span class="fl gray">实付款</span><span class="fr orange">¥${((groupOrder.orderTotalAmt-groupOrder.orderDiscountAmt)?string("#0.00"))!}</span></p>
                <p><span class="fr orange">(含余额支付¥${((groupOrder.orderTotalAmt-groupOrder.orderPayAmt-groupOrder.orderDiscountAmt)?string("#0.00"))!})</span></p>

            </div>

            <div class="payment-info">
                <p><span class="fl gray">下单时间</span><span
                        class="fr">${groupOrder.createTime?string('yyyy-MM-dd HH:mm:ss')}</span></p>
                <p><span class="fl gray">付款时间</span><span
                        class="fr">${(groupOrder.orderPayTime?string('yyyy-MM-dd HH:mm:ss'))!}</span></p>
            </div>

            <div class="fbbwrap fbbwrap-total">
                <div class="ftbtnbar">
                    <div class="content-wrap"></div>
                    <div class="button-wrap bkno">
                    <#--<#if type?has_content && type == 6>
                        <a class="orderdetailbtn" href="javascript:void(0)">已取消</a>
                    <#else>
                        <a class="orderdetailbtn" id="return">退款</a>
                    </#if>-->

                    <#if (groupOrder.orderPropertyCd == 0)>
                        <#if (groupOrder.orderPayStatusCd == 1)>
                        <#--<span>待付款</span>-->
                            <a class="orderdetailbtn" href="javascript:void(0);" @click="rePay()"
                               id="payBtn">付款</a>
                            <a class="orderdetailbtn" href="javascript:void(0);" @click="cancelOrder()" id="cancelBtn">取消订单</a>
                        <#else>
                            <#if (groupOrder.extraInfo.countCanUseCode > 0)>
                                <#if (groupOrder.extraInfo.countCanUseCode == groupOrder.quantity)>
                                    <#if groupOrder.allowUseEndTime?datetime gt .now?datetime>
                                    <#--<span>可使用</span>-->
                                        <a class="orderdetailbtn" href="javascript:" @click="refundOrder()">退款</a>
                                    <#else>
                                    <#--<span>已过期</span>-->
                                    </#if>
                                <#else>
                                    <a class="orderdetailbtn" href="javascript:"
                                       @click="toComment()">评价</a>
                                </#if>
                            <#else>
                                <#if (groupOrder.orderReviewStatusCd == 1)>
                                <#--<span>待评价</span>-->
                                    <a class="orderdetailbtn" href="javascript:"
                                       @click="toComment()">评价</a>
                                <#else>
                                <#--<span>已完成</span>-->
                                </#if>
                            </#if>
                        </#if>
                    <#else>
                    <#--<span>已取消</span>--><a class="orderdetailbtn" href="javascript:void(0);"
                                              @click="deleteOrder()">删除订单</a>
                    </#if>
                    </div>
                </div>
            </div>
        </div>
    </div>


<#if groupOrder.extraInfo.promotionCouponCodeList??>
    <#list groupOrder.extraInfo.promotionCouponCodeList as code>
        <div id="middlePopover_${code.couponCodeId!}" class="mui-popover codeshowbox">
            <div class="mui-popover-arrow"></div>
            <div class="codeshow"><img src="${ctx}/qrCode/generate?content=${code.Coupon_Code?default(0)}"></div>
        </div>
    </#list>
</#if>
    <div id="J_ASSpec" class="actionsheet-spec">
        <!--微信支付-->
        <div class="payment-method" v-show='isBalancePay?false:true'>
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择支付方式</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">

                        <li v-for="(value,key) in bussinessConfigTypeList">
                            <a href="javascript:void(0)" onclick="toPay('alipay')"
                               v-if="key == 'config_alipay_mobile'">支付宝支付</a>
                            <a href="javascript:void(0)" onclick="toPay('unionpay')"
                               v-if="key == 'config_unionpay_mobile'">银联支付</a>
                            <a href="javascript:void(0)" onclick="toPay('wechatpay')"
                               v-if="key == 'weixin_pay_config'">微信支付</a>
                            <a href="javascript:void(0)" @click="isBalancePay = true"
                               v-if="key == 'userBalnce'">余额支付</a>
                        </li>

                        <#--
                        <li v-show='isWxBrowser'>
                            <a href="javascript:void(0)" onclick="toPay('wechatpay')">微信支付</a>
                        </li>
                        <li id="balancePay">
                            <a href="javascript:void(0)" @click="isBalancePay = true">余额支付</a>
                        </li>
                        <li v-show='isWxBrowser?false:true'>
                            <a href="javascript:void(0)" onclick="toPay('alipay')">支付宝</a>
                        </li>
                        -->
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button cancelBtn">取消</a>
                    </div>
                </div>
            </div>
        </div>

        <!--余额支付-->
        <div class="ye-payment" v-show='isBalancePay'>
            <div class="prod-info">
                <div class="title">支付订单金额<span class="orange">￥{{balancePayAmt.toFixed(2)}}</span>元</div>
            </div>
            <div class="paymentwrap">
                <div class="orderinfo">
                    <p v-show="hasPayPwd">当前余额￥{{userBalance.toFixed(2)}}</p>
                    <P>请{{hasPayPwd?'输入':'设置'}}支付密码</P>
                </div>
                <div class="pwd-box">
                    <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
                    <div class="fake-box" v-show='hasPayPwd'>
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                    </div>
                </div>
                <div class="orderinfo" v-show='hasPayPwd?false:true'>
                    <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="javaScript:setPayPwd()" class="textcolor">设置支付密码</a>！</p>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button" onclick="checkPayPwd()">确定</a>
                        <a href="javascript:void(0)" class="button cancel">取消</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="show-abnormal-bg" id="returnDlg1"></div>
    <div class="mui-abnormal" id="returnDlg2">
        <div class="ordercancel">
            <div class="info">
                <h3>请选择退款原因：</h3>
                <div class="selectbox">
                    <select v-model="applyReasonCd">
                    <#list orderReturnReasonList as orderReturnReason>
                        <li>
                            <option value="${orderReturnReason.codeId}">
                            ${orderReturnReason.codeCnName}
                            </option>
                        </li>
                    </#list>
                    </select>
                </div>
                <h3>退款备注：</h3>
                <textarea v-model="reasonDetailDesc"></textarea>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" @click="subRefund">提交</a>
                <a href="javascript:void(0);" id="change">取消</a>
            </div>
        </div>
    </div>

</div>
</div>
<script type="text/javascript" src="${ctx}/static/mobile/js/sha1.js"></script>

<script>
    var app = new Vue({
        el: '#app',
        data: {
            bussinessConfigTypeList: {},
            hasPayPwd: false,
            isBalancePay: false,
            balancePayAmt: 0,
            userBalance: 0,
            currentOrderId:${groupOrder.orderId?default(0)},
            reasonDetailDesc: '',
            applyReasonCd: 0,
            isWxBrowser: 0
        },
        computed: {
            isWxBrowser: function () {
                var ua = navigator.userAgent.toLowerCase();
                return ua.match(/MicroMessenger/i) == "micromessenger"
            }
        },
        methods: {
            rePay: function () {

                $.get('/account/groupPurchaseOrder/jsonRepayData', {orderId: this.currentOrderId}, function (data) {
                    if (new Date(data.data.enableEndTime) < new Date()) {
                        mui.alert("该团购活动已经结束，无法购买！")
                        return false;
                    }
                    if (data.data.realSaleCnt >= data.data.grouponMaxSaleNum) {
                        mui.alert("库存不足，无法购买！")
                        return false;
                    }
                    if (data.data.currentUserNum >= data.data.grouponPersonQuotaNum) {
                        mui.alert("您购买的次数已经超过限购数，无法购买！")
                        return false;
                    }
                    app.balancePayAmt = data.data.orderPayAmt;
                    app.bussinessConfigTypeList = data.bussinessConfigTypeList;
                    app.userBalance = data.data.extraInfo.userBalance;
                    if(data.data.extraInfo.payPassword != null && data.data.extraInfo.payPassword != '') app.hasPayPwd = true;
                    paymentshow();
                })
            },
            cancelOrder: function () {
                mui.prompt('', '请输入原因', '请输入取消原因', ['取消', '确认'], function (e) {
                    if (e.index == 1) {
                        $.get('/account/groupPurchaseOrder/cancelGroupOrder', {
                            orderId: app.currentOrderId,
                            reason: e.value
                        }, function (data) {
                            if (data.result == 'success') {
                                mui.toast('取消成功！');
                                location.reload();
                            } else {
                                mui.alert(data.message);
                            }
                        });
                    }
                })
            },
            deleteOrder: function () {
                mui.confirm('是否确认删除订单？', function (index) {
                    if (index == 1) {
                        $.get('/account/groupPurchaseOrder/deleteOrder', {orderId: this.currentOrderId}, function (data) {
                            if (data.result == 'success') {
                                mui.toast('删除成功！');
                                location.reload();
                            } else {
                                mui.alert(data.message);
                            }
                        });
                    }
                })
            },
            refundOrder: function () {
                this.reasonDetailDesc = '';
                this.applyReasonCd = 0;
                $("#returnDlg1").addClass("mui-active");
                $("#returnDlg2").addClass("mui-popup-in");
                document.ontouchmove = function () {
                    return false;
                }
            },
            toComment: function () {
                var url = '/spa/#/m/account/order/review/' + this.currentOrderId + '?successUrl=' + encodeURIComponent(window.location.href);
                location.href = url;
            },
            subRefund: function () {
                if (this.applyReasonCd == 0) {
                    mui.toast('请选择退款原因！');
                    return false;
                }
                closeDlg();
                $.ajax({
                    url: '/m/account/groupPurchaseOrder/dealRefundOrder',
                    data: {
                        orderId: this.currentOrderId,
                        applyReasonCd: this.applyReasonCd,
                        remark: this.reasonDetailDesc
                    },
                    type: 'post',
                    dataType: 'json',
                    success: function (data) {
                        if (data.result == 'success') {
                            mui.toast(data.data);
                            location.reload();
                        } else {
                            mui.toast(data.message);
                        }
                    },
                    error: function () {
                        mui.alert('网络错误，请稍候重试！');
                    }
                });
            }
        }
    });

    function mkqrcode(text) {
        $('.codeshow').qrcode({width: 100, height: 100, text: text})
//        $('.codeshow').html(text);
    }

    //初始化方法
    $(function () {
        $("#change").on("click", function () {
            closeDlg();
        })
    });

    var closeDlg = function () {
        $(".show-abnormal-bg").removeClass("mui-active");
        $(".mui-abnormal").removeClass("mui-popup-in");
        document.ontouchmove = null;
    }


    //跳转到设置支付密码页面
    function setPayPwd() {
        var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=' + encodeURIComponent(window.location.href);
        window.location.href = _url;
    }
    <#----------------------------------------------支付处理---------------------------------------------------->
    //    $(function(){
    var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
            }).appendTo(document.body),
            specAS = $("#J_ASSpec");

    specAS.find(".close").on("click", function () {
        paymenthide();
    });

    $(".cancelBtn,.cancel").on("click", function () {
        paymenthide();
    });

    function paymentshow() {
        clearPwd();
        paymentMask.show().animate({opacity: 1}, {
            duration: 80,
            complete: function () {
                specAS.css({
                    top: "100%",
                    opacity: 0,
                    display: "block"
                }).animate({
                    opacity: 1,
                    translateY: "-" + specAS.height() + "px"
                }, {
                    duration: 200,
                    easing: "ease-in-out"
                });
            }
        });
        $(document).bind("touchmove", function (e) {
            e.preventDefault();
        });
        $('.actionsheet-spec .spec-list')[0].addEventListener('touchmove', function (e) {
            e.stopPropagation();
        }, false);
    }

    function paymenthide(callback) {
        app.isBalancePay = false;
        specAS.animate({
            opacity: 0,
            translateY: 0
        }, {
            duration: 200,
            easing: "ease-in-out",
            complete: function () {
                specAS.hide();
                paymentMask.animate({opacity: 0}, {
                    duration: 80,
                    complete: function () {
                        paymentMask.hide();
                        if (typeof callback == "function") callback.call();
                    }
                });
            }
        });
        $(document).unbind("touchmove");
    }

    var $input = $(".fake-box input");
    $("#pwd-input").on("input", function () {
        var pwd = $(this).val().trim();
        for (var i = 0, len = pwd.length; i < len; i++) {
            $input.eq("" + i + "").val(pwd[i]);
        }
        $input.each(function () {
            var index = $(this).index();
            if (index >= len) {
                $(this).val("");
            }
        });
        if (len == 6) {
            checkPayPwd();
        }
    });
    //    })

    function checkPayPwd() {
        var pwd = $("#pwd-input").val().trim();
        if (!/^\d{6}$/.test(pwd)) {
            mui.toast('支付密码错误！');
            clearPwd();
            return false
        }
        //SHA1加密
        var payPwd = CryptoJS.SHA1(pwd).toString();

        //执行其他操作
        $.post('${ctx}/m/account/groupPurchaseOrder/checkPayPwd', {payPwd: payPwd}, function (data) {
            if (data.result == 'success') {
                toPay('balancePay');
            } else {
                mui.toast('支付密码错误！');
                clearPwd();
            }
        })
    }

    //处理支付
    function toPay(payWay) {
        $.ajax({
            url: '/account/groupPurchaseOrder/dealRepayOrder',
            type: 'post',
            data: {
                orderId: app.currentOrderId,
                payWay: payWay
            },
            dataType: 'json',
            success: function (data) {
                if (data.result == 'success') {
                    if (payWay == 'balancePay') {
                        mui.toast('支付成功！');
                        location.reload();
                    } else {
                        window.location.href = '/m/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
                    }
                } else {
                    mui.alert(data.message);
                }
            },
            error: function () {
                mui.alert('网络出错，请稍后再试！');
            }
        });
    }

    function clearPwd() {
        $("#pwd-input").val('');
        $('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
    }

</script>
</body>
</html>