<div>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#assign pcLogo = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcLogo()?default("")>
<#assign companyAddress = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getCompanyAddress()?default("")>
<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/jquery.regionMgr.js"></script>
<style>
    div {
        color: #000;
    }

    div {
        padding: 0;
        margin: 0;
        font-size: 12px;
        color: #000;
        text-align: left;
        font-size: 12px;
    }

    .printdiv {
        position: relative;
        color: #000;
        font-size: 12px;
    }

    .printdiv table {
        margin: auto;
        border-collapse: collapse;
        color: #000;
    }

    .printdiv table td {
        font-size: 12px;
    }

    .printdiv .goods td, .printdiv .goods th {
        border: 1px solid #333;
        font-size: 12px;
    }

    .printdiv .goods th {
        background: #ccc;
    }

    h3 {
        position: relative;
        line-height: 50px;
        font-size: 15px;
        padding: 0;
        margin: 0;
    }

    h3 img {
        display: block;
    }

    .w_print {
        width: 100%;
    }

    @media print {
        .noprint {
            display: none;
        }

        /*.left {*/
            /*float: left;*/
        /*}*/

        .qianzi {
            text-align: center;
            font-size: 14px;
            font-weight: bold;
            padding-bottom: 15px;
        }

        .qianzi span {
            display: inline-block;
            width: 150px;
            border-bottom: 1px solid #000000;
        }

        div {
            padding: 0;
            margin: 0;
            font-size: 12px;
            color: #000;
            text-align: left;
            font-size: 12px;
        }

        .printdiv {
            position: relative;
            width: 100%;
            padding: 0;
            color: #000;
            font-size: 12px;
            /*height: 50% !important;*/
            /*height: 100%;*/
            margin: 0;
        }

        .pageNext{
            page-break-before: always;
        }

        .pageNext:first-child{
            page-break-before:avoid;
        }

        .printdiv table {
            margin: auto;
            border-collapse: collapse;
            color: #000;
        }

        .printdiv table td {
            font-size: 12px;
        }

        .printdiv .goods td, .printdiv .goods th {
            border: 1px solid #333;
            font-size: 12px;
        }

        .printdiv .goods th {
            background: #ccc;
        }

        /*.right {*/
            /*float: left;*/
            /*margin: 0px 15px;*/
        /*}*/

        h3 {
            line-height: 30px;
            font-size: 18px;
            padding: 0;
            margin: 0;
        }

        h3 img {
            display: block;
        }

        #print-container {
            width: 100%;
        }

        .bottom-logo {

        }

        .w_print {
            width: 95%;
            margin: auto;
        }

        .dd {
            padding-top: 5px;
        }
    }

</style>
<p class="noprint" style="padding:15px 0;text-align:center;border-bottom:1px solid #000;background:#f2f2f2;">
    <input type="button" value="打印订单" onclick="window.print();"></p>

<div id="print-container">
	<#if orderList??>
    <#list orderList as one>
    	  <#assign orderReceiveInfo=""/>
		        <#if orderReceiveInfoMap?has_content && orderReceiveInfoMap[one.orderId?string]?exists>
		            <#assign orderReceiveInfo=orderReceiveInfoMap[one.orderId?string]/>
		        </#if>
    	 <div class="pageNext"></div>
         <div class="printdiv <#if one_index%2==0>left<#else>right</#if>">
    		 <h3 class="w_print" align="center">
                <img height="50" src="${pcLogo!}" border="0" alt=""/>
                	购物清单
             </h3>
		            <div class="w_print">
		                购货人：${(one.userName)!?html}<!-- 购货人姓名 -->&nbsp;
		                下单：<#if one.createTime??>${one.createTime?string("MM-dd HH:mm")}</#if><!-- 下订单时间 -->&nbsp;
		            </div>
    	  <div class="w_print">订单号：${(one.orderNumber)!}<!-- 订单号 -->
            
            </div>
            <#if orderReceiveInfo?? && orderReceiveInfo.receiveName??>
                <div class="w_print">
                    姓名：${(orderReceiveInfo.receiveName)!}&nbsp;<!-- 收货人姓名 -->
                    电话：<#if orderReceiveInfo?? && orderReceiveInfo.receiveTel??>${orderReceiveInfo.receiveTel!}</#if>
                    &nbsp; <!-- 联系电话 -->
                    <!-- 手机号码 -->
                    <br/>地址：${(orderReceiveInfo.receiveAddrCombo)!?html}
                </div>
            </#if>
            <div class="w_print">
                买家留言： ${(one.orderRemark)!?html}
            </div>
            <table class="goods w_print" cellpadding="0" cellspacing="0">
                <tbody>
                <tr align="center">
                    <!-- 商品名称 -->
                    <th bgcolor="#cccccc">商品名称(规格)</th>
                    <!-- 商品单价 -->
                    <th bgcolor="#cccccc">价格</th>
                    <!-- 商品数量 -->
                    <th bgcolor="#cccccc">数量</th>
                    <!-- 价格小计 -->
                    <th bgcolor="#cccccc">小计</th>
                </tr>
                 <#assign orderItems=""/>
		        <#if orderItemsMap?has_content && orderItemsMap[one.orderId?string]?exists>
		            <#assign orderItems=orderItemsMap[one.orderId?string]/>
		        </#if>
                <#if orderItems?? && orderItems?has_content>
		            <#list orderItems as orderItem>
		                    <tr>
		                        <td>
		                        	<div class="goodsinfo">
								    <div class="goodspic">
								            <a href="${ctx}/admin/adminProduct/edit?id=${orderItem.productId!}">
								            	<img src="${(orderItem.productPicUrl)!}" style="width:80px;height: 80px" title="${orderItem.productName?default("")?html}" />
								            </a>
								    </div>
								    	<div class="goodsname">
								    		${orderItem.productName?default("")?html}
								    	</div>
									</div>
		                       </td>
		                        <td>
		                                                             ￥ ${(orderItem.salePrice)!0.0}
		                        </td>
		                        <td>${(orderItem.quantity)!0}</td>
		                        <td>￥ ${(orderItem.productTotal)!0.0}</td>
		                    </tr>
		               </#list>
        		</#if>
                <tr>
                    <!-- 商品总金额 -->
                    <td align="right" colspan="4">订单总额：￥${(one.orderTotalAmt)!0.0}
                        		，应付：￥${(one.orderPayAmt)!0.0}
                    </td>
                </tr>
                    <#if one.orderRemark?has_content && one.orderRemark != "">
                    <tr>
                        <!-- 给购货人看的备注信息 -->
                        <td align="left" colspan="4">备注：${(one.orderRemark)!?html}</td>
                    </tr>
                    </#if>
                </tbody>
            </table>
            <div style="text-align: center;margin-top:10px;" class="bottom-logo w_print">
                <div class="qianzi" style="text-align: center;">客户签字：<span>&nbsp;</span></div>
                <div style="text-align: center;">
                <#--<img height="40" src="../images/logo_print_gg.png" border="0" alt=""/>-->
                    <div style="min-height:20;"></div>
                </div>
                <div class="dd" style="text-align: center;">${companyAddress!}
                    <span id="siteName"></span>
                </div>
            </div>
        </div>
    </#list>
</#if>

    <script type="text/javascript">
       $(function () {

//        var basePath = window.location.protocol + "//" + window.location.host;
//        $.find("#siteName").text(window.location.host);
            $("div").find("span#siteName").each(function () {
                $(this).text(window.location.host);
            });

        });

    </script>
</div>