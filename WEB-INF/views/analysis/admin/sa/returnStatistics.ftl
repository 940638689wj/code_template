<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script src="${staticPath}/admin/js/echarts.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30">退货订单量：
                            <span class="red" id="orderQuantity">${(returnStatistics.orderQuantity)!0}</span>
                        </label>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    //导出
    function generateAllReport() {
        location.href = "${ctx}/admin/sa/returnStatistics/exportReturnStatistics";
        BUI.Message.Alert("导出成功!");
    }

</script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '退货单', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '订单号', dataIndex: 'orderNumber', width: 160},
            {title: '退货时间', dataIndex: 'applyTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '操作人', dataIndex: 'operUserName', width: 120},
            {title: '配送方式', dataIndex: 'expressName', width: 200},
            {title: '物流单号', dataIndex: 'returnExpressNum', width: 200},
            {
                title: '物流费用', dataIndex: 'orderExpressAmt', width: 160, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
            {title: '会员', dataIndex: 'userLoginName', width: 200}
        ];

        var store = Search.createStore('${ctx}/admin/sa/returnStatistics/grid_json', {pageSize: 10});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small', handler: generateAllReport}
                ]
            },
            plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select'
        });
        var grid = search.get('grid');
        grid.render();
    });

</script>
</body>
</html>  