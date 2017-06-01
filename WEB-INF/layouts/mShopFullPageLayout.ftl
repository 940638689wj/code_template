<#assign seoTitle = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoTitle()?default("")>
<#assign seoKeywords = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoKeywords()?default("")>
<#assign seoDescription = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoDescription()?default("")>
<#assign other = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoOther()?default("")>
<!doctype html>
<html>
<head>
	

<#if !titleSuffix?has_content>
    <#assign titleSuffix = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSiteName()?default("")>
</#if>
<#assign newTitle = ""/>
<#if titleSuffix?has_content && seoTitle?has_content>
    <#assign newTitle = seoTitle + " - " + titleSuffix/>
<#else>
    <#assign newTitle = seoTitle?default("") + titleSuffix?default("")/>
</#if>
<#if title?? && title?has_content>
    <#assign newTitle = title + " - " + newTitle />
</#if>

    <title>${newTitle!}</title>

    <meta charset="UTF-8">
	<meta name="keywords" content="<#if seoKeywords?has_content>${seoKeywords!} </#if>" />
    <meta name="description" content="<#if seoDescription?has_content>${seoDescription!} </#if>" />
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">

    <#if siteName?has_content>
        <meta name="apple-mobile-web-app-title" content="${siteName}"/>
    </#if>

    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/gmu.css?v=201506012147" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/ecmmobile.css?v=201506012147" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/storeinstore.css?v=201506012147" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/template/${tempalte.id!}/themes/${tempalteTheme!}/css/theme.css?v=0150">
    <script type="text/javascript" src="${staticPath}/js/zepto.js?v=201506012147"></script>
    <script type="text/javascript" src="${staticPath}/js/gmu.js?v=201506012147"></script>
    <script type="text/javascript" src="${staticPath}/js/ecmmobile.js?v=201506012147"></script>
    ${head}

    <link rel="stylesheet" href="${ctx}/common/mobile/css">
    <script>
        window.cache_data = {
            _pcUrl : "${pcUrl!}",
            _mobileUrl : "${mobileUrl!}",
            _mobileLogo : "${mLogo}"
        <#if isLogin?has_content && isLogin>
            ,isLogin : true
        </#if>
        };
    </script>
</head>
<body>
${body}
<script src="${ctx}/common/mobile/js"></script>
<script>
    function isWeiXin(){
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/MicroMessenger/i) == 'micromessenger'){
            return true;
        }else{
            return false;
        }
    }

    (function(cache_data){
        var _extend = function(a, b) {
            var _extend_ = function(a, b) {
                for (var key in b) {
                    a[key] = b[key];
                }
                return a;
            };
            return _extend_(_extend_({}, a), b);
        };
        window.wxData = _extend({
            img_url : [cache_data._pcUrl, cache_data._mobileLogo].join("")
        }, window.wxData);
    }(window.cache_data));
</script>
<script type="text/javascript" src="${staticPath!}/js/wxapi.js?v=0120"></script>
</body>
</html>