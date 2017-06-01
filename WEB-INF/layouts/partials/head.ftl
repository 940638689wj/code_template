<#assign ctx = request.contextPath>

<#assign seoTitle = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoTitle()?default("")>
<#assign seoKeywords = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoKeywords()?default("")>
<#assign seoDescription = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoDescription()?default("")>
<#assign other = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoOther()?default("")>

<meta charset="UTF-8">

<#assign newTitle = title!/>

<title>${newTitle!}<#if seoTitle?? && seoTitle?has_content>-${seoTitle}</#if></title>

<#if other?has_content>${other!}</#if>

<meta name="keywords" content="<#if seoKeywords?has_content>${seoKeywords!} </#if>" />

<meta name="description" content="<#if seoDescription?has_content>${seoDescription!} </#if>" />

<link rel="stylesheet" href="${ctx}/static/css/global.css">
<link rel="stylesheet" href="${ctx}/static/css/style.css">
<link rel="stylesheet" href="${ctx}/static/css/mycenter.css">
<link rel="stylesheet" href="${ctx}/static/css/module.css">

<script src="${ctx}/static/js/jquery-1.11.0.min.js"></script>
<script src="${ctx}/static/js/jquery.placeholder.min.js"></script>
<script src="${ctx}/static/layer/layer.js"></script>
<script src="${ctx}/static/js/yrkj.js"></script>
<script src="${ctx}/static/js/avalon.min.js"></script>

${head!}

<link rel="stylesheet" href="${ctx}/common/pc/css">