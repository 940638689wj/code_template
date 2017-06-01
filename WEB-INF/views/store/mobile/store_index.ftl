<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>门店</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}css/module.css" />-->
    <link rel="stylesheet" type="text/css" href="${staticPath}css/storeinstore.css" />
    <!--<script type="text/javascript" src="${staticPath}js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}js/jquery.unveil.js"></script>-->
    <script type="text/javascript" src="${staticPath}/js/modules.js"></script>
    <script type="text/javascript" src="${staticPath}js/rateit.js"></script>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">门店</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="store-top" style="background-image: url('${(store.storeLogoUrl)!}');"></div>
            <div class="in-header in-storeheader">
                <div class="hd">
                    <div class="info">
                        <h3>${(store.storeName)!}</h3>
                        <p>店铺编号${(store.storeNumber)!}</p>
                    </div>
                </div>
                <div class="bd">
                	<#if collect??>
                    <div class="collection selected">已收藏</div>
                    <#else>
                    <div class="collection">收藏</div>
                    </#if>
                    <a class="storeyards" href="${ctx}/m/store/toQrCode?storeId=${(store.storeId)!'0'}"></a>
                </div>
            </div>
            <!--
            <div class="storeevaluation">
                <span class="rateit" data-rateit-value="4" data-rateit-readonly="true" data-rateit-starwidth="25" data-rateit-starheight="20"></span>
                <span class="score">4.0</span>
            </div>
            -->
            <div class="borderbox">
                <ul class="store-contact">
                    <li><span class="address"></span><p>${(store.provinceName)!}${(store.cityName)!}${(store.countyName)!}${(store.detailAddress)!}</p></li>
                    <li><span class="tell"></span><p>${(store.telephone)!}</p></li>
                    <li>营业时间：8:00-23:00</li>
                </ul>
            </div>

           <!-- <div class="borderbox">
                <div class="viplatinos">
                    <h3>公告和活动</h3>
                    <div class="info black">
                        <p>文本信息文本信息文本信息文本信息文本信 息文本信息文本信息文本信息文本信息文本信息 文本信息文本信息文本信息文本信</p>
                    </div>
                </div>
            </div> -->
			<div class="containerwrap">
	            ${layoutHtml!}
	        </div>
	        
            <div class="borderbox">
                <div class="store-title">门店商品</div>
                <ul class="prd-list store-list">
                	<#if list??>
                	<#list list as goods>
						<#if !(goods_index>2)>                   
                    <li>
                        <a href="${ctx}/m/product/${goods.productId}">
                        <div class="pic">
                            <img src="${(goods.picUrl)!}">
                        </div>
                        <h3>${(goods.productName)!}</h3>
                        <p class="price mt24"><span class="price-real">￥<em>${(goods.defaultPrice)!}</em></span><span class="price-origin">${(goods.tagPrice)!}</span></p>
                        </a>
                    </li>
                    	</#if>
                    </#list>
                    <#if (list?size>3)>
                     <li class="more"><a href="${ctx}/m/store/storeGoods?storeId=${(store.storeId)!}">查看更多</a></li>
                    </#if>
                    </#if>
                </ul>
            </div>
            
            <div class="fbbwrap fbbwrap-total">
                <div class="ftbtnbar">
                    <div class="store-content-wrap">
                        <a href="tel:${(store.telephone)!'0'}" class="store-btn">联系店铺</a>
                    </div>
                    <div class="store-content-wrap">
                        <a href="${ctx}/m/store/toStoreMap/${(store.storeId)!}" class="store-btn entity" >到实体店</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script>
   $(function(){
        $(".collection").on("click", function () {
            var btn = $(this);
            var userId='${(userId)!''}';
            if(!btn.hasClass("selected")){
            	if(userId==null||userId==''){
	            	var btnArray = ['取消', '登录'];
		    		mui.confirm('', '你还未登录，请先登录', btnArray, function(e) {
			            if (e.index == 0) {
			            } else {
			           		 location.href="${ctx}/m/login?successUrl="+location.href;
			            }
			        });
            	}else{
            	 	//添加收藏
	            	$.post('${ctx}/m/account/collection/addStoreCollect',{type:1,collectId:${(store.storeId)!}},
	            	function(data){
	            		btn.html("已收藏");
                		mui.toast('添加收藏成功');
	            	});
            	}
            }else{
            	//添加收藏
	            	$.post('${ctx}/m/account/collection/cancelCollect',{type:1,collectId:${(store.storeId)!}},
	            	function(data){
	            		  btn.html("收藏");
                mui.toast('取消收藏');
	            	});
              
            }
            btn.toggleClass("selected");
        });
        
    })
    
</script>
</body>
</html>