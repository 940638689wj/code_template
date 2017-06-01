<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<script type="text/javascript">
    function goToPage(targetPage){
        goTo = targetPage;
        if(!goTo){
            goTo = $("#goToPageText").val();
        }

        var numReg = /^[1-9]\d*$/
        if(!numReg.test(goTo)){
            alert("数值格式不合法，请重新输入!");
            $("#goToPageText").val('');
            $("#goToPageText").focus();
            return;
        }

        pageGoTo(goTo);
    }
</script>
<div class="pagination">
    <#assign currentPage = pageDTO.page>
    <#assign totalPage = pageDTO.totalPage>
    <#assign startPage = currentPage - 2>
    <#assign endPage = currentPage + 2>
    <#if (startPage < 1)>
        <#assign endPage = endPage + (1 - startPage)>
        <#assign startPage = 1>
    </#if>
    <#if (endPage > totalPage)>
        <#assign startPage = startPage - (endPage - totalPage)>
        <#if (startPage < 1)>
            <#assign startPage = 1>
        </#if>
        <#if totalPage == 0>
            <#assign endPage = 1>
        <#else>
            <#assign endPage = totalPage>
        </#if>
    </#if>
    <a href="javascript:void (0);" onclick="javascript:goToPage(1)">首页</a>
    <#if currentPage != 1>
        <a href="javascript:void (0);" onclick="javascript:goToPage(${currentPage -1})"  class="prev">上一页</a>
    </#if>
    <#if (startPage > 1)>
        <b>...</b>
    </#if>
    <#list startPage..endPage as page>
        <#if page == currentPage>
            <a href="javascript:void(0);" class="page-cur" style="height: auto;">${page}</a>
        <#else>
            <a href="javascript:void(0);" onclick="javascript:goToPage(${page})">${page}</a>
        </#if>
    </#list>
    <#if (endPage < totalPage)>
        <b>...</b>
    </#if>
    <#if currentPage != totalPage>
        <a href="javascript:void (0);" onclick="javascript:goToPage(${currentPage + 1})" class="next">下一页</a>
    </#if>
    <a href="javascript:void(0);" onclick="javascript:goToPage(${totalPage})">尾页</a>
    <span class="page-info">共 ${pageDTO.totalPage} 页</span>
    <span class="page-go">到第<input id="goToPageText" type="text">页
        <button type="button" onclick="javascript:goToPage()">确定</button>
    </span>
</div>