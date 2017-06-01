<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>提购订单</title>
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body class="page-login">
<div :controller="app" class="ms_controller">
<#include "include/header.ftl"/>
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>订单中心<span><em>_</em>提货券订单</span></h3></div>
            <div class="corder-tab">
                <ul>
                    <li :for="($index,typeName) in @typeNameList" :class="{current: @type == ($index+1)}">
                        <a href="javascript:void(0)" :click="@type = ($index+1)">
                            {{typeName}}
                        </a>
                    </li>
                </ul>
            </div>
            <div class="center-list">
                <table class="orderdatatb orderdatatb2">
                    <thead>
                    <tr>

                        <td class="order-num" width="20%">订单号</td>
                        <td class="td-name" width="10%">收货人</td>
                        <td class="order-time" width="20%">下单时间</td>
                        <td class="tal" width="10%">套餐名称</td>
                        <td class="td-amount" width="10%">数量</td>
                        <td class="td-total" width="10%">实付金额</td>
                        <td class="td-status" width="15%">状态</td>
                        <td class="td-operate" width="15%">操作</td>
                    </tr>
                    </thead>
                </table>

                <div class="datawrap">
                    <table>
                        <tbody>
                        <#--
                        <tr>
                            <th colspan="6" class="ordertb-hd"><div class="order-num">订单号<em>{{pickOrder.orderNumber}}</em></div><div class="order-time">下单时间<em>{{pickOrder.createTime | date("yyyy-MM-dd HH:mm:ss")}}</em></div></th>

                        </tr>
                        -->

                        <tr  class="orderdatatb" :for="pickOrder in @pickOrderList">

                            <td class="order-num" width="20%">{{pickOrder.orderNumber}}</td>
                            <td class="td-name" width="10%">{{pickOrder.receiveName}}</td>
                            <td class="order-time" width="20%">{{pickOrder.createTime | date("yyyy-MM-dd HH:mm:ss")}}</td>
                            <td class="td-product" width="10%">{{pickOrder.packageName}}</td>

                            <td class="td-amount" width="10%">{{pickOrder.pickNumAmt}}</td>
                            <td class="td-total" width="10%"><span class="price-real">￥{{pickOrder.orderTotalAmt-pickOrder.orderDiscountAmt}}</span><p></p></td>
                            <td class="td-status" width="15%">{{pickOrder.orderDistrbuteTypeName}}<p><span class="source">{{pickOrder.originPlatformName}}</span></p></td>
                            <#--对应不同状态的操作 -->
                            <td class="td-operate" ms-visible="pickOrder.type == 1"><a href="javascript:void(0)" ms-click="@repay(pickOrder.orderId)" class="v-btn">付款</a><a href="javascript:void(0)" ms-click="@cancel(pickOrder.orderId)" class="v-button">取消订单</a><a href="javascript:void(0)" ms-click="@paymentDel(pickOrder.orderId)" class="v-button">删除订单</a><p><a href="javascript:void()" ms-click="@toDetail(pickOrder.orderId)">查看详情</a></p></td>
                            <td class="td-operate" ms-visible="pickOrder.type == 2"><p><a href="javascript:void(0)" ms-click="@toDetail(pickOrder.orderId)">查看详情</a></p></td>
                            <td class="td-operate" ms-visible="pickOrder.type == 3"><a href="javascript:void(0)" ms-click="@confirm(pickOrder.orderId)" ms-visible="pickOrder.orderDistrbuteTypeCd == 1" class="v-btn">确认收货</a><p><a href="javascript:void()" ms-click="@toDetail(pickOrder.orderId)">查看详情</a></td>
                            <td class="td-operate" ms-visible="pickOrder.type == 4"><p><a href="javascript:void(0)" ms-click="@toDetail(pickOrder.orderId)">查看详情</a></p></td></td>
                            <td class="td-operate" ms-visible="pickOrder.type == 5"><a href="javascript:void(0)" ms-click="@deleteOrder(pickOrder.orderId)" class="v-btn">删除订单</a><p><a href="javascript:void(0)" ms-click="@toDetail(pickOrder.orderId)">查看详情</a></p></td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
            <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        </div>
    </div>
    <div id="payment" class="hidden">
        <div class="paytypes">
            <ul>
                <li><a href="#" id="balancePay">余额支付</a></li>
                <li><a href="#" id="alipay">支付宝支付</a></li>
            </ul>
        </div>
    </div>
