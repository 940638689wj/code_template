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
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>

                        <div class="pull-left">
                            <input type="text" id="loginName" name="loginName" class="control-text" placeholder="会员账号">
                            <select class="input-small bui-form-field-select bui-form-field" name="type"
                                    aria-disabled="false" aria-pressed="false">
                                <option value="" selected="selected">
                                    全部
                                </option>
                                <option value="0">
                                    消费
                                </option>
                                <option value="1">
                                    收入
                                </option>
                            </select>
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
        location.href = "${ctx}/admin/sa/userBalanceDetail/exportUserBalanceDetail?" + params;
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
//页面加载时获取本月时间
	$(function(){
		$("#thisMonth").addClass("step-active");
		var bTime=getCurrentMonth()[0];
		var eTime=getCurrentMonth()[1];
		$("#beginTime").attr("value",bTime);
		$("#endTime").attr("value",eTime);	
	});
</script>

<script type="text/javascript">
    var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '会员收支明细', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: '会员ID', dataIndex: 'userId', width: 40, visible: false, renderer: function (value, rowObj) {
                return "<input type='hidden' name='userId' value='" + value + "'>";
            }
            },
            {
                title: '用户', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '姓名', dataIndex: 'userName', width: 100, visible: true, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '收入金额', dataIndex: 'balanceIncome', width: 100, renderer: function (value, rowObj) {
                if(value==0){
                   return '--'
                }else {
                    return value.toFixed(2);
                }
            }
            },
            {
                title: '消费金额', dataIndex: 'balanceExpend', width: 100, renderer: function (value, rowObj) {
                if(value==0){
                    return '--'
                }else {
                    return value.toFixed(2);
                }
            }
            },
             {
                title: '渠道', dataIndex: 'codeCnName', width: 200, renderer: function (value, rowObj) {
               	if(value==null){
               		value='';
               	}
               	return value;
            }
            },
             {
                title: '操作时间', dataIndex: 'createTime', width: 200, renderer: function (value, rowObj) {
                //return value;
                var date = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
                return date;
            }
            },
            {
                title: '备注', dataIndex: 'remark', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            }
           
        ];

        var store = Search.createStore('${ctx}/admin/sa/userBalanceDetail/grid_json', {pageSize: 15});
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
            btnId: 'user_search'
        });

        grid = search.get('grid');
        grid.render();

    });

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
    		search.load();
    		//refeshData(bTime,eTime);
    	
        });
    });


</script>
</body>
</html>  