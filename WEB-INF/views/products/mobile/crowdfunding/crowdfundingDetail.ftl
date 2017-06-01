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
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/crowdfunding/list"></a>
	        <h1 class="mui-title">商品详情</h1>
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
	                <p class="sku-custom-attr">{{promotionDesc}}</p>
	            </div>
                <p class="sku-sales-num">众筹结束时间：{{limitTime}}</p>
	            <div class="sku-price">
	                <div class="price-real">￥<strong>{{perAmt}}</strong></div>
	            </div>
	            <div class="funding-progress">
	                <div class="progressbar"><span v-bind:style="percent"></span></div><#-- v-bind:style="width: currentPeopleNum/requireNum%;" -->
	                <div class="count count-total">
	                    <em>{{requireNum}}</em><span>总需人次</span>
	                </div>
	                <div class="count count-current">
	                    <em>{{currentPeopleNum}}</em><span>已参与</span>
	                </div>
	                <div class="count count-remain">
	                    <em>{{requireNum-currentPeopleNum}}</em><span>剩余</span>
	                </div>
	            </div>
	        </div>
	
	        <div class="skutabbar" id="J_DetailTab">
	            <ul>
	                <li class="selected"><a href="javascript:void(0);">图文详情</a></li>
	                <li class=""><a class="itemlink" v-bind:href="allRecodeUrl">所有参与记录</a></li>
	            </ul>
	        </div>
	        <div class="sku-detail-content">
	            <div id="J_DetailContent" class="tabpag">
	                <div class="iconinfo" v-show="noDesc">
	                    <div class="ico ico-info"></div>
	                    <strong>暂无图片详情</strong>
	                </div>
	                <div v-html="productDetailDesc"></div>
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
	                    <a id="J_BtnBuy" class="button" v-on:click='toPay'>立即参与众筹</a>
	                </div>
	            </div>
	        </div>
	    </div>
	</div>
</div>
<script type='text/javascript'>
var temp = $('#picUrls').val();
var picUrls = [];
if (temp == null || temp.trim() == '') {} else {
    picUrls = temp.split(",");
}
var app = new Vue({
    el: '#app',
    data: {
        picUrls: picUrls,
        promotionName: '',
        requireNum: 0,
        currentPeopleNum: 0,
        productDetailDesc: '',
        perAmt: 0.00,
        personalJoinLimit: 0,
        promotionDesc: '',
        onSale: true,
        noDesc: false,
        allRecodeUrl :'${ctx}/m/account/crowdfundingOrder/toOrderRecode?promotionId='+$('#promotionId').val(),
        percent: 'width:0%',
        limitTime:''
    },
    methods: {
        toPay: function() {
            var userId = $("#userId").val();
            if (userId == null || userId == '') {
                mui.confirm('您尚未登录，请先登录！', '请先登录', ['确认', '取消'],
                function(e) {
                    if (e.index == 0) {
                        window.location.href = "/m/login?successUrl=${ctx}/m/crowdfunding/detail/" + $('#promotionId').val();
                    }
                });
                return false;
            } else {
                window.location.href = '/m/account/crowdfundingOrder/toPay?promotionId=' + $('#promotionId').val();
            }
        }
    }
});

$(function() {
    $.ajax({
        url: '${ctx}/m/crowdfunding/jsonDetail?promotionId=' + $('#promotionId').val(),
        type: 'get',
        success: function(data) {
            app.limitTime = new Date(data.endTime).format('yyyy-MM-dd');
            app.promotionName = data.promotionName;
            app.requireNum = data.requireNum.toFixed(0);
            if (data.productDetailDesc == null || data.productDetailDesc.trim() == '') {
                app.noDesc = true;
            } else {
                app.noDesc = false;
                app.productDetailDesc = data.productDetailDesc;
            }
            app.currentPeopleNum = data.currentPeopleNum;
            app.onSale = data.currentPeopleNum < data.requireNum ? true: false;
            app.promotionDesc = data.promotionDesc;
            app.personalJoinLimit = data.personalJoinLimit;
            app.perAmt = data.perAmt.toFixed(2);
            app.percent = 'width : ' + eval((app.currentPeopleNum / app.requireNum)*100) + '%'
        }
    });
});

$(function() {
    var swiper = new Swiper('.swiper-container', {
        pagination: '.swiper-pagination',
        paginationType: 'fraction',
        loop: true,
        preloadImages: false,
        lazyLoading: true,
    });

    //tab栏固顶
    var tabBar = $("#J_DetailTab");
    $(window).on("scroll",
    function() {
        var tabTop = tabBar.offset().top;
        if (document.body.scrollTop > tabTop) {
            tabBar.addClass("fixed");
        } else {
            tabBar.removeClass("fixed");
        }
    });

    var detailContent = $('#J_DetailContent');
    detailContent.find('[width],[height]').css({
        width: 'auto',
        height: 'auto'
    });
    detailContent.find("img").css({
        width: "auto",
        height: "auto",
        margin: "20px auto",
        display: "block"
    }).unveil(0,
    function() {
        var img = $(this);
        img.one("load",
        function() {
            img.css({
                width: "auto",
                height: "auto",
                margin: "auto"
            });
        });
    });

    //图片详情产品参数tab
    $(".skutabbar li").click(function() {
        var idx = $(this).index();
        $(".skutabbar li").removeClass("selected");
        $(this).addClass("selected");
        $(".tabpag").hide().eq(isNaN(idx) ? 0 : idx).show();
    });
})

</script>
</body>
</html>