<div class="prd-music">
    <#assign rqCodeTitle = (product.productId)?default("")>
    <#if !(rqCodeTitle?has_content)>
        <#assign rqCodeTitle = ("ID_" + (product.productId)?default(""))>
    </#if>
    <#assign rqCodeTitle = rqCodeTitle + ".jpeg">
    <#assign rqCodeGenerateUrl = "${ctx}/admin/sa/productManage/viewWxQrCode?productId=${product.productId}&title=${rqCodeTitle}">
    <div><img src="${rqCodeGenerateUrl}"></div>
</div>