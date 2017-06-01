<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${staticPath}/js/lodop/LodopFuncs.js"></script>  
    <object id="LODOP_OB" classid="clsid:2105C259-1E0C-4534-8141-A753534CB4CA" width=0 height=0>   
    <embed id="LODOP_EM" type="application/x-print-lodop" width=0 height=0></embed>  
</object>     
</head>
<body onLoad="javascript:MyPREVIEW();">
            <div>
                数据加载中，请稍等！
            </div>

<#if orderList??>
    <#list orderList as one>
<div id="div_${one_index}" class="hide">
<table cellspacing="0" class="table table-info">
    <caption>订单信息</caption>
    <tr>
        <th>订单编号：</th>
        <td>${one.orderNumber!}</td>
        <th>收货人：</th>
        <td>${one.receiveName!}</td>
    </tr>
        <tr>
            <th>联系方式：</th>
            <td>${one.receiveTel!}</td>
            <th>收货地址：</th>
            <td>${one.receiveAddrCombo!}</td>
        </tr>

        <tr>
            <th>下单时间：</th>
            <td>
            ${(one.createTime?string("yyyy-MM-dd HH:MM:ss"))!}
            </td>
            <th>买家留言：</th>
            <td>${one.orderRemark!}</td>
            
       </tr>
</table> 


<table cellspacing="0" class="table table-bordered table-striped" width="600" >
      <caption>商品清单</caption>
       <thead>
            <tr>
                <th>商品名称</th>
                <th>商品单价</th>
                <th>商品数量</th>
                <th>小计</th>
            </tr>
       <thead>
            <tbody> 
            
		<#list itemMap?keys as mKey>
			 <#if mKey="${one.orderId}">
			  <#assign items = itemMap[mKey]>   
			      <#list items as itemValue>
			  
              <tr>
                        <td style="vertical-align:middle; text-align:center;">${itemValue.productName}</td>
                        <td style="vertical-align:middle; text-align:center;">￥${itemValue.salePrice}</td>
                        <td style="vertical-align:middle; text-align:center;">${itemValue.quantity}</td>
                        <td style="vertical-align:middle; text-align:center;">￥${itemValue.productTotal}</td>
              </tr>
			     </#list>
			     </#if>
			   </#list>
             
         
            </tbody>  
</table> 
       
 
<table cellspacing="0" class="table table-info" width="600">
    <caption>订单金额</caption>
    <tr>
        <th>订单总价(包含邮费)：</th>
        <td>￥${one.orderTotalAmt!}</td>
        <th>订单优惠：</th>
        <td>￥<#if one.orderDiscountAmt ??>${one.orderDiscountAmt}<#else>0.00</#if></td>
        <th>应付金额：</th>
        <td>￥${one.orderPayAmt!}</td>
     </tr>
</table> 
</div>
   </#list>
        </#if>

<script type="text/javascript">  
   function MyPREVIEW() {	
           var size = ${orderList?size};
  			LODOP = getLodop();  
			LODOP.PRINT_INIT("中文学位证书打印");
			LODOP.SET_PRINT_STYLE("FontSize",16);
			LODOP.SET_PRINT_STYLE("Bold",1);	
			for (j = 0; j < size; j++) {
				CreatePrintPage(j);	
			};		
			LODOP.SET_PREVIEW_WINDOW(0,0,0,0,0,"");			
			LODOP.PREVIEW();
			window.close();
	 };	
	 
    function CreatePrintPage(id) { 
        LODOP.NewPage();
        var strHTML= $('#div_'+id).html();
        var strStyleCSS="<link href='print.css' type='text/css' rel='stylesheet'>";
        var strFormHtml=strStyleCSS+"<body>"+strHTML+"</body>";
        LODOP.ADD_PRINT_HTM(0,0,"100%","100%",strFormHtml);
    };    
</script> 
</body>
</html>  