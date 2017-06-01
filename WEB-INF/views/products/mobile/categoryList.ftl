<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品分类</title>
</head>
<body>
    <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m"></a>
                <h1 class="mui-title"><#--<a href="/m/category/list.html">-->商品分类<#--</a>--></h1>
                <#--<h1 class="mui-title"><a href="/m/brand/list.html">品牌馆</a></h1>-->
            <a class="mui-icon"></a>
        </header>

        <div class="shelves-search">
            <div class="category-search">
                <input type="text" id="searchKey" value="${searchKey!}" placeholder="搜索您想要的商品">
                <button type="button" onclick="searchByKeyword();">搜索</button>
            </div>
        </div>

        <div class="mui-content">
            <div class="accordianlist">
                <div class="acitem">
                    <div class="actit"><div class="con"><a href="${ctx}/m/products/0.html">全部商品</a></div></div>
                </div>

                <#if productCategoryList?? && productCategoryList?has_content>
                    <#list productCategoryList as productCategory>
                        <div class="acitem ac-toggled">
                            <div class="actit">
                                <div class="con">
                                    <a href="${ctx}/m/products/${productCategory.categoryId}.html">${(productCategory.categoryName)!?html}</a>
                                </div>
                                <div class="ac-toggle-btn"></div>
                            </div>
                            <#if productCategory.childProductCategory?? && productCategory.childProductCategory?has_content>
                                <div class="accon">
                                    <ul class="prd-catlist">
                                        <#list productCategory.childProductCategory as childCategory>
                                            <li><a href="${ctx}/m/products/${childCategory.categoryId}.html">${(childCategory.categoryName)!?html}</a></li>
                                        </#list>
                                    </ul>
                                </div>
                            </#if>
                        </div>
                    </#list>
                </#if>
            </div>

            <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
        </div>
    </div>

<script>
    $(function(){
        $(".ac-toggle-btn").on("click",function() {
            var obj = $(this).closest(".acitem");
            if(obj.hasClass("ac-toggled")){
                $(".acitem").addClass("ac-toggled");
                obj.removeClass("ac-toggled");
            }else{
                obj.addClass("ac-toggled");
            }
        });
    })

    function searchByKeyword(){//搜索
        window.location.href="${ctx}/m/products/0.html?q="+$("#searchKey").val();
    }
</script>
</body>
</html>