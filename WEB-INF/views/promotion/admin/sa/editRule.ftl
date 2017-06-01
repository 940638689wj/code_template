<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">积分设置</span></li>
        </ul>
    </div>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/pointRule/savePointRule" method="post">
        <div id="edit-div" class="form-content">
            <div class="control-group">
                <label class="control-label control-label-auto"
                       style="display:inline-block; width: 160px; 2text-align: right;">
                    新注册一个账号可获得 ：</label>
                <div class="controls">
                    <input value="${(newRegisterUser)!}" name="newRegisterUser" data-rules="{regexp:/^\d*$/}"
                           data-messages="{regexp:'不是有效的数字'}" class="input-normal control-text">&nbsp;积分
                </div>
            </div>

            <div class="control-group">
                <label class="control-label control-label-auto"
                       style="display:inline-block; width: 160px; 2text-align: right;">用户完善信息赠送：</label>
                <div class="controls">
                    <input value="${(updateCustomerMessage)!}" name="updateCustomerMessage"
                           data-rules="{regexp:/^\d*$/}" data-messages="{regexp:'不是有效的数字'}"
                           class="input-normal control-text">&nbsp;积分
                </div>
            </div>

            <div class="control-group">
                <label class="control-label control-label-auto"
                       style="display:inline-block; width: 160px; 2text-align: right;">签到可获得 ：</label>
                <div class="controls">
                    <input value="${(customerCheck)!}" name="customerCheck" data-rules="{regexp:/^\d*$/}"
                           data-messages="{regexp:'不是有效的数字'}" class="input-normal control-text">&nbsp;积分
                </div>
            </div>

            <div class="actions-bar">
            <#--<@securityAuthorize ifAnyGranted="rule:base:integration">-->
                <button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            <#--</@securityAuthorize>-->
            </div>
    </form>
</div>
<script type="text/javascript">
    $(function () {
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
                //2.数据返回,延迟打开提交按钮,避免重复显示提示信息！
                setTimeout("remainTime()", 1000);
            }
        });
        form.on('beforesubmit', function () {
            //1.提交时，屏蔽提交按钮避免重复提交！
            btn = document.getElementById('save');
            btn.disabled = true;
        });
        form.render();
    });
    //延时启用保存按钮 
    function remainTime() {
        //打开提交按钮
        btn = document.getElementById('save');
        btn.disabled = false;
    }
</script>
</body>
</html>