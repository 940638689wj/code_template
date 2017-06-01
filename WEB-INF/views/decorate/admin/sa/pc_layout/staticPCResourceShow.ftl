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
<div class="container">
    <ul class="breadcrumb">
        &nbsp;&nbsp;<li class="active">编辑:${siteConfigKeys.friendlyKey!}</li>
    </ul>
    <form id="myForm" name="myForm" class="form-horizontal" action="${ctx}/admin/sa/pc/decorate/save" method="post">
        <input type="hidden" id="key" name="key" value="${siteConfigKeys.key!}">
        <div class="form-content">
            <div id="txtAreaEditor" class="row">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <textarea id="editorTxtArea" name="content" style="height: 350px;width: 920px;">${html!}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <#--<@securityAuthorize ifAnyGranted="decorate:pc_style_code">-->
            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
            </div>
        <#--</@securityAuthorize>-->

    </form>
</div>
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
        var initWidth = 1200;
        var key = '${siteConfigKeys.key!}';
        if(key.indexOf('pc')>=0 ){
            initWidth = 380;
        }
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: initWidth, initialFrameHeight: 500,allowDivTransToP:false});
        window.msg_editor.render("editor");


	<#if platform?has_content && "pc"==platform>
        var styleUrl = '${ctx}/static/css/style.css';
        var templateUrl = '${ctx}/static/template/${templateId}/css/tmpl.css';
        var templateThemeUrl = '${ctx}/static/template/${templateId}/themes/${templateTheme!}/css/theme.css';
        var staticResourceCssUrl = '${ctx}/common/pc/css';
	</#if>

        window.msg_editor.ready(function(){
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:styleUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:templateUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:templateThemeUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:staticResourceCssUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
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

</script>
</body>
</html>