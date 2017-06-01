<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <form id="J_Form" class="form-horizontal" action="/admin/sa/test/doExecSyncOrder" method="POST">
        <h3 class="label-title">
            <span>execSyncOrder</span>
        </h3>
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">shell脚本文件名：</label>
                    <div class="controls">
                        <input type="text" class="control-text" data-rules="{required:true}"
                               id="RUNNING_SHELL_FILE" name="RUNNING_SHELL_FILE" value="xxx.sh">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">shell脚本所在目录：</label>
                    <div class="controls">
                        <input type="text" class="control-text" data-rules="{required:true}"
                               id="SHELL_FILE_DIR" name="SHELL_FILE_DIR" value="/data/">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">时间：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <input type="text" class="calendar calendar-time control-text" name="startDate" data-rules="{required:true}" value="">
                        <span>至</span>
                        <input type="text" class="calendar calendar-time control-text" name="endDate" data-rules="{required:true}" value="">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <div class="controls">
                        <button type="submit" id="submit" class="button button-primary">执行</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>

<script type="text/javascript">
    var Form = BUI.Form
    var form = new Form.Form({
        srcNode: '#J_Form',
        submitType: 'ajax',
        callback: function (data) {
            if (app.ajaxHelper.handleAjaxMsg(data)) {
                doLoopQueryExecSyncOrder();
            }else{
                $('#submit').attr('disabled', false);
            }
        }
    });
    form.on('beforesubmit', function(){
        $('#submit').attr('disabled', true);
        return true;
    });
    form.render();

    function doLoopQueryExecSyncOrder(){

    }
</script>
</body>
</html>