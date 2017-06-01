<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>首页模板</title>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/global.css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/mobile.css"/>
    <link rel="stylesheet" href="${ctx}/static/mobile/css/module.css"/>
    <link rel="stylesheet" href="${ctx}/static/decoration/mobile/css/decoration.css"/>
    <link rel="stylesheet" href="${ctx}/static/js/ztree/3.5.12/css/romaTree/zTreeStyle.css"/>
    <link rel="stylesheet" href="${ctx}/static/js/jsGrid/jsgrid.css"/>
</head>
<body>
<div class="dcm-page">
    <div class="dcm-header">
        <div class="dcm-logo-extra"><a href="${ctx}/admin/sa/mobile/layoutManage/show"><span style="color:red">移动商城首页&gt;&gt;</span></a>新增微信商城模板</a></div>
        <div class="dcm-header-btns">
        <#if decoration?? && decoration.publish>
            <a id="J_btn_save" href="javascript:void(0)">保存并发布</a>
        <#else>
            <a id="J_btn_save" href="javascript:void(0)">保存</a>
            <a id="J_btn_publish" href="javascript:void(0)">发布</a>
        </#if>
        </div>
    </div>
    <div class="dcm-container">
        <div class="dcm-sidebar">
            <div class="dcm-side-menu">
            </div>
        </div>
        <div class="dcm-main">
            <div class="dcm-preview-wrap">
                <div class="dcm-preview">
                    <div class="dcm-preview-box">
                        <div class="dcm-preview-box-page">
                        <#--<div data-frame="index_head"></div>-->
                            <div class="container">
                                <div class="containerwrap">

                                </div>
                            <#--<div data-frame="global_foot"></div>-->
                            </div>
                        </div>
                    </div>
                    <div class="dcm-preview-btn">
                        <a id="J_btn_preview" href="javascript:void(0)">预览页面</a>
                    </div>
                </div>
            </div>
            <div class="dcm-setting-wrap">
                <div class="dcm-setting">
                    <div class="dcm-setting-title">
                        当前控件 ： <span class="title-txt"></span>
                    </div>
                    <div class="dcm-setting-body">
                        <div class="setting-body-in"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="${ctx}/static/mobile/js/zepto.js"></script>
<script src="${ctx}/static/mobile/js/mui.min.js"></script>
<script src="${ctx}/static/js/require.js"></script>
<script>
    var app = {
        extend : function(a, b) {
            var _extend_ = function(a, b) {
                for (var key in b) {
                    a[key] = b[key];
                }
                return a;
            };
            return _extend_(_extend_({}, a), b);
        }
    };

    app.formatDateTimeStrToDate = function(datetimeStr) {
        var a = datetimeStr.split(" ");
        var d = a[0].split("-");
        var t = a[1].split(":");
        return new Date(d[0],(d[1]-1),d[2],t[0],t[1],t[2]);
    };

    var args = {};
    (function () {
        var result = {},
                params = location.search && location.search.substring(1),
                arr = params.split("&");
        for(var i = 0; i < arr.length-1; i++){
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
        frameConfigUrl = "${ctx}/admin/sa/mobile/layoutManage/getIsPushFrameJson/"+id;
    }
    var getLinkUrl = "/admin/links/getLinks";
    var activityDataUrl =  '/admin/sa/mobile/layoutManage/getPromptionList';
    var layoutDataUrl = "${ctx}/admin/sa/mobile/layoutManage/getLayoutJson/"+id;
    var goodsCategoryDataUrl = "${ctx}/admin/sa/mobile/layoutManage/getGoodsCategory";
    var goodsListDataUrl = "${ctx}/admin/sa/mobile/layoutManage/getGoodsList";
    window.UEDITOR_HOME_URL = "${ctx}/static/admin/js/ueditor/";
    //加载requireJs
    require.config({
        baseUrl: '${ctx}/static/js'
    });
    require(["decoration/config"], function () {
        require(["decoration/mobile/layoutEdit"]);
    });
</script>
</html>