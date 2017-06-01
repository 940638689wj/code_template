<#assign ctx = request.contextPath>

<div id="main">
    <div class="shoptb">
        <div class="shoptb-hd">
            <table>
                <tbody><tr>
                    <td class="td-select"></td>
                    <td class="td-product">商品</td>
                    <td class="td-price">单价</td>
                    <td class="td-amount">数量</td>
                    <td class="td-total">小计</td>
                    <td class="td-operate"></td>
                </tr>
                </tbody></table>
        </div>
        <div id="shoptbRow"></div>
        <#--
        <div class="shoptb-row">
            <table>
                <tbody>
                <tr>
                    <td class="td-select"><input type="checkbox"></td>
                    <td class="td-product">
                        <div class="first-column">
                            <div class="img"><a href="#"><img src="images/awardsGame.jpg"></a></div>
                            <div class="info">
                                <div class="name"><a href="../goods_detail.html" target="_blank">Genanx格男仕春季新款时尚潮流男士修身小西装</a></div>
                                <div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="td-price">￥127</td>
                    <td class="td-amount">
						<span class="amount-widget">
							<input type="text" class="textfield" value="1">
							<span class="increase increase-disabled"></span>
							<span class="decrease"></span>
						</span>
                        <span class="text-red">限购1件</span>
                    </td>
                    <td class="td-total">
                        <em>￥127 </em>
                    </td>
                    <td class="td-operate">
                        <a class="ico-recycle" href="javascript:void(0)" title="删除">删除</a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
        <div class="shoptb-row">
            <table>
                <tbody><tr>
                    <td class="td-select"><input type="checkbox"></td>
                    <td class="td-product">
                        <div class="first-column">
                            <div class="img"><a href="#"><img src="images/awardsGame.jpg"></a></div>
                            <div class="info">
                                <div class="name"><a href="../goods_detail.html" target="_blank">Genanx格男仕春季新款时尚潮流男士修身小西装</a></div>
                                <div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="td-price">￥127</td>
                    <td class="td-amount">
						<span class="amount-widget">
							<input type="text" class="textfield" value="1">
							<span class="increase"></span>
							<span class="decrease"></span>
						</span>
                    </td>
                    <td class="td-total">
                        <em>￥127 </em>
                    </td>
                    <td class="td-operate">
                        <a class="ico-recycle" href="javascript:void(0)" title="删除">删除</a>
                    </td>
                </tr>
                </tbody></table>
        </div>
        <div class="shoptb-row">
            <table>
                <tbody><tr>
                    <td class="td-select"><input type="checkbox"></td>
                    <td class="td-product">
                        <div class="first-column">
                            <div class="img"><a href="#"><img src="images/awardsGame.jpg"></a></div>
                            <div class="info">
                                <div class="name"><a href="../goods_detail.html" target="_blank">Genanx格男仕春季新款时尚潮流男士修身小西装</a></div>
                                <div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="td-price">￥127</td>
                    <td class="td-amount">
						<span class="amount-widget">
							<input type="text" class="textfield" value="1">
							<span class="increase"></span>
							<span class="decrease decrease-disabled"></span>
						</span>
                    </td>
                    <td class="td-total">
                        <em>￥127 </em>
                    </td>
                    <td class="td-operate">
                        <a class="ico-recycle" href="javascript:void(0)" title="删除">删除</a>
                    </td>
                </tr>
                </tbody></table>
        </div>
        <div class="shoptb-row">
            <table>
                <tbody><tr>
                    <td class="td-select"><input type="checkbox"></td>
                    <td class="td-product">
                        <div class="first-column">
                            <div class="img"><a href="#"><img src="images/awardsGame.jpg"></a></div>
                            <div class="info">
                                <div class="name"><a href="../goods_detail.html" target="_blank">Genanx格男仕春季新款时尚潮流男士修身小西装</a></div>
                                <div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="td-price">￥127</td>
                    <td class="td-amount">
						<span class="amount-widget">
							<input type="text" class="textfield" value="1">
							<span class="increase increase-disabled"></span>
							<span class="decrease"></span>
						</span>
                    </td>
                    <td class="td-total">
                        <em>￥127 </em>
                    </td>
                    <td class="td-operate">
                        <a class="ico-recycle" href="javascript:void(0)" title="删除">删除</a>
                    </td>
                </tr>
                </tbody></table>
        </div>-->

        <div class="shoptb-foot-wrap">
            <div class="shoptb-foot">
                <div class="tbft-l">
                    <ul>
                        <li><label><input type="checkbox" id="J_CheckAll"> &nbsp;全选</label></li>
                        <li><a href="javascript:void(0)" id="J_DeleteALL">删除</a></li>
                        <#--<li><a href="javascript:void(0)">移到收藏夹</a></li>-->
                    </ul>
                </div>
                <div class="tbft-r">
                    <div class="btn-buy btn-buy-disabled" id="buyNowDiv">
                        <a href="javascript:void(0)" id="buyNow"><span>立即结算</span></a>
                    </div>
                </div>
                <div class="tbft-total">
                    <ul>
                        <li>数量总计：<em id="totalQuantity">0</em> 件</li>
                        <li>总计（不含运费）：<span class="price-real">￥<em id="totalPrice">0.00</em></span></li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="shoptb-tiphd" id="unAvailableDesc">
            <#--以下商品已下架，不能购买（不计入结算）
            <div class="r"><a class="ico-recycle" href="javascript:void(0)" id="deleteAllUnAvailable">清除所有失效商品</a></div>
        	-->
        </div>
        <div id="unAvailableCartItemList"></div>
        <#--
        <div class="shoptb-row shoptb-disabled">
            <table>
                <tbody><tr>
                    <td class="td-select"><input type="checkbox"></td>
                    <td class="td-product">
                        <div class="first-column">
                            <div class="img"><a href="#"><img src="images/awardsGame.jpg"></a></div>
                            <div class="info">
                                <div class="name"><a href="../goods_detail.html" target="_blank">Genanx格男仕春季新款时尚潮流男士修身小西装</a></div>
                                <div class="prop"><span>颜色<em>黑色</em></span><span>尺码<em>M</em></span>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td class="td-price">￥127</td>
                    <td class="td-amount">

                    </td>
                    <td class="td-total">
                        <em>￥127 </em>
                    </td>
                    <td class="td-operate">
                        <a class="ico-recycle" href="javascript:void(0)" title="删除">删除</a>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>-->
    </div>

    <div class="pageinfo" <#if cartCount?? && cartCount gt 0>style="display: none;" <#else></#if>>
        <div class="shopcart-empty">
            <div class="extra">
                购物车商品为空，请&nbsp; <a href="${ctx}/index.html" class="btn-action">返回首页</a> &nbsp;挑选喜欢的商品
            </div>
        </div>
    </div>
</div>

<script>
    var flag = true;
    var cartList = $("#shoptbRow"),
        checkAllBtn = $("#J_CheckAll"),
        //unAvailableCartItemDiv = $("#unAvailableCartItemDiv"),
        unAvailableCartItemList = $("#unAvailableCartItemList"),
        deleteAllBtn = $("#J_DeleteALL"),
        unAvailableDesc = $('#unAvailableDesc'),
        buyNowBtn = $("#buyNow"),
        buyNowDiv = $('#buyNowDiv');

    $(function () {
        // 加载商品
        getShopCartList();

        // 数量改变事件
        $('#shoptbRow').on('change', '.quantity', function(){
            var quantity = 0;
            try{
                quantity = parseInt($(this).val());
                if(!quantity){
                    layer.msg('数量输入有误!');
                    getShopCartList();
                    return ;
                }
            }catch(e){
                layer.msg('数量输入有误!');
                getShopCartList();
                return ;
            }

            console.log("quantity==="+quantity);
            if(quantity == 999999 || !flag) {
                return;
            }
            if(quantity < 1 || !flag) {
            	layer.msg('数量不能小于1!');
                getShopCartList();
                return ;
            }

            var cartItemId = $(this).attr('data-cartItemId');
            var realStock = $(this).attr('data-realStock');
            if(quantity > realStock){
                layer.msg("所选商品数量已超过库存!");
                $('#quantity_'+cartItemId).val(realStock);
                quantity = realStock;
                updateShopCartList(cartItemId, quantity);
                return;
            }
            updateShopCartList(cartItemId, quantity);
        });
        $('#shoptbRow').on('keypress', 'input[data-cartItem-quantity]', function(ev){
            var keycode = (ev.keyCode ? ev.keyCode : ev.which);
            if (keycode == '13') {
                $(this).change();
            }
        });

        // 数量加事件
        $('#shoptbRow').on('click', '.increase', function(){
            if($(this).hasClass('increase-disabled')){
                return ;
            }

            var cartItemId = $(this).attr('data-cartItemId');
            var quantity = $('#quantity_'+cartItemId).val();
            var realStock = $('#quantity_'+cartItemId).attr('data-realStock');
            quantity = parseInt(quantity);
            if(quantity == 999999 || !flag) {
                return;
            }
            quantity++;
            if(quantity > realStock){
                layer.msg("所选商品数量已超过库存!");
                $('#quantity_'+cartItemId).val(realStock);
                quantity = realStock;
                updateShopCartList(cartItemId, quantity);
                return;
            }
            updateShopCartList(cartItemId, quantity);
        });

        // 数量减事件
        $('#shoptbRow').on('click', '.decrease', function(){
            if($(this).hasClass('increase-disabled')){
                return ;
            }

            var cartItemId = $(this).attr('data-cartItemId');
            var quantity = $('#quantity_'+cartItemId).val();
            quantity = parseInt(quantity);
            if(quantity == 1 || !flag) {
                return;
            }
            quantity--;

            updateShopCartList(cartItemId, quantity);
        });

        // 单个cartItem删除
        $('#shoptbRow,#unAvailableCartItemList').on('click', '.ico-recycle', function(){
            var cartItemId = $(this).attr('data-cartItemId');
            layer.confirm('确定要删除该商品吗?', {
                btn: ['确定','取消'] //按钮
            }, function(){
                deleteCartItem(cartItemId);
            }, function(){
                layer.closeAll();
            });
        });

        // 结算按钮
        buyNowBtn.on('click', function(){
            if(!flag) {//请求未成功时
                return;
            }
            flag = false;
            var ids = '';
            $("input[name='chk_item']").filter(":checked").each(function(i) {
                var cartItemId = $(this).attr('cartItemId');
                if(cartItemId) {
                    if(i == 0) {
                        //用户未登录时cartItemId为undefined；
                        ids += cartItemId;
                    } else {
                        ids += ',' + cartItemId;
                    }
                }
            });

            //如果立即结算的样式为禁用状态，那么，点击无效果
            if(buyNowDiv.hasClass('btn-buy-disabled')){
                return;
            }

            window.location.href = "${ctx}/cart/buyCart?ids=" + ids;
        });

        checkAllBtn.on("change", function () {
            if(!flag) {//请求未成功时
                return;
            }

            var checkboxes = cartList.find("input[type=checkbox]:not(:disabled)");
            if(this.checked){
                checkboxes.prop("checked",true);
            }else{
                checkboxes.prop("checked",false);
            }
            checkChange();
        });

        deleteAllBtn.on("click", function () {
            if(!flag) {//请求未成功时
                return;
            }

            var ids = "";
            $("input[type='checkbox']").filter(":checked").each(function(i) {
                if(i == 0) {
                    ids += $(this).attr('cartItemId');
                } else if($(this).attr('cartItemId')){
                    ids += ',' + $(this).attr('cartItemId');
                }
            });

            if(ids == ""){
                layer.msg('请选择需要删除的商品!');
                return ;
            }

            layer.confirm('确定要删除商品吗?', {
                btn: ['确定','取消'] //按钮
            }, function(){
                deleteCartItem(ids);
            }, function(){
                layer.closeAll();
            });
        });

		//删除所有失效的商品
		unAvailableDesc.on("click",'#deleteAllUnAvailable',function() {
			if(!flag) {//请求未成功时
                return;
            }
            
            var ids = "";
            $("#unAvailableCartItemList input[type='checkbox']").each(function(i) {
                if(i == 0) {
                    ids += $(this).attr('cartItemId');
                } else {
                    ids += ',' + $(this).attr('cartItemId');
                }
            });

            layer.confirm('确定要删除所有失效的商品吗?', {
                btn: ['确定','取消'] //按钮
            }, function(){
                deleteCartItem(ids);
            }, function(){
                layer.closeAll();
            });
		});
		
        cartList.on("change","input[type=checkbox]", function () {
            if(!flag) {//请求未成功时
                return;
            }

            checkChange();
        });

        var shopFoot = $(".shoptb-foot"),
                footTop = shopFoot.offset().top,
                footHeight = shopFoot.height();
        $(window).on("scroll", function (){
            var win = $(window),
                    t = win.scrollTop() + win.height() - footHeight;
            if(t < footTop){
                shopFoot.addClass("fixed");
            }else{
                shopFoot.removeClass("fixed");
            }
        });
    });

    function deleteCartItem(ids){
        if(!flag) {//请求未成功时
            return;
        }

        flag=false;
        $.ajax({
            url  : '${ctx}/cart/delete',
            async : true,
            type : "GET",
            dataType : "json",
            data : {"ids" : ids},
            success : function(result) {
                flag=true;
                if(result.result == 'success') {
                    layer.msg('已删除所选记录');
                    getShopCartList ();
                }
            },
            error:function(XMLHttpResponse ){
                flag=true;
                console.log("请求未成功");
            }
        });
    }

    // 加载商品
    function getShopCartList(){
        flag=false;

        $.ajax({
            url : '${ctx}/cart/shopCartList',
            async : true,
            dataType : 'json',
            type: 'GET',
            data : {},
            success : function(result) {
                flag=true;
                if(result) {
                    shopCartList(result.cart, result.total);

                    //如果没有商品
                    if(result.cart.length == 0) {
                        $('.shoptb').hide();
                        $('.pageinfo').show();
                    }else{
                        $('.pageinfo').hide();
                        $('.shoptb').show();
                    }

                    //如果商品全部选中就把全选设为选中状态
                    var checkboxes = cartList.find("input[type=checkbox]");
                    var checkCount = cartList.find("input:checked");
                    if(checkCount.length == checkboxes.length && checkCount.length != 0){
                        checkAllBtn.prop("checked",true);
                    }else{
                        checkAllBtn.prop("checked",false);
                    }
                } else {
                    cartList.empty();//清空列表
                    $('#totalPrice').empty();//清空总额
                    $('#totalPrice').append('0.00');
                }
            },
            error:function(XMLHttpResponse ){
                flag=true;
                console.log("请求未成功");
            }
        });
    }

    //处理购物车数据，并添加到页面上
    function shopCartList(cartResult,total) {
        cartList.empty();//清空列表
        //unAvailableCartItemDiv.hide();
        unAvailableCartItemList.empty();//清空列表

        $('#totalPrice').empty();//清空总价格

        var cartItemId = '';
        var productId = '';
        var productName = '';//产品名称
        var tagPrice = '';//吊牌价
        var firstAddedSalePrice = '';//首次加入购物车的价格
        var subtotal = '';//商品小计
        var quantity = '';//数量
        var isSelected = '';//是否选中
        var productPicUrl = '';//产品图片地址
        var promotionId = '';//活动id
        var promotionDiscountRuleId = '';//活动规则id
        var personLimitNum = '';//限购数
        var isShowTagPriceText = '';//是否显示“挂牌金额”字眼
        var checked = '';
        var isSelectNum = 0;
        var selectTotalQuantity = 0;
        var realStock = 0;//库存
        var promotionDiscountDesc = '';//活动描述
        var skuValue = '';//sku描述
        var masterProductId = '';//主商品Id

        for(var i = 0; i < cartResult.length; i++) {
            cartItemId = cartResult[i].cartItemId;
            productId = cartResult[i].productId;
            productName = cartResult[i].productName;//产品名称
            tagPrice = rendererZhMoney(cartResult[i].tagPrice);//吊牌价
            firstAddedSalePrice = rendererZhMoney(cartResult[i].firstAddedSalePrice);//首次加入购物车的价格
            subtotal = rendererZhMoney(cartResult[i].subtotal);//商品小计
            quantity = cartResult[i].quantity;//数量
            isSelected = cartResult[i].isSelected;//是否选中
            productPicUrl = cartResult[i].productPicUrl;//产品图片地址
            personLimitNum = cartResult[i].personLimitNum;//限购数
            isShowTagPriceText = cartResult[i].isShowTagPriceText;//是否显示“挂牌金额”字眼
            var isAvailable = cartResult[i].isAvailable;
			realStock = cartResult[i].realStock;
			promotionDiscountDesc = cartResult[i].promotionDiscountDesc;

            if(cartResult[i].skuValue != undefined){
                skuValue = cartResult[i].skuValue;
            }else{
                skuValue = "";
            }

			masterProductId = cartResult[i].masterProductId;

            if(isSelected && isSelected == 1 && isAvailable) {
                checked = "checked";
                isSelectNum ++;
                selectTotalQuantity = selectTotalQuantity + quantity;
            } else {
                checked = "";
            }

            var contentStr = '';
            if(isAvailable){
                contentStr +='<div class="shoptb-row">';
		        contentStr +='    <table>';
		        contentStr +='        <tbody>';
		        contentStr +='        <tr>';
		        contentStr +='            <td class="td-select"><input type="checkbox" ' + checked + ' cartItemId="'+cartItemId+'"></td>';
		        contentStr +='            <td class="td-product">';
		        contentStr +='                <div class="first-column">';
		        contentStr +='                    <div class="img"><a href="/product/'+masterProductId+'"><img src="'+productPicUrl+'"></a></div>';
		        contentStr +='                    <div class="info">';
		        contentStr +='                        <div class="name"><a href="/product/'+masterProductId+'" target="_blank">'+productName+'</a></div>';
		        contentStr +='                        <div class="prop"><span>'+skuValue+'</span>';
		        contentStr +='                        </div>';
		        contentStr +='                    </div>';
		        contentStr +='                </div>';
		        contentStr +='            </td>';
		        contentStr +='            <td class="td-price">￥'+firstAddedSalePrice+'</td>';
		        contentStr +='            <td class="td-amount">';
				contentStr +='				<span class="amount-widget">';
				contentStr +='					<input type="text" class="textfield quantity" id="quantity_'+cartItemId+'" data-cartItemId="'+cartItemId+'" data-realStock="'+realStock+'" value="'+quantity+'">';
				if(quantity > 1) {
					contentStr +='					<span data-cartItemId="'+cartItemId+'" class="increase"></span>';
					contentStr +='					<span data-cartItemId="'+cartItemId+'" class="decrease"></span>';
				} else {
					contentStr +='					<span data-cartItemId="'+cartItemId+'" class="increase"></span>';
					contentStr +='					<span data-cartItemId="'+cartItemId+'" class="decrease decrease-disabled"></span>';
				}
				contentStr +='				</span>';
		        contentStr +='                <span class="text-red" data-realStock="'+realStock+'">库存'+realStock+'件</span>';
		        contentStr +='            </td>';
		        contentStr +='            <td class="td-total">';
		        contentStr +='                <em>￥'+subtotal+' </em>';
		        contentStr +='            </td>';
		        contentStr +='            <td class="td-operate">';
		        contentStr +='                <a class="ico-recycle" data-cartItemId="'+cartItemId+'" href="javascript:void(0)" title="删除">删除</a>';
		        contentStr +='            </td>';
		        contentStr +='        </tr>';
		        contentStr +='        </tbody>';
		        contentStr +='    </table>';
		        contentStr +='</div>';
		        
		        cartList.append(contentStr);//把购物车中商品数据添加到当前标签中
            }else{
	            contentStr +='<div class="shoptb-row shoptb-disabled">';
		        contentStr +='    <table>';
		        contentStr +='        <tbody><tr>';
		        contentStr +='            <td class="td-select"><input type="checkbox" cartItemId="'+cartItemId+'"></td>';
		        contentStr +='            <td class="td-product">';
		        contentStr +='                <div class="first-column">';
		        contentStr +='                    <div class="img"><a href="javascript:void(0)"><img src="'+productPicUrl+'"></a></div>';
		        contentStr +='                    <div class="info">';
		        contentStr +='                        <div class="name"><a href="javascript:void(0)" target="_blank">'+productName+'</a></div>';
		        contentStr +='                        <div class="prop"><span>'+skuValue+'</span>';
		        contentStr +='                        </div>';
		        contentStr +='                    </div>';
		        contentStr +='                </div>';
		        contentStr +='            </td>';
		        contentStr +='            <td class="td-price">￥'+firstAddedSalePrice+'</td>';
		        contentStr +='            <td class="td-amount">';
		        contentStr +='				<span class="amount-widget">';
				contentStr +='					<input type="text" readonly class="textfield quantity" value="'+quantity+'">';
				contentStr +='					<span class="increase increase-disabled"></span>';
				contentStr +='					<span class="decrease decrease-disabled"></span>';
				contentStr +='				</span>';
		        contentStr +='            </td>';
		        contentStr +='            <td class="td-total">';
		        contentStr +='                <em>￥'+subtotal+' </em>';
		        contentStr +='            </td>';
		        contentStr +='            <td class="td-operate">';
		        contentStr +='                <a class="ico-recycle" data-cartItemId="'+cartItemId+'" href="javascript:void(0)" title="删除">删除</a>';
		        contentStr +='            </td>';
		        contentStr +='        </tr>';
		        contentStr +='        </tbody>';
		        contentStr +='    </table>';
		        contentStr +='</div>';
		        
		        unAvailableCartItemList.append(contentStr);
            }
        }

        if(isSelectNum > 0) {
            buyNowDiv.removeClass('btn-buy-disabled');
        }else{
            buyNowDiv.addClass('btn-buy-disabled');
        }
        
        if($('.shoptb-disabled').length > 0) {
        	unAvailableDesc.html('以下商品已下架，不能购买（不计入结算）<div class="r"><a class="ico-recycle" href="javascript:void(0)" id="deleteAllUnAvailable">清除所有失效商品</a></div>');
        }

        $('#totalPrice').html(rendererZhMoney(total));
        $("#totalQuantity").html(selectTotalQuantity);
    }

    //更新购物车数据
    function updateShopCartList (id,num) {
        if(id == undefined) {
            id = '';
        }
        flag=false;
        $.ajax({
            url  : '${ctx}/cart/update',
            async : true,
            type : "GET",
            dataType : "json",
            data : {"cartItemId" : id, "quantity" : num},
            success : function(result) {
                flag=true;
                if(result.result == 'success') {
                    getShopCartList ();
                    //如果商品未选中把全选和立即结算都变灰
                    var checkboxes = cartList.find("input[type=checkbox]");
                    if(checkboxes.length == 0) {
                        buyNowDiv.addClass('btn-buy-disabled');
                    }
                } else {
                    if(result.message) {
                        layer.msg(result.message);
                    }
                }
            },
            error:function(XMLHttpResponse ){
                flag=true;
                console.log("请求未成功");
            }
        });
    }

    //改变选中状态
    function checkChange(){
        var checkboxes = cartList.find("input[type=checkbox]:not(:disabled)"),
                noChecked = true,
                checkCount = 0;
        var selectedCartItemId = '';

        checkboxes.each(function () {
            if(this.checked == true){
                if(checkCount == 0){
                    selectedCartItemId += $(this).attr('cartItemId');
                } else {
                    selectedCartItemId += ','+$(this).attr('cartItemId');
                }

                noChecked = false;
                checkCount++;
            }
        });

        flag=false;
        $.ajax({
            url  : '${ctx}/cart/updateIsSelected',
            async : true,
            type : "GET",
            dataType : "json",
            data : {"selectedCartItemId" : selectedCartItemId},
            success : function(result) {
                flag=true;
                if(result.result == 'success') {
                    if(noChecked){
                        buyNowDiv.addClass('btn-buy-disabled');
                    }else{
                        buyNowDiv.removeClass('btn-buy-disabled');
                    }

                    if(checkCount == checkboxes.length){
                        checkAllBtn.prop("checked",true);
                    }else{
                        checkAllBtn.prop("checked",false);
                    }

                    getShopCartList ();
                }
            },
            error:function(XMLHttpResponse ){
                flag=true;
                console.log("请求未成功");
            }
        });
    }

    //金额格式化
    function rendererZhMoney(v) {
        if(isNaN(v)){
            return v;
        }
        v = (Math.round((v - 0) * 100)) / 100;
        v = (v == Math.floor(v)) ? v + ".00" : ((v * 10 == Math.floor(v * 10)) ? v
        + "0" : v);
        v = String(v);
        var ps = v.split('.');
        var whole = ps[0];
        var sub = ps[1] ? '.' + ps[1] : '.00';
        var r = /(\d+)(\d{3})/;
        while (r.test(whole)) {
            whole = whole.replace(r, '$1' + ',' + '$2');
        }
        v = whole + sub;

        return v;
    }
</script>