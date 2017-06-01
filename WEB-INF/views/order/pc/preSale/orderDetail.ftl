<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title>订单详情</title>
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body>
<div :controller="app" class="ms-controller">
<div class="center-layout">
    <div class="crumbWrap">
        <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="#">预售定单</a>
            <span class="divide">&gt;</span>
            <span>订单详情</span>
        </div>
    </div>
    <div class="order-state">
        <div class="state-lcol">
            <div class="state-top">订单号：{{nowOrderNumber}}</div>
            <div :if="orderForDeposit.orderStatusCd == 1">
	            <h3 class="state-txt">待付定金</h3>
	            <div class="state-btns">
	                <a :attr="{href: '${ctx}/account/preSaleOrder/toPayForDeposit/'+orderForDeposit.orderId}" class="v-btn" id="btnBuy">支付定金</a>
	            </div>
            </div>
            <div :if="orderForRemain.orderStatusCd == 1">
	            <h3 class="state-txt">待付尾款</h3>
	            <div class="state-btns">
	                <a :attr="{href: '${ctx}/account/preSaleOrder/toOrderForRemain/'+orderForRemain.orderId}" class="v-btn" id="btnBuy">支付尾款</a>
	            </div>
            </div>
            <div :if="orderForRemain.orderStatusCd ==20 || orderForRemain.orderStatusCd == 3">
	            <h3 class="state-txt">待收货</h3>
            </div>
            <div :if="orderForRemain.orderStatusCd ==5">
	            <h3 class="state-txt">已完成</h3>
            </div>
            <div :if="orderForRemain.orderStatusCd ==6 || orderForDeposit.orderStatusCd == 6">
	            <h3 class="state-txt">已取消</h3>
            </div>
        </div>
        <div class="state-rcol">
            <div class="order-presale order-process"> 
                <div class="node ready" id="status1">
                    <i class="node-icon icon-start"></i>
                    <ul>
                        <li class="txt1">&nbsp;</li>
                        <li class="txt2">提交预售单</li>
                        <!--<li class="txt3">2016-12-14 <br> 08:19:28</li>-->
                    </ul>
                </div>
                <div class="proce" id="line1"></div>
                <div class="node" id="status2">
                    <i class="node-icon icon-pay"></i>
                    <ul>
                        <li class="txt1">&nbsp;</li>
                        <li class="txt2">支付定金</li>
                        <!--<li class="txt3">2016-12-14 <br> 08:19:28</li>-->
                    </ul>
                </div>
                <div class="proce" id="line2"></div>
                <div class="node" id="status3">
                    <i class="node-icon icon-pay"></i>
                    <ul>
                        <li class="txt1">&nbsp;</li>
                        <li class="txt2">支付尾款</li>
                        <!--<li class="txt3">2016-12-14 <br> 08:19:28</li>-->
                    </ul>
                </div>
                <div class="proce" id="line3"></div>
                <div class="node" id="status4">
                    <i class="node-icon icon-express"></i>
                    <ul>
                        <li class="txt1">&nbsp;</li>
                        <li class="txt2">等待收货</li>
                        <!--<li class="txt3">2016-12-14 <br> 08:19:28</li>-->
                    </ul>
                </div>
                <div class="proce" id="line4"></div>
                <div class="node" id="status5">
                    <i class="node-icon icon-finish"></i>
                    <ul>
                        <li class="txt1">&nbsp;</li>
                        <li class="txt2">完成</li>
                        <!--<li class="txt3">2016-12-14 <br> 08:19:28</li>-->
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="order-info-mod">
        <div class="dl">
            <div class="dt">定金信息</div>
            <div class="dd">
                <p><span>定金单号：</span><em>{{orderForDeposit.orderNumber}}</em></p>
                <p><span>支付方式：</span><em>账户余额支付</em></p>
                <p><span>支付状态：</span><em>{{orderForDeposit.orderPayStatusDesc}}</em></p>
                <p><span>创建时间：</span><em>{{orderForDeposit.createTime | date("yyyy-MM-dd HH:mm:ss")}}</em></p>
                <p><span>订单备注：</span><em>{{orderForDeposit.remark}}</em></p>
            </div>
        </div>
        <div class="dl">
            <div class="dt">尾款信息</div>
            <div class="dd">
                <p><span>尾款单号：</span><em>{{remainOrderNumber}}</em></p>
                <p><span>支付状态：</span><em>{{remainOrderPayStatusDesc}}</em></p>
                <p><span>创建时间：</span><em :if="remainCreateTime != '' ">{{remainCreateTime | date("yyyy-MM-dd HH:mm:ss")}}</em></p>
                <p><span>订单备注：</span><em>{{remainRemark}}</em></p>
            </div>
        </div>
        <div class="dl">
            <div class="dt">配送信息</div>
            <div class="dd">
                <p><span>快递公司：</span><em>{{expressName}}</em></p>
                <p><span>快递单号：</span><em>{{expressNumber}}</em></p>
                <p><span>发货时间：</span><em :if="sendTime !=''">{{sendTime | date("yyyy-MM-dd HH:mm:ss")}}</em></p>
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
                <!--<th class="col-1">优惠</th>-->
                <th class="col-1">小计</th>
                <!--<th class="col-1">操作</th>-->
            </tr>
            </thead>
            <tbody>
            <tr>
                <td>
                    <div class="first-column">
                        <div class="img"><a :attr="{href: '/product/' + orderForDeposit.masterProductId}"><img :attr="{src:orderForDeposit.productPicUrl}"></a></div>
                        <div class="info">
                            <div class="name"><a :attr="{href: '/product/' + orderForDeposit.masterProductId}" target="_blank">{{orderForDeposit.productName}}</a></div>
                            <div class="prop" :if="orderForDeposit.skuDesc != null && orderForDeposit.skuDesc != ''"><span>{{orderForDeposit.skuDesc}}</span>
                            </div>
                        </div>
                    </div>
                </td>
                <td>¥{{orderForDeposit.salePrice}}</td>
                <td>{{orderForDeposit.quantity}}</td>
                <!--<td>--</td>-->
                <td><span class="text-red">¥{{orderForDeposit.quantity * orderForDeposit.salePrice}}</span></td>
                <!--<td><a href="#" class="v-button">申请退换货</a></td>-->
            </tr>
            </tbody>
        </table>
        <div class="goods-total">
            <ul>
                <li>
                    <span class="label">商品总额：</span>
                    <span class="txt">¥{{orderForDeposit.quantity * orderForDeposit.salePrice}}</span>
                </li>
                <li>
                    <span class="label">快递费用：</span>
                    <span class="txt" :if="orderExpressAmt !=''">¥{{orderExpressAmt}}</span>
                </li>
                <li>
                    <span class="label">定金总额：</span>
                    <span class="txt">¥{{orderForDeposit.orderTotalAmt}}</span>
                </li>
                <li>
                    <span class="label">尾款总额：</span>
                    <span class="txt" :if="remainOrderTotalAmt !=''">¥{{remainOrderTotalAmt}}</span>
                </li>
            </ul>
        </div>
    </div>
