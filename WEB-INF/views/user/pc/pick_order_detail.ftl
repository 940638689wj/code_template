<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>提货订单详情</title>
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body class="page-login">
<#include "include/header.ftl"/>
<div :controller="app" class="ms-controller">
    <div class="center-layout">
        <div class="crumbWrap">
            <div class="crumb">
                <span class="t">您的位置：</span>
                <a class="c" href="/">首页</a>
                <span class="divide">&gt;</span>
                <a class="c" href="/account">个人中心</a>
                <span class="divide">&gt;</span>
                <a class="c" href="${ctx}/account/pickupOrder/list">提货订单</a>
                <span class="divide">&gt;</span>
                <span>订单详情</span>
            </div>
        </div>
        <div class="order-state">
            <div class="state-lcol">
                <div class="state-top">订单号：{{@orderHeaderDTO.orderNumber}}</div>
                <h3 class="state-txt">{{@orderHeaderDTO.orderStatusName}}</h3>
                <div :if="@orderHeaderDTO.orderStatusCd ==  1">
                    <div class="state-btns">
                        <a href="javascript:void(0);" class="v-btn" :click="@selectOrderId = @orderId">付款</a>
                    </div>
                    <div class="state-btns">
                        <a href="javascript:void(0);" class="v-button" :click="cancelOrder">取消</a>
                    </div>
                </div>
                <div :if="@orderHeaderDTO.orderStatusCd ==  3 && @orderHeaderDTO.orderDistrbuteTypeCd == 1">
                    <div class="state-btns">
                        <a href="javascript:void(0);" class="v-btn" :click="confirmReceive">确认收货</a>
                    </div>
                </div>

            </div>
            <div class="state-rcol">
                <div class="order-process order-presale">
                    <div :class="{node: true, ready: orderHeaderDTO.type != 6}">
                        <i class="node-icon icon-start"></i>
                        <ul>
                            <li class="txt1">&nbsp;</li>
                            <li class="txt2">提交订单</li>
                        </ul>
                    </div>
                    <div :if="orderHeaderDTO.type != 6">
                        <div :class="{proce: true,done: orderHeaderDTO.type >= 2}"></div>
                        <div :class="{node: true,ready: orderHeaderDTO.type >= 2}">
                            <i class="node-icon icon-pay"></i>
                            <ul>
                                <li class="txt1">&nbsp;</li>
                                <li class="txt2">付款成功</li>
                            </ul>
                        </div>
                        <div :class="{proce: true,done: orderHeaderDTO.type >= 3}"></div>
                        <div :class="{node: true,ready: orderHeaderDTO.type >= 3}">
                            <i class="node-icon icon-express"></i>
                            <ul>
                                <li class="txt1">&nbsp;</li>
                                <li class="txt2">等待收货</li>
                            </ul>
                        </div>
                        <#--
                        <div :class="{proce: true,done: orderHeaderDTO.type >= 4}"></div>
                        <div :class="{node: true,ready: orderHeaderDTO.type >= 4}">
                            <i class="node-icon icon-evaluate"></i>
                            <ul>
                                <li class="txt1">&nbsp;</li>
                                <li class="txt2">评价</li>
                            </ul>
                        </div>
                        -->
                        <div :class="{proce: true,done: orderHeaderDTO.type == 5}"></div>
                        <div :class="{node: true,ready: orderHeaderDTO.type == 5}">
                            <i class="node-icon icon-finish"></i>
                            <ul>
                                <li class="txt1">&nbsp;</li>
                                <li class="txt2">完成</li>
                            </ul>
                        </div>
                    </div>
                    <div :if="orderHeaderDTO.type == 6">
                        <div class="proce"></div>
                        <div class="node">
                            <i class="node-icon icon-finish"></i>
                            <ul>
                                <li class="txt1">&nbsp;</li>
                                <li class="txt2">取消</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="order-info-mod">
            <div class="dl">
                <div class="dt">订单信息</div>
                <div class="dd">
                    <p><span>订单号：</span><em>{{@orderHeaderDTO.orderNumber}}</em></p>
                    <p><span>付款方式：</span><em>{{@orderHeaderDTO.orderPayModeName}}</em></p>
                    <p><span>支付状态：</span><em>{{orderHeaderDTO.orderPayTime ? "已支付" : "未支付"}}</em></p>
                    <p><span>买家备注：</span><em>{{orderHeaderDTO.orderRemark}}</em></p>
                </div>
            </div>
            <div class="dl" :if="@orderReceiveInfo.orderDistrbuteTypeCd == 1">
                <div class="dt">收货人信息</div>
                <div class="dd">
                    <p><span>收货人：</span><em>{{@orderReceiveInfo.receiveName}}</em></p>
                    <p><span>地址：</span><em>{{@orderReceiveInfo.receiveAddrCombo}}</em></p>
                    <p><span>手机号码：</span><em>{{@orderReceiveInfo.receiveTel}}</em></p>
                    <p><span>配送方式：</span>
                        <em>{{@orderReceiveInfo.orderDistrbuteTypeCd == 1 ? @orderHeaderDTO.expressName : '门店自提'}}</em>
                    </p>
                    <p><span>运费：</span><em>¥{{@orderHeaderDTO.orderExpressAmt}}</em></p>
                </div>
            </div>
            <div class="dl" :if="@orderReceiveInfo.orderDistrbuteTypeCd == 2">
                <div class="dt">自提信息</div>
                <div class="dd">
                    <p><span>自提时间：</span><em>{{@orderReceiveInfo.requiredStartTime | date("yyyy-MM-dd HH:mm:ss")}}
                        至 {{@orderReceiveInfo.requiredEndTime | date("yyyy-MM-dd HH:mm:ss")}}</em></p>
                    <p><span>自提门店：</span><em>{{@orderHeaderDTO.storeName}}</em></p>
                </div>
            </div>
            <div class="dl">
                <div class="dt">付款信息</div>
                <div class="dd">
                    <p><span>付款方式：</span><em>{{@orderHeaderDTO.orderPayModeName}}</em></p>
                    <p><span>付款时间：</span><em>{{@orderHeaderDTO.createTime | date("yyyy-MM-dd HH:mm:ss")}}</em></p>
                    <p><span>商品总额：</span><em>¥{{@orderHeaderDTO.orderProductAmt}}</em></p>
                    <p><span>应支付金额：</span><em>¥{{@orderHeaderDTO.orderTotalAmt.toFixed(2)}}</em></p>
                    <p><span>订单折扣：</span><em>¥{{@orderHeaderDTO.orderDiscountAmt}}</em></p>
                    <p>
                        <span>实付金额：</span>
                        <em>¥{{(@orderHeaderDTO.orderPayAmt + @orderHeaderDTO.payBalance).toFixed(2)}}</em>
                    </p>
                </div>
            </div>
            <div class="dl">
                <div class="dt">发票信息</div>
                <div class="dd">
                    <p><span>发票类型：</span><em>{{@orderReceiveInfo.invoiceTypeName}}</em></p>
                    <p><span>发票抬头：</span><em>{{@orderReceiveInfo.invoiceForName}}</em></p>
                    <p><span>发票内容：</span><em>{{@orderReceiveInfo.invoiceTitle}}</em></p>
                </div>
            </div>
        </div>
        <div class="order-goods">
            <table class="datatb">
                <thead>
                <tr>
                    <th class="tal">商品</th>
                    <th class="col-2">商品单价</th>
                    <th class="col-1">数量</th>
                    <th class="col-1">优惠</th>
                    <th class="col-1">小计</th>
                    <th class="col-1">操作</th>
                </tr>
                </thead>
                <tbody>
                <tr :for="orderItem in @orderHeaderDTO.orderItemList">
                    <td>
                        <div class="first-column">
                            <div class="img">
                                <a :attr="{href: '/product/' + orderItem.productId}" target="_blank">
                                    <img :attr="{src: orderItem.productPicUrl}">
                                </a>
                            </div>
                            <div class="info">
                                <div class="name">
                                    <a :attr="{href: '/product/' + orderItem.productId}" target="_blank">{{orderItem.productName}}</a>
                                </div>
                                <div class="prop">{{orderItem.skuKeyJsonStr}}</div>
                            </div>
                        </div>
                    </td>
                    <td>¥{{orderItem.salePrice}}</td>
                    <td>{{orderItem.quantity}}</td>
                    <td>--</td>
                    <td><span class="text-red">¥{{orderItem.productTotal}}</span></td>
                    <td>
                        <!--
                        <div :if="orderHeaderDTO.type == 2 || orderHeaderDTO.type == 3">
                            <a href="#" class="v-button" :if="!orderItem.applyStatusCd">退款/退货</a>
                            <a href="#" class="v-button" :if="orderItem.applyStatusCd">退款/退货状态：{{orderItem.applyStatusName}}</a>
                        </div>
                        -->
                    </td>
                </tr>
                </tbody>
            </table>
            <div class="goods-total">
                <ul>
                    <li>
                        <span class="label">商品总额：</span>
                        <span class="txt">¥{{@orderHeaderDTO.orderProductAmt}}</span>
                    </li>
                    <li>
                        <span class="label">运　　费：</span>
                        <span class="txt">¥{{@orderHeaderDTO.orderExpressAmt}}</span>
                    </li>
                    <li>
                        <span class="label">应付金额：</span>
                        <span class="txt">¥{{@orderHeaderDTO.orderTotalAmt}}</span>
                    </li>
                    <li>
                        <span class="label">订单折扣：</span>
                        <span class="txt">-¥{{@orderHeaderDTO.orderDiscountAmt}}</span>
                    </li>
                    <li class="text-red">
                        <span class="label">实付金额：</span>
                        <span class="txt count">¥{{(@orderHeaderDTO.orderPayAmt + @orderHeaderDTO.payBalance).toFixed(2)}}</span>
                    </li>
                </ul>
            </div>
        </div>
    </div>

