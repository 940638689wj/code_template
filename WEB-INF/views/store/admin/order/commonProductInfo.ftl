<div>
	   <#if orderItems?has_content>
<table cellspacing="0" class="table table-bordered table-striped">
      <caption>商品清单</caption>
        <thead>
            <tr>
                <th>商品</th>
                <th>单价</th>
                <th>数量</th>
                <th>重量</th>
                <th>优惠</th>
                <th>小计</th>
               
            </tr>
        </thead>
            <tbody>
            <#list orderItems as orderItem> 
                    <tr>
                        <td>${orderItem.productName!}</td>
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
                        <td><#if orderItem.productDiscountAmt??>￥-${orderItem.productDiscountAmt!}<#else>0</#if></td>
                        <#if orderItem.productDiscountAmt??>
                        <td>￥${orderItem.productTotal-orderItem.productDiscountAmt}</td>
                        <#else>
                        <td>￥${orderItem.productTotal!}</td>
                        </#if>
                       
                    </tr>
             </#list>  
        </tbody>
        </table> 
            </#if>       
        
            <#if orderDishes?has_content>
        <table cellspacing="0" class="table table-bordered table-striped">
      <caption>菜品清单</caption>
        <thead>
            <tr>
                <th>菜品 </th>
                <th>单价</th>
               	<th>数量</th>
                <th>重量</th>
                <th>优惠</th>
                <th>小计</th>
              
            </tr>
        </thead>
            <tbody>
            <#list orderDishes as orderDishe> 
                    <tr>
                        <td>${orderDishe.productName!}</td>
                        <td>${orderDishe.salePrice!}</td>
                        <td>${orderDishe.quantity!}</td>
                        <td>${orderDishe.productWeight!}&nbsp&nbsp
                        <#if orderDishe.productWeight??>
                        <#if orderDishe.productWeightUnitCd==1>
                       g(克)
                       <#elseif orderDishe.productWeightUnitCd==2>
                       kg(千克)
                       <#else>
                       t(吨)
                       </#if>
                       </#if>
                        </td>
                        <td><#if orderDishe.productDiscountAmt??>￥-${orderDishe.productDiscountAmt!}<#else>0</#if></td>
                        <#if orderDishe.productDiscountAmt??>
                        <td>￥${orderDishe.productTotal-orderDishe.productDiscountAmt}</td>
                        <#else>
                        <td>￥${orderDishe.productTotal!}</td>
                        </#if>
                    </tr>
             </#list>  
        </tbody>
        </table> 
            </#if> 
</div>




