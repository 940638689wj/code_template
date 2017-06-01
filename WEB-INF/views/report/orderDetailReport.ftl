<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
	<#include "../../../includes/sa/header.ftl"/>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
	<script type="text/javascript" src="${staticPath}/admin/js/dateFormate.js"></script>
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
                        
                        <div class="pull-left">
                            <input type="text" id="orderPhone" name="orderPhone" class="control-text" placeholder="下单人手机号">
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
                        	<button id="user_search" name="user_search" type="button" class="button button-primary ml">搜索</button>
                            <button id="export" type="button"class="button button-primary" >导出报表</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
            	<div class="pull-left">
                    <label id="orderPayAmtTotal" class="control-label control-label-auto mr30">应支付总额：<span class="red"><#if order??>${order.map1.ORDERPAYAMT!'0.00'} 元</#if></span></label>
                    <label id="orderQuantity" class="control-label control-label-auto mr30">订单数量：<span class="red"><#if order??>${order.map1.ORDERQUANTITY!'0'}</#if></span></label>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
	//导出
	$("#export").click(function(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/report/orderDetailReport/exportOrderDetailReport?"+params;
    	BUI.Message.Alert("导出成功");
	});
</script>
<script type="text/javascript">
	//更新页面数据
	$("#user_search").click(function(){
		var params=$("#searchForm_select").serialize();
		/*
		var bTime=$("#beginTime").val();
    	var eTime=$("#endTime").val(); 
    	if( bTime&&eTime ){
    		bTime=new Date(bTime);
    		eTime=new Date(eTime);
    		if(bTime.getTime()>eTime.getTime()){
        		//BUI.Message.Alert("开始日期和结束日期不正确！");
        		return ;
    		}
    	}
    	var orderPhone=$("#orderPhone").val();
    	var reg=/^(\d{11})$/;
    	if(orderPhone){
	    	if(!reg.test(orderPhone)){
	    		BUI.Message.Alert("手机号输入不正确！");
	        	return false;
	    	}
    	}*/
    	getTotalData(params);
	});
	
	function getTotalData(params) {  
        //通过Ajax获取数据  
        $.ajax({  
            type : "post",  
            async : false, //同步执行  
            url : "${ctx}/report/orderDetailReport/getTotalData?"+params,  
            data : {},  
            dataType : "json", //返回数据形式为json  
            success : function(data) {  
	            if(data) {  
	               $("#orderPayAmtTotal").html("应支付总额：<span class='red'>"+data.map1.ORDERPAYAMT+" 元"+"</span>");
	               $("#orderQuantity").html("订单数量：<span class='red'>"+data.map1.ORDERQUANTITY+"</span>");
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
        	{text:'订单明细报表',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '订单号',dataIndex :'orderNum',width:200, renderer:function(value,rowObj){
				var str='<a href="${ctx}/report/orderDetailReport/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
	            return str;
			}},
			{title : '订单来源系统',dataIndex :'orderSrcSystemDesc',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单来源平台',dataIndex :'orderSrcDeiveDesc',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单状态',dataIndex :'orderStatusDesc',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单属性',dataIndex :'orderPropertyDesc',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '支付状态',dataIndex :'payStatusDesc',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '下单时间',dataIndex :'orderCreateTime',width:200, renderer:function(value,rowObj){
				//return value;
				var date = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
				return date;
			}},
			{title : '订单总额',dataIndex :'orderTotalAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '应付金额',dataIndex :'orderPayAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '下单人',dataIndex :'orderUserName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '下单人手机号',dataIndex :'orderPhone',width:100, renderer:function(value,rowObj){
				return value;
			}}
		];
		
		var store = Search.createStore('${ctx}/report/orderDetailReport/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   width: '100%',
				height:getContentHeight(),
	            // 底部工具栏
	            bbar:{
	                // pagingBar:表明包含分页栏
	                pagingBar:true
	            },
	            plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
			});
	
		var search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            btnId:'user_search'
		});
			var grid = search.get('grid');
		});
		
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
</script>
</body>
</html>  