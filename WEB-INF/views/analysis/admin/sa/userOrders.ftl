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
                        <label class="control-label control-label-auto mr30">订单量：<span class="red" id="orderQuantity">0</span></label>
                        <label class="control-label control-label-auto mr30">订单额：<span class="red" id="orderTotalAmt">￥0.00</span></label>
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
        location.href = "${ctx}/admin/sa/userOrders/exportUserCptReport?" + params;
        BUI.Message.Alert("导出成功");
    }

</script>
<script type="text/javascript">
    var myChart = echarts.init(document.getElementById('volumeMain'));
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        selectedEvent: 'click',
        children: [
            {text: '会员消费指数', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '会员', dataIndex: 'loginName', width: 200},
            {title: '姓名', dataIndex: 'userName', width: 200},
            {title: '订单量', dataIndex: 'orderQuantity'},
            {title: '订单额', dataIndex: 'orderTotalAmt'},
            {title: '实付金额', dataIndex: 'orderPayAmt', width: 200},
            {
                title: '退款金额', dataIndex: 'orderReturnAmt', width: 200, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            }
        ];

        var store = Search.createStore('${ctx}/admin/sa/userOrders/grid_json', {pageSize: 10});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出全部报表', btnCls: 'button button-small', handler: generateAllReport},
                    {
                        xclass: 'bar-item-text',
                        text: '<div class="tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning">' +
                        '<i class="icon icon-white icon-volume-up"></i></span>' +
                        '<div class="tips-content">提示: 点击具体会员条目可显示对应会员折线图</div></div>'
                    }
                ]
            },
            plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
//            btnId: "user_search",
            formId: 'searchForm_select'
        });
        var grid = search.get('grid');
        grid.render();
        grid.on('selectedchange', function (ev) {
            if (ev.item) {
                var userId = ev.item.userId;
                var myChart = echarts.getInstanceByDom(document.getElementById('volumeMain'));
                getChartData(userId, myChart);
                getTotal(userId);
            }
        });
        grid.on('aftershow', function (ev) {
            try{
                grid.setSelected(grid.getFirstItem());
            }catch(ex){
                //
            }
        });
    });

    //获取当前搜索时间总数
    $("#user_search").click(function () {
        search.load();
        getTotal();
    });

    function getTotal(userId) {
        var beginTime = $("#beginTime").val();
        var endTime = $("#endTime").val();
        var originPlatformCd = $("#originPlatformCd").val();
        $.ajax({
            url: '${ctx}/admin/sa/userOrders/getTotal',
            dataType: 'json',
            method: 'get',
            data: {
                userId: userId,
                beginTime: beginTime,
                endTime: endTime,
                originPlatformCd: originPlatformCd
            },
            success: function (data) {
                $("#orderQuantity").html(data.orderQuantity);
                $("#orderTotalAmt").html('￥' + (data.orderTotalAmt).toFixed(2))
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
                data: ['订单量', '订单额(单位：元)'],
                selected: {
                    '订单成交量': true,
                    '订单成交额(单位：元)': false
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
                    name: '订单量',
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
                    name: '订单额(单位：元)',
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
                }
            ]
        };
        // 为echarts对象加载数据
        myChart.setOption(option);
        myChart.hideLoading();
        var userId = null;
        getChartData(userId, myChart);//ajax后台交互
        //setChartData();
    });

    /**
     * 图表数据初始化
     *
     * @param userId
     * @param myChart
     */
    function getChartData(userId, myChart) {
        //获得图表的options对象
        var options = myChart.getOption();
        if (!userId) {
            //图表数据初始化为0
            options.series[0].data = [0];
            options.series[1].data = [0];
            myChart.hideLoading();
            myChart.setOption(options);
        } else {
            var beginTime = $("#beginTime").val();
            var endTime = $("#endTime").val();
            var originPlatformCd = $("#originPlatformCd").val();
            //通过Ajax获取数据
            $.ajax({
                type: "post",
                async: false, //同步执行
                url: '${ctx}/admin/sa/userOrders/line_data',
                data: {
                    userId: userId,
                    beginTime: beginTime,
                    endTime: endTime,
                    originPlatformCd: originPlatformCd
                },
                dataType: "json", //返回数据形式为json
                success: function (data) {
                    if (data) {
                        options.xAxis[0].data = data.map1.dateList;  //时间
                        if (data.map1.orderQuantity.length > 0) {
                            options.series[0].data = data.map1.orderQuantity;//订单量
                        } else {
                            options.series[0].data = [0];//没有则为0
                        }
                        if (data.map1.orderTotalAmt.length > 0) {
                            options.series[1].data = data.map1.orderTotalAmt;//订单额
                        } else {
                            options.series[1].data = [0];//没有则为0
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
    }

    $("#user_search").click(function () {
        var bTime = $("#beginTime").val();
        var eTime = $("#endTime").val();
        if (bTime && eTime) {
            bTime = new Date(bTime);
            eTime = new Date(eTime);
        }
        var myChart = echarts.getInstanceByDom(document.getElementById('volumeMain'));
        var userId=null;
        getChartData(userId,myChart);
    });

</script>
</body>
</html>  