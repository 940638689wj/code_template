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
                        <input name="cardTypeCd" value="${cardTypeCd!}" type="hidden"/>
                    </form>
                </div>
            </div>
        </div>
        <div class="content-body">
            <div id="grid"></div>
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
            {text: '现金卡', value: '1'},
            {text: '积分卡', value: '2'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '名称', dataIndex: 'name', width: 100},
            {title: '描述', dataIndex: 'description', width: 200},
            {title: '卡值', dataIndex: 'value', width: 100},
            {title: '生成数量', dataIndex: 'cardCodeNum', width: 80},
            {title: '已使用数量', dataIndex: 'usedNum', width: 80},
            {title: '启用状态', dataIndex: 'statusName', width: 80},
            {title: '开始日期', dataIndex: 'startDate', width: 150, renderer: BUI.Grid.Format.dateRenderer},
            {title: '结束日期', dataIndex: 'endDate', width: 150, renderer: BUI.Grid.Format.dateRenderer},
            {title: '创建时间', dataIndex: 'createTime', width: 150, renderer: BUI.Grid.Format.datetimeRenderer},
            {
                title: '操作', dataIndex: '', width: 250, renderer: function (value, rowObj) {
                var editStr = "";
                editStr += '&nbsp;&nbsp;<a href=\'javascript:editCard(\"' + rowObj.id + '\")\'>编辑</a>';
                editStr += '&nbsp;&nbsp;<a href=\'javascript:showCardCode(\"' + rowObj.id + '\")\'>查看关联卡号</a>';
                editStr += '&nbsp;&nbsp;<a href=\'javascript:exportCardCode(\"' + rowObj.id + '\")\'>导出关联卡号</a>';
                if (rowObj.usedNum == 0) {
<@securityAuthorize ifAnyGranted="delete">
                    editStr += '&nbsp;&nbsp;<a href=\'javascript:delCard(\"' + rowObj.id + '\")\'>删除</a>';
</@securityAuthorize>
                }
                return editStr;
            }
            }
        ];
        var store = Search.createStore('entityCard/grid_json');
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns
            , tbar: {
                items: [
                    {text: '添加', btnCls: 'button button-small button-primary', handler: addFunction}/*,
                    {text: '设置背景图', btnCls: 'button button-small', handler: setImage}*/
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get("grid");

        grid.render();

        //切换标签
        tab.on('selectedchange', function (ev) {
            $('#searchForm input[name="cardTypeCd"]').val(ev.item.get("value"));
            search.load();
        });
        tab.setSelected(tab.getItemAt(${cardTypeCd!}-1));

    });

    /**
     * 添加
     */
    function addFunction() {
        window.location.href = "${ctx}/admin/sa/entityCard/toSave?cardTypeCd=" + $('#searchForm input[name="cardTypeCd"]').val();
    }

    /**
     * 设置背景图
     */
    function setImage() {
        window.location.href = "${ctx}/admin/sa/entityCard/toSetImage?cardTypeCd=" + $('#searchForm input[name="cardTypeCd"]').val();
    }


    /**
     * 编辑自定义信息
     *
     * @param id    信息Id
     */
    function editCard(id) {
        window.location.href = "${ctx}/admin/sa/entityCard/toSave?id=" + id + "&cardTypeCd=" + $('#searchForm input[name="cardTypeCd"]').val();
    }

    /**
     * 删除会员卡/积分卡
     *
     * @param id    实体卡Id
     */
    function delCard(id) {
        BUI.Message.Confirm('确认要删除该条目吗？', function () {
            $.ajax({
                url: "${ctx}/admin/sa/entityCard/delete",
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

    //查看关联卡号
    function showCardCode() {
        choiceProductDialog.get('loader').load();
        choiceProductDialog.show();
    }

    //导出
    function exportCardCode(entityCardId) {
        location.href = "${ctx}/admin/sa/entityCard/exportCardInfo?entityCardId=" + entityCardId;
    }

    var Overlay = top.BUI.Overlay,
            Grid = BUI.Grid,
            Data = BUI.Data;
    var Store = Data.Store,
            columns = [
                {title: '编号', dataIndex: 'id', width: 85},
                {title: '卡号', dataIndex: 'cardNum', width: 125},
                {title: '密码', dataIndex: 'password', width: 168},
                {
                    title: '状态', dataIndex: 'isUsed', width: 60, renderer: function (val, rowObj) {
                    if (val != null && val == 0) {
                        return "未使用";
                    } else {
                        return "已使用";
                    }
                }
                },
                {title: '使用时间', dataIndex: 'useTime', width: 135, renderer: BUI.Grid.Format.datetimeRenderer},
                {title: '所属人', dataIndex: 'userName', width: 185},

            ];
    var store = new Store({
                url: '${ctx}/admin/sa/entityCard/cardCode/grid_json',
                autoLoad: false, //自动加载数据
                pageSize: 5
            }),
            grid = new Grid.Grid({
                columns: columns,
                store: store,
                loadMask: true, //加载数据时显示屏蔽层
                emptyDataTpl: '<div class="centered"><h2>暂时没有关联的卡号!</h2></div>',
                // 底部工具栏
                bbar: {
                    // pagingBar:表明包含分页栏
                    pagingBar: true
                }
            });

    var dialog = new Overlay.Dialog({
        title: '卡号列表',
        width: 1100,
        height: 300,
        children: [grid],
        childContainer: '.bui-stdmod-body',
        success: function () {
            this.close();
        }
    });

    function showCardCode(entityCardId) {
        var params = { //配置初始请求的参数
            start: 0,
            sort: 'id desc',
            "entityCardId": entityCardId
        };
        store.load(params);
        dialog.show();
    }

</script>
</body>
</html>