<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${staticPath}/js/printOrder.js"></script>
</head>
<body>
<div class="container">
    <div id="bindConcent" class="hide">
        <form id="J_Form" class="form-horizontal" action="" method="post">
            <input type="hidden" id="expressId"/>
            <div class="control-group">
                <label class="control-label">运费模板：</label>
                <div class="controls">
                    <select id="expressTemplateId">
                        <option value="">请选择</option>
                    <#if expressTemplates?has_content>
                        <#list expressTemplates as e>
                            <option value="${e.templateId!}">${e.templateName!}</option>
                        </#list>
                    </#if>
                    </select>
                </div>
            </div>
        </form>
    </div>


    <div class="title-bar">
        <div id="tab">
        </div>

        <div class="content-body">
            <div id="grid"></div>
        </div>

    </div>
    <script>
        var search;
        var dialog;
        BUI.use(['bui/overlay', 'bui/form'], function (Overlay, Form) {

            var form = new Form.Form({
                srcNode: '#J_Form'
            }).render()

            dialog = new Overlay.Dialog({
                title: '关联运费模板',
                width: 400,
                height: 200,
                //配置DOM容器的编号
                contentId: 'bindConcent',
                success: function () {
                    var expressTemplateId = $("#expressTemplateId").val();
                    if (expressTemplateId == '') {
                        app.showError("请选择要关联的模板！");
                        return false;
                    }
                    $.ajax({
                        url: "${ctx}/admin/sa/order/express/addOrEditExpress",
                        type: "post",
                        dataType: "json",
                        data: {"expressTemplateId": expressTemplateId, "expressId": $("#expressId").val()},
                        success: function (data) {
                            if (data) {
                                app.showSuccess("操作成功")
                                dialog.close();
                                search.load();
                            }
                        }
                    });
                }
            });
        });

        var Tab = BUI.Tab;
        var grid;
        var tab = new Tab.Tab({
            render: '#tab',
            elCls: 'nav-tabs',
            autoRender: true,
            children: [
                {text: '设置物流', value: '0'}
            ]
        });
        tab.setSelected(tab.getItemAt(0));
        BUI.use('common/search', function (Search) {
            columns = [
                {title: '名称', dataIndex: 'expressName', width: "200px"},
                {title: '首重重量(克)', dataIndex: 'firstValue', width: "100px"},
                {title: '首重价格', dataIndex: 'firstPrice', width: "120px"},
                {title: '续重重量(克)', dataIndex: 'continueValue', width: "120px"},
                {title: '续重价格', dataIndex: 'continuePrice', width: "120px"},
                {
                    title: '状态', dataIndex: 'expressStatusCd', width: "80px", renderer: function (value, rowObj) {
                    return value == 1 ? "启用" : "禁用";
                }
                },
                {
                    title: '默认配送方式', dataIndex: 'isDefaultExpress', width: "100px", renderer: function (value, rowObj) {
                    return value == 1 ? "是" : "否";
                }
                },
                {title: '关联运费模板', dataIndex: 'templateName', width: "150px"},
                {
                    title: '操作', dataIndex: '', width: 300, renderer: function (value, rowObj) {
                    editStr = Search.createLink({
                        text: '编辑',
                        href: '${ctx}/admin/sa/order/express/toEditExpressInfo?expressId=' + rowObj.expressId
                    });
                    var result = ""
                    result += editStr;
                    result += '&nbsp;&nbsp;<a href=\'javascript:setTemplate(' + rowObj.expressId + ');\'>关联运费模板</a>';
                    if (rowObj.expressStatusCd == 1) {
                        result += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(' + rowObj.expressId + ');\'>禁用</a>';
                    } else {
                        result += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(' + rowObj.expressId + ');\'>启用</a>';
                    }
                    return result;
                }
                }
            ];

            var store = Search.createStore('${ctx}/admin/sa/order/express/getExpressPage', {
                pageSize: 15,
                autoSync: true //保存数据后，自动更新
            });

            var gridCfg = Search.createGridCfg(columns, {
                width: '100%',
                height: getContentHeight(),
                tbar: {
                    items: [
                        {text: '添加', btnCls: 'button button-primary', handler: addFunction},
                        {text: '设为默认物流', btnCls: 'button', handler: setDefaultExpress},
                    ]
                },
                plugins: [BUI.Grid.Plugins.RadioSelection, BUI.Grid.Plugins.AutoFit] // 插件形式引入多选表格
            });

            search = new Search({
                store: store,
                gridCfg: gridCfg
            });
            grid = search.get('grid');

            /**
             * 添加物流
             */
            function addFunction() {
                window.location.href = '${ctx}/admin/sa/order/express/toEditExpressInfo';
            }

            /**
             * 设置默认物流
             */
            function setDefaultExpress() {
                var selections = grid.getSelected();
                if (!selections) {
                    app.showError("请选择物流");
                    return false;
                }
                $.ajax({
                    url: "${ctx}/admin/sa/order/express/setDefaultExpress",
                    type: "post",
                    datatype: "json",
                    data: {"expressId": selections.expressId},
                    success: function (data) {
                        if (data) {
                            app.showSuccess("操作成功")
                            search.load();
                        }
                    }
                });
            }
        });

        /**
         * 点击 关联运费模板
         *
         * @param id 物流id
         */
        function setTemplate(id) {
            $("#expressId").val(id);
            dialog.show();
        }

        function changeStatus(id) {
            $.ajax({
                url: "${ctx}/admin/sa/order/express/changeStatus",
                type: "post",
                datatype: "json",
                data: {"expressId": id},
                success: function (data) {
                    if (data) {
                        app.showSuccess("操作成功")
                        search.load();
                    }

                }

            });
        }

    </script>
</body>
</html>  