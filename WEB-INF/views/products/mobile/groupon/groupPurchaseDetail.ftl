<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<html>
<head>
<script type="text/javascript" src="${ctx}/static/js/vue.min.js"></script>
<script type="text/javascript" src="${ctx}/static/mobile/js/swiper.min.js"></script>
<style>
	[v-cloak] {
		display: none;
	}
</style>
</head>
<body>
<input type='hidden' id="promotionId" value='${promotionId!}'>
<input type='hidden' id="picUrls" value='${picUrls!}'>
<input type='hidden' id="userId" value='${userId!}'>
<div id='app' v-cloak>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/groupPurchase/list"></a>
        <h1 class="mui-title">团购详情</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="swiper-container picslider">
            <div class="swiper-wrapper">
                <div class="swiper-slide" v-for="picUrl in picUrls">
                    <div class="pic"><img v-bind:data-src="picUrl" class="swiper-lazy"></div>
                    <div class="swiper-lazy-preloader"></div>
                </div>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>
		
        <div class="sku-detail-top">
            <div class="sku-intro">
                <h1 class="sku-name">{{promotionName}}</h1>
                <p class="sku-custom-attr">{{skuCustomAttr}}</p>
            </div>
            <p class="sku-sales-num">有限期：{{limitTime}}<span class="inventory">已售{{saleNum}}</span></p>
            <div class="sku-price">
                <div class="price-real">￥<strong>{{realPrice}}</strong></div>
            </div>
        </div>

        <div class="skutabbar" id="J_DetailTab">
            <ul>
                <li class="selected"><a href="javascript:void(0);">图文详情</a></li>
                <li class=""><a class="itemlink" v-bind:href="evaluateUrl">商品评价</a></li>
            </ul>
        </div>
        <div class="sku-detail-content">
            <div id="J_DetailContent" class="tabpag">
                <div class="iconinfo" v-show="noDesc">
                    <div class="ico ico-info"></div>
                    <strong>暂无图片详情</strong>
                </div>
                <div v-html="productDesc"></div>
            </div>
            </div>
        </div>

        <div class="fbbwrap-total">
            <div class="ftbtnbar" v-show='onSale?false:true'>
                <div class="button-wrap button-wrap-expand button-wrap-disabled">
                    <a href="javascript:void(0)" class="button">商品已售罄</a>
                </div>
            </div>

            <div class="ftbtnbar" v-show='onSale'>
                <div class="button-wrap button-wrap-expand">
                    <a id="J_BtnBuy" class="button">立即抢购</a>
                </div>
            </div>
        </div>
    </div>

	<div id="J_ASSpec" class="actionsheet-spec">
	    <div class="close"></div>
	    <div class="prod-info">
	        <div class="pic"><img v-bind:src="picUrls[0]" alt=""/></div>
	        <div class="name">{{promotionName}}</div>
	        <div class="price"><span class="price-real">￥<em>{{realPrice}}</em></span></div>
	    </div>
	    <div class="spec-list detail">
	        <div class="spec-list-wrap">
	            <div class="spec-item" v-for="item in sku">
	                <h3>{{item.skuType}}</h3>
	                <div class="c">
	                    <div class="prop-list">
	                        <ul>
	                            <li>{{item.skuValue}}</li>
	                        </ul>
	                    </div>
	                </div>
	            </div>
	            <div class="spec-item">
	                <h3>数量</h3>
	                <div class="c">
	                    <div class="number-widget">
	                        <div class="number-minus disabled" v-on:click="deNum"></div>
	                        <input class="number-text" type="number" v-model="buyNum" v-on:change="checkNum">
	                        <div class="number-plus" v-on:click="inNum"></div>
	                    </div>
	                    <div class="sku-stock-count">库存<em>{{realStock}}</em>件</div>
	                </div>
	            </div>
	        </div>
	    </div>
	
	    <div class="fbbwrap nofixed">
	        <div class="ftbtnbar">
	            <div class="button-wrap button-wrap-expand">
	                <a href="javaScript:void(0)" v-on:click="toPay" class="button btn-buy">下一步</a>
	            </div>
	        </div>
	    </div>
	</div>
