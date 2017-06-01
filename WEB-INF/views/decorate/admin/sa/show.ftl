<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
     <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
</head>
<body>

    <#--<ul class="breadcrumb">
        <li class="active">编辑:${templateKeyTypes.friendlyType!}</li>
    </ul>-->
    <div style="padding-bottom: 5px;">
        <ul class="bui-tab link-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
            <li id="baiDuEditorHref" class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                <a href="javascript:switchToBasicTab();">富文本</a>
            </li>
            <li id="txtAreaEditorHref" class="bui-tab-item bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
                <a href="javascript:switchToAdvancedTab();">纯文本</a>
            </li>
        </ul>
    </div>
    <form id="myForm" name="myForm" class="form-horizontal" action="${ctx}/admin/sa/mobile/decorate/save" method="post">
        <input type="hidden" id="key" name="key" value="${siteConfigKeys.key!}">
        <input type="hidden" id="contentType" name="contentType" value="1">

            <div id="baiDuEditor">
                        <script type="text/plain" id="editor" name="content">${html!}</script>
            </div>
            <div id="txtAreaEditor" class="hide">
                        <textarea id="editorTxtArea" name="advancedContent" style="height: 350px;width: 920px;">${html!}</textarea>
            </div>
    <#--<@securityAuthorize ifAnyGranted="decorate:mobile_index">-->
        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
        </div>
    <#--</@securityAuthorize>-->

    </form>
<script type="text/javascript">
    var contentId = "editor";
    var getIframeById = function (idIframe) {
        var iframe;
        if (document.all) {//IE
            iframe = window.document.frames[idIframe]
        } else {//Firefox
            iframe = window.document.getElementById(idIframe)
        }
        if (iframe) {
            return iframe;
        }
        return null;
    }
    var getIframeDoc = function (idIframe) {
        var doc;
        var iframe = getIframeById(idIframe);
        if (iframe) {
            if (document.all) {//IE
                doc = iframe.document;
            } else {//Firefox
                doc = iframe.contentDocument;
            }
            return doc;
        }
        return  null;
    }
    $(function(){
        var initWidth = '99%';
        var key = '${siteConfigKeys.key}';
        if(key.indexOf('mobile')>=0 ){
            initWidth = 640;
        }
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: initWidth, initialFrameHeight: 500,allowDivTransToP:false});
        window.msg_editor.render("editor");

        var muiCss = '${ctx}/static/mobile/css/mui.css';
        var yrmobileCss = '${ctx}/static/mobile/css/yrmobile.css';
        var framesCss = '${ctx}/static/mobile/css/frames.css';
        var moduleCss = '${ctx}/static/mobile/css/module.css';
        var commonCss = '${ctx}/common/mobile/css';
        var commonJs = '${ctx}/common/mobile/js';

        window.msg_editor.ready(function(){
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:muiCss,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:yrmobileCss,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:framesCss,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:moduleCss,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:commonCss,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:commonJs,
                tag:"link",
                type:"text/javascript"
            });
        });


        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#myForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
            }
        }).render();
    });

    function switchToBasicTab(){
        $("#txtAreaEditorHref").removeClass("bui-tab-item-selected");
        $("#txtAreaEditorHref").removeClass("bui-tab-item-hover");
        $("#baiDuEditorHref").addClass("bui-tab-item-selected");
        $("#baiDuEditorHref").addClass("bui-tab-item-hover");
        $("#txtAreaEditor").hide();
        $("#baiDuEditor").show();
        $("#contentType").val("1");
    }

    function switchToAdvancedTab(){
        $("#baiDuEditorHref").removeClass("bui-tab-item-selected");
        $("#baiDuEditorHref").removeClass("bui-tab-item-hover");
        $("#txtAreaEditorHref").addClass("bui-tab-item-selected");
        $("#txtAreaEditorHref").addClass("bui-tab-item-hover");
        $("#baiDuEditor").hide();
        $("#txtAreaEditor").show();
        $("#contentType").val("2");
    }
</script>
</body>
</html>