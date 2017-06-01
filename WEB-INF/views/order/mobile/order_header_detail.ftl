<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>订单详情</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/orderHeader?type=${type}"></a>
    <#--<a class="mui-icon mui-icon-left-nav" href="javascript:history.back()"></a>-->
        <h1 class="mui-title">订单详情</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
<div class="mui-content">
    <div class="toptip">
        <!-- <div>提示：请在 15:00 内付款，否则该订单取消！</div> -->
    </div>
    <div class="order-address orderdetail-address">
        <span class="name">${orderReceiveInfo.receiveName!}</span>
        <span class="phone">${orderReceiveInfo.receiveTel!}</span>
        <address>${orderReceiveInfo.receiveAddrCombo!}</address>
    </div>
    <div class="sure-list">
    <#if (goodsList?size>0)>
        <h3><span class="goods"></span>商品清单</h3>
        <ul>
            <#list goodsList as goods>
                <li>
                    <div class="name">
                        <#if type==3><input type="checkbox" name="orderItemId" value="${goods.orderItemId!}"
                                            <#if goods.applyStatus?has_content>disabled="disabled"</#if>></#if>${goods.productName!}
                        <#if goods.applyStatus?has_content>(${goods.applyType!}${goods.applyStatus!})</#if>
                    </div>
                    <div class="num">
                        <span>x</span>${goods.quantity!}</div>
                    <div class="price">￥${goods.productTotal!}</div>
                </li>
            </#list>
        </ul>
    </#if>
        <dl>
            <dt>配送费</dt>
            <dd>￥${orderHeader.orderExpressAmt!}</dd>
        </dl>
        <!-- <P class="info">已使用***优惠</P> -->
    <#assign total = orderHeader.orderProductAmt + orderHeader.orderExpressAmt>
        <dl>
            <dt><span>总计 ￥${total!}</span><span>优惠 ￥${orderHeader.orderDiscountAmt!}</span></dt>
            <dd>
                实付<span>￥<#if orderHeader.orderPayAmt?? && (orderHeader.orderPayAmt >=0)>${orderHeader.orderPayAmt!}<#else>
                0</#if></span></dd>
        </dl>
    </div>

    <div class="borderbox">
        <div class="title">订单信息</div>
        <div class="order-info">
            <ul>
                <li><p>订单号码：</p><span>${orderHeader.orderNumber!}</span></li>
                <li><p>订单时间：</p><span>${orderHeader.createTime?datetime}</span></li>
                <li><p>买家留言：</p><span>${orderHeader.orderRemark!"无"}</span></li>
            </ul>
        </div>
    </div>

<#if type!=5>
    <div class="fbbwrap-total">
        <div class="ftbtnbar">
            <div class="content-wrap">
                <div class="content-wrap-in">
                    <!-- <div class="l orange">待付款</div> -->
                </div>
            </div>
            <div class="button-wrap">
                <#if type==1 || type == 2>
                    <#if type == 1>
                        <a class="button" id="paymentBtn">付款</a>
                    </#if>
                    <a class="button cancel" id="cancelOrder">取消</a>
                <#elseif type ==3>
                    <a class="button cancel" id="return">退款</a>
                    <#--<a href="javascript:confirmReceive();" class="button" id="confirmReceive">确认收货</a>-->
                <#elseif type==4>
                    <#if orderHeader.orderReviewStatusCd==1>
                        <a class="button"
                           href="${ctx}/m/account/orderHeader/toOrderHeaderReview?orderId=${orderHeader.orderId}">
                            去评价</a>
                    </#if>
                </#if>
            </div>
        </div>
    </div>
