<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <title>${ctx}会员概况${staticPath}</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/theme-01.css"/>

    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>

    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>
    <script src="${staticPath}/admin/js/echarts-plain.js"></script>
	<script type="text/javascript" src="${staticPath}/admin/js/config.js"></script>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/theme-01.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-text">会员整体概况</div>
        <div id="grid" class="mb10"></div>
    </div>
    <div class="content-top">
        <div id="tab"></div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0" method="get">
            <div class="row mb10">
                <div class="control-group">
                    <div class="controls  control-row-auto ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" class="calendar control-text" id="beginTime" name="beginTime">
                            <span class="mr5">至</span>
                            <input type="text" class="calendar control-text" id="endTime" name="endTime">
                            <input class="control-text" name="userPhone" id="userPhone" type="hidden">
                            
                            <button class="button button-primary"  id="user_search" name="user_search">搜索</button>
                            <button class="button button-primary" id="export" type="button">导出</button>
                        </div>
                    </div>
                    <div class="title-bar-side title-bar-side2">
                        <div class="search-bar">
                            <form>
                                <input class="control-text" name="userPhone2" id="userPhone2" type="text" placeholder="下单人手机号">
                                <button onclick="shortSearch()" type="button"></button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div class="content-body">
        <div id="grid2"></div>
    </div>
</div>
<script type="text/javascript">
	//导出
	$("#export").click(function(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/admin/sa/report/exportNewRegUserInfo?"+params;
    	BUI.Message.Alert("导出成功");
	});
	
</script>
<script type="text/javascript">
	function shortSearch(){
		var phone=$("#userPhone2").val();
		$("#userPhone").val(phone)
	//	alert(phone);
        $('#user_search').click();
        
    }


    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'新增会员报表',value:'1'}
        ]
    });
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        $('#log').text(item.get('text') + ' ' + item.get('value'));
    });
    tab.setSelected(tab.getItemAt(0));

    var Grid = BUI.Grid,
        Data = BUI.Data,
        Store = Data.Store,
            columns = [
                {title : '注册会员总数',dataIndex :'a', width:100},
                {title : '购买会员总数',dataIndex :'b', width:100},
                {title : '成交笔数',dataIndex :'c',width:100},
                {title : '成交总金额',dataIndex :'d', width:100},
                {title : '成交均价',dataIndex :'e', width:100},
                {title : '成交客单价',dataIndex :'f',width:100}
            ],
            data = [{a:'123',b:'100'}];
    	var store2 = new Store({
                data : data
            }),
            grid2 = new Grid.Grid({
            	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
                render:'#grid',
                width:'100%',
                columns : columns,
                store : store2
            });
    //grid2.render();


    var Grid = BUI.Grid,
        Toolbar = BUI.Toolbar,
        Data = BUI.Data,
        Store = Data.Store,
        columns = [{
            title : '注册时间',
            dataIndex :'a',
            width:200
        },{
            title : '会员手机号',
            dataIndex :'userPhone',
            width:120,
            renderer:function(value,rowObj){
				return value;
			}
        },{
            title : '会员姓名',
            dataIndex : 'c',
            width:100
        },{
            title : '消费总额',
            dataIndex : 'd',
            width:100
        },{
            title : '购买次数',
            dataIndex : 'e',
            width:100
        },{
            title : '本年度消费总额',
            dataIndex : 'f',
            width:100
        },{
            title : '本年度购买次数',
            dataIndex : 'g',
            width:100
        },{
            title : '所属门店名称',
            dataIndex : 'h',
            width:200
        },{
            title : '门店类型',
            dataIndex : 'i',
            width:100
        },{
            title : '上级会员手机号',
            dataIndex : 'j',
            width:120
        },{
            title : '所属大区',
            dataIndex : 'k',
            width:200
        },{
            title : '所属分公司',
            dataIndex : 'l',
            width:200
        },{
            title : '所属办事处',
            dataIndex : 'm',
            width:200
        }],
	    data = [{a:'200'},{a:'cdd',b:'edd'},{a:'1333',c:'eee',d:2},{a:'1333',c:'eee',d:2},{a:'1333',c:'eee',d:2}];
		
    	var store = new Store({
            data : data,
            autoLoad:true,
            pageSize:'20'
        }),
        grid = new Grid.Grid({
            width: '100%',
            height:getContentHeight(),
            render:'#grid2',
            columns : columns,
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:true
            },
            store : store
        });
    
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '注册时间',dataIndex :'regTime',width:200, renderer:function(value,rowObj){
				if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
			}},
			{title : '会员手机号',dataIndex :'userPhone',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '会员姓名',dataIndex :'userName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '消费总额',dataIndex :'totalTxAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '购买次数',dataIndex :'totalTxCmt',width:100, renderer:function(value,rowObj){				
				return value?value:'0';
			}},
			{title : '本年度消费总额',dataIndex :'yearTotalTxAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '本年度购买次数',dataIndex :'yearTotalTxCnt',width:100, renderer:function(value,rowObj){
				return value?value:'0';
			}},
			{title : '所属门店名称',dataIndex :'blgStoreName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '门店类型',dataIndex :'blgStoreType',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '上级会员手机号',dataIndex :'parentUserPhone',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '所属大区',dataIndex :'areaName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '所属分公司',dataIndex :'branchName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '所属办事处',dataIndex :'officeName',width:200, renderer:function(value,rowObj){
				return value;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/admin/sa/report/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
				width: '100%',
				height: '100%',
	            // 底部工具栏
	            bbar:{
	                // pagingBar:表明包含分页栏
	                pagingBar:true
	            }
			});
		var search = new Search({
			gridId:'grid2',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            btnId:"user_search"
		});
			var grid = search.get('grid');
			grid.render();
			
			
		});
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '注册会员总数',dataIndex :'regcnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '购买会员总数',dataIndex :'pnum',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '成交笔数',dataIndex :'txcnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '成交总金额',dataIndex :'txamt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '成交均价',dataIndex :'avg',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '成交客单价',dataIndex :'avg2',width:100, renderer:function(value,rowObj){
				return value;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/admin/sa/report/grid_json2',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
				width: '100%',
				height: '100%',
	            // 底部工具栏
	            bbar:{
	                // pagingBar:表明包含分页栏
	                pagingBar:false
	            }
			});
	
		var search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            btnId:"user_search"
		});
			var grid = search.get('grid');
			
			
		});


    BUI.use('bui/calendar',function(Calendar){
        var datepicker = new Calendar.DatePicker({
            trigger:'.calendar',
            //delegateTrigger : true, //如果设置此参数，那么新增加的.calendar元素也会支持日历选择
            autoRender : true,
            align :{
                node: 'trigger',     // 参考元素, falsy 或 window 为可视区域, 'trigger' 为触发元素, 其他为指定元素
                points: ['tl','tl'], // ['tr', 'tl'] 表示 overlay 的 tl 与参考节点的 tr 对齐
                offset: [0, 30]    // 有效值为 [n, m]
            }
        });
    });
</script>
</body>
</html>  