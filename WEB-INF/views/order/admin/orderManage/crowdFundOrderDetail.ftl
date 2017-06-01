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

    <script>
        var Overlay = top.BUI.Overlay,
                Grid = BUI.Grid,
                Data = BUI.Data;
        var Store = Data.Store,
                columns = [
                    {title: '编号', dataIndex: 'promotionCrowdFundCodeId', width: 85},
                    {title: '众筹码', dataIndex: 'fundCodeNum', width: 125},
                    {
                        title: '订单支付时间',
                        dataIndex: 'orderPayTime',
                        width: 135,
                        renderer: BUI.Grid.Format.datetimeRenderer
                    }
                ];
        var store = new Store({
                    url: '${ctx}/admin/sa/orderManage/findDialogPage',
                    autoLoad: false, //自动加载数据
                    pageSize: 5
                }),
                grid = new Grid.Grid({
                    columns: columns,
                    store: store,
                    loadMask: true, //加载数据时显示屏蔽层
                    emptyDataTpl: '<div class="centered"><h2>数据为空!</h2></div>',
                    // 底部工具栏
                    bbar: {
                        // pagingBar:表明包含分页栏
                        pagingBar: true
                    }
                });

        var dialog = new Overlay.Dialog({
            title: '众筹明细',
            width: 500,
            height: 300,
            children: [grid],
            childContainer: '.bui-stdmod-body',
            success: function () {
                this.close();
            }
        });

        function viewOfferCode(promotionId, userId) {
            var params = { //配置初始请求的参数
                start: 0,
                sort: 'id desc',
                "promotionId": promotionId,
                "userId": userId
            };
            store.load(params);
            dialog.show();
        }
    </script>
</head>
<body>
<div class="container">
    <div id="tab"></div>
</div>

