<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${staticPath}/js/vue.min.js"></script>
    <script src="${staticPath}/js/vue-resource.min.js"></script>
    <style>
        [v-cloak] {
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div id="tab"></div>
</div>

<div class="container" id="container" v-cloak>
    <div class="container">
    <#--订单信息标签-->
        <div>
        <#--流程图-->
            <div class="steps">
                <ul v-if="orderHeaderDTO.type != 6">
                    <li class="step-first step-active">
                        <b class="stepline"></b>
                        <div class="stepind">1</div>
                        <div class="stepname">1.提交预售订单</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 1}">
                        <b class="stepline"></b>
                        <div class="stepind">2</div>
                        <div class="stepname">2.买家付定金</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 2}">
                        <b class="stepline"></b>
                        <div class="stepind">3</div>
                        <div class="stepname">3.买家付尾款</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 3}">
                        <b class="stepline"></b>
                        <div class="stepind">4</div>
                        <div class="stepname">4.商家发货</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 4, 'step-last': true}">
                        <b class="stepline"></b>
                        <div class="stepind">5</div>
                        <div class="stepname">5.确认收货</div>
                    </li>
                </ul>
                <ul v-else>
                    <li class="step-first">
                        <b class="stepline"></b>
                        <div class="stepind">1</div>
                        <div class="stepname">1.提交订单</div>
                    </li>
                    <li class="step-last">
                        <b class="stepline"></b>
                        <div class="stepind">2</div>
                        <div class="stepname">2.关闭</div>
                    </li>
                </ul>
            </div>
        <#--操作栏-->
            <ul class="breadcrumb">
                <br>
                <b style="font-size: 14px">
                    预售单号：{{orderHeaderDTO.orderNumber}}&nbsp;
                    <li class="active">{{orderHeaderDTO.orderStatusName}}</li>
                </b>
                <span>
                    <span v-if="orderHeaderDTO.type == 1">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="payOrder()">支付定金</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="cancelOrder()">关闭</button>
                    </span>
                    <span v-if="orderHeaderDTO.type == 2">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="cancelOrder()">关闭</button>
                    </span>
                    <span v-if="orderHeaderDTO.type == 3">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="sendOrder()">发货</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="cancelOrder()">关闭</button>
                    </span>
                    <span v-if="orderHeaderDTO.type == 4">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="confirmReceive()">确认收货</button>
                    </span>
                </span>
                &nbsp;&nbsp;
                <button type="button" class="button button-primary" @click="window.print">打印</button>
            </ul>
        <#--表格-->
            <table cellspacing="0" class="table table-info">
                <caption>预售信息</caption>
                <tbody>
                <tr>
                    <th>预售单号：</th>
                    <td>{{orderHeaderDTO.orderNumber}}</td>
                    <th>付款状态：</th>
                    <td>{{orderHeaderDTO.orderStatusName}}</td>
                </tr>
                <tr>
                    <th>下单时间：</th>
                    <td>{{orderHeaderDTO.createTime | time}}</td>
                    <th>付款时间：</th>
                    <td>{{orderHeaderDTO.orderPayTime | time}}</td>
                </tr>
                <tr>
                    <th>预售定金：</th>
                    <td>{{orderHeaderDTO.earnest}}</td>
                    <th>商品件数：</th>
                    <td>{{orderHeaderDTO.productNum}}</td>
                </tr>
                <tr>
                    <th>订单来源：</th>
                    <td>{{orderHeaderDTO.originPlatformName}}</td>
                    <th>支付方式：</th>
                    <td>{{orderHeaderDTO.orderPayWayName}}</td>
                </tr>
                <template v-if="orderCancelInfo">
                    <tr>
                        <th>关闭理由：</th>
                        <td>{{orderCancelInfo.cancelReason}}</td>
                        <th>备注：</th>
                        <td>{{orderCancelInfo.operaterDesc}}</td>
                    </tr>
                </template>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-bordered table-striped"
                   v-if="orderHeaderDTO.orderItemList.length > 0">
                <caption>商品清单</caption>
                <thead>
                <tr>
                    <th>商品</th>
                    <th>单价</th>
                    <th>数量</th>
                    <#--<th>优惠</th>-->
                    <th>小计</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="orderItem in orderHeaderDTO.orderItemList">
                    <td>{{orderItem.productName}}</td>
                    <td>{{orderItem.salePrice}}</td>
                    <td>{{orderItem.quantity}}</td>
                    <#--<td>￥{{orderItem.productDiscountAmt}}</td>-->
                    <td>￥{{orderItem.productTotal}}</td>
                </tr>
                </tbody>
            </table>
        </div>

    </div>
