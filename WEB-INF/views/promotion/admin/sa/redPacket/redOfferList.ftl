<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<script src="/static/admin/js/common/search-min.js"></script>
<div class="container">
    <div class="row">
        <form id="searchFormRedPkg" class="form-horizontal search-form">
            <input name="orderBy" value="id desc" type="hidden"/>
            <div class="row">
                <div class="control-group span5">
                    <label class="control-label" style="width: 45px;">名称：</label>
                    <div class="controls">
                        <input type="text" class="control-text" name="promotionName" style="width: 80px;">
                    </div>
                </div>
                <div class="control-group span9">
                    <label class="control-label" style="width: 65px;">有效日期：</label>
                    <div class="controls">
                        <input type="text" class="calendar control-text" name="le_startDate" value="">
                        <span>至</span>
                        <input type="text" class="calendar control-text" name="ge_endDate" value="">
                    </div>
                </div>
                <div class="span9">
                    <button  type="button" id="btnSearch" class="button button-primary">搜索</button>
                </div>
            </div>
        </form>
    </div>
    <div class="search-grid-container">
        <div id="gridRedPkg"></div>
    </div>
</div>
<script type="text/javascript">

    BUI.use(['common/search','common/page'],function (Search) {
        var grid;
        var columns = [
            {title:'编号',dataIndex:'promotionId',width:80},
            {title:'名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'描述',dataIndex:'promotionDesc',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'数量',dataIndex:'couponTotalNum',width:80},
            {title:'库存数',dataIndex:'stockNum',width:80},
           {title:'状态',dataIndex:'statusCd',width:100,renderer : function(value, rowObj){
            	var str = "";
            	if(value == 1) {
            		return str="启用";
            	} else {
            		return str="禁用";
            	}
            }},
            {title:'推送条件',dataIndex:'couponPushOrderAmtLimit',width:150}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/redPacket/coupon_json',{pageSize:5});
        var isMultiChoice = ${isMultiChoice?default(true)?string("true","false")};
        var gridCfg;
        if(isMultiChoice){
            gridCfg = Search.createGridCfg(columns,{
                plugins : [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
                multiSelect: false
            });
        } else {
            gridCfg = Search.createGridCfg(columns,{
                plugins : [BUI.Grid.Plugins.RadioSelection]// 插件形式引入单选表格
            });
        }

        var search = new Search({
            formId : "searchFormRedPkg",
            store : store,
            gridCfg : gridCfg,
            gridId : "gridRedPkg"
        });
        grid = search.get('grid');
        top.getSelectedRecordsRedPkg = function() {
            var selections = grid.getSelection();
            return selections;
        };
    });

</script>