</div>
</#if>

    <div class="show-abnormal-bg" id="returnDlg1"></div>
    <div class="mui-abnormal" id="returnDlg2">
        <div class="ordercancel">
            <div class="info">
                <h3>请选择退款原因：</h3>
                <div class="selectbox">
                    <select id="applyReasonCd">
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
                <textarea id="reasonDetailDesc"></textarea>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" id="submit">提交</a>
                <a href="javascript:void(0);" id="change">取消</a>
            </div>
        </div>
    </div>

    <div id="methodpayment" class="actionsheet-spec">
        <div class="close"></div>
        <div class="prod-info">
            <div class="title">请选择支付方式</div>
        </div>
        <div class="spec-list">
            <div class="spec-list-wrap">
                <ul class="tbviewlist paytypes">
                <#if businessConfigTypeList?? && businessConfigTypeList?has_content>
                    <#list businessConfigTypeList?keys as key>
                        <#assign payName="" />
                        <#assign payWay="4" />
                        <#if key="config_alipay_mobile">
                            <#assign payName="支付宝支付" />
                            <#assign payWay="2" />
                        <#elseif key="config_unionpay_mobile">
                            <#assign payName="银联支付" />
                            <#assign payWay="4" />
                        <#elseif key="weixin_pay_config">
                            <#assign payName="微信支付" />
                            <#assign payWay="1" />
                        <#elseif key="userBalnce">
                            <#assign payName="余额支付" />
                            <#assign payWay="5" />
                        </#if>

                        <li>
                            <a href="javascript:void(0);" <#if payWay!="5">onclick="submitOrder('${payWay}');"</#if>
                               <#if payWay == "5">id="balancepaymentBtn"</#if>>${payName!}</a>
                        </li>
                    </#list>
                </#if>
                </ul>
            </div>
        </div>

        <div id="balancePayment" class="balance-payment">
            <h3>支付订单金额￥<span class="needPay finalPay">${orderHeader.orderPayAmt?default(0)}</span>元</h3>
            <div class="paymentwrap" <#if isPayPassword == 1>style="display:none;"</#if>>
                <div class="orderinfo">
                    <P>请输入支付密码</P>
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
            </div>

            <div class="paymentwrap" <#if isPayPassword == 0>style="display:none;"</#if>>
                <div class="orderinfo">
                    <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="${ctx}/m/account/userChangePaw/changePaw_VerifyPhone?type=3"
                                                    class="orange">设置支付密码</a>！</p>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button" id="balancePaymentSub">确定</a>
                        <a href="javascript:void(0)" class="button cancel" id="balancePaymentCancle">取消</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="fbbwrap-total nofixed">
            <div class="ftbtnbar">
                <div class="button-wrap button-wrap-expand">
                    <a href="javascript:void(0)" class="button btn-buy">取消</a>
                </div>
            </div>
        </div>
    </div>

</div>

