<#assign ctx = request.contextPath>
    <div class="cart-panel">
        <#if cartList?? && cartList?has_content>
        <div class="cart-info">
            <ul>
                <#list cartList as cartItem>
                    <li>
                        <div class="cart-img">
                            <a href="${ctx}/product/${cartItem.productId}"><img src="${cartItem.productPicUrl}" alt=""/></a>
                        </div>
                        <div class="cart-count">
                            <span class="price-real">¥<em>${cartItem.firstAddedSalePrice}</em></span>
                            <span>x${cartItem.quantity}</span>
                        </div>
                        <div class="cart-title">
                            <a href="${ctx}/product/${cartItem.productId}">${cartItem.productName}</a>
                        </div>
                        <#--<div class="cart-del"><a href="${ctx}/cart/delete">×</a></div>-->
                    </li>
                </#list>
            </ul>
        <#else>
            <div class="cart-tips">
                您的购物车还是空的哦，赶紧行动吧！
            </div>
        </#if>

            <div class="cart-ft">
                <div class="cart-total">
                    <p>总计: <strong>¥ ${total?default(0)?string(',##0.00')}</strong></p>
                </div>
                <div class="cart-btn">
                    <a href="${ctx}/cart/list.html"><span>结算</span></a>
                </div>
            </div>
        </div>
    </div>
<script>
    $(function(){
        $('#headCartCount').html('${productCount?default(0)}');
    })
</script>