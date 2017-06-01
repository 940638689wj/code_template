<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script src="${staticPath}/admin/js/echarts.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
        <div id="tab1">

        </div>

        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls control-row-auto ml0 ">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>

                        <div class="pull-left">
                            <input type="text" id="productName" name="productName" class="control-text" placeholder="商品名称">
                            <input type="hidden" id="originPlatformCd" name="originPlatformCd" class="control-text"
                                   placeholder="订单来源系统CD">
                            <button id="user_search" name="user_search" type="button" class="button button-primary ml">
                                搜索
                            </button>
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
                        
                         <div class="pull-left offset1" id="plactformSelectContainer">
                        	<button onclick="totalSearch()" type="button" class="button button-primary ml">全部</button>
                        	<button onclick="totalSearch(1)" type="button" class="button ml">手机端</button>
                        	<button onclick="totalSearch(0)" type="button" class="button ml">PC端</button>
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


<script type="text/javascript">

</script>
<script type="text/javascript">
	//导出
	function generateAllReport(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/admin/sa/dailyOrders/exportMallSaleReport?"+params;
    	BUI.Message.Alert("导出成功");
	};
	
	function exportProductInfo(){
	 var url ="${ctx}/admin/sa/order/exportProductInfo?productName="+$("input[name='productName']").val()
	                                                                 +"&beginTime="+ $('#beginTime').val()
	                                                                 +"&endTime="+$('#endTime').val() 
	                                                                 +"&originPlatformCd="+$('#originPlatformCd').val();
	 window.open(url);
	}

</script>
<script type="text/javascript">
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'商品销售表',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '图片',dataIndex :'productPicUrl',width:200, renderer : function(value, rowObj){
                var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	}else{
            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	}
                return img_url;
            }},
			{title : '销量排名',dataIndex :'rowNum',width:200},
			{title : '商品名称',dataIndex :'productName',width:200},
			
			{title : '货号',dataIndex :'barCode',width:200},
			{title : '总销量',dataIndex :'countNo',width:200},
		];
		
				
		var store = Search.createStore('${ctx}/admin/sa/order/sumInfo_grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,{
			tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small', handler: exportProductInfo}
                ]
            },
			plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
			width: '100%',
			height:	getContentHeight(),
            // 底部工具栏,pagingBar:表明包含分页栏
            //bbar:{
              //  pagingBar:true
            //}
		});
	
		var search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
           // btnId:'user_search'
		});
			var grid = search.get('grid');
			
			 $("#user_search").click(function () {
            //var params=encodeURI(decodeURIComponent($("#searchForm_select").serialize(),true));
            //var params = $("#searchForm_select").serialize();
            var bTime = $("#beginTime").val();
            var eTime = $("#endTime").val();

            if (bTime && eTime) {
                bTime = new Date(bTime);
                eTime = new Date(eTime);
                if (bTime.getTime() > eTime.getTime()) {
                    return;
                }
            }
            search.load();
        });
			
		});
		
	
	
	//点击全部，搜索日期范围内全部订单
	function totalSearch(val){
		var originPlatformCd;
		if(val!=null){
			originPlatformCd = val;
		}else{
			originPlatformCd = '';
		}
		$("#originPlatformCd").attr("value",originPlatformCd);
		$("#user_search").trigger("click");
	}
	
	// 初始化
    $(function () {
        var t = $(".container").find("li");
        $(t).each(function (i, item) {
            $(this).click(function () {
                // 有颜色就删掉
                $("li").removeClass('step-active');
                // 改变颜色
                $(this).addClass("step-active");
                // 请求处理
                var bTime;
                var eTime;
                if (this.id == "thisWeek") {
                    bTime = getCurrentWeek()[0];
                    eTime = getCurrentWeek()[1];
                } else if (this.id == "lastWeek") {
                    bTime = getPreviousWeek()[0];
                    eTime = getPreviousWeek()[1];
                } else if (this.id == "thisMonth") {
                    bTime = getCurrentMonth()[0];
                    eTime = getCurrentMonth()[1];
                } else if (this.id == "lastMonth"){
                    bTime = getPreviousMonth()[0];
                    eTime = getPreviousMonth()[1];
                }
                $("#beginTime").attr("value", bTime);
                $("#endTime").attr("value", eTime);
                //refeshData(bTime,eTime);
            });
        });
    });

    //点击按钮 样式变化
    $("#plactformSelectContainer").find("button").click(function(){
        // 有颜色就删掉
        $("#plactformSelectContainer button").removeClass('button-primary');
		// 改变颜色
		$(this).addClass("button-primary");
    });
</script>

</body>
</html>  