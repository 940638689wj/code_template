<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#assign consultDetailList = pageDTO.content>
<div class="detail-consults">
    <h3 class="hd">商品咨询</h3>
    <div class="consult-list">
    <#include "consult_ajaxpage.ftl">
    </div>
</div>
<div class="pagination">
     <@pager pageDTO/>
</div>
<#macro pager pageDTO steps=3>
    <#assign page = pageDTO.page>
    <#assign totalPages = pageDTO.totalPage>

    <#assign startRangeIndex = page - steps/>
    <#if startRangeIndex lt 1>
        <#assign startRangeIndex = 1/>
    </#if>
    <#assign endRangeIndex = page + steps/>
    <#if endRangeIndex gte totalPages>
        <#assign endRangeIndex = totalPages/>
    </#if>

    <#if page gt 1>
        <a class="prev" href="javascript:goPage(${page -1});"><i></i>上一页</a>
    <#else>
        <a class="prev disabled"><i></i>上一页</a>
    </#if>
    <#if startRangeIndex gt 1>
        <a href='javascript:goPage(1);'>1</a> <b>...</b>
    </#if>
    <#list startRangeIndex..endRangeIndex as currPage>
        <#if currPage==page>
            <b class="page-cur">${page}</b>
        <#elseif currPage!=0>
            <a href='javascript:goPage(${currPage});'>${currPage}</a>
        </#if>
    </#list>
    <#if endRangeIndex lt totalPages>
        <b>...</b><a href='javascript:goPage(${totalPages});'>${totalPages}</a>
    </#if>
    <#if page lt totalPages>
        <a class="next" href="javascript:goPage(${page+1});">下一页<i></i></a>
    <#else>
        <a class="next disabled">下一页<i></i></a>
    </#if>
</#macro>
