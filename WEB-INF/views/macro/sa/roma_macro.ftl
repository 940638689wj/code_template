
<#-- adminUser 的权限判断
    ifAnyGranted: 要被判断的权限限，多个权限项可用 ,(逗号) 分隔
-->
<#macro securityAuthorize ifAnyGranted>
    <#assign hasPermission = Static["cn.yr.chile.common.helper.SiteConfigHelper"].securityAuthorize(ifAnyGranted)>
    <#if hasPermission>
        <#nested>
    </#if>
</#macro>

<#macro showMoney price isNumerical=false>
    <#if isNumerical>
        ￥${price?default(0)?string(",##0.00")}
    <#else>
        ${price?default(0)?string(",##0.00")}
    </#if>
</#macro>

<#macro moneyFormat price isNumerical=false>
    <#if isNumerical>
    ${price?default(0)?string(",##0.00")}
    <#else>
    ${price?default(0)?string(",##0.00")}
    </#if>
</#macro>


<#-- 产品的列表图片-->
<#macro productImage product showType=''>
<img src="/admin/${(product.media['primary'].url)!}<#if showType?has_content>?${showType}</#if>" style="width:80px;height: 80px" title="${product.name?default("")?html}" />
</#macro>

<#macro formatProductThumbnailImage product >
    /admin/${(product.media['primary'].url)!}?largeAdminThumbnail
</#macro>

<#macro formatMediaThumbnailImage mediaUrl>
    /admin/${(mediaUrl)!}?largeAdminThumbnail
</#macro>


<#macro showOrderProductInfo ctx orderItem isLoop=true>
<#local product = orderItem.product/>
<div class="goodsinfo">
    <div class="goodspic">
        <#if fromAdminSystem??&&fromAdminSystem>
            <a href="${ctx}/admin/adminProduct/edit?id=${product.id!}">
                <@productImage product "thumbnail"/></a>
        <#else>
           <@productImage product "thumbnail"/>
        </#if>
    </div>
    <div class="goodsname"><#--<a href="${ctx}/product/${product.id}.html">-->
    ${product.name?default("")?html}<#--</a>--></div>
    <div class="goodsprop">
        <#local itemAttrMap = orderItem.orderItemAttributes!""/>
        <#if itemAttrMap?has_content && product.productOptions?has_content>
            <#list itemAttrMap?keys as key>
                <#assign itemAttr = itemAttrMap[key]/>
                <#if isLoop??&&isLoop=true>
                    <#list product.productOptions as productOption>
                        <#if productOption.attributeName==key && itemAttr.value?has_content>
                            ${productOption.label!} ${itemAttr.value!}&nbsp;&nbsp;&nbsp;&nbsp;
                            <#break/>
                        </#if>
                    </#list>
                <#else>
                    ${itemAttr.name!} ${itemAttr.value!}&nbsp;&nbsp;&nbsp;&nbsp;
                </#if>
            </#list>
        </#if>
    </div>
</div>
</#macro>

<#macro starView onStarCout onPic offPic>
    <#list 1..5 as temp>
        <#if temp lte onStarCout>
            <img src="${onPic}">
        <#else>
            <img src="${offPic}">
        </#if>
    </#list>
</#macro>

<#macro showSource source>
    <#if source=="qq">
    腾讯微博
    <#elseif source=="alipay">
    支付宝
    <#elseif source=="sina">
    新浪微博
    <#elseif source=="weixin">
    微信
    <#elseif source=="qq">
    注册顾客
    </#if>
</#macro>


<#macro showProductCategoryOptions parent level currentId currentParentId selectedCategoryId>
    <#if parent?has_content>
    <option <#if selectedCategoryId?string != "-1" && parent.categoryId?string==selectedCategoryId?string>selected="selected"</#if> value="${parent.categoryId}"><#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${parent.categoryName!}</option>
    </#if>
    <#if parent?has_content && parent.allChildCategories?has_content>
        <#list parent.allChildCategories as child>
            <@showProductCategoryOptions child level+1 currentId currentParentId selectedCategoryId/>
        </#list>
    </#if>
</#macro>


<#macro OrderApplyProductImage product>
    <img src="/admin/${(product.media['primary'].url)!}?thumbnail" title="${product.name?default("")?html}" />
</#macro>
<#macro showOrderApplyProductInfo ctx orderItem>
    <#local product = orderItem.product/>
<div class="refund-side-prod">
    <div class="prod-img">
        <#--<a href="${ctx}/product/${product.id}.html">-->
            <@OrderApplyProductImage product/>
        <#--</a>-->
    </div>
    <div class="prod-name"><a href="${ctx}/product/${product.id}.html" target="_blank">
    ${product.name?default("")?html}</a></div>
    <div class="prod-info">
        <#local itemAttrMap = orderItem.orderItemAttributes!""/>
        <#if itemAttrMap?has_content && product.productOptions?has_content>
            <#list itemAttrMap?keys as key>
                <#assign itemAttr = itemAttrMap[key]/>
                <#list product.productOptions as productOption>
                    <#if productOption.attributeName==key && itemAttr.value?has_content>
                    ${productOption.label!} ${itemAttr.value}&nbsp;&nbsp;&nbsp;&nbsp;
                        <#break/>
                    </#if>
                </#list>
            </#list>
        </#if>
    </div>
