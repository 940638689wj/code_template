<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的收藏</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
    <script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">我的收藏</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="tabbar">
                <ul>
                    <li><a href="${ctx}/m/account/collection/toGoods">商品</a></li>
                    <li class="selected"><a href="${ctx}/m/account/collection/toShop">微店</a></li>
                    <li><a href="${ctx}/m/account/collection/toStore">门店</a></li>
                </ul>
            </div>
            <div class="borderbox">
                <ul class="prd-list browse-lst prize-lst">
                <#if list??>
                <#list list as store>
                    <li>
                        <div class="pic">
                            <a href="${ctx}/m/store/${(store.storeId)!}"><img src="${(store.logoUrl)!}"></a>
                        </div>
                        <h3><a href="${ctx}/m/store/${(store.storeId)!}">${(store.mstoreName)!}</a></h3>
                        <div class="source"><p>店铺编号：</p>
                        <em class="cancelcollection" id="sure" value="" onclick="cancelCollect('${(store.userId)!}',this);">取消收藏</em>
                        </div>
                    </li>
                 </#list>
                 </#if>   
                </ul>
            </div>
        </div>
         	<#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
<script>
    function cancelCollect(collectId,obj){
    	  var btnArray = ['确认', '关闭'];
            mui.confirm('', '是否确认取消？', btnArray, function(e) {
               if (e.index == 0) {
               $.post('${ctx}/m/account/collection/cancelCollect',{'collectId':collectId,'type':2},function(data){
	               	if(data){
	               	    mui.toast('成功取消收藏');
	               		location.href='${ctx}/m/account/collection/toShop';
                   
	               	}else{
	               		mui.toast('取消收藏失败');
	               	}
               });
               }
           })
    }
</script>
</body>
</html>