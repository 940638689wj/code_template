<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<!doctype html>
<html lang="en">
<head>
	<title>商品详情</title>
    <script type="text/javascript" src="${staticResourcePath}/js/swiper.min.js"></script>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
                <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/products/0"></a>
                <h1 class="mui-title">商品详情</h1>
				<a class="mui-icon"></a>
	            <#if limitId??><input type="hidden" id="limitId" name="limitId" value="${limitId!}"/></#if>
	            <input type="hidden" id="personLimitNum" name="personLimitNum" value="<#if userLimitNum??>${userLimitNum}<#else>${personLimitNum!}</#if>"/>
	        </header>
        </#if>

        <div class="mui-content">
			<input type="hidden" id="realStock" value=""/>
			<input type="hidden" id="mainProductId" value="${productId!}"/>
			<#if userId?? && userId?has_content>
				<input type="hidden" id="userId" value="${userId}"/>
			</#if>

		    <div class="swiper-container picslider">
                <div class="swiper-wrapper">
                <#assign firstProductPic = ""/>
                <#if productPicList?? && productPicList?has_content>
	                <#list productPicList as productPic>
                        <#if !(firstProductPic?? && firstProductPic?has_content)>
                            <#assign firstProductPic = productPic/>
                        </#if>
						<div class="swiper-slide">
							<div class="pic"><img data-src="${productPic}" class="swiper-lazy"></div>
							<div class="swiper-lazy-preloader"></div>
						</div>
                    </#list>
                </#if>
                </div>
                <!-- Add Pagination -->
                <div class="swiper-pagination"></div>
            </div>

            <div class="sku-detail-top">
		        <div class="sku-intro">
		        	<input type="hidden" name="productId" id="productId" value="${(product.productId)!}">
		            <h1 class="sku-name">${(product.productName)!?html}</h1>
		            <p class="sku-custom-attr">${(productExtend.productSubTitle)!?html}</p>
		            <p class="sku-sales-num">已售${saleCnt?default("0")}件
		            <#if productSetting.isShowStock?has_content && productSetting.isShowStock==0>
		            	<span class="inventory">库存:${(product.sum)!0}件</span>
		            </#if>
		            </p>
		        </div>
				<div class="sku-price">
	                <div class="price-real">
	                <#if promotionPrice?? && promotionPrice?has_content >
	                	￥<strong id="nowPrice">${promotionPrice!0}</strong><span>${promotionDesc!}</span>
	                <#elseif userProductPrice?? && userProductPrice?has_content>
	                	￥<strong id="nowPrice">${userProductPrice!0}</strong><span>会员价</span>
	                <#elseif productSetting.isShowSalePrice?has_content && productSetting.isShowSalePrice==1>
	                	 ￥<strong id="nowPrice">${(product.defaultPrice)!0}</strong>
	                </#if>
	                
	                <#if productSetting.isShowTagPrice?has_content && productSetting.isShowTagPrice==1>
	                   <span class="price-origin">￥${(product.tagPrice)!0}</span>
	                </#if>
	                
	                </div>
	               <div class="priceForUser">
	               </div>
            	</div>
            
        	</div>
        	
        	<#--搭配套餐-->
            <div class="sku-collocation">
            
            <#--<div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink" href="combo_list.html">
                            <div class="c">搭配套餐</div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="collocationList">
                <ul>
                    <li>
                        <div class="pic"><img src="images/goodspic.jpg" ></div>
                        <div class="price">¥<em>1289.00</em></div>
                    </li>
                    <li>
                        <div class="pic"><img src="images/goodspic.jpg" ></div>
                        <div class="price">¥<em>1289.00</em></div>
                    </li>
                    <li>
                        <div class="pic"><img src="images/goodspic.jpg" ></div>
                        <div class="price">¥<em>1289.00</em></div>
                    </li>
                </ul>
            </div>-->
        	</div>
        	<#--评价-->
        	<div class="sku-evaluate">
	            <div class="tbviewlist">
	                <ul>
	                    <li>
	                        <a class="itemlink" href="${ctx}/m/product/evaluation?productId=${productId!}">
	                            <div class="r">好评率<em class="orange">${goodReviewValue?default(0)}%</em></div>
	                            <div class="c">商品评价<em>(${reviewTotal?default(0)}人)</em></div>
	                        </a>
	                    </li>
	                </ul>
	            </div>

                <#if productReviewList?? && productReviewList?has_content>
	                <div class="review-list">
	                    <div class="review-item">
	                        <ul>
	                        	<#list productReviewList as productReview>
            	 					<#assign BigDecimal = 5/>
            	 	 			<#if productReview.productMatchScore?? && productReview.productMatchScore?has_content>
                        			<#assign BigDecimal = productReview.productMatchScore/>
                     			</#if>
	                            <li>
	                                <div class="bd">
	                                    <h3><em class="fl">${(productReview.reviewerName)!?html}</em><em class="fr"><span class="review-star review-star-${BigDecimal}"><b></b>
	                                    </span></em></h3>
             	        					<p>${(productReview.reviewContent)!?html}</p>
	                                </div>
	                            </li>
	                        	</#list>
	                        </ul>
	                    </div>
	                </div>
                <#else>
	                <div class="iconinfo">
                    <div class="ico ico-info"></div>
                    <strong>暂无用户评价</strong>
                    </div> 
                 </#if>
        		</div>
        	<div class="skutabbar" id="J_DetailTab">
	            <ul>
	                <li class="selected"><a href="javascript:void(0);">图文详情</a></li>
	                <li><a href="javascript:void(0);">商品参数</a></li>
	                <li><a href="javascript:void(0);">月成交记录</a></li>
	            </ul>
	        </div>

			<#--图文详情-->
	        <div class="sku-detail-content">
	            <div id="J_DetailContent" class="tabpag">
	            	<#--<ul class="tbviewlist">
		                    <li>
		                        <div class="hd">重量：</div>
		                        <div class="bd"></div>
		                    </li>
							<li>
								<div class="hd">单位：</div>
								<div class="bd"></div>
							</li>
							 <li>
								<div class="hd"></div>
								<div class="bd"></div>
							</li>
                    </ul>
		           		//富文本
	                	${(productExtend.productMDetailDesc)!}
						<div class="iconinfo">
							<div class="ico ico-info"></div>
							<strong>暂无图片详情</strong>
						</div>
					 -->
				</div>
				
				 <#--产品参数详情-->
		          <div class="tabpag" style="display: none" id="productParameters">
		          <#--
		          <#if productAttributeList?? && productAttributeList?has_content>
		            <#list productAttributeList as productAttribute>
	                <ul class="tbviewlist" >
	                    <li>
	                        <div class="hd">${productAttribute.attrName!}</div>
	                        <div class="bd">${productAttribute.attrValue!}</div>
	                    </li>
	                </ul>
	                </#list>
	                <#else>
	                <div class="iconinfo">
	                    <div class="ico ico-info"></div>
	                    <strong>产品参数</strong>
	                </div>
	                </#if>
	                -->
	            </div>
	            
	           <div class="tabpag" style="display: none">
                <#if dealRecord?? && dealRecord?has_content>
                <div class="in-recordlist">
                    <ul>
                        <li>
                        <#if dealRecord.headPortraitUrl?has_content>
                            <div class="t"><img src="${staticResourcePath}${dealRecord.headPortraitUrl!}" alt=""></div>
                        <#else>
                            <div class="t"><img src="${staticResourcePath}/images/userhead.jpg" alt=""></div>
                        </#if>
                            <div class="c">
                                <div class="usr">${dealRecord.userName!}</div>
                                <div class="count">购买了 <em>${dealRecord.quantity!}</em> 件</div>
                                <div class="time">${dealRecord.createTime?string("yyyy-MM-dd HH:mm:ss")}</div>
                            </div>
                        </li>
                        <li class="more">
                            <a href="${ctx}/m/product/toDealRecord?productId=${productId!}">查看更多</a>
                        </li>
                   </ul>
                </div>
                <#else>
                	<div class="iconinfo">
	                    <div class="ico ico-info"></div>
	                    <strong>没有成交记录</strong>
                	</div>
                </#if>
            	</div>
        	  </div>

	        
            <div class="fbbwrap-total">
            <#if product.productStatusCd== -2||product.productStatusCd== 2>   
	            <div class="ftbtnbar">
	                <div class="button-wrap button-wrap-expand button-wrap-disabled">
	                    <a href="javascript:void(0)" class="button">商品已售罄/下架</a>
	                </div>
	            </div>
	        <#elseif isPreSaleProduct?has_content>
	        	<div class="ftbtnbar">
	                <div class="button-wrap button-wrap-expand button-wrap-disabled">
	                    <a href="javascript:void(0)" class="button">预售商品暂无法购买</a>
	                </div>
	            </div>
			<#else>
	            <div class="ftbtnbar">
	                <div class="button-l">
	                    <div class="sku-action">
	                        <a class="btn-fav <#if isCollect?? && isCollect?has_content && isCollect == 1> selected</#if>" href="javascript:void(0)">收藏</a>
	                    </div>
	                    <a href="${ctx}/m/cart/list" id="J_ShopCart">
	                        <i class="iconfont">&#xe611;</i>
	                        <span>购物车</span>
	                        <em id="productCount">0</em>
	                    </a>
	                </div> 
	                <div class="button-wrap button-wrap-expand">
                     		<a class="button addtocart" id="J_BtnCart" >加入购物车</a>
                    		<a class="button" id="J_BtnBuy" >立即购买</a>
	                </div>
	            </div>
        	</div>
        	</#if>
        </div>
        
        <div id="J_ASSpec" class="actionsheet-spec">

        <div class="close"></div>
        
        
        

        <div class="prod-info">
            <div class="pic"><img src="${firstProductPic}" alt=""/></div>
            <div class="name">${(product.productName)!?html}</div>
		    <div class="price"><span class="price-real">¥
		    	<#if promotionPrice?? && promotionPrice?has_content >
                	<em id="price">${promotionPrice!0}</em>
                <#elseif userProductPrice?? && userProductPrice?has_content>
                	<em id="price">${userProductPrice!0}</em>
                <#else>
                	 <em id="price">${(product.defaultPrice)!0}</em>
                </#if>
		    	<#--<#if userProductPrice?has_content>
        			<em id="price">${userProductPrice!0}<em>
        		<#else>
        			<em id="price">${(product.defaultPrice)!?html}</em>
        		</#if>-->
		    </span></div>
        </div>

        <div class="spec-list detail">
            <div class="spec-list-wrap">
				<#if optionList?? && optionList?has_content>
					<#list optionList as option>
						<div class="spec-item">
							<h3>${option.label}</h3>
							<div class="c">
								<div class="prop-list">
									<ul>
									<#list optionMap?keys as hadOptionValueId>
											<#if hadOptionValueId='${option.id}'>
												<#assign optionValue=optionMap[hadOptionValueId]>
												<#list optionValue?keys as value>
												<li id="${value}">${optionValue[value].label}</li>
												</#list>
											</#if>
										</#list>
									</ul>
								</div>
							</div>
						</div>
					</#list>
				</#if>

				<div class="spec-item">
					<h3>数量</h3>
					<div class="c">
						<div class="number-widget">
							<div class="number-minus disabled"></div>
							<input class="number-text" type="number" value="1">
							<div class="number-plus"></div>
						</div>
						<#if productSetting.isShowStock==0>
							<div class="sku-stock-count">库存<em id="stock">${(product.sum)!0}</em>件</div>
						</#if>
					</div>
				</div>

            </div>
        </div>

        <div class="fbbwrap nofixed">
            <div class="ftbtnbar">
                <div class="button-wrap button-wrap-expand">
                    <a href="javascript:void(0)" class="button btn-buy">确定</a>
                </div>
            </div>
        </div>

    </div>

