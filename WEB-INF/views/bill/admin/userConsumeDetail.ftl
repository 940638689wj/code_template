<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
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
                    <div class="controls control-row-auto ml0 ">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text" >
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text" >
                        </div>
						
						
                        <div class="pull-left">
                            <input type="text" id="loginName" name="loginName" class="control-text" placeholder="会员账号">                           
                            <button id="user_search" name="user_search" type="button" class="button button-primary ml">搜索 </button>                            
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
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30">售出订单总数：<span class="red" id="orderTxCnts">0</span></label>
                        <label class="control-label control-label-auto mr30">售出商品总数：<span class="red" id="orderTxAmts">0</span></label>
                        <label class="control-label control-label-auto mr30">售出订单总金额：<span class="red" id="productSalesCnts">￥0.00</span></label>
                    </div>
                </div>
            </div>
            <div class="row mb10">
                <button id="export" type="button" class="button button-primary">导出</button>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
    //导出
    $("#export").click(function () {
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/sa/userConsumeDetail/exportUserConsumeDetail?" + params;
        BUI.Message.Alert("导出成功");
    });
</script>
<script type="text/javascript">
    <#--//更新页面数据-->
    <#--$("#user_search").click(function () {-->
        <#--var params = $("#searchForm_select").serialize();-->

        <#--getTotalData(params);-->
    <#--});-->

    <#--function getTotalData(params) {-->
        <#--//通过Ajax获取数据  -->
        <#--$.ajax({-->
            <#--type: "post",-->
            <#--async: false, //同步执行-->
            <#--url: "${ctx}/report/orderDetailReport/getTotalData?" + params,-->
            <#--data: {},-->
            <#--dataType: "json", //返回数据形式为json-->
            <#--success: function (data) {-->
                <#--if (data) {-->
                    <#--$("#orderPayAmtTotal").html("应支付总额：<span class='red'>" + data.map1.ORDERPAYAMT + " 元" + "</span>");-->
                    <#--$("#orderQuantity").html("订单数量：<span class='red'>" + data.map1.ORDERQUANTITY + "</span>");-->
                <#--}-->
            <#--},-->
            <#--error: function (errorMsg) {-->

            <#--}-->
        <#--});-->
    <#--}-->


</script>
<script type="text/javascript">
//页面加载时 取本月时间
	$(function(){ 

	    $("#thisMonth").addClass("step-active");
		var bTime=getCurrentMonth()[0];
	    var eTime=getCurrentMonth()[1]; 
	    $("#beginTime").attr("value",bTime);
	    $("#endTime").attr("value",eTime);	
        console.log(eTime+'加载完成时'); 
	});
</script>

<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '会员消费明细', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: '订单号', dataIndex: 'orderNumber', width: 140, visible: true, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '会员', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {             
                return value;
            }
            },
            {
                title: '订单金额', dataIndex: 'orderTotalAmt', width: 100, visible: true, renderer: function (value, rowObj) {
                if(value== null || value=='0'  ){
                	value=0;
                }
                return value.toFixed(2);
            }
            },
            {
                title: '商品数量', dataIndex: 'quantity', width: 100, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '下单时间', dataIndex: 'orderCreateTime', width: 200, renderer: function (value, rowObj) {
                if(value==null){
                	value='';
                	return value;
                }
                var date = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
                return date;
            }
            },
             {
                title: '订单完成时间', dataIndex: 'orderCompleteTime', width: 200, renderer: function (value, rowObj) {
                if(value==null){
                	value='';
                	return value;
                }
               	var date = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
               	return date;
            }
            }           
           
           
        ];

        var store = Search.createStore('${ctx}/admin/sa/userConsumeDetail/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns,
                {
                    width: '100%',
                    height: getContentHeight(),
                    // 底部工具栏
                    bbar: {
                        // pagingBar:表明包含分页栏
                        pagingBar: true
                    },
                    plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
                });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select',
           // btnId: 'user_search'
        });
		
       var grid = search.get('grid');
        grid.render();
 
        console.log($("#endTime").val()+'BUI');
		//页面加载完成后获取当前默认时间总数
        $(search_sum());
    });
    
    
  //获取当前搜索时间总数
	$("#user_search").click(search_sum);
	
  //根据时间段获取总数的方法
    function search_sum(){
            var beginTime = $("#beginTime").val();
            var endTime = $("#endTime").val();
            var loginName = $("#loginName").val();
            search.load();
            $.ajax({
                url:'${ctx}/admin/sa/userConsumeDetail/getTotal',
                dataType : 'json',
                method : 'get',
                data : {beginTime:beginTime,endTime:endTime,loginName:loginName},
                success : function(data){
                    $("#orderTxCnts").html(data.totalOrderNumber == null ? 0 : data.totalOrderNumber),
                	 $("#orderTxAmts").html(data.totalQuantity == null ? 0 : data.totalQuantity),
                 	$("#productSalesCnts").html('￥'+(data.totalAmt == null ? 0 : data.totalAmt).toFixed(2))
                          
                }
            })
        };
    
 	

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
    		} else if(this.id=="lastMonth"){
    			bTime=getPreviousMonth()[0];
    			eTime=getPreviousMonth()[1];
    		}
			
			$("#beginTime").val(bTime);
    		$("#endTime").val(eTime);
    		console.log(eTime+'change');
    		search_sum();
    		//refeshData(bTime,eTime);
    	});
    });

	

</script>
</body>
</html>  