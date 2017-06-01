<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <style>
        .inner-block-label {
            margin-left: 15px;;
            display: inline-block;
            width: 500px;
        }
    </style>
</head>
<body>
<div class="form-horizontal">
    <div id="tab"></div>
    <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
        <div class="tips-content">
            要使用短信推送.请先接入短信运营商.如需帮助.请联系逸锐售后
        </div>
    </div>
    <div class="control-group">
        <div class="controls">
            <div>
                <label class="inner-block-label">订单指派配送员后会将短信推送给配送员，设置短信推送的内容模板</label>
                <a title="短信验证" edit-template="SMS_SHOPPER_PUSH_MSG" class="button"
                   href="javascript:;"><span>编辑模板</span></a>
            </div>
        </div>
    </div>
</div>
<div id="dialog" class="well" style="display: none;">
    <div class="control-group">
        <label class="control-label"></label>
        <div class="controls">
            <textarea id="template" style="width: 320px;height: 120px;"></textarea>
        </div>
    </div>
</div>
<script type="text/javascript">
    BUI.use(["bui/tab", "bui/form", "bui/overlay"], function (Tab, Form, Overlay) {
        var tab = new Tab.Tab({
            render: "#tab",
            elCls: "nav-tabs",
            autoRender: true,
            children: [
                {text: "短信推送配置", value: "0"}
            ]
        });
        tab.setSelected(tab.getItemAt(0));

        var array;
        $("[edit-template]").click(function () {
            var key = $(this).attr("edit-template"), title = "短信推送";
            $.post("${ctx}/admin/sa/smsPush/findTemplate", {key: key}, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    var content = data.data || "";
                    array = content.split(/\\n/);
                    $("#template").val(array[0] || "");
                }
            });
            new Overlay.Dialog({
                contentId: "dialog",
                title: title || '模板编辑',
                buttons: [{
                    text: '保存',
                    elCls: 'button button-primary',
                    handler: function () {
                        var template = $("#template").val() || "";
                        $.post("${ctx}/admin/sa/smsPush/saveTemplate", {key: key, template: template}, function (data) {
                            if (app.ajaxHelper.handleAjaxMsg(data)) {
                                app.showSuccess("操作成功！");
                            }
                        });
                        this.close();
                    }
                }, {
                    text: '重置',
                    elCls: 'button',
                    handler: function () {
                        $("#template").val(array[0] || "");
                    }
                }],
                mask: true,
                closeAction: "destroy"
            }).show();
        });
    });

</script>
</body>
</html>