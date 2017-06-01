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
                        <div class="pull-left">
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

                        <input type="hidden" id="originPlatformCd" name="originPlatformCd">

                        <div class="pull-left offset1" id="plactformSelectContainer">
                            <button onclick="totalSearch()" type="button" class="button button-primary ml">全部</button>
                            <button onclick="totalSearch(1)" type="button" class="button ml">手机端</button>
                            <button onclick="totalSearch(0)" type="button" class="button ml">PC端</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30">订单成交量：<span class="red"
                                                                                         id="orderTxCnts">0</span></label>
                        <label class="control-label control-label-auto mr30">订单成交额：<span class="red" id="orderTxAmts">￥0.00</span></label>
                        <label class="control-label control-label-auto mr30">商品成交量：<span class="red"
                                                                                         id="productSalesCnts">0</span></label>
                        <label class="control-label control-label-auto mr30">商品退换量：<span class="red"
                                                                                         id="changeReturnCnt">0</span></label>
                        <label class="control-label control-label-auto mr30">商品退换率：<span class="red"
                                                                                         id="changeReturnRates">0.00%</span></label>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="volumeMain" style="height:300px;margin-top:20px;"></div>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    //页面加载时 取本月时间
    $(function () {
        $("#thisMonth").addClass("step-active");
        var bTime = getCurrentMonth()[0];
        var eTime = getCurrentMonth()[1];
        $("#beginTime").attr("value", bTime);
        $("#endTime").attr("value", eTime);
    });
</script>
<script type="text/javascript">
    //导出
    function generateAllReport() {
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/sa/dailyOrders/exportMallSaleReport?" + params;
        BUI.Message.Alert("导出成功");
    }
</script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '商城销售情况', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '时间', dataIndex: 'reportDate', width: 200, renderer: BUI.Grid.Format.dateRenderer},
            {
                title: '订单成交量', dataIndex: 'orderTxCnt', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '订单成交额', dataIndex: 'orderTxAmt', width: 200, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
            {
                title: '商品成交量', dataIndex: 'productSalesCnt', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '商品退换量', dataIndex: 'changeReturnCnt', width: 200, renderer: function (value, rowObj) {
                if (rowObj.changeReturnCnt != "" && rowObj.changeReturnCnt) {
                    return value;
                } else {
                    var str = '0';
                    return str;
                }
            }
            },
            {
                title: '商品退换率', dataIndex: 'changeReturnRate', width: 200, renderer: function (value, rowObj) {
                var str = (value * 100).toFixed(2);
                str += '%';
                return str;
            }
            }
        ];


        var store = Search.createStore('${ctx}/admin/sa/dailyOrders/grid_json', {pageSize: 10});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出全部报表', btnCls: 'button button-small', handler: generateAllReport}
                ]
            },
            plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight(),
            // 底部工具栏,pagingBar:表明包含分页栏
            //bbar:{
            //  pagingBar:true
            //}
        });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select'
            //btnId:'user_search'
        });
        var grid = search.get('grid');
        grid.render();

    });

    //获取当前搜索时间总数
    $("#user_search").click(function () {
        search.load();
        getTotal();
    });

    function getTotal() {
        var beginTime = $("#beginTime").val();
        var endTime = $("#endTime").val();
        var originPlatformCd = $("#originPlatformCd").val();
        $.ajax({
            url: '${ctx}/admin/sa/dailyOrders/getTotal',
            dataType: 'json',
            method: 'get',
            data: {beginTime: beginTime, endTime: endTime, originPlatformCd: originPlatformCd},
            success: function (data) {
                $("#orderTxCnts").html(data.orderTxCnt);
                $("#orderTxAmts").html('￥' + (data.orderTxAmt).toFixed(2));
                $("#productSalesCnts").html(data.productSalesCnt);
                $("#changeReturnCnt").html(data.changeReturnCnt);
                $("#changeReturnRates").html((data.changeReturnRate * 100).toFixed(2) + '%');
            }
        })
    }

    //点击全部，搜索日期范围内全部订单
    function totalSearch(val) {
        var originPlatformCd;
        if (val != null) {
            originPlatformCd = val;
        } else {
            originPlatformCd = '';
        }
        $("#originPlatformCd").attr("value", originPlatformCd);
        $("#user_search").trigger("click");
    }

    // 初始化(按钮样式变化)
    $(function () {
        var t = $(".steps-small").find("li");
        $(t).click(function () {
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
            } else {
                bTime = getPreviousMonth()[0];
                eTime = getPreviousMonth()[1];
            }

            $("#beginTime").attr("value", bTime);
            $("#endTime").attr("value", eTime);
            //refeshData(bTime,eTime);
        });
        getTotal();
    });

    //点击按钮 样式变化
    $("#plactformSelectContainer").find("button").click(function () {
        // 有颜色就删掉
        $("#plactformSelectContainer button").removeClass('button-primary');
        // 改变颜色
        $(this).addClass("button-primary");
    });
