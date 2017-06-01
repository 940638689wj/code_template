<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<#if showTitle?? && showTitle>
<head>
    <title>预售订单</title>
    <script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue.min.js"></script>
</head>
</#if>
<style>
	[v-cloak] {
		display: none;
	}
</style>
<body>
<div id="app" v-cloak>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href='${ctx}/m/account/otherOrder/index'></a>
        <h1 class="mui-title">预售订单</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar skutabbar-order">
            <ul id="selectStatus">
                <li class="selected" id="allStatus" onclick="selectStatus(this,0,'all')"><a href="#">全部</a></li>
                <li onclick="selectStatus(this,1,'forDeposit')"><a href="#">待付定金</a></li>
                <li onclick="selectStatus(this,1,'forRemain')"><a href="#">待付尾款</a></li>
                <li onclick="selectStatus(this,20,'forRemain')"><a href="#">待发货</a></li>
                <li id="wait_receipt" onclick="selectStatus(this,3,'forRemain')"><a href="#">待收货</a></li>
                <li onclick="selectStatus(this,5,'forRemain')"><a href="#">已完成</a></li>
                <li id="cancel_status" onclick="selectStatus(this,6,'forRemain')"><a href="#">已取消</a></li>
            </ul>
        </div>

        <div class="financiallistWrap">
            <div class="order_list">
                <ul>
                    <!-- <li>
                        <div class="hd">
                            <span class="r">未付款</span>
                            <span class="l">2016-04-27 18:18</span>
                        </div>
                        <div class="items">
                            <a href="order_details.html">
                                <div class="pic"><img src="images/goodspic.jpg"></div>
                                <h3>耐克正品 2013新款FREE 5.0赤足系列男子跑步鞋 536840-003 YK</h3>
                                <p class="price">￥<em>1290.00</em></p>
                                <p class="spec">数量：1</p>
                            </a>
                        </div>
                        <div class="items">
                            <a href="order_details.html">
                                <div class="pic"><img src="images/goodspic.jpg"></div>
                                <h3>耐克正品 2013新款FREE 5.0赤足系列男子跑步鞋 536840-003 YK</h3>
                                <p class="price">￥<em>1290.00</em></p>
                                <p class="spec">数量：1</p>
                            </a>
                        </div>
                        <div class="ft">共2件商品，合计：<span>￥1154.00</span></div>
                        <div class="cz">
                            <a class="mui-btn mui-btn-outlined">查看物流</a>
                            <a class="mui-btn mui-btn-danger mui-btn-outlined">确认收货</a>
                        </div>
                    </li> -->
                </ul>
            </div>
        </div>
    </div>
    
    <div id="J_ASSpec" class="actionsheet-spec">
<!--微信支付-->
<div class="payment-method">
    <div class="close"></div>
    <div class="prod-info">
        <div class="title">请选择支付方式</div>
    </div>
    <div class="spec-list">
        <div class="spec-list-wrap">
            <ul class="tbviewlist paytypes">
                <li v-show='isWxBrowser'>
                    <a href="#" onclick="toPay('wechatpay')">微信支付</a>
                </li>
                <li v-show='isUnionpay'>
                    <a href="#" onclick="toPay('unionpay')">银联支付</a>
                </li>
                <li v-show='isWxBrowser?false:true'>
                    <a href="#" onclick="toPay('alipay')">支付宝支付</a>
                </li>
            </ul>
        </div>
    </div>

    <div class="fbbwrap-total nofixed">
        <div class="ftbtnbar">
            <div class="button-wrap button-wrap-expand">
                <a href="javascript:void(0)" class="button cancelBtn">取消</a>
            </div>
        </div>
    </div>