</div>
</#macro>

<#macro showProductOption product orderItem>
    <#local isFirst=true/>
    <#local itemAttrMap = orderItem.orderItemAttributes!""/>
    <#if itemAttrMap?has_content && product.productOptions?has_content>
        <#list itemAttrMap?keys as key>
            <#assign itemAttr = itemAttrMap[key]/>
            <#list product.productOptions as productOption>
                <#if productOption.attributeName==key && itemAttr.value?has_content>
                    <#if isFirst>
                        ${(itemAttr.value)?html}
                    <#else>
                        &nbsp;-&nbsp;${(itemAttr.value)?html}
                    </#if>

                    <#local isFirst=false/>
                    <#break/>
                </#if>
            </#list>
        </#list>
    </#if>
</#macro>

<#--分页-->
<#macro pager pageDTO basicUrl steps=3 >
    <#assign page = pageDTO.page>
    <#assign totalPages = pageDTO.totalPage>

    <#assign startRangeIndex = page - steps/>
    <#if startRangeIndex lt 1>
        <#assign startRangeIndex = 1/>
    </#if>

    <#assign endRangeIndex = startRangeIndex + steps/>
    <#if endRangeIndex gt totalPages>
        <#assign endRangeIndex = totalPages/>
    </#if>


    <#if page gt 1>
    <li><a href="${basicUrl}?pageIndex=${page-1}">«  上一页</a></li>
    <#else>
    <li class="disabled"><a href="#">«  上一页</a></li>
    </#if>

    <#if endRangeIndex==0>
        <li class="active"><a href="${basicUrl}?pageIndex=${page}">${page}</a></li>
    <#else >
        <#list startRangeIndex..endRangeIndex as currPage>
            <#if currPage==page>
            <li class="active"><a href="${basicUrl}?pageIndex=${page}">${page}</a></li>
            <#else >
            <li><a href="${basicUrl}?pageIndex=${currPage}">${currPage}</a></li>
            </#if>
        </#list>
    </#if>


    <#if page lt totalPages>
    <li><a href="${basicUrl}?pageIndex=${page+1}">下一页 »</a></li>
    <#else>
    <li class="disabled" ><a href="#">下一页 »</a></li>
    </#if>
</#macro>


<#--
分页宏
传入pageAction，不传formId 会自动创建form 如：<@pager pageModel "${ctx}/user/balance"/>
-->
<#macro pager1 pageModel pageAction formId="">
    <#assign pagerFormId="pagerForm">
    <#if formId?has_content>
        <#assign pagerFormId="${formId}">
    </#if>

    <#if pageAction?has_content>
        <form action="${pageAction}" id="${pagerFormId}" method="POST">
            <input type="hidden" name="goToPage" value="${pageModel.page?default(0)}"/>
        </form>
    </#if>

<div class="pagination">
    <a href="javascript:prevPage();" class="pg-prev">上一页</a>
    <span <#if (pageModel.totalPage) gt 1>id="pg-select"</#if> class="pg-select">${pageModel.page}/#{pageModel.totalPage}</span>
    <a href="javascript:nextPage();" class="pg-next">下一页</a>
</div>
<script type="text/javascript">
    //<![CDATA[
    var currentPage = ${pageModel.page};
    var totalPage = ${pageModel.totalPage};
    function prevPage() {
        if (currentPage <= 1) {
            return;
        }
        currentPage--;
        toPage(currentPage);
    }
    function nextPage() {
        if (currentPage > (totalPage-1)) {
            return;
        }
        currentPage++;
        toPage(currentPage);
    }
    function toPage(toPageIndex) {
        <#if pageAction?has_content>
            var limit = "${(pageModel.pageSize)?default(6)}", start = (toPageIndex - 1) * limit;
            if("${pageAction!}".indexOf("?")>0){
                window.location.href = "${pageAction!}&goToPage=" + toPageIndex+"&page="+toPageIndex + "&limit=" + limit + "&start=" + start;
            } else{
                window.location.href = "${pageAction!}?goToPage=" + toPageIndex+"&page="+toPageIndex + "&limit=" + limit + "&start=" + start;;
            }
        <#else>
            var obj1 = $("<input type='hidden' name='goToPage'/> ");
            obj1.val(toPageIndex);
            obj1.appendTo($("#${pagerFormId}"));

            var obj2 = $("<input type='hidden' name='page'/> ");
            obj2.val(toPageIndex);
            obj2.appendTo($("#${pagerFormId}"));

            var start = $("<input type='hidden' name='start'/> "), limit = $("<input type='hidden' name='limit' value='6'/> ");
            start.val((toPageIndex - 1) * limit.val());
            start.appendTo($("#${pagerFormId}"));
            limit.appendTo($("#${pagerFormId}"));
            $("[name='page']").val(toPageIndex);
            $("#${pagerFormId}").submit();
        </#if>
    }

    $(function () {
        $("#pg-select").dropmenu({
            content:[
                <#assign currIndex=pageModel.page-1/>
                <#assign totalPage = pageModel.totalPage-1/>
                <#assign startIndex = 0/>
                <#assign endIndex =totalPage/>
                <#if endIndex lt 0><#assign endIndex=0/></#if>
                <#if !(startIndex ==0 && endIndex==0)>
                    <#assign indexList = startIndex..endIndex/>
                    <#assign indexListSize = indexList?size - 1>
                    <#list indexList as index>
                        {text:'${index+1}',href:'javascript:toPage(${index + 1});'}<#if index_index lt indexListSize>,</#if>
                    </#list>
                </#if>
            ]
        });
    });
    //]]>
