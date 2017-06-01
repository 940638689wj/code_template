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
        <div id="tab">
        </div>

    </div>
    <div class="content-top">
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0" method="get">
            <div class="row mb10">
                <div class="control-group">
                    <div class="controls  control-row-auto ml0">
                    	<div class="pull-left bui-form-group" data-rules="{dateRange : true}">
	           				<span class="" >下单时间：</span>
	                        <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
	                        <span class="mr5">至</span>
	                        <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>
	                        <span class="ml">会员类型：</span>
                        <select name="userTypeId">
                            	<option value="" selected>所有分类</option>
                                <#if userTypeList?? && userTypeList?has_content>
	                                <#list userTypeList as list>
	                                    <option value="${list.userTypeName}">${list.userTypeName}</option>
	                                </#list>
	                            </#if>
                            </select>
                        <span class="ml">购买渠道：</span>
                        <select name="txChannelCd" class="mr5">
                            <option value="">全部</option>
                            <option value="商城">商城</option>
                            <option value="微店">微店</option>
                            <option value="门店">门店</option>
                            <option value="其它">其它</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row mb10">
                <div class="control-group">
              
                    	<span class="pull-left " >手机号码：</span>
                        <input type="text" id="userPhone" name="userPhone" class="control-text pull-left ">
                        <span class="ml pull-left ">订单号：</span>
                        <input type="text" id="orderNum" name="orderNum" class="control-text pull-left ">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
	                        <span class="ml" >注册时间：</span>
	                        <input type="text" id="rBeginTime" name="rBeginTime" class="calendar control-text">
	                        <span class="mr5">至</span>
	                        <input type="text" id="rEndTime" name="rEndTime" class="calendar control-text">
                        </div>
                        <div class="controls  control-row-auto ml0">
                        <button id="user_search" class="button button-primary ">搜索</button>
                        <button type="button" class="button button-primary" id="export">导出</button>
						</div>
						
                    </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30" id="counts">
                            首次购买会员总数：<span class="red"  ><#if counts??>${(counts)!}</#if></span>
                        </label>
                        <label class="control-label control-label-auto mr30" id="sum">
                            首次购买总金额：<span class="red"><#if sum??>${(sum)!}</#if></span>
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
	$("#export").click(function(){
		
		var params=$("#searchForm_select").serialize();
		
		location.href ="${ctx}/report/firstBuyReport/exportFirstBuyReport?"+params;
		
    	BUI.Message.Alert("导出成功");
	});
</script>
<script type="text/javascript">
	//更新页面数据
	$("#user_search").click(function(){
		
		var params=$("#searchForm_select").serialize();
		var bTime=$("#beginTime").val();
    	var eTime=$("#endTime").val(); 
    	var rBTime=$("#rBeginTime").val();
    	var rETime=$("#rEndTime").val(); 
    	if( bTime&&eTime ){
    		bTime=new Date(bTime);
    		eTime=new Date(eTime);
    		if(bTime.getTime()>eTime.getTime()){
        		alert("下单开始日期和结束日期不正确！");
        		return ;
    		}
    	}
    	if( rBTime&&rETime ){
    		rBTime=new Date(rBTime);
    		rETime=new Date(rETime);
    		if(rBTime.getTime()>rETime.getTime()){
        		alert("注册开始日期和结束日期不正确！");
        		return ;
    		}
    	}
    	getTotalData(params);
	});
	function getTotalData(params) {  
            //通过Ajax获取数据  
            $.ajax({  
                type : "post",  
                async : false, //同步执行  
                url : "${ctx}/report/firstBuyReport/getTotalData?"+params,  
                data : {},  
                dataType : "json", //返回数据形式为json  
                success : function(data) {  
                if(data) { 
                
                   $("#counts").find("span").html(data.map1.counts);
                   $("#sum").find("span").html(data.map1.sum);
                 
                   }
                },  
                error : function(errorMsg) {  
                    
                }  
            });
        }  
	
	
	
</script>
<script type="text/javascript">

    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'会员首次购买报表',value:'1'}
        ]
    });
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        $('#log').text(item.get('text') + ' ' + item.get('value'));
    });
    tab.setSelected(tab.getItemAt(0));

    var Grid = BUI.Grid,
        Toolbar = BUI.Toolbar,
        Data = BUI.Data;
    var Grid = Grid,
        Store = Data.Store,
        columns = [{
            title : '注册时间',
            dataIndex :'a',
            width:200
        },{
            title : '用户手机号',
            dataIndex :'b',
            width:100
        },{
            title : '用户名',
            dataIndex : 'c',
            width:100
        },{
            title : '会员类型',
            dataIndex : 'd',
            width:100
        },{
            title : '购买渠道',
            dataIndex : 'e',
            width:100
        },{
            title : '订单来源门店',
            dataIndex : 'f',
            width:150
        },{
            title : '订单来源微店主手机号',
            dataIndex : 'g',
            width:150
        },{
            title : '配送门店',
            dataIndex : 'h',
            width:150
        },{
            title : '所属大区',
            dataIndex : 'i',
            width:150
        },{
            title : '所属分公司',
            dataIndex : 'j',
            width:150
        },{
            title : '所属办事处',
            dataIndex : 'k',
            width:150
        },{
            title : '订单编号',
            dataIndex : 'l',
            width:100
        },{
            title : '订单应支付金额',
            dataIndex : 'm',
            width:100
        },{
            title : '下单时间',
            dataIndex : 'n',
            width:200
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
            render:'#grid',
            columns : columns,
            tbar:{
                items:[{
                    btnCls : 'button button-small',
                    text:'导出全部报表',
                }]
            },
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:true
            },
            store : store
        });
    //grid.render();
BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '注册时间',dataIndex :'regTime',width:200, renderer:function(value,rowObj){
				if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
			}},
			{title : '用户手机号',dataIndex :'userPhone',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '用户名',dataIndex :'userName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '会员类型',dataIndex :'userType',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '购买渠道',dataIndex :'txChannelCd',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '订单来源门店',dataIndex :'srcStoreName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单来源微店',dataIndex :'srcShopPhone',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '上级微店主',dataIndex :'fatherShopPhone',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '配送门店',dataIndex :'sendStoreName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			
			{title : '所属大区',dataIndex :'areaName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '所属分公司',dataIndex :'branchName',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '所属办事处',dataIndex :'userTypeDesc',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单编号',dataIndex :'orderNum',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单应支付金额',dataIndex :'orderPayAmt',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '下单时间',dataIndex :'orderCreateTime',width:200, renderer:function(value,rowObj){
				if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
			}}
		];
		
				
		var store = Search.createStore('${ctx}/report/firstBuyReport/grid_json',{pageSize:15});
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