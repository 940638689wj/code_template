<#assign templateType = "">
<#assign searchkey = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getSearchWordHtml(templateType)?default("")>
<#assign searchRight = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getSearchRightTemplate(templateType)?default("")>
<#assign pcLogo = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcLogo()?default("")>
<#assign ctx = request.contextPath>
<div class="top-container header-main">
    <div class="header-logo">
        <a href="${ctx}/"><img src="${pcLogo!images/logo.png}"></a>
    </div>
    <div class="topshopcart" id="headerCart">
        <a href="${ctx}/cart/list" class="header-cart"><span>我的购物车</span><em
                id="headCartCount">${(cart.itemCount)!}</em></a>
        <div class="header-cart-popup" id="mini-cart-container">
        </div>
    </div>
    <div class="topsearch">
        <form target="_top" action="${ctx}/products/0.html" name="search">
            <div class="search-panel">
                <input type="text" <#--name="q" disabled--> style="display:none">
                <input type="text" name="q" value="${searchKey!}" placeholder="搜索商品">
                <button type="submit">搜索</button>
            </div>
        </form>
        <div class="hotsearch">
        ${searchkey!}
        </div>
    </div>
</div>

<script type="text/javascript">
    $(function () {
        getCartCount();
    });

	function getCartCount(){
		$.ajax({
            url: '${ctx}/cart/getCartCount',
            type: "GET",
            dataType: "json",
            success: function (data) {
                if (data) {
                    $('#headCartCount').html(data.productCount);
                }
            },
            error: function (e) {
            }
        });
	}
    $("#headerCart").hover(getCartContent, removeCartContent);
    function getCartContent() {
        var url = "${ctx}/cart/getMiniCartInfo";
        $.ajax({
            url: url,
            type: "GET",
            dataType: 'html',
            success: function (data) {
                $("#mini-cart-container").html(data);
            },
            error: function (e) {
            }
        });
        $("#headerCart").addClass("cart-hover");
    }
    function removeCartContent() {
        $("#headerCart").removeClass("cart-hover");
    }
</script>