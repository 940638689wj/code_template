<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>订单退款详情</title>
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body>
<#include "../include/header.ftl"/>
<div :controller="app" class="ms-controller">
    <div class="center-layout">
        <div class="comment-detail">
            <div class="crumbWrap">
                <div class="crumb">
                    <span class="t">您的位置：</span>
                    <a class="c" href="/">首页</a>
                    <span class="divide">&gt;</span>
                    <a class="c" href="/account">个人中心</a>
                    <span class="divide">&gt;</span>
                    <a class="c" href="/account/order?orderTypeCd=1">普通订单</a>
                    <span class="divide">&gt;</span>
                    <a class="c" :attr="{href: '/account/order/toDetail?orderId=' + @form.orderId}">订单详情</a>
                    <span class="divide">&gt;</span>
                    <span>退款/退货详情</span>
                </div>
            </div>
            <div class="detail-hd">
                <h3>申请退换货详情</h3>
                <p>
                    <span class="mr20">订单号：{{@orderHeaderDTO.orderNumber}}</span>
                    {{@orderHeaderDTO.createTime | date("yyyy-MM-dd HH:mm:ss")}}
                </p>
            </div>
            <div class="comment-content">
                <div class="comment-tiem">
                    <div class="fi-info">
                        <div class="comment-goods">
                            <div class="p-img"><a :attr="{href: '/product/' + @orderItem.productId}"><img :attr="{src: @orderItem.productPicUrl}"></a></div>
                            <p class="p-name"><a :attr="{href: '/product/' + @orderItem.productId}">{{@orderItem.productName}}</a></p>
                            <p class="p-price">¥{{@orderItem.salePrice}}</p>
                        </div>
                    </div>
                    <div class="fi-operate">
                        <div class="commentform return">
                            <ul>
                                <li>
                                    <div class="tit">退款类型：</div>
                                    <div class="con">{{@orderReturnInfo.applyTypeName}}</div>
                                </li>
                                <li>
                                    <div class="tit">退款金额：</div>
                                    <div class="con">{{@orderReturnInfo.returnAmt}}</div>
                                </li>
                                <li>
                                    <div class="tit">原因：</div>
                                    <div class="con">{{@orderReturnInfo.applyReasonName}}</div>
                                </li>
                                <li>
                                    <div class="tit">备注：</div>
                                    <div class="con">{{@orderReturnInfo.reasonDetailDesc}}</div>
                                </li>
                                <li>
                                    <div class="tit">当前状态：</div>
                                    <div class="con">{{@orderReturnInfo.applyStatusName}}</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="f-btnbox">
                <div class="f-btnbox-wrapin">
                    <a class="btn-submit" :attr="{href: '/account/order/toDetail?orderId=' + @orderItem.orderId}">返回订单详情</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var vm = avalon.define({
        $id: 'app',
        orderItemId: ${orderItemId!},
        orderItem: {},
        orderReturnInfo: {},
        // ---方法---
    });

    vm.$watch('onReady', function () {
        // 获取订单详情
        $.get('/orderHeader/getOrderReturnDetail', {
            orderItemId: vm.orderItemId
        }, function (data) {
            vm.orderItem = data.orderItem;
            vm.orderReturnInfo = data.orderReturnInfo;
        }, 'json');

    });

</script>
</body>
</html>