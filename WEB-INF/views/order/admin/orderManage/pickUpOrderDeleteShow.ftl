<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
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
                if (obj.orderStatusCd == 6) {
                <@securityAuthorize ifAnyGranted="delete">
                    str += "<span class='grid-command' onclick='deleteOrder(" + obj.orderId + ")'>删除</span>";
                </@securityAuthorize>
                }
                return str;
            }
            },
            {
                title: '订单号', dataIndex: 'orderNumber', width: "150px", renderer: function (val, obj) {
                return "<a href='${ctx}/admin/sa/orderManage/toAllOrderDetail?orderId=" + obj.orderId + "' target='_blank'>" + val + "</a>";
            }
            },
            {title: '收货人', dataIndex: 'receiveName', width: "80px"},
            {title: '手机号', dataIndex: 'receiveTel', width: "100px"},
            {title: '收货地址', dataIndex: 'receiveAddrCombo', width: "300px"},
            {
                title: '会员', dataIndex: 'nickName', width: "100px", renderer: function (val, obj) {
                return val ? val : obj.loginName;
            }
            },
            {title: '套餐名称', dataIndex: 'packageName', width: "150px"},
            {
                title: '实付金额', dataIndex: '', width: "80px", renderer: function (val, obj) {
                return obj.orderTotalAmt - obj.orderDiscountAmt;
            }
            },
            {
                title: '配送方式', dataIndex: 'orderDistrbuteTypeCd', width: "80px", renderer: function (val, obj) {
                return val == 1 ? obj.expressName : '门店自提';
            }
            },
            {title: '自提门店', dataIndex: 'storeName', width: "80px"},
            {title: '订单状态', dataIndex: 'orderStatusName', width: "80px"},
            {title: '下单时间', dataIndex: 'createTime', width: "160px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '发货时间', dataIndex: 'sendTime', width: "160px", renderer: BUI.Grid.Format.datetimeRenderer}
        ];

        var store = Search.createStore('${ctx}/admin/sa/orderManage/findAllOrderPage?adminDeleteStatusCd=2&orderTypeCd=${orderTypeCd!}&orderDistrbuteTypeCd=${orderDistrbuteTypeCd!}', {
                    pageSize: 15,
                    autoSync: true //保存数据后，自动更新
                }),
                gridCfg = Search.createGridCfg(columns, {
                    width: '100%',
                    height: 650,
                    tbar: {
                        items: [
                        <@securityAuthorize ifAnyGranted="delete">
                            {text: '批量删除', btnCls: 'button button-small', handler: deleteFunction}
                        </@securityAuthorize>]
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
                            //  location.reload();
                        });
                    }
                }
            });
        });
    }


</script>
</body>
</html>