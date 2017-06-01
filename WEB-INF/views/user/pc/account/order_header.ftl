<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>全部订单</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body class="page-login">
<div :controller="app" class="ms-controller">
<#include "../include/header.ftl"/>
    <div class="center-layout">
    <#include "../include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>订单中心<span><em>_</em>{{@orderTypeCd == 1 ? '普通订单' : '白鹭卡订单'}}</span></h3></div>
            <div class="corder-tab">
                <ul>
                    <li :for="($index,typeName) in @typeNameList" :class="{current: @type == $index}">
                        <a href="javascript:void(0)" :click="@type = $index">
                            {{typeName + "(" + @count["type" + $index] + ")"}}
                        </a>
                    </li>
                    <li :class="{current: @type == 7}" :if="@orderTypeCd == 1" style="float:right;">
                        <a href="javascript:void(0)" :click="@type = 7">
                            退换货订单({{@count.type7 ? @count.type7 : 0}})
                        </a>
                    </li>
                </ul>
            </div>
            <div class="center-list" :if="@orderHeaderDTOList.length > 0">
                <table class="orderdatatb orderdatatb2">
                    <thead>
                    <tr>
                        <td class="tal">商品信息</td>
                        <td class="td-amount">数量</td>
                        <td class="td-price">优惠</td>
                        <td class="td-total">商品金额</td>
                        <td class="td-status">状态</td>
                        <td class="td-operate">操作</td>
                    </tr>
                    </thead>
                </table>

                <div class="datawrap">
                    <table class="orderdatatb" :for="orderHeader in @orderHeaderDTOList">
                        <tbody>
                        <tr>
                            <th colspan="4" class="ordertb-hd">
                                <div class="order-num">订单号<em>{{orderHeader.orderNumber}}</em></div>
                                <div class="order-time">
                                    下单时间
                                    <em>{{orderHeader.createTime | date("yyyy-MM-dd HH:mm:ss")}}</em>
                                </div>
                            </th>
                        </tr>
                        <tr>
                            <td>
                                <table class="datatb-l">
                                    <tbody>
                                    <tr :for="orderItem in orderHeader.orderItemList">
                                        <td class="td-product">
                                            <div class="first-column">
                                                <div class="img">
                                                    <a :attr="{href: '/product/' + orderItem.productId}"
                                                       target="_blank">
                                                        <img :attr="{src: orderItem.productPicUrl}">
                                                    </a>
                                                </div>
                                                <div class="info">
                                                    <div class="name">
                                                        <a :attr="{href: '/product/' + orderItem.productId}"
                                                           target="_blank">
                                                            {{orderItem.productName}}
                                                        </a>
                                                    </div>
                                                    <div class="prop">
                                                        {{orderItem.skuKeyJsonStr}}
                                                    </div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="td-amount">{{orderItem.quantity}}</td>
                                        <td class="td-price">---</td>
                                        <td class="td-total"><span class="price-real">￥{{orderItem.salePrice}}</span>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </td>
                            <td class="td-status">{{orderHeader.orderStatusName}}</td>
                            <td class="td-operate">
                                <div :if="@orderHeader.type == 1">
                                    <a href="javascript:void(0)" class="v-btn"
                                       :click="selectOrderId = orderHeader.orderId">付款</a>
                                    <a href="javascript:void(0)" class="v-button"
                                       :click="cancelOrder(orderHeader.orderId)">取消订单</a>
                                </div>
                                <div :if="@orderHeader.type == 3">
                                    <a href="javascript:void(0)" class="v-btn"
                                       :click="confirmReceive(orderHeader.orderId)">确认收货</a>
                                </div>
                                <div :if="@orderHeader.type == 4">
                                    <a :attr="{href: '/account/order/toReview?orderId=' + orderHeader.orderId}" class="v-btn">评价</a>
                                </div>
                                <div :if="@orderHeader.type == 6">
                                    <a href="javascript:void(0)" class="v-btn"
                                       :click="delOrder(orderHeader.orderId)">删除订单</a>
                                </div>
                                <p><a :attr="{href: '/account/order/toDetail?orderId=' + orderHeader.orderId}">查看详情</a>
                                </p>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>

            </div>

        <#--分页控件-->
            <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        <#--支付弹窗-->
            <wbr :widget="{ is: 'ms-payDialog', orderId: @selectOrderId, clearOrderId: @clearOrderId}">

            <#--<wbr :widget="{ is: 'ms-addressSelect'}">-->

        </div>
    </div>
