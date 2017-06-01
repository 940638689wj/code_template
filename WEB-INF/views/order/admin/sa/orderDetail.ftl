<#assign ctx = request.contextPath>
<#assign platformTypes = ''>
<#assign expressTypes=[]/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
 <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="breadcrumb">
            <li class="active">订单详情</li>
        </ul>
    </div>
    <div class="content-body">
        <div class="order-info-tite"><h3>订单基本信息</h3></div>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>订单号:</th>
                <td>${(order.orderNumber)!}<#if orderInfo.Is_Store_First_Order><span class="text-red">首单</span></#if></td>
                <th>订单来源系统:</th>
                <td>${DICT('ORDER_ORIGIN_SYSTEM_CD','${(orderInfo.Origin_System_Cd)!}')}</td>
                <th>订单来源平台:</th>
                <td>${DICT('Origin_Platform_Cd','${(orderInfo.Origin_Platform_Cd)!}')}</td>
            </tr>
            <tr>
                <th>订单类型:</th>
                <td>${DICT('ORDER_TYPE_CD','${order.orderTypeCd}')}</td>
                <th>下单时间:</th>
                <td>${order.createTime?string('yyyy-MM-dd HH-mm-ss')}</td>
                <th>订单状态:</th>
                <td><script>document.write($.fn.status('${order.orderStatusCd}'));</script></td>
            </tr>
            <tr> 
                <th>订单属性:</th>
                <td>${DICT('ORDER_PROPERTY_CD','${order.orderPropertyCd}')}</td>
                <th>问题类型:</th>
                <td>${(order.orderProblemType)!}</td>
                <th>下单人:</th>
                <td>${(user.userName)!}</td>
            </tr>
            <tr>
                <th>下单人手机号:</th>
                <td>${(user.phone)!}</td>
                <th>下单省份:</th>
                <td>${(orderProvinceName)!}</td>
                <th>下单城市:</th>
                <td>${(orderCityName)!}</td>
            </tr>
            <tr>
                <th>订单分配类型:</th>
                <td>${DICT('Order_Distrbute_Type_Cd','${(order.orderDistrbuteTypeCd)!}')}</td>
                <th>难度系数:</th>
                <td>${DICT('Order_Hard_Cd','${(order.orderHardCd)!}')}</td>
                <th>订单来源微店主:</th>
                <td>${orderFromMstoreUserName!}</td>
            </tr>
            <tr>
                <th>订单来源门店:</th>
                <td>${orderFromStoreName!}</td>
                <th></th>
                <td></td>
                <th></th>
                <td></td>
            </tr>
            </tbody>
        </table>
        <div class="order-info-tite"><h3>订单金额信息</h3></div>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>支付类型:</th>
                <td>${DICT('order_Pay_Mode_Cd','${order.orderPayModeCd!}')}</td>
                <th>支付方式:</th>
                <td>${DICT('ORDER_PAY_WAY_CD','${order.orderPayWayCd!}')}</td>
                <th>支付状态:</th>
                <td>${DICT('ORDER_PAY_STATUS_CD','${order.orderPayStatusCd!}')}</td>
            </tr>
            <tr>
                <th>支付时间:</th>
                <td></td>
                <th>应支付金额:</th>
                <td>${(order.orderPayAmt)!}元</td>
                <th>订单总额:</th>
                <td>${(order.orderTotalAmt)!}元</td>
            </tr>
            <tr>
                <th>优惠总额:</th>
                <td>${(order.orderDiscountAmt)!}元</td>
                <th>积分抵扣金额:</th>
                <td>
                <#if orderPayInfo??><#list orderPayInfo as orderPI> 
                	<#if orderPI.payTypeCode==3>
                		${orderPI.discount}元
                	</#if>
                </#list></#if>
                </td>
                <th>红包抵扣金额:</th>
                <td> 
                <#if orderPayInfo??><#list orderPayInfo as orderPI> 
                	<#if orderPI.payTypeCode==1>
                		${orderPI.discount}元
                	</#if>
                </#list></#if>
                </td>
            </tr>
            <tr>
                <th>购酒券抵扣金额:</th>
                <td> 
                <#if orderPayInfo??><#list orderPayInfo as orderPI> 
                	<#if orderPI.payTypeCode==2>
                		${orderPI.discount}元
                	</#if>
                </#list></#if>
                </td>
                <th>优惠券抵扣金额:</th>
                <td> 
                <#if orderPayInfo??><#list orderPayInfo as orderPI> 
                	<#if orderPI.payTypeCode==5>
                		${orderPI.discount}元
                	</#if>
                </#list></#if>
                </td>
                <th>第三方交易流水号:</th>
              <td></td>
            </tr>
            <tr>
                <th>订单快递金额:</th>
             	<td>${(order.orderExpressAmt)!}元</td>
                <th>发票快递金额:</th>
               <td>${(order.invoiceExpressAmt)!}元</td>
                <th></th>
                <td></td>
            </tr>
            </tbody>
        </table>
        <#if orderItem??>
        <div class="order-info-tite"><h3>订单产品信息</h3></div>
        <#list orderItem as orderI>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>产品名称:</th>
             	<td>${orderI.productName}</td>
                <th>产品销售单位:</th>
                <td>${orderI.salesUnit}</td>
                <th>产品数量:</th>
               <td>${orderI.quantity}瓶</td>
            </tr>
            <tr>
                <th>产品单价:</th>
               <td>${(orderI.tagPrice)!}元</td>
                <th>是否赠品:</th>
                <td>
                <#if order.isGiftCd?? && order.isGiftCd>是<#else>否</#if>
                </td>
                <th></th>
                <td></td>
            </tr>
            </tbody>
           
        </table>
        </#list>
        </#if>
        <#if orderPromotionInfo??>
        <div class="order-info-tite"><h3>订单活动信息</h3></div>
        <#list orderPromotionInfo as orderPI>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>活动类型:</th>
                <td>${(orderPI.promotionTypeDesc)!}</td>
                <th>活动名称:</th>
                <td>${(orderPI.promotionName)!}</td>
                <th>活动描述:</th>
                <td>${(orderPI.promotionDesc)!}</td>
            </tr>
            <tr>
                <th>活动优惠金额:</th>
                <td>${(orderPI.discount)!}元</td>
                <th>赠送礼品:</th>
                <td></td>
                <th>赠送积分</th>
                <td></td>
            </tr>
            <tr>
                <th>赠送优惠券:</th>
                <td></td>
                <th>赠送红包:</th>
                <td></td>
                <th></th>
                <td></td>
            </tr>
            </tbody>
        </table>
        </#list>
        </#if>
        <div class="order-info-tite"><h3>订单收货信息</h3></div>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>收货人:</th>
                <td>${(orderReceiveInfo.Receive_Name)!}</td>
                <th>联系方式:</th>
                <td>${(orderReceiveInfo.Receive_Tel)!}</td>
                <th>收货地址:</th>
             	<td>${(orderReceiveInfo.Receive_Addr_Combo)!}</td>
            </tr>
            <tr>
                <th>烟酒店:</th>
                <td>${(orderReceiveInfo.store_name)!}</td>
                <th>烟酒店联系人:</th>
              <td>${(orderReceiveInfo.Contacts)!}</td>
                <th>烟酒店联系方式:</th>
               <td>${(orderReceiveInfo.Telephone)!}</td>
            </tr>
            <tr>
                <th>买家留言:</th>
               	<td>${(orderReceiveInfo.remark)!}</td>
                <th>快递公司:</th>
                <td>${(orderReceiveInfo.Express_Name)!}</td>
                <th>快递单号:</th>
                <td>${(orderReceiveInfo.Express_No)!}</td>
            </tr>
            <tr>
                <th>发票快递公司:</th>
                <td>${(orderReceiveInfo.Express_Name)!}</td>
                <th>发票快递单号:</th>
                <td>${(orderReceiveInfo.Express_No)!}</td>
                <th>发票类型:</th>
                <td>${(orderReceiveInfo.Invoice_Type_Cd)!}</td>
            </tr>
            <tr>
                <th>发票单号:</th>
                <td>${(orderReceiveInfo.Invoice_Number)!}</td>
                <th>发票邮寄地址:</th>
                <td>${(orderReceiveInfo.Invoice_Receive_Addr)!}</td>
                <th>发票收货人:</th>
                <td>${(orderReceiveInfo.Invoice_Receive_Name)!}</td>
            </tr>
            <tr>
                <th>发票收货人联系方式:</th>
                <td>${(orderReceiveInfo.Invoice_Receive_Tel)!}</td>
                <th></th>
                <td></td>
                <th></th>
                <td></td>
            </tr>
            </tbody>
        </table>
        <#if orderReturn??>
        <div class="order-info-tite"><h3>订单退款/退货信息</h3></div>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>类型:</th>
                <td><script>document.write($.fn.applyType('${(orderReturn.Apply_Type)!}'));</script></td>
                <th>申请时间:</th>
                <td>${(orderReturn.Apply_Time?string('yyyy-MM-dd HH-mm-ss'))!}</td>
                <th>申请理由:</th>
                <td>${(orderReturn.Apply_Reason)!}</td>
            </tr>
            <tr>
                <th>初审时间:</th>
                <td>${(orderReturn.Trial_Time?string('yyyy-MM-dd HH-mm-ss'))!}</td>
                <th>初审意见:</th>
               <td>${(orderReturn.Trial_Opinion)!}</td>
                <th>初审客服:</th>
               <td>${(orderReturn.Trial_User_Name)!}</td>
            </tr>
            <tr>
                <th>客服主管处理时间:</th>
               <td>${(orderReturn.Leader_Handle_Time?string('yyyy-MM-dd HH-mm-ss'))!}</td>
                <th>客服主管处理意见:</th>
                <td>${(orderReturn.Leader_Opinion)!}</td>
                <th>客服主管:</th>
                <td>${(orderReturn.Leader_Name)!}</td>
            </tr>
            <tr>
                <th>退款交易号:</th>
                <td>${(orderReturn.Serial_No)!}</td>
                <th>退款金额:</th>
                <td>${(orderReturn.Amount)!}</td>
                <th>是否收到货:</th>
                <td>
                <#if Is_Receive_Good>是<#else>否</#if>
                </td>
            </tr>
          </tbody>
        </table>
        </#if>
        <#if review??>
        <div class="order-info-tite"><h3>订单评价信息</h3></div>
        <#list review as re>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>门店名称:</th>
                <td>${(re.Store_Name)!}</td>
                <th>发货速度:</th>
                <td>${(re.Sale_Ship_Speed_Score)!}</td>
                <th>服务态度:</th>
                <td>${(re.Sale_Service_Attr_Score?int)!}</td>
            </tr>
            <tr>
                <th>产品名称:</th>
                <td>${(re.Product_Name)!}</td>
                <th>评价内容:</th>
                <td>${(re.Review_Content)!}</td>
                <th>符合程度:</th>
                <td>${(re.Product_Match_Score)!} </td>
            </tr>
            
            </tbody>
        </table>
        </#list>
        </#if>
        <#if operationInfo??>
        <div class="order-info-tite"><h3>订单处理信息</h3></div>
        <#list operationInfo as op>
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>处理人:</th>
                <td>${(op.Oper_Name)!}</td>
                <th>处理时间:</th>
                <td>${(op.Oper_Time?string('yyyy-MM-dd HH:mm:ss'))!}</td>
                <th>处理类型:</th>
                <td>${DICT('ORDER_OPER_TYPE_CD','${(op.Oper_Type_Cd)!}')}</td>
                <th>处理详情:</th>
                <td>${(op.Oper_Desc)!}</td>
            </tr>
            </tbody>
        </table>
        </#list>
    </div>
	</#if>

    <div id="ordernote" class="hide">
            <div class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">备注：</label>
                        <div class="controls control-row-auto">
                            <textarea id="remarkAgree" class="span6"></textarea>
                        </div>
                    </div>
                </div>
                <div class="row" style="overflow:scroll;height:200px;">
                	<table style="width:100%;" id="remarktb">
                	
                	</table>
                </div>
            </div>
    </div>

    <div id="ordercancel" class="hide">
        <form class="form-horizontal">
            <div class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">备注：</label>
                        <div class="controls control-row-auto">
                            <textarea name="remarkAgree" class="span6"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
   
</div>
</body>

</html>  