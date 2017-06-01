<#assign ctx = request.contextPath>
<#--<div id="nav1>-->
    <#--<div class="navWrap">-->
        <#--<div class="nav-catalog">-->
            <#--<div class="catalog-wrap">-->
                <#--<h2 class="catalog-title">-->
                    <#--<a href="${ctx}/account">个人中心</a>-->
                <#--</h2>-->
            <#--</div>-->
        <#--</div>-->
    <#--</div>-->
<#--</div>-->
<script type="text/javascript">
    $(function () {
        var headerStr = '<div class="navWrap">'
                + '<div class="nav-catalog">'
                + '<div class="catalog-wrap">'
                + '<h2 class="catalog-title">'
                + '<a href="${ctx}/account">个人中心</a>'
                + '</h2>'
                + '</div>'
                + '</div>'
                + '</div>';
        $("#nav").html(headerStr);
//        $("#nav").css("display", "none");
    });
</script>