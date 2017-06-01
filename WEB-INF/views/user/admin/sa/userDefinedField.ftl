<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-bar">
            <div id="tab"></div>
        </div>
        <div class="content-top">
            <div class="title-bar-side">
                <div class="search-bar">
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal span24">
                        <input name="sort" value="id desc" type="hidden"/>
                        <input type="hidden" name="eq_visible" value="0">
                    </form>
                </div>
            </div>
        </div>
        <div class="content-body">
            <div id="grid">

            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
    var Tab = BUI.Tab;
    var search;
    var grid;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '会员自定义信息', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '字段名称', dataIndex: 'fieldName', width: 100},
            {title: '字段类型', dataIndex: 'fieldTypeName', width: 120},
            {title: '是否启用', dataIndex: 'statusName', width: 80},
            {
                title: '是否必填', dataIndex: 'isRequired', width: 80, renderer: function (value, rowObj) {
                if (value == 0) {
                    return "否";
                } else if (value == 1) {
                    return "是";
                }
            }
            },
            {title: '排序值', dataIndex: 'sortValue', width: 100},
            {title: '创建时间', dataIndex: 'createTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {
                title: '操作', dataIndex: '', width: 100, renderer: function (value, rowObj) {
                var editStr = "";
                editStr += '&nbsp;<a href=\'javascript:editField(\"' + rowObj.id + '\")\'>编辑</a>';
        <@securityAuthorize ifAnyGranted="delete">
                editStr += '&nbsp;<a href=\'javascript:delField(\"' + rowObj.id + '\")\'>删除</a>';
        </@securityAuthorize>
                return editStr;
            }
            }
        ];
        var store = Search.createStore('userDefinedField/grid_json');
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: getContentHeight(),
            render: '#grid',
            columns: columns
            , tbar: {
                items: [
                    {text: '添加', btnCls: 'button button-small button-primary', handler: addFunction}
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get('grid');

        grid.render();

        function addFunction() {
            window.location.href = "${ctx}/admin/sa/userDefinedField/toSave";
        }

    });

    /**
     *编辑自定义信息
     *
     * @param id    信息Id
     */
    function editField(id) {
        window.location.href = "${ctx}/admin/sa/userDefinedField/toSave?id=" + id;
    }

    /**
     * 删除自定义信息
     *
     * @param id    信息Id
     */
    function delField(id) {
        BUI.Message.Confirm('确认要删除该条目吗？', function () {
            $.ajax({
                url: "${ctx}/admin/sa/userDefinedField/delete",
                type: "post",
                dataType: "json",
                data: {id: id},
                success: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("删除成功！");
                        search.load();
                    }
                }
            });
        }, 'question')
    }
</script>

</body>
</html>