</div>
</div>
<script type='text/javascript'>
var temp = $('#picUrls').val(); 
var picUrls = [];
if(temp == null || temp.trim()== ''){
}else{
	picUrls = temp.split(",");
}
var app = new Vue({
		el : '#app',
		data : {
			picUrls : picUrls,
			promotionName : '',
			skuCustomAttr : '',
			limitTime : '',
			saleNum : '',
			realPrice : '',
			productDesc : '',
			noDesc : true,
			onSale : true,
			realStock : '',
			sku : [],
			userStartTime :'', 	<#--使用开始时间-->
			userEndTime : '',	<#--使用到期时间-->
			personQuotaNum : '', <#--限购数-->
			buyNum : 1,
			evaluateUrl :''
		},
		methods : {
			deNum : function(){
				this.buyNum = eval(parseInt(this.buyNum)-1);
				this.checkNum();
			},
			inNum : function(){
				this.buyNum = eval(parseInt(this.buyNum)+1);
				this.checkNum();
			},
			checkNum : function(){
				if(this.buyNum > this.personQuotaNum){
					this.buyNum = 1;
					mui.alert('该团购每人限购'+this.personQuotaNum+',请重新选择数量！'); 
				}
				this.buyNum <= 0?this.buyNum = 1:'';
				this.buyNum > this.realStock?this.buyNum = this.realStock:'';
				if(parseInt(this.buyNum) == 1){
					$(".number-minus").addClass("disabled")
				}else{
					$(".number-minus").removeClass("disabled")
				}
				if(parseInt(this.buyNum) == this.realStock){
					$(".number-plus").addClass("disabled");
				}else{
					$(".number-plus").removeClass("disabled");
				}
			},
			toPay : function(){
				window.location.href = '/m/account/groupPurchaseOrder/toGroupPay?buyNum='+this.buyNum+'&promotionId='+$('#promotionId').val();
			}
		}
	});

var productId;
var userLevelLimit;
var grouponPersonQuotaNum;