</div>
<input type="hidden" id="orderId" value="${orderId!}">


<!--<div id="payment" class="hidden">
    <div class="paytypes">
        <ul>
            <li id="balancePayment"><a href="javascript:void(0);">余额支付</a></li>
            <li><a href="#">支付宝支付</a></li>
            <li><a href="#">银联支付</a></li>
        </ul>
    </div>
</div>
<div id="payPassword"  class="hidden">
    <div class="formList paypassword">
        <div class="item">
            <div class="hd">输入支付密码：</div>
            <div class="bd">
                <input type="text" class="textfield">
            </div>
        </div>
        <div class="item">
            <div class="hd"></div>
            <div class="bd">
                <a class="v-btn" href="#">确定</a>
            </div>
        </div>
    </div>
</div>-->
</div>
<script>
	var vm = avalon.define({
        	$id: 'app',
        	<#--定金单信息-->
        	orderForDeposit:'',
        	<#--当前订单号-->
        	nowOrderNumber:'',
        	<#--尾款单信息-->
        	orderForRemain:'',
        	remainOrderNumber:'',
        	remainCreateTime:'',
        	remainOrderTotalAmt:'',
        	remainOrderPayStatusDesc:'',
        	remainStatus:'',
        	remainRemark:'',
        	orderExpressAmt:'',
        	<#--配送信息-->
        	expressName:'',
        	expressNumber:'',
        	sendTime:'',
        	getExpressInfo: function(orderId){
        		$.ajax({
				url : '${ctx}/account/preSaleOrder/getExpressInfo?orderId='+orderId,
				type : 'get',
				success : function(data){console.log(data);
					if(data!=null){
						vm.expressName = data.expressName;
						vm.expressNumber = data.orderexpressInfo.orderExpressNum;
						vm.sendTime = data.orderexpressInfo.sendTime;
					}
				}
				});
        	},
        	showOrderStatus: function(){//线条样式 done
        		if(vm.orderForDeposit.orderStatusCd == 1){//待付定金
        			$("#line1").addClass("done");
        			$("#status2").addClass("ready");
        			
        		}
        		if(vm.remainStatus == 1){//待付尾款
        			$("#line1").addClass("done");
        			$("#status2").addClass("ready");
        			$("#line2").addClass("done");
        			$("#status3").addClass("ready");
        		}
        		if(vm.remainStatus == 20 || vm.remainStatus == 3){//待收货
        			$("#line1").addClass("done");
        			$("#status2").addClass("ready");
        			$("#line2").addClass("done");
        			$("#status3").addClass("ready")
        			$("#line3").addClass("done");
        			$("#status4").addClass("ready")
        		}
        		if(vm.remainStatus == 5){//已完成
        			$("#line1").addClass("done");
        			$("#status2").addClass("ready");
        			$("#line2").addClass("done");
        			$("#status3").addClass("ready")
        			$("#line3").addClass("done");
        			$("#status4").addClass("ready")
        			$("#line4").addClass("done");
        			$("#status5").addClass("ready");
        		}
        	}
        	
        });
	// 初始化 回调
    vm.$watch('onReady', function () {
        var orderId = $("#orderId").val();
		$.ajax({
				url : '${ctx}/account/preSaleOrder/orderDetail_Json?orderId='+orderId,
				type : 'get',
				success : function(data){console.log(data);
					if(data!=null){
						vm.orderForDeposit = data.orderForDeposit;
						if(data.orderForRemain!=null){
							vm.orderForRemain = data.orderForRemain;
							vm.remainOrderNumber = data.orderForRemain.orderNumber;
							vm.remainCreateTime = data.orderForRemain.createTime;
							vm.remainOrderTotalAmt = data.orderForRemain.orderTotalAmt;
							vm.remainOrderPayStatusDesc = data.orderForRemain.orderPayStatusDesc;
							vm.remainRemark = data.orderForRemain.remark;
							vm.remainStatus = data.orderForRemain.orderStatusCd;
							vm.orderExpressAmt = data.orderForRemain.orderExpressAmt;
						}
						vm.nowOrderNumber = data.nowOrderNumber;
						vm.showOrderStatus();
						if(data.orderForRemain!=null){
							vm.getExpressInfo(data.orderForRemain.orderId);
						}
					}
				}
		});
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

        $("#btnBuy").on("click",function(){
            payment();
        })

        $("#balancePayment").on("click",function(){
            paypassword();
        })
    })

    function payment(){
        layer.open({
            type: 1,
            title: '选择支付方式',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px'],
            content: $("#payment")
        });
    }

    var payPassword;
    function paypassword(){
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px','200px'],
            content: $("#payPassword")
        });
    }
</script>
</body>
</html>