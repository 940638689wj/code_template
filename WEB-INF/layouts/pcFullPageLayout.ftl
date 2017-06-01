<#assign ctx = request.contextPath>

<#assign pcUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcUrl()?default("")>
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<#assign mLogo = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileLogo()?default("")>

<!doctype html>
<html>
<head>
    <#include "partials/head.ftl"/>
</head>
<body <#if isIndex?? && isIndex>class="page-list"</#if>>

    <#include "partials/header.ftl"/>


${body}

<#include "partials/footer.ftl"/>


<script>
</script>
</body>
</html>