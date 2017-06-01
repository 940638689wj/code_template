<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<html>
<head>
	<script type="text/javascript" src="${ctx}/static/js/vue.min.js"></script>
	<style>
		[v-cloak] {
			display: none;
		}
	</style>
</head>
<body>
<div id='app' v-cloak>
	<input type='hidden' id='addrId' value='${addrId!}'>
	<div id="page">
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" v-bind:href='backUrl'></a>
	        <h1 class="mui-title">确认订单</h1>
	        <a class="mui-icon"></a>
	    </header>
	    <div class="mui-content">
			<div class="exchangetab">
	            <ul>
	                <li id='takeByExpressBtn' class="selected" v-on:click='takeByExpress'><a href="javaScript:void(0)">快递配送</a></li>
	                <li id='takeBySelfBtn' v-on:click='takeBySelf'><a href="javaScript:void(0)">上门自提</a></li>
	            </ul>
	        </div>
			
			<div v-show='isExpress?false:true'>
		        <div class="tbviewlist categorylist orderviewlist">
		            <ul>
		                <li class="itemlink">
		                    <div class="c">选择提货门店</div>
		                    <div class="s">
		                        <select v-model='storeId' v-on:change='selectStore'>
		                            <option value='0'>请选择</option>
		                            <option v-for="item in store" v-bind:value="item.storeId">{{item.storeName}}</option>
		                        </select>
		                    </div>
		                </li>
		                <li>
		                    <a id="deliveryTimeBtn" class="itemlink" href="javascript:void(0);">
		                        <div class="r" id='selectDeliveryTimeTip'>请选择</div>
		                        <div class="c">选择提货时间</div>
		                    </a>
		                </li>
		            </ul>
		        </div>
			</div>
			
			<div v-show='isExpress'>
		        <div class="order-address" v-show='hasAddress'>
		            <a v-on:click='selectAddress'>
		            <span class="name">{{receiverName}}</span>
		            <span class="phone">{{tel}}</span>
		            <address>{{province}}  {{city}}  {{county}}{{addr}}</address>
		            </a>
		        </div>
		
		        <div v-show='hasAddress?false:true' class="order-address">
					<a v-on:click='selectAddress'>
		                <address>您的收货信息为空，点此添加收货地址</address>
		            </a>
		        </div>
			</div>
	
	        <div class="borderbox mb0">
	            <h3 class="title">商品清单</h3>
	            <ul class="prd-list b-bottom">
	                <li>
	                    <div class="pic">
	                        <img v-bind:src="picUrl">
	                    </div>
	                    <div class="r">
	                        <p class="name">{{productName}}</p>
	                        <p class="info">
	                        	<span class="num"><i class="small">X</i>1</span>
	                        	<span class="specifications"><i v-for='item in sku'>{{item.skuType}}：{{item.skuValue}}&nbsp;</i></span>
	                        </p>
	                    </div>
	                </li>
	            </ul>
	        </div>
	
	        <div class="borderbox">
	            <div class="tbviewlist categorylist">
	                <ul>
	                    <li class="itemlink" v-show='isExpress'>
	                        <div class="c">配送方式（包邮）</div>
	                        <div class="s">
	                            <select v-model='expressId'>
	                                <option value='0'>请选择</option>
	                                <option v-for='item in expressList' v-bind:value='item.expressId'>{{item.expressName}}</option>
	                            </select>
	                        </div>
	                    </li>
	                    
	                    <li>
	                        <div class="hd">买家留言:</div>
	                        <div class="bd">
	                            <input type="text" v-model='remark' placeholder="选填：对本次交易的说明">
	                        </div>
	                    </li>
	                </ul>
	            </div>
	        </div>
	
	        <div class="fbbwrap-total">
	            <div class="ftbtnbar">
	                <div class="content-wrap">
	                    <div class="content-wrap-in content-cartwrap-in">
	                        <div class="r">
	                            <div class="main-info"><i>众筹价格（已支付）：</i><span>¥{{productTotal.toFixed(2)}}</span></div>
	                        </div>
	                    </div>
	                </div>
	                <div class="button-wrap">
	                    <a class="button" v-on:click='sub'>确定</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>



