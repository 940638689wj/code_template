<#assign ctx = (request.contextPath)?default("")>

<#assign seoTitle = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoTitle()?default("")>
<#assign seoKeywords = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoKeywords()?default("")>
<#assign seoDescription = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoDescription()?default("")>
<#assign other = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSeoOther()?default("")>
<#assign pcUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcUrl()?default("")>
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<#assign mLogo = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileLogo()?default("")>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
   <#if !titleSuffix?has_content>
    <#assign titleSuffix = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSiteName()?default("")>
</#if>
<#assign newTitle = title!/>
<#--<#if titleSuffix?has_content && seoTitle?has_content>
    <#assign newTitle = seoTitle + " - " + titleSuffix/>
<#else>
    <#assign newTitle = seoTitle?default("") + titleSuffix?default("")/>
</#if>-->

    <title>${newTitle!}</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-title" content="${siteName!}"/>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
	 <#if other?has_content>${other!}</#if>
	 
	<meta name="keywords" content="<#if seoKeywords?has_content>${seoKeywords!} </#if>" />
    <meta name="description" content="<#if seoDescription?has_content>${seoDescription!} </#if>" />

    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/global.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mobile.css" />

    <script type="text/javascript" src="${ctx}/static/mobile/js/zepto.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mui.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mobile.js"></script>

    <script type="text/javascript" src="${ctx}/static/mobile/js/jquery.unveil.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/vue.min.js"></script>
    <script type="text/javascript" src="${ctx}/static/js/vue-resource.min.js"></script>

    <link rel="stylesheet" href="${ctx}/common/mobile/css">
    <script>
        window.cache_data = {
            _pcUrl : "${pcUrl!}",
            _mobileUrl : "${mobileUrl!}",
            _mobileLogo : "${mLogo!}"
        };
    </script>

    ${head}
</head>
<body>
${body}

<script src="${ctx}/common/mobile/js"></script>
<script>
    function isAlipayBrowser(){
        var ua = window.navigator.userAgent.toLowerCase();
        if(ua.match(/AlipayDefined/i) == 'alipaydefined'){
            return true;
        }else{
            return false;
        }
    }
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
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript" src="${ctx}/static/mobile/js/wxapi.js?v=0921"></script>

<script type="text/javascript" src="${ctx}/static/mobile/js/rateit.js"></script>

</body>
</html>