<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  	<#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">移动商城首页装修</span></li>
        </ul>
    </div>

    <form id="J_Form" name="J_Form" class="form-horizontal"
          action="${ctx}/admin/sa/mobile/layoutManage/saveMobileDecorateInfo"
          method="post">
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <input type="hidden" id="editors" name="content" value='${(mobileDecorateInfo)!}'/>
                        <script type="text/plain" id="editor"
                                name="contents">${(mobileDecorateInfo)?default("<p></p>")}</script>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
</div>
</body>
<script type="text/javascript">
    $(function(){
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: 1200, initialFrameHeight: 500});
        window.msg_editor.render("editor");

        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
            }
        }).render();
        form.on('beforesubmit', function(){
            var content = window.msg_editor.getContent();
            $('#editors').val(content);
        });

        $('button[type="reset"]').click(function(){
            window.msg_editor.setContent('${(mobileDecorateInfo)!?js_string}');
        });
    })
</script>
</html>  