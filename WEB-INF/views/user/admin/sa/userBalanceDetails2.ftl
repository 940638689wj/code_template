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
                    <div class="controlscontrol-row-auto  ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text" >
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text" >
                        </div>
                        <div class="pull-left">
                        	<button id="user_search" name="user_search" type="button" class="button button-primary ml">搜索</button>
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
                        
                        <!--input type="hidden" id="originPlatformCd" name="originPlatformCd"-->
                        
                      
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30">存入金额：<span class="red" id="orderTxCnts">￥0.00</span></label>
                        <label class="control-label control-label-auto mr30">消费金额：<span class="red" id="orderTxAmts">￥0.00</span></label>
                        <label class="control-label control-label-auto mr30">余额：<span class="red" id="productSalesCnts">￥0.00</span></label>
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
	//页面加载时 取本月时间
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
	function generateAllReport(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/admin/sa/report/userBalanceDetail/exportMallSaleReport?"+params;
    	BUI.Message.Alert("导出成功");
	};
	
</script>
<script type="text/javascript">
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'账户余额统计',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '时间',dataIndex :'createTime',width:200, renderer: BUI.Grid.Format.datetimeRenderer},
			{title : '类型',dataIndex :'',width:200, renderer:function(value,rowObj){
				if(rowObj.balanceExpend==null||rowObj.balanceExpend==0){
					value="存入金额";
				}else{
					value="消费金额";
				}
				return value;
			}},
			{title : '金额',dataIndex :'balanceExpend',width:200, renderer:function(value,rowObj){
				if(value==null||value==0){
					value="+"+rowObj.balanceIncome;	
				}else{
					value="-"+value;
				}
				return value;
			}},
			
			{title : '渠道',dataIndex :'codeCnName',width:200, renderer:function(value,rowObj){
				if(value==null){
					value="";
				}
				return value;
			}},
			{title : '会员',dataIndex :'phone',width:200, renderer:function(value,rowObj){
					return value;
			
			}},
			{title : '姓名',dataIndex :'userName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '备注',dataIndex :'remark',width:200, renderer:function(value,rowObj){
				return value;
			}}
		];
		
				
		var store = Search.createStore('${ctx}/admin/sa/report/userBalanceDetail/grid_json',{pageSize:20});
		var gridCfg = Search.createGridCfg(columns,{
			tbar: {
                items: [
                    {text: '导出全部报表', btnCls: 'button button-small', handler: generateAllReport}
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
	
        search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            //btnId:'user_search'
		});
        var grid = search.get('grid');
        grid.render();

        //页面加载完成后获取当前默认时间总数
        $(search_sum());



    });
    
    //获取当前搜索时间总数
	$("#user_search").click(search_sum);
    
    //根据时间段获取总数的方法
    function search_sum(){
            var beginTime = $("#beginTime").val();
            var endTime = $("#endTime").val();
            var originPlatformCd = $("#originPlatformCd").val();
            search.load();
            $.ajax({
                url:'${ctx}/admin/sa/report/userBalanceDetail/getTotal',
                dataType : 'json',
                method : 'get',
                data : {beginTime:beginTime,endTime:endTime,originPlatformCd:originPlatformCd},
                success : function(data){
                    $("#orderTxCnts").html('￥'+(data.balanceIncome).toFixed(2)),
                	 $("#orderTxAmts").html('￥'+(data.balanceExpend).toFixed(2)),
                 	$("#productSalesCnts").html('￥'+(data.balance).toFixed(2))
                          
                }
            })
        };
		
	
	
	//点击全部，搜索日期范围内全部收支
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
	
	// 初始化(按钮样式变化)
    $(function(){
    	var t = $(".steps-small").find("li");
   		$(t).click(function(){
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
    		search_sum();//切换时间时自动刷新页面内容
    		//refeshData(bTime,eTime);
    	});
    });	
    

</script>

</body>
</html>  