<div id="deliveryTimeDialogDiv" class="actionsheet-spec">
    <div class="close"></div>
    <div class="prod-info">
        <div class="title">提货时间</div>
    </div>
    <div class="ctimewap">
        <div class="ctimewap-left">
            <div id="ctimewapleftScroll" class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <ul class="ctime-date">
                        <#--
                        <li class="selected">02月13日（周一）</li>
                        <li>02月14日（周一）</li>
                        -->
                        <li v-for='item in dateList' v-bind:data-key='item.key'>{{item.value}}</li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="ctimewap-right">
            <div id="ctimewaprightScroll" class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <ul class="ctime-time">
                        <li>
                            <label>
                                <input type="radio" name="pickupTime" v-bind:value="amTime">
                                <div class="c" id="amTime">{{amTime}}</div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="pickupTime" v-bind:value="pmTime">
                                <div class="c" id="pmTime">{{pmTime}}</div>
                            </label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="fbbwrap-total nofixed">
        <div class="ftbtnbar">
            <div class="button-wrap button-wrap-expand">
                <a href="javascript:void(0)" id="confirmDeliveryTime" class="button">确定</a>
            </div>
        </div>
    </div>
</div>
</div>

<script type='text/javascript'>
var promotionId = ${promotionId!};
var addrId = $('#addrId').val();
var app = new Vue({
    el: '#app',
    data: {
        hasAddress:false,
		hasStore:true,
		isExpress:true,
		remark:'',
		perAmt:0,
		province:'',
		city:'',
		county:'',
		addr:'',
		productName:'',
		sku:[],
		tel:'',
		addrId:'',
		receiverName:'',
		orderId:'',
		picUrl:'',
		store:[],
		backUrl : '/m/account/crowdfundingOrder/detail?promotionId='+promotionId,
		storeId : 0,
		expressList : [],
		expressId : 0,
		dateList :[],
		amTime:'',
		pmTime:'',
		pickupDate:'',
		pickupTime:'',
		productTotal:0
		
    },
    methods: {
        takeByExpress(){
        	$("#takeByExpressBtn").addClass('selected');
        	$("#takeBySelfBtn").removeClass('selected');
        	app.isExpress = true;
        },
        takeBySelf(){
        	$("#takeBySelfBtn").addClass('selected');
	    	$("#takeByExpressBtn").removeClass('selected');
    		app.isExpress = false;
        	if(this.hasStore){
    		}else{
    			mui.alert('该众筹商品无自提门店，请使用快递配送', '自提提醒', function() {
                    app.takeByExpress();
                });
    		}
        },
        selectAddress(){
        	setCookie('promotionId',promotionId);
        	location.href = '${ctx}/m/account/userAddress/selectAddressList?fromType=3';
        },
        selectStore(){
        	$('#selectDeliveryTimeTip').html('请选择');
        	app.pickupDate = '';
        	app.pickupTime = '';
        },
        sub(){
        	var param = {} ;
        	if(app.isExpress){		//快递
				if(app.addrId == 0 || app.addrId == ''){
					mui.toast('请先选择地址！');
					return false;
				}
				if(app.expressId == 0 || app.expressId == ''){
					mui.toast('请先选择快递！');
					return false;
				}
				param.isExpress = true;
				param.addrId = app.addrId;
				param.expressId = app.expressId;
			}else{					//自提
				if(app.storeId == null || app.storeId == 0){
					mui.toast('请先选择自提门店！');
					return false;
				}
				if(app.pickupTime == '' || app.pickupDate == ''){
					mui.toast('请先选择提货时间！');
					return false;
				}
				param.isExpress = false;
				param.storeId = app.storeId;
				param.pickupTime = app.pickupTime;
				param.pickupDate = app.pickupDate;
			}
			
        	mui.confirm('是否确认提交？','提交确认',function(e){
        		if(e.index == 1){
					param.remark = app.remark;
					param.orderId = app.orderId;
					param.promotionId = promotionId;
					var paramStr = JSON.stringify(param);
        			//发送请求
        			$.ajax({
        				url:'dealAwardOrder',
        				data:param,
        				dataType:'json',
        				type:'post',
        				success:function(data){
        					if(data.result == 'success'){
        						mui.toast('领奖成功！');
	        					location.href = '/m/account/crowdfundingOrder/list';
        					}else{
        						mui.alert(data.message);
        					}
        				}
        			});
        		}
        	});
        }
    }
});

