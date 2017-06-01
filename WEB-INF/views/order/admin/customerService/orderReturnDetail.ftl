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
<#--<ul class="breadcrumb">-->
<#--<li class="active">订单详情</li>-->
<#--</ul>-->
    <div id="tab"></div>
</div>

<div class="container" id="container" v-cloak>
    <div class="container">
    <#--订单信息标签-->
        <div class="refund-body" v-show="type == -1">
            <div class="refund-side">
                <div class="refund-side-hd"><span>退款／退货申请</span></div>
                <div class="refund-side-prod">
                    <div class="prod-img"><a><img :src="orderItem.productPicUrl" alt=""/></a></div>
                    <div class="prod-name"><a>{{orderItem.productName}}</a></div>
                    <div class="prod-info"><span>{{orderItem.skuKeyJsonStr}}</span></div>
                </div>
                <div class="refund-side-info">
                    <ul>
                        <li><span>买家要求：</span><strong class="text-red">{{orderReturnInfo.applyTypeName}}</strong></li>
                        <li><span>退款金额：</span><strong class="text-red">{{orderReturnInfo.returnAmt}}</strong>元</li>
                    <#--<li><span>原　　因：</span>{{orderReturnInfo.applyReasonName}}</li>-->
                    </ul>
                </div>
                <div class="refund-side-orderinfo">
                    <p>退款单号：{{orderReturnInfo.returnOrderNumber}}</p>
                </div>
            </div>

            <div class="refund-main">

                <div class="flow-steps" v-if="orderReturnInfo.applyStatusCd == 1">
                    <ol class="num5">
                        <ol class="num5">
                            <li class="first current-prev"><i class="icon-ok"></i>买家申请退款</li>
                            <li class="current"><i class="num">2</i>卖家处理退款申请</li>
                            <li class="last"><i class="num">3</i>处理完成</li>
                        </ol>
                    </ol>
                </div>

                <div class="flow-steps" v-if="orderReturnInfo.applyStatusCd != 1">
                    <ol class="num5">
                        <li class="first done"><i class="icon-ok"></i>买家申请退货</li>
                        <li class="current-prev"><i class="icon-ok"></i>卖家处理退货申请</li>
                        <li class="last current"><i class="num">3</i>处理完成</li>
                    </ol>
                </div>

                <div class="refund-form">
                    <div class="refund-form-bd">
                        <h3>当前状态：{{orderReturnInfo.applyStatusName}}</h3>
                        <p class="refund-instruction">
                            如果已发货，同意后请等待买家退货。
                        </p>
                        <div v-if="orderReturnInfo.applyStatusCd == 1">
                            <button class="button button-primary" @click="auditReturn(2)">同意</button>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <button class="button" @click="auditReturn(3)">拒绝</button>
                        </div>
                    </div>
                    <div class="refund-side-info return">
                        <ul>
                            <li><span>原　　因：</span><strong>{{orderReturnInfo.applyReasonName}}</strong></li>
                            <li><span>退款说明：</span><strong>{{orderReturnInfo.reasonDetailDesc}}</strong></li>
                            <li><span>图　　片：</span>
                                <div class="picWrap">
                                    <div class="pic" v-for="orderReturnImgUrl in orderReturnImgUrlList">
                                        <a :href="orderReturnImgUrl.returnImgUrl" target="_blank">
                                            <img :src="orderReturnImgUrl.returnImgUrl">
                                        </a>
                                    </div>
                                </div>
                            </li>
                            <template v-if="orderReturnInfo.returnExpressNum">
                                <li><span>物流公司：</span><strong>{{orderReturnInfo.returnExpressName}}</strong></li>
                                <li><span>快递单号：</span><strong>{{orderReturnInfo.returnExpressNum}}</strong></li>
                                <li><span>客户备注：</span><strong>{{orderReturnInfo.returnExpressRemark}}</strong></li>
                            </template>
                        </ul>
                    </div>
                    <div class="refund-form-hd">
                        <div class="form-title">留言板</div>
                    </div>
                    <div class="leave-message">
                        <div class="lm-box">
                            <textarea v-model="operateDescription"></textarea>
                        </div>
                        <div class="lm-ft">
                        <#--<div class="lm-upload"><a class="uploadbtn" href="javascript:void(0)">上传凭证</a>-->
                        <#--<span>最多5张，单张不超过5M，支持GIF，JPG，JPEG，PNG，BMP格式</span>-->
                        <#--</div>-->
                            <div class="lm-commit">
                                <a href="javascript:void(0)" class="button button-primary"
                                   @click="submitMessageBoard"><span>发表留言</span></a>
                            </div>
                        </div>
                    </div>
                    <div class="message-list">
                        <ul>
                            <li v-for="orderReturnInfoLog in orderReturnInfoLogList">
                                <div class="time">({{orderReturnInfoLog.createTime | time}})</div>
                                <div class="name">
                                    操作人：{{orderReturnInfoLog.operatorName}}－{{orderReturnInfoLog.operatorTypeCd == 1 ?
                                    '管理员' : '会员'}}
                                </div>
                                <div class="con">操作：{{orderReturnInfoLog.operateTypeName}}</div>
                                <div class="con">备注留言：{{orderReturnInfoLog.operateDescription}}</div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div v-show="type == 0">
        <#--流程图-->
            <div class="steps">
                <ul v-if="orderHeaderDTO.type != 6">
                    <li class="step-first step-active">
                        <b class="stepline"></b>
                        <div class="stepind">1</div>
                        <div class="stepname">1.提交订单</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 1}">
                        <b class="stepline"></b>
                        <div class="stepind">2</div>
                        <div class="stepname">2.买家付款</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 2}">
                        <b class="stepline"></b>
                        <div class="stepind">3</div>
                        <div class="stepname">3.商家发货</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 3}">
                        <b class="stepline"></b>
                        <div class="stepind">4</div>
                        <div class="stepname">4.确认收货</div>
                    </li>
                    <li :class="{'step-active': orderHeaderDTO.type > 4, 'step-last': true}">
                        <b class="stepline"></b>
                        <div class="stepind">5</div>
                        <div class="stepname">5.{{orderHeaderDTO.orderTypeCd == 5 ? "完成" : "评价"}}</div>
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
                    订单号：{{orderHeaderDTO.orderNumber}}&nbsp;
                    <li class="active">{{orderHeaderDTO.orderStatusName}}</li>
                </b>

                &nbsp;&nbsp;
                <button type="button" class="button button-primary" @click="window.print">打印</button>
            </ul>
        <#--表格-->
            <table cellspacing="0" class="table table-info">
                <tbody>
                <tr>
                    <th>订单备注：</th>
                    <td>{{remarkForm.remark}}</td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-info">
                <caption>订单信息</caption>
                <tbody>
                <tr>
                    <th>订单号：</th>
                    <td>{{orderHeaderDTO.orderNumber}}</td>
                    <th>支付状态：</th>
                    <td>{{orderHeaderDTO.orderPayTime ? "已支付" : "未支付"}}</td>
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
                </tbody>
            </table>

            <table cellspacing="0" class="table table-info" v-if="!store">
                <caption>收货人信息</caption>
                <tbody>
                <tr>
                    <th>收件人：</th>
                    <td>{{orderReceiveInfo.receiveName}}</td>
                    <th>配送状态：</th>
                    <td v-if="orderHeaderDTO.orderStatusCd == 1"></td>
                    <td v-if="orderHeaderDTO.orderStatusCd == 20">待发货</td>
                    <td v-if="orderHeaderDTO.orderStatusCd == 3 || orderHeaderDTO.orderStatusCd == 5">
                        已发货
                    </td>
                </tr>
                <tr>
                    <th>联系手机：</th>
                    <td>{{orderReceiveInfo.receiveTel}}</td>
                    <th>快递单号：</th>
                    <td>{{orderReceiveInfo.orderExpressNum}}</td>
                </tr>
                <tr>
                    <th>收货地址：</th>
                    <td>{{orderReceiveInfo.receiveAddrCombo}}</td>
                    <th>配送方式：</th>
                    <td>{{orderHeaderDTO.expressName}}</td>
                </tr>
                <tr>
                    <th>发货时间：</th>
                    <td>{{orderReceiveInfo.sendTime}}</td>
                    <th>买家留言：</th>
                    <td>{{orderHeaderDTO.orderRemark}}</td>
                </tr>
                <tr>
                    <th>配送发票：</th>
                    <td>{{orderReceiveInfo.invoiceTypeName}}</td>
                    <th>发票抬头：</th>
                    <td>{{orderReceiveInfo.invoiceTitle}}</td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-info" v-if="store">
                <caption>门店信息</caption>
                <tbody>
                <tr>
                    <th>门店名称：</th>
                    <td>{{store.storeName}}</td>
                    <th>门店地址：</th>
                    <td>{{store.detailAddress}}</td>
                </tr>
                <tr>
                    <th>门店描述：</th>
                    <td>{{store.storeDescription}}</td>
                    <th>联系电话：</th>
                    <td>{{store.telephone}}</td>
                </tr>
                <tr>
                    <th>提货时间：</th>
                    <td>{{orderReceiveInfo.requiredStartTime | time}} 至 {{orderReceiveInfo.requiredEndTime | time}}</td>
                    <th>发货时间：</th>
                    <td>{{orderReceiveInfo.sendTime | time}}</td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-bordered table-striped"
                   v-if="orderHeaderDTO.orderTypeCd != 5 && orderHeaderDTO.orderItemList.length > 0">
                <caption>商品清单</caption>
                <thead>
                <tr>
                    <th>商品</th>
                    <th>单价</th>
                    <th>数量</th>
                    <th>优惠</th>
                    <th>小计</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="orderItem in orderHeaderDTO.orderItemList">
                    <td>{{orderItem.productName}}</td>
                    <td>{{orderItem.salePrice}}</td>
                    <td>{{orderItem.quantity}}</td>
                    <td>￥{{orderItem.productDiscountAmt}}</td>
                    <td>￥{{orderItem.productTotal}}</td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-bordered table-striped"
                   v-if="orderHeaderDTO.orderTypeCd == 5">
                <caption>套餐信息</caption>
                <thead>
                <tr>
                    <th>提货券名称</th>
                    <th>套餐名称</th>
                    <th>价格</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>{{orderHeaderDTO.pickupCouponName}}</td>
                    <td>{{orderHeaderDTO.packageName}}</td>
                    <td>{{orderHeaderDTO.pickupAmt}}</td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-info" v-if="orderHeaderDTO.orderTypeCd == 5">
                <caption>订单金额</caption>
                <tbody>
                <tr>
                    <th>商品总价：</th>
                    <td>￥{{orderHeaderDTO.orderProductAmt}}</td>
                    <th>快递费用：</th>
                    <td>￥{{orderHeaderDTO.orderExpressAmt}}</td>
                </tr>
                <tr>
                    <th>应付金额：</th>
                    <td>￥{{orderHeaderDTO.orderTotalAmt}}</td>
                    <th></th>
                    <td></td>
                </tr>
                </tbody>
            </table>

            <table cellspacing="0" class="table table-info" v-if="orderHeaderDTO.orderTypeCd != 5">
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
                    <th>积分抵扣：</th>
                    <td>￥{{orderHeaderDTO.payScore ? orderHeaderDTO.payScore : 0}}</td>
                    <th>订单折扣：</th>
                    <td>-￥{{orderHeaderDTO.orderDiscountAmt}}</td>
                </tr>
                <tr>
                    <th>获得积分：</th>
                    <td>{{orderHeaderDTO.productReturnScore}}</td>
                    <th>实付金额：</th>
                    <td>￥<span v-if="orderHeaderDTO.type != 1 && orderHeaderDTO.type != 6">{{(orderHeaderDTO.orderPayAmt + orderHeaderDTO.payBalance).toFixed(2)}}</span>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>

    <#--付款信息标签-->
        <div v-show="type == 1">
            <table cellspacing="0" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>付款方式</th>
                    <th>支付方式</th>
                    <th>付款金额</th>
                    <th>支付状态</th>
                    <th>付款时间</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>{{orderHeaderDTO.orderNumber}}</td>
                    <td>{{orderHeaderDTO.orderPayModeName}}</td>
                    <td>{{orderHeaderDTO.orderPayWayName}}</td>
                    <td>{{orderHeaderDTO.orderPayAmt + orderHeaderDTO.payBalance}}</td>
                    <td>{{orderHeaderDTO.orderPayTime ? "已支付" : "未支付"}}</td>
                    <td>{{orderHeaderDTO.orderPayTime | time}}</td>
                </tr>
                </tbody>
            </table>
        </div>


    <#--发货信息标签-->
        <div v-show="type == 2">
            <table cellspacing="0" class="table table-bordered table-striped">
                <thead>
                <tr>
                    <th>订单号</th>
                    <th>配送方式</th>
                    <th>发货状态</th>
                    <th>快递单号</th>
                    <th>发货时间</th>
                    <th>收件人</th>
                    <th>联系手机</th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <td>{{orderHeaderDTO.orderNumber}}</td>
                    <td>{{orderReceiveInfo.orderDistrbuteTypeCd == 1 ? orderHeaderDTO.expressName : "门店自提"}}</td>
                    <td>{{orderReceiveInfo.sendTime ? "已发货" : "未发货"}}</td>
                    <td>{{orderReceiveInfo.orderExpressNum}}</td>
                    <td>{{orderReceiveInfo.sendTime | time}}</td>
                    <td>{{orderReceiveInfo.receiveName}}</td>
                    <td>{{orderReceiveInfo.receiveTel}}</td>
                </tr>
                </tbody>
            </table>
        </div>

    <#--订单日志标签-->
        <div v-show="type == 3">
            <table cellspacing="0" class="table table-bordered table-striped" v-if="orderOperationInfoList.length > 0">
                <thead>
                <tr>
                    <th>操作人</th>
                    <th>标题</th>
                    <th>操作描述</th>
                    <th>操作时间</th>
                </tr>
                </thead>
                <tbody>
                <tr v-for="orderOperationInfo in orderOperationInfoList">
                    <td>{{orderOperationInfo.operName}}</td>
                    <td>{{orderOperationInfo.operTypeDesc}}</td>
                    <td>{{orderOperationInfo.operDesc}}</td>
                    <td>{{orderOperationInfo.operTime | time}}</td>
                </tr>
                </tbody>
            </table>
            <div class="text" style=" text-align:center;" v-if="orderOperationInfoList.length == 0">
                <h2>暂无操作日志</h2>
            </div>
        </div>

    <#--订单备注标签-->
        <div v-show="type == 4">
            <form class="form-horizontal">
                <div class="control-group">
                    <label class="control-label">标记：</label>
                    <div class="controls" data-rules="{required:true}">
                        <label><input type="radio" value="0" v-model="remarkForm.remarkTypeCd"/>普通</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <label><input type="radio" value="1" v-model="remarkForm.remarkTypeCd"/>紧急</label>
                    </div>
                </div>

                <div class="control-group">
                    <label class="control-label">订单备注：</label>
                    <div class="controls">
                        <textarea class="input-large" type="text" v-model="remarkForm.remark"></textarea>
                    </div>
                </div>

                <div class="row form-actions actions-bar">
                    <div class="span13 offset3">
                        <button type="button" class="button button-primary" @click="saveOrderRemark">保存</button>
                        <button type="button" class="button" @click="resetOrderRemark">重置</button>
                    </div>
                </div>
            </form>
        </div>

    </div>
</div>

<script>
    var vm = new Vue({
        el: '#container',
        data: {
            returnOrderNumber: ${returnOrderNumber!0},
            type: 0, // 标签页类型
            orderReturnInfo: {}, // 退款信息
            orderReturnImgUrlList: [], // 退款图片
            orderItem: {}, // 退款商品item信息
            orderReturnInfoLogList: [], // 退款操作日志
            orderHeaderDTO: {}, // 订单和商品信息
            orderReceiveInfo: {}, // 收货人信息
            store: {}, // 门店信息
            orderOperationInfoList: [], // 订单操作日志
            remarkForm: { // 订单备注表单
                remarkTypeCd: '0',
                remark: ''
            },
            operateDescription: '' // 留言内容
        },
        computed: {},
        methods: {
            // 刷新订单详情信息
            refreshDetail: function () {

                // 加载退款订单信息
                this.$http.get('/admin/sa/customerService/getOrderReturnDetail', {
                    params: {
                        returnOrderNumber: this.returnOrderNumber
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.orderReturnInfo = res.body.orderReturnInfo;
                            this.orderReturnImgUrlList = res.body.orderReturnImgUrlList;
                            this.orderItem = res.body.orderItem;
                            this.orderReturnInfoLogList = res.body.orderReturnInfoLogList;

                            this.orderHeaderDTO = res.body.orderHeaderDTO;
                            this.orderReceiveInfo = res.body.orderReceiveInfo;
                            this.store = res.body.store;
                            this.orderOperationInfoList = res.body.orderOperationInfoList;
                            if (res.body.orderRemark.remark) {
                                this.remarkForm.remark = res.body.orderRemark.remark;
                            }
                            if (res.body.orderRemark.remarkTypeCd != null) {
                                this.remarkForm.remarkTypeCd = res.body.orderRemark.remarkTypeCd;
                            }
                        }
                )
            },
            // 保存订单备注
            saveOrderRemark: function () {
                this.$http.post('/admin/sa/orderManage/saveOrderRemark', {
                    orderId: this.orderHeaderDTO.orderId,
                    remarkTypeCd: this.remarkForm.remarkTypeCd,
                    remark: this.remarkForm.remark
                }, {emulateJSON: true}).then(
                        function (res) {
                            if (app.ajaxHelper.handleAjaxMsg(res)) {
                                app.showSuccess('修改订单备注成功！');
                            }
                        }
                )
            },
            // 重置订单备注
            resetOrderRemark: function () {
                this.refreshDetail();
            },
            // 发表留言
            submitMessageBoard: function () {
                this.$http.post('/admin/sa/customerService/submitMessageBoard', {
                    orderReturnInfoId: this.orderReturnInfo.id,
                    operateDescription: this.operateDescription
                }, {
                    emulateJSON: true
                }).then(function (res) {
                    if (res.body) {
                        app.showSuccess('发布成功');
                        this.refreshDetail();
                    }
                })
            },
            // 审核操作
            auditReturn: function (applyStatusCd) {
                var obj = this;
                var str = '';
                if (applyStatusCd == 2) {
                    str = '同意'
                } else if (applyStatusCd == 3) {
                    str = '拒绝';
                }
                BUI.Message.Confirm('确认' + str + '该退款申请？', function () {
                    obj.$http.post('/admin/sa/customerService/auditReturn', {
                        id: obj.orderReturnInfo.id,
                        applyStatusCd: applyStatusCd
                    }, {
                        emulateJSON: true
                    }).then(
                            function (res) {
                                if (res.body.result) {
                                    app.showSuccess(res.body.message);
                                    obj.refreshDetail();
                                } else {
                                    app.showError(res.body.message);
                                    obj.refreshDetail();
                                }
                            }
                    )
                })
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
            {text: '退款退货处理', value: '-1'},
            {text: '订单信息', value: '0'},
            {text: '付款信息', value: '1'},
            {text: '发货信息', value: '2'},
            {text: '订单日志', value: '3'},
            {text: '订单备注', value: '4'}
        ]
    });

    // 切换标签页
    tab.on('selectedchange', function (ev) {
        vm.type = ev.item.get("value");
    });
    tab.setSelected(tab.getItemAt(0));

</script>
</body>
</html>  