<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${staticPath}/js/printOrder.js"></script>
</head>
<body>

<div class="content-top">
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var search;
    BUI.use('common/search', function (Search) {
        var columns = [
            {
                title: '操作', dataIndex: '', width: "50px", renderer: function (val, obj) {
                var str = "";
                str += "<span class='grid-command' onclick='deleteOrder(" + obj.orderId + ")'>删除</span>";
                return str;
            }
            },
            {
                title: '订单号', dataIndex: 'orderNumber', width: "180px", renderer: function (val, obj) {
                return "<a href='${ctx}/admin/sa/orderManage/toPreSaleOrderDetail?orderId=" + obj.orderId + "' target='_blank'>" + val + "</a>";
            }
            },
            {title: '订单来源', dataIndex: 'originPlatformName', width: "100px"},
            {title: '会员手机', dataIndex: 'phone', width: "100px"},
            {title: '数量', dataIndex: 'quantity', width: 40},
            {title: '定金', dataIndex: 'price', width: "70px"},
            {title: '付定金时间', dataIndex: 'depositPayTime', width: "140px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '定金支付类型', dataIndex: 'depositOrderPayModelName', width: "90px"},
            {title: '尾款', dataIndex: 'restPrice', width: "70px"},
            {title: '付尾款时间', dataIndex: 'restPayTime', width: "140px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '订单状态', dataIndex: 'orderStatusName', width: "80px"}
        ];

        var store = Search.createStore('findPreSaleOrderPage?adminDeleteStatusCd=2&orderDistrbuteTypeCd=${orderDistrbuteTypeCd!}', {
                    pageSize: 15,
                    autoSync: true //保存数据后，自动更新
                }),
                gridCfg = Search.createGridCfg(columns, {
                    width: '100%',
                    height: 650,
                    tbar: {
                        items: [
                            {text: '批量删除', btnCls: 'button button-small', handler: deleteFunction}
                        ]
                    },
                    plugins: [BUI.Grid.Plugins.CheckSelection, BUI.Grid.Plugins.AutoFit] // 插件形式引入多选表格
                });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        var grid = search.get('grid');

        function deleteFunction() {
            var selectedContent = grid.getSelection();
            if (!selectedContent.length) return BUI.Message.Alert("请选择要删除的订单！");
            BUI.Message.Confirm('确认要将订单永久删除吗？', function () {
                var selectedContentIds = [];
                for (var i = 0; i < selectedContent.length; i++) {
                    selectedContentIds.push(selectedContent[i].orderId);
                }
                $.ajax({
                    url: "${ctx}/admin/sa/order/deleteOrders",
                    type: "post",
                    dataType: "json",
                    data: {orderIds: selectedContentIds, type: 1},
                    success: function (data) {
                        if (data) {
                            BUI.Message.Alert("删除成功！", function () {
                                search.load();
                            });
                        }
                    }
                });
            });

        }

    });


    function deleteOrder(id) {
        BUI.Message.Confirm('确认要将订单永久删除吗？', function () {
            $.ajax({
                url: "${ctx}/admin/sa/order/deleteOrders",
                type: "post",
                dataType: "json",
                data: {orderIds: id, type: 1},
                success: function (data) {
                    if (data) {
                        BUI.Message.Alert("删除成功！", function () {
                            search.load();
                        });
                    }
                }
            });
        });
    }


</script>
</body>
</html>