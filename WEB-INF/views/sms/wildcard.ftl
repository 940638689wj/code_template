<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <title>通配符</title>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/sms/pushConfig">短信推送</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">通配符</li>
    </ul>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form"></form>
            </div>
        </div>
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    (function($){
        $(function(){
            var columns = [
                {title: '名称', dataIndex: 'name', width: 80},
                {title: '通配符', dataIndex: 'wildcard', width: 100},
                {title: '说明', dataIndex: 'desc', width: 250},
                {title: '范例', dataIndex: 'demo', width: 250, renderer: function(val) {
                    return app.grid.format.renderTitle(val, 32);
                }},
                {title: '限制条件', dataIndex: 'limit', width: 250}
            ];
            var store = new BUI.Data.Store({
                        url: "/static/json/sms_wildcard.json",autoLoad: true
                    }),
                    grid = new BUI.Grid.Grid({
                        render: '#grid',
                        width: '100%',//如果表格使用百分比，这个属性一定要设置
                        columns: columns,
                        store: store
                    });
            grid.render();
        });
    }(jQuery));
</script>
</body>
</html>
