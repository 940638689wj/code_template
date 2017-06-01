<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>订单详情</title>
    <script type="text/javascript" src="${staticPath}/js/vue.min.js"></script>
    <script type="text/javascript" src="${staticPath}/mobile/js/dateFormate1.js"></script>
    <script type="text/javascript" src="${staticPath}/mobile/js/sha1.js"></script>
	<style>
		[v-cloak] {
			display: none;
		}
	</style>
</head>
<body>
<div id='app' v-cloak>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/preSaleOrder/list"></a>
        <h1 class="mui-title">订单详情</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r orange" v-html="">{{orderStatus}}</div>
                            <div class="c">订单号：{{orderNumber}}</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="borderbox">
            <h3 class="title">商品清单</h3>
            <ul class="prd-list b-bottom">
                <li>
                    <div class="pic">
                        <img v-bind:src='defaultPic'>
                    </div>
                    <div class="r">
                        <p class="name">{{productName}}</p>
                        <!--<p><span class="specifications">{{skuDesc}}</span></p>-->
                        <p class="info"><span class="num"><i class="small">X</i>{{quantity}}</span></p>
                        <div class="price">
                            <div class="price-real">¥{{defaultPrice}}</div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="payment-info">
            <p><span class="fl gray"><h1>订单信息</h1></span></p>
            <p><span class="fl gray">下单时间</span><span class="fr">{{createTime}}</span></p>
            <p><span class="fl gray" v-html='isForDeposit?"定金付款方式":"尾款付款方式"'></span>
            <span class="fr">{{payModel}}</span></p>
            <p><span class="fl gray" v-html='isForDeposit?"定金付款状态":"尾款付款状态"'></span>
            <span class="fr">{{payStatus}}</span></p>
            <p><span class="fl gray" >订单备注</span><span class="fr">{{remark}}</span></p>
            <p><span class="fl gray">已付定金</span><span class="fr orange">¥{{payForDpositAmt}}</span></p>
            <p v-show='isNeedPay?true:false'><span class="fl gray" v-html='isForDeposit?"待付定金":"待付尾款"'></span>
	           <span class="fr orange" v-show='isShowBalancePayAmt?true:false'>(余额已支付¥{{balancePayAmt}})</span>
	           <span class="fr orange">¥{{realAmt}}</span></p>
	        
	        <p v-show='isNeedPay?false:true'><span class="fl gray" v-html='isForDeposit?"已付定金":"已付尾款"'></span>
	           <span class="fr orange" v-show='isShowBalancePayAmt?true:false'>(余额已支付¥{{balancePayAmt}})</span>
	           <span class="fr orange">¥{{realAmt}}</span></p>
        </div>
        <div class="fbbwrap fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap"></div>
                <div class="button-wrap bkno">
                    <a class="orderdetailbtn view" href="javascript:void(0)" v-show='isShowCancelOrder?true:false' v-on:click="cancelOrder()">取消订单</a>
                </div>
            </div>
        </div>
    </div>
</div>
  
            
</div>
<script>
var orderId = ${orderId!};
var app = new Vue({
		el : '#app',
		data : {
			orderNumber:'',
			totalAmt:'',
			realAmt:'',
			defaultPic:'',
			productName:'',
			defaultPrice:'',
			quantity:'',
			createTime:'',
			payModel:'',
			payStatus:'',
			orderStatus:'',
			remark:'',
			skuDesc:'',
			<#--已付定金-->
			payForDpositAmt:'0.00',
			userBalance:'0.00',
			balancePayAmt:0,
			isUnionpay : false,
			isWxBrowser : false,
			isForDeposit: true,
			isShowBalancePayAmt:false,
			isShowCancelOrder:false,
			isNeedPay:true,
			<#--是否使用余额支付-->
			isBalancePay:false,
			<#--是否有余额参与支付-->
			hasBalancePay:false,
			hasPassword:false
		},
		methods:{
			subOrder: function(){
	        	if(this.hasPassword){
	        		var pwd = $("#pwd-input").val();
	        		if(pwd.length==6){
	        			mui.toast("订单已提交，请稍等!");
	        		}else if(pwd.length>0 && pwd.length< 6){
	        			mui.toast("请输入6位数的密码!");
	        		}else{
	        			mui.toast("请输入密码!");
	        		}
	        	}else{
	        		setPayPwd();
	        	}
	        },
	        cancelOrder: function(){
				var btnArray = ['确认', '关闭'];
			    mui.confirm('', '确认要取消该订单？', btnArray, function(e) {
			        if (e.index == 0) {
			        	$.ajax({
							url:'${ctx}/m/account/preSaleOrder/cancelOrder',
							type:'post',
							data:{
								"orderId":orderId
							},
							dataType:'json',
							success:function(data){
								if(data.result=='success'){
									mui.toast('订单已取消');
									location.href='${ctx}/m/account/preSaleOrder/detail/'+orderId;
								}else{
									mui.alert(data.message);
								}
							},
							error:function(){
								mui.alert('网络出错，请稍后再试！');
							}
						});
			        }
			    });
			},
			ConvertJSONDateToJSDateObject: function(JSONDateString) {
			    var date = new Date(parseInt(JSONDateString));
			    return date;
			}
		}
	});
		
	$(function(){
	    var ua = navigator.userAgent.toLowerCase();  
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {  
	        app.isWxBrowser = true;	//判断是否微信浏览器
	    } 
		$.ajax({
			url : '${ctx}/m/account/preSaleOrder/detail_json?orderId='+orderId,
			type : 'get',
			success : function(data){
				app.orderNumber=data.orderDetail.orderNumber;
				app.totalAmt=(data.orderDetail.orderTotalAmt).toFixed(2);
				app.realAmt=(data.orderDetail.orderPayAmt).toFixed(2);
				app.defaultPic=data.orderDetail.productPicUrl;
				app.productName=data.orderDetail.productName;
				app.defaultPrice=(data.orderDetail.salePrice).toFixed(2);
				app.quantity=data.orderDetail.quantity;
				app.createTime=Format(app.ConvertJSONDateToJSDateObject(data.orderDetail.createTime),"yyyy-MM-dd HH:mm");
				app.payModel=data.orderDetail.orderPayModelDesc;
				app.orderStatus=data.orderDetail.orderStatusDesc;
				app.payStatus = data.orderDetail.orderPayStatusDesc;
				app.remark=data.orderDetail.remark;
				app.skuDesc = data.orderDetail.skuDesc;
				app.payForDpositAmt = (data.orderDetail.payForDpositAmt).toFixed(2);
				app.balancePayAmt =eval(data.orderDetail.orderTotalAmt - data.orderDetail.orderPayAmt).toFixed(2);
				app.userBalance = (data.userBalance).toFixed(2);
				if(data.orderDetail.orderType==2){//判断定是定金订单还是尾款订单
					app.isForDeposit = false;
				};
				if(data.orderDetail.orderType==1 && eval(data.orderDetail.orderTotalAmt - data.orderDetail.orderPayAmt)>0){
					app.isShowBalancePayAmt = true;
				};
				if(data.orderDetail.orderStatusCd ==1){
					app.isShowCancelOrder = true;
				};
				if(data.orderDetail.orderStatusCd !=1){
					app.isNeedPay = false;
				};
				if(data.payPassword!=null && data.payPassword!=''){
					app.hasPassword=true;
				}
			}
		});
	}); 
</script>
</body>
</html>