<#assign ctx = request.contextPath>
<#assign mobileMenuLogo = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileMenuLogo()?default("")>

<div class="globalMenu">
    <div class="gbt-wrap">
        <ul>
            <#assign showIndex_=0/>
            <#if showIndex?? && showIndex?has_content>
                <#assign showIndex_ = showIndex/>
            </#if>

            <li <#if showIndex_==1>class="current"</#if>>
                <a href="${ctx}/m/index.html">
                    <span class="gbt-ico iconfont">&#xe613;</span>
                    <span class="gbt-text">首页</span>
                </a>
            </li>

            <li <#if showIndex_==2>class="current"</#if>>
                <a href="${ctx}/m/category/list.html">
                    <span class="gbt-ico iconfont">&#xe60b;</span>
                    <span class="gbt-text">商品分类</span>
                </a>
            </li>

            <li <#if showIndex_==4>class="current"</#if>>
                <a href="${ctx}/m/cart/list">
                    <span class="gbt-ico iconfont">&#xe611;</span>
                    <span class="gbt-text">购物车</span>
                </a>
            </li>

            <li <#if showIndex_==5>class="current"</#if>>
                <a href="${ctx}/m/account">
                    <span class="gbt-ico iconfont">&#xe61e;</span>
                    <span class="gbt-text">个人中心</span>
                </a>
            </li>
        </ul>
    </div>
</div>