<#--支付弹窗-->
    <wbr :widget="{ is: 'ms-payDialog', orderId: @selectOrderId, clearOrderId: @clearOrderId}">
</div>
<#include "include/payDialog.ftl"/>
<script>
    var vm = avalon.define({
        $id: 'app',
        orderId: ${orderId!},
        orderHeaderDTO: {}, // 订单信息
        orderReceiveInfo: {}, // 收货人信息
        selectOrderId: 0,
        // ---方法---
        // 加载订单数据
        loadData: function () {
            $.get('/orderHeader/orderHeaderDetail', {
                orderId: vm.orderId
            }, function (data) {
                vm.orderHeaderDTO = data.orderHeaderDTO;
                vm.orderReceiveInfo = data.orderReceiveInfo;
            }, 'json');
        },
        // 取消订单
        cancel: function(orderId){
            layer.prompt({title: '请输入取消原因', formType: 2}, function (text, index) {
                layer.close(index);
                $.get('${ctx}/account/pickupOrder/cancelPickOrder', {orderId: orderId, reason: text}, function (data) {
                    if (data.result == 'success') {
                        layer.msg('取消成功！');
                        vm.loadData();
                    } else {
                        layer.alert(data.message);
                    }
                });
            });
        },
        // 确认收货
        confirmReceive: function(orderId){

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
        // 删除订单
        delOrder: function () {
            layer.confirm('删除订单？', {
                btn: ['确认', '退出'] //按钮
            }, function () {
                $.post('/orderHeader/delOrderHeader', {
                    orderId: vm.orderId
                }, function (data) {
                    if (data.result == 'success') {
                        vm.loadData();
                        layer.msg('删除成功');
                    }
                }, 'json');
            }, function () {
            });
        },
        // 支付窗口 组件回调 清空selectOrderId
        clearOrderId: function () {
            this.selectOrderId = 0;
        },
    });

    vm.$watch('onReady', function () {
        vm.loadData();
    });
</script>
</body>
</html>