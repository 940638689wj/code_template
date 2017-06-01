<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/">
<#assign topCategoryList = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getProductCategoryGroupByGroup(1)?default("")>
<#assign foodCategoryList = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getProductCategoryGroupByGroup(2)?default("")>
<#assign pcNav = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getPcNav()?default("")>
<div id="nav">

    <div class="navWrap">
        <div class="nav-catalog">
            <div class="catalog-wrap">
                <h2 class="catalog-title">
                    <span>全部商品分类</span>
                </h2>
                <div class="catalog-block">
                <#if topCategoryList?has_content>
                    <ul>
                        <li>
                            <span><a href="${ctx}/products/0.html">全部商品</a></span>
                        </li>
                        <#list topCategoryList as top>
                            <li>
                                <span><a href="${ctx}/products/${(top.categoryId)?default(0)?c}.html">${(top.categoryName)?html}</a></span>
                                <p>
                                    <#list top.childProductCategory as childPC>
                                        <a href="${ctx}/products/${(childPC.categoryId)?default(0)?c}.html">${(childPC.categoryName!)?html}</a>
                                    </#list>
                                </p>
                            </li>
                        </#list>
                    </ul>
                </#if>
                </div>
            </div>
            <div class="navigation">
                <ul>
                    <#--<ul>-->
                        <#--<li data-navmenu="snav_item1" class="site-nav-item"><a href="${ctx}/index.html">首页</a></li>-->
                        <#--<li data-navmenu="snav_item2" class="site-nav-item"><a href="${ctx}/products/0.html">各地特产</a></li>-->
                        <#--<li data-navmenu="snav_item3" class="site-nav-item"><a href="${ctx}/products/0.html">厦航糕点</a></li>-->
                        <#--<li data-navmenu="snav_item2" class="site-nav-item"><a href="${ctx}/products/0.html">厦航特色</a></li>-->
                        <#--<li data-navmenu="snav_item2" class="site-nav-item"><a href="${ctx}/products/0.html">厦航团购</a></li>-->
                        <#--<li data-navmenu="snav_item2" class="site-nav-item"><a href="${ctx}/products/0.html">积分商城</a></li>-->
                        <#--<li data-navmenu="snav_item2" class="site-nav-item"><a href="${ctx}/products/0.html">提货券兑换</a></li>-->
                    <#--</ul>-->
                    <ul>
                        <li data-navmenu="snav_item1" class="site-nav-item"><a href="${ctx}/index.html">首页</a></li>
                    <#if pcNav?has_content && (pcNav.navs)?has_content>
                        <#assign navs = pcNav.navs>
                        <#list navs as nav>
                            <li data-navmenu="snav_item1" class="site-nav-item">
                                <a href="${ctx}/${(nav.linkUrl)!?default("")}">${(nav.name)!?default("")}</a>
                            </li>
                        </#list>
                    </#if>
                    </ul>
                </ul>
            </div>
        </div>
    </div>
</div>


</div>