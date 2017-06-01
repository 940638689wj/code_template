<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html>
<head>
	<title>个人中心</title>
</head>

<body class="page-list">
<div :controller="app" class="ms-controller">
<#include "include/header.ftl"/>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
<div id="header">
    <div class="center-layout">
        <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="center-pro-wrap">
                <div class="center-property">
                    <h3>可用金额</h3>
                    <div class="v-cash">
                        <p class="v-much"><span>${userConsumeCalc.userBalance!0}</span>元</p>
                        <a class="v-btn" href="javascript:businessIsActive()">充值</a>
                    </div>
                    <div class="v-grade">${(user.userLevelName)!}</div>
                </div>
                <div class="privileges">
                    <ul>
                        <li>
                            <a href="${ctx}/account/userPromotion/toRedPacket"> <span class="coupons-bg"></span></a>
                            <h3>红包</h3>
                            <p><em>${redCount!0}</em>个</p>

                        </li>
                        <li>
                            <a href="${ctx}/account/userPromotion/toCoupon"><span class="coupons-bg"></span></a>
                            <h3>优惠券</h3>
                            <p><em>${couponCount!0}</em>张</p>
                        </li>
                        <li>
                            <a href="${ctx}/account/pickup"><span class="delivery-bg"></span></a>
                            <h3>提货券</h3>
                            <p><em>${pickCount!0}</em>张</p>
                        </li>
                        <li>
                            <a href="${ctx}/account/group"><span class="group-bg"></span></a>
                            <h3>团购券</h3>
                            <p><em>${groupCount!0}</em>张</p>
                        </li>
                        <li>
                            <a href="${ctx}/account/userScoreDetail"><span class="integral-bg"></span></a>
                            <h3>积分</h3>
                            <p><em>${userConsumeCalc.totalScore!0}</em></p>
                        </li>
                        <#if user?? && user.mStoreStatusCd?has_content && user.mStoreStatusCd == 1>
                        <li>
                            <a href="${ctx}/account/myCustomer"><span class="achievement-bg"></span></a>
                            <h3>业绩点</h3>
                            <p><em>${userConsumeCalc.userProductPoint!0}</em></p>
                        </li>
                        </#if>

                    </ul>
                </div>
            </div>

            <div class="orderclass">
                <#--
                <ul>
                    <li><span>商城订单</span><p><a href="#">待付款<em>(1)</em></a><a href="#">待发货<em>(1)</em></a><a href="#">待收货<em>(1)</em></a><a href="#">待评价<em>(1)</em></a><a href="#">退款退货<em>(1)</em></a></p></li>
                    <li><span>提货券订单</span><p><a href="#">待付款<em>(1)</em></a><a href="#">待发货<em>(1)</em></a><a href="#">待收货<em>(1)</em></a><a href="#">待评价<em>(1)</em></a></p></li>
                    <li><span>团购订单</span><p><a href="#">待付款<em>(1)</em></a><a href="#">待评价<em>(1)</em></a><a href="#">退款退货<em>(1)</em></a></p></li>
                </ul>
                -->
            </div>


            <div class="center-list">
                <h3><a href="${ctx}/account/order?orderTypeCd=1">查看全部订单&gt;</a>最近订单</h3>
                <table class="orderdatatb orderdatatb2">
                    <thead>
                    <tr>
                        <td class="tal">商品信息</td>
                        <td class="td-price">金额</td>
                        <td class="td-amount">数量</td>
                        <td class="td-price">优惠</td>
                        <td class="td-total">实付金额</td>
                        <td class="td-status">状态</td>
                        <td class="td-operate">操作</td>
                    </tr>
                    </thead>
                </table>

                <div class="datawrap">
                    <table class="orderdatatb">
                        <tbody :if="@orderHeaderDTOList.length > 0" :for="orderHeader in @orderHeaderDTOList">
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
                                        <td class="td-price">￥{{orderItem.salePrice}}</td>
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
                        <tbody class="orderdatatb" :if="@orderHeaderDTOList.length == 0">
                        <tr>
                            <td colspan="4" class="nodata">
                                近期都没有订单，赶快<a href="${ctx}/products/0.html" class="red">去购物</a>吧！
                            </td>
                        </tr>
                        </tbody>
                    </table>

                </div>
            </div>
            <wbr :widget="{ is: 'ms-payDialog', orderId: @selectOrderId, clearOrderId: @clearOrderId}">
            <div class="center-list">
                <h3>猜你喜欢</h3>
                <div class="section">
                    <ul>
                       <#list hotProductList as hotProduct>
                        <#if (hotProduct_index < 4)>
                            <li>
                                <div class="pic"><a href="${ctx}/product/${hotProduct.productId!}/"><img src="${hotProduct.picUrl!}"/></a></div>
                                <p class="name"><a href="${ctx}/product/${hotProduct.productId!}/">${hotProduct.productName!}</a></p>
                                <p class="money">
                                    <span>￥<strong>${hotProduct.defaultPrice!}</strong></span>
                                    <del>￥${hotProduct.tagPrice!}</del>
                                </p>
                            </li>
                        </#if>
                    </#list>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
</div>
<#include "include/payDialog.ftl"/>
<script>
    var vm = avalon.define({
        $id: 'app',
        selectOrderId:0,
        orderTypeCd:1,
        type:0,
        pageNo: 1,
        pageSize: 4,
        orderHeaderDTOList: [],
        loadList: function(pageNo){
            if (pageNo != null) {
                this.pageNo = pageNo;
            }
            $.get('${ctx}/orderHeader/findListByLimit',{
                pageNo: vm.pageNo,
                pageSize: vm.pageSize,
                orderTypeCd: vm.orderTypeCd,
                type: vm.type
            },function(data){
                vm.orderHeaderDTOList = data.orderHeaderDTOList;
            })
        },
        //清空支付窗口
        clearOrderId: function () {
            this.selectOrderId = 0;
        },
        //取消订单
        cancelOrder: function (orderId) {
            layer.confirm('确认取消该订单？', {
                btn: ['确认', '退出'] //按钮
            }, function () {
                $.post('${ctx}/orderHeader/cancelOrderHeader', {
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
        },
    });
    vm.$watch('onReady',function(){
        vm.loadList();
    })

</script>
</body>
</html>