//设置Cookie
function setCookie(name, value) {
    document.cookie = name + '=' + encodeURIComponent(value) + ';path=/';
}

//初始化数据
$(function() {
    $.ajax({
        url: 'jsonAwardData?promotionId=' + promotionId +'&addrId='+addrId,
        type: 'get',
        success: function(_data) {
        	if(_data.result == 'success'){
        		var data = _data.data;
        		if(data.addrId != null ){
	        		app.hasAddress = true;
	        		app.province = data.province;
	        		app.city = data.city;
	        		app.county = data.county;
	        		app.addr = data.addr;
	        		app.addrId = data.addrId;
	        		app.tel = data.tel;
	        		app.receiverName = data.receiverName;
	        		app.expressList = data.expressList;
	        	}
	        	if(data.store == null){
	        		app.hasStore = false;
	        	}else{
	        		app.store = data.store;
	        	}
	        	app.productName = data.productName;
	        	app.orderId = data.orderId;
	        	app.picUrl = data.picUrl;
	        	app.sku = data.sku;
	        	app.perAmt = data.perAmt;
	        	app.dateList  = data.dateList;
	        	app.productTotal = data.productTotal;
        	}else{
        		mui.alert(_data.message,function(){
        			location.href = '/m/account/crowdfundingOrder/list';
        		});
        	}
        }
    });
    
        paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {}).appendTo(document.body),
        
        /*提货时间*/
        dTime = $("#deliveryTimeDialogDiv");
        dTime.find(".close").on("click", function () {
            deliveryTimehide();
        });
        $("#deliveryTimeBtn").on("click", function () {
            var len = app.store.length;
            for(var i=0;i<len;i++){
            	var store = app.store[i];
            	if(store.storeId == app.storeId){
            		app.amTime = store.amStart+'-'+store.amEnd;
            		app.pmTime = store.pmStart+'-'+store.pmEnd;
            	}
            }
            
            if(app.storeId == 0){
                mui.toast('请先选择提货门店!');
                return ;
            }
            deliveryTimeshow();
        });
        $('#confirmDeliveryTime').on("click", function(){
            var pickupDateList = $('.ctime-date').find('li').filter('.selected');
            if(pickupDateList == undefined || pickupDateList.length < 1){
                mui.toast('请选择提货日期!');
                return ;
            }
            app.pickupDate = $(pickupDateList.get(0)).attr('data-key');
            var pickupDate = $(pickupDateList.get(0)).text();

            var pickupTimeList = $('input[name="pickupTime"]').filter(":checked");
            if(pickupTimeList == undefined || pickupTimeList.length < 1){
                mui.toast('请选择提货时间!');
                return ;
            }
            
            app.pickupTime = pickupTimeList.val();

            $('#selectDeliveryTimeTip').html(pickupDate+" &nbsp;"+app.pickupTime);
            deliveryTimehide();
        });

        $('.ctime-date').on('click', 'li', function(){
            $('.ctime-date').find('li').removeClass('selected');
            $(this).addClass('selected');
        });
        
        function deliveryTimeshow(){
	        paymentMask.show().animate({opacity:1},{
	            duration:80,
	            complete: function () {
	                dTime.css({
	                    top : "100%",
	                    opacity : 0,
	                    display : "block"
	                }).animate({
	                    opacity : 1,
	                    translateY:"-"+dTime.height() +"px"
	                },{
	                    duration : 200,
	                    easing : "ease-in-out"
	                });
	            }
	        });
	        $(document).bind("touchmove",function(e){
	            e.preventDefault();
	        });
	    }
	
	    function deliveryTimehide(callback){
	        dTime.animate({
	            opacity : 0,
	            translateY:0
	        },{
	            duration : 200,
	            easing : "ease-in-out",
	            complete : function () {
	                dTime.hide();
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
});

    mui('#ctimewapleftScroll').scroll();
    mui('#ctimewaprightScroll').scroll();
</script>
</body>
</html>