</div>

<#--支付 弹窗-->
<div id="payContent" class="hide">
    <form class="form-horizontal">
        <div class="control-group">
            <label class="control-label"></label>
            <div class="controls">
                注意：此操作会改变订单的状态
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">付款方式：</label>
            <div class="controls">
                <select id="orderPayWayCd" name="orderPayWayCd"></select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">备注：</label>
            <div class="controls">
                <textarea class="input-large" type="text" id="payOperDesc" name="payOperDesc"></textarea>
            </div>
        </div>
    </form>
</div>

<#--关闭订单 弹窗-->
<div id="cancelContent" class="hide">
    <form class="form-horizontal">
        <div class="control-group">
            <label class="control-label"></label>
            <div class="controls">
                关闭交易？请您确认已通知买家，并已达成一致。您单方面关闭交易，将可能导致买家投诉
            </div>
        </div>
        <br>

        <div class="control-group">
            <label class="control-label">关闭订单的理由：</label>
            <div class="controls">
                <select id="cancelOrderReason" name="cancelOrderReason"></select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">备注：</label>
            <div class="controls">
                <textarea class="input-large" type="text" id="cancelOperDesc" name="cancelOperDesc"></textarea>
            </div>
        </div>
    </form>
</div>

<#--发货 弹窗-->
<div id="sendContent" class="hide">
    <form class="form-horizontal">
        <div class="control-group">
            <label class="control-label">订单号：</label>
            <div class="controls" id="sendOrderNumber"></div>
        </div>

        <div class="control-group">
            <label class="control-label">订单总价：</label>
            <div class="controls" id="sendOrderPayAmt"></div>
        </div>

        <div class="control-group">
            <label class="control-label">收货人：</label>
            <div class="controls" id="sendReceiveName"></div>
        </div>

        <div class="control-group">
            <label class="control-label">配送方式：</label>
            <div class="controls">
                <select id="expressId" name="expressId"></select>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">快递单号：</label>
            <div class="controls">
                <input class="input-normal control-text" name="orderExpressNum" id="orderExpressNum">
            </div>
        </div>
    </form>
</div>

