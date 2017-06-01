<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">

        <li class="active">订单信息</li>
    </ul>
    <div>

        <div class="container">
            <ul class="breadcrumb">
            <#if orderRemarks?has_content>
            <h2>  客服备注：
                <#list orderRemarks as orderRemark>
                ${orderRemark.remark!} &nbsp&nbsp&nbsp&nbsp
                </#list>
            </#if>
                <br>
                <li class="active">订单号：${orderInfoDTO.orderNumber!}</li>
                <span style="font-size:20px;color:red;">
                <#if orderReturnInfo.applyTypeCd == 1>
                    退款
                <#elseif orderReturnInfo.applyTypeCd == 2>
                    退款退货
                <#elseif orderReturnInfo.applyTypeCd == 3>
                    换货
                <#elseif orderReturnInfo.applyTypeCd == 4>
                    退货
                </#if>
                </span>

            </ul>
            <div id="noPrint">
                <p>
                    <button type="button" id="print" class="button button-primary">打印订单</button>
                </p>
            </div>
            <div id="content" class="hide">
                <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/order/changePrice" method="post">
                    <input type="hidden" name="orderId" value="${orderInfoDTO.orderId!}">
                    <div class="control-group">
                        <label class="control-label">退换货原因：</label>
                        <div class="controls">
                        ${(systemCode.codeCnName)!}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">是否收到货：</label>
                        <div class="controls">
                        ${(orderReturnInfo.isReceiveGood == 0)?string('否','是')}
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">退换货描述：</label>
                        <div class="controls">
                        ${orderReturnInfo.reasonDetailDesc!}
                        </div>
                    </div>

                    <div class="control-group mb10 w580">
                        <label class="control-label">是否同意：</label>
                        <div class="controls bui-form-group" data-rules="{checkRange:1}"
                             data-messages="{checkRange:'请选择学校类型！'}">
                            <label><input type="radio" name="type" value="1"/>同意</label>
                            <label><input type="radio" name="type" value="0"/>拒绝</label>
                        </div>
                    </div>

                    <div class="control-group">
                        <label class="control-label">处理意见：</label>
                        <div class="controls">
                            <textarea class="input-large" type="text" id="setInfo"></textarea>
                        </div>
                    </div>
                </form>
            </div>

            <div>


                <table cellspacing="0" class="table table-info">
                    <tbody>
                    <tr>
                        <th>终端：</th>
                        <td>${(orderInfoDTO.originPlatformCd == 0)?string('PC端','手机端')}</td>
                    </tr>
                    </tbody>
                </table>

                <table cellspacing="0" class="table table-info">
                    <caption>订单信息</caption>
                    <tbody>
                    <tr>
                        <th>订单号：</th>
                        <td>${orderInfoDTO.orderNumber!}</td>
                        <th>付款状态：</th>
                        <td>${(orderInfoDTO.orderPayStatusCd == 1)?string('否','是')}</td>
                    </tr>
                    <tr>
                        <th>下单时间：</th>
                        <td>
                        ${(orderInfoDTO.createTime?string("yyyy-MM-dd HH:mm:ss"))!}
                        </td>
                        <th>付款时间：</th>
                        <td>
                        ${(payTime?string("yyyy-MM-dd HH:mm:ss"))!}
                        </td>
                    </tr>


                    <tr>
                        <th>付款类型：</th>
                        <td>${(orderInfoDTO.orderPayModeCd == 1)?string('在线支付','线下支付')}</td>
                        <th>商品件数：</th>
                        <td>${totalNo!}</td>
                    </tr>

                    <tr>
                        <th>付款方式：</th>
                    <#if orderInfoDTO.orderPayWayCd == 1>
                        <td>微信支付</td>
                    <#elseif orderInfoDTO.orderPayWayCd == 2>
                        <td>支付宝</td>
                    <#elseif orderInfoDTO.orderPayWayCd == 3>
                        <td>货到付款</td>
                    <#elseif orderInfoDTO.orderPayWayCd == 4>
                        <td>银联支付</td>
                    <#else>
                        <td>余额支付</td>
                    </#if>
                        <th></th>
                        <td></td>
                    </tr>

                    </tbody>
                </table>

                <table cellspacing="0" class="table table-info">
                    <caption>收货人信息</caption>
                    <tbody>
                    <tr>
                        <th>收件人：</th>
                        <td>${orderInfoDTO.receiveName!}</td>
                        <th>订单状态：</th>
                    <#if orderInfoDTO.orderStatusCd == 1>
                        <td>未付款</td>
                    <#elseif orderInfoDTO.orderStatusCd == 10>
                        <td>待指派</td>
                    <#elseif orderInfoDTO.orderStatusCd == 11>
                        <td>待指派</td>
                    <#elseif orderInfoDTO.orderStatusCd == 20>
                        <td>待发货</td>
                    <#elseif orderInfoDTO.orderStatusCd == 3>
                        <td>已发货</td>
                    <#elseif orderInfoDTO.orderStatusCd == 4>
                        <td>待评价</td>
                    <#elseif orderInfoDTO.orderStatusCd == 5>
                        <td>已完成</td>
                    <#else>
                        <td>已关闭</td>
                    </#if>
                    </tr>
                    <tr>
                        <th>联系方式：</th>
                        <td>${orderInfoDTO.receiveTel!}</td>
                        <th>收件地址：</th>
                        <td>${orderInfoDTO.receiveAddrCombo!}</td>
                    </tr>


                    <tr>
                        <th>会员名：</th>
                        <td>${orderInfoDTO.userName!}</td>

                        <th>买家留言：</th>
                        <td>${orderInfoDTO.orderRemark!}</td>
                    </tr>

                    <tr>
                        <th>物流：</th>
                        <td>${(express.expressName)!}</td>

                        <th>快递单号：</th>
                        <td>${(orderInfoDTO.orderExpressNum)!}</td>
                    </tr>


                    <tr>
                        <th>评价时间：</th>
                        <td>
                        ${(reviewTime?string("yyyy-MM-dd HH:mm:ss"))!}
                        </td>
                        <th>发货时间：</th>
                        <td>
                        ${(orderInfoDTO.sendTime?string("yyyy-MM-dd HH:mm:ss"))!}
                        </td>
                    </tr>

                    </tbody>
                </table>

            <#if orderItems?has_content>
                <table cellspacing="0" class="table table-bordered table-striped">
                    <caption>商品清单</caption>
                    <thead>
                    <tr>
                        <th>商品</th>
                        <th>规格</th>
                        <th>单价</th>
                        <th>数量</th>
                        <th>重量</th>
                        <th>优惠</th>
                        <th>小计</th>
                        <th>退款/换货</th>
                    </tr>
                    </thead>
                    <tbody>

                        <#list orderItems as orderItem>
                        <tr>
                            <td>${orderItem.productName!}</td>
                            <td width="300">
                                <#list productMap?keys as mKey>
                                    <#if mKey="${orderItem.productId}">
                                        <#assign items = productMap[mKey]>
                                        <#list items?keys as key>
                                        ${key}:${items[key]}
                                        </#list>
                                    </#if>
                                </#list>
                            </td>
                            <td>${orderItem.salePrice!}</td>
                            <td>${orderItem.quantity!}</td>
                            <td>${orderItem.productWeight!}&nbsp&nbsp
                                <#if orderItem.productWeight??>
                                    <#if orderItem.productWeightUnitCd==1>
                                        g(克)
                                    <#elseif orderItem.productWeightUnitCd==2>
                                        kg(千克)
                                    <#else>
                                        t(吨)
                                    </#if>
                                </#if>
                            </td>
                            <td>￥-<#if orderItem.productDiscountAmt??>${orderItem.productDiscountAmt!}<#else>
                                0</#if></td>
                            <#if orderItem.productDiscountAmt??>
                                <td>￥${orderItem.productTotal-orderItem.productDiscountAmt}</td>
                            <#else>
                                <td>￥${orderItem.productTotal!}</td>
                            </#if>
                            <#if orderReturnInfo.orderItemId == orderItem.orderItemId>
                                <#if orderReturnInfo.applyTypeCd == 1>
                                    <td><a href="javascript:void(0);" onclick="js_method()">退款</a></td>
                                <#elseif orderReturnInfo.applyTypeCd == 2>
                                    <td><a href="javascript:void(0);" onclick="js_method()">退款退货</a></td>
                                <#elseif orderReturnInfo.applyTypeCd == 3>
                                    <td><a href="javascript:void(0);" onclick="js_method()">换货</a></td>
                                <#elseif orderReturnInfo.applyTypeCd == 4>
                                    <td><a href="javascript:void(0);" onclick="js_method()">退货</a></td>
                                </#if>
                            <#else>
                                <td>--</td>
                            </#if>
                        </tr>
                        </#list>

                    </tbody>
                </table>
            </#if>


                <table cellspacing="0" class="table table-info">
                    <caption>订单金额</caption>
                    <tbody>
                    <tr>
                        <th>订单优惠：</th>
                        <td>￥${orderAmtInfo.orderDiscountAmt!}</td>
                        <th>商品总价：</th>
                        <td>￥${orderAmtInfo.orderProductAmt!}</td>
                    </tr>
                    <tr>
                        <th>已用优惠券：</th>
                        <td><#if promotionInfo?has_content>${promotionInfo.promotionName!}<#else>无</#if></td>
                        <th>快递费用：</th>
                        <td>￥${orderAmtInfo.orderExpressAmt!}</td>

                    </tr>


                    <tr>
                        <th>优惠券折扣：</th>
                        <td>￥-<#if promotionInfo?has_content>${promotionInfo.discount}<#else>0.00</#if></td>

                        <th>订单总价：</th>
                        <td>￥${orderAmtInfo.orderTotalAmt!}</td>

                    </tr>
                    <tr>
                        <th>红包折扣：</th>
                        <td>￥-<#if redPacketInfo?has_content>${redPacketInfo.discount}<#else>0.00</#if></td>
                        <th>订单折扣：</th>
                        <td>￥-<#if orderAmtInfo.orderDiscountAmt ??>${orderAmtInfo.orderDiscountAmt}<#else>
                            0.00</#if></td>

                    </tr>
                    <tr>
                        <th>积分折扣：</th>
                        <td><#if exchageMoneyPointPay?has_content>￥${exchageMoneyPointPay!}<#else>
                            ￥0.00</#if>&nbsp;(消耗${(pointPay)?default("0")}积分)
                        </td>
                        <th>应付金额：</th>
                        <td>￥${orderAmtInfo.orderPayAmt!}</td>
                    </tr>

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var dialog;
    BUI.use(['bui/overlay', 'bui/form'], function (Overlay, Form) {
        var form = new Form.Form({
            srcNode: '#J_Form'
        }).render();

        dialog = new Overlay.Dialog({
            title: '操作',
            width: 600,
            height: 400,
            //配置DOM容器的编号
            contentId: 'content',
            success: function () {
                var type = $("input[name='type']:checked").val();
                if (type == null) {
                    BUI.Message.Alert("请选择是否同意！");
                    return false;
                }
                $.ajax({
                    type: "post",
                    url: "${ctx}/admin/sa/order/setOrderReturnInfo",
                    data: {
                        "id":${orderReturnInfo.id!},
                        "setType": type,
                        "orderItemId":${orderReturnInfo.orderItemId!},
                        "setInfo": $('#setInfo').val(),
                        "userId":${orderInfoDTO.userId!}
                    },
                    dataType: "json",
                    success: function (data) {
                        if (data == 0) {
                            BUI.Message.Alert("操作成功!", function () {
                                location.reload();
                            });
                        } else if (data == 2) {
                            BUI.Message.Alert("请不要重复提交审核!");
                        } else if (data == 3) {
                            BUI.Message.Alert("该订单已做过处理!");
                        }
                        else {
                            BUI.Message.Alert("已提交审核!");
                        }
                        window.href.location = "${ctx}/admin/sa/order/changePrice";
                        dialog.close();
                    },

                });
            }
        });


    });


    function js_method() {
        var type =   ${orderReturnInfo.applyStatusCd};
        if (type != 1) {
            BUI.Message.Alert("已审核或已提交审核");
            return false;
        }
        dialog.show();

    }


    $(function () {
        $('#print').click(function () {
            $("#noPrint").hide();
            window.print();
            $("#noPrint").show();
        });
    });

</script>
</body>
</html>  