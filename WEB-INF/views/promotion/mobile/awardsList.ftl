<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">

<#include "${ctx}/macro/sa/roma_macro.ftl"/>

<!doctype html>
<html>
<head>
    <title>我的奖品</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">我的奖品</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <div class="borderbox">
            <ul class="prd-list browse-lst prize-lst">
            <#if page?has_content>
                <#list page.content as one>
                    <li>
                        <div class="pic">
                            <#if one.awardsItemName == "积分">
                                <img src="${ctx}/static/mobile/images/credit.png">
                            <#elseif one.awardsItemName == "优惠劵">
                                <img src="${ctx}/static/mobile/images/coupon.png">
                            <#elseif one.awardsItemName == "红包">
                                <img src="${ctx}/static/mobile/images/briberyMoney.png">
                            <#else>
                                <img src="${(one.itemPicUrl)!}">
                            </#if>
                        </div>

                        <h3>${(one.awardsItemName)!}</h3>
                        <span class="num">数量：1</span>
                        <div class="source"><p>来源：<#if one.awardTypeCd?has_content><#if one.awardTypeCd == 1>
                            大转盘</#if></#if>
                            <#if one.awardTypeCd?has_content><#if one.awardTypeCd == 2>幸运刮刮卡</#if></#if>
                        </p>  <#if one.status>
                            <em class="disabled">已领取</em>
                        <#else>
                            <em><a onClick="getAwards(${(one.id)!})">待领取</a></em>
                        </#if>
                        </div>
                    </li>
                </#list>
            <#else>
                亲，你还没有奖品记录哦!
            </#if>
            </ul>
        <@pager1 page "/m/awards/list" "searchForm"/>
        </div>
    </div>
</div>


<script>
    function getAwards(id) {
        $.ajax({
            url: '${ctx}/m/awards/getAwards?id=' + id,
            type: 'post',
            data: {},
            cache: false,
            dataType: 'html',
            success: function (res) {
                if (res) {
                    mui.toast("领取成功!");
                    location.href = '${ctx}/m/awards/list';
                }
            },
            error: function () {
                //nothing
            }
        });
    }
</script>

</body>
</html>
