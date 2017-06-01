<body class="page-list">
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>
<div id="main">
    <div class="checkout">
        <div class="checkout-tit">填写并核对订单信息</div>
        <div class="checkout-steps">
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>商品信息</h3>
                    <span class="extra-r flr"><a href="/crowdfunding/detail/${crowdFundDTO.promotionId!}" class="link">返回众筹详情</a></span>
                </div>
                <div class="shoptb">
                    <div class="shoptb-hd">
                        <table>
                            <tbody>
                            <tr>
                                <td class="td-product">商品</td>
                                <td class="td-price">价值</td>
                                <td class="td-promote">众筹价</td>
                                <td class="td-amount">数量</td>
                                <td class="td-total">小计</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="shoptb-row">
                        <table>
                            <tbody>
                            <tr>
                                <td class="td-product">
                                    <div class="first-column">
                                        <div class="img"><a href="#"><img src="/static/images/awardsGame.jpg"></a></div>
                                        <div class="info">
                                            <div class="name"><a href="/crowdfunding/detail/${crowdFundDTO.promotionId!}"
                                                                 target="_blank">${crowdFundDTO.promotionName!}</a>
                                            </div>
                                            <div class="prop"><span>总需 <em
                                                    style="color:#FF0000;">${crowdFundDTO.requireNum!}</em> 人次参与，还剩 <em
                                                    style="color:#FF0000;">${crowdFundDTO.requireNum - crowdFundDTO.currentPeopleNum!}</em> 人次</span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="td-price">
                                    ￥${(crowdFundDTO.requireNum * crowdFundDTO.perAmt)?string('##0.00#')}</td>
                                <td class="td-promote">${crowdFundDTO.perAmt?string('##0.00#')}</td>
                                <td class="td-amount">
                                            <span id='countBtn' class="amount-widget">
                                                <span class="decrease" onclick="deNum()"></span>
                                                <input class="textfield" type="number" id="buyNum"
                                                       onchange="changeNum()">
                                                <span class="increase" onclick="inNum()"></span>
                                            </span>
                                </td>
                                <td class="td-total"><em>￥<span id="totalAmt"></span> </em></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>支付信息</h3>
                </div>
                <div class="order-ft">
                    <div class="order-extra">
                        <div class="formList order-extra">
                            <div class="item">
                                <div class="hd">余额抵扣</div>
                                <div class="bd">
                                    <input id="integral" type="checkbox" name="integral" <#if (crowdFundDTO.userBalance <=0 )>disabled = 'true'</#if><span
                                        class="infotext">当前可用余额￥${crowdFundDTO.userBalance?string('####0.00#')}，是否使用</span>
                                </div>
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
                <span class="price-num">￥<span id="realPayAmt"></span></span>
            </div>
        </div>
        <div class="inner">
            <button id="balancepaymentBtn">提交订单</button>
        </div>
    </div>

    <div id="payment" class="hidden">
        <div class="paytypes">
            <ul>
                <li><a href="javascript:toPay('alipay')">支付宝支付</a></li>
                <li><a href="javascript:toPay('unionpay')" id='unionpay'>银联支付</a></li>
            </ul>
        </div>
    </div>
    <div id="payPassword" class="hidden">
        <div class="formList paypassword">
            <div class="item">
                <div class="hd">输入支付密码：</div>
                <div class="bd">
                    <input type="password" class="textfield" value=''>
                </div>
            </div>
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <a class="v-btn" href="javascript:">确定</a>
                </div>
            </div>
        </div>
    </div>
</div>
    <script type='text/javascript'>
    var promotionId = ${promotionId?default('0')};

    var app = {
        buyNum:${buyNum?default(0)},
        userBalance: ${crowdFundDTO.userBalance?default('0')},
        perAmt:${crowdFundDTO.perAmt?default('0')},
        personalJoinLimit:${crowdFundDTO.personalJoinLimit?default('0')},
        requireNum:${crowdFundDTO.requireNum?default(0)},
        payWays: '${crowdFundDTO.payWays?default('0')}',
        currentPeopleNum:${crowdFundDTO.currentPeopleNum?default(0)},    <#--该众筹已被购买数量-->
        currentUserNum:${crowdFundDTO.currentUserNum?default(0)},        <#--该用户已经购买数量-->
        md5: '${crowdFundDTO.payPassword?default('nomd5')}',
        maxNum:${(crowdFundDTO.requireNum - crowdFundDTO.currentPeopleNum)?default(0)}
    };

    $(function () {
    <#--判断用户购买数量是否超限-->
        if (app.currentUserNum >= app.personalJoinLimit) {
            layer.alert('您购买的次数已经达到限购数，已经无法购买', function () {
                window.location.href = '/crowdfunding/list';
            })
            return false;
        }
        app.currentUserLimit = app.personalJoinLimit - app.currentUserNum;
        if (eval(app.buyNum - app.currentUserLimit) > 0 || eval(app.buyNum  -app.maxNum) > 0) {
            layer.msg("您选择的数量已经超过限购数!", {icon: 5});
            app.buyNum = 1;
        }
        $('#buyNum').val(app.buyNum);
        //重新计算金额
        reCountAmt();

        //余额支付按钮
        $("#integral").click(function () {
            $("#integral").toggleClass('mui-active');
            balancePay();
        });
        if (app.payWays.indexOf('unionpay') < 0) $('#unionpay').hide();
    });

    <#--数量变化-->
    function deNum() {
        app.buyNum = eval(parseInt(app.buyNum) - 1);
        checkNum();
    }
    function inNum() {
        app.buyNum = eval(parseInt(app.buyNum) + 1);
        checkNum();
    }
    function changeNum() {
        app.buyNum = $('#buyNum').val().trim().replace('.', '');
        checkNum();
    }
    <#--校验数量并重算金额-->
    function checkNum() {
        if (app.buyNum > app.currentUserLimit) {
            app.buyNum = 1;
            layer.alert('该团购每人限购' + app.personalJoinLimit + '人次,您已经购买了' + app.currentUserNum + '人次，请检查购买数量！');
        }
        app.buyNum <= 0 ? app.buyNum = 1 : '';
        app.buyNum > app.maxNum ? app.buyNum = app.maxNum : '';
        if (parseInt(app.buyNum) == 1) {
            $("#countBtn .decrease").addClass("decrease-disabled")
        } else {
            $("#countBtn .decrease").removeClass("decrease-disabled")
        }
        if (app.buyNum >= app.maxNum) {
            $("#countBtn .increase").addClass("increase-disabled");
        } else {
            $("#countBtn .increase").removeClass("increase-disabled");
        }
        $('#buyNum').val(app.buyNum);
        //重新计算金额
        reCountAmt();
    }

    //重新计算金额
    function reCountAmt() {
        app.payAmt = eval(app.buyNum * app.perAmt).toFixed(2);		//计算小计：数量*单价-优惠
        app.realPayAmt = app.payAmt;	//实付
        //改变数量时保留余额支付
        balancePay();
    }

    var payPwdFlag;
    var productId;
    var fullBalanceFlag = true;


    //计算余额支付后的金额
    function balancePay() {
        if ($("#integral").hasClass('mui-active')) {
            app.isBalancePay = true;
            //如果余额大于应付金额，则余额完全抵扣金额，输入密码直接付款
            //如果余额小于应付金额，则实付金额等于小计-余额
            var _payAmt = eval(app.realPayAmt - app.userBalance);//应付金额
            if (_payAmt < 0) {
                app.balancePayAmt = app.realPayAmt;
                app.realPayAmt = '0.00';
            } else {
                app.balancePayAmt = app.userBalance;
                app.realPayAmt = _payAmt.toFixed(2);
            }
        } else {
            app.isBalancePay = false;
            app.realPayAmt = app.payAmt;	//实付
        }
        $('#realPayAmt').html(app.realPayAmt);
        $('#totalAmt').html(app.payAmt);
    }


    //跳转到设置支付密码页面
    function setPayPwd() {
        var _url = '/account/userChangePaw?type=2&successUrl=' + encodeURIComponent(window.location.href);
        window.location.href = _url;
    }
    <#----------------------------------------------支付处理---------------------------------------------------->
    $(function () {
        $("#balancepaymentBtn").on("click", function () {
            if ($("#integral").hasClass('mui-active')) {
                if (app.md5 == 'nomd5' || app.md5 == '') {
                  	//如果没有支付密码，需要先跳转到设置支付密码页面
                    layer.confirm('请先设置支付密码',function(){
                        setPayPwd();
                    });
                } else {
                    paypassword();
                }
            } else {
                payment();
            }
        });

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

        var payPassword;

        function paypassword() {
            $("#payPassword input").val('');
            payPassword = layer.open({
                type: 1,
                title: '支付密码',
                skin: 'layui-layer-rim',
                shade: [0.6],
                area: ['360px', '200px'],
                content: $("#payPassword")
            });
        }

        $('#payPassword .v-btn').click(function () {
            var reg = /^\d{6}$/;
            var payPwd = $("#payPassword input").val();
            if (reg.test(payPwd)) {
                //SHA1加密
                var payPwd = CryptoJS.SHA1(payPwd).toString();

                //执行其他操作
                $.post('/m/account/groupPurchaseOrder/checkPayPwd', {payPwd: payPwd}, function (data) {
                    if (data.result == 'success') {
                        if (app.realPayAmt == 0) {
                            //如果余额支付且余额足够，则直接支付
                            $('#wait').addClass('mui-progressbar-infinite');
                            $.ajax({
                                url: '/m/account/crowdfundingOrder/dealCrowdfundOrder',
                                type: 'post',
                                data: {
                                    promotionId: promotionId,
                                    buyNum: app.buyNum,
                                    payWay: 'balancePay',
                                    terminal:'pc'
                                },
                                dataType: 'json',
                                success: function (data) {
                                    layer.close(payPassword);
                                    if (data.result == 'success') {
                                        layer.msg('支付成功!');
                                        location.href = "/account/crowdfundingOrder/toPaySuccessPage?orderId=" + data.data;
                                    } else {
                                        layer.alert(data.message);
                                    }
                                },
                                error: function () {
                                    layer.alert('网络出错，请稍后再试！');
                                }
                            });
                        } else {
                            //如果余额支付但余额不足，则再次弹出微信支付框
                            app.isBalancePay = false;
                            fullBalanceFlag = false;
                            layer.close(payPassword);
                            payment();
                        }

                    } else {
                        layer.msg('支付密码错误！');
                    }
                })
            } else {
                layer.close(payPassword);
                layer.msg('密码错误！');
            }
        })
    })

    function toPay(payWay) {
        switch (payWay) {
            case 'wechatpay':
                //如果选中余额，就是余额部分支付
                payWay = $("#integral").hasClass('mui-active') ? 'wechatpay_balance' : 'wechatpay';
                break;
            case 'alipay':
                //如果选中余额，就是余额部分支付
                payWay = $("#integral").hasClass('mui-active') ? 'alipay_balance' : 'alipay';
                break;
            case 'unionpay':
                //如果选中余额，就是余额部分支付
                payWay = $("#integral").hasClass('mui-active') ? 'unionpay_balance' : 'unionpay';
                break;
        }
        $.ajax({
            url: '/m/account/crowdfundingOrder/dealCrowdfundOrder',
            type: 'post',
            data: {
                promotionId: promotionId,
                buyNum: app.buyNum,
                payWay: payWay,
                terminal:'pc'
            },
            dataType: 'json',
            success: function (data) {
                if (data.result == 'success') {
                    window.location.href = '/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
                } else {
                    layer.alert(data.message);
                }
            },
            error: function () {
                layer.alert('网络出错，请稍后再试！');
            }
        });
    }
</script>
</body>
