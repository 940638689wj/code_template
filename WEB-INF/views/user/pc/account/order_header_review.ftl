<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <meta charset="UTF-8">
    <title>订单评价</title>
    <script src="/static/js/jquery.raty.min.js"></script>
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
        <div class="crumbWrap">
            <div class="crumb">
                <span class="t">您的位置：</span>
                <a class="c" href="/">首页</a>
                <span class="divide">&gt;</span>
                <a class="c" href="/account">个人中心</a>
                <span class="divide">&gt;</span>
                <a class="c" href="/account/order?orderTypeCd=1">普通订单</a>
                <span class="divide">&gt;</span>
                <span>评价订单</span>
            </div>
        </div>
        <div class="comment-detail">
            <div class="detail-hd">
                <h3>评价订单</h3>
                <p>
                    <span class="mr20">订单号：{{@orderHeaderDTO.orderNumber}}</span>
                    {{@orderHeaderDTO.createTime | date("yyyy-MM-dd HH:mm:ss")}}
                </p>
            </div>
            <div class="comment-content">
                <div class="comment-tiem" :for="($index, orderItem) in @orderHeaderDTO.orderItemList">
                    <div class="fi-info">
                        <div class="comment-goods">
                            <div class="p-img">
                                <a :attr="{href: '/product/' + orderItem.productId}" target="_blank">
                                    <img :attr="{src: orderItem.productPicUrl}">
                                </a>
                            </div>
                            <p class="p-name">
                                <a :attr="{href: '/product/' + orderItem.productId}" target="_blank">
                                    {{orderItem.productName}}
                                </a>
                            </p>
                            <p class="p-price">¥{{orderItem.salePrice}}</p>
                        </div>
                    </div>
                    <div class="fi-operate">
                        <div class="commentform">
                            <ul>
                                <li>
                                    <div class="tit">评价得分：</div>
                                    <div class="con"><span class="ratestar"></span></div>
                                </li>
                                <li>
                                    <div class="tit">评价内容：</div>
                                    <div class="con"><textarea
                                            :duplex="@reviewInfoList[$index].reviewContent"></textarea></div>
                                </li>
                                <li>
                                    <wbr :widget="{ is: 'ms-uploadImg', updatePicUrl: @updatePicUrl, index: $index}">
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="f-btnbox">
                <div class="f-btnbox-wrapin">
                    <a class="btn-submit" :click="submitReview">提交</a>
                </div>
            </div>
        </div>
    </div>
</div>
<#include "../include/uploadImg.ftl"/>
<script>
    var vm = avalon.define({
        $id: 'app',
        orderId: ${orderId!},
        orderHeaderDTO: {}, // 订单信息
        reviewInfoList: [], // 评价信息
        // ---方法---
        // 初始化星级评分插件
        initRaty: function () {
            $.fn.raty.defaults.path = '/static/images';
            $('.ratestar').raty({
                number: 5,//多少个星星设置
                score: 0,//初始值是设置
                targetType: 'number',
                size: 20,
                //		half      : true,
                starHalf: 'star-half.png',
                starOff: 'star-off.png',
                starOn: 'star-on.png',
                cancel: false,
                targetKeep: true,
                precision: false,
                click: function (score) {
                    // 更新评分
                    $('input[name=score]').each(function (index) {
                        vm.reviewInfoList[index].productMatchScore = $(this).val();
                    });
                }
            });

            var win = $(window),
                    fbtinbox = $(".f-btnbox"),
                    commentFoot = $(".f-btnbox-wrapin"),
                    fbtinboxHeight = commentFoot.outerHeight();
            win.on("scroll", function () {
                var footTop = fbtinbox.offset().top,
                        t = win.scrollTop() + win.height() - fbtinboxHeight;
                if (t < footTop) {
                    commentFoot.addClass("fixed");
                } else {
                    commentFoot.removeClass("fixed");
                }
            });
        },
        // 更新图片url
        updatePicUrl: function (picUrlList, index) {
            this.reviewInfoList[index].productReviewPicInfos = [];
            for (var i = 0; i < picUrlList.length; i++) {
                this.reviewInfoList[index].productReviewPicInfos.push({
                    picUrl: picUrlList[i]
                });
            }
        },
        // 提交评论
        submitReview: function () {
            var obj = this;
            var flag = true;
            for (var i = 0; i < obj.reviewInfoList.length; i++) {
                if (obj.reviewInfoList[i].productMatchScore == '0') {
                    layer.msg('评分不能为空');
                    flag = false;
                    return false;
                }
            }

            if (flag) {
                // 构造参数
                var param = {
                    orderId: obj.orderId,
                    productReviewList: obj.reviewInfoList
                };
                // 发送提交请求
                $.ajax({
                    type: "POST",
                    url: "/orderHeader/saveReview",
                    data: JSON.stringify(param),//将对象序列化成JSON字符串
                    dataType: "json",
                    contentType: 'application/json;charset=utf-8', //设置请求头信息
                    success: function (data) {
                        if (data && data.result == "success") {
                            layer.msg("评价成功！");
                            window.location.href = "/account/order/toDetail?orderId=" + obj.orderId;
                        } else {
                            layer.msg("不可重复评价");
                        }
                    }
                });

            }
        }
    });

    vm.$watch('onReady', function () {
        // 获取订单详情数据
        $.get('/orderHeader/orderHeaderDetail', {
            orderId: vm.orderId
        }, function (data) {
            vm.orderHeaderDTO = data.orderHeaderDTO;
            var orderItemList = data.orderHeaderDTO.orderItemList;
            for (var i = 0; i < orderItemList.length; i++) {
                vm.reviewInfoList.push({
                    productId: orderItemList[i].productId,
                    productMatchScore: '0',
                    reviewContent: '',
                    productReviewPicInfos: []
                });
            }
            vm.initRaty();
        }, 'json');

    });

</script>
</body>
</html>