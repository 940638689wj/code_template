<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
        </div>
    </div>

    <div class="content-top">
        <div id="tab1"></div>
    </div>
    <form id="searchForm" class="form-horizontal search-form">
        <div class="row">
            <input type="text" class="control-text" name="promotionName" placeholder="红包名称" >
            <button id="btnSearch" type="submit" class="button button-primary">查询</button>
            <input type="button" onclick="redPacketUseDetailExport()" class="button button-primary" value="导出"/>
        </div>
    </form>
    <div id="grid"></div>
</div>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'红包列表',value:'0'},
            {text:'红包使用明细',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(1));
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="0"){
            window.location.href = "/admin/sa/promotion/redPacket/list";
        }else if(item.get('value')=="1"){
            window.location.href = "/admin/sa/promotion/redPacket/useDetailList";
        }
    });


    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'订单金额',dataIndex:'orderTotalAmt',width:80},
            {title:'红包名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'红包金额',dataIndex:'couponCodeValue',width:80},
            {title:'使用的红包优惠码',dataIndex:'couponCode',width:180},
            {title:'使用时间',dataIndex:'usedTime',width:140,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'使用者',dataIndex:'userName', width:100},
            {title:'使用订单号',dataIndex:'orderNumber',width:150},
        ];
        var store = Search.createStore('/admin/sa/promotion/redPacket/useDetailList/grid_json?couponStatusCd=2&promotionTypeCd=56',{pageSize:30});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
</script>
<script>
    function redPacketUseDetailExport() {
        var params = $("#searchForm").serialize();
        location.href = "${ctx}/admin/sa/promotion/redPacket/exportExcel?" + params;
        BUI.Message.Alert("导出成功");
    }
</script>
</body>
</html>