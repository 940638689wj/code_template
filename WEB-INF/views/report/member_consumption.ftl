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
	    <script src="${staticPath}/admin/js/echarts.js"></script>
	
	<link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/theme-01.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-text">会员消费指数</div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0" method="get">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" class="calendar control-text" id="beginTime" name="beginTime">
                            <span class="mr5">至</span>
                            <input type="text" class="calendar control-text"  id="endTime" name="endTime">
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
                        <div class="pull-left offset1">
                            <button class="button button-primary ml" id="user_search" name="user_search" type="button">搜索</button>
                        
                            <button id="export" type="button" class="button button-primary">导出明细报表</button>
                            
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
   <div class="content-top">
    <div id="tab"></div>
    <div id="volumeMain" style="height:400px;margin-top:50px;">

    </div>
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
		location.href ="${ctx}/report/consumerPrice/exportConsumerPrice?"+params;
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
            {text:'下单会员数',value:'1'}
        ]
    });
    BUI.use(['common/search','common/page'],function (Search) {
    	var search = new Search({
			
			formId:'searchForm_select',
            btnId:'user_search'
		});
    
    });
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        $('#log').text(item.get('text') + ' ' + item.get('value'));
    });
    tab.setSelected(tab.getItemAt(0));

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
     $(function () {
        // 基于准备好的dom，初始化echarts图表
        var myChart = echarts.init(document.getElementById('volumeMain'));
        
        var option = {
            tooltip : {
                trigger: 'axis',
                formatter: "{a}<br/> {b} <br/> {c}"
            },
            legend: {
                data:['下单会员数(单位：人)'],
                selected: {
				    '下单会员数(单位：人)': true,
				    
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
                }
                ],
                
            series : [
                {
                    name:'下单会员数(单位：人)',
                    type:'bar',
                    itemStyle: {
                        normal: {
                        	label : {show: false, position: 'top'},
                            color: '#1E90FF'
                        }
                    },
					symbol:'rect',
					symbolSize: 13,
					yAxisIndex: 0,
                    data: []
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
                url : "${ctx}/report/consumerPrice/line_data?beginTime="+bTime+"&endTime="+eTime,  
                data : {},  
                dataType : "json", //返回数据形式为json  
                success : function(data) {  
                if(data) {
                //	alert('~~~');  
                   options.xAxis[0].data = data.map1.dateList;  //时间 
              
                   options.series[0].data = data.map1.txCustomrtCnt;//商品退换率
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
	        		if(bTime.getTime()>eTime.getTime()){
		        		alert("开始日期和结束日期不正确！");
		        		return ;
	        		}
	        	}
	        	var myChart=echarts.getInstanceByDom(document.getElementById('volumeMain'));;
	        	getChartData(myChart);
        	});
    
</script>
</body>
</html>  