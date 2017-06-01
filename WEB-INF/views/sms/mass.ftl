<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                dataType: 'Json',
                callback: function (data) {
                    if(data.invalidTelephoneCount>0){
                     BUI.Message.Alert("发送失败，第【"+data.countLine+"】行有不符的电话号码");
                     return;
                    }
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        BUI.Message.Alert("发送成功!总共【"+data.totalCount+"】行数据,其中电话【"+data.telephoneCount+"】个，成功发送【"+data.successCount+"】个电话");
                    }
                }
            }).render();
        });
    </script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="bui-tab nav-tabs" aria-disabled="false"><li class="bui-tab-item bui-tab-item-selected" aria-disabled="false"><span class="bui-tab-item-text">短信群发</span></li></ul>
    </div>


    <div class="content-body">
        <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/sms/mass" method="post">
            <div class="order-info-tite">
                <h3>请输入手机号码，多个号码请换行</h3>
            </div>
            <textarea id="telephones" class="textarea-maxbig" name="telephones"></textarea>

            <div class="order-info-tite">
                <h3>请输入要发送的信息</h3>
            </div>
            <textarea id="content" class="textarea-maxbig" name="content"></textarea>

            <div class="form-horizontal" method="post">
                <div class="row form-actions actions-bar">
                    <div class="span13">
                        <button type="submit" class="button button-primary">发送</button>
                        <button type="reset" class="button">重置</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
</body>
</html>