<div class="container" id="container" v-cloak>

    <div v-show="type == 0">
        <div class="content-body">
            <div class="goods-cell goods-cell-crowdfunding">
                <div class="goodspic"><a href="#"><img :src="promotionCrowdFundDTO.productPicUrl"></a></div>
                <div class="goodsname"><a href="#">{{promotionCrowdFundDTO.productName}}</a>(访问地址：/product/{{promotionCrowdFundDTO.productId}}.html)
                </div>
                <div class="goodsattr">{{promotionCrowdFundDTO.skuKeyJsonStr}}</div>
            </div>
            <p class="result-crowdfunding" v-if="promotionCrowdFundDTO.crowdFundStatusCd == 0">
                众筹尚未完成，总需参与次数{{totalNeedTimes}}
                <span class="ml">已购人次{{promotionCrowdFundDTO.hasJoinTimes}}</span>
                <span class="ml">尚需次数{{remainTimes}}</span>
            </p>
            <p class="result-crowdfunding" v-else>
                众筹结果已揭晓，中奖会员：{{promotionCrowdFundDTO.phone}}
                <span class="ml">中奖众筹码：{{promotionCrowdFundDTO.winCode}}</span>
                <span class="ml">会员{{promotionCrowdFundDTO.isTaked ? '已' : '尚未'}}发起领奖</span>
            </p>

            <div class="order-info-tite"><h3>所有参与记录</h3></div>
            <div id="records" v-if="promotionCrowdFundCodeList.length > 0">
                <div class="cfund-recordlist-wrap">
                    <div class="cfund-recordlist-start">
                        <div class="ico ico-clock"></div>
                    </div>

                    <div v-for="(promotionCrowdFundCode,index) in promotionCrowdFundCodeList">
                        <div class="cfund-recordlist-time" v-if="index == 0
                        || promotionCrowdFundCode.createTime.substring(0,10) != promotionCrowdFundCodeList[index-1].createTime.substring(0,10)">
                            <span>{{promotionCrowdFundCode.createTime.substring(0,10)}}</span>
                            <i class="ico ico-recorddot ico-recorddot-solid"></i>
                        </div>
                        <ul class="cfund-recordlist">
                            <li>
                                <span class="time">{{promotionCrowdFundCode.createTime.substring(10)}}</span>
                                <i class="ico ico-recorddot ico-recorddot-hollow"></i>
                                <div class="info">
                                    <p>
                                        <span class="userpic"></span>
                                        <a href="javascript:void(0);" @click="viewOfferCode(promotionId,promotionCrowdFundCode.userId)">
                                            {{promotionCrowdFundCode.phone}}</a>
                                        参与了
                                        <em class="text-red">{{promotionCrowdFundCode.singleAlreadyBuy}}人次</em>
                                    </p>
                                </div>
                            </li>
                        </ul>
                    </div>

                    <div class="cfund-recordlist-end">
                        <div class="ico ico-clock"></div>
                    </div>
                </div>
            </div>
        </div>

        <pager :page-no="pageNo" :page-size="pageSize" :page-count="promotionCrowdFundCodeCount"
               @changepageno="changePageNo" v-if="promotionCrowdFundCodeList.length > 0"></pager>

    </div>

    <div v-if="type == 1">
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
                    <div class="stepname">5.评价</div>
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
            <span v-show="!editReceive">
                    <span v-if="orderHeaderDTO.type == 1">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            @click="editReceive = true" v-if="!store">编辑</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="payOrder()">支付</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="changePriceOrder()"
                                            v-if="orderHeaderDTO.orderTypeCd != 5">调价</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="cancelOrder()">关闭</button>
                    </span>
                    <span v-if="orderHeaderDTO.type == 2">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            @click="editReceive = true">编辑</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="sendOrder()">发货</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="cancelOrder()">关闭</button>
                    </span>
                    <span v-if="orderHeaderDTO.type == 3">
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            @click="editReceive = true">编辑</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="confirmReceive()">确认收货</button>
                        &nbsp;&nbsp;<button type="button" class="button button-primary"
                                            onclick="extendOrder()">延长收货时间</button>
                    </span>
                </span>
            <span v-show="editReceive">
                    &nbsp;&nbsp;<button type="button" class="button button-primary" @click="saveEditReceive">保存</button>
                    &nbsp;&nbsp;<button type="button" class="button" @click="cancelEditReceive">取消</button>
                </span>
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
            </tbody>
        </table>

        <table cellspacing="0" class="table table-info" v-if="!store">
            <caption>收货人信息</caption>
            <tbody>
            <tr>
                <th>收件人：</th>
                <td v-show="!editReceive">{{orderReceiveInfo.receiveName}}</td>
                <td v-show="editReceive"><input v-model="orderReceiveInfo.receiveName" class="control-text"
                                                style="width: 90%"></td>
                <th>配送状态：</th>
                <td v-if="orderHeaderDTO.orderStatusCd == 1"></td>
                <td v-if="orderHeaderDTO.orderStatusCd == 20">待发货</td>
                <td v-if="orderHeaderDTO.orderStatusCd == 3 || orderHeaderDTO.orderStatusCd == 5">
                    已发货
                </td>
            </tr>
            <tr>
                <th>联系手机：</th>
                <td v-show="!editReceive">{{orderReceiveInfo.receiveTel}}</td>
                <td v-show="editReceive"><input v-model="orderReceiveInfo.receiveTel" class="control-text"
                                                style="width: 90%"></td>
                <th>快递单号：</th>
                <td v-show="!editReceive">{{orderReceiveInfo.orderExpressNum}}</td>
                <td v-show="editReceive"><input v-model="orderReceiveInfo.orderExpressNum" class="control-text"
                                                style="width: 90%"></td>
            </tr>
            <tr>
                <th>收货地址：</th>
                <td v-show="!editReceive">{{orderReceiveInfo.receiveAddrCombo}}</td>
                <td v-show="editReceive">
                    <input v-model="orderReceiveInfo.receiveAddrCombo" class="control-text" style="width: 90%">
                </td>
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
                <th>订单优惠：</th>
                <td>￥{{orderHeaderDTO.activityDiscount ? orderHeaderDTO.activityDiscount : 0}}</td>
                <th>商品总价：</th>
                <td>￥{{orderHeaderDTO.orderProductAmt}}</td>
            </tr>
            <tr>
                <th>已用优惠券：</th>
                <td>{{orderHeaderDTO.promotionName}}</td>
                <th>订单折扣：</th>
                <td>￥{{orderHeaderDTO.orderDiscountAmt}}</td>

            </tr>
            <tr>
                <th>优惠券折扣：</th>
                <td>￥{{orderHeaderDTO.promotionDiscount ? orderHeaderDTO.promotionDiscount : 0}}</td>
                <th>快递费用：</th>
                <td>￥{{orderHeaderDTO.orderExpressAmt}}</td>
            </tr>
            <tr>
                <th>红包抵扣：</th>
                <td>-￥{{orderHeaderDTO.redPacketDiscount ? orderHeaderDTO.redPacketDiscount : 0}}</td>
                <th>应付金额：</th>
                <td>￥{{orderHeaderDTO.orderTotalAmt}}</td>
            </tr>
            <tr>
                <th>积分抵扣：</th>
                <td>￥{{orderHeaderDTO.payScore ? orderHeaderDTO.payScore : 0}}</td>
                <th>实付金额：</th>
                <td>￥<span
                        v-if="orderHeaderDTO.type != 1 && orderHeaderDTO.type != 6">{{orderHeaderDTO.orderPayAmt + orderHeaderDTO.payBalance}}</span>
                </td>
            </tr>
            <tr>
                <th>获得积分：</th>
                <td>{{orderHeaderDTO.productReturnScore}}</td>
                <th></th>
                <td></td>
            </tr>
            </tbody>
        </table>


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

        <div class="expressSend" style="display: none;">
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
        </div>

        <div class="pickup" style="display: none;">
            <div class="control-group">
                <label class="control-label">门店名称：</label>
                <div class="controls storeName"></div>
            </div>
            <div class="control-group">
                <label class="control-label">提货时间：</label>
                <div class="controls requiredTime"></div>
            </div>
        </div>
    </form>
