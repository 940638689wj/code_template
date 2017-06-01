<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>秒杀活动</title>

    <script type="text/javascript" src="${ctx}/static/mobile/js/jquery.countdown.js"></script>
</head>
<body>
<div id="page">
    <div class="mui-content">
        <div class="borderbox">

            <ul class="prd-list store-list snapup-list">
                <#if productList?? && productList?has_content>
                    <#list productList as productDTO>
                        <li>
                            <a href="${ctx}/m/product/${productDTO.productId}.html?pt=ms&pid=${productDTO.promotionId}">
                                <div class="pic">
                                    <img src="${(productDTO.picUrl)!}">
                                </div>

                                <h3>${(productDTO.productName)!}</h3>
                                <p class="price">
                                    <span class="price-real">￥<em>${(productDTO.secKillPrice)!}</em></span>
                                    <span class="price-origin">¥${(productDTO.defaultPrice)!}</span>
                                </p>
                                <div class="countdown">
                                    <div class="t">马上抢</div>
                                    <div class="c" data-countdown="flash_sale" data-end="${(productDTO.enableEndTime)?string('yyyy-MM-dd HH:mm:ss')}"
                                         data-start="${(productDTO.enableStartTime)?string('yyyy-MM-dd HH:mm:ss')}">
                                        <em class="days_1"></em><span class="days_2">天</span>
                                        <em class="hours_1"></em><span class="hours_2">时</span>
                                        <em class="minutes_1"></em><span class="minutes_2">分</span>
                                        <em class="seconds_1"></em><span class="seconds_2">秒</span>
                                    </div>
                                </div>
                            </a>
                        </li>
                    </#list>
                </#if>
            </ul>
        </div>

        <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
</div>
</body>
</html>