</div>
<#include "../include/pager.ftl"/>
<#include "../include/payDialog.ftl"/>
<#--<#include "include/addressSelect.ftl"/>-->
<script>
    var vm = avalon.define({
        $id: 'app',
        // ---数据---
        selectOrderId: 0,
        orderTypeCd: ${orderTypeCd!},
        type: ${type!0}, // 订单类型
        typeNameList: ['全部订单', '待付款', '待发货', '待收货', '待评价', '已完成', '已取消'], // 类型列表
        count: {type0: 0, type1: 0, type2: 0, type3: 0, type4: 0, type5: 0, type6: 0},
        pageNo: 1,
        pageSize: 5,
        orderHeaderDTOList: [],
        $computed: {
            pageCount: function () {
                return this.count["type" + this.type];
            }
        },
        // ---方法---
        // 获取所有类型的数量
        getAllCount: function () {
            $.get('/orderHeader/getAllCount', {
                orderTypeCd: vm.orderTypeCd
            }, function (data) {
                vm.count = data;
            });
        },
        // 加载分页数据
        loadList: function (pageNo) {
            if (pageNo != null) {
                this.pageNo = pageNo;
            }
            if(vm.type != 7) {
                $.get('/orderHeader/findListByLimit', {
                    pageNo: vm.pageNo,
                    pageSize: vm.pageSize,
                    orderTypeCd: vm.orderTypeCd,
                    type: vm.type
                }, function (data) {
                    vm.orderHeaderDTOList = data.orderHeaderDTOList;
                });
            } else {
                $.get('/orderHeader/findListByLimit', {
                    pageNo: vm.pageNo,
                    pageSize: vm.pageSize,
                    orderTypeCd: vm.orderTypeCd,
                    orderPropertyCd: 1
                }, function (data) {
                    vm.orderHeaderDTOList = data.orderHeaderDTOList;
                });
            }
        },
        // 支付窗口 组件回调 清空selectOrderId
        clearOrderId: function () {
            this.selectOrderId = 0;
        },
        // 取消订单
        cancelOrder: function (orderId) {
            layer.confirm('确认取消该订单？', {
                btn: ['确认', '退出'] //按钮
            }, function () {
                $.post('/orderHeader/cancelOrderHeader', {
                    orderId: orderId
                }, function (data) {
                    if (data.result == 'success') {
                        vm.pageNo = 1;
                        vm.loadList();
                        vm.getAllCount();
                        layer.msg('取消成功');
                    }
                }, 'json');
            }, function () {
            });
        },
        // 确认收货
        confirmReceive: function (orderId) {
            layer.confirm('确认收货？', {
                btn: ['确认', '退出'] //按钮
            }, function () {
                $.post('/orderHeader/confirmReceive', {
                    orderId: orderId
                }, function (data) {
                    if (data.result == 'success') {
                        vm.pageNo = 1;
                        vm.loadList();
                        vm.getAllCount();
                        layer.msg('确认收货成功');
                    } else {
                        layer.msg(data.message)
                    }
                }, 'json');
            }, function () {
            });
        },
        // 删除订单
        delOrder: function (orderId) {
            layer.confirm('删除订单？', {
                btn: ['确认', '退出'] //按钮
            }, function () {
                $.post('/orderHeader/delOrderHeader', {
                    orderId: orderId
                }, function (data) {
                    if (data.result == 'success') {
                        vm.pageNo = 1;
                        vm.loadList();
                        vm.getAllCount();
                        layer.msg('删除成功');
                    }
                }, 'json');
            }, function () {
            });
        }
    });

    // 初始化 回调
    vm.$watch('onReady', function () {
        // 查询所有类型总数
        vm.getAllCount();
        vm.loadList();
    });

    //修改订单类型 回调
    vm.$watch('type', function () {
        vm.orderHeaderDTOList = [];
        vm.pageNo = 1;
        vm.loadList();
    });
</script>
</body>
</html>