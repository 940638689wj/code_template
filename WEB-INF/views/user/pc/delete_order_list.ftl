<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html>
<head>
    <title>订单回收站</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body class="page-login">
<div :controller="app" class="ms-controller">
<#include "include/header.ftl"/>
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>订单中心<span><em>_</em>订单回收站</span></h3></div>
            <div class="center-list">
                <table class="orderdatatb orderdatatb2">
                    <thead>
                    <tr>
                        <td class="tal">商品信息</td>
                        <td class="td-name">收货人</td>
                        <#--<td class="td-price">金额</td> -->
                        <td class="td-amount">数量</td>
                        <td class="td-operate">订单类型</td>
                        <td class="td-total">实付金额</td>
                        <td class="td-status">状态</td>
                    </tr>
                    </thead>
                </table>

                <div class="datawrap">
                    <table class="orderdatatb" :for="orderHeader in @orderHeaderDTOList">
                        <tbody>
                        <tr>
                            <th colspan="7" class="ordertb-hd"><div class="order-num">订单号<em>{{orderHeader.orderNumber}}</em></div><div class="order-time">下单时间<em>{{orderHeader.createTime | date("yyyy-MM-dd HH:mm:ss")}}</em></div></th>
                        </tr>
                        <tr :for="orderItem in orderHeader.orderItemList">
                            <td class="td-product">{{orderItem.productName}}</td>
                            <td class="td-name">{{orderHeader.receiveName}}</td>
                           <#-- <td class="td-price">￥{{orderItem.salePrice}}</td> -->
                            <td class="td-amount">{{orderItem.quantity}}</td>
                            <td class="td-operate">{{orderHeader.orderTypeName}}</td>
                            <td class="td-total"><span class="price-real">￥{{orderItem.salePrice}}</span><p></p></td>
                            <td class="td-status">已删除<p><span class="source">{{orderHeader.originPlatformName}}</span></p></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
            <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        </div>
    </div>
</div>
<#include "include/pager.ftl"/>
<script>
    $(function(){
        $("#menu_deleteOrderList").addClass("current");
    })

    var vm = avalon.define({
        $id: 'app',
        pageNo: 1,
        pageSize: 4,
        pageCount: 0,
        orderHeaderDTOList: [],
        loadList: function(pageNo){
            if(pageNo != null){
                this.pageNo = pageNo;
            }
            $.get('${ctx}/account/order/findDeleteOrderListByLimit',
                    {
                        pageNo: vm.pageNo,
                        pageSize: vm.pageSize

                    },function(data){
                        vm.orderHeaderDTOList = data.deleteOrderList;
                    })
        },
        getPageCount: function(){
            $.get("${ctx}/account/order/getDeleteOrderCount",{},function(data){
                vm.pageCount = data.pageCount;
            })
        }
    });
    vm.$watch("onReady",function(){
        vm.getPageCount();
        vm.loadList();
    });
</script>
</body>
</html>