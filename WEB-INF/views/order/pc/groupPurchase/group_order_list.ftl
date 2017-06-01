<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>团购订单</title>
</head>
<body class="page-login">
<#include "../../../user/pc/include/header.ftl"/>
<div class="center-layout">
    <#include "../../../user/pc/include/menu.ftl"/>
    <div class="center-content">
        <div class="content-titel"><h3>订单中心<span><em>_</em>团购订单</span></h3></div>
        <div class="corder-tab">
            <ul id="orderTab">
                <li class="current"><a href="#" onclick="changeType(2,this)">待付款</a></li>
                <li><a href="#" onclick="changeType(4,this)">可使用</a></li>
                <li><a href="#" onclick="changeType(5,this)">待评价</a></li>
                <li><a href="#" onclick="changeType(6,this)">已完成</a></li>
                <li><a href="#" onclick="changeType(1,this)">已取消</a></li>
                <li><a href="#" onclick="changeType(3,this)">已过期</a></li>
            </ul>
        </div>
        <div class="center-list">
            <table class="orderdatatb orderdatatb2">
                <thead>
                <tr>
                    <td class="tal">团购商品信息</td>
                    <td class="td-price">金额</td>
                    <td class="td-amount">数量</td>
                    <td class="td-operate">优惠</td>
                    <td class="td-total">实付金额</td>
                    <td class="td-status">状态</td>
                    <td class="td-operate">操作</td>
                </tr>
                </thead>
            </table>

            <div class="datawrap" id="orderList">

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

</div>
<link rel="stylesheet" href="/static/css/jquery.page.css">
<script type="text/javascript" src="/static/js/jquery.page.js"></script>
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>
<script>

    var initPageFlag = true;
    var totalPage;
    var pageSize = 4;
    var currentOrderId;
    var type = 2;

    $(function () {
        jsonData(1);

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

    function changeType(_type, e) {
        $('#orderTab li').removeClass('current');
        $(e).parent().addClass('current');
        type = _type;
        initPageFlag = true;
        jsonData(1);
    }

    function jsonData(_page) {
        var index = layer.load(1, {
            shade: [0.1, '#fff'] //0.1透明度的白色背景
        });

        $.get('/account/groupPurchaseOrder/jsonListData', {
            pageNum: _page,
            pageSize: pageSize,
            type: type
        }, function (data) {
            if (data) {
                console.log(data)
                $('#orderList').empty();
                if (initPageFlag) {
                    initPageFlag = false;
                    initPage(data.count);
                }
                _page == 1 ? $('#page .prv').hide() : $('#page .prv').show();
                /*_page == totalPage ? $('#page .next').hide() : $('#page .next').show();*/

                var result = '';
                var status;
                var opera = '';
                var couponDesc;
                switch (type) {
                    case 1:
                        status = '已取消';
                        opera = '<a href="javascript:deleteOrder()" class="v-btn">删除订单</a>';
                        break;
                    case 2:
                        status = '待付款';
                        opera = '<a href="javascript:repay()" class="v-btn">付款</a><a href="javascript:cancel()" class="v-button">取消订单</a>';
                        break;
                    case 3:
                        status = '已过期';
                        break;
                    case 4:
                        status = '可使用';
                        break;
                    case 5:
                        status = '待评价';
                        opera = '<a href="#" class="v-btn">评价</a>';
                        break;
                    case 6:
                        status = '已完成';
                        break;
                }
                opera += '<p><a href="javascript:detail()">查看详情</a></p>';

                data.result.forEach(function (val) {
                    couponDesc = '';
                    if (val.couponDesc) {
                        val.couponDesc.forEach(function (desc) {
                            couponDesc += '<p>' + desc + '</p>';
                        })
                    }
                    var groupCouponDesc = val.groupCouponDesc == null ? '' : val.groupCouponDesc;
                    result += '<table class="orderdatatb"> <tbody > <tr> <th colspan="7" class="ordertb-hd"> ' +
                            '<div class="order-num">订单号<em>' + val.orderNumber + '</em></div> ' +
                            '<div class="order-time">下单时间<em>' + new Date(val.createTime).format('yyyy-MM-dd hh:mm:ss') + '</em></div> </th> </tr> <tr> ' +
                            '<td class="td-product"> <div class="first-column"> <div class="img"><a href="#">' +
                            '<img src="' + val.picUrl + '"></a></div> <div class="info"> ' +
                            '<div class="name"><a href="/groupPurchase/detail/' + val.promotionId + '" target="_blank">' + val.promotionName + '</a> ' +
                            '</div> <div class="prop"><span>' + groupCouponDesc + '</span> </div> </div> </div> </td> ' +
                            '<td class="td-price">￥' + val.grouponPrice.toFixed(2) + '</td> <td class="td-amount">' + val.quantity + '</td> <td class="td-operate">' + couponDesc + '</td> ' +
                            '<td class="td-total"><span class="price-real">￥' + (val.orderTotalAmt-val.orderDiscountAmt).toFixed(2) + '</span></td> ' +
                            '<td class="td-status">' + status + '</td> <td class="td-operate" onclick="recordOrder(' + val.orderId + ')"> ' + opera +
                            '</td> </tr> </tbody> </table>'
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
        pageEle.prev().html('共' + pageTotal + '件团购订单');

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

    //支付按钮事件
    function repay() {
//        layer.msg(orderId);
        $.get('jsonRepayData', {orderId: orderId}, function (data) {
//            console.log(data);
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
    }

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

    var orderId;
    function recordOrder(_orderId) {
        orderId = _orderId;
//        console.log(orderId);
    }

    function cancel() {
        layer.prompt({title: '请输入取消原因', formType: 2}, function (text, index) {
            layer.close(index);
            $.get('cancelGroupOrder', {orderId: orderId, reason: text}, function (data) {
                if (data.result == 'success') {
                    layer.msg('取消成功！');
                    location.reload();
                } else {
                    layer.alert(data.message);
                }
            });
        });
    }

    function deleteOrder() {
        layer.confirm('是否确认删除订单？',function () {
            $.get('deleteOrder', {orderId: orderId}, function (data) {
                if (data.result == 'success') {
                    layer.msg('删除成功！');
                    location.reload();
                } else {
                    layer.alert(data.message);
                }
            });
        })
    }

    function detail(){
        location.href = 'detail/'+orderId;
    }
</script>
</body>
</html>
