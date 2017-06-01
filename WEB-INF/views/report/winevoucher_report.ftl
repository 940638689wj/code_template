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
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
	
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
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">至</span>
                            <input type="text" id="endTime" name="endTime" type="text" class="calendar control-text">
                            <span class="ml">会员类型：</span>
                            
                            
                            <select name="userTypeId">
                            	<option value="" selected>所有分类</option>
                                <#if userTypeList?? && userTypeList?has_content>
	                                <#list userTypeList as list>
	                                    <option value="${list.userTypeId}">${list.userTypeName}</option>
	                                </#list>
	                            </#if>
                            </select>
                        </div>
                        <div class="steps steps-small pull-left">
                           <ul>
                                <li class="step-first" id="thisWeek">
                                    <b class="stepline"></b>
                                    <div class="stepind">本周</div>
                                </li>
                                <li id="lastWeek">
                                    <b class="stepline"></b>
                                    <div class="stepind">上周</div>
                                </li>
                                <li id="thisMonth">
                                    <b class="stepline"></b>
                                    <div class="stepind">本月</div>
                                </li>
                                <li class="step-last" id="lastMonth">
                                    <b class="stepline"></b>
                                    <div class="stepind">上月</div>
                                </li>
                            </ul>
                        </div>
                        <div class="pull-left">
                            <input value="" name="userPhone" id="userPhone"class="input-normal control-text offset1" placeholder="会员手机号">
                            <button id="user_search" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label id="income" class="control-label control-label-auto mr30">
                            存入金额：<span class="red">${(income)!'0'}</span>
                        </label>
                        <label label id="expenditure" class="control-label control-label-auto mr30">
                            消费金额：<span class="red">${(expenditure)!'0'}</span>
                        </label>
                        <label label id="balance" class="control-label control-label-auto mr30">
                            余额：<span class="red">${(income-expenditure)!'0'}</span>
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
	//更新页面数据
	$("#user_search").click(function(){
		var params=encodeURI(encodeURI(decodeURIComponent($("#searchForm_select").serialize(),true)));
		var bTime=$("#beginTime").val();
    	var eTime=$("#endTime").val(); 
    	if( bTime&&eTime ){
    		bTime=new Date(bTime);
    		eTime=new Date(eTime);
    		if(bTime.getTime()>eTime.getTime()){
        		alert("开始日期和结束日期不正确！");
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
                url : "${ctx}/report/wineBalanceTotal/getTotalData?"+params,  
                data : {},  
                dataType : "json", //返回数据形式为json  
                success : function(data) {  
                if(data) {  
                
                 if (typeof(data.map1.income) == "undefined") {
                 var income=0;
                 }else{
                 var income=data.map1.income;
                 }
                 if (typeof(data.map1.expenditure) == "undefined") {
                 var expanditure=0;
                 }else{
                 var expanditure=data.map1.expenditure;
                 }
                   $("#income").find("span").html(income);
                   $("#expenditure").find("span").html(expanditure);
                   var total=income-expanditure;
                   var balance=total.toFixed(2);
                   $("#balance").find("span").html(balance);
                   }
                },  
                error : function(errorMsg) {  
                    
                }  
            });
        }  
	
	
</script>
<script type="text/javascript">
// 初始化
    $(function(){
    	var t = $(".container").find("li");
   		$(t).each(function(i,item){
        	$(this).click(function(){
                // 有颜色就删掉
                $("li").removeClass('step-active');
        		// 改变颜色
        		$(this).addClass("step-active");
        		// 请求处理
        		var bTime;
        		var eTime;
        		if(this.id=="thisWeek"){ 
        		  	bTime=getCurrentWeek()[0];
        		  	eTime=getCurrentWeek()[1];
        		}else if(this.id=="lastWeek"){
        			bTime=getPreviousWeek()[0];
        			eTime=getPreviousWeek()[1]; 
        		}else if(this.id=="thisMonth"){
        			bTime=getCurrentMonth()[0];
        			eTime=getCurrentMonth()[1]; 
        		} else{
        			bTime=getPreviousMonth()[0];
        			eTime=getPreviousMonth()[1];
        		}
        		
        		$("#beginTime").attr("value",bTime);
        		$("#endTime").attr("value",eTime); 
        		//refeshData(bTime,eTime);
        	});
    	});
    });
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'会员购酒券统计',value:'1'}
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
            title : '商品销量排名',
            dataIndex :'a',
            width:100
        },{
            title : '商品编码',
            dataIndex :'b',
            width:100
        },{
            title : '商品名称',
            dataIndex : 'c',
            width:200
        },{
            title : '系列分类',
            dataIndex : 'd',
            width:150
        },{
            title : '商品条码',
            dataIndex : 'e',
            width:150
        },{
            title : '图片',
            dataIndex : 'f',
            width:150
        },{
            title : '退换率',
            dataIndex : 'g',
            width:100
        },{
            title : '销售额',
            dataIndex : 'h',
            width:100
        },{
            title : '销售量',
            dataIndex : 'i',
            width:100
        },{
            title : '待发货量',
            dataIndex : 'j',
            width:100
        },{
            title : '退换量',
            dataIndex : 'k',
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
			{title : '时间',dataIndex :'eventTime',width:200, renderer:function(value,rowObj){
				if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
			}},
			{title : '类型',dataIndex :'typeCd',width:120, renderer:function(value,rowObj){
				return value;
			}},
			{title : '金额',dataIndex :'eventAmt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '会员手机号',dataIndex :'userPhone',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '姓名',dataIndex :'userName',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '备注',dataIndex :'remark',width:200, renderer:function(value,rowObj){
				return value;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/report/wineBalanceTotal/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
				width: '100%',
				height: getContentHeight(),
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