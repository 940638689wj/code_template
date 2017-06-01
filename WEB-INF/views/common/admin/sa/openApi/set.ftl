<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="/static/admin/js/bui.js"></script>
    <script type="text/javascript">
        function isReset(){
            BUI.Message.Confirm('确认要重置么？',function(){
                $("#J_Form").submit();
            },'question');
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li>OpenAPI设置 <span class="divider"></span></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/common/openApi/resetSecret/${appName!}" method="post" >
        <div id="edit-div" class="form-content">

            <div class="row">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">接口地址：</label>
                        <div class="controls">
                            <span id="apiAddressUrlId"></span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">AppKey：</label>
                        <div class="controls">
                            <span>${(appKey)!}</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">AppSecret：</label>
                        <div class="controls">
                            <span>${(appSecret)!}</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="actions-bar">
                <button type="button"  onclick="isReset()" class="button button-primary" >重置AppSecret</button>
            </div>
    </form>
</div>
<script type="text/javascript">
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/common/openApi/set/${appName!}";
                }
            }
        }).render();

        function getBasePath() {
            var basePath = window.location.protocol+"//"+window.location.host;
            return basePath;
        }

        $("#apiAddressUrlId").text(getBasePath()+"/api/web/index");
    });
</script>
</body>
</html>