<script>
    var vm = new Vue({
        el: '#container',
        data: {
            orderId: ${orderId!},
            orderHeaderDTO: {}, // 订单和商品信息
            orderReceiveInfo: {}, // 收货人信息
            cancelOrderReasonList: [], // 订单关闭原因列表
            orderPayWayCdList: [], // 支付方式列表
            expressList: [], // 配送方式列表
            orderCancelInfo: {} // 订单的关闭信息
        },
        computed: {
        },
        methods: {
            // 刷新订单详情信息
            refreshDetail: function () {
                this.$http.get('getPreSaleOrderDetail', {
                    params: {
                        orderId: this.orderId
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.orderHeaderDTO = res.body.orderHeaderDTO;
                            this.orderReceiveInfo = res.body.orderReceiveInfo;
                            this.cancelOrderReasonList = res.body.cancelOrderReasonList;
                            this.orderPayWayCdList = res.body.orderPayWayCdList;
                            this.expressList = res.body.expressList;
                            this.orderCancelInfo = res.body.orderCancelInfo;
                        }
                )
            }
        },
        created: function () {
            this.refreshDetail();
        }
    });

    Vue.filter('time', function (value) {
        function add0(m) {
            return m < 10 ? '0' + m : m
        }

        if (!value) {
            return "";
        }
        var time = new Date(parseInt(value));
        var y = time.getFullYear();
        var m = time.getMonth() + 1;
        var d = time.getDate();
        var h = time.getHours();
        var mi = time.getMinutes();
        var s = time.getSeconds();
        return y + '-' + add0(m) + '-' + add0(d) + ' ' + add0(h) + ':' + add0(mi) + ':' + add0(s);
    });


    // =====以下为bui+jquery====
    // 标签页
    var tab = new BUI.Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '订单信息', value: '0'}
        ]
    });

    tab.setSelected(tab.getItemAt(0));


    // ------支付 弹窗操作-------
    var payType = 0;
    // 支付 弹窗
    var payDialog = new BUI.Overlay.Dialog({
        title: '支付',
        width: 500,
        height: 320,
        contentId: 'payContent',
        success: function () {
            $.post("payPreSaleOrder", {
                orderId: vm.orderId,
                orderPayWayCd: $("#orderPayWayCd").val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    window.location.replace("${ctx}/admin/sa/orderManage/toPreSaleOrderDetail?orderId=" + data);
                }
            }, "json");
        }
    });

    // 渲染 支付渠道 下拉
    setTimeout(setPayWay, 1000);
    function setPayWay() {
        for (var index in vm.orderPayWayCdList) {
            var orderPayWayCd = vm.orderPayWayCdList[index].orderProblemDesc;
            $("#orderPayWayCd").append('<option value="' + vm.orderPayWayCdList[index].codeId + '">' + vm.orderPayWayCdList[index].codeCnName + '</option>')
        }
    }

    // 打开 支付 弹窗
    function payOrder(type) {
        payType = type;
        payDialog.show();
    }


    // ------关闭订单 弹窗操作-------
    // 关闭订单 弹窗
    var cancelDialog = new BUI.Overlay.Dialog({
        title: '关闭订单',
        width: 500,
        height: 320,
        contentId: 'cancelContent',
        success: function () {
            $.post("cancelOrder", {
                orderId: vm.orderId,
                cancelReason: $("#cancelOrderReason").val(),
                cancelOperDesc: $("#cancelOperDesc").val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("关闭成功");
                    vm.refreshDetail();
                    cancelDialog.close();
                }
            }, "json")
        }
    });

    // 渲染 关闭订单理由 下拉
    setTimeout(setCancelOrderReason, 1000);
    function setCancelOrderReason() {
        for (var index in vm.cancelOrderReasonList) {
            var cancelOrderReason = vm.cancelOrderReasonList[index].codeCnName;
            $("#cancelOrderReason").append('<option value="' + cancelOrderReason + '">' + cancelOrderReason + '</option>')
        }
    }

    // 打开 关闭订单 弹窗
    function cancelOrder() {
        cancelDialog.show();
    }


    // ------发货 弹窗操作-------
    // 发货 弹窗
    var sendDialog = new BUI.Overlay.Dialog({
        title: '发货',
        width: 500,
        height: 400,
        contentId: 'sendContent',
        success: function () {
            $.post("sendOrder", {
                orderId: vm.orderId,
                expressId: $("#expressId").val(),
                orderExpressNum: $("#orderExpressNum").val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("发货成功");
                    vm.refreshDetail();
                    sendDialog.close();
                }
            }, "json")
        }
    });

    // 渲染 配送方式 下拉
    setTimeout(setExpressId, 1000);
    function setExpressId() {
        $("#sendOrderNumber").html(vm.orderHeaderDTO.orderNumber);
        $("#sendOrderPayAmt").html(vm.orderHeaderDTO.orderPayAmt);
        $("#sendReceiveName").html(vm.orderReceiveInfo.receiveName);
        for (var index in vm.expressList) {
            var str = '<option value="' + vm.expressList[index].expressId + '" ';
            if (vm.expressList[index].expressId == vm.orderReceiveInfo.expressId) {
                str += 'selected="selected"';
            }
            str += '>' + vm.expressList[index].expressName + '</option>';
            $("#expressId").append(str);
        }
        $("#orderExpressNum").val(vm.orderReceiveInfo.orderExpressNum);
    }

    // 打开 发货 弹窗
    function sendOrder() {
        sendDialog.show();
    }

    // 确认收货
    function confirmReceive() {
        var str = "操作后订单状态会变成待评价,只能查看订单不能进行任何操作";
        BUI.Message.Confirm(str, function () {
            $.post("confirmReceive", {orderId: vm.orderId}, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("收货成功！");
                    vm.refreshDetail();
                }
            })
        });
    }
</script>
</body>
</html>  