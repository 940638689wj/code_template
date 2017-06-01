<#assign ctx = request.contextPath>
<#include "${ctx}/includes/sa/header.ftl"/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<script src="/static/admin/js/common/search-min.js"></script>
<div class="container">
    <div class="row">
        <form id="searchForm" class="form-horizontal search-form">
            <input name="orderBy" value="id desc" type="hidden"/>
            <input type="hidden" name="statusCd" value="1" />
            <input type="hidden" name="isEnableTime" value="1" />
            <div class="row">
                <div class="control-group span5">
                    <label class="control-label" style="width: 55px;">名称：</label>
                    <div class="controls">
                        <input type="text" class="control-text" name="promotionName" style="width: 80px;">
                    </div>
                </div>
                <div class="control-group span9">
                    <label class="control-label" style="width: 65px;">有效日期：</label>
                    <div class="controls">
                        <input type="text" class="calendar control-text" name="lStartDate" value="">
                        <span>至</span>
                        <input type="text" class="calendar control-text" name="gEndDate" value="">
                    </div>
                </div>
                <div class="span2">
                    <button  type="button" id="btnSearch" class="button button-primary">搜索</button>
                </div>
            </div>
        </form>
    </div>
    <div class="search-grid-container">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var grid;
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'编号',dataIndex:'promotionId',width:80},
            {title:'名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'描述',dataIndex:'promotionDesc',width:217, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'数量',dataIndex:'couponTotalNum',width:80},
            {title:'领取数量',dataIndex:'doleCount',width:80},
            {title:'已使用数量',dataIndex:'useCount',width:80},
            {title:'使用起始时间',dataIndex:'enableStartTime',width:110,renderer:BUI.Grid.Format.dateRenderer},
            {title:'使用结束时间',dataIndex:'enableEndTime',width:110,renderer:BUI.Grid.Format.dateRenderer},
            {title:'状态',dataIndex:'statusCd',width:70, renderer : function(value, rowObj){
                if(value == "0"){
                    return "禁用";
                }else{
                    return "启用";
                }
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/coupons/couponOfferDialogList/grid_json',{pageSize:5});
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

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        grid = search.get('grid');
    });

    function getSelectedRecords(){
        var selections = grid.getSelection();
        return selections;
    }
    top.getSelectedRecords = function(){
        var selections = grid.getSelection();
        return selections;
    };
</script>