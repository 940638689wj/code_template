<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>订单退货物流</title>
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
                    <span>填写退货物流</span>
                </div>
            </div>
            <div class="detail-hd">
                <h3>填写退货物流信息</h3>
                <p>
                    <span class="mr20">订单号：{{@orderHeaderDTO.orderNumber}}</span>
                    {{@orderHeaderDTO.createTime | date("yyyy-MM-dd HH:mm:ss")}}
                </p>
            </div>
            <div class="comment-content">
                <div class="comment-tiem">
                    <div class="fi-info">
                        <div class="comment-goods">
                            <div class="p-img"><a :attr="{href: '/product/' + @orderItem.productId}"><img
                                    :attr="{src: @orderItem.productPicUrl}"></a></div>
                            <p class="p-name"><a :attr="{href: '/product/' + @orderItem.productId}">{{@orderItem.productName}}</a>
                            </p>
                            <p class="p-price">¥{{@orderItem.salePrice}}</p>
                        </div>
                    </div>
                    <div class="fi-operate">
                        <div class="commentform return">
                            <ul>
                                <li>
                                    <div class="tit">退货地址：</div>
                                    <div class="con">{{@logistics.orderReturnAddress}}</div>
                                </li>
                                <li>
                                    <div class="tit">邮编：</div>
                                    <div class="con">{{@logistics.orderReturnPostcode}}</div>
                                </li>
                                <li>
                                    <div class="tit">收件人：</div>
                                    <div class="con">{{@logistics.orderReturnName}}</div>
                                </li>
                                <li>
                                    <div class="tit">联系电话：</div>
                                    <div class="con">{{@logistics.orderReturnPhone}}</div>
                                </li>
                                <li>
                                    <div class="tit">物流公司：</div>
                                    <div class="con"><input type="text" class="textfield" :duplex="@form.returnExpressName"></div>
                                </li>
                                <li>
                                    <div class="tit">快递单号：</div>
                                    <div class="con"><input type="text" class="textfield" :duplex="@form.returnExpressNum"></div>
                                </li>
                                <li>
                                    <div class="tit">备注：</div>
                                    <div class="con"><textarea :duplex="@form.returnExpressRemark"></textarea></div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="f-btnbox">
                <div class="f-btnbox-wrapin">
                    <a class="btn-submit" :click="submit">提交</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var vm = avalon.define({
        $id: 'app',
        orderId: ${orderId!},
        logistics: {},
        form: {
            orderItemId: ${orderItemId!},
            returnExpressName: '',
            returnExpressNum: '',
            returnExpressRemark: ''
        },
        // ---方法---
        // 提交物流信息
        submit: function () {
            if (!vm.form.returnExpressName) {
                layer.msg('物流公司不能为空')
                return false
            }
            if (!vm.form.returnExpressNum) {
                layer.msg('快递单号不能为空')
                return false
            }
            $.get('/orderHeader/submitLogistics', vm.form, function (data) {
                if (data) {
                    layer.msg("提交成功");
                    window.location.href = "/account/order/toDetail?orderId=" + vm.orderId;
                } else {
                    layer.msg("提交失败，请稍后重试");
                }
            }, 'json');

        }
    });

    vm.$watch('onReady', function () {
        // 获取订单详情
        $.get('/orderHeader/getLogistics', {}, function (data) {
            vm.logistics = data;
        }, 'json');
    });

</script>
</body>
</html>