$(function(){
	$.ajax({
		url : '${ctx}/m/groupPurchase/jsonDetail?promotionId='+$('#promotionId').val(),
		type : 'get',
		success : function(data){
			app.promotionName = data.promotionName;
			app.skuCustomAttr = data.grouponDesc;
			app.limitTime = new Date(data.enableEndTime).format('yyyy-MM-dd');
			app.saleNum = data.saleNum;
			app.realPrice = data.grouponPrice.toFixed(2);
			app.realStock = data.realStock;
			app.sku = data.sku;
			if(data.productDetailDesc == null||data.productDetailDesc.trim()==''){
				app.noDesc = true;
			}else{
				app.noDesc = false;
				app.productDesc = data.productDetailDesc;
			}
			app.onSale = data.realStock > 0?true:false;
			app.userStartTime = data.userStartTime;
			app.userEndTime = data.userEndTime;
			app.personQuotaNum = data.personQuotaNum;
			app.evaluateUrl = "/m/product/evaluation?productId="+data.masterProductID;
			userLevelLimit = data.userLevelLimit;
			productId = data.productId;
			app.personQuotaNum = data.grouponPersonQuotaNum;
			initSwiper();
		}
	});
	
	// tab栏固顶
	var tabBar = $("#J_DetailTab");
	$(window).on("scroll", function() {
		var tabTop = tabBar.offset().top;
		if (document.body.scrollTop > tabTop) {
			tabBar.addClass("fixed");
		} else {
			tabBar.removeClass("fixed");
		}
	});

	var detailContent = $('#J_DetailContent');
	detailContent.find('[width],[height]').css({
		width : 'auto',
		height : 'auto'
	});
	detailContent.find("img").css({
		width : "auto",
		height : "auto",
		margin : "20px auto",
		display : "block"
	}).unveil(0, function() {
		var img = $(this);
		img.one("load", function() {
			img.css({
				width : "auto",
				height : "auto",
				margin : "auto"
			});
		});
	});

	// 商品规格
	$(".prop-list li").each(function() {
		if (!$(this).hasClass("disabled")) {
			$(this).on("click", function() {
				$(this).addClass("active").siblings().removeClass("active");
			})
		}
	})

	// 图片详情产品参数tab
	$(".skutabbar li").click(function() {
		var idx = $(this).index();
		$(".skutabbar li").removeClass("selected");
		$(this).addClass("selected");
		$(".tabpag").hide().eq(isNaN(idx) ? 0 : idx).show();
	});

	// 选择参加促销活动
	var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function(e) {
				hideSpecAS();
			}).appendTo(document.body), specAS = $("#J_ASSpec");
	$("#J_BtnBuy").on("click", function() {
		//showSpecAS();
		var userId = $('#userId').val().trim();
		if(userId == null || userId == ''){
			mui.confirm('您尚未登录，请先登录！','请先登录',['确认','取消'],function(e){
				if(e.index == 0){
					window.location.href = "/m/login?successUrl=${ctx}/m/groupPurchase/detail/"+$('#promotionId').val();
				}
			});
			return false;
		}else{
			checkStockAndLevel();
		}
	});
	specAS.find(".close").on("click", function() {
		hideSpecAS();
	});
	
	function checkStockAndLevel(){
		//发送请求验证库存和用户等级
		$.get('${ctx}/m/groupPurchase/checkStock?promotionId='+$('#promotionId').val(),function(data){
			if(data.userLevel<0){
				//跳转到登录页面
				mui.confirm('您尚未登录，请先登录！','请先登录',['确认','取消'],function(e){
					if(e.index == 0){
						window.location.href = "/m/login?successUrl=${ctx}/m/groupPurchase/detail/"+$('#promotionId').val();
					}
				});
				return false;
			}/*else if(userLevelLimit.indexOf(data.userLevel.toString()) < 0){
				mui.alert('很遗憾，您的等级不符合购买条件！');
				return false;
			}*/
			if(data.countUserBuyNum >= grouponPersonQuotaNum){
				mui.alert('您购买的次数已经超过限购次数！');
				return false;
			}
			if(data.stock<=0){
				app.realStock = 0;
				app.onSale = false;
				mui.alert('很遗憾，改团购商品已经售尽！');
				return false;
			}else{
				app.realStock = data.stock;
				showSpecAS();
			}
		});
	}
	
	function showSpecAS() {
		
		specASMask.show().animate({
			opacity : 1
		}, {
			duration : 80,
			complete : function() {
				specAS.css({
					top : "100%",
					opacity : 0,
					display : "block"
				}).animate({
					opacity : 1,
					translateY : "-" + specAS.height() + "px"
				}, {
					duration : 200,
					easing : "ease-in-out"
				});
			}
		});
		$(document).bind("touchmove", function(e) {
			e.preventDefault();
		});
		$('.actionsheet-spec .spec-list.detail')[0].addEventListener(
				'touchmove', function(e) {
					e.stopPropagation();
				}, false);
	}

	function hideSpecAS(callback) {
		specAS.animate({
			opacity : 0,
			translateY : 0
		}, {
			duration : 200,
			easing : "ease-in-out",
			complete : function() {
				specAS.hide();
				specASMask.animate({
					opacity : 0
				}, {
					duration : 80,
					complete : function() {
						specASMask.hide();
						if (typeof callback == "function")
							callback.call();
					}
				});
			}
		});
		$(document).unbind("touchmove");
	}
});

	//初始化图片展示区
	function initSwiper(){
		var swiper = new Swiper('.swiper-container', {
			pagination : '.swiper-pagination',
			paginationType : 'fraction',
			loop : true,
			preloadImages : false,
			lazyLoading : true
		});
	}
</script>
</body>
</html>