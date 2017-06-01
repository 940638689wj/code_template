<#assign ctx=request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>预览历史</title>
</head>
<body>
<#include "include/header.ftl">

    <div class="center-layout">
    <#include "include/menu.ftl" />
        <div class="center-content">
            <div class="content-titel"><h3>会员中心<span><em>_</em>浏览历史</span></h3></div>
            <div class="section section-favourite">
                <ul> 
                <#if productList?? && productList?has_content>      
                   <#list productList as product>
                        <#assign productIdStr = (product.productId)?string>  
                        <#assign regionPrice = "">
                        <#assign imgUrl = "">
                        <#if historyProductsRegionPriceMap?? && (historyProductsRegionPriceMap?size > 0) >  
                            <#if historyProductsRegionPriceMap[productIdStr]??>  
                                <#assign regionPrice = historyProductsRegionPriceMap[productIdStr]>
                            </#if>      
                        </#if> 
                                <li>
                                    <div class="pic"><a href="#"><img src="${(product.picUrl)!}"></a></div>
                                    <p class="name"><a href="#">${(product.productName)!?html}</a></p>
                                    <p class="money"><span>¥<strong>${regionPrice!(product.defaultPrice)}</strong></span></p>
                                    <a class="buy-link" href="${ctx}/product/${(product.productId)!}">立即购买</a>
                                </li>
                    </#list>
                </#if>
                </ul>
            </div>
        </div>
    </div>
<script>
    $(function () {
        $("#menu_history").addClass("current");
    });
</script>
</body>
</html>