<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script src="${staticPath}/admin/js/echarts.js"></script>
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
                            <#--
                            <div>
	                        <tr>
	                        <td>订单成交量</td><td>订单总额</td><td>订单应支付总额</td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
	                        </tr>
	                        </div>
	                        -->
                        </div>
                        
                        <div class="pull-left">
                        	<button id="user_search" name="user_search" type="button" class="button button-primary ml">搜索</button>
                            <button id="export" type="button"class="button button-primary" >导出全部报表</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>
</div>

<div class="content-top">
    <div id="volumeMain" style="height:400px;margin-top:50px;">

    </div>
</div>
<script type="text/javascript">
	$(function(){ 
		$("#thisMonth").addClass("step-active");
		var bTime=getCurrentMonth()[0];
        var eTime=getCurrentMonth()[1]; 
        $("#beginTime").attr("value",bTime);
        $("#endTime").attr("value",eTime); 
	});
</script>
<script type="text/javascript">
	//导出
	$("#export").click(function(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/report/mallSale/exportMallSaleReport?"+params;
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
        	{text:'商城销售报表',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '订单成交量',dataIndex :'orderTxCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '订单总额',dataIndex :'orderTxAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '订单应支付总额',dataIndex :'orderRealPayAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '优惠券抵扣',dataIndex :'couponDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '积分抵扣金额',dataIndex :'pointDiscountAmt',width:100, renderer:function(value,rowObj){				
				return value.toFixed(2);
			}},
			{title : '红包抵扣金额',dataIndex :'redEnvelopeDiscoutAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '购酒券抵扣金额',dataIndex :'balanceDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '微店收入抵扣',dataIndex :'mStoreCommDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '分销收入抵扣',dataIndex :'developRebateDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '优惠总额',dataIndex :'totalDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '商品总销量',dataIndex :'productSalesCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '商品退换量',dataIndex :'changeReturnCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '商品退换率',dataIndex :'changeReturnRate',width:100, renderer:function(value,rowObj){
				var str=value.toFixed(2);
				str+='%';
				return str;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/report/mallSale/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
				width: '100%',
				height:'100%',
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
<script type="text/javascript">
        $(function () {
        // 基于准备好的dom，初始化echarts图表
        var myChart = echarts.init(document.getElementById('volumeMain'));
        
        var option = {
            tooltip : {
                trigger: 'axis',
                formatter: "{a}<br/> {b} <br/> {c}"
            },
            legend: {
                data:['订单成交量','订单总额(单位：元)','商品退换量','商品退换率'],
                selected: {
				    '订单成交量': true,
				    '订单总额(单位：元)': false,
				    '商品退换量': false,
				    '商品退换率': false
				}
            },
            xAxis : [
                {
                    type : 'category',
                    data : [],
                    axisTick:{
                    	interval:0
                    }
                }
            ],
            yAxis : [
                {
                    type : 'value',
                    axisLabel : {
                        formatter: function (value) {
                            // Function formatter
                            return value
                        }
                    }
                },
                {
                    type : 'value',
                    position: 'right',
                    axisLabel : {
                        formatter: function (value) {
                            // Function formatter
                            return value+'%'
                        }
                    },
                    splitLine : {
		                show: false
		            }
                }
                ],
                
            series : [
                {
                    name:'订单成交量',
                    type:'bar',
                    itemStyle: {
                        normal: {
                        	//label : {show: true, position: 'top'},
                            color: '#1E90FF'
                        }
                    },
					symbol:'rect',
					symbolSize: 13,
					yAxisIndex: 0,
                    data: []
                },
                {
                    name:'订单总额(单位：元)',
                    type:'line',
                    itemStyle: {
                        normal: {
                        	//label : {show: true, position: 'top',formatter: '{c}'},
                            color: '#B3764D'
                        }
                    },
                    symbol:'circle',
					symbolSize: 13,
                    smooth:true,
                    yAxisIndex: 0,
                    data: []
                },
                {
                    name:'商品退换量',
                    type:'bar',
                    itemStyle: {
                        normal: {
                        	//label : {show: true, position: 'top'},
                            color: '#DD22DD'
                        }
                    },
                    symbol:'triangle',
					symbolSize: 13,
					yAxisIndex: 0,
                    data:[]
                },
                {
                    name:'商品退换率',
                    type:'line',
                    itemStyle: {
                        normal: {
                        	//label : {show: true, position: 'top',formatter: '{c}%'},
                            color: '#61B34D'
                        }
                    },
                    symbol:'diamond',
					symbolSize: 13,
					smooth:true,
                    yAxisIndex: 1,
                    data:[]
                }
            ]
        };
        // 为echarts对象加载数据
        myChart.setOption(option);
        myChart.hideLoading();
        getChartData(myChart);//aja后台交互   
        //setChartData();
    });
    
        function getChartData(myChart) {  
            //获得图表的options对象  
            var options = myChart.getOption();  
            var bTime=$("#beginTime").val();
            var eTime=$("#endTime").val();
            //通过Ajax获取数据  
            $.ajax({  
                type : "post",  
                async : false, //同步执行  
                url : "${ctx}/report/mallSale/line_data?beginTime="+bTime+"&endTime="+eTime,  
                data : {},  
                dataType : "json", //返回数据形式为json  
                success : function(data) {  
                if(data) {  
                   options.xAxis[0].data = data.map1.dateList;  //时间 
                   options.series[0].data = data.map1.orderTxCnt;//订单成交量
                   options.series[1].data = data.map1.orderTxAmt;//订单总额
                   options.series[2].data = data.map1.changeReturnCnt;//商品退换量
                   options.series[3].data = data.map1.changeReturnRate;//商品退换率
//                  alert(options.series[2].data);
//                  alert(options.series[3].data);
                   myChart.hideLoading();  
                   myChart.setOption(options);  
                    }
                },  
                error : function(errorMsg) {  
                    alert("不好意思，图表请求数据失败啦!"); 
                    myChart.hideLoading();  
                }  
            });
        }  
    
    $("#user_search").click(function(){
        		var bTime=$("#beginTime").val();
	        	var eTime=$("#endTime").val(); 
	        	if( bTime&&eTime ){
	        		 
	        		bTime=new Date(bTime);
	        		eTime=new Date(eTime);
	        		
	        	}
	        	var myChart=echarts.getInstanceByDom(document.getElementById('volumeMain'));;
	        	getChartData(myChart);
        	});
    
</script>
</body>
</html>  