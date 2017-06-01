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
<body>
<#include "${ctx}/user/pc/include/header.ftl"/>
<div :controller="app" class="ms-controller">
<#--<#include "include/header.ftl"/>-->
	<div class="center-layout">
	    <#include "${ctx}/user/pc/include/menu.ftl"/>
	    <div class="center-content">
	        <div class="content-titel"><h3>订单中心<span><em>_</em>预售订单</span></h3></div>
	        <div class="corder-tab">
	            <ul>
	                <li :for="($index,typeName) in @typeNameList" :class="[@type == $index && 'current']">
                        <a href="javascript:void(0)" :click="@type = $index">
                            {{typeName}}
                        </a>
                    </li>
	            </ul>
	        </div>
	        <div class="center-list" :if="@preSaleOrderDTOList.length > 0" >
	            <table class="orderdatatb orderdatatb2">
	                <thead>
	                <tr>
	                    <td class="tal">预售商品信息</td>
	                    <td class="td-price">金额</td>
	                    <td class="td-amount">数量</td>
	                    <td class="td-operate">金额</td>
	                    <td class="td-status">状态</td>
	                    <td class="td-operate">操作</td>
	                </tr>
	                </thead>
	            </table>
	
	            <div class="datawrap">
	                <table class="orderdatatb" :for="preSaleOrder in @preSaleOrderDTOList">
	                    <tbody>
	                    <tr>
	                        <th colspan="7" class="ordertb-hd"><div class="order-num">订单号<em>{{preSaleOrder.masterOrderNumber}}</em></div><div class="order-time">下单时间<em>{{preSaleOrder.createTime | date("yyyy-MM-dd
                                    HH:mm:ss")}}</em></div></th>
	                    </tr>
	                    <tr>
	                        <td class="td-product">
	                            <div class="first-column">
	                                <div class="img"><a :attr="{href: '/product/' + preSaleOrder.masterProductId}"><img :attr="{src: preSaleOrder.productPicUrl}"></a></div>
	                                <div class="info">
	                                    <div class="name"><a :attr="{href: '/product/' + preSaleOrder.masterProductId}" target="_blank">{{preSaleOrder.productName}}</a></div>
	                                    <div class="prop" :if="preSaleOrder.skuDesc !=null && preSaleOrder.skuDesc != ''">{{preSaleOrder.skuDesc}}</span>
	                                    </div>
	                                </div>
	                            </div>
	                        </td>
	                        <td class="td-price">￥{{preSaleOrder.salePrice}}</td>
	                        <td class="td-amount">1</td>
	                        <td class="td-operate"><span class="price-real">￥{{preSaleOrder.orderTotalAmt}}</span><p>尾款</p>
	                        <p :if="preSaleOrder.orderStatusCd >=2">已付定金：￥{{preSaleOrder.price}}</p>
	                        <p :if="preSaleOrder.orderStatusCd ==1 && preSaleOrder.extendOrderId != preSaleOrder.orderMasterId">已付定金：￥{{preSaleOrder.price}}</p>
	                        <p :if="preSaleOrder.orderStatusCd ==1 && preSaleOrder.extendOrderId == preSaleOrder.orderMasterId">已付定金：￥{{preSaleOrder.orderTotalAmt - preSaleOrder.orderPayAmt}}</p>
	                        </td>
	                        <td class="td-status">{{preSaleOrder.orderStatusDesc}}</td>
	                        
	                        <td class="td-operate" :if="preSaleOrder.orderStatusCd ==1 && preSaleOrder.extendOrderId==preSaleOrder.orderMasterId">
	                            <a href="#" class="v-btn" ms-click="cancelOrder(preSaleOrder.orderId)">取消订单</a>
	                            <a :attr="{href: '${ctx}/account/preSaleOrder/toPayForDeposit/'+preSaleOrder.orderId}" class="v-btn">支付定金</a>
	                            <p><a :attr="{href: '${ctx}/account/preSaleOrder/toOrderDetail/'+preSaleOrder.orderId}">查看详情</a></p>
	                        </td>
	                        <td class="td-operate" :if="preSaleOrder.orderStatusCd ==1 && preSaleOrder.extendOrderId != preSaleOrder.orderMasterId">
	                            <a href="#" class="v-btn" ms-click="cancelOrder(preSaleOrder.orderId)">取消订单</a>
	                            <a :attr="{href: '${ctx}/account/preSaleOrder/toOrderForRemain/'+preSaleOrder.orderId}" class="v-btn">支付尾款</a>
	                            <p><a :attr="{href: '${ctx}/account/preSaleOrder/toOrderDetail/'+preSaleOrder.orderId}">查看详情</a></p>
	                        </td>
	                        <td class="td-operate" :if="preSaleOrder.orderStatusCd ==3">
	                            <p><a href="#" class="v-btn" ms-click="confirmReceipt(preSaleOrder.orderId)">确认收货</a></p>
	                            <p><a :attr="{href: '${ctx}/account/preSaleOrder/toOrderDetail/'+preSaleOrder.orderId}">查看详情</a></p
	                        </td>
	                        <td class="td-operate" :if="preSaleOrder.orderStatusCd >=2">
	                            <p><a :attr="{href: '${ctx}/account/preSaleOrder/toOrderDetail/'+preSaleOrder.orderId}">查看详情</a></p>
	                        </td>
	                    </tr>
	                    </tbody>
	                </table>
	            </div>
	        </div>
	       
			 <#-- 分页控件-->
			<div :if="@preSaleOrderDTOList.length > 0">
            <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
            </div>
	    </div>
	</div>
</div>
<#include "${ctx}/user/pc/include/pager.ftl"/>
<script>
	var vm = avalon.define({
        $id: 'app',
        // ---数据---
        type: 0, // 订单类型
        typeNameList: ['全部订单', '待付定金', '待付尾款', '待发货', '待收货', '已完成', '已取消'], // 类型列表
        //count: {type0: 0, type1: 0, type2: 0, type3: 0, type4: 0, type5: 0, type6: 0},
        pageNo: 1,
        pageSize: 5,
        preSaleOrderDTOList: [],
        pageCount:14,
        <#--$computed: {
            pageCount: function () {
                return this.count["type" + this.type];
            }
        },-->
        // ---方法---
        // 加载分页数据
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
            $.get('/account/preSaleOrder/findPreSaleListByLimit', {
                pageNo: vm.pageNo,
                pageSize: vm.pageSize,
                type: vm.type
            }, function (data) {
            	vm.pageCount = data.totalCount;
                vm.preSaleOrderDTOList = data.PreSaleOrderDTOList;
            })
        },
        cancelOrder:function(orderId){
        	layer.confirm('确认要取消该订单？', {
				    btn: ['确认','取消'],
				    shade: false //不显示遮罩
				}, function(index){
					   $.ajax({
						url:'${ctx}/account/preSaleOrder/cancelOrder_pc',
						type:'post',
						data:{
							"orderId":orderId
						},
						dataType:'json',
						success:function(data){
							if(data.result=='success'){
								layer.msg('订单已取消!');
								window.location.reload();
							}else{
								layer.alert(data);
							}
						},
						error:function(){
							layer.alert('网络出错，请稍后再试！');
						}
					});
				    layer.close(index);
				});
        },
        confirmReceipt:function(orderId){
			layer.confirm('是否确认收货？', {
				    btn: ['确认','取消'],
				    shade: false //不显示遮罩
				}, function(index){
					   $.ajax({
						url:'${ctx}/account/preSaleOrder/confirmReceipt_pc',
						type:'post',
						data:{
							"orderId":orderId
						},
						dataType:'json',
						success:function(data){
							if(data.result=='success'){
								window.location.reload();
							}else{
								layer.alert(data);
							}
						},
						error:function(){
							layer.alert('网络出错，请稍后再试！');
						}
					});
				    layer.close(index);
				});
		}
        
    });

    // 初始化 回调
    vm.$watch('onReady', function () {
        vm.loadList();
    });

    //修改订单类型 回调
    vm.$watch('type', function () {
        vm.preSaleOrderDTOList = [];
        vm.pageNo = 1;
        vm.loadList();
    });
	
    $(function(){
        $(".mcmenu dt").on("click", function () {
            var parentMenu = $(this).parent();
            parentMenu.toggleClass("mcmenu-closed");
            if(parentMenu.hasClass("mcmenu-closed")){
                parentMenu.animate({
                    height : 40
                },{duration:200});
            }else{
                parentMenu.animate({
                    height : parentMenu.prop("scrollHeight")
                },{duration:200});
            }
        });
    })
</script>
</body>
</html>