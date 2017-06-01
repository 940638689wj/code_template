<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <title>购物车</title>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        <h1 class="mui-title">购物车</h1>
        <a class="mui-icon" id="J_EditBtn"><span>编辑</span></a>
    </header>
    <div class="mui-content">
    	<div class="iconinfo" style="display:none">
            <i class="ico ico-shopcart"></i>
            <strong>购物车还空着</strong>
            <p>去选几件中意的商品吧</p>
            <div class="btnbar">
                <a href="${ctx}/m" class="mui-btn mui-btn-block mui-btn-primary">去购物</a>
            </div>
        </div>
        <div class="cart-list">
			<ul class="cartItemList">

			</ul>
        </div>

        <div id="unAvailableCartItemDiv" style="display: none;" class="cart-list cart-list-oos">
            <div class="prd-list-title">
                <span class="orange">以下商品已下架或删除，不能购买</span>
            </div>
            <ul id="unAvailableCartItemList">
                <#--<li>
                    <label>
						<input type="checkbox" name="chk_item" disabled>
					</label>
                    <div class="pic">
						<a href="#">
							<img class="lazyload" src="/static/mobile/images/blank.gif" data-src="images/goodspic.jpg" alt=""/>
						</a>
					</div>
                    <div class="intro">
                        <div class="name">
							<a href="#">产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称产品名称</a>
						</div>
                        <div class="price">
                            <div class="number-widget">
                                <div class="number-minus disabled"></div>
                                <input class="number-text" type="number" value="1" disabled>
                                <div class="number-plus disabled"></div>
                            </div>
                            <div class="price-real">¥<span>6.90</span></div>
                        </div>
                    </div>
                </li>-->
            </ul>
        </div>

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in content-cartwrap-in">
                        <div class="l"><label><input id="J_CheckAll" type="checkbox">全选</label></div>
                        <div class="r">合计：</div>
                        <div class="r">
                            <div class="main-info" id="total"><span>¥<em>00.00</em></span></div>
                            <div class="extra-info">不含配送费</div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap button-wrap-disabled cash-buttons">
                    <a id="J_ButtonCash" class="button" href="javascript:void(0)">结算(0)</a>
                </div>
                <div class="button-wrap button-wrap-disabled edit-buttons">
                    <a id="J_ButtonDel" class="button" href="javascript:void(0)">删除</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $(function(){
    	var flag = true;
    	
    	getShopCartList ();
    	
        imglazyload();
        var isEditAll = false,
            unAvailableCartItemDiv = $("#unAvailableCartItemDiv"),
            editBtn = $("#J_EditBtn"),
            checkAllBtn = $("#J_CheckAll"),
			unAvailableCartItemList = $("#unAvailableCartItemList"),
            cartList = $(".cartItemList");

        editBtn.on("click", function () {
            if(isEditAll){
                this.innerHTML = '<span>编辑</span>';
                isEditAll = false;

                unAvailableCartItemList.find("input[type=checkbox]").prop("checked",false);
                unAvailableCartItemList.find("input[type=checkbox]").prop("disabled",true);

                getShopCartList();
            }else{
                this.innerHTML = '<span>完成</span>';
                isEditAll = true;
                unAvailableCartItemList.find("input[type=checkbox]").prop("disabled",false);
            }
            $(".ftbtnbar").toggleClass("editing");
        });


        cartList.on("change","input[type=checkbox]", function () {
        	if(!flag) {//请求未成功时
        		return;
            }
            
            checkChange();
        });
        
         unAvailableCartItemList.on("change","input[type=checkbox]", function () {
        	if(!flag) {//请求未成功时
        		return;
            }
            
            checkChange();
        });

        checkAllBtn.on("change", function () {
        	if(!flag) {//请求未成功时
        		return;
            }
            
            var checkboxes = cartList.find("input[type=checkbox]:not(:disabled)");
            if(isEditAll){
				// 在编辑区域时 点击全选，要包含 不可用的商品
                checkboxes = $("input[name='chk_item']");
			}

            if(this.checked){
                checkboxes.prop("checked",true);
            }else{
                checkboxes.prop("checked",false);
            }

            checkChange();
        });

		//删除操作
        $("#J_ButtonDel").on("click",function(){
            if($(this).parent().hasClass("button-wrap-disabled")) return;
            var btnArray = ['确认', '关闭'];
            mui.confirm('', '确认要删除所选商品吗？', btnArray, function(e) {
                if (e.index == 0) {
                	var ids = "";
                	$("input[name='chk_item']").filter(":checked").each(function(i) {
                		if(i == 0) {
                			ids += $(this).parent().parent().find('.cartItemId').val();
                		} else {
                			ids += ',' + $(this).parent().parent().find('.cartItemId').val();
                		}
                	});
                	flag=false;
                	$.ajax({
                		url  : '${ctx}/m/cart/delete',
                    	async : true,
                    	type : "GET",
            			dataType : "json",
            			data : {"ids" : ids},
            			success : function(result) {
            				flag=true;
            				if(result.result == 'success') {
            					mui.toast('已删除所选商品');
            					$(".edit-buttons").removeClass("button-wrap-disabled").addClass("button-wrap-disabled");
            					getShopCartList ();
            				}
            			},
            			error:function(XMLHttpResponse ){
            				flag=true;
            				console.log("请求未成功");
            			}
                	});
                }
            })
        })

		//改变选中状态
        function checkChange(){
            var checkboxes = $("input[name='chk_item']:not(:disabled)"),
                    noChecked = true,
                    checkCount = 0,
                    buttonGroups = $(".ftbtnbar .button-wrap");
            var selectedCartItemId = ''; 
            
            checkboxes.each(function () {
                if(this.checked == true){
                	if(checkCount == 0){
	                    selectedCartItemId += $(this).parent().parent().find('.cartItemId').val();
                	} else {
                		selectedCartItemId += ','+$(this).parent().parent().find('.cartItemId').val();
                	}
                
                    noChecked = false;
                    checkCount++;
                }
            });
            console.log(selectedCartItemId);
            console.log(checkCount);

            flag=false;
            $.ajax({
        		url  : '${ctx}/m/cart/updateIsSelected',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"selectedCartItemId" : selectedCartItemId},
    			success : function(result) {
    				flag=true;
    				if(result.result == 'success') {
	    				if(noChecked){
			                buttonGroups.addClass("button-wrap-disabled");
			            }else{
			                buttonGroups.removeClass("button-wrap-disabled");
			            }
			            if(checkCount == checkboxes.length){
			                checkAllBtn.prop("checked",true);
			            }else{
			                checkAllBtn.prop("checked",false);
			            }

						if(!isEditAll){
							// 正在编辑时 点击checkbox不触发重新加载列表
                            getShopCartList ();
						}
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flag=true;
    				console.log("请求未成功");
    			}
        	});
        }
        
        //加载购物车数据
        function getShopCartList () {
        	flag=false;
        	$.ajax({
            	url  : '${ctx}/m/cart/shopCartList',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			success : function(result) {
    				flag=true;
    				if(result) {
    					shopCartList(result.cart, result.total);
    					
    					//如果没有商品
    					if($('.cartItemList li').length == 0) {
                            checkAllBtn.prop("disabled",true);
							if($('#unAvailableCartItemList li').length == 0){
                                $('.iconinfo').show();
                                //checkAllBtn.attr("disabled",true);
							}else{
                                $('.iconinfo').hide();
                                //checkAllBtn.attr("disabled",true);
							}
    					}else{
    						$('.iconinfo').hide();
    						//checkAllBtn.attr("disabled",false);
    						checkAllBtn.prop("disabled",false);
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
    					$('.main-info').empty();//清空总额
    					$('.main-info').append('<span>¥ <em>0.00</em></span>');
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
            unAvailableCartItemDiv.hide();
            unAvailableCartItemList.empty();//清空列表
        	$('#couponList').empty();//清空优惠券列表
        	$('.main-info').empty();//清空总价格
        	
        	var cartItemId = '';
    		var productId = '';
    		var productName = '';//产品名称
    		var tagPrice = '';//吊牌价
    		var firstAddedSalePrice = '';//首次加入购物车的价格
    		var quantity = '';//数量
    		var isSelected = '';//是否选中
    		var productPicUrl = '';//产品图片地址
    		var promotionId = '';//活动id
    		var promotionDiscountRuleId = '';//活动规则id
    		var personLimitNum = '';//限购数
    		var isShowTagPriceText = '';//是否显示“挂牌金额”字眼
    		var checked = '';
    		var isSelectNum = 0;
    		var realStock = '';   //库存
    		var promotionDiscountDesc = '';//活动描述
    		var skuValue = '';//sku文字描述
    		var masterProductId = '';//主商品Id
        		
			for(var i = 0; i < cartResult.length; i++) {
        		cartItemId = cartResult[i].cartItemId;
        		productId = cartResult[i].productId;
        		productName = cartResult[i].productName;//产品名称
        		tagPrice = rendererZhMoney(cartResult[i].tagPrice);//吊牌价
        		firstAddedSalePrice = rendererZhMoney(cartResult[i].firstAddedSalePrice);//首次加入购物车的价格
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
        		} else {
        			checked = "";
        		}
        		var li = '<li>';

				if(isAvailable){
                    li +='	<label><input type="checkbox" '+checked+' name="chk_item"></label>';
                    li +='	<div class="pic"><a href="${ctx}/m/product/'+masterProductId+'"><img class="lazyload" src="'+ productPicUrl +'" data-src="images/goodspic.jpg" alt=""/></a></div>';
                    li +='	<div class="intro">';
                    li +='		<div class="name">';
                    if(promotionDiscountDesc) {
                    	li +='			<span>' + promotionDiscountDesc + '</span>';
                    }
                    li +='			<a href="${ctx}/m/product/'+masterProductId+'">'+productName+'</a>';
                    li +='		</div>';
                    li +='		<p>'+skuValue+'</p>';
                    li +='		<div class="price">';
                    li +='			<div class="number-widget">';
                    li +='				<div class="number-minus disabled"></div>';
                    li +='				<input class="number-text" type="number" value="'+quantity+'">';
                    li +='				<div class="number-plus"></div>';
                    li +='				<input type="hidden" value="'+cartItemId+'" class="cartItemId">';
                    li +='				<input type="hidden" value="'+quantity+'" class="quantity">';
                    li +='				<input type="hidden" value="'+realStock+'" class="realStock">';
                    li +='			</div>';
                    li +='			<div class="price-real">¥<span>'+firstAddedSalePrice+'</span></div>';
                    li +='		</div>';
                    li +='		<div class="purchasing">库存：' + realStock + '</div>';
                    li +='	</div>';
                    li +='</li>';
				}else{
                    li +='	<label><input type="checkbox" '+checked+' name="chk_item" disabled></label>';
                    li +='	<div class="pic"><a href="javascript:void(0)"><img class="lazyload" src="'+ productPicUrl +'" data-src="images/goodspic.jpg" alt=""/></a></div>';
                    li +='	<div class="intro">';
                    li +='		<div class="name"><a href="javascript:void(0)">'+productName+'</a></div>';
                    li +='		<p>'+skuValue+'</p>';
                    li +='		<div class="price">';
                    li +='			<div class="number-widget">';
                    li +='				<div class="number-minus disabled"></div>';

                    li +='				<input class="number-text" type="number" value="'+quantity+'" disabled>';

                    li +='				<div class="number-plus disabled"></div>';

                    li +='				<input type="hidden" value="'+cartItemId+'" class="cartItemId">';
                    li +='				<input type="hidden" value="'+quantity+'" class="quantity">';
                    li +='			</div>';
                    li +='			<div class="price-real">¥<span>'+firstAddedSalePrice+'</span></div>';
                    li +='		</div>';
                    li +='	</div>';
                    li +='</li>';
				}

				if(isAvailable){
                    cartList.append(li);//把购物车中商品数据添加到当前标签中
				}else{
                    unAvailableCartItemDiv.show();
					unAvailableCartItemList.append(li);
				}
            }

            if(isSelectNum > 0) {
        		$('.button-wrap').removeClass('button-wrap-disabled');
        	}
        	$('#total').html('<span>¥<em>'+rendererZhMoney(total)+'</em></span>');
        	$("#J_ButtonCash").html('结算('+ isSelectNum +')');
        }
        
        //加数量
        cartList.on('click','.number-plus',function() {
        	var number = $(this).parent().find('.number-text').val();
        	if(number == 999999 || !flag) {
        		return;
        	}
        	var limit =  $(this).parent().find('.realStock').val();
        	console.log(limit)
        	if(parseInt(number)>=parseInt(limit)){
        	  mui.toast('商品无库存了！');
        	  return;
        	}
        	number++;
        	
        	var id = $(this).parent().find('.cartItemId').val();
        	updateShopCartList(id, number);
        });
        
       
        
        //减数量
        cartList.on('click','.number-minus',function() {
        	var number = $(this).parent().find('.number-text').val();
        	if(number == 1 || !flag) {
        		return;
        	}
        	
        	var id = $(this).parent().find('.cartItemId').val();
        	number--;
        	updateShopCartList(id, number);
        	
        });
        
        //直接改变商品的数量
        cartList.on('change','.number-text',function() {
    		if(!flag) { return; }
    		var num = $(this).val();
        	var id = $(this).parent().find('.cartItemId').val();
        	var productId = $(this).parent().parent().parent().data("productId");
    		//var cartData = shopCartData();
    		var shopnum = $(this).parent().find('.quantity').val();//原有数量
    		//var personlimitnum = $(this).parent().parent().parent().find('.purchasing').data('personlimitnum');//限购数
    		 var limit =  $(this).parent().find('.realStock').val();
    		var reg = new RegExp("^[1-9][0-9]*$"); 
        	if(!reg.test(num)){  
        		//还原原来的数量
        		$(this).val(shopnum);
		        mui.toast('商品数量只能输入正整数！');
		        return;
		    } 
		    if(parseInt(num)>limit){
		    mui.toast("商品库存不足！");
				$('.number-text').val(shopnum);
				return;
		    }
		    if(parseInt(num) > 99999) {
		    	mui.toast("商品的购买数量不能超过99999");
				$('.number-text').val(shopnum);
				return;
		    }
		    /*
		    if(personlimitnum && parseInt(personlimitnum) < parseInt(num)) {
		    	//还原原来的数量
        		$(this).val(personlimitnum);
		        mui.toast('你购买的数量已超过限购数！');
		        return;
		    }
		    */
		    
    		updateShopCartList (id,num,productId);
        });
        
        //更新购物车数据
        function updateShopCartList (id,num) {
        	if(id == undefined) {
        		id = '';
        	}
        	flag=false;
        	$.ajax({
            	url  : '${ctx}/m/cart/update',
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
	    					$(".ftbtnbar .button-wrap a").removeClass("button-wrap-disabled").addClass("button-wrap-disabled");
	    					$("#J_CheckAll").prop("checked",false);
    					}
    				} else {
    					if(result.message) {
	    					mui.toast(result.message);
    					}
    				}
    			},
    			error:function(XMLHttpResponse ){
    				flag=true;
    				console.log("请求未成功");
    			}
            }); 
        }
        
        //结算
        $('#J_ButtonCash').on('click',function() {
        	var ids = '';
        	if(!flag) { return; }
        	$("input[name='chk_item']").filter(":checked").each(function(i) {
        		var cartItemId = $(this).parent().parent().find('.cartItemId').val();
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
        	var isClick = $(this).parent().is('.button-wrap-disabled');
        	if(isClick) {
        		return;
        	}

        	window.location.href = "${ctx}/m/cart/buyCart?ids=" + ids;
        });
        
        
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
    })
</script>
</body>
</html>