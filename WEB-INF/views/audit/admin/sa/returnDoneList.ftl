<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>

    <div class="content-top">
	<form id="searchForm" class="form-horizontal search-form">
	    <div class="row">
	    	<div class="search-bar">
                <input id="keywords" name="keywords" class="control-text" type="text" placeholder="收货人/手机号/订单号"/>
                <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                    申请时间:<input type="text" id="beginTime" name="beginTime" class="calendar control-text" >
                    <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                    <input type="text" id="endTime" name="endTime" class="calendar control-text" >
                </div>
                <select name="auditStatusCds">
                    <option value=''>审核状态</option>
                    <option value="1">已通过</option>
                    <option value="2">已拒绝</option>
                </select>
                <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
	        </div>
	    </div>
	</form>
    </div>

    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
	var search;
	var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'退款审核',value:'0'},
            {text:'审核日志',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(1));
    
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/sa/returnAudit/list";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/sa/returnAudit/doneList";
	        }
    });

	BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'审核对象',dataIndex:'orderNumber',width:200,renderer : function(value, rowObj){
                var str = "";
                str = "<a href='javascript:orderDetail(\""+rowObj.returnOrderNumber+"\");'>"+value+"</a>";
                return str;
        	}},
        	{title:'审核内容',dataIndex:'',width:200, renderer : function(value, rowObj){
         		return "退款";
            }},
         	{title:'审核结果',dataIndex:'auditStatusCd',width:200, renderer : function(value, rowObj){
                if(value=='1'){
                    value="审核通过";
                }else if(value=='2'){
                    value="审核拒绝";
                }
                return value;
            }},
            {title:'审核人',dataIndex:'operator',width:200, renderer : function(value, rowObj){
                return value;
            }},
            {title:'申请时间',dataIndex:'applyTime',width:200, renderer: BUI.Grid.Format.datetimeRenderer},
            {title:'审核时间',dataIndex:'changeTime',width:200, renderer: BUI.Grid.Format.datetimeRenderer}
        ];
        var store = Search.createStore('${ctx}/admin/sa/returnAudit/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight()
        });
        
        var search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();

    });

    //点击订单号跳转到订单详情页
	function orderDetail(obj){
        window.open("${ctx}/admin/sa/customerService/toOrderReturnDetail?returnOrderNumber=" + obj);
    }
    
</script>
</body>
</html>  