<script>
    $(function () {
        var balancePayment = $("#balancePayment");
        var orderId = ${orderHeader.orderId};

        //确认收货
        $("#confirmReceive").on("click", function () {
            var btnArray = ['是', '否'];
            mui.confirm('', '确认收货？', btnArray, function (e) {
                if (e.index == 0) {
                    $.post("${ctx}/m/account/orderHeader/confirmReceive", {
                        orderId: orderId
                    }, function (data) {
                        if (data && data.result == "success") {
                            mui.toast("'收货成功'!");
                            window.location.href = "${ctx}/m/account/orderHeader?type=4";
                        } else {
                            mui.toast(data.message);
                        }
                    }, "json");
                }
            })
        })

        //退款
        $("#return").on("click", function () {
            if ($("input[name='orderItemId']").size() == $("input[disabled='disabled']").size()) {
                mui.toast("无可退款商品！");
                return;
            }
            if ($("input[name='orderItemId']:checked").size() == 0) {
                mui.toast("请选择退款商品！");
                return;
            }
            $("#returnDlg1").addClass("mui-active");
            $("#returnDlg2").addClass("mui-popup-in");
            document.ontouchmove = function () {
                return false;
            }
        })
        //取消订单
        $("#cancelOrder").on("click", function () {
            var btnArray = ['否', '是'];
            mui.confirm('', '确认取消该订单？', btnArray, function (e) {
                if (e.index == 1) {
                    $.post("${ctx}/m/account/orderHeader/cancelOrderHeader", {
                        orderId: orderId
                    }, function (data) {
                        if (data && data.result == "success") {
                            window.location.href = "${ctx}/m/account/orderHeader?type=${type}";
                        } else {
                            mui.toast("取消失败，请稍后重试！");
                        }
                    }, "json");
                }
            })
        })
        //关闭退款窗口
        var closeDlg = function () {
            $(".show-abnormal-bg").removeClass("mui-active");
            $(".mui-abnormal").removeClass("mui-popup-in");
            document.ontouchmove = null;
        }
        //提交退款信息
        $("#submit").on("click", function () {
            closeDlg();
            //选中的商品id列表
            var orderItemIdList = [];
            $("input[name='orderItemId']:checked").each(function () {
                orderItemIdList.push($(this).val());
            });
            var param = {};
            param.orderId = orderId;
            param.applyReasonCd = $("#applyReasonCd").val();
            param.reasonDetailDesc = $("#reasonDetailDesc").val();
            param.orderItemIdList = orderItemIdList;
            //提交退款信息
            $.ajax({
                type: "POST",
                url: "${ctx}/m/account/orderHeader/returnOrderHeader",
                data: JSON.stringify(param),//将对象序列化成JSON字符串
                dataType: "json",
                contentType: 'application/json;charset=utf-8', //设置请求头信息
                success: function (data) {
                    if (data && data.result == "success") {
                        window.location.href = "${ctx}/m/account/orderHeader?type=${type}"
                    } else if (data && data.result == "false") {
                        mui.toast(data.isRefund);
                        return;
                    } else {
                        mui.toast("退款失败，请稍后重试！");
                        return;
                    }
                }
            });
        });
        //取消退款信息
        $("#change").on("click", function () {
            closeDlg();
        })

        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
                specAS = $("#methodpayment");
        $("#paymentBtn").on("click", function () {
            showSpecAS();
        });
        specAS.find(".close").on("click", function () {
            hideSpecAS();
        });

        $(".btn-buy").on("click", function () {
            hideSpecAS();
        });

        function showSpecAS() {
            specASMask.show().animate({opacity: 1}, {
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
        }

        function hideSpecAS(callback) {
            specAS.animate({
                opacity: 0,
                translateY: 0
            }, {
                duration: 200,
                easing: "ease-in-out",
                complete: function () {
                    specAS.hide();
                    specASMask.animate({opacity: 0}, {
                        duration: 80,
                        complete: function () {
                            specASMask.hide();
                            if (typeof callback == "function") callback.call();
                        }
                    });
                }
            });
        }

    <#-- 余额支付 -->

        var $input = $(".fake-box input");
        var payPassword = "";
        $("#pwd-input").on("input", function () {
            var pwd = $(this).val().trim();
            for (var i = 0, len = pwd.length; i < len; i++) {
                $input.eq("" + i + "").val(pwd[i]);
                payPassword = pwd;
            }
            $input.each(function () {
                var index = $(this).index();
                if (index >= len) {
                    $(this).val("");
                }
            });
            if (len == 6) {

            }
        });

        $("#balancepaymentBtn").on("click", function () {
            paymentshow();
        });

    <#--确认余额支付-->
        $("#balancePaymentSub").on("click", function () {
            if (payPassword.length != 6) {
                mui.toast('支付密码为6位数字！');
                return;
            }
            $.ajax({
                url: '${ctx}/m/account/order/testPayPwd',
                async: true,
                type: "GET",
                dataType: "json",
                data: {"payPassword": payPassword},
                success: function (result) {
                    flagSub = true;
                    if (result.result == 'success') {
                        blancePay = true;
                        submitOrder(5);
                    } else {
                        mui.toast(result.message);
                    }
                },
                error: function (XMLHttpResponse) {
                    flagSub = true;
                    console.log("请求未成功");
                }
            });
        });

    <#--取消余额支付-->
        $("#balancePaymentCancle").on("click", function () {
            paymenthide();
        });

        //显示支付密码框
        function paymentshow() {
            balancePayment.css({
                top: "100%",
                opacity: 0,
                display: "block"
            }).animate({
                opacity: 1,
                translateY: "-" + balancePayment.height() + "px"
            }, {
                duration: 200,
                easing: "ease-in-out"
            });
        }

        //隐藏支付密码框
        function paymenthide() {
            balancePayment.animate({
                opacity: 0,
                translateY: 0
            }, {
                duration: 200,
                easing: "ease-in-out",
                complete: function () {
                    balancePayment.hide();
                }
            });
        }

        $(".cancelService").on("click", function () {
            $(".show-abnormal-bg").removeClass("mui-active");
            $(".mui-abnormal").removeClass("mui-popup-in");
            document.ontouchmove = null;
        });

    });

    function submitOrder(payWay) {
        location.href = "${ctx}/m/account/order/goToOrderPayment?orderNumber=${orderHeader.orderNumber}&payWay=" + payWay;
    }

</script>
</body>
</html>