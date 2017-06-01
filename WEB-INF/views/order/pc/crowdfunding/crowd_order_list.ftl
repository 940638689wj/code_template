<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>众筹订单</title>
</head>
<body class="page-login">
<#include "../../../user/pc/include/header.ftl"/>
<div class="center-layout">
<#include "../../../user/pc/include/menu.ftl"/>
    <div class="center-content">
        <div class="content-titel"><h3>订单中心<span><em>_</em>众筹订单</span></h3></div>

        <div class="center-list">
            <table class="orderdatatb orderdatatb2">
                <thead>
                <tr>
                    <td class="tal">众筹商品信息</td>
                    <td class="td-name">众筹人次</td>
                    <td class="td-total">小计</td>
                    <td class="td-status">状态</td>
                    <td class="td-operate">操作</td>
                </tr>
                </thead>
            </table>
            <div class="datawrap">
                <table class="orderdatatb">
                    <tbody id="orderList">
                    <#--订单列表-->
                    </tbody>
                </table>
            </div>
        </div>
        <div class="pr-pager">
            <span class="total"></span>
            <div id="page"></div>
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
</div>
<link rel="stylesheet" href="/static/css/jquery.page.css">
<script type="text/javascript" src="/static/js/jquery.page.js"></script>
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>

<script>
    var userId = ${userId?default(0)};

    var initPageFlag = true;
    var totalPage;
    var pageSize = 6;
    var now;
    var currentOrderId;

    $(function () {
        jsonData(1);
        now = new Date();

        $('#balancePay').click(function () {
            layer.close(payment);
            paypassword();
        });

        $("#alipay").click(function () {
            layer.close(payment);
            toPay("alipay");
        });

    });


    function jsonData(_page) {
        var index = layer.load(1, {
            shade: [0.1, '#fff'] //0.1透明度的白色背景
        });
        $.get('/account/crowdfundingOrder/jsonListData', {pageNum: _page, pageSize: pageSize}, function (data) {
            if (data) {
                /*console.log(data)*/
                $('#orderList').empty();
                if (initPageFlag) {
                    initPageFlag = false;
                    initPage(data.count);
                }
                _page == 1 ? $('#page .prv').hide() : $('#page .prv').show();
                _page == totalPage ? $('#page .next').hide() : $('#page .next').show();

                var result = '';
                data.result.forEach(function (val) {
                    var opera = '';
                    var message = '';
                    var status = '';
                    var promotionUrl = '';
                    if (val.orderPropertyCd == 0) { //正常订单
                        if (val.orderPayStatusCd == 1) {    // 待付款
                            message = '<div class="prop">总需<i class="text-black">' + val.requireNum + '</i>人次参与，还剩' +
                                    '<i class="text-black">' + eval(val.requireNum - val.currentPeopleNum) + '</i>人次</div>';
                            opera = '<a href="JavaScript:repay(' + val.orderId + ')" class="v-btn">付款</a>';
                            status = '待付款';
                        } else {//已付款
                            if (val.crowdFundStatusCd == 0 || !val.winnerLoginName) {//待揭晓
                                message = '<div class="prop">总需<i class="text-black">' + val.requireNum + '</i>人次参与，还剩' +
                                        '<i class="text-black">' + eval(val.requireNum - val.currentPeopleNum) + '</i>人次</div>';
                                status = '待揭晓';
                            } else {//已揭晓
                                message = '<div class="prop">获奖者<i class="text-red">' + val.winnerLoginName.substring(0, 3) + '****' + val.winnerLoginName.substring(val.winnerLoginName.length - 4) + '</i> ' +
                                        '</div><div class="prop">揭晓时间:' + new Date(val.calcTime).format('yyyy-MM-dd hh:mm:ss') + '</div>'
                                if (userId == val.winnerUserId) {//中奖
                                    if (!val.taked) {//未领奖
                                        status = '未领奖<p class="text-red">恭喜中奖</p>';
                                        opera = '<a href="/account/crowdfundingOrder/toAwardOrder/'+val.promotionId+'" class="btn-award">领奖</a>';
                                    } else {
                                        if(data.orderStatusCd == 5){
                                            //已领奖，且已收货
                                            status = '已领奖<p class="text-red">恭喜中奖</p>';
                                        }else{
                                            //已领奖，未收货
                                            status = '已完成<p class="text-red">恭喜中奖</p>';
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
                    promotionUrl = '/crowdfunding/detail/'+val.promotionId;
                    result += '<tr><td class="td-product"><div class="first-column"><div class="img"><a href="'+promotionUrl+'"><img src="' + val.picUrl + '"/></a>' +
                            '</div><div class="info"><div class="name"><a href="'+promotionUrl+'" target="_blank">' + val.promotionName + '</a>' +
                            '</div><div class="prop">价值：￥' + val.defaultPrice.toFixed(2) + '（众筹价：￥' + val.perAmt.toFixed(2) + '）</div>' +
                            message +
                            '</div></div></td><td class="td-name">' + val.quantity +
                            '</td><td class="td-total"><span class="price-real">￥' + (eval(val.quantity * val.perAmt).toFixed(2)) + '</span></td>' +
                            '<td class="td-status">' + status + '</td><td class="td-operate">' + opera +
                            '<p><a href="/account/crowdfundingOrder/detail?orderId='+val.orderId+'">查看详情</a></p></td></tr>';
                })
                $('#orderList').append(result);
                layer.close(index);
            }
        });
    }

    //初始化分页插件
    function initPage(pageTotal) {
        var pageEle = $("#page");
        totalPage = Math.ceil(pageTotal / pageSize);
        pageEle.prev().html('共' + pageTotal + '件众筹订单');

        pageEle.Page({
            totalPages: totalPage,
            //分页总数
            liNums: 5,
            //分页的数字按钮数(建议取奇数)
            activeClass: 'activP',
            //active 类样式定义
            hasFirstPage: false,
            hasLastPage: false,
            callBack: function (page) {
                jsonData(page);
            }
        });
    }

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

    //支付弹框
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

    //密码输入框
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
</script>
</body>
</html>