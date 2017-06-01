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
        <#--操作栏-->
            <ul class="breadcrumb">
                <br>
                <b style="font-size: 14px">
                    订单号：{{orderHeaderDTO.orderNumber}}&nbsp;
                    <li class="active" v-if="orderHeaderDTO.type == 2">已付款</li>
                    <li class="active" v-else>{{orderHeaderDTO.orderStatusName}}</li>
                </b>
                <span>
                    <span>
                        <button type="button" class="button button-primary" onclick="cancelOrder()" v-if="orderHeaderDTO.type!=6">关闭</button>
                    </span>
                </span>
                &nbsp;&nbsp;
                <button type="button" class="button button-primary" @click="window.print">打印</button>
            </ul>
        <#--表格-->
            <table cellspacing="0" class="table table-info">
                <caption>订单信息</caption>
                <tbody>
                <tr>
                    <th>订单号：</th>
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
                    <th>支付类型：</th>
                    <td>{{orderHeaderDTO.orderPayModeName}}</td>
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

            <table cellspacing="0" class="table table-bordered table-striped">
                <caption>团购信息</caption>
                <thead>
                <tr>
                    <th>商品名称</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>小计</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>{{orderItem.productName}}</td>
                    <td>{{orderItem.salePrice}}</td>
                    <td>{{orderItem.quantity}}</td>
                    <td>{{orderItem.productTotal}}</td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-info">
                <caption>订单金额</caption>
                <tbody>
                <tr>
                    <th>活动优惠：</th>
                    <td>-￥{{orderHeaderDTO.activityDiscount ? orderHeaderDTO.activityDiscount : 0}}</td>
                    <th>商品总价：</th>
                    <td>￥{{orderHeaderDTO.orderProductAmt}}</td>
                </tr>
                <tr>
                    <th>已用优惠券：</th>
                    <td>{{orderHeaderDTO.promotionName}}</td>
                    <th>快递费用：</th>
                    <td>￥{{orderHeaderDTO.orderExpressAmt}}</td>
                </tr>
                <tr>
                    <th>优惠券折扣：</th>
                    <td>-￥{{orderHeaderDTO.promotionDiscount ? orderHeaderDTO.promotionDiscount : 0}}</td>
                    <th>应付金额：</th>
                    <td>￥{{orderHeaderDTO.orderTotalAmt}}</td>
                </tr>
                <tr>
                    <th>红包抵扣：</th>
                    <td>-￥{{orderHeaderDTO.redPacketDiscount ? orderHeaderDTO.redPacketDiscount : 0}}</td>
                    <th>订单折扣：</th>
                    <td>-￥{{orderHeaderDTO.orderDiscountAmt}}</td>
                </tr>
                <tr>
                    <th>积分抵扣：</th>
                    <td>-￥{{orderHeaderDTO.payScore ? orderHeaderDTO.payScore : 0}}</td>
                    <th>实付金额：</th>
                    <td><span v-if="orderHeaderDTO.type != 1 && orderHeaderDTO.type != 6">￥{{(orderHeaderDTO.orderPayAmt + orderHeaderDTO.payBalance).toFixed(2)}}</span>
                    </td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-bordered table-striped">
                <caption>团购券信息</caption>
                <thead>
                <tr>
                    <th>券号</th>
                    <th>二维码</th>
                    <th>使用状态</th>
                    <th>使用时间</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="promotionCouponCode in promotionCouponCodeList">
                    <td>{{promotionCouponCode.couponCode}}</td>
                    <td><img class="qrCodeSmallImg" :src="'/qrCode/generate?content=' + promotionCouponCode.couponCode"
                             style="width:30px;height: 30px;cursor: pointer;"/></td>
                    <td>{{promotionCouponCode.codeTypeName}}</td>
                    <td>{{promotionCouponCode.usedTime | time}}</td>
                </tr>
                </tbody>
            </table>

        </div>

    </div>
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


<script>
    var vm = new Vue({
        el: '#container',
        data: {
            orderId: ${orderId!},
            orderHeaderDTO: {}, // 订单和商品信息
            orderCancelInfo: {}, // 订单的关闭信息
            cancelOrderReasonList: [], // 订单关闭原因列表
            orderItem: {}, // 团购商品信息
            promotionCouponCodeList: [] // 团购券信息
        },
        computed: {},
        methods: {
            // 刷新订单详情信息
            refreshDetail: function () {
                this.$http.get('getGrouponOrderDetail', {
                    params: {
                        orderId: this.orderId
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.orderHeaderDTO = res.body.orderHeaderDTO;
                            this.orderCancelInfo = res.body.orderCancelInfo;
                            this.cancelOrderReasonList = res.body.cancelOrderReasonList;
                            this.orderItem = res.body.orderItem;
                            this.promotionCouponCodeList = res.body.promotionCouponCodeList;
                        }
                )
            }
        },
        created: function () {
            this.refreshDetail();
        },
        mounted: function () {
            var x = 5;
            var y = 5;
            $(".qrCodeSmallImg").live('mouseover', function (ev) {
                var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='" + $(this).attr("src") + "'><\/div>"; //创建 div 元素
                $("body").append(tooltip);	//把它追加到文档中
                $("#tooltip").css({
                    "top": (ev.pageY + y) + "px",
                    "left": (ev.pageX + x) + "px"
                }).show("fast");	  //设置x坐标和y坐标，并且显示
            }).live('mouseout', function () {
                $("#tooltip").remove();	 //移除
            }).live('mouseover', function (e) {
                $("#tooltip").css({
                    "top": (e.pageY + y) + "px",
                    "left": (e.pageX + x) + "px"
                });
            });
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

</script>
</body>
</html>  