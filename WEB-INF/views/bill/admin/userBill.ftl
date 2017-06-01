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
                            <input type="text" id="loginName" name="loginName" class="control-text" placeholder="会员账号">
                            <#--<select class="input-small bui-form-field-select bui-form-field" name="isChecked"-->
                                    <#--aria-disabled="false" aria-pressed="false">-->
                                <#--<option value="0" selected="selected">-->
                                    <#--未结账-->
                                <#--</option>-->
                                <#--<option value="1">-->
                                    <#--已结账-->
                                <#--</option>-->
                            <#--</select>-->
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
                        <#--<div class="pull-left">-->
                            <#--<button id="all" type="button" class="button button-primary"-->
                                    <#--onclick="setOriginPlatformCd(this,'');">全部-->
                            <#--</button>-->
                            <#--<button id="mobile" type="button" class="button" onclick="setOriginPlatformCd(this,1);">手机端-->
                            <#--</button>-->
                            <#--<button id="PC" type="button" class="button" onclick="setOriginPlatformCd(this,0);">PC端-->
                            <#--</button>-->
                        <#--</div>-->

                    </div>
                </div>
            </div>
            <div class="row mb10">
                <#--<div class="pull-left">-->
                    <#--<button id="agree" name="agree" onclick="auditAgreed();" type="button"-->
                            <#--class="button button-primary">结账-->
                    <#--</button>-->
                <#--<button id="user_search2" name="user_search" type="button" class="button button-primary">-->
                <#--查看已结算对账单-->
                <#--</button>-->
                    <button id="export" type="button" class="button button-primary">导出对账单</button>
                <#--</div>-->
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
        location.href = "${ctx}/admin/sa/userBill/exportUserBill?" + params;
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
    var grid;
    var search;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '会员账单', value: '0'}
        ]
    });
    var tab1 = new Tab.Tab({
        render: '#tab1',
        elCls: 'link-tabs',
        autoRender: true,
        children: [
            {text: '<button id="all" class="button button-primary" onclick="setOriginPlatformCd(this,\'\')">全部</button>', value: '2'},
            {text: '<button id="mobile" type="button" class="button" onclick="setOriginPlatformCd(this,1);">手机端</button>', value: '1'},
            {text: '<button id="PC" type="button" class="button" onclick="setOriginPlatformCd(this,0);">PC端</button>', value: '0'}
        ]
    });
    tab1.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="1"){
            $("#originPlatformCd").val("1");
        }else if(item.get('value')=="2"){
            $("#originPlatformCd").val("");
        }else if(item.get('value')=="0"){
            $("#originPlatformCd").val("0");
        }
        search.load({start:0});
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
                title: '会员账号', dataIndex: 'loginName', width: 100, renderer: function (value, rowObj) {
                var str = '<a href="${ctx}/admin/sa/user/toUserDetailIndex/' + rowObj.userId + '">' + value + '</a>';
                return str;
            }
            },
            {
                title: '订单ID', dataIndex: 'orderId', width: 40, visible: false, renderer: function (value, rowObj) {
                return "<input type='hidden' name='orderId' value='" + value + "'>";
            }
            },
            {
                title: '订单号', dataIndex: 'orderNumber', width: 100, renderer: function (value, rowObj) {
                var str = '<a href="${ctx}/admin/sa/order/toOrderDetail?orderId=' + rowObj.orderId + '">' + value + '</a>';
                return str;
            }
            },
            {
                title: '订单来源平台', dataIndex: 'originPlatformDesc', width: 100, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '订单商品', dataIndex: 'orderItems', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '订单金额', dataIndex: 'orderTotalAmt', width: 100, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
            {
                title: '快递费', dataIndex: 'orderExpressAmt', width: 100, renderer: function (value, rowObj) {
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
//            {
//                title: '账单状态', dataIndex: 'isUserChecked', width: 100, renderer: function (value, rowObj) {
//                var str;
//                if (value == "0") {
//                    str = "未结账";
//                } else if (value == "1") {
//                    str = "已结账";
//                }
//                return str;
//            }
//            }
        ];

        var store = Search.createStore('${ctx}/admin/sa/userBill/grid_json', {pageSize: 15});
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
        //grid.render();

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

    //批量结账
    function auditAgreed(orderId) {
        var orderIds = '';
        if (null != orderId && '' != orderId) {
            orderIds = orderId;
        } else {
            var selectedContent = grid.getSelection();
            if (selectedContent.length <= 0) {
                BUI.Message.Alert("请选择申请!");
                return false;
            }
//            if(selectedContent.length < 2){
//                BUI.Message.Alert("选择的申请条数不能低于2条!");
//                return false;
//            }
            var selectedContentIds = [];
            for (var i = 0; i < selectedContent.length; i++) {
                selectedContentIds.push(selectedContent[i].orderId);
            }
            orderIds = selectedContentIds.join(",");

        }
        BUI.Message.Confirm("是否确认结账？", function () {
            app.ajax('${ctx}/admin/sa/userBill/checkBill', {
                orderIds: orderIds, code: 'Y'
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("结账成功");
                    location.href = location.href;
                }
            });
        });
    }

    //设置订单来源系统参数切换
    function setOriginPlatformCd(ev, value) {
        $("#all").removeClass("button-primary");
        $("#mobile").removeClass("button-primary");
        $("#PC").removeClass("button-primary");
        $(ev).addClass("button-primary");
        $("#originPlatformCd").val(value);
    }
</script>
</body>
</html>  