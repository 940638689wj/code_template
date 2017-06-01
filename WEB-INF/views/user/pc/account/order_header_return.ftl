<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>订单退款</title>
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
                    <span>退款退货</span>
                </div>
            </div>
            <div class="detail-hd">
                <h3>申请退换货</h3>
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
                                    <div class="tit">申请类型：</div>
                                    <div class="con">
                                        <select :duplex="@form.applyTypeCd">
                                            <option value="1">仅退款</option>
                                            <option value="2" :if="@orderHeaderDTO.type == 3">退货退款</option>
                                        </select>
                                    </div>
                                </li>
                                <li>
                                    <div class="tit">是否收到货：</div>
                                    <div class="con">
                                        <label for="radio1">
                                            <input type="radio" name="radio" value="0" :duplex="@form.isReceiveGood">&nbsp;未收到货
                                        </label>
                                        <label for="radio2">
                                            <input type="radio" name="radio" value="1" :duplex="@form.isReceiveGood">&nbsp;已收到货
                                        </label>
                                    </div>
                                </li>
                                <li :if="@orderHeaderDTO.type == 3">
                                    <div class="tit">需要退款金额：</div>
                                    <div class="con">
                                        <input type="number" class="textfield input-short" :duplex="@form.returnAmt"
                                               :change="limitMaxReturnAmt()">
                                        元 (最多<span class="red">{{@maxReturnAmt}}</span>元)
                                        <span :if="@orderItem.payScoreAmt">(消耗积分{{orderItem.payScoreAmt}})</span>
                                        <span :if="@orderItem.payXmairCardAmt">(消耗白鹭卡积分{{orderItem.payXmairCardAmt}})</span>
                                    </div>
                                </li>
                                <li :if="@orderHeaderDTO.type == 2">
                                    <div class="tit">需要退款金额：</div>
                                    <div class="con">
                                        <span class="red">￥{{@maxReturnAmt}}</span>
                                        <span :if="@orderItem.payScoreAmt">(消耗积分{{orderItem.payScoreAmt}})</span>
                                        <span :if="@orderItem.payXmairCardAmt">(消耗白鹭卡积分{{orderItem.payXmairCardAmt}})</span>
                                    </div>
                                </li>
                                <li>
                                    <div class="tit">退款原因：</div>
                                    <div class="con">
                                        <select :duplex="@form.applyReasonCd">
                                            <option :for="orderReturnReason in @orderReturnReasonList"
                                                    :attr="{value: orderReturnReason.codeId}">
                                                {{orderReturnReason.codeCnName}}
                                            </option>
                                        </select>
                                    </div>
                                </li>
                                <li>
                                    <div class="tit">退款说明：</div>
                                    <div class="con"><textarea :duplex="@form.reasonDetailDesc"></textarea></div>
                                </li>
                                <li>
                                    <div class="tit">上传凭证：</div>
                                    <wbr :widget="{ is: 'ms-uploadImg', updatePicUrl: @updatePicUrl, index: $index}">
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
<#include "../include/uploadImg.ftl"/>
<script>
    var vm = avalon.define({
        $id: 'app',
        orderHeaderDTO: {}, // 订单信息
        orderReturnReasonList: [], // 退款原因列表
        orderItem: {},
        // 退款提交表单
        form: {
            orderId: ${orderId!},
            orderItemId: ${orderItemId!},  // 退款商品的itemId
            applyTypeCd: 1, // 退换类型 1：退款 2：退款退货
            isReceiveGood: 0, // 是否收到货 0：未收到 1：已收到
            returnAmt: '',
            applyReasonCd: -1,
            reasonDetailDesc: '',  // 退款描述
            picUrlList: []  // 图片url
        },
        maxReturnAmt: 0,
        $computed: {
            // 是否发货
            isDelivery: function () {
                if (this.orderHeaderDTO.type === 2) {
                    return false;
                }
                return true;
            }
        },
        // ---方法---
        // 限制退款金额的输入上限
        limitMaxReturnAmt: function () {
            if (parseFloat(vm.form.returnAmt) > parseFloat(vm.maxReturnAmt)) {
                vm.form.returnAmt = vm.maxReturnAmt;
            }
        },
        // 更新图片url列表
        updatePicUrl: function (picUrlList) {
            this.form.picUrlList = picUrlList
        },
        // 提交退款信息
        submit: function () {
            if (this.form.returnAmt == null) {
                layer.msg('请输入退款金额');
                return false;
            }
            $.ajax({
                type: "POST",
                url: "/orderHeader/returnOrderHeader",
                data: JSON.stringify(vm.form),//将对象序列化成JSON字符串
                dataType: "json",
                contentType: 'application/json;charset=utf-8', //设置请求头信息
                success: function (data) {
                    if (data.result == 'success') {
                        layer.msg("提交成功");
                        window.location.replace('/account/order/toDetail?orderId=' + vm.form.orderId);
                    } else {
                        layer.msg(data.message);
                    }
                }
            })
        }
    });

    vm.$watch('onReady', function () {
        // 获取订单详情
        $.get('/orderHeader/orderHeaderDetail', {
            orderId: vm.form.orderId
        }, function (data) {
            vm.orderHeaderDTO = data.orderHeaderDTO;
            vm.orderReturnReasonList = data.orderReturnReasonList;
            vm.form.applyReasonCd = data.orderReturnReasonList[0].codeId;
            // 计算退款金额
            if (vm.orderHeaderDTO.orderItemList) {
                var orderItemList = vm.orderHeaderDTO.orderItemList;
                for (var i = 0; i < orderItemList.length; i++) {
                    if (orderItemList[i].orderItemId == vm.form.orderItemId) {
                        vm.orderItem = orderItemList[i];
                        vm.maxReturnAmt = (orderItemList[i].payCashAmt * orderItemList[i].quantity).toFixed(2);
                        if (!vm.maxReturnAmt) {
                            vm.maxReturnAmt = 0;
                        }
                    }
                }
            }
            // 未发货的定死退款金额
            if (vm.orderHeaderDTO.type === 2) {
                vm.form.returnAmt = parseFloat(vm.maxReturnAmt);
            }
        }, 'json');

    });

    //    vm.$watch('form.returnAmt', function (val) {
    //
    //    })
</script>
</body>
</html>