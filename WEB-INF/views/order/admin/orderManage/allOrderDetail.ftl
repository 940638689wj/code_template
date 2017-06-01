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
                <tr v-if="orderHeaderDTO.orderTypeCd == 1 || orderHeaderDTO.orderTypeCd == 3">
                    <th>期望送达时间：</th>
                    <td>{{orderHeaderDTO.expectSendTime}}</td>
                    <th></th>
                    <td></td>
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
                    <th>发票对象：</th>
                    <td>
                        {{orderReceiveInfo.invoiceForName}}
                    </td>
                </tr>
                <template v-if="orderReceiveInfo.invoiceTypeCd == 1">
                    <tr>
                        <th>个人姓名：</th>
                        <td>{{orderReceiveInfo.companyName}}</td>
                        <th></th>
                        <td></td>
                    </tr>
                </template>
                <template v-if="orderReceiveInfo.invoiceTypeCd == 2">
                    <tr>
                        <th>单位名称：</th>
                        <td>{{orderReceiveInfo.companyName}}</td>
                        <th>纳税人识别码：</th>
                        <td>{{orderReceiveInfo.companyTaxpayerIdentifyCode}}</td>
                    </tr>
                    <tr>
                        <th>注册地址：</th>
                        <td>{{orderReceiveInfo.companyRegisterAddr}}</td>
                        <th>注册电话：</th>
                        <td>{{orderReceiveInfo.companyRegisterTel}}</td>
                    </tr>
                    <tr>
                        <th>银行账户：</th>
                        <td>{{orderReceiveInfo.companyBankAccount}}</td>
                        <th>开户行：</th>
                        <td>{{orderReceiveInfo.companyOpeningBankName}}</td>
                    </tr>
                    <tr>
                        <th>发票抬头：</th>
                        <td>{{orderReceiveInfo.invoiceTitle}}</td>
                        <th>发票配送地址：</th>
                        <td>{{orderReceiveInfo.companyOpeningBankName}}</td>
                    </tr>
                </template>
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
                <template v-if="orderHeaderDTO.orderTypeCd == 1">
                    <tr>
                        <th>获得积分：</th>
                        <td>{{orderHeaderDTO.productReturnScore}}</td>
                        <th></th>
                        <td></td>
                    </tr>
                </template>
                <template v-if="orderHeaderDTO.orderTypeCd == 3">
                    <tr>
                        <th>白鹭卡积分抵扣：</th>
                        <td>-￥{{orderHeaderDTO.egretScore ? orderHeaderDTO.egretScore : 0}}</td>
                        <th></th>
                        <td></td>
                    </tr>
                    <tr>
                        <th>获得积分：</th>
                        <td>{{orderHeaderDTO.productReturnScore}}</td>
                        <th></th>
                        <td></td>
                    </tr>
                </template>
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

<#--调价 弹窗-->
<div id="changePriceContent" class="hide">
    <form class="form-horizontal">

        <div class="control-group">
            <label class="control-label">调价前订单总价：</label>
            <div class="controls" id="beforeChangePrice"></div>
        </div>

        <div class="control-group">
            <label class="control-label">调价后订单总价：</label>
            <div class="controls">
                <input class="input-normal control-text" name="orderPayAmt" id="orderPayAmt">
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">备注：</label>
            <div class="controls">
                <textarea class="input-large" type="text" id="changePriceOperDesc"
                          name="changePriceOperDesc"></textarea>
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
            orderId: ${orderId!},
            type: 0, // 标签页类型
            orderHeaderDTO: {}, // 订单和商品信息
            orderReceiveInfo: {}, // 收货人信息
            store: {}, // 门店信息
            orderCancelInfo: {}, // 订单的关闭信息
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
            // 收货人信息表单
            receiveForm: function () {
                return {
                    orderId: this.orderId,
                    receiveName: this.orderReceiveInfo.receiveName,
                    receiveTel: this.orderReceiveInfo.receiveTel,
                    receiveAddrCombo: this.orderReceiveInfo.receiveAddrCombo,
                    orderExpressNum: this.orderReceiveInfo.orderExpressNum
                }
            }
        },
        methods: {
            // 刷新订单详情信息
            refreshDetail: function () {
                this.$http.get('getAllOrderDetail', {
                    params: {
                        orderId: this.orderId
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.orderHeaderDTO = res.body.orderHeaderDTO;
                            this.orderReceiveInfo = res.body.orderReceiveInfo;
                            this.store = res.body.store;
                            this.orderCancelInfo = res.body.orderCancelInfo;
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


    // ------支付 弹窗操作-------
    // 支付 弹窗
    var payDialog = new BUI.Overlay.Dialog({
        title: '支付',
        width: 500,
        height: 320,
        contentId: 'payContent',
        success: function () {
            $.post("payOrder", {
                orderId: vm.orderId,
                orderPayWayCd: $("#orderPayWayCd").val(),
                payOperDesc: $("#payOperDesc").val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("支付成功");
                    vm.refreshDetail();
                    payDialog.close();
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
    function payOrder() {
        payDialog.show();
    }


    // ------调价 弹窗操作-------
    // 调价 弹窗
    var changePriceDialog = new BUI.Overlay.Dialog({
        title: '调价',
        width: 500,
        height: 320,
        contentId: 'changePriceContent',
        success: function () {
            $.post("changePriceOrder", {
                orderId: vm.orderId,
                orderPayAmt: $("#orderPayAmt").val(),
                changePriceOperDesc: $("#changePriceOperDesc").val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("调价成功");
                    vm.refreshDetail();
                    changePriceDialog.close();
                }
            }, "json");
        }
    });

    // 渲染 调价前订单总价
    setTimeout('$("#beforeChangePrice").html("￥" + vm.orderHeaderDTO.orderPayAmt)', 1000);

    // 打开 调价 弹窗
    function changePriceOrder() {
        changePriceDialog.show();
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
            $("#expressId").append(str);
            $("#orderExpressNum").val(vm.orderReceiveInfo.orderExpressNum);
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
                orderId: vm.orderId,
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