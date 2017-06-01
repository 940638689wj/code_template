<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
         <#include "${ctx}/includes/sa/header.ftl"/>
         <#include "storeTree_macro2.ftl"/>
       <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
</head>
<body>
	<div class="container">
    <div class="container-main">
        <div id="left" class="side-menu">
        <@storeTree zNodes=zNodes  target="rightFrame"
            targetUrl=targetUrl/>
        </div>
        <div id="right" class="main-content">
            <iframe id="rightFrame" name="rightFrame" src="${defaultTargetUrl!}"
                    style="display: block;width: 100%;height: 100%;" scrolling="auto" frameborder="0"></iframe>
        </div>
    </div>
</div>
<script>
    function resetHeight(){
        var h = $(window).height() - ($('.title-bar').outerHeight() || 0);
        $('.side-menu').height(h -2);
        $('.side-menu-wrap').height(h-37);
        $('.main-content').height(h);
    }
    resetHeight();
    $(window).on('resize',resetHeight);
</script>
</body>
</html>