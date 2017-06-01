<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile">
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<!doctype html>
<html lang="en">
<head>
	<title>商品详情</title>
    <script type="text/javascript" src="${staticResourcePath}/js/swiper.min.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/dateFormate1.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/products/0"></a>
        <h1 class="mui-title">商品详情</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
		<input type="hidden" id="realStock" value=""/>
		<input type="hidden" id="promotionId" value="${promotionId!}">
		<input type="hidden" id="defaultPrice" value="${product.defaultPrice!}">
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
            </div>
            <div class="sku-price">
                <div class="price-real"> 
                	<#if productSetting.isShowSalePrice?has_content && productSetting.isShowSalePrice==1>
	                                                       ￥<strong>${(product.defaultPrice)!0}</strong>
	                </#if>
	                <#if productSetting.isShowTagPrice?has_content && productSetting.isShowTagPrice==1>
	                   <span class="price-origin">￥${(product.tagPrice)!0}</span>
	                </#if>
                </div>
            </div>
            <ul class="advance">
                <li>
                    <div class="t"><h3>预售期</h3><p id="preSaleTime">02.19-02.22</p></div>
                    <div class="b">定金：￥<span id="preMoney">1000</span></div>
                </li>
                <li>
                    <div class="t"><h3>尾款期</h3><p id="remainderTime">02.19-02.22</p></div>
                    <div class="b">尾款：￥<span id="remainderMoney">1000</span></div>
                </li>
            </ul>
        </div>

        <div class="skutabbar" id="J_DetailTab">
            <ul>
                <li class="selected"><a href="javascript:void(0);">图文详情</a></li>
                <li><a href="javascript:void(0);">商品参数</a></li>
            </ul>
        </div>
        <div class="sku-detail-content">
            <div id="J_DetailContent" class="tabpag">
                <#-- <div class="iconinfo">
                    <div class="ico ico-info"></div>
                    <strong>暂无图片详情</strong>
                </div>
                <img data-src="http://img01.taobaocdn.com/imgextra/i1/1708919206/TB2xeA6apXXXXXLXpXXXXXXXXXX_%21%211708919206.jpg" src="/static/mobile/images/loading.gif">
                <img data-src="http://img04.taobaocdn.com/imgextra/i4/1708919206/TB2bwFaaFXXXXbfXXXXXXXXXXXX_%21%211708919206.jpg" src="/static/mobile/images/loading.gif">
                <img data-src="http://img04.taobaocdn.com/imgextra/i4/1708919206/TB2ZnhcaFXXXXXEXXXXXXXXXXXX_%21%211708919206.jpg" src="/static/mobile/images/loading.gif">
               -->
            </div>
            <div class="tabpag" style="display: none" id="productParameters">
                <#-- <div class="iconinfo">
                    <div class="ico ico-info"></div>
                    <strong>产品参数</strong>
                </div>
                <ul class="tbviewlist">
                    <li>
                        <div class="hd">品牌：</div>
                        <div class="bd">KLML</div>
                    </li>
                    <li>
                        <div class="hd">货号：</div>
                        <div class="bd">01</div>
                    </li>
                    <li>
                        <div class="hd">上市年份：</div>
                        <div class="bd">2013年夏季</div>
                    </li>
                    <li>
                        <div class="hd">风格：</div>
                        <div class="bd">休闲</div>
                    </li>
                    <li>
                        <div class="hd">流行元素：</div>
                        <div class="bd">浅口 色拼接 松糕跟</div>
                    </li>
                    <li>
                        <div class="hd">颜色分类：</div>
                        <div class="bd">军绿色 天蓝色 巧克力色 桔色 浅灰色 浅绿色 浅黄色 深卡其布色 深灰色 深紫色 深蓝色 白色 粉红色 紫罗兰 紫色 红色 绿色 花色 蓝色 褐色 透明 酒红色 黄色 黑色</div>
                    </li>
                    <li>
                        <div class="hd">尺码：</div>
                        <div class="bd">35 36 37 38 39 40 41 42 43 44 45 46 47</div>
                    </li>
                    <li>
                        <div class="hd">图案：</div>
                        <div class="bd">纯色</div>
                    </li>
                </ul> -->
                </div>
            </div>
        </div>

        <div class="fbbwrap-total">
            <div class="ftbtnbar" style="display: none;">
                <div class="button-wrap button-wrap-expand button-wrap-disabled">
                    <a href="javascript:void(0)" class="button">商品已售罄</a>
                </div>
            </div>

            <div class="ftbtnbar">
                <div class="button-l">
                    <div class="sku-action">
                        <a class="btn-fav <#if isCollect?? && isCollect?has_content && isCollect == 1> selected</#if>" href="javascript:void(0)">收藏</a>
                    </div>
                </div>
                <div class="button-wrap button-wrap-expand">
                	<#if product.productStatusCd== -2||product.productStatusCd== 2>
                    	<a class="button disabled">立即支付定金</a>
                    <#else>
                    	<a id="J_BtnBuy" class="button">立即支付定金</a>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="J_ASSpec" class="actionsheet-spec">
        <div class="close"></div>
        <div class="prod-info">
            <div class="pic"><img src="${firstProductPic}" alt=""/></div>
            <div class="name">${(product.productName)!?html}</div>
            <#if finalProductPrice?has_content>
               	<div class="price"><span class="price-real">¥<em id="price">${(finalProductPrice)!?html}</em></span></div>
			<#else>
				<div class="price"><span class="price-real">¥<em id="price">${(product.defaultPrice)!?html}</em></span></div>
			</#if>
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
	var isInTime=false;
	$(function(){
		productParameters();
        productDetailInfo();
        getPreSaleInfo();
	})
	
	var cartList = $(".number-widget");
    var realStock=	${(product.sum)!0};
    <#if optionList?? && optionList?has_content>
	 	var skuMap=${skuMap};
	 	var sku="";
    //商品规格
    $(".prop-list li").each(function(){
            if(!$(this).hasClass("disabled")){
                $(this).on("click",function(){
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
					$("#price").html(message["price"]);
                	<#--
                	<#if promotionPrice?? && promotionPrice?has_content>
			     		$("#price").html(message["promotionPrice"]);				        	
			       	<#elseif userProductPrice?? && userProductPrice?has_content>
			            $("#price").html(message["memberPrice"]);
			        <#else>
			        	$("#price").html(message["price"]);
			        </#if>
			        -->
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
	    	$("#productId").val(message["productId"]);
	    	$("#price").html(message["price"]);
    	<#--<#if promotionPrice?? && promotionPrice?has_content>
				$("#price").html(message["promotionPrice"]);
				$("#nowPrice").html(message["promotionPrice"]);		
				$(".price-origin").html(message["price"]);		        	
	       	<#elseif userProductPrice?? && userProductPrice?has_content>
	            $("#price").html(message["memberPrice"]);
	            $("#nowPrice").html(message["memberPrice"]);
	            $(".price-origin").html(message["price"]);	
	        <#else>
	        	$("#price").html(message["price"]);
	        	$("#nowPrice").html(message["price"]);
	        	$(".price-origin").html(message["price"]);	
	        </#if>
			-->
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
        
         //立即支付动作
      $("#J_ASSpec .btn-buy").on("click", function () {
            var productId= $("#productId").val();
            var num=$('.number-text').val();
            if(parseInt(num)>parseInt(realStock)){
 				mui.toast("商品库存不足!");
 				return;
 				}
 			//hideSpecAS();
            buyNow(productId);
        });
        
        function buyNow(productId){
        	var userId = $('#userId').val();
			<#if userId?? && userId?has_content>
				var quantity = $('.number-text').val();
				var promotionId = $("#promotionId").val();
				if(!isInTime){
					mui.toast("不在预售定金期内!");
					return;
				}
				if(eval(parseInt(quantity))>eval(parseInt(realStock))){
					mui.toast("商品库存不足!");
					return;
				}
				window.location.href = "${ctx}/m/account/preSaleOrder/submitOrder?productId=" + productId + "&quantity=" + quantity+"&promotionId="+promotionId;
			<#else>
				var btnArray = ['确认', '关闭'];
				mui.confirm('', '您还未登录，请先登录!', btnArray, function(e) {
					if (e.index == 0) {
						window.location.href = "${ctx}/m/login?successUrl="+encodeURIComponent(window.location.href);
					}
				})
			</#if>
		}
             
    $(function(){
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
            margin:"20px auto",
            display:"block"
        }).unveil(0, function () {
            var img = $(this);
            img.one("load", function () {
                img.css({
                    width : "auto",
                    height : "auto",
                    margin:"auto"
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

        //选择参加促销活动
        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        $("#J_BtnBuy").on("click", function () {
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
           $(document).bind("touchmove",function(e){
                e.preventDefault();
            });
            $('.actionsheet-spec .spec-list.detail')[0].addEventListener('touchmove', function(e) {
                e.stopPropagation();
            }, false);
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
            $(document).unbind("touchmove");
        }

    })
    
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
	
	function getPreSaleInfo(){
		var pid = $('#mainProductId').val();
		var promotionId = $('#promotionId').val();
		$.ajax({
    		url  : '${ctx}/m/preSale/getPreSaleInfo',
        	type : "GET",
			dataType : "json",
			data : {"productId" : pid,"promotionId":promotionId},
			success : function(data) {
				if(data!=null){
					//payBeginTime = data.preSaleInfo.enableStartTime;
					//payEndTime = data.preSaleInfo.allowPayRemainderStartTime;
					isInTime = data.isInTime;
					var defaultPrice= $("#defaultPrice").val();
					$("#preSaleTime").html(Format(ConvertJSONDateToJSDateObject(data.preSaleInfo.enableStartTime),"MM.dd")+"-"+Format(ConvertJSONDateToJSDateObject(data.preSaleInfo.allowPayRemainderStartTime),"MM.dd"));
					$("#preMoney").html(data.preSaleInfo.price);//定金
					$("#remainderTime").html(Format(ConvertJSONDateToJSDateObject(data.preSaleInfo.allowPayRemainderStartTime),"MM.dd")+"-"+Format(ConvertJSONDateToJSDateObject(data.preSaleInfo.allowPayRemainderEndTime),"MM.dd"));;
					$("#remainderMoney").html(eval(defaultPrice)-eval(data.preSaleInfo.price));//尾款
				}
			}
		});
	}
	 //转换JSON数据中的时间为标准时间
	function ConvertJSONDateToJSDateObject(JSONDateString) {
	    var date = new Date(parseInt(JSONDateString));
	    return date;
	}
</script>
</body>
</html>