</script>
</#macro>

<#macro selectOptions selectList value label currentValue>
    <#if selectList?? && selectList?size gt 0>
        <#list selectList as select>
            <option value="${(select[value])?default("")}" <#if currentValue?? && (select[value])?? && currentValue?string == select[value]?string>selected="selected" </#if>>${(select[label]?default(""))}</option>
        </#list>
    </#if>
</#macro>

<#macro select selectList value label currentValue defaultValue defaultLabel name id>
    <select id="${id!}" name="${name!}">
        <#if defaultLabel??>
            <option value="${defaultValue!}">${defaultLabel!}</option>
        </#if>
        <@selectOptions selectList value label currentValue></@selectOptions>
    </select>
</#macro>

<#macro selectFast selectList value label defaultLabel name id>
    <@select selectList value label "" "" defaultLabel name id></@select>
</#macro>

<#macro selectCategory selectList currentValue defaultLabel name id>
    <select id="${id!}" name="${name!}">
        <#if defaultLabel??>
            <option value="">${defaultLabel!}</option>
        </#if>
        <@selectCategoryOptions selectList currentValue></@selectCategoryOptions>
    </select>
</#macro>

<#macro selectCategoryOptions selectList currentValue>
    <#if selectList?? && selectList?size gt 0>
        <#list selectList as category>
            <#assign currentId = (category[value])?default(-1)/>
            <#assign currentParentId = (category.defaultParentCategory.id)?default(-1)/>
            <@showProductCategoryOptions category 0 currentId currentParentId currentValue/>
        </#list>
    </#if>
</#macro>


<#macro pager1 pageModel pageAction formId="">
    <#assign pagerFormId="pagerForm">
    <#if formId?has_content>
        <#assign pagerFormId="${formId}">
    </#if>

    <#if pageAction?has_content>
        <form action="${pageAction}" id="${pagerFormId}" method="POST">
            <input type="hidden" name="goToPage" value="${pageModel.page?default(0)}"/>
        </form>
    </#if>

<div class="pagination">
    <a href="javascript:prevPage();" class="pg-prev">上一页</a>
    <span <#if (pageModel.totalPage) gt 1>id="pg-select"</#if> class="pg-select">${pageModel.page}/#{pageModel.totalPage}</span>
    <a href="javascript:nextPage();" class="pg-next">下一页</a>
</div>
<script type="text/javascript">
    //<![CDATA[
    var currentPage = ${pageModel.page};
    var totalPage = ${pageModel.totalPage};
    function prevPage() {
        if (currentPage <= 1) {
            return;
        }
        currentPage--;
        toPage(currentPage);
    }
    function nextPage() {
        if (currentPage > (totalPage-1)) {
            return;
        }
        currentPage++;
        toPage(currentPage);
    }
    function toPage(toPageIndex) {
        <#if pageAction?has_content>
            var limit = "${(pageModel.pageSize)?default(6)}", start = (toPageIndex - 1) * limit;
            if("${pageAction!}".indexOf("?")>0){
                window.location.href = "${pageAction!}&goToPage=" + toPageIndex+"&page="+toPageIndex + "&limit=" + limit + "&start=" + start;
            } else{
                window.location.href = "${pageAction!}?goToPage=" + toPageIndex+"&page="+toPageIndex + "&limit=" + limit + "&start=" + start;;
            }
        <#else>
            var obj1 = $("<input type='hidden' name='goToPage'/> ");
            obj1.val(toPageIndex);
            obj1.appendTo($("#${pagerFormId}"));

            var obj2 = $("<input type='hidden' name='page'/> ");
            obj2.val(toPageIndex);
            obj2.appendTo($("#${pagerFormId}"));

            var start = $("<input type='hidden' name='start'/> "), limit = $("<input type='hidden' name='limit' value='6'/> ");
            start.val((toPageIndex - 1) * limit.val());
            start.appendTo($("#${pagerFormId}"));
            limit.appendTo($("#${pagerFormId}"));
            $("[name='page']").val(toPageIndex);
            $("#${pagerFormId}").submit();
        </#if>
    }

    //]]>
</script>
</#macro>