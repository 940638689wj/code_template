<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">

<!doctype html>
<html>
<head>
    <title>购物车</title>
</head>
<body>
    <div id="page">
			<header class="mui-bar mui-bar-nav">
            	<a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
            		<h1 class="mui-title" id="a">购物车</h1> 
           	 	<a class="mui-icon" id="J_EditBtn"><span>编辑</span></a>
 	       	</header>
 
        <div class="mui-content">
            <div class="toptip">
                <div>友情提示：只有存在有相同支付方式的商品才能一起结算！</div>
            </div>
            <div class="borderbox">
            	<!--
                <div class="prd-list-title">
                    <i class="ico-promote-solid">促</i>全场：购物满5000减200，包邮
                </div>
                -->
                <ul class="prd-list cart-list checklist">
                <!-- 
                    <li>
                        <label><input type="checkbox" name="chk_item"></label>
                        <div class="pic"><a href="#"><img src="images/goodspic.jpg"></a></div>
                        <h3><a href="#">耐克正品 2013新款FREE 5.0赤足系列男子跑步鞋 536840-003 YK</a></h3>
                        <div class="price-origin-cart">￥398.00</div>
                        <div class="price">
                            <div class="number-widget number-widget-cart">
                                <input class="number-text" type="text" value="1">
                                <div class="number-minus"></div>
                                <div class="number-plus"></div>
                            </div>
                            <span class="price-real">￥<em>1290.00</em></span>
                        </div>
                        <div class="purchasing">限购10件</div>
                    </li>
                    <li>
                        <label><input type="checkbox" name="chk_item"></label>
                        <div class="pic"><a href="#"><img src="images/goodspic.jpg"></a></div>
                        <h3><a href="#">耐克正品 2013新款FREE 5.0赤足系列男子跑步鞋 536840-003 YK</a></h3>
                        <div class="price-origin-cart">￥398.00</div>
                        <div class="price">
                            <div class="number-widget number-widget-cart">
                                <input class="number-text" type="text" value="1">
                                <div class="number-minus"></div>
                                <div class="number-plus"></div>
                            </div>
                            <span class="price-real">￥<em>1290.00</em></span>
                        </div>
                    </li>
                    -->
                </ul>
            </div>
        </div>

        <div class="fbbwrap fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in">
                        <div class="l"><label><input id="J_CheckAll" type="checkbox">全选</label></div>
                        <div class="r">
                            <div class="main-info"><span>¥ <em>00.00</em></span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap cash-buttons">
                    <a id="J_ButtonCash" class="button button-wrap-disabled" href="javascript:void(0)">立即结算</a>
                </div>
                <div class="button-wrap edit-buttons">
                    <a id="J_ButtonDel" class="button button-wrap-disabled" href="javascript:void(0)">删除</a>
                </div>
            </div>
        </div>
        
        <div id="J_ASSpec" class="actionsheet-spec">
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择商品参加的促销</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="l">
                                    <div class="lable fullreduction">满减</div>
                                    <div class="prompt">购物满5000减200，包邮，不与其他优惠同享</div>
                                </div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="l">
                                    <div class="lable keepfolding">满折</div>
                                    <div class="prompt">购物满10件可享9.2折优惠，不与其他优惠同享</div>
                                </div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="l">
                                    <div class="lable hidegift">满赠</div>
                                    <div class="prompt">购物满2000可赠白瓷饮酒杯一组</div>
                                </div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="paytype">
                                <div class="c">不参与促销活动</div>
                            </label>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="fbbwrap nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button sales-btn">确定</a>
                    </div>
                </div>
            </div>
        </div>
        <div id="couponList"></div>
        <input type="hidden" id="selectedProducts">
    </div>
<script type="text/javascript">
    $(function(){
        var isEditAll = false,
            checkAllBtn = $("#J_CheckAll"),
            editBtn = $("#J_EditBtn"),
            cartList = $(".cart-list"),
            flag=true;//设置一个标记
		
        getShopCartList ();
        
        editBtn.on("click", function () {
            if(isEditAll){
                this.innerHTML = '<span>编辑</span>';
                isEditAll = false;
            }else{
                this.innerHTML = '<span>完成</span>';
                isEditAll = true;
            }
            $(".ftbtnbar").toggleClass("editing");
        });

        //选中产品
        cartList.on("change","input[type=checkbox]", function () {
            checkChange();
        });

        checkAllBtn.on("change", function () {
            var checkboxes = cartList.find("input[type=checkbox]");
            if(this.checked){
                checkboxes.prop("checked",true);
            }else{
                checkboxes.prop("checked",false);
            }
            checkChange();
        });

        //选择产品的操作
        function checkChange(){
            var checkboxes = cartList.find("input[type=checkbox]"),
                    noChecked = true,
                    checkCount = 0,
                    buttonGroups = $(".ftbtnbar .button-wrap a");
            var selectedProducts = '';       
            checkboxes.each(function () {
                if(this.checked == true){
                    selectedProducts += ','+$(this).parent().parent().data('cartItemId') + ',';
                    noChecked = false;
                    checkCount++;
                }
            });
            
            $('#selectedProducts').val(selectedProducts);//把选择的商品存放在一个隐藏域中
            
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
        }

        //减产品数量
        cartList.on('click','.number-minus',function() {
    		if(!flag) { return; }
    		var num = $(this).parent().find('input[class="number-text"]').val();//商品数量
    		
        	if(num==1) {
        		$(this).addClass('disabled');
        		return;
        	}else{
        		$(this).removeClass('disabled');
        	}
        	
        	num--;
        	
        	var id = $(this).parent().parent().parent().data('cartItemId');
        	
    		$(this).parent().find('input[class="number-text"]').val(num);
    		var cartData = shopCartData();
    		updateShopCartList (id,num,cartData);
        })
        
        //加产品数量
        cartList.on('click','.number-plus',function() {
    		if(!flag) { return; }
    		var personlimitnum = $(this).parent().parent().parent().find('.purchasing').data('personlimitnum');//限购数
    		var num = $(this).parent().find('input[class="number-text"]').val();
    		var id = $(this).parent().parent().parent().data('cartItemId');
    		
        	if(personlimitnum) {
    			if((personlimitnum-1) == num) {
    				$(this).addClass('disabled');
        			$(this).parent().find('input[class="number-text"]').val(personlimitnum);
        			var cartData = shopCartData();
    				updateShopCartList (id,personlimitnum,cartData);
    				return;
    			}else if(personlimitnum == num) {
    				return;
    			}else{
    				$(this).removeClass('disabled');
    			}
    		}
    		
    		num++;

        	$(this).parent().find('input[class="number-text"]').val(num);
    		var cartData = shopCartData();
    		updateShopCartList (id,num,cartData);
        })
        
        //直接改变商品的数量
        cartList.on('change','.number-text',function() {
    		if(!flag) { return; }
    		var num = $(this).val();
        	var id = $(this).parent().parent().parent().data('cartItemId');
    		var cartData = shopCartData();
    		
    		var reg = new RegExp("^[0-9]*$"); 
        	if(!reg.test(num)){  
        		//还原原来的数量
        		$(this).val($(this).data('shopnum'));
		        mui.toast('请输入合法的数量');
		        return;
		    } 
		    
    		updateShopCartList (id,num,cartData);
        });
        
        //删除功能
        $("#J_ButtonDel").on("click",function(){
            if($(this).hasClass("button-wrap-disabled")) return;
            if(!flag) { return; }
            var btnArray = ['确认', '关闭'];
            mui.confirm('', '确认要删除所选商品吗？', btnArray, function(e) {
                if (e.index == 0) {
                	var ids = "";
                	var pids = "";
                	$("input[name='chk_item']").filter(":checked").each(function(i) {
                		
                		if(i == 0) {
                			ids += $(this).parent().parent().data('cartItemId');
                			pids += $(this).parent().parent().data('productId')+"-"+$(this).parent().parent().find('.number-text').eq(0).val().trim();
                		} else {
                			ids += ',' + $(this).parent().parent().data('cartItemId');
                			pids += ',' + $(this).parent().parent().data('productId')+"-"+$(this).parent().parent().find('.number-text').eq(0).val().trim();
                		}
                	});
                	flag=false;
                	$.ajax({
                		url  : '${ctx}/m/cart/delete',
                    	async : true,
                    	type : "GET",
            			dataType : "json",
            			data : {"ids" : ids,"pids" : pids},
            			success : function(result) {
            				flag=true;
            				if(result.result == 'success') {
            					mui.toast('已删除所选商品');
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
        
        //结算
        $('#J_ButtonCash').on('click',function() {
        	var ids = '';
        	if(!flag) { return; }
        	$("input[name='chk_item']").filter(":checked").each(function(i) {
        		var cartItemId = $(this).parent().parent().data('cartItemId');
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
        	var isClick = $(this).is('.button-wrap-disabled');
        	if(isClick) {
        		return;
        	}

        	window.location.href = "${ctx}/m/cart/buyCart?ids=" + ids;
        });
        
        //加载购物车数据
        function getShopCartList () {
        	flag=false;
        	$.ajax({
            	url  : '${ctx}/m/cart/mstoreCartList',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			success : function(result) {
    				flag=true;
    				if(result) {
    					console.log(result);
    					shopCartList(result.cart, result.total);
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
        
        //更新购物车数据
        function updateShopCartList (id,num,cartData) {
        	if(id == undefined) {
        		id = '';
        	}
        	flag=false;
        	$.ajax({
            	url  : '${ctx}/m/cart/update',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : {"cartItemId" : id, "quantity" : num, "cartData":cartData},
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
        	$('#couponList').empty();//清空优惠券列表
        	$('.main-info').empty();//清空总价格
			for(var i = 0; i < cartResult.length; i++) {
        		var cartItemId = cartResult[i].cartItemId;
        		var productId = cartResult[i].productId;
        		var productName = cartResult[i].productName;//产品名称
        		var tagPrice = rendererZhMoney(cartResult[i].tagPrice);//吊牌价
        		var firstAddedSalePrice = rendererZhMoney(cartResult[i].firstAddedSalePrice);//首次加入购物车的价格
        		var quantity = cartResult[i].quantity;//数量
        		var isSelected = cartResult[i].isSelected;//是否选中
        		var productPicUrl = cartResult[i].productPicUrl;//产品图片地址
        		var promotionId = cartResult[i].promotionId;//活动id
        		var promotionDiscountRuleId = cartResult[i].promotionDiscountRuleId;//活动规则id
        		var discountTypeCd = cartResult[i].discountTypeCd;//折扣类型
        		var promotionDiscountDesc = cartResult[i].promotionDiscountDesc;//优惠描述
        		var userCanUseCouponList = cartResult[i].userCanUseCouponList;//商品对应的优惠券（活动）
        		var personLimitNum = cartResult[i].personLimitNum;//限购数
        		var selectedProducts = $('#selectedProducts').val();//获取商品的选中状态
        		var mstoreName = cartResult[i].mstoreName;
        		var checked = "";
        		console.log(cartResult[i]);
        		if(selectedProducts.indexOf(','+cartItemId+',') != -1) {
        			checked = "checked";
        		}
        		if(isSelected) {
        			checked = "checked";
        		}
        		var li = '<li>';
        		li += '<label><input type="checkbox" name="chk_item" '+ checked +'></label>';
        		li += '<div class="pic"><a href="#"><img src="' + productPicUrl + '"></a></div>';
        		li += '<h3><a href="#">' + productName+　'</a><span style=" position: fixed;right: 10px;">('+mstoreName+')</span></h3>';
        		li += '<div class="price-origin-cart">￥' + tagPrice + '</div>';
        		li += '<div class="price">';
        		li += ' 	<div class="number-widget number-widget-cart">';
        		li += '			<input class="number-text" type="text" data-shopnum="'+quantity+'" value="' + quantity + '">';
        		
        		if(quantity==1) {
        			li += '		<div class="number-minus disabled"></div>';
        		}else{
        			li += '		<div class="number-minus"></div>';
        		}
        		
        		if(personLimitNum && personLimitNum == quantity) {
        			li += '		<div class="number-plus disabled"></div>';
        		} else {
        			li += '		<div class="number-plus"></div>';
        		}
        		li += '</div>';
        		li += '		<span class="price-real">￥<em>' + firstAddedSalePrice + '</em></span>';
        		li += '</div>';
        		
        		if(personLimitNum) {
        			li += '<div class="purchasing" data-personLimitNum="'+personLimitNum+'">限购'+ personLimitNum +'件</div>';
        		}
        		
        		if(promotionDiscountRuleId) {
        			var discountTypeCdStr = '';
	                if(discountTypeCd == 1) {
	                	discountTypeCdStr = '满减';
	                } else if(discountTypeCd == 2){
	                	discountTypeCdStr = '满折';
	                }
	                
        			li += '<div class="information">';
	                li += '     <div class="content">';
	                li += '         <span class="keepfolding">' + discountTypeCdStr + '</span>';
	                li += '         <p>' + promotionDiscountDesc + '</p>';
	                li += '     </div>';
	                li += '     <div class="modify orange" data-pid="'+productId+'">修改优惠</div>';
	                li += '</div>';
        		} else if (userCanUseCouponList && userCanUseCouponList.length > 0) {
        			li += '<div class="information">';
        			li += '     <div class="content">';
        			li += '     </div>';
	                li += '     <div class="modify orange" data-pid="'+productId+'">修改优惠</div>';
	                li += '</div>';
        		}
        		
            	li += '</li>';
            	
				$li = $(li);
				$li.data('cartItemId',cartItemId);
				$li.data('productId',productId);
				$li.data('promotionId',promotionId);
				$li.data('promotionDiscountRuleId',promotionDiscountRuleId);
            	
            	cartList.append($li);//把购物车中商品数据添加到当前标签中
            	
            	if(userCanUseCouponList && userCanUseCouponList.length > 0) {
            		div =  '<div id="J_ASSpec_'+productId+'" class="actionsheet-spec" data-cartitemid="'+cartItemId+'">';
			        div += '   <div class="close"></div>';
			        div += '   <div class="prod-info">';
			        div += '       <div class="title">请选择商品参加的促销</div>';
			        div += '   </div>';
			        div += '   <div class="spec-list">';
			        div += '       <div class="spec-list-wrap">';
			        div += '           <ul class="tbviewlist paytypes">';
			        
			        for(j = 0; j < userCanUseCouponList.length; j++) {
			        	var typeCdStr = '';
		                if(userCanUseCouponList[j].discountTypeCd == 1) {
		                	typeCdStr = '满减';
		                } else if(discountTypeCd == 2){
		                	typeCdStr = '满折';
		                }
				        div += '               <li>';
				        div += '                   <label data-listpromotionid="'+userCanUseCouponList[j].promotionId+'" data-listdiscountruleid="'+userCanUseCouponList[j].id+'" data-listcouponcodeid="'+userCanUseCouponList[j].couponCodeId+'">';
				        div += '                       <input type="radio" name="paytype">';
				        div += '                       <div class="l">';
				        div += '                           <div class="lable fullreduction">' + typeCdStr + '</div>';
				        div += '                           <div class="prompt">' + userCanUseCouponList[j].discountDesc + '</div>';
				        div += '                       </div>';
				        div += '                   </label>';
				        div += '               </li>';
			        }
			        div += '                <li>';
			        div += '                   <label>';
			        div += '                       <input type="radio" name="paytype">';
			        div += '                       <div class="c">不参与促销活动</div>';
			        div += '                   </label>';
			        div += '               </li>';
			        div += '           </ul>';
			        div += '       </div>';
			        div += '   </div>';
			
			        div += '   <div class="fbbwrap nofixed">';
			        div += '       <div class="ftbtnbar">';
			        div += '           <div class="button-wrap button-wrap-expand">';
			        div += '               <a href="javascript:void(0)" class="button sales-btn">确定</a>';
			        div += '           </div>';
			        div += '       </div>';
			        div += '   </div>';
			        div += '</div>';
			        
			        $('#couponList').append(div);
            	}
        	}
			
			$('.main-info').append('<span>¥ <em>' + rendererZhMoney(total) + '</em></span>');
			$("input[name='chk_item']").filter(":checked").each(function() {
				$(".ftbtnbar .button-wrap a").removeClass("button-wrap-disabled");
			});
        }
        
        //获取所有产品的数据
        function shopCartData() {
        	var shopListStr = '';
        	cartList.find("li").each(function(i) {
        		var productId = $(this).data("productId");
        		var quantity = $(this).find('.number-text').eq(0).val();
        		if(i == 0) {
        			shopListStr += productId + "-" + quantity + "-0";
        		} else {
        			shopListStr += "," + productId + "-" + quantity + "-0";
        		}
        	});
        	return shopListStr;
        }
        $('#a').click(function() {
        	addShopCart(1, 2 );
        
        }); 
        
        //选择参加促销活动
        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
                
        cartList.on('click','.orange',function() {
        	pid = $(this).data("pid");
        	specAS = $("#J_ASSpec_"+pid);
        	showSpecAS();
        });
        
        $('#couponList').on('click','.close',function() {
        	hideSpecAS();
        });
        
        //选择优惠券，点击确认后
        $('#couponList').on('click','.sales-btn',function() {
        	hideSpecAS();
        	var $lable = specAS.find("input:checked").parent();
        	var cartItemId = specAS.data('cartitemid')? specAS.data('cartitemid') : '';
        	var promotionId = $lable.data('listpromotionid')?$lable.data('listpromotionid') : '';
            var promotionDiscountRuleId = $lable.data('listdiscountruleid')?$lable.data('listdiscountruleid') : '';
            var promoCouponCodeId = $lable.data('listcouponcodeid')?$lable.data('listcouponcodeid') : '';
            var data = {};
            data.cartItemId = cartItemId;
            data.promotionId = promotionId;
            data.promotionDiscountRuleId = promotionDiscountRuleId;
            data.promoCouponCodeId = promoCouponCodeId;
            $.ajax({
            	url  : '${ctx}/m/cart/update',
            	async : true,
            	type : "GET",
    			dataType : "json",
    			data : data,
    			success : function(result) {
    				if(result.result == 'success') {
    					getShopCartList ();
    				}
    			},
    			error:function(XMLHttpResponse ){
    				console.log("请求未成功");
    			}
            }); 
        });
        

        function showSpecAS(){
            specASMask.show().animate({opacity:1},{
                duration:80,
                complete: function () {
                    specAS.css({
                        top : "100%",
                        opacity : 0,
                        display : "block"
                    }).animate({
                        opacity : 1,
                        translateY:"-"+specAS.height() +"px"
                    },{
                        duration : 200,
                        easing : "ease-in-out"
                    });
                }
            });
        }

        function hideSpecAS(callback){
            specAS.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    specAS.hide();
                    specASMask.animate({opacity:0},{
                        duration : 80,
                        complete: function () {
                            specASMask.hide();
                            if(typeof callback == "function") callback.call();
                        }
                    });
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

    })
</script>
</body>
</html>