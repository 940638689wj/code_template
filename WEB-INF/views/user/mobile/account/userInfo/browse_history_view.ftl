<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<#include "${ctx}/macro/sa/roma_macro.ftl">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>浏览历史</title>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">浏览历史</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="borderbox">
                <ul class="prd-list browse-lst">
            	<#if productList?? && productList?has_content>
	                <#list productList as product>
	                    <#assign productIdStr = (product.productId)?string>
	                    <#-- 区域价 -->
	                    <#assign regionPrice = "">
	                    <#assign imgUrl = "">
	                    <#if historyProductsRegionPriceMap?? && (historyProductsRegionPriceMap?size > 0) >
	                        <#if historyProductsRegionPriceMap[productIdStr]??>
	                            <#assign regionPrice = historyProductsRegionPriceMap[productIdStr]>
	                        </#if>	                         
	                    </#if>
	                    <li>
	                        <a href="${ctx}/m/product/${product.productId}">
	                            <div class="pic">
	                                <img src="${(product.picUrl)!}"  style="width:80px;height: 80px" title="${(product.productName)?default("")?html}" />
	                            </div>
	                            <h3>${(product.productName)!?html}</h3>
	                            <br/>
	                            <br/>
	                            <p><span class="price-browse"><em>&nbsp;￥</em>${regionPrice!(product.defaultPrice)}</span></p>
	                        </a> 
	                    </li>
	                 </#list>
				<#else>
			        <div class="iconinfo">
			            <i class="ico ico-info"></i>
			            <strong>亲，你还没浏览历史哦!</strong>
			        </div>	               
	            </#if>   
	         	</ul>
	         </div>
        </div>

    </div>
</body>
</html>