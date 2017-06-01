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
        	 <input name="storeId" value="${storeId!}" type="hidden" id="storeId"/>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls control-row-auto ml0 ">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>

                        <div class="pull-left">
                        	<input type="text" id="orderNumber" name="orderNumber" class="control-text" placeholder="订单号">
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
            <div class="row">
                <div class="pull-left">
                	   <button id="print" type="button"class="button button-primary" onclick="toPrint()">打印订单</button>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
    var grid;
    var search;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
                render: '#tab',
                elCls: 'nav-tabs',
                autoRender: true,
                children: [
                    {text: '历史配送单', value: '0'},
                ]
            });
   
    tab.setSelected(tab.getItemAt('0'));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
             {title: '订单号', dataIndex: 'orderNumber', width: '180px', renderer: function (val, obj) {
				          return  "<a href='${ctx}/admin/store/order/"+obj.orderId+"' target='_blank'>"+val+"</a>";
            	         }},
            {title: '收货人', dataIndex: 'receiveName', renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }},
            {title: '手机号', dataIndex: 'receiveTel', width: "100px"},
            {
                title: '商品名称', dataIndex: 'productName', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '商品金额', dataIndex: 'productTotal', width: 100, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
        	{
                title: '下单时间', dataIndex: 'createTime', width: 200, renderer: function (value, rowObj) {
                //return value;
                var date = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
                return date;
            }
            },
            {
                title: '订单状态', dataIndex: 'orderStatusCd', width: 100, renderer: function (value, rowObj) {
                if (value == "4" || value == "5") {
                     return "已完成";
                }
                return "";
            }
            },
            {
                title: '配送方', dataIndex: 'orderDistrbuteTypeCd', width: 100, renderer: function (value, rowObj) {
              	var str;
                if (value == "1") {
                    str = '门店';
                } else if (value == "2") {
                    str = "总部";
                }
                return str;
            	}
            },
            {
                title: '备注', dataIndex: 'orderRemark', width: 100
            }

            
        ];

        var store = Search.createStore("${ctx}/admin/store/historicalDistribution/grid_json", {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns,
                {
                    width: '100%',
                    height: getContentHeight(),
                    // 底部工具栏
                    bbar: {
                        // pagingBar:表明包含分页栏
                        pagingBar: true
                    },
                    plugins: [BUI.Grid.Plugins.CheckSelection, BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
                });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select',
            //btnId: 'user_search'
        });

        grid = search.get('grid');
        grid.render();
        
         //更新页面数据
        $("#user_search").click(function () {
            var params = $("#searchForm_select").serialize();
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
        
        function toPrint(){
            var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择订单!");
                return false;
            }

            var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].orderId);
            }
            window.open("${ctx}/admin/store/order/print?id="+selectedContentIds.join(","));
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
                } else if (this.id == "lastMonth") {
                    bTime = getPreviousMonth()[0];
                    eTime = getPreviousMonth()[1];
                }

                $("#beginTime").attr("value", bTime);
                $("#endTime").attr("value", eTime);
                //refeshData(bTime,eTime);
            });
        });
    });

</script>
</body>
</html>  