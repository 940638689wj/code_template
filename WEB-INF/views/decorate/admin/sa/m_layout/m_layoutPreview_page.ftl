<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>首页模板预览</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <link rel="stylesheet" href="${ctx}/static/mobile/css/global.css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/mobile.css"/>

    <link rel="stylesheet" href="${ctx}/static/mobile/css/frames.css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/module.css"/>
</head>
<body class="PagePreview">
<div id="page" class="page-index">
    <div data-frame="index_head"></div>
    <div class="container">
        <div class="containerwrap">

        </div>
        <div data-frame="global_foot"></div>
    </div>
    <div data-frame="menu"></div>
    <div data-frame="customer_service"></div>
</div>
</body>

<script src="${ctx}/static/mobile/js/zepto.js"></script>
<script src="${ctx}/static/mobile/js/gmu.js"></script>
<script src="${ctx}/static/js/require.js"></script>
<script>
    var args = {};
    (function () {
        var result = {},
                params = location.search && location.search.substring(1),
                arr = params.split("&");
        for(var i = 0; i < arr.length-2; i++){
            var t = arr[i].split("=");
            result[t[0]] = t[1];
        }
        args = result;
    })();

    var id = 0;
    <#if decoration?? && decoration.id??>
    id = "${(decoration.id)!}";
    </#if>
    var frameConfigUrl = "${ctx}/static/decoration/mobile/config/frameConfig.json";
    if(id != 0){
        frameConfigUrl = "${ctx}/admin/sa/mobile/layoutManage/getIsPushFrameJson/${(decoration.id)!}";
    }
    var layoutData = ${(data)!};
    require.config({
        baseUrl: '${ctx}/static/js'
    });
    require(["decoration/config"], function () {
        require(["decoration/mobile/layoutPreview"]);
    });
</script>
</html>