<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"/>
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
                <div class="recyclebin">
                <#--<a href="${ctx}/admin/sa/orderManage/toOrderRecycle?orderTypeCd=${orderTypeCd!}">订单回收站</a></div>-->
                    <div class="search-bar">
                        <form id="searchForm" class="form-horizontal search-form">
                            <input name="type" value="${type!0}" type="hidden"/>
                            <input type="text" placeholder="订单号" name="orderNumber" class="control-text"/>
                            <button type="button" onclick="searchLoad()"><i class="icon-search"></i></button>
                        </form>
                    </div>
                    <div class="search-content">
                    </div>
                </div>
            </div>
            <div class="content-body">
                <div id="grid"></div>
            </div>

        </div>
    </div>

</div>
<script type="text/javascript">
    var search;
    var grid;
    var tab = new BUI.Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '全部(<span class="type0"></span>)', value: '0'},
            {text: '退款(<span class="type1"></span>)', value: '1'},
            {text: '退货(<span class="type2"></span>)', value: '2'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: '退款单号', dataIndex: 'returnOrderNumber', width: "160px", renderer: function (val, obj) {
                return "<a href='/admin/sa/customerService/toOrderReturnDetail?returnOrderNumber=" + val + "' target='_blank'>" + val + "</a>";
            }
            },
            {title: '订单号', dataIndex: 'orderNumber', width: "160px"},
            {title: '收货人手机', dataIndex: 'receiveTel', width: "100px"},
            {title: '收货人', dataIndex: 'receiveName', width: "80px"},
            {title: '订单来源', dataIndex: 'originPlatformName', width: "80px"},
            {title: '退换货状态', dataIndex: 'applyStatusName', width: "80px"},
            {title: '订单状态', dataIndex: 'orderStatusName', width: "80px"},
            {title: '商品名称', dataIndex: 'productName', width: "150px"},
            {title: '商品金额', dataIndex: 'salePrice', width: "80px"},
            {
                title: '配送方式', dataIndex: 'orderDistrbuteTypeCd', width: "80px", renderer: function (val, obj) {
                return val == 1 ? obj.expressName : '门店自提';
            }
            },
            {title: '下单时间', dataIndex: 'createTime', width: "150px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '申请时间', dataIndex: 'applyTime', width: "150px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '买家留言', dataIndex: 'orderRemark', width: "100px"}
        ];
        var store = Search.createStore('/admin/sa/customerService/findOrderReturnPage', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns,
            tbar: {
                items: [
//                        {text: '导出', btnCls: 'button button-small button-primary', handler: exportAllOrder},
//                    {text: '打印订单', btnCls: 'button button-small button-primary', handler: printAllOrder}
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
            $("input[name=type]").val(ev.item.get("value"));
            search.load();
        });
        tab.setSelected(tab.getItemAt(${type!0}));

    });

    // 获取所有类型数量
    $.get("/admin/sa/customerService/findOrderReturnCount", {}, function (data) {
        for (var i = 0; i <= 2; i++) {
            $(".type" + i).html(data['type' + i]);
        }
    });

    /**
     * 删除订单
     */
    function delOrder(orderId) {
        BUI.Message.Confirm("确认删除订单", function () {
            $.post("delOrder", {orderId: orderId}, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("删除成功");
                    search.load();
                }
            })
        });
    }

    /**
     * 导出
     */
    function exportAllOrder() {
        window.location.href = "${ctx}/admin/sa/orderManage/exportAllOrder?adminDeleteStatusCd=1&orderTypeCd=" + $("input[name=orderTypeCd]").val() + "&type=" + $("input[name=type]").val();
    }

    function searchLoad() {
        search.load();
    }

</script>

</body>
</html>