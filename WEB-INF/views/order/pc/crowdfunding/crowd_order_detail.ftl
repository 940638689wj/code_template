<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>众筹订单</title>
</head>
<body class="page-login">
<div class="center-layout">
<#include "../../../user/pc/include/menu.ftl"/>
    <div class="center-content">
        <div class="content-titel"><a href="/account/crowdfundingOrder/list" class="flr">返回众筹订单列表&gt;</a>
            <h3>订单中心<span><em>_</em>众筹订单详情</span></h3></div>
        <div class="center-list">
            <table class="orderdatatb orderdatatb2">
                <thead>
                <tr>
                    <td class="tal">众筹商品信息</td>
                    <td class="td-name">数量</td>
                    <td class="td-total">小计</td>
                    <td class="td-status">状态</td>
                    <td class="td-operate">操作</td>
                </tr>
                </thead>
            </table>

            <div class="datawrap">
                <table class="orderdatatb">
                    <tbody id="orderList">

                    </tbody>
                </table>
            </div>
        </div>

        <div id="address" class="order-info-mod" style="height:120px;display: none" id="address">
            <div class="dl" style="width: 33%">
                <div class="dt">收货人信息</div>
                <div class="dd">
                    <p><span>收货人：</span><em id="receiveName"></em></p>
                    <p><span>地址：</span><em id="receiveAddr"></em></p>
                    <p><span>联系电话：</span><em id="receiveTel"></em></p>
                </div>
            </div>
            <div class="dl" style="width: 33%">
                <div class="dt">配送信息</div>
                <div class="dd">
                    <p><span>快递名称：</span><em id="expressName"></em></p>
                    <p><span>快递单号：</span><em id="expressNum"></em></p>
                </div>
            </div>
            <div class="dl" style="width: auto">
                <div class="dt"></div>
                <div class="dd" style="text-align: center">
                    <a href="javascript:" class="v-btn" id="btnConfirmReceive" style="display: none">确认收货</a>
                </div>
            </div>
        </div>

        <div id="store" style="display:none">
            <div class="title">提货门店</div>
            <div class="grouporder-info">
                <ul>
                    <li><span id="storeName"></span>
                        <p id="storeAddr"></p></li>
                </ul>
            </div>
        </div>

        <div class="title">
            本期商品您总共购买<i class="text-red" id="orderNum"></i>次，拥有<i class="text-red" id="countFundCodeNum"></i>个众筹码
        </div>
        <table class="orderdatatb">
            <thead>
            <tr>
            <tr>
                <th>购买时间</th>
                <th>购买人次</th>
                <th class="tal" width="60%">众筹码</th>
            </tr>
            </tr>
            </thead>
            <tbody id="crowdFundCodeList">

            </tbody>
        </table>
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
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>
<script>
    var orderId = ${orderId?default(0)};
    var now;
    var hasWinnerCodeFlag = false;
    var winCode;
    $(function () {
        now = new Date();

        $('#balancePay').click(function () {
            layer.close(payment);
            paypassword();
        });

        $("#alipay").click(function () {
            layer.close(payment);
            toPay("alipay");
        });

        var index = layer.load(1, {
            shade: [0.1, '#fff'] //0.1透明度的白色背景
        });
        $.get('jsonDetailData', {orderId: orderId}, function (data) {
            if (data) {
//                console.log(data);
                var opera = '';
                var message = '';
                var status = '';
                if (data.orderPropertyCd == 0) { //正常订单
                    if (data.orderPayStatusCd == 1) {    // 待付款
                        message = '<div class="prop">总需<i class="text-black">' + data.requireNum + '</i>人次参与，还剩' +
                                '<i class="text-black">' + eval(data.requireNum - data.currentPeopleNum) + '</i>人次</div>';
                        opera = '<a href="JavaScript:repay(' + data.orderId + ')" class="v-btn">付款</a>';
                        status = '待付款';
                    } else {//已付款
                        if (data.crowdFundStatusCd == 0 || !data.winnerLoginName) {//待揭晓
                            message = '<div class="prop">总需<i class="text-black">' + data.requireNum + '</i>人次参与，还剩' +
                                    '<i class="text-black">' + eval(data.requireNum - data.currentPeopleNum) + '</i>人次</div>';
                            status = '待揭晓';
                        } else {//已揭晓
                            message = '<div class="prop">获奖者：<i class="text-red">' + data.winnerLoginName.substring(0, 3) + '****' + data.winnerLoginName.substring(data.winnerLoginName.length - 4) + '</i> ' +
                                    '</div><div class="prop">揭晓时间：' + new Date(data.calcTime).format('yyyy-MM-dd hh:mm:ss') + '</div>'
                            if (data.userId == data.winnerUserId) {//中奖
                                if (!data.taked) {//未领奖
                                    status = '未领奖<p class="text-red">恭喜中奖</p>';
                                    opera = '<a href="toAwardOrder/' + data.promotionId + '" class="btn-award">领奖</a>';
                                } else {
                                    if(data.orderStatusCd == 5){
                                        //已领奖，且已收货
                                        status = '已领奖<p class="text-red">恭喜中奖</p>';
                                    }else{
                                        //已领奖，未收货
                                        status = '已完成<p class="text-red">恭喜中奖</p>';
                                    }

                                    //显示领奖信息
                                    if (data.extraInfo.orderDistrbuteType == 1) {
                                        $("#address").show();
                                        $("#receiveAddr").html(data.extraInfo.receiveAddrCombo);
                                        $("#receiveTel").html(data.extraInfo.receiveTel);
                                        $("#receiveName").html(data.extraInfo.receiveName);
                                        if (data.extraInfo.expressNum && data.extraInfo.expressName) {
                                            $("#expressNum").html(data.extraInfo.expressNum);
                                            $("#expressName").html(data.extraInfo.expressName);
                                            if(data.orderStatusCd != 5){
                                                $("#btnConfirmReceive").show();
                                            }
                                        } else {
                                            $("#expressName").html("尚未发货");
                                        }
                                    } else {
                                        $("#store").show();
                                        $('#storeAddr').html(data.extraInfo.storeAddr);
                                        $('#storeName').html(data.extraInfo.storeName + ':');
                                    }
                                }
                            } else {//没中奖
                                status = '未中奖';
                            }
                        }
                    }
                } else {//已退款
                    status = '已退款';
                }
                var promotionUrl = '/crowdfunding/detail/' + data.promotionId;
                var result = '<tr><td class="td-product"><div class="first-column"><div class="img"><a href="' + promotionUrl + '"><img src="' + data.picUrl + '"/></a>' +
                        '</div><div class="info"><div class="name"><a href="' + promotionUrl + '" target="_blank">' + data.promotionName + '</a>' +
                        '</div><div class="prop">订单号：' + data.orderNumber + '</div>' +
                        '<div class="prop">价值：￥' + data.defaultPrice.toFixed(2) + '（众筹价：￥' + data.perAmt.toFixed(2) + '）</div>' +
                        message +
                        '</div></div></td><td class="td-name">' + data.quantity +
                        '</td><td class="td-total"><span class="price-real">￥' + (eval(data.quantity * data.perAmt).toFixed(2)) + '</span></td>' +
                        '<td class="td-status">' + status + '</td><td class="td-operate">' + opera +
                        '</td></tr>';
                $('#orderList').append(result);
                $('#orderNum').html(data.extraInfo.orderList.length);
                $('#countFundCodeNum').html(data.extraInfo.countFundCodeNum);
            <#--遍历输出购买历史记录-->
                var crowdFundCodeList = '';
                if (data.winCode && data.winCode != '') {
                    winCode = data.winCode;
                    hasWinnerCodeFlag = true;
                }
                data.extraInfo.orderList.forEach(function (order) {
                    crowdFundCodeList += '<tr><td>' + new Date(order.createTime).format('yyyy-MM-dd hh:mm:ss') + '</td><td class="text-red">' + order.fundCodeNums.length + '</td>' +
                            '<td class="tal">' + getfundCodeStr(order.fundCodeNums) + '</td></tr>'
                });
//                console.log(data)
                $("#crowdFundCodeList").append(crowdFundCodeList);
                layer.close(index)
            }
        });
    });

    function getfundCodeStr(fundCodeNums) {
        if (hasWinnerCodeFlag) {
            return fundCodeNums.join(",").replace(winCode, winCode + '（已中奖）');
        } else {
            return fundCodeNums.join(",");
        }
    }


    $(function () {
        $(".mcmenu dt").on("click", function () {
            var parentMenu = $(this).parent();
            parentMenu.toggleClass("mcmenu-closed");
            if (parentMenu.hasClass("mcmenu-closed")) {
                parentMenu.animate({
                    height: 40
                }, {duration: 200});
            } else {
                parentMenu.animate({
                    height: parentMenu.prop("scrollHeight")
                }, {duration: 200});
            }
        });

        $("#btnBuy").on("click", function () {
            payment();
        });

        $("#balancePayment").on("click", function () {
            paypassword();
        });

        $("#btnConfirmReceive").click(function () {
            layer.confirm("是否确认收货？", function () {
                $.get("${ctx}/account/crowdfundingOrder/receiveConfirm", {orderId: orderId}, function (data) {
                    if (data) {
                        if (data.result == 'success') {
                            layer.msg("确认收货成功！");
                            setTimeout(function(){
                                location.reload();
                            },1000);
                        } else {
                            layer.alert(data.message);
                        }
                    } else {
                        layer.msg("网络异常，请稍候再试");
                    }
                });
            });
        });
    });

    function repay(orderId) {
        $.get('/account/crowdfundingOrder/jsonRepayData', {orderId: orderId}, function (data) {
            if (data) {
                if (new Date(data.promotionEndTime) < now) {
                    layer.alert("该众筹活动已经结束，无法购买！")
                    return false;
                } else if ((data.requireNum - data.currentPeopleNum - data.quantity) < 0) {
                    layer.alert("购买的数量已经超过该众筹数量，无法购买！")
                    return false;
                } else if ((data.personalJoinLimit - data.quantity - data.currentUserNum) < 0) {
                    layer.alert("购买的数量已经超过该限购数，无法购买！")
                    return false;
                }

                currentOrderId = orderId;

                /*如果订单实付为0，则直接提交订单
                如果订单实付不为0，则选择支付方式：如果余额足够，则显示余额支付，否则支付支付宝支付*/
                if (data.orderPayAmt == 0) {
                    layer.msg('确认支付吗？', {
                        time: 0 //不自动关闭
                        , btn: ['确认', '取消']
                        , yes: function (index) {
                            toPay('balancePay');
                        }
                    });
                } else {
                    data.extraInfo.userBalance >= data.orderPayAmt ? $('#balancePay').show() : $('#balancePay').hide();
                    payment();
                }
            }
        });
    }

    //处理支付
    function toPay(payWay) {
        $.ajax({
            url: '/account/crowdfundingOrder/dealRepayOrder',
            type: 'post',
            data: {
                orderId: currentOrderId,
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
    $('#payPassword .v-btn').click(function () {
        layer.close(payPassword);
        var reg = /^\d{6}$/;
        var payPwd = $("#payPassword input").val();
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
    })

    var payment;
    function payment() {
        payment = layer.open({
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
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px', '200px'],
            content: $("#payPassword")
        });
    }
</script>
</body>
</html>