</div>
</div>
</div>
<script>
	var app = new Vue({
		el : '#app',
		data : {
			orderId:'',//当前选中的订单
			isUnionpay : false,
			isWxBrowser : false
		}
	});
	
	$(function(){
		$("#allStatus").click();
		getPayWay();
	});
	
	function getPayWay(){
		var ua = navigator.userAgent.toLowerCase();  
	    if(ua.match(/MicroMessenger/i)=="micromessenger") {  
	        app.isWxBrowser = true;	//判断是否微信浏览器
	    } 
		$.ajax({
			url : '${ctx}/m/account/preSaleOrder/getPayWay',
			type : 'get',
			success : function(data){
				if(data.indexOf('unionpay')>=0)app.isUnionpay = true;
			}
		});
	}
	function selectStatus(e,statusCd,type){
    	$("#selectStatus li").each(function(){
			$(this).removeClass("selected");
		});
		$('.order_list ul').empty(); 
		$(".dropload-down").remove();
		if(e!=null){
			$(e).addClass("selected");
		} 
		getOrderList(statusCd,type);
    }
	function getOrderList(statusCd,type){
		// 页数
        var page = 0;
        // 每页展示5个
        var size = 5;
        // dropload
        $('.financiallistWrap').dropload({
            scrollArea : window,
            domDown : {
                domClass   : 'dropload-down',
                domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
                domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData  : '<div class="dropload-noData">没有跟多数据了</div>'
            },
            loadDownFn : function(me){
                page++;
                // 拼接HTML
                var result = '';
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/account/preSaleOrder/getOrderList_json?pageNo='+page+'&limit='+size+'&statusCd='+statusCd+'&type='+type,
                    dataType: 'json',
                    success: function(data){ 
                        var arrLen = data.rows.length;
                        if(arrLen > 0){
                            for(var i=0; i<arrLen; i++){
                            		result +='<li>'+
                                    '<div class="hd"><span class="r">'+data.rows[i].orderStatusDesc+'</span><span class="l">订单号:'+data.rows[i].masterOrderNumber+'</span></div>';
                                    result += '<div class="items">' +
                                                        '<a href="${ctx}/m/account/preSaleOrder/detail/'+data.rows[i].orderId+'">' +
                                                        '<div class="pic">'+'<img src="${ctx}'+data.rows[i].productPicUrl+'">'+'</div>' +
                                                        '<h3>'+data.rows[i].productName+'</h3>' +
                                                        '<p class="price">￥<em>'+(data.rows[i].orderTotalAmt).toFixed(2)+'</em></p>' +
                                                        '<p class="spec">数量：x'+data.rows[i].quantity+'</p></a></div>';
		                            result +='<div class="cz">';
		                            if(data.rows[i].orderStatusCd ==1){
		                            	result +='<a class="mui-btn mui-btn-danger mui-btn-outlined" onclick="cancelOrder('+data.rows[i].orderId+')">取消订单</a>';
		                            }
	                            	if(data.rows[i].orderStatusCd==1 && data.rows[i].extendOrderId == data.rows[i].orderMasterId){
	                            		result +='<a class="mui-btn mui-btn-danger mui-btn-outlined payForDeposit" href="${ctx}/m/account/preSaleOrder/payForDeposit/'+data.rows[i].orderId+'">支付订金</a>';
	                            	}else if(data.rows[i].orderStatusCd==1 && data.rows[i].extendOrderId != data.rows[i].orderMasterId){
	                            		result +='<a class="mui-btn mui-btn-danger mui-btn-outlined" href="${ctx}/m/account/preSaleOrder/submitOrderForRemain?orderId='+data.rows[i].orderId+'">支付尾款</a>';
	                            	}else if(data.rows[i].orderStatusCd==3 && data.rows[i].extendOrderId != data.rows[i].orderMasterId){
	                            		result +='<a class="mui-btn mui-btn-danger mui-btn-outlined" onclick="confirmReceipt('+data.rows[i].orderId+')">确认收货</a>';
	                            	}
                                    result +='</div>'
                                    	   +'</li>';
                            }
                        }else{
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function(){
                            $('.order_list ul').append(result);
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                        me.resetload();
                    }
                });
            }
        });
	}
    
        var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
                
        $(".payForDeposit").on("click", function () {
            paymentshow();
        });
        specAS.find(".close").on("click", function () {
            paymenthide();
        });

        $(".cancelBtn,.cancel").on("click", function () {
            paymenthide();
        });

        function paymentshow(orderId){
        	app.orderId=orderId;
            paymentMask.show().animate({opacity:1},{
                duration:80,
                complete: function () {
                    specAS.css({
                        top : "100%",
                        opacity : 0,
                        display : "block"
                    }).animate({
                        opacity : 1,
                        translateY:"-"+specAS.height() +"px"
                    },{
                        duration : 200,
                        easing : "ease-in-out"
                    });
                }
            });
            $(document).bind("touchmove",function(e){
                e.preventDefault();
            });
            $('.actionsheet-spec .spec-list')[0].addEventListener('touchmove', function(e) {
                e.stopPropagation();
            }, false);
        }

        function paymenthide(callback){
            specAS.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    specAS.hide();
                    paymentMask.animate({opacity:0},{
                        duration : 80,
                        complete: function () {
                            paymentMask.hide();
                            if(typeof callback == "function") callback.call();
                        }
                    });
                }
            });
            $(document).unbind("touchmove");
        }
	
	function toPay(payWay){
		$.ajax({
			url:'${ctx}/m/account/preSaleOrder/dealPreSaleOrder',
			type:'post',
			data:{
				"orderId":app.orderId,
				"payWay":payWay,
				"type":"downPaymentForList",
				"originPlatformCd":"0"
			},
			dataType:'json',
			success:function(data){
				if(data.result=='success'){
					window.location.href = '${ctx}/m/account/order/goToOrderPayment?payWay='+data.data.payWay+'&orderNumber='+data.data.orderNumber;
				}else{
					mui.alert(data.message);
				}
			},
			error:function(){
				mui.alert('网络出错，请稍后再试！');
			}
		});
	}
	
	function cancelOrder(orderId){
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
							mui.toast('订单已取消!');
							$("#cancel_status").click();
						}else{
							mui.alert(data);
						}
					},
					error:function(){
						mui.alert('网络出错，请稍后再试！');
					}
				});
	        }
	    })
	}
	function confirmReceipt(orderId){
		var btnArray = ['确认', '关闭'];
	    mui.confirm('', '是否确认收货？', btnArray, function(e) {
	        if (e.index == 0) {
	        	$.ajax({
					url:'${ctx}/m/account/preSaleOrder/confirmReceipt',
					type:'post',
					data:{
						"orderId":orderId
					},
					dataType:'json',
					success:function(data){
						if(data.result=='success'){
							$("#wait_receipt").click();
						}else{
							mui.alert(data);
						}
					},
					error:function(){
						mui.alert('网络出错，请稍后再试！');
					}
				});
	        }
	    })
	}
	
</script>
</body>
</html>