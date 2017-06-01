<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的微店</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}css/module.css" />-->
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}css/storeinstore.css" />
    <!--<script type="text/javascript" src="${staticResourcePath}js/zepto.js"></script>
    <script type="text/javascript" src="${staticResourcePath}js/mui.min.js"></script>
    <script type="text/javascript" src="${staticResourcePath}js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticResourcePath}js/jquery.unveil.js"></script>-->
    <script type="text/javascript" src="${staticResourcePath}/js/modules.js"></script>
    <script type="text/javascript" src="${staticResourcePath}js/frames.js"></script>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">我的微店</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="dec-top" style="background-image: url(${logourl!});"></div>
            <div class="in-header">
                <div class="hd">
                    <div class="shopfor" style="background-image: url(${userHead!});"></div>
                    <div class="info">
                        <h3><#if userMstore??>${userMstore.mstoreName!}</#if></h3>
                        <p>店铺编号<#if userMstore??>${userMstore.userId!}</#if></p>
                    </div>
                </div>
                <div class="bd">
                    <div class="collection">收藏</div>
                    <a class="storeyards" href="${ctx}/m/account/mstoreUser/toQrCode?userId=${mstoreId!'0'}"></a>
                </div>
            </div>
            <div class="containerwrap">
	            ${layoutHtml!}
	        </div>
            <div class="md-imgtxt-l1r2a">
            	<#if p1?? || p2?? || p3??>
            	<ul>
                	<li><#if p1??><a href="${ctx}/m/product/${p1.productId!0}"><img src="${(p1.picUrl)!}"><p>¥${p1.defaultPrice!}</p></a></#if></li>
                    <li><#if p2??><a href="${ctx}/m/product/${p2.productId!0}"><img src="${(p2.picUrl)!}"><p>¥${p2.defaultPrice !}</p></a></#if></li>
                    <li><#if p3??><a href="${ctx}/m/product/${p3.productId!0}"><img src="${(p3.picUrl)!}"><p>¥${(p3.defaultPrice)!}</p></a></#if></li>
                </ul>
            	</#if>
            </div>
            <div class="in-title"><h3>特卖活动</h3></div>
            <div class="sis-pdlist">
                <ul>
                	<#if productsForMstore??>
	                	<#list productsForMstore as pm>
	                		<#if (pm_index>2) >
	                			<li><a href="${ctx}/m/product/${pm.productId!0}">
			                        <div class="pic"><img src="${pm.picUrl!}"></div>
			                        <div class="price">¥${pm.defaultPrice !}</div>
			                   	 </a>
		                 	  	</li>
	                		</#if>
	                	</#list>
                	</#if>
                	
                	<#if productsForDefault??>
	                	<#list productsForDefault as pd>
	                			<li><a href="${ctx}/m/product/${pd.productId!0}">
			                        <div class="pic"><img src="${pd.picUrl!}"></div>
			                        <div class="price">¥${pd.defaultPrice !}</div>
			                   	 </a>
		                 	  	</li>
	                	</#list>
                	</#if>
                </ul>
            </div>
            
        </div>

        <div class="gbm-wechat">
            <div class="wrap">
                <div class="gbm-wechat-list">
                    <ul>
                        <li class="nav-item nav-item-home"><a href="${ctx}/m/account/mstoreUser/mstoreIndex?mstoreId=${mstoreId!}">微店首页</a></li>
                        <li class="nav-item"><a href="${ctx}/m/account/productmanager/goodCategory?mstoreId=${mstoreId!}"><span class="iconfont">&#xf0c9</span>商品分类</a>
                        </li>
                        <li class="nav-item"><a href="javascript:void(0)"><span class="iconfont">&#xf0c9</span>我</a>
                            <div class="gbm-wechat-sub" style="display: none;">
                                <ul>
                                    <li><a href="${ctx}/m/cart/mstoreCart">我的购物车</a></li>
                                    <li><a href="${ctx}/m/account/mstoreUser/toMstoreOrderList?type=0">我的订单</a></li>
                                </ul>
                            </div>
                        </li>
                        <li class="nav-item"><a href="javascript:void(0)"><span class="iconfont">&#xf0c9</span>用户服务</a>
                        	<div class="gbm-wechat-sub" style="display: none;">
                                <ul>
                                    <li><a href="${ctx}/m/account/mstoreUser/tNoticeList/3">操作指南</a></li>
                                    <li><a href="tel:95019">联系客服</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
<script>
    $(function(){
        $(".collection").on("click", function () {
            var btn = $(this);
            if(!btn.hasClass("selected")){
            	//添加收藏信息
            	$.get("${ctx}/m/account/mstoreUser/collectMstore",{collectId : ${mstoreId!}},function(data){
            		btn.html("已收藏");
                    mui.toast('添加收藏成功');
            	});
            }else{
            	//取消收藏
            	$.get("${ctx}/m/account/mstoreUser/cancelCollectMstore",{collectId : ${mstoreId!}},function(data){
            		btn.html("收藏");
                    mui.toast('取消收藏');
            	});
            }
            btn.toggleClass("selected");
        });
    })
</script>
</html>