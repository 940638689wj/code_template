<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title>${(product.productName)!?html}</title>
    <script src="${ctx}/static/js/jquery.imagezoom.min.js"></script>
	<script src="${ctx}/static/js/boxer.min.js"></script>
	<script src="${ctx}/static/js/dateFormate1.js"></script>
	<link rel="stylesheet" href="${staticPath}/css/fsboxer.css">
</head>
<body class="page-list">

    
    <div id="main">
        <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="${ctx}/index.html">首页</a>
            <span class="divide">&gt;</span>
            <a class="c" href="${ctx}/products/${product.categoryId}.html">${productCategory.categoryName}</a>
            <span class="divide">&gt;</span>
            <span>${(product.productName)!?html}</span>
        </div>

        <div class="contents clearfix">
            <div class="info_l">
                <dl>
                	
                    <dt id="piclist"><a href="${ctx}/images/pic.jpg"><img src="${ctx}/images/pic.jpg" rel="${ctx}/images/pic.jpg" class="jqzoom" /></a></dt>
                    <dd>
                        <div class="tb-thumb" id="thumblist">
                            <ul>
                            <#assign firstProductPic = ""/>
			                <#if productPicList?? && productPicList?has_content>
				                <#list productPicList as productPic>
			                        <#if productPic_index=0>
			                            <#assign firstProductPic = productPic/>
			                        </#if>
                                <li <#if productPic_index=0>class="tb-selected"</#if>><a href="javascript:void(0);"><img src="${productPic}" mid="${productPic}" big="${productPic}"></a></li>
                                </#list>
			                </#if>
                            </ul>
                        </div>
                    </dd>
                </dl>
                <div class="pr-links">
                    <span class="sharewidget"><span class="bdsharebuttonbox" data-tag="share_1">
                     	<a class="bds_weixin" data-cmd="weixin"></a>
						<a class="bds_tsina" data-cmd="tsina"></a>
						<a class="bds_sqq" data-cmd="sqq">
					</span></span>
                    <a class="socialbtn" href="javascript:void(0);"><i class="icon <#if isCollect?? && isCollect?has_content &&isCollect=1>ico-unlike<#else>ico-liked</#if>" id="likeBtn"></i>收藏商品<!--<i class="icon ico-unlike"></i>取消收藏--></a>
                </div>
            </div>

            <div class="info_r">
            <input type="hidden" id="productId" value=""/>
            <input type="hidden" id="realStock" value=""/>
            <input type="hidden" id="promotionId" value="${promotionId!}"/>
            <input type="hidden" id="defaultPrice" value="${product.defaultPrice!}"/>
            <#if userId?? && userId?has_content>
            <input type="hidden" id="userId" value="${userId!}"/>
            </#if>
                <div class="proName">
                    <h2>${(product.productName)!?html}</h2>
                    <p>${(productExtend.productSubTitle)!?html}</p>
                </div>
                <div class="pre-sale"><span>预售期</span><em id="preSaleDePositTime"></em></div>
                <div class="pre-sale"><span>尾款期</span><em id="preSaleRemainTime"></em></div>
                <div class="proDetails">
                <dl class="clearfix">
                    <dt>销售价：</dt>
                    <dd>
                        <span class="price-real" id="price">¥${(product.defaultPrice)?html}</span>
                    </dd>
                 </dl>
                 <dl class="clearfix">
                    <dt>定金：</dt>
                    <dd>
                    	<span class="price-real">¥</span><span class="price-real" id="preMoney"></span>
                    </dd>
                 </dl>
                 <dl class="clearfix">
                    <dt>尾款：</dt>
                    <dd>
                        <span class="price-real" id="remainderMoney"></span>
                    </dd>
                 </dl>
                 <div class="detail-qrcode">
                    <p>手机购买</p>
                    <div class="qrcode">
                        <img src="/qrCode/generate?content=${pcUrl!}/m/product/${product.productId}" alt="" width="100" height="100"/>
                        <span class="ui-arrow"></span>
                    </div>
                </div>
                </div>
                <dl class="meta-item">
                    <dt>商品评价：</dt>
                    <dd>好评度${(goodReviewP)?string("#.#")}%<em>（共<i class="red">${(productSumInfo.mainReviewCnt)?default(0)}</i> 条评论）</em></dd>
                </dl>
                <dl class="meta-item">
                    <dt>销量：</dt>
                    <dd>${(saleCnt)!0}件</dd>
                </dl>
                <div class="proList_box">
                <#if hadOptionList?? && hadOptionList?has_content>
	                <#list hadOptionList as option>
	                    <dl class="meta-item meta-amount">
	                        <dt class="metatit">${option.label}：</dt>
	                        <dd>
	                            <ul class="clearfix prop-list" id="skuList">
	                            <#list hadOptionValueMap?keys as hadOptionValueId>
	                            	<#if hadOptionValueId='${option.id}'>
	                            		<#assign optionValue=hadOptionValueMap[hadOptionValueId]>
	                            		<#list optionValue?keys as value>
			                                <li id="${value}"><a href="javascript:void(0);">
			                                    <span>${optionValue[value].label}</span>
			                                </a><i></i></li>
		                                </#list>
	                                </#if>
	                            </#list>    
	                            </ul>
	                        </dd>
	                    </dl>
	                    </#list>
                    </#if>
                  <!-- <dl class="meta-item meta-amount">
                        <dt class="metatit">：</dt>
                        <dd>
                            <ul class="clearfix prop-list">
                                <li class="selected"><a href="#">
                                    <span>175/92A S</span>
                                </a><i></i></li>
                                <li><a href="#">
                                    <span>175/96A M</span>
                                </a><i></i></li>
                                <li><a href="#">
                                    <span>175/96A M</span>
                                </a><i></i></li>
                                <li class="disabled"><a href="#">
                                    <span>175/96A M</span>
                                </a><i></i></li>
                            </ul>
                        </dd>
                    </dl>-->
                    <dl class="meta-item meta-amount">
                        <dt class="metatit">数量：</dt>
                        <dd>
                            <span class="amount-widget">
                                <input type="number" class="textfield" id="count" value="1">
                                <span class="increase " id="create"></span>
                                <span class="decrease decrease-disabled" id="decreate"></span>
                            </span>
                            <#if productSetting.isShowStock==0>
	                            <em id="stock">（库存 ${product.sum} ）</em>
		            		</#if>
                        </dd>
                    </dl>
                </div>
                <div class="proList-action">
                    <div class="btn-buy"><a onclick="buyNow();">立即付定金</a></div>
                </div>
            </div>

        </div>

        <div class="showAdds">
            <div class="showAddsLeft fll">
                <div class="showLeftCon">
                    <h3>热销商品</h3>
                    <ul>
                    <#if hotProductList?? && hotProductList?has_content>
				        <#list hotProductList as hotProduct>
                        <li><a href="${ctx}/product/${hotProduct.productId}">
                            <div class="sPic"><img src="${hotProduct.picUrl}"></div>
                            <div class="sbox"><p>${hotProduct.productName}</p><span>¥${hotProduct.defaultPrice}</span></div>
                        </a>
                        </li>
                        </#list>
                      </#if>
                    </ul>
                </div>

                <div class="showLeftCon">
                    <h3>最近浏览的商品</h3>
                    <ul>
                    <#if historyProductList?has_content>
		                <#list historyProductList as historyProduct>	
                        <li><a href="${ctx}/product/${historyProduct.productId}">
                            <div class="sPic"><img src="${historyProduct.picUrl}"></div>
                            <div class="sbox"><p>${historyProduct.productName}</p><span>¥${historyProduct.defaultPrice}</span></div>
                        </a>
                        </li>
                        </#list>
	                 </#if>
                    </ul>
                </div>
            </div>

            <div class="showAddsRight flr">
                <div class="detail-tabbox">
                    <div class="tabboxlist">
                        <ul>
                            <li class="select"><a href="javascript:void(0);">商品详情</a></li>
                            <li><a href="javascript:void(0);">商品评价</a></li>
                            <li><a href="javascript:void(0);">月交易记录</a></li>
                        </ul>
                    </div>
                </div>
                <div class="product-detail">
                    <div class="moudle_details">
                        <div class="moudle_top"><span class="sp_cs">商品参数</span></div>
                        <div class="t-info">
                            <table width="100%" border="0" cellpadding="0" cellspacing="0">
                                <tbody>
                                <#if attributeListList?? && attributeListList?has_content>
	                                <tr>
	                                	<#list attributeListList as attribute>
	                                	<#if 0<attribute_index  && (attribute_index % 4)==0></tr><tr></#if>
	                                    <td>
	                                        <div class="zxx_con">${(attribute.attrName)!?html}：${(attribute.attrValue)!?html}</div>
	                                    </td>
	                                    </#list>
	                                </tr>
	                            <#else>
	                            	<div class="moudle_prompt">暂无商品参数</div>
                                </#if> 
                                </tbody>
                            </table>
                        </div>
                        
                        <div class="moudle_top"><span class="sp_show">商品展示</span></div>
                        <#if productExtend?? && productExtend.productDetailDesc?has_content>
	                        <div class="moudle_img">
	                            ${(productExtend.productDetailDesc)!}
	                        </div>
                        	<#else>
                        	<div class="moudle_prompt">暂无商品详情</div>
                        </#if>
                    </div>
                    <div class="moudle_details" style="display: none;" id="moudle_details">
                    	<div class="dc_score">
						    <span class="score">综合评分</span>
						    <span class="fl">|</span>
						    <span class="review-star review-star-${((productSumInfo.productMatchScoreAvg)?default(0))}"><b></b></span>
						    </div>
						    <ul class="dc_c_t">
						    	<li <#if type==0>class="on"</#if>><a href="javascript:void(0);">全部（${(productSumInfo.mainReviewCnt)?default(0)?number}）</a></li>
						        <li <#if type==1>class="on"</#if>><a href="javascript:void(0);">好评（${goodReview}）</a></li>
						        <li <#if type==2>class="on"</#if>><a href="javascript:void(0);">中评（${mediumReview}）</a></li>
						        <li <#if type==3>class="on"</#if>><a href="javascript:void(0);">差评（${badReview}）</a></li>
						    </ul>
						<div class="review-list" id="review-list">
           				<#include "./reviewList.ftl"/>	
           				</div>
					</div>
					
					<!--月交易记录-->
					<div class="moudle_details" style="display: none;" id="moudle_details">
						<div id="dealRecord-list">
           				<#include "./participation_record.ftl"/>	
           				</div>
					</div>
					
           		</div>
            </div>
        </div>
    </div>
<script>
	payBeginTime = "";
	payEndTime = "";
    $(function(){
     $(".jqzoom").imagezoom();
        $("#thumblist li a").hover(function(){
            $(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
            $(".jqzoom").attr('src',$(this).find("img").attr("mid"));
            $(".jqzoom").attr('rel',$(this).find("img").attr("big"));
        });
        
        <#if hadOptionList?? && hadOptionList?has_content>
    	var skuMap=${skuMap};
    	var realStock=	${product.sum};
    	//var message=skuMap["2:7:16"];
    	//alert(message["realStock"]);
    	var sku="";
    	$(".prop-list li").each(function(){
    		var idx =$(this).index();
    		if(idx==0){
    			$(this).attr("class","selected");
    		}
    		if($(this).attr("class")=="selected"){
    			//alert($(this).attr("id"));
    			sku=sku+$(this).attr("id")+":";
    		}
    	})
    	if (sku.length > 0) {
        			sku = sku.substr(0,sku.length - 1);
    		}	
    	var message=skuMap[sku];
		$("#stock").html("（库存 "+message["realStock"]+" ）");
		$("#productId").val(message["productId"]);
		$("#realStock").val(message["realStock"]);
		realStock=message["realStock"];
        	
    	$("#price").html("¥"+message["price"]);
        $("#defaultPrice").val(message["price"]);
        
        var prePrice = $("#preMoney").html();
        if(prePrice!=null && prePrice!=""){
        	changeRemainderMoney(prePrice,message["price"]);
        }
        
        
    	$(".prop-list li").click(function(){
    		sku="";
    		
    		//选择规格时重置输入框
    		$("#count").val(1);
    		$("#create").removeClass("decrease-disabled");
    		$("#decreate").addClass("decrease-disabled");
    		
    		//var idx =$(this).index();
    		$(this).parent().find('li').removeClass("selected");
    		$(this).addClass("selected");
    		$(".prop-list li").each(function(){
    			if($(this).attr("class")=="selected"){
    				//alert($(this).attr("id"));
    				sku=sku+$(this).attr("id")+":";
    			}
	    		
    		})
    		
    		if (sku.length > 0) {
        			sku = sku.substr(0,sku.length - 1);
    		}	
    		//alert(sku)
    		var message=skuMap[sku];
    		//alert(message["realStock"]);
    		
    		$("#stock").html("（库存 "+message["realStock"]+" ）");
    		$("#price").html("¥"+message["price"]);
    		$("#defaultPrice").val(message["price"]);
    		realStock=message["realStock"];
    		$("#productId").val(message["productId"]);
    		$("#realStock").val(message["realStock"]);
    		
    		var prePricet = $("#preMoney").html();
	        if(prePricet!=null && prePricet!=""){
	        	changeRemainderMoney(prePricet,message["price"]);
	        }
    		
    	})
    	<#else>
    		$("#productId").val(${product.masterProductId});
    		$("#realStock").val(${product.realStock});
    	</#if>
    	
    	getPreSaleInfo();//加载预售信息
    	
        $(".topshopcart").hover(getCartContent, removeCartContent);
        //加载第一幅图片
        $("#piclist a").attr('href',"${firstProductPic}");
        $("#piclist img").attr('src',"${firstProductPic}");
        $("#piclist img").attr('rel',"${firstProductPic}");
        var cartList = $(".amount-widget");
	    
	    
	   	
		//加数量
        cartList.on('click','.increase',function() {
        	var number = $(this).parent().find('.textfield').val();
        	//alert(number)
        	if(number == realStock) {
        	  $(this).parent().find(".increase").attr("class","increase increase-disabled");
        		return;
        	}
        	$(this).parent().find(".decrease").attr("class","decrease");
        	number++;
        	$(this).parent().find('.textfield').val(number);
        	//alert($(this).parent().find('.textfield').val());
        });
        //减数量
        cartList.on('click','.decrease',function() {
        	var number = $(this).parent().find('.textfield').val();
        	//alert(number)
        	if(number == 1 ) {
        	  $(this).parent().find(".decrease").attr("class","decrease decrease-disabled");
        		return;
        	}
        		$(this).parent().find(".increase").attr("class","increase");
        	
        	number--;
        	$(this).parent().find('.textfield').val(number);
        });
         //直接改变商品的数量
        cartList.on('change','.textfield',function() {
    		var num = $(this).val();
    		//var cartData = shopCartData();
    		//var personlimitnum = $(this).parent().parent().parent().find('.purchasing').data('personlimitnum');//限购数
    		var reg = new RegExp("^[1-9][0-9]*$"); 
        	if(!reg.test(num)){  
        		//还原原来的数量
        		$(this).parent().find('.textfield').val(1);
		        layer.msg('商品数量只能输入正整数！');
		        return;
		    } 
		    if(parseInt(num) > realStock) {
		    	layer.msg("商品的购买数量不能超过"+realStock);
        		$(this).parent().find('.textfield').val(1);
				return;
		    }
		    /*
		    if(personlimitnum && parseInt(personlimitnum) < parseInt(num)) {
		    	//还原原来的数量
        		$(this).val(personlimitnum);
		        layer.msg('你购买的数量已超过限购数！');
		        return;
		    }
		    */
		    $(this).parent().find('.number-text').val(num);
		    //alert($(this).parent().find('.number-text').val())
        });
        

        var tabboxList = $(".tabboxlist"),
            tabboxListtop = tabboxList.offset().top;
        $(window).on("scroll",function(){
            var scrolltop = $(this).scrollTop();
            tabboxList.removeAttr("style");
            if(scrolltop > tabboxListtop){
                tabboxList.addClass("tabboxlist-fix");
            }else{
                tabboxList.removeClass("tabboxlist-fix");
            }
        });

        $('.boxer').boxer({
            labels: {
                close: "关闭",
                count: "/",
                next: "下一个",
                previous: "上一个"
            }
        });

        $(".tabboxlist li").on("click",function(){
            var idx = $(this).index();
            $(".tabboxlist li").removeClass("select");
            $(this).addClass("select");
            $(".moudle_details").hide().eq(isNaN(idx) ? 0 : idx).show();
        })


        $('.detail-qrcode').hover(function(){
            $(this).find('.qrcode').show();
        },function(){
            $('.qrcode').hide();
        });
        var isCollect = 0;//是否收藏：0：未收藏，1：已收藏 
        <#if isCollect?? && isCollect?has_content>
        		isCollect = ${isCollect};
        	</#if>
		 //点击收藏
        $(".socialbtn").on("click", function () {
        	//alert(isCollect);
            var btn = $(this);
			var pid = ${product.productId}
            if(isCollect==1){
            	isCollect=0;
            }else{
            	isCollect=1;
            }
            
            var userId = $('#userId').val()
            if(userId) {
            	$.ajax({
	        		url  : '${ctx}/m/product/collect',
	            	async : true,
	            	type : "GET",
	    			dataType : "json",
	    			data : {"productId" : pid, "isCollect" : isCollect},
	    			success : function(result) {
	    				if(result.result == 'success') {
	    				if(isCollect==0){
	    					$('#likeBtn').attr('class',"icon ico-liked");
	    				}
	    				if(isCollect==1){
	    					//alert("1");
	    					$('#likeBtn').attr('class',"icon ico-unlike");
	    					
	    				}
	    			}}
	    		})
            } else {
            	 //询问框
			    layer.confirm('您还未登录，请先登录!', {
				        btn: ['确认', '关闭']
				    }, function(){
				        //layer.msg('的确很重要', {icon: 1});
				        window.location.href = "${ctx}/login?successUrl="+encodeURIComponent(window.location.href);
				    }
			    );
            }
        });

    })
    function getCartContent(){
        $(".topshopcart").addClass("cart-hover");
    }
    function removeCartContent(){
        $(".topshopcart").removeClass("cart-hover");
    }
   
    $(".dc_c_t li").click(function(){
    	var type=$(this).index();
    	//alert("ww");
    	$(this).parent().find('li').removeClass("on");
    	$(this).addClass("on");
    	gotoPage(type,1);
    
    })
	//页面跳转
    function gotoPage(reviewType,page){
	    $.ajax({
			url:"${ctx}/product/Review_ajaxpage_List",
			data:{
				productId:${product.productId},
	    		type:reviewType,
	    		goToPage:page
			},
			dataType:"text",
			success:function(data){
				//alert("ww");
				$("#review-list").html(data);
			}
    	});
    }
    
    //成交记录页面跳转
    function gotoRecordPage(page){
	    $.ajax({
			url:"${ctx}/product/dealRecord_ajaxpage_List",
			data:{
				productId:${product.masterProductId},
	    		goToPage:page
			},
			dataType:"text",
			success:function(data){
				$("#dealRecord-list").html(data);
			}
    	});
    }		
    //立即购买
    function buyNow(){
	        <#if userId?? && userId?has_content>
	           	var quantity = $('.textfield').val();
	           	var realStock= $("#realStock").val();
	           	var productId= $("#productId").val();
	           	var promotionId = $("#promotionId").val();
	           	if(parseInt(quantity)>parseInt(realStock)){
	 				layer.msg("商品库存不足!");
	 				return;
 				}
                window.location.href = "${ctx}/account/preSaleOrder/toSubmitOrderForDeposit?productId=" + productId + "&quantity=" + quantity+"&promotionId="+promotionId;
		        <#else>
		            //询问框
			        layer.confirm('您还未登录，请先登录!', {
			            btn: ['确认', '关闭'] //按钮
			        }, function(){
			            //layer.msg('的确很重要', {icon: 1});
			            window.location.href = "${ctx}/login?successUrl="+encodeURIComponent(window.location.href);
			        }, function(){
			            /*layer.msg('也可以这样', {
			                time: 20000, //20s后自动关闭
			                btn: ['明白了', '知道了']
			            });*/
			        });
		        </#if>
		    }
		    
	    
	//获取预售信息   
	function getPreSaleInfo(){
		var promotionId = $('#promotionId').val();
		$.ajax({
    		url  : '${ctx}/preSale/getPreSaleInfo_pc',
        	type : "GET",
			dataType : "json",
			data : {"promotionId":promotionId},
			success : function(data) {
				if(data!=null){
					payBeginTime = data.enableStartTime;
					payEndTime = data.allowPayRemainderStartTime;
					var defaultPrice=$("#defaultPrice").val();
					$("#preSaleDePositTime").html(Format(ConvertJSONDateToJSDateObject(data.enableStartTime),"MM.dd")+"-"+Format(ConvertJSONDateToJSDateObject(data.allowPayRemainderStartTime),"MM.dd"));
					$("#preSaleRemainTime").html(Format(ConvertJSONDateToJSDateObject(data.allowPayRemainderStartTime),"MM.dd")+"-"+Format(ConvertJSONDateToJSDateObject(data.allowPayRemainderEndTime),"MM.dd"));
					$("#preMoney").html((data.price).toFixed(2));
					changeRemainderMoney(data.price,defaultPrice);
				}
			}
		});
	}
	//尾款
	function changeRemainderMoney(prePrice,nowSalePrice){
        var money= eval(nowSalePrice)-eval(prePrice);
		$("#remainderMoney").html("¥"+(money).toFixed(2));//尾款
	}
	//转换JSON数据中的时间为标准时间
	function ConvertJSONDateToJSDateObject(JSONDateString) {
	    var date = new Date(parseInt(JSONDateString));
	    return date;
	}
</script>
    <script>
        with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
    </script>
</body>
</html>