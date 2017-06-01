<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "../../../includes/sa/header.ftl"/>

</head>
<body>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">test cache</span></li>
        </ul>
    </div>

    <form name="freeOrder_Form" class="form-horizontal" id="freeOrder_Form" action="/admin/script2/freeOrder/doExecute" method="POST">
        <h3 class="label-title">
            <span>存储</span>
        </h3>
        <div id="linkFreeOrderDiv" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">key：</label>
                    <div class="controls">
                        <input type="text" class="control-text" data-rules="{required:true}" id="saveKey" name="saveKey" >
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">value：</label>
                    <div class="controls">
                        <input type="text" class="control-text" data-rules="{required:true}" id="saveValue" name="saveValue" >
                        <button type="button" id="saveKeyValue" class="button button-primary">保存</button>
                    </div>
                </div>
            </div>
        </div>
    </form>

    <form name="stockholder_Form" class="form-horizontal" id="stockholder_Form" action="" method="POST">
        <h3 class="label-title">
            <span>获取</span>
        </h3>
        <div id="linkStockholderDiv" class="form-content">

            <div class="row">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">key：</label>
                        <div class="controls">
                            <input type="text" class="control-text" id="getKey" name="" data-rules="{required:true}">
                            <button type="button" id="getKeyValue" class="button button-primary">获取</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>

<script type="text/javascript">
    $(function(){
        $('#saveKeyValue').on("click", function(){
            var data = {};
            data.saveKey = $("#saveKey").val();
            data.saveValue = $("#saveValue").val();

            $.post('${ctx}/admin/sa/test/saveKeyValue',data,function(){
                app.showSuccess('保存成功!');
            });
        });

        $('#getKeyValue').on("click", function(){
            var data = {};
            data.getKey = $("#getKey").val();

            $.get('${ctx}/admin/sa/test/getKeyValue',data,function(resultData){
                app.showSuccess(resultData.getValue);
            });
        });
    });
</script>
</body>
</html>