</div>
<#include "include/pager.ftl"/>
<script type="text/javascript" src="${ctx}/static/mobile/js/sha1.js"></script>
<script>
    $(function(){
        $("#menu_pickupOrder").addClass("current");
        $("#balancePay").click(function(){
            layer.closeAll();
            layer.prompt({title:'请输入密码',formType:1},function(text,index){
                layer.close(index);
                passwordCheck(text)
            });
        });

        $("#alipay").click(function () {
            layer.closeAll();
            toPay("alipay");
        });

    });
    var orderId;
    //支付弹框
    function payment(id) {
        orderId = id;
        layer.open({
            type: 1,
            title: '选择支付方式',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px'],
            content: $("#payment")
        });
    }
    //校验密码
    function passwordCheck(payPwd){
        var reg = /^\d{6}$/;
        if (reg.test(payPwd)) {
            //SHA1加密
            var payPwd = CryptoJS.SHA1(payPwd).toString();
            //执行其他操作
            $.post('${ctx}/m/account/groupPurchaseOrder/checkPayPwd', {payPwd: payPwd}, function (data) {
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

    //处理支付
    function toPay(payWay) {
        $.ajax({
            url: '${ctx}/account/pickupOrder/repayOrder',
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
                        window.location.href = '${ctx}/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
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

    var vm = avalon.define({
        $id: 'app',
        type: 1,
        typeNameList: ['待付款','待发货','待收货','已完成','已取消'],
        pageNo: 1,
        pageSize: 4,
        pickOrderList:[],
        count: {type1:0,type2:0,type3:0,type4:0,type5:0},
        $computed: {
            pageCount: function(){
                return this.count["type"+this.type];
            }
        },
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
            $.get('${ctx}/account/pickupOrder/findListByLimit',{
                'pageNo':vm.pageNo,
                'pageSize':vm.pageSize,
                'type':vm.type
            },function(data){
                vm.pickOrderList = data.orderList;
            });
        },
        toDetail: function(orderId){
            location.href="${ctx}/account/pickupOrder/detail?orderId="+orderId;
        },
        confirm: function(orderId){

            layer.confirm('是否确定收货？',function(){

                    $.post('${ctx}/account/pickupOrder/confirmOrder',{'orderId':orderId},function(data){
                        if(data.result == 'success'){
                            layer.msg('交易完成');
                            location.reload();
                        }else{
                            layer.msg("操作失败");
                        }
                    });
            });
        },
        deleteOrder:function(orderId){
            layer.confirm('删除订单不能找回',function(){
                $.get('${ctx}/account/pickupOrder/deletePickOrder', {orderId: orderId}, function (data) {
                    if (data.result == 'success') {
                        layer.msg('删除成功！');
                        location.reload();
                    } else {
                        layer.msg(data.message);
                    }
                });
            });
        },
        paymentDel: function(orderId){
            layer.confirm("删除订单不能找回",function(){
                $.get("${ctx}/account/pickupOrder/paymentDel",{orderId,orderId},function(data){
                    if(data.result == "success"){
                        layer.msg("删除成功");
                        location.reload();
                    }else{
                        layer.msg(data.message);
                    }
                })
            })
        },
        repay: function(orderId){
            $.get('${ctx}/account/pickupOrder/repayJson',{'orderId':orderId},function(data){
                if(new Date(data.allowUseEndTime) < new Date()){
                    layer.alert("该提购券已过期，无法购买！")
                    return false;
                }
                data.orderPayAmt >data.userBalance? $('#balancePay').hide():$('#balancePay').show();
                payment(orderId);
            })
        },
        cancel: function(orderId){
            layer.prompt({title: '请输入取消原因', formType: 2}, function (text, index) {
                layer.close(index);
                $.get('${ctx}/account/pickupOrder/cancelPickOrder', {orderId: orderId, reason: text}, function (data) {
                    if (data.result == 'success') {
                        layer.msg('取消成功！');
                        location.reload();
                    } else {
                        layer.alert(data.message);
                    }
                });
            });
        }
    });

    vm.$watch('onReady',function(){
        $.get('${ctx}/account/pickupOrder/getAllCount',{},function(data){
            vm.count = data;
        });
        vm.loadList();
    });
    vm.$watch('type',function(){
        vm.pickOrderList = [];
        vm.pageNo = 1;
        vm.loadList();
    });
</script>
</body>
</html>