</script>
<script type="text/javascript">
    $(function () {
        // 基于准备好的dom，初始化echarts图表
        var myChart = echarts.init(document.getElementById('volumeMain'));

        var option = {
            tooltip: {
                trigger: 'axis',
                formatter: "{a}<br/> {b} <br/> {c}",
                axisPointer: {
                    type: 'none'
                }
            },
            legend: {
                data: ['订单成交量', '订单成交额(单位：元)', '商品退换量', '商品退换率'],
                selected: {
                    '订单成交量': true,
                    '订单成交额(单位：元)': false,
                    '商品退换量': false,
                    '商品退换率': false
                }
            },
            xAxis: [
                {
                    type: 'category',
                    data: [],
                    axisTick: {
                        interval: 0
                    }
                }
            ],
            yAxis: [
                {
                    type: 'value',
                    axisLabel: {
                        formatter: function (value) {
                            // Function formatter
                            return value
                        }
                    }
                },
                {
                    type: 'value',
                    position: 'right',
                    axisLabel: {
                        formatter: function (value) {
                            // Function formatter
                            return value + '%'
                        }
                    },
                    splitLine: {
                        show: false
                    }
                }
            ],

            series: [
                {
                    name: '订单成交量',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            //label : {show: true, position: 'top'},
                            color: '#1E90FF'
                        }
                    },
                    symbol: 'rect',
                    symbolSize: 13,
                    yAxisIndex: 0,
                    data: []
                },
                {
                    name: '订单成交额(单位：元)',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            //label : {show: true, position: 'top',formatter: '{c}'},
                            color: '#B3764D'
                        }
                    },
                    symbol: 'circle',
                    symbolSize: 13,
                    smooth: true,
                    yAxisIndex: 0,
                    data: []
                },
                {
                    name: '商品退换量',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            //label : {show: true, position: 'top'},
                            color: '#DD22DD'
                        }
                    },
                    symbol: 'triangle',
                    symbolSize: 13,
                    yAxisIndex: 0,
                    data: []
                },
                {
                    name: '商品退换率',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            //label : {show: true, position: 'top',formatter: '{c}%'},
                            color: '#61B34D'
                        }
                    },
                    symbol: 'diamond',
                    symbolSize: 13,
                    smooth: true,
                    yAxisIndex: 1,
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
        var beginTime = $("#beginTime").val();
        var endTime = $("#endTime").val();
        var originPlatformCd = $("#originPlatformCd").val();
        //通过Ajax获取数据
        $.ajax({
            type: "post",
            async: false, //同步执行
            url: '${ctx}/admin/sa/dailyOrders/line_data',
            data: {beginTime: beginTime, endTime: endTime, originPlatformCd: originPlatformCd},
            dataType: "json", //返回数据形式为json
            success: function (data) {
                if (data) {
                    options.xAxis[0].data = data.map1.dateList;  //时间
                    if (data.map1.orderTxCnt.length > 0) {
                        options.series[0].data = data.map1.orderTxCnt;//订单成交量
                    } else {
                        options.series[0].data = [0];//没有则为0
                    }
                    if (data.map1.orderTxAmt.length > 0) {
                        options.series[1].data = data.map1.orderTxAmt;//订单总额
                    } else {
                        options.series[1].data = [0];//没有则为0
                    }
                    if (data.map1.changeReturnCnt.length > 0) {
                        options.series[2].data = data.map1.changeReturnCnt;//商品退换量
                    } else {
                        options.series[2].data = [0];//没有则为0
                    }
                    if (data.map1.changeReturnRate.length > 0) {
                        options.series[3].data = data.map1.changeReturnRate;//商品退换率
                    } else {
                        options.series[3].data = [0];//没有则为0
                    }
                    myChart.hideLoading();
                    myChart.setOption(options);
                }
            },
            error: function (errorMsg) {
                alert("不好意思，图表请求数据失败啦!");
                myChart.hideLoading();
            }
        });
    }

    $("#user_search").click(function () {
        var bTime = $("#beginTime").val();
        var eTime = $("#endTime").val();
        if (bTime && eTime) {
            bTime = new Date(bTime);
            eTime = new Date(eTime);
        }
        var myChart = echarts.getInstanceByDom(document.getElementById('volumeMain'));
        getChartData(myChart);
    });

</script>
</body>
</html>  