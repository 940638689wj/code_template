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
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item" onclick="couponList();" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">优惠券列表</span>
                </li>
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" onclick="couponUsedDetailList();" aria-pressed="false">
                    <span class="bui-tab-item-text">优惠券使用明细</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="content-top">
        <form id="searchForm" class="form-horizontal search-form">
            <div class="row">
                <div class="control-group">
                    <div class="controls">
                	<span class="bui-form-group" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
		                  使用时间 : <input type="text" class="calendar control-text" name="startUsedTime">
		                <span>至</span>
		                <input type="text" class="calendar control-text" name="endUsedTime">
		             </span>
                        优惠码 : <input type="text" class="control-text" name="couponCode">
                        优惠券名称 :
                        <input type="text" class="control-text" name="couponName">
                        手机号 : <input type="text" class="control-text" name="phone">
                        订单号 : <input type="text" class="control-text" name="orderNumber">
                    </div>
                    <button id="btnSearch" class="button button-primary">查询</button>&nbsp;

                    <button type="button" class="button button-primary" onclick="couponUseDetailExport();">导出</button>
                </div>
            </div>
        </form>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var search = null;
    function couponList(){
        window.location.href="${ctx}/admin/sa/promotion/coupons/list";
    }
    function couponUsedDetailList(){
        window.location.href="${ctx}/admin/sa/promotion/coupons/useDetailList";
    }
    function couponUseDetailExport() {
        var params = $("#searchForm").serialize();
        location.href = "${ctx}/admin/sa/promotion/coupons/useDetail/export?" + params;
        BUI.Message.Alert("导出成功");
    }

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'优惠码',dataIndex:'couponCode',width:170},
            {title:'优惠券名称',dataIndex:'promotionName',width:200},
            {title:'优惠券面额',dataIndex:'realUseCouponValue',width:150},
            {title:'实际使用优惠金额',dataIndex:'realUseCouponValue',width:180},
            {title:'使用时间',dataIndex:'usedTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'使用者手机号',dataIndex:'phone',width:120,renderer : function(value, rowObj){
                var str = "";
                str = "<a href='${ctx}/admin/sa/user/toUserDetailIndex/"+rowObj.userId+"'>"+value+"</a>";
                return str;
            }},
            {title:'使用订单号',dataIndex:'orderNumber',width:200,renderer : function(value, rowObj){
                var str = "";
                if(value && rowObj.orderId){
                    str = "<a href='${ctx}/admin/sa/orderManage/toAllOrderDetail?orderId="+rowObj.orderId+"'>"+value+"</a>";
                }
                return str;
            }},
            {title:'订单状态',dataIndex:'orderStatusName',width:120}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/coupons/useDetailList/grid_json?couponStatusCd=2',{pageSize:20});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight()
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
</script>
</body>
</html>