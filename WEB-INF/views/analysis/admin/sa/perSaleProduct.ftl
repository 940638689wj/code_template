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
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>
                        <select id="orderStatusCd" name="orderStatusCd">
                            <option value="">全部</option>
                            <option value=66>待评价</option>
                            <option value=20>待发货</option>
                            <option value=3>已发货</option>
                            <option value=55>已完成</option>
                        </select>
                        <select id="searchType" name="searchType">
                            <option value=1>商品ID</option>
                            <option value=2>商品货号</option>
                            <option value=3>商品名称</option>
                        </select>
                        <input id="keyWords" name="keyWords" class="control-text" type="text" value="">
                        <button id="user_search" name="user_search" type="button" class="button button-primary ml">
                            搜索
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30">商品销量：
                            <span class="red" id="totalQuantity">0</span>
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
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/sa/perSaleProduct/exportReport?" + params;
        BUI.Message.Alert("导出成功");
    }

</script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        selectedEvent: 'click',
        children: [
            {text: '商城销售明细', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '商品分类', dataIndex: 'categoryName', width: 80},
            {
                title: '图片', dataIndex: 'picUrl', width: 200, renderer: function (value, rowObj) {
                var img_url = "";
                if(value!=null){
                    img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
                }else{
                    img_url = '<img src="" style="width:30px;height: 30px;"/>';
                }
                return img_url;
            }
            },
            {title: '商品ID', dataIndex: 'productId', width: 80},
            {title: '商品名称', dataIndex: 'productName', width: 200},

            {title: '规格', dataIndex: 'standardStr', width: 200},
            {title: '订单号', dataIndex: 'orderNumber', width: 200},
            {title: '外部ID', dataIndex: 'outsideId', width: 200},
            {title: '数量', dataIndex: 'quantity', width: 200},
            {title: '售价', dataIndex: 'salePrice', width: 200},
            {title: '成本价', dataIndex: 'tagPrice', width: 200},
            {title: '商品返利', dataIndex: 'productCommissionAmt', width: 200},
            {title: '品牌', dataIndex: 'brandName', width: 200},
            {title: '收货人', dataIndex: 'receiveName', width: 200},
            {title: '联系电话', dataIndex: 'receiveTel', width: 200},
            {title: '收货地址', dataIndex: 'receiveAddrCombo', width: 200}
        ];

        var store = Search.createStore('${ctx}/admin/sa/perSaleProduct/grid_json', {pageSize: 10});
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
            btnId: "user_search",
            formId: 'searchForm_select'
        });
        var grid = search.get('grid');
        grid.on('aftershow', function (ev) {
            getTotal();
        });
    });


    $("#user_search").click(function () {
        getTotal();
    });

    /**
     * 获取当前搜索时间总数
     */
    function getTotal() {
        var beginTime = $("#beginTime").val();
        var endTime = $("#endTime").val();
        var orderStatusCd = $("#orderStatusCd").find("option:selected").val();
        var searchType = $("#searchType").find("option:selected").val();
        var keyWords = $("#keyWords").val();
        $.ajax({
            url: '${ctx}/admin/sa/perSaleProduct/getTotal',
            dataType: 'json',
            method: 'get',
            data: {
                beginTime: beginTime,
                endTime: endTime,
                orderStatusCd: orderStatusCd,
                searchType: searchType,
                keyWords: keyWords
            },
            success: function (data) {
                $("#totalQuantity").html(data);
            }
        })
    }
</script>
</body>
</html>  