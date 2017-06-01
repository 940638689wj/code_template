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
                        <label class="control-label control-label-auto mr30">
                            收款额：<span class="red" id="incomeAmt">￥0.00</span>
                        </label>
                        <label class="control-label control-label-auto mr30">
                            退款额：<span class="red" id="returnAmt">￥0.00</span>
                        </label>
                        <label class="control-label control-label-auto mr30">
                            收入：<span class="red" id="allIncome">￥0.00</span>
                        </label>
                        <label class="control-label control-label-auto mr30">
                            使用积分：<span class="red" id="consumeScore">0</span>
                        </label>
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
        location.href = "${ctx}/admin/sa/saleIncome/export?" + params;
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
            {text: '商城收支情况', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '时间', dataIndex: 'reportTime', width: 200, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '类型', dataIndex: 'typeName', width: 200},
            {
                title: '金额', dataIndex: 'amount', width: 200, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
            {
                title: '使用积分', dataIndex: 'consumeScore', width: 200, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
            {title: '订单号', dataIndex: 'orderNumber', width: 200},
            {title: '会员', dataIndex: 'loginName', width: 200},
            {title: '会员名称', dataIndex: 'userName', width: 200}
        ];


        var store = Search.createStore('${ctx}/admin/sa/saleIncome/grid_json', {pageSize: 5});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出全部报表', btnCls: 'button button-small', handler: generateAllReport}
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
            formId: 'searchForm_select'
//            btnId: 'user_search'
        });
        var grid = search.get('grid');
        grid.on('aftershow', function (ev) {
            getTotal();
        });
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
            url: '${ctx}/admin/sa/saleIncome/getTotal',
            dataType: 'json',
            method: 'get',
            data: {
                beginTime: beginTime,
                endTime: endTime,
                originPlatformCd: originPlatformCd
            },
            success: function (data) {
                $("#incomeAmt").html('￥' +data.incomeAmt.toFixed(2));
                $("#returnAmt").html('￥' +data.returnAmt.toFixed(2));
                $("#allIncome").html('￥' + (data.allIncome).toFixed(2));
                $("#consumeScore").html(data.consumeScore.toFixed(2));
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
                data: ['收款额', '退款额', '收入', '使用积分'],
                selected: {
                    '收款额': true,
                    '退款额': false,
                    '收入': false,
                    '使用积分': false
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
                }
            ],

            series: [
                {
                    name: '收款额',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            //label : {show: true, position: 'top'},
                            color: '#1E90FF'
                        }
                    },
                    symbol: 'rect',
                    symbolSize: 13,
                    smooth: true,
                    yAxisIndex: 0,
                    data: []
                },
                {
                    name: '退款额',
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
                    name: '收入',
                    type: 'line',
                    itemStyle: {
                        normal: {
                            //label : {show: true, position: 'top'},
                            color: '#DD22DD'
                        }
                    },
                    symbol: 'triangle',
                    symbolSize: 13,
                    smooth: true,
                    yAxisIndex: 0,
                    data: []
                },
                {
                    name: '使用积分',
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
                    yAxisIndex: 0,
                    data: []
                }
            ]
        };
        // 为echarts对象加载数据
        myChart.setOption(option);
        myChart.hideLoading();
        getChartData(myChart);//aja后台交互   
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
            url: '${ctx}/admin/sa/saleIncome/line_data',
            data: {beginTime: beginTime, endTime: endTime, originPlatformCd: originPlatformCd},
            dataType: "json", //返回数据形式为json
            success: function (data) {
                if (data) {
                    options.xAxis[0].data = data.map1.dateList;  //时间
                    if (data.map1.incomeAmt.length > 0) {
                        options.series[0].data = data.map1.incomeAmt;//收款额
                    } else {
                        options.series[0].data = [0];//没有则为0
                    }
                    if (data.map1.returnAmt.length > 0) {
                        options.series[1].data = data.map1.returnAmt;//退款额
                    } else {
                        options.series[1].data = [0];//没有则为0
                    }
                    if (data.map1.allIncome.length > 0) {
                        options.series[2].data = data.map1.allIncome;//收入
                    } else {
                        options.series[2].data = [0];//没有则为0
                    }
                    if (data.map1.consumeScore.length > 0) {
                        options.series[3].data = data.map1.consumeScore;//使用积分
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