</div>

<#--延长收货时间 弹窗-->
<div id="extendContent" class="hide">
    <form class="form-horizontal">
        <div class="control-group">
            <label class="control-label"></label>
            <div class="controls">
                延长收货时间可以让买家有更多的时间来确认收货，而不急于去申请退款
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">延长天数：</label>
            <div class="controls">
                <select id="orderExtendDays" name="orderExtendDays">
                    <option value="3">三天</option>
                    <option value="5">五天</option>
                    <option value="7">七天</option>
                </select>
            </div>
        </div>

    </form>
</div>

<script>
    var vm = new Vue({
        el: '#container',
        data: {
            type: 0,
            promotionId: ${promotionId!},
            promotionCrowdFundDTO: {}, // 众筹信息
            promotionCrowdFundCodeList: [], // 参与记录
            promotionCrowdFundCodeCount: 0, // 参数记录总数
            pageNo: 1,
            pageSize: 5,
            // 订单信息
            orderHeaderDTO: {}, // 订单和商品信息
            orderReceiveInfo: {}, // 收货人信息
            store: {}, // 门店信息
            cancelOrderReasonList: [], // 订单关闭原因列表
            orderPayWayCdList: [], // 支付方式列表
            orderOperationInfoList: [], // 订单操作日志
            expressList: [], // 配送方式列表
            remarkForm: { // 订单备注表单
                remarkTypeCd: '0',
                remark: ''
            },
            editReceive: false // 收货人信息编辑开关
        },
        computed: {
            // 总需参与次数
            totalNeedTimes: function () {
                return this.promotionCrowdFundDTO.crowdFundProductAmt / this.promotionCrowdFundDTO.crowdFundPerAmt;
            },
            // 剩余参与次数
            remainTimes: function () {
                return this.totalNeedTimes - this.promotionCrowdFundDTO.hasJoinTimes;
            }
        },
        methods: {
            // 刷新订单详情信息
            refreshDetail: function () {
                this.$http.get('getCrowdFundOrderDetail', {
                    params: {
                        promotionId: this.promotionId
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.promotionCrowdFundDTO = res.body.promotionCrowdFundDTO;

                            // 若已开奖，则加载中奖的订单信息
                            if (this.promotionCrowdFundDTO.winedOrderId) {
                                this.$http.get('getAllOrderDetail', {
                                    params: {
                                        orderId: this.promotionCrowdFundDTO.winedOrderId
                                    },
                                    emulateJSON: true
                                }).then(
                                        function (res) {
                                            this.orderHeaderDTO = res.body.orderHeaderDTO;
                                            this.orderReceiveInfo = res.body.orderReceiveInfo;
                                            this.store = res.body.store;
                                            this.orderOperationInfoList = res.body.orderOperationInfoList;
                                            this.cancelOrderReasonList = res.body.cancelOrderReasonList;
                                            this.orderPayWayCdList = res.body.orderPayWayCdList;
                                            this.expressList = res.body.expressList;
                                            if (res.body.orderRemark.remark) {
                                                this.remarkForm.remark = res.body.orderRemark.remark;
                                            }
                                            if (res.body.orderRemark.remarkTypeCd != null) {
                                                this.remarkForm.remarkTypeCd = res.body.orderRemark.remarkTypeCd;
                                            }
                                        }
                                )

                            }
                        }
                )
            },
            // 加载参与记录
            loadList: function () {
                this.$http.get('findCrowdFundCodePage', {
                    params: {
                        promotionId: this.promotionId,
                        pageIndex: this.pageNo - 1,
                        limit: this.pageSize
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.promotionCrowdFundCodeCount = res.body.results;
                            this.promotionCrowdFundCodeList = res.body.rows;
                            for (var i in this.promotionCrowdFundCodeList) {
                                this.promotionCrowdFundCodeList[i].createTime = BUI.Grid.Format.datetimeRenderer(this.promotionCrowdFundCodeList[i].createTime)
                            }
                        }
                )
            },
            // 分页重新加载数据
            changePageNo: function (pageNo) {
                this.pageNo = pageNo;
                this.loadList();
            },
            // 保存对收货信息的编辑
            saveEditReceive: function () {
                this.editReceive = false;
                this.$http.post('saveEditReceive', this.receiveForm, {emulateJSON: true}).then(
                        function (res) {
                            if (app.ajaxHelper.handleAjaxMsg(res)) {
                                app.showSuccess('修改成功！');
                            }
                        }
                )
            },
            // 取消收货信息的编辑
            cancelEditReceive: function () {
                this.editReceive = false;
                this.refreshDetail();
            },
            // 保存订单备注
            saveOrderRemark: function () {
                this.$http.post('saveOrderRemark', {
                    orderId: this.orderId,
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
            }
        },
        created: function () {
            this.refreshDetail();
            this.loadList();
        }
    });

    Vue.filter('time', function (value, type) {
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

        if (type == 1) {
            return y + '-' + add0(m) + '-' + add0(d);
        }
        return y + '-' + add0(m) + '-' + add0(d) + ' ' + add0(h) + ':' + add0(mi) + ':' + add0(s);
    });

    // 分页组件
    Vue.component('pager', {
        template: '<div class="pagination pagination-right">' +
        '<ul>' +
        '<li :class="{disabled: pageNo == 1}"><a href="javascript:void(0)" @click="prev">« 上一页</a></li>' +
        '<li v-for="pageNum in pageNumList" :class="{active: pageNo == pageNum, disabled: pageNum == omit}">' +
        '<a v-if="pageNum == omit" href="javascript:void(0)">{{pageNum}}</a>' +
        '<a v-else href="javascript:void(0)" @click="currPageNo = pageNum">{{pageNum}}</a>' +
        '</li>' +
        '<li :class="{disabled: pageNo == pageNumCount}"><a href="javascript:void(0)" @click="next">下一页 »</a></li>' +
        '</ul>' +
        '</div>',
        props: ['pageCount', 'pageNo', 'pageSize'],
        data: function () {
            return {
                omit: '...',
                currPageNo: this.pageNo
            }
        },
        watch: {
            currPageNo: function (pageNo) {
                this.$emit('changepageno', pageNo);
            }
        },
        computed: {
            // 总页数
            pageNumCount: function () {
                return Math.ceil(this.pageCount / this.pageSize);
            },
            // 真正显示在页面上的页码
            pageNumList: function () {
                var pageNumList = [];
                // 少于五个直接打印所有页码
                if (this.pageNumCount <= 5) {
                    for (var i = 1; i <= this.pageNumCount; i++) {
                        pageNumList.push(i)
                    }
                } else {
                    var startIndex = this.currPageNo - 2; // 起始页码
                    var endIndex = this.currPageNo + 2; // 结束页码
                    // 处理页码越界
                    if (startIndex < 1) {
                        startIndex = 1;
                    } else if (endIndex > this.pageNumCount) {
                        startIndex = this.pageNumCount - 4;
                    }
                    // 生成五条页码
                    for (var i = startIndex; i < startIndex + 5; i++) {
                        pageNumList.push(i);
                    }
                }

                // 起始页码大于1
                if (startIndex > 1) {
                    // 大于2时加省略号
                    if (startIndex > 2) {
                        pageNumList.unshift(this.omit)
                    }
                    // 加第一页页码
                    pageNumList.unshift(1);
                }
                // 结束页码小于最大页数
                if (endIndex < this.pageNumCount) {
                    // 结束页码小于最大页数减1时加省略号
                    if (endIndex < this.pageNumCount - 1) {
                        pageNumList.push(this.omit)
                    }
                    // 加最后一页页码
                    pageNumList.push(this.pageNumCount);
                }
                return pageNumList;
            }
        },
        methods: {
            // 上一页
            prev: function () {
                if (this.currPageNo != 1) {
                    this.currPageNo = this.currPageNo - 1;
                }
            },
            // 下一页
            next: function () {
                if (this.currPageNo != this.pageNumCount) {
                    this.currPageNo = this.currPageNo + 1;
                }
            }
        }
    });

    // =====以下为bui+jquery====
    // 标签页

    setTimeout(createTab, 300);
    function createTab() {
        var tabChildren = [{text: '众筹详情', value: '0'}];
        if (vm.promotionCrowdFundDTO.crowdFundStatusCd == 1) {
            tabChildren.push({text: '领奖详情', value: '1'})
        }

        var tab = new BUI.Tab.Tab({
            render: '#tab',
            elCls: 'nav-tabs',
            autoRender: true,
            children: tabChildren
        });

        // 切换标签页
        tab.on('selectedchange', function (ev) {
            vm.type = ev.item.get("value");
        });

        tab.setSelected(tab.getItemAt(0));
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
                orderId: vm.promotionCrowdFundDTO.winedOrderId,
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
                orderId: vm.promotionCrowdFundDTO.winedOrderId,
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

    // 渲染 发货弹窗 下拉
    setTimeout(setExpressId, 1000);
    function setExpressId() {
        $("#sendOrderNumber").html(vm.orderHeaderDTO.orderNumber);
        $("#sendOrderPayAmt").html(vm.orderHeaderDTO.orderPayAmt + vm.orderHeaderDTO.payBalance);
        $("#sendReceiveName").html(vm.orderReceiveInfo.receiveName);
        if (vm.store) {
            $(".pickup").show();
            $(".storeName").html(vm.store.storeName);
            $(".requiredTime").html(BUI.Grid.Format.datetimeRenderer(vm.orderReceiveInfo.requiredStartTime) + " 至<br>" + BUI.Grid.Format.datetimeRenderer(vm.orderReceiveInfo.requiredEndTime));
        } else {
            $(".expressSend").show();
        }
        for (var index in vm.expressList) {
            var str = '<option value="' + vm.expressList[index].expressId + '" ';
            if (vm.expressList[index].expressId == vm.orderReceiveInfo.expressId) {
                str += 'selected="selected"';
            }
            str += '>' + vm.expressList[index].expressName + '</option>';
            $("#expressId").append(str)
        }

    }

    // 打开 发货 弹窗
    function sendOrder() {
        sendDialog.show();
    }


    // ------延长收货时间 弹窗操作-------
    // 延长收货时间 弹窗
    var extendDialog = new BUI.Overlay.Dialog({
        title: '延长收货时间',
        width: 500,
        height: 200,
        contentId: 'extendContent',
        success: function () {
            $.post("extendOrder", {
                orderId: vm.promotionCrowdFundDTO.winedOrderId,
                orderExtendDays: $("#orderExtendDays").val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("延长收货时间成功");
//                    vm.refreshDetail();
                    extendDialog.close();
                }
            }, "json")
        }
    });

    // 打开 延长收货时间 弹窗
    function extendOrder() {
        extendDialog.show();
    }


    // 确认收货
    function confirmReceive() {
        var str = "操作后订单状态会变成待评价,只能查看订单不能进行任何操作";
        BUI.Message.Confirm(str, function () {
            $.post("confirmReceive", {orderId: vm.promotionCrowdFundDTO.winedOrderId}, function (data) {
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