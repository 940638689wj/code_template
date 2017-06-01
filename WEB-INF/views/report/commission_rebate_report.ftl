<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
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
        <div id="tab"></div>
        <div id="grid" class="mb10"></div>
    </div>
    <div class="content-top">
        <form class="form-horizontal search-form mb0" id="searchForm_select" name="searchForm_select" method="get">
            <div class="row mb10">
                <div class="control-group">
                    <div class="controls  control-row-auto ml0">
                        <input type="text" id="userPhone" name="userPhone" class="control-text" placeholder="会员手机号检索">
                        <button class="button button-primary" type="submit" id="user_search" >搜索</button>
                        <button class="button button-primary" id="export" type="button" >导出</button>
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
		
		location.href ="${ctx}/report/userFirstTxInfo/exportUserFirstTxInfo?"+params;
		
    	BUI.Message.Alert("导出成功");
	});
</script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'会员佣金返利报表',value:'1'}
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
                {title : '发展会员奖励',dataIndex :'a', width:100},
                {title : '发展会员积分',dataIndex :'b', width:100},
                {title : '发展分销返利',dataIndex :'c',width:100},
                {title : '商品URL返利',dataIndex :'d', width:200},
                {title : '首单奖励',dataIndex :'e', width:100},
                {title : '下级微店主返利',dataIndex :'f',width:100},
                {title : '微店佣金',dataIndex :'g', width:100},
                {title : '已提现总额',dataIndex :'h', width:100},
                {title : '未提现总额',dataIndex :'i',width:100},
                {title : '微店主总数',dataIndex :'j', width:100},
                {title : '会员总数',dataIndex :'k',width:100}
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
            title : '会员手机号',
            dataIndex :'a',
            width:150
        },{
            title : '会员姓名',
            dataIndex :'b',
            width:100
        },{
            title : '佣金总额',
            dataIndex : 'c',
            width:100
        },{
            title : '下级微店返利总额',
            dataIndex : 'd',
            width:110
        },{
            title : '首单奖励总额',
            dataIndex : 'e',
            width:100
        },{
            title : '商品URL返利总额',
            dataIndex : 'f',
            width:100
        },{
            title : '发展分销返利',
            dataIndex : 'g',
            width:100
        },{
            title : '发展会员奖励',
            dataIndex : 'h',
            width:100
        },{
            title : '发展会员数',
            dataIndex : 'i',
            width:100
        },{
            title : '已提现总额',
            dataIndex : 'j',
            width:100
        },{
            title : '未提现总额',
            dataIndex : 'k',
            width:100
        },{
            title : '是否微店主',
            dataIndex : 'l',
            width:100
        }],
        data = [{a:'200'},{a:'cdd',b:'edd'},{a:'1333',c:'eee',d:2},{a:'1333',c:'eee',d:2},{a:'1333',c:'eee',d:2}];

    var store = new Store({
            data : data,
            autoLoad:true,
            pageSize:'20'
        }),
        grid = new Grid.Grid({
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
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
    //grid.render();

BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '会员手机号',dataIndex :'userPhone',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '会员姓名',dataIndex :'userName',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '佣金总额',dataIndex :'totalRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '下级微店返利总额',dataIndex :'sonShopRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '首单奖励总额',dataIndex :'firstOrderRebateAmt',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '商品URL返利总额',dataIndex :'urlRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '发展分销返利',dataIndex :'developDistriRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '发展会员奖励',dataIndex :'developMemberRebateAmt',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '发展会员积分',dataIndex :'developMemberPoint',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '发展会员数',dataIndex :'developMemberCnt',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '已提现总额',dataIndex :'withdrawAmt',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '未提现总额',dataIndex :'unwithdrawAmt',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '是否微店主',dataIndex :'isMStore',width:200, renderer:function(value,rowObj){
				return value;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/report/userFirstTxInfo/grid_json2',{pageSize:15});
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
			
			
		});
BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
		{title : '发展会员奖励',dataIndex :'developMemberRebateAmt',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '发展会员积分',dataIndex :'developMemberPoint',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '发展分销返利',dataIndex :'developDistriRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '商品URL返利',dataIndex :'urlRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '首单奖励',dataIndex :'firstOrderRebateAmt',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '下级微店主返利',dataIndex :'sonMStoreRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '微店佣金',dataIndex :'mStoreRebateAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '已提现总额',dataIndex :'withdrawedAmt',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '未提现总额',dataIndex :'unwithdrawAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '微店主总数',dataIndex :'mStoreCnt',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '会员总数',dataIndex :'memberCnt',width:200, renderer:function(value,rowObj){
				return value;
			}}
			
		];
		
				
		var store = Search.createStore('${ctx}/report/userFirstTxInfo/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   //plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
				plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
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