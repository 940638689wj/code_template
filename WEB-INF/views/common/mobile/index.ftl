<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">

<#assign regionSuccessTip = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getRegionSuccessTip()?default("")>
<#assign mobileDecorateInfo = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getMobileDecorateInfo()?default("")>

<!doctype html>
<html>
<head>
    <title>首页</title>

	<link rel="stylesheet" type="text/css" href="${staticResourcePath}css/yrmodule.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}css/module.css" />
    <script type="text/javascript" src="${staticResourcePath}js/modules.js"></script>
    <script type="text/javascript" src="${staticResourcePath}js/iSlider.min.js"></script>

    <script>
        $(function(){
           $(".lazyload").unveil();
        });

    	function searchByKeyword(){
    		var searchKey = $("#searchKey").val();
    		window.location.href = "${ctx}/m/products/0.html?q="+searchKey;
    	}
    </script>
</head>
<body>
<div id="page">
	<div id="index_header">
        <div class="intoolbar">
            <div class="logo"><a href="#"><img src="<#if mobileLogo??&&mobileLogo?has_content>${mobileLogo!}<#else>${staticResourcePath}images/logo-white.png</#if>"></a></div>
            <div class="m">
                <form method="get" action="${ctx}/m/products/0.html">
                    <div class="search">
                        <input type="search" id="searchKey" name="q" placeholder="搜索商品">
                		<button type="button" onclick="searchByKeyword();">搜索</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div class="mui-content">
        <div class="containerwrap">
            <#--${mobileDecorateInfo!}-->
            ${layoutHtml!}
        </div>

        <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>
</div>

</body>
</html>