</div>
<script>
	$(function(){
        imglazyload();
        loadCartInfo();
        getPriceForUser();
        getProductPromotion();
        productParameters();
        productDetailInfo();
    })

	    var cartList = $(".number-widget");
	    var realStock=	${(product.sum)!0};
	     <#if optionList?? && optionList?has_content>
		 	var skuMap=${skuMap};
		 	var sku="";
		 	//商品规格
	        $(".prop-list li").each(function(){
	            if(!$(this).hasClass("disabled")){
	                $(this).click(function(){
	                	sku="";
	                    $(this).addClass("active").siblings().removeClass("active");
	                	$(".prop-list li").each(function(){
			    			if($(this).attr("class")=="active"){
			    				sku=sku+$(this).attr("id")+":";
			    			}
			    		})

			    		if (sku.length > 0) {
							sku = sku.substr(0,sku.length - 1);
			    		}

			    		var message=skuMap[sku];
	    				$("#stock").html(message["realStock"]);
	    				realStock = message["realStock"];

	    				$('.number-text').val(1);
	    				$(".number-minus").attr("class","number-minus");
	                	$(".number-plus").attr("class","number-plus");
	                	$("#productId").val(message["productId"]);
						//$("#price").html(message["price"]);
						<#if promotionPrice?? && promotionPrice?has_content>
							$("#price").html(message["promotionPrice"]);
							$("#nowPrice").html(message["promotionPrice"]);		
							//$(".price-origin").html(message["price"]);		        	
				       	<#elseif userProductPrice?? && userProductPrice?has_content>
				            $("#price").html(message["memberPrice"]);
				            $("#nowPrice").html(message["memberPrice"]);
				            //$(".price-origin").html(message["price"]);	
				        <#else>
				        	$("#price").html(message["price"]);
				        	$("#nowPrice").html(message["price"]);
				        	//$(".price-origin").html(message["price"]);	
				        </#if>
						
	                })
	            }

                var idx = $(this).index();
                if (idx == 0) {
                    $(this).attr("class", "active");
                }

                if ($(this).attr("class") == "active") {
                    sku = sku + $(this).attr("id") + ":";
                }
	        })

			 if (sku.length > 0) {
				 sku = sku.substr(0, sku.length - 1);
			 }

	    	var message = skuMap[sku];
	    	$("#stock").html(message["realStock"]);
	    	realStock=message["realStock"];
	    	//$("#price").html(message["price"]);
	    	$("#productId").val(message["productId"]);
	    	<#if promotionPrice?? && promotionPrice?has_content>
				$("#price").html(message["promotionPrice"]);
				$("#nowPrice").html(message["promotionPrice"]);		
				//$(".price-origin").html(message["price"]);		        	
	       	<#elseif userProductPrice?? && userProductPrice?has_content>
	            $("#price").html(message["memberPrice"]);
	            $("#nowPrice").html(message["memberPrice"]);
	            //$(".price-origin").html(message["price"]);	
	        <#else>
	        	$("#price").html(message["price"]);
	        	$("#nowPrice").html(message["price"]);
	        	//$(".price-origin").html(message["price"]);	
	        </#if>
			
		 <#else>
			$("#productId").val(${product.masterProductId});
    		$("#stock").html(${product.sum});
		</#if>

		//加数量
        cartList.on('click','.number-plus',function() {
        	var number = $(this).parent().find('.number-text').val();
        	if(number == realStock) {
        	  $(this).parent().find(".number-plus").attr("class","number-plus disabled");
        		return;
        	}

        	$(this).parent().find(".number-minus").attr("class","number-minus");
        	number++;
        	$(this).parent().find('.number-text').val(number);
        });

        //减数量
        cartList.on('click','.number-minus',function() {
        	var number = $(this).parent().find('.number-text').val();
        	if(number == 1 ) {
        	  $(this).parent().find(".number-minus").attr("class","number-minus disabled");
        		return;
        	}

			$(this).parent().find(".number-plus").attr("class","number-plus");
        	
        	number--;
        	$(this).parent().find('.number-text').val(number);
        });

         //直接改变商品的数量
        cartList.on('change','.number-text',function() {
    		var num = $(this).val();
    		var reg = new RegExp("^[1-9][0-9]*$");
        	if(!reg.test(num)){  
        		//还原原来的数量
        		$(this).parent().find('.number-text').val(1);
		        mui.toast('商品数量只能输入正整数！');
		        return;
		    }

		    if(parseInt(num) > realStock) {
		    	mui.toast("商品的购买数量不能超过"+realStock);
        		$(this).parent().find('.number-text').val(1);
				return;
		    }
		    $(this).parent().find('.number-text').val(num);
        });
        
        var addToCartFlag = true;        
        function addToCart(productId){
			<#if userId?? && userId?has_content>
				var num=$('.number-text').val();
				if(!addToCartFlag) { return; }//防止多次提交
				addToCartFlag = false;

				var submitData={};
				submitData.productId = productId;
				submitData.quantity =num;
				submitData.userId = '${userId}';
				$.ajax({
					url  : '${ctx}/m/cart/add',
					async : true,
					type : "GET",
					dataType : "json",
					data : submitData,
					success : function(result) {
						if(result.result == 'success') {
							loadCartInfo();
						}if(result.result=='error'){
							mui.toast(result.message);
						}
						addToCartFlag = true;
					},
					error:function(XMLHttpResponse ){
						mui.toast(XMLHttpResponse.message);
						addToCartFlag = true;
					}
				});
	        <#else>
	            var btnArray = ['确认', '关闭'];
	            mui.confirm('', '您还未登录，请先登录!', btnArray, function(e) {
	                if (e.index == 0) {
	                    window.location.href = "${ctx}/m/login?successUrl="+encodeURIComponent(window.location.href);
	                }
	            })
	        </#if>
	    }

		 function buyNow(productId){
			<#if userId?? && userId?has_content>
				var quantity = $('.number-text').val();
				if(parseInt(quantity)>parseInt(realStock)){
					mui.toast("商品库存不足!");
					return;
				}

				window.location.href = "${ctx}/m/cart/buyNow?productId=" + productId + "&quantity=" + quantity;
			<#else>
				var btnArray = ['确认', '关闭'];
				mui.confirm('', '您还未登录，请先登录!', btnArray, function(e) {
					if (e.index == 0) {
						window.location.href = "${ctx}/m/login?successUrl="+encodeURIComponent(window.location.href);
					}
				})
			</#if>
		}
		    
    	function loadCartInfo(){
	        $.ajax({
	            url  : '${ctx}/m/cart/getCartInfo',
	            async : true,
	            type : "GET",
	            dataType : "json",
	            data : {},
	            success : function(result) {
	               	$('#productCount').text(result.productCount);
	            },
	            error:function(XMLHttpResponse ){
	                console.log(XMLHttpResponse.message);
	            }
	        });
    	}
    
		//暂时没用到
		function toConsult(productId){
			<#if userId?? && userId?has_content>
				 window.location.href = "${ctx}/m/product/consulting?productId="+productId;
			<#else>
				var btnArray = ['确认', '关闭'];
				mui.confirm('', '您还未登录，请先登录!', btnArray, function(e) {
					if (e.index == 0) {
						window.location.href = "${ctx}/m/login?successUrl="+encodeURIComponent(window.location.href);
					}
				})
			</#if>
		}

	var flag = true;//防止多次提交
	$(function() {
		var userId = $('#userId').val(),
            pid = $('#mainProductId').val(),
            isCollect = 0;//是否收藏：0：未收藏，1：已收藏
			<#if isCollect?? && isCollect?has_content>
				isCollect = ${isCollect};
			</#if>

		 var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationType : 'fraction',
            loop : true,
            preloadImages: false,
            lazyLoading : true,
        });

        var mySwiper1 = new Swiper('#coupon-list',{
            freeMode : true,
            slidesPerView : 'auto',
        });

        //tab栏固顶
        var tabBar = $("#J_DetailTab");
        $(window).on("scroll", function () {
            var tabTop = tabBar.offset().top;
            if(document.body.scrollTop > tabTop){
                tabBar.addClass("fixed");
            }else{
                tabBar.removeClass("fixed");
            }
        });

        var detailContent = $('#J_DetailContent');
        detailContent.find('[width],[height]').css({width:'auto',height:'auto'});
        detailContent.find("img").css({
            width : "auto",
            height : "auto",
            margin:"auto",
            display:"block"
        }).unveil(0, function () {
            var img = $(this);
            img.one("load", function () {
                img.css({
                    width : "auto",
                    height : "auto"
                });
            });
        });

        //图片详情产品参数tab
        $(".skutabbar li").click(function () {
            var idx = $(this).index();
            $(".skutabbar li").removeClass("selected");
            $(this).addClass("selected");
            $(".tabpag").hide().eq(isNaN(idx) ? 0 : idx).show();
        });

          //点击收藏
        $(".btn-fav").on("click", function () {
            var btn = $(this);

            if(isCollect) {
            	isCollect = 0;
            } else {
            	isCollect = 1;
            }
            
            if(userId) {
            	$.ajax({
	        		url  : '${ctx}/m/product/collect',
	            	async : true,
	            	type : "GET",
	    			dataType : "json",
	    			data : {"productId" : pid, "isCollect" : isCollect},
	    			success : function(result) {
	    				if(result.result == 'success') {
	    					if(!btn.hasClass("selected")){
				                btn.html("已收藏");
				                mui.toast('添加收藏成功');
				            }else{
				                btn.html("收藏");
				                mui.toast('取消收藏');
				            }
				            btn.toggleClass("selected").addClass("animating")
				                .on("animationend webkitAnimationEnd MSAnimationEnd oAnimationEnd", function () {
				                    btn.removeClass("animating");
				                });
	    				}
	    			},
	    			error:function(XMLHttpResponse ){
	    				console.log("请求未成功");
	    			}
	    		})
            } else {
            	var btnArray = ['确认', '关闭'];
                mui.confirm('', '您还未登录，请先登录！', btnArray, function(e) {
	                if (e.index == 0) {
	                   window.location.href = "${ctx}/m/login?successUrl="+window.location.href;
	                }
	            })
            }
        });
		


        //加入购物车
        $(".sku-addshoppingcart").on("click",function(){
            var current = $(this);
            current.hide();
            $(".number-widget").show();
        })
    	var reviewerId = $('.reviewerId');
    	for(var i=0;i<reviewerId.length;i++){
    		var name = $('#reviewerName_'+$(reviewerId[i]).val()).text();
    		var mphone = name.substr(0,1) + '***' + name.substr(name.length-1);
   			$('#reviewerName_'+$(reviewerId[i]).val()).text(mphone)
    	}
    	
    	 


        //添加购物车动作
      $("#J_ASSpec .btn-buy").on("click", function () {
            var productId= $("#productId").val();
            var num=$('.number-text').val();
            
            if(parseInt(num)>parseInt(realStock)){
 				mui.toast("商品库存不足!");
 				return;
 				}
           	if($(this).attr("id")=="J_BtnBuy"){
            	buyNow(productId);
           	}else{
           		addToCart(productId);
           		<#if userId?? && userId?has_content>
           			throwInCart($("#J_BtnCart"));
           		</#if>
           	}
            hideSpecAS();
        });

        function throwInCart(source){
            var start = $(source).offset(),
                    end = $("#J_ShopCart").offset(),
                    winH = $(window).height()-30,
                    sX = start.left + start.width/ 2 - 15,
                    sY = winH + start.height/ 2 - 15,
                    eX = end.left + end.width/ 2 - 15,
                    eY = end.top + end.height/ 2 - 15;
            var throwItem = $('<div class="throwInItem"></div>').css({
                top : sY,
                left : sX,
                "-webkit-transform-origin":((eX - sX)/2+15)+"px 0"
            }).appendTo(document.body);
            throwItem.animate({
                rotate : "-200deg"
            },{
                duration : 800,
                easing : "ease-out",
                complete : function () {
                    throwItem.remove();
                    mui.toast('已添加到购物车',true);
                }
            });
        }
    	
    	
    	//选择参加促销活动
        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
        specAS = $("#J_ASSpec");
    	$("#J_BtnCart,#J_BtnBuy,#J_BtnChooes").on("click", function () {
    		 //alert($(this).attr("id"));
    		 $(".btn-buy").attr("id",$(this).attr("id"));
            showSpecAS();
        });
        specAS.find(".close").on("click", function () {
            hideSpecAS();
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
	});
	
	function getProductPromotion(){
		var pid = $('#mainProductId').val();
		var userId = $('#userId').val();
		$.ajax({
    		url  : '${ctx}/m/product/getProductPromotion',
        	type : "GET",
			dataType : "json",
			data : {"productId" : pid,"userId":userId},
			success : function(data) {
				if(data!=null){
					var datalength = data.data.combPromotionList.length;
					if(datalength>0){
						for(var i=0;i<datalength;i++){
							var htmlStr='';
							var promotion = data.data.combPromotionList[i].proProductList;
							if(promotion.length>0){
								var promotionId=promotion[i].combProduct.promotionId;
								var productId = $('#mainProductId').val();
								htmlStr+='<div class="tbviewlist"><ul><li><a class="itemlink" href="${ctx}/m/product/combPromotionDetail?userId=${userId!}&promotionId='+promotionId+'&productId='+productId+'"><div class="c">搭配套餐</div></a></li></ul></div><div class="collocationList"><ul>';
								for(var j=0;j<promotion.length;j++){
									htmlStr+='<li><div class="pic"><img src="${ctx}'+promotion[j].combProduct.productPicUrl+'" ></div>';
									htmlStr+='<div class="price">¥<em>'+promotion[j].combProduct.price+'</em></div></li>';
								}
								htmlStr+='</ul></div>';
								$(".sku-collocation").append(htmlStr);
							}
						}
					}
					
				}
			}
	    });
	}
	
	function getPriceForUser(){
		$(".priceForUser").hide();
		var pid = $('#mainProductId').val();
		var userId = $('#userId').val();
		if(userId==null || userId==""){
			return false;
		}
		$.ajax({
    		url  : '${ctx}/m/product/getPriceForUser',
        	type : "GET",
			dataType : "json",
			data : {"productId" : pid,"userId":userId},
			success : function(data) {
				if(data!=null){
					var productPriceForUser= data.data.productPriceUserLevelXref
					if(productPriceForUser !="undefined" && productPriceForUser!=null){
						var htmlStr = '';
						if(productPriceForUser.onlyCashAmt!=null){
						   htmlStr+='<div class="price-real"><span class="promotetag">现金</span><span class="price-points">￥'+productPriceForUser.onlyCashAmt+'</span></div>'
						}
						if(productPriceForUser.onlyScoreAmt!=null){
						   htmlStr+='<div class="price-real"><span class="promotetag">积分</span><span class="price-points" >'+productPriceForUser.onlyScoreAmt+'积分</span></div>'
						}
						if(productPriceForUser.cwsCashAmt!=null && productPriceForUser.cwsScoreAmt!=null){
						   htmlStr+='<div class="price-real"><span class="promotetag">现金+积分</span><span class="price-points" >￥'+productPriceForUser.cwsCashAmt+'+'+productPriceForUser.cwsScoreAmt+'积分</span></div>'
						}
						if(productPriceForUser.xmairCardScoreAmt!=null){
						   htmlStr+='<div class="price-real"><span class="promotetag">白鹭卡积分</span><span class="price-points" >'+productPriceForUser.xmairCardScoreAmt+'积分</span></div>'
						}
						if(productPriceForUser.cwxmairCashAmt!=null && productPriceForUser.cwxmairXmairScoreAmt!=null){
						   htmlStr+='<div class="price-real"><span class="promotetag">现金+白鹭卡积分</span><span class="price-points" >￥'+productPriceForUser.cwxmairCashAmt+'+'+productPriceForUser.cwxmairXmairScoreAmt+'积分</span></div>'
						}
						$(".priceForUser").append(htmlStr);
						$(".priceForUser").show();
					}
				}
			}
	    });
	}
	
	function productParameters(){
		var pid = $('#mainProductId').val();
		$.ajax({
    		url  : '${ctx}/m/product/productParameters',
        	type : "GET",
			dataType : "json",
			data : {"productId" : pid},
			success : function(data) {
				htmlStr='';
				if(data!=null){
					var datalength = data.productAttributeList.length;
					if(datalength>0){
						for(var i=0;i<datalength;i++){
							htmlStr+='<ul class="tbviewlist"><li><div class="hd">'+data.productAttributeList[i].attrName+'</div>'
	                        		+'<div class="bd">'+data.productAttributeList[i].attrValue+'</div></li></ul>';
						}
					}else{
						htmlStr='<div class="iconinfo"><div class="ico ico-info"></div><strong>产品参数</strong></div>';
					}
				}else{
					htmlStr='<div class="iconinfo"><div class="ico ico-info"></div><strong>产品参数</strong></div>';
				}
				$("#productParameters").append(htmlStr);
			}
	    });
	}
	
	function productDetailInfo(){
		var pid = $('#mainProductId').val();
		$.ajax({
    		url  : '${ctx}/m/product/productDetailInfo',
        	type : "GET",
			dataType : "json",
			data : {"productId" : pid},
			success : function(data) {
				var htmlStr='';
				var htmlCount=0;
				if(data!=null){
					htmlStr+='<ul class="tbviewlist">';
					if(data.productSetting!=null){
						if(data.productSetting.isShowWeight==0 && data.productExtend.productWeight!=null){
							htmlStr+='<li><div class="hd">重量：</div><div class="bd">'+data.productExtend.productWeight;
							if(data.unit!=null && data.unit!=""){
								htmlStr+=data.unit;
							}
							htmlStr+='</li></div>';
							htmlCount++;
						}
					}
					if(data.productExtend.productMeasureUnit!=null){
	            			htmlStr+='<li><div class="hd">单位：</div><div class="bd">'+data.productExtend.productMeasureUnit+'</div></li>';
	            			htmlCount++;
	            		}
	            	htmlStr+='</ul>';
					if(data.productExtend!=null){
						if(data.productExtend.productMDetailDesc!=null && data.productExtend.productMDetailDesc!=""){
							htmlStr+=data.productExtend.productMDetailDesc;
							htmlCount++;
						}
					}
					if(htmlCount<=0){
						htmlStr+='<div class="iconinfo"><div class="ico ico-info"></div><strong>暂无图文详情</strong></div>';
					}
				}else{
					htmlStr+='<div class="iconinfo"><div class="ico ico-info"></div><strong>暂无图文详情</strong></div>';
				}
				$("#J_DetailContent").append(htmlStr);
			}
			
		});
	}
</script>

<script>
	<#-- 
    (function(cache_data){
        var url = "${shareUrl!}";
        console.log("shareUrl="+url);
        console.log("window.location.host="+window.location.host);
        console.log("cache_data._mobileLogo="+cache_data._mobileLogo);
        window.wxData = {
            img_url : <#if firstProductPic?? && firstProductPic?has_content>['http://'+window.location.host, '${firstProductPic}'].join("")<#else>['http://'+window.location.host, cache_data._mobileLogo].join("")</#if>,
            link : url,
            title : "${(product.productName)!?html}",
            desc : "${(product.productName)!?html}"
        };
    }(window.cache_data)); -->
</script>

</body>
</html>