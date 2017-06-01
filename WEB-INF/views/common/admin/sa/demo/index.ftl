<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected">
                <span class="bui-tab-item-text">demo演示</span>
            </li>
        </ul>
    </div>

    <form name="scriptForm" class="form-horizontal" id="scriptForm" action="" method="POST">
        <h3 class="label-title">
            <span>bui常用控件</span>
        </h3>
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">&nbsp;</label>
                    <div class="controls">
                        <a href="/admin/sa/common/demo/grid/list" target="_blank" class="button button-primary">bui列表使用</a>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">&nbsp;</label>
                    <div class="controls">
                        <a href="/admin/sa/common/demo/form" target="_blank" class="button button-primary">bui表单使用</a>
                    </div>
                </div>
            </div>
        </div>



    </form>
</div>

<script type="text/javascript">

</script>

</body>
</html>