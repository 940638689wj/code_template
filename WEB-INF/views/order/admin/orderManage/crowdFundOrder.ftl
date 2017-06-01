<#assign ctx = request.contextPath>
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
            <#--<div class="recyclebin"><a href="${ctx}/admin/sa/order/toOrderRecycle">订单回收站</a></div>-->
                <div class="search-bar">
                    <form id="searchForm" class="form-horizontal search-form">
                        <input name="type" value="0" type="hidden"/>
                        <input type="text" placeholder="商品名称" name="productName" class="control-text"/>
                    </form>
                    <button type="button" onclick="searchLoad()"><i class="icon-search"></i></button>
                </div>
            </div>
        </div>
        <div class="content-body">
            <div id="grid"></div>
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
            {text: '未开始(<span class="type1"></span>)', value: '1'},
            {text: '众筹中(<span class="type2"></span>)', value: '2'},
            {text: '已失效(<span class="type3"></span>)', value: '3'},
            {text: '未领奖(<span class="type4"></span>)', value: '4'},
            {text: '待发货(<span class="type5"></span>)', value: '5'},
            {text: '已发货(<span class="type6"></span>)', value: '6'},
            {text: '待评价(<span class="type7"></span>)', value: '7'},
            {text: '已完成(<span class="type8"></span>)', value: '8'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: '操作', dataIndex: 'orderNumber', width: "100px", renderer: function (val, obj) {
                return "<a href='${ctx}/admin/sa/orderManage/toCrowdFundOrderDetail?promotionId=" + obj.promotionId + "' target='_blank'>查看详情</a>";
            }
            },
            {title: '订单号', dataIndex: 'orderNumber', width: "180px"},
            {title: '众筹商品', dataIndex: 'productName', width: 125},
            {title: '货号', dataIndex: 'barCode', width: 80},
            {title: '规格', dataIndex: 'skuKeyJsonStr', width: 190},
            {title: '众筹价格', dataIndex: 'crowdFundProductAmt', width: 70},
            {title: '付款时间', dataIndex: 'orderPayTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
//            {title: '中奖者', dataIndex: 'phone', width: 120},
            {title: '中奖者手机', dataIndex: 'phone', width: 100},
            {title: '配送方式', dataIndex: 'expressName', width: 80, renderer: function (val,obj) {
                if(obj.type >= 5 ){
                    return val ? val : '门店自提';
                }
                return '';
            }},
            {title: '参与人次', dataIndex: 'alreadyBuy', width: 80},
            {title: '总需人次', dataIndex: 'totalBuy', width: 80},
            {title: '状态', dataIndex: 'typeName', width: 80}
        ];
        var store = Search.createStore('findCrowdFundOrderPage', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns,
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small button-primary', handler: exportPreSale}
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
        tab.setSelected(tab.getItemAt(0));

    });

    function searchLoad() {
        search.load();
    }

    // 获取所有类型数量
    $.get("findCrowdFundOrderCount", {}, function (data) {
        for (var i = 0; i <= 8; i++) {
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
    function exportPreSale() {
        window.location.href = "${ctx}/admin/sa/orderManage/exportCrowdFundOrder?type=" + $("input[name=type]").val();
    }

</script>
</body>
</html>