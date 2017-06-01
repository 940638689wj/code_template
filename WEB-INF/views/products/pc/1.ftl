<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title>${(product.productName)!?html}</title>
	<script src="${ctx}/static/js/lib/cloud-zoom.1.0.2.min.js"></script>
	<script src="${ctx}/static/js/lib/jquery.fancybox-1.3.4.pack.js?v=0120"></script>
	<script src="${ctx}/static/js/boxer.min.js"></script>
	<link rel="stylesheet" href="${staticPath}/css/fsboxer.css">
 	<style>
        /* zoom-section */
        .zoom-small-image{width:380px; height:380px; overflow:hidden;}
        /* 这是下方的鼠标指针的移动镜头平方米。 */
        .cloud-zoom-lens {border: 1px solid #888;margin:-1px;background-color:#fff;cursor:move;}
        /* 这是标题文本 */
        .cloud-zoom-title {font-family:Arial, Helvetica, sans-serif;position:absolute !important;background-color:#000;color:#fff;padding:3px;width:100%;text-align:center;font-weight:bold;font-size:10px;top:0px;}
        /* 这是缩放窗口。 */
        .cloud-zoom-big { width:380px; height:380px; border:0px solid #ccc; overflow:hidden;}
        /* 这是加载消息。 */
        .cloud-zoom-loading {color:white;background:#222;padding:3px;border:1px solid #000;}
        .bdshare_popup_box {z-index: 10000!important;}
    </style>
</head>
<body>
<#macro starView onStarCout onPic offPic>
    <#list 1..5 as temp><#if temp lte onStarCout><img src="${onPic}"><#else><img src="${offPic}"></#if></#list>
</#macro>
<script>

    function showOptionImage(obj){
        var imageUrl = $(obj).attr("data-option-url");
        if(imageUrl && imageUrl != ""){
            $("#optionImg img").attr("src", imageUrl);
            $("#zoom-small-image").hide();
            $("#optionImg").show();
        }
    }


    //初始化图片显示效果
    var initJqueryZoom = function(){
        $(".thumbslist > li").hover(function() {
            var $this = $(this);
            if ($this.hasClass("selected")) {
                return false;
            } else {
                $(".thumbslist > li").removeClass("selected");
                $this.addClass("selected").find("a").click();
            }
        });
        $(".thumbslist > li").first().addClass("selected");
        $(".thumbslist > li").first().children("a").click();
    }

    var lastAddCartType="";
    var anonymousShopping = "false";
    $(function(){
    	$('.boxer').boxer({
        labels: {
            close: "关闭",
            count: "/",
            next: "下一个",
            previous: "上一个"
        	}
    	});
        initJqueryZoom();
       	var cartList = $(".amount-widget");
	    var realStock=	${product.realStock};
	    
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
		        mui.toast('你购买的数量已超过限购数！');
		        return;
		    }
		    */
		    $(this).parent().find('.number-text').val(num);
		    //alert($(this).parent().find('.number-text').val())
        });
		// 页签切换脚本重构
        $("#tab-ul li").click(function(){
            var idx = $(this).index();
            //alert(idx);
            $(".detailTab:lt(" + idx + ")").hide();
            $(".detailTab").eq(idx).show();
            $("ul.detail-tabbar li").removeClass("selected").eq(idx).addClass("selected");
        });

      
        
    });
    function setSmallSize(){
        $(".zoom-small-image img").each(function(){
            $(this).css({"width":'auto',"height":'auto'});
            var wPic=$(this).width();
            var hPic=$(this).height();
            var xScale=380/wPic;
            var yScale=380/hPic;
            if(xScale<yScale){
                yScale=xScale;
            }else{
                xScale=yScale;
            }
            
            wPic=wPic*xScale;
            hPic=hPic*yScale;
            xPic=(380-wPic)/2;
            yPic=(380-hPic)/2;
            $(this).css({"width":wPic,"height":hPic});
            $(".zoom-small-image a").css({"width":wPic,"height":hPic});
            $(".zoom-small-image").css({"width":wPic,"height":hPic,"margin-left":xPic,"margin-top":yPic});
        });
    }
    function setThumbSize(){
        $(".zoom-desc img").each(function(){
            $(this).css({"width":'auto',"height":'auto'})
            var wPic=$(this).width();
            var hPic=$(this).height();
            var xScale=55/wPic;
            var yScale=55/hPic;
            if(xScale<yScale){
                yScale=xScale;
            }else{
                xScale=yScale;
            }
            wPic=wPic*xScale;
            hPic=hPic*yScale;
            xPic=(55-wPic)/2;
            yPic=(55-hPic)/2;
            $(this).css({"width":wPic,"height":hPic,"margin-left":xPic,"margin-top":yPic});
        });
    }
	
    $(function(){
         //点击收藏
        $(".flr").on("click", function () {
            var isCollect = 0;//是否收藏：0：未收藏，1：已收藏 
        
        	//alert("66");
            var btn = $(this);
			var pid = ${product.productId}
            <#if isCollect?? && isCollect?has_content>
        		isCollect = ${isCollect};
        	</#if>
            if(isCollect) {
            	isCollect = 0;
            } else {
            	isCollect = 1;
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
	    					$("#likeBtn").hide();
                			$("#unlikeBtn").show();
                			 location.reload();
	    				}
	    				if(isCollect==1){
	    					alert("收藏成功");
	    					$("#likeBtn").show();
                			$("#unlikeBtn").hide();
                			 location.reload();
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
		
        $(function(){
            $('.goods-gallery').on('mouseover',function(){
				var wPic = $(".zoom-small-image img").width();
		        var hPic = $(".zoom-small-image img").height();
		        if(wPic <380 && hPic< 380){
		            $("#anypos").css({"width":wPic,"height":hPic});
		        }else {
		            $("#anypos").css({"width":"380px","height":"380px"});
		        }
                $('#anypos').show();
            }).on('mouseout',function(){
                $('#anypos').hide();
            });
            $("#anypos").on('mouseover',function(){
                $('#anypos').css("z-index", -1);
            }).on('mouseout',function(){
                $('#anypos').css("z-index", 100);
            });
        });

    });
    var format = function(time, format){
	    var t = new Date(time);
	    var tf = function(i){return (i < 10 ? '0' : '') + i};
	    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
	        switch(a){
	            case 'yyyy':
	                return tf(t.getFullYear());
	                break;
	            case 'MM':
	                return tf(t.getMonth() + 1);
	                break;
	            case 'mm':
	                return tf(t.getMinutes());
	                break;
	            case 'dd':
	                return tf(t.getDate());
	                break;
	            case 'HH':
	                return tf(t.getHours());
	                break;
	            case 'ss':
	                return tf(t.getSeconds());
	                break;
	        }
	    })}
	function switchReviewShow(reviewType){
	
	$.ajax({
		url:"${ctx}/product/reviewList",
		data:{
			productId:${product.productId},
    		type:reviewType
		},
		dataType:"json",
		success:function(data){
			if(data.result=="true"){
				var list = data.productReviewList;
    			var table = document.body.querySelector('.review-list ul');
    			table.innerHTML = "";
		        var cells = document.body.querySelectorAll('.list');
		        for (var i = 0 ; i < list.length ; i++) {
		            var li = document.createElement('li');
		            var first=
		            		'<div class="review-user">'+
		            			'<div class="userimg"><img src="'+list[i].headPortraitUrl+'"/></div>'+
		            			'<div class="username"><a href="#">'+list[i].reviewerName+'</a></div>'+
		            			'<div class="userintro">'+list[i].userLevelName+" "+(list[i].areaName==null?'':list[i].areaName)+'</div>'+
		            		'</div>'+
		            		'<div class="review-content">'+
		            			'<span class="review-time">'+format(list[i].reviewTime, 'yyyy-MM-dd HH:mm:ss')+'</span>'+
		            			'<span class="ratestar"><span class="review-star review-star-'+list[i].productMatchScore*2+'"><b></b></span></span>'+
		            			'<div class="content"><p class="review-exp"><span class="tit">心得：</span><span class="con">'
		            				+list[i].reviewContent+
		            			'</span></p>'+
		            			'<p class="review-buytime"><span class="tit">购买时间：</span><span class="con">'+format(list[i].createTime, 'yyyy-MM-dd HH:mm:ss')+'</span>'+
		            			'</div>';
		            			
		            	if(typeof(list[i].pics)!= 'undefined'){
		            		var pic=list[i].pics;
		            		var picArray=pic.split(",");
		            		var pics= "";
		            		//alert(picArray);
		            		for(var g=0;g<picArray.length;g++){
		            				pics+='<div class="pic"><a rel="gallery'+list[i].reviewId+'" class="boxer" href="'+picArray[g]+'"><img alt="" src="'+picArray[g]+'"></a></div>';
		            			}
		            		first+='<div class="review-img">'+pics+'</div>';
		            		}
		            		//alert((typeof(list[i].replyContent)!= 'undefined'))
		            	if((typeof(list[i].replyContent)!= 'undefined')&&list[i].replyContent!=''){
		            		var reply='<div class="answer clearfix"><dl><dt>回复：</dt><dd>'+list[i].replyContent+'</dd></dl>'+
		            					'<span>'+format(list[i].replyTime, 'yyyy-MM-dd HH:mm:ss')+'</span>'+
		            					'</div>';
		            		first=first+reply;
		            		//alert('p');
		            		}
		            		first=first+'</div>';
		            		//alert(first)
		            		
		            li.innerHTML=first;
		            table.appendChild(li);
		            $('.boxer').boxer({
				        labels: {
				            close: "关闭",
				            count: "/",
				            next: "下一个",
				            previous: "上一个"
				        	}
				    	});
		        }
		        var div = document.createElement('div');
		        div.className = "loadmore";   
		        div.innerHTML='<a onClick="toReviewList();" href="javascript:void(0);">显示更多</a>';
		        table.appendChild(div);
			} else if(data.result=="false") {
				//var li = document.createElement('li');
				var table = document.body.querySelector('.review-list ul');
				table.innerHTML='<li style="text-align: center; padding-left: 0px;">当前无相关评论</li>';
			}
		}
	});    	
  }
</script>



<div id="page">
	<#if userId?? && userId?has_content>
        		<input type="hidden" id="userId" value="${userId}"/>
        	</#if>
    <div class="layout">
        <div class="crumb">
            <span class="t">您的位置：${ctx}</span><a class="c" href="${ctx}/index.html">首页</a> <span class="divide">&gt;</span> <a class="c" href="${ctx}/products/${product.categoryId}.html?productType=${product.productTypeCd}">${productCategory.categoryName}</a> <span class="divide">&gt;</span> <span class="c">${(product.productName)!?html}</span>
        </div>
        <div class="detail-hd clearfix">
            <div class="goods-gallery">
                <div class="pic">
                	<div class="zoom-small-image" id="zoom-small-image">
                	    <a href='${ctx}/static/images/blank.gif' class = 'cloud-zoom' id='zoom1'
                       		rel="adjustX:10, adjustY:0, position:'anypos', showTitle:false, zoomWidth:380, zoomHeight:380">
                        <img src="${ctx}/static/images/blank.gif" id="zoomImg" onLoad="setSmallSize();" /></a>
                    	<a id="optionImg" href="" rel="gallery" style="display: none;">
                        <img yr="autoimg" style="width: 380px;height: 380px" class="medium" src="" />
                    	</a>
                    </div>
                </div>
                <div class="thumbs">
                    <div class="thumbswrap">
			             <ul class="thumbslist">
			                <#assign firstProductPic = ""/>
			                <#if productPicList?? && productPicList?has_content>
				                <#list productPicList as productPic>
			                        <#if !(firstProductPic?? && firstProductPic?has_content)>
			                            <#assign firstProductPic = productPic/>
			                        </#if>
			                    <li>
			                    	<a class="cloud-zoom-gallery" href="${productPic?default("")}"
                                           rel="useZoom: 'zoom1', smallImage: '${productPic?default("")}'">
			                    	<img src="${productPic}" onLoad="setThumbSize();">
			                    	</a>
			                    </li>
			                    </#list>
			                </#if>
                        </ul>
                    </div>
                </div>
             <div id="anypos" style="position:absolute; display: none; width:380px;height:380px; overflow:hidden; margin-left:372px; margin-top:-460px;"></div>
                
            </div>
            <div class="goods-property">
                <h3 class="goodsname">${(product.productName)!?html}</h3>
                <div class="goodsextra">${(productExtend.productSubTitle)!?html}</div>
                <div class="goods-saleprop">
                    
                    <!--<dl class="meta-item">
                        <dt class="metatit">价格：</dt>
                        <dd>
                            <div class="promote promote-strong">
                                <i>限时特价</i><span class="price-real">￥128.00</span><span class="countdown">5天06:48:25</span><i>定金：20</i>
                            </div>
                        </dd>
                    </dl>
                    <dl class="meta-item">
                        <dt class="metatit">促销：</dt>
                        <dd>
                            <div class="promote">
                                <i>满额减</i>满￥300减￥30  满￥200减￥20 <a class="detail_link" href="#">详情</a>
                            </div>
                            <div class="promote">
                                <i>条码购</i>手机下单再打九五折 赶紧拿起手机扫描二维码吧<span class="ico-qrcode"></span>
                            </div>
                        </dd>
                    </dl>-->
                    <#if finalPricePrice?? && finalPricePrice?has_content>
	                    <div class="promote-price">
	                        <span class="promotetag">会员专享<s></s></span>
	                        <span class="price-real">￥<em>${(finalPricePrice)!?html}</em></span>
	                    </div>
                    </#if>
                    <dl class="meta-item">
                        <dt class="metatit">销售价：</dt>
                        <dd>￥${(product.defaultPrice)!?html}</dd>
                    </dl>
                    
                   	
                    <dl class="meta-item">
                        <dt class="metatit">评价：</dt>
                        <dd>
                        <!--<span class="review-star review-star-${(productSumInfo.productMatchScoreAvg)!'0'}">
                        <span class="review-star review-star-${(pro.productMatchScore)!'0'}"><b></b></span>-->
                        <span class="review-star review-star-${((productSumInfo.productMatchScoreAvg)?default(0))}"><b></b></span>
                    	（<em>${(productSumInfo.mainReviewCnt)?default(0)}</em>评论，${(goodReviewP)?string("#.#")}%推荐）</dd>
                    </dl>
                    <dl class="meta-item">
                        <dt class="metatit">销量：</dt>
                        <dd>${(saleCnt)!0}件</dd>
                    </dl>
                    
                </div>
                <div class="goods-data">
                    <ul>
                        <li>累计评价 <em>${(productSumInfo.mainReviewCnt)?default(0)?number}</em></li>
                    </ul>
                </div>
	               <div class="goods-prop ">
	                    
	                    <dl class="meta-item meta-amount">
	                        <dt class="metatit">数<span></span>量：</dt>
	                        <dd>
	                            <span class="amount-widget">
	                                <span class="increase"></span>
	                                <input type="number" id="count" name="count" class="textfield" value="1">
	                                <span class="decrease decrease-disabled"></span>
	                            </span>
	                            <#if productSetting.isShowStock==0>
	                            	<em>（库存 ${product.realStock} ）</em>
		            			</#if>
	                        </dd>
	                    </dl>
	                    
	                    <a href="#" class="btn" style="display:none;"><span>确定</span></a>
	                </div>
                
                <div class="goods-action">
                <#if product.productStatusCd== -2||product.productStatusCd== 2>
                    <div class="btn-cart disabled">
                        <a ><span>此商品已被删除或下架</span></a>
                    </div>
                <#elseif productIsDistribution==false>
                	<div class="btn-cart disabled">
                        <a ><span>此商品已不在配送范围</span></a>
                    </div>
                <#else>
                    <!--<a class="link" href="#">免注册购物</a>-->
                    <div class="btn-buy">
                        <a onclick="buyNow('${product.productId}');"><span>立即购买</span></a>
                    </div>
                    <div class="btn-cart">
                        <a href="javascript:void(0);" onclick="addToCart('${product.productId}');"><span>加入购物车</span></a>
                    </div>
                </#if>
                </div>

                
            </div>
            <div class="goods-social">
                <div class="detail-qrcode">
                    <div class="qrcode-box"><img src="/qrCode/generate?content=${pcUrl!}/m/product/${product.productId}" alt=""/></div>
                    <p>手机扫码购</p>
                </div>
                <div class="links">
                    <span class="sharewidget socialbtn"><i class="ico ico-share"></i>分享<span class="bdsharebuttonbox" data-tag="share_1"><a class="bds_more" data-cmd="more" id="share"></a></span></span>
                 	 <script>
                             var shareUrl = "${pcUrl!}/m/product/${(product.productId)}.html";
                             window._bd_share_config = {
                                 "common": {
                                     "bdSnsKey": {},
                                     "bdText": "",
                                     "bdMini": "2",
                                     "bdMiniList": ["sqq","qzone","weixin","tsina","tieba","douban","tqq","mshare","copy"],
                                     "bdPic": "${pcUrl!}${productPicList[0]!}",
                                     "bdStyle": "0",
                                     "bdSize": "16",
                                     bdUrl: "${pcUrl!}/product/${(product.productId)}.html",
                                     onBeforeClick:function(cmd,config){
                                         // 微信分享重新注入手机地址
                                         if (cmd == "weixin") {
                                             config.bdUrl = shareUrl;
                                         }
                                         return config;
                                     }
                                 }, "share": {"bdSize": 16}, "selectShare": {"bdContainerClass": null, "bdSelectMiniList":false}
                             };
                             with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+ new Date().getHours()];
                         </script>
                 	<a href="javascript:void(0);" id="unlikeBtn" class="socialbtn flr" style="<#if isCollect?? && isCollect?has_content && isCollect == 1><#else>display: none;</#if>">
                        <i class="ico ico-liked"></i>取消收藏
                    </a>
                    <a href="javascript:void(0);" id="likeBtn" class="socialbtn flr" style="<#if isCollect?? && isCollect?has_content && isCollect == 1>display: none;</#if>">
                        <i class="ico ico-unlike"></i>加入收藏
                    </a>
                </div>

                
            </div>

            <div class="goods-side">
                <div class="goods-side-tit"><s></s><span>看了又看</span></div>
                <div id="J_GoodsSideSlide" class="goods-side-bd">
                    <div class="goods-side-slides-wrap">
                        <ul>
                        	<#if historyProductList?has_content>
	                            <#list historyProductList as historyProduct>
	                            <li>
	                                <a href="${ctx}/product/${historyProduct.productId}">
	                                    <div class="pic"><img src="${historyProduct.picUrl}" alt=""/></div>
	                                    <div class="price">¥<em>${historyProduct.defaultPrice}</em></div>
	                                    <div class="name">${historyProduct.productName}</div>
	                                </a>
	                            </li>
	                            </#list>
                            </#if>
                        </ul>
                    </div>
                    <div class="goods-side-slides-nav">
                        <div class="prev"></div>
                        <div class="next"></div>
                    </div>
                </div>
            </div>

        </div>
        <div class="detail-bd clearfix">
          <div class="detail-bd  detail-bd-r clearfix">
          	<div class="detail-extra-r">
                <div class="detail-extra-wrap">
                    <div class="detail-extra-tit">热销商品</div>
                    <div class="detail-extra-con">
                    <#if hotProductList?? && hotProductList?has_content>
				        <#list hotProductList as hotProduct>
                        <ul class="goodslist-grid goodslist-grid-col1">
                            <li><a href="${ctx}/product/${hotProduct.productId}">
                                <div class="pic"><img src="${hotProduct.picUrl}" alt=""></div>
                                <div class="price"><span class="price-real" style="margin-right:0px;">¥<em style="padding-left:4px;">${hotProduct.defaultPrice}</em></span></div>
                                <div class="name" style="text-align:center;margin-top:0px;">${hotProduct.productName}</div>
                            </a></li>
                        </ul>
                        </#list>
                      </#if>
	                </div>
	                </div>
	                <!--<span class="price-origin">¥<em>99</em></span>-->
	            </div>
            <div class="detail-main">
            <div class="detail-tabbox">
                <div class="detail-tabbox-wrap">
                    <div class="detail-tabbox-layout">
                        <ul id="tab-ul" class="detail-tabbar">
                            <li id="productDetailTab" class="selected">
                                <a href="javascript:;"><span>商品详情</span></a>
                            </li>
                            <li id="reviewDetailTab">
                                <a href="javascript:;"><span>用户评价(${(productSumInfo.mainReviewCnt)?default(0)?string("#.##")})</span></a>
                            </li>
                        </ul>
                    </div>
                    <!--<ul class="detail-anchors">
                        <li class="selected"><a href="#">详情描述</a></li>
                        <li><a href="#">尺码图</a></li>
                        <li><a href="#">平铺图</a></li>
                        <li><a href="#">细节图</a></li>
                    </ul>-->
                </div>
            </div>
            <div class="detail-attributes">
                <ul class="attributes-list">
                <#if productSetting.isShowWeight==0>
                	<li title="${(productExtend.productWeight)!?html}">重量：${(productExtend.productWeight)!?html}</li>
                </#if>
					<#if unit?? && unit?has_content>
                        <li title="${(unit)!?html}">单位：${(unit)!?html}</li>
					</#if>
                <#if productAttributeList?? && productAttributeList?has_content>
                	<#list productAttributeList as productAttribute>
		            <li title="${(productAttribute.attrValue)!?html}">${(productAttribute.attrName)!?html}：${(productAttribute.attrValue)!?html}</li>
		            </#list>
		        </#if>
                </ul>
           	</div>
           	
            <#if productExtend?? && productExtend.productDetailDesc?has_content>
                    <div class="detail-description detailTab" style="margin-left:0px;">
	                	${(productExtend.productDetailDesc)!}
	                </div>
	                <#else>
	                <div class="detail-description detailTab" style="margin-left:0px;">
	                    <div class="ico ico-info"></div>
	                    <strong>暂无图片详情</strong>
	                </div>
	         </#if>
	         	 <div id="detail-reviews-div" class="detail-reviews detailTab">
                    <h3 class="hd"><span>商品评价</span></h3>
				
                    <div class="review-overview">
                        <div class="review-rate">
                            <span><em>${(goodReviewP)?string("#.#")}</em>%</span>

                            <p>强烈推荐购买</p>
                        </div>
                        <ul class="review-summary">
                            <li>
                                <div class="sumtit"><em>好评</em><span>(${(goodReviewP)?string("#.#")}%)</span></div>
                                <div class="sumratebar"><span style="width:${(goodReviewP)?string("#.#")}%"></span></div>
                            </li>
                            <li>
                                <div class="sumtit"><em>中评</em><span>(${(mediumReviewP)?string("#.#")}%)</span></div>
                                <div class="sumratebar"><span style="width:${(mediumReviewP)?string("#.#")}%"></span></div>
                            </li>
                            <li>
                                <div class="sumtit"><em>差评</em><span>(${(badReviewP)?string("#.#")}%)</span></div>
                                <div class="sumratebar"><span style="width:${(badReviewP)?string("#.#")}%"></span></div>
                            </li>
                        </ul>
                        <div class="review-intro">
                            <p>发表评论让消费者了解您的购买心得，与广大网友沟通讨论您的购买理念,赶快发表您的评论吧！</p>
                        </div>
                    </div>
                    <div class="review-filter">
                        <ul>
                            <li onclick="javascript:switchReviewShow(0);" class="selected"><input id="rate-all" type="radio" name="review-filter" checked><label
                                    for="rate-all">全部评价</label></li>
                            <li onclick="javascript:switchReviewShow(1);"><input id="rate-good" type="radio" name="review-filter"><label
                                    for="rate-good">好评(${goodReview})</label></li>
                            <li onclick="javascript:switchReviewShow(2);"><input id="rate-normal" type="radio" name="review-filter"><label for="rate-normal">中评(${mediumReview})</label>
                            </li>
                            <li onclick="javascript:switchReviewShow(3);"><input id="rate-bad" type="radio" name="review-filter"><label
                                    for="rate-bad">差评(${badReview})</label></li>
                        </ul>
                    </div>
                    <div class="review-list">
                        <ul>
                        	<#if productReviewList?? && productReviewList?has_content>
                        		<#list productReviewList as productReview>
				                <li>
	                                <div class="review-user">
	                                    <div class="userimg"><img src="${(productReview.headPortraitUrl)!?html}"></div>
	                                    <div class="username"><a href="javascript:void(0);">${(productReview.reviewerName)!?html}</a></div>
	                                    <div class="userintro">${(productReview.userLevelName)!?html}　${(productReview.areaName)!?html}</div>
	                                </div>
	                                <div class="review-content">
	                                    <span class="review-time">${(productReview.reviewTime)?string("yyyy-MM-dd HH:mm:ss ")!}</span>
	                                    <span class="ratestar">
	                                    	<span class="review-star review-star-${(productReview.productMatchScore)?default(0)*2}"><b></b></span>
	                                    </span>
	
	                                    <div class="content">
	                                        <p class="review-exp">
	                                            <span class="tit">心得：</span><span class="con">${(productReview.reviewContent)!?html}</span>
	                                        </p>
	
	                                        <p class="review-buytime"><span class="tit">购买时间：</span><span class="con">${(productReview.createTime)?string("yyyy-MM-dd hh:mm:ss")!}</span>
	                                        </p>
	                                    </div>
	                                    <#if productReview.pics??>
		                                    <div class="review-img">
		                                    	<#list productReview.pics?split(",") as pic>
		                                        <div class="pic"><a rel="gallery${(productReview.reviewId)!?html}" class="boxer" href="${(pic)!}"><img alt="" src="${(pic)!}"></a></div>
	                                    		</#list>
	                                    	</div>
                                    	</#if>
	                                  <#if productReview.replyContent?? && productReview.replyContent?has_content>
	                                 	  <div class="answer clearfix">
	                                        <dl>
	                                            <dt>回复：</dt>
	                                            <dd>
												${(productReview.replyContent)!?html}	
	                                            </dd>
	                                        </dl>
	                                        <span>${(productReview.replyTime)?string("yyyy-MM-dd hh:mm:ss")!}</span>
                            				</div>
                                    	</#if> 
	                                </div>
                            	</li>
                            	</#list>
                            	<div class="loadmore" ><a onClick="toReviewList();" href="javascript:void(0);">显示更多</a></div>
                            	
			                <#else>
				                <li style="text-align: center; padding-left: 0px;">当前无相关评论</li>
			                </#if>
                    </ul>
                </div>
    			<div id="consults" class="detail-consults">
                    <h3 class="hd"><span>购买咨询</span></h3>

                    <div class="consult-list">
                    	<#if userConsultInfoList?? && userConsultInfoList?has_content>
		                	<div class="consulting">
			                    <ul>
			                    	<#list userConsultInfoList as userConsultInfo>
				                        <li class="consultdetail">
			                                <div class="ask clearfix">
			                                    <dl>
			                                        <dt>提问：</dt>
			                                        <dd>${userConsultInfo.content}</dd>
			                                    </dl>
			                                    <span>提问者：${userConsultInfo.loginName}  ${(userConsultInfo.createTime)?string("yyyy-MM-dd HH:mm:ss ")}</span>
			                                </div>
			                                <div class="answer clearfix">
			                                    <dl>
			                                        <dt>回答：</dt>
			                                        <dd>
			                                        ${userConsultInfo.replyContent}
			                                        </dd>
			                                    </dl>
			                                    <span>回答者：【管理员】${(userConsultInfo.replyTime)?string("yyyy-MM-dd HH:mm:ss ")}</span>
			                                </div>
			                            </li>
			                        </#list>
			                    </ul>
		                	</div>
		                	<div style="background:#fcfcfc; overflow: hidden; zoom:1; margin-top: 10px;">
		                		<span style="float: left;">购买之前，如有问题，请咨询。<a target="_blank" onClick="toConsultList();" href="javascript:void(0);">[发表咨询]</a></span>
                          	</div>
                          <div class="loadmore"><a onClick="toConsultList();" href="javascript:void(0);">显示更多</a></div>
                        
                        <#else>
                        	<ul>
                                <li style="text-align: center; padding-left: 0px;">当前无相关咨询</li>
                            </ul>
                            <div style="background:#fcfcfc; overflow: hidden; zoom:1; margin-top: 10px;">
		                		<span style="float: left;">购买之前，如有问题，请咨询。<a target="_blank" onClick="toConsultList();" href="javascript:void(0);">[发表咨询]</a></span>
                          	</div>
                        </#if>
                    </div>
                </div>

                <div class="block">
                    <h2 class="blocktitle"><span>您最近浏览过</span></h2>

                    <div class="blockcon">
                        <ul class="goodslist-grid">
	                        <#if historyProductList?has_content>
		                       <#list historyProductList as historyProduct>
	                            <li>
	                            	<a href="${ctx}/product/${historyProduct.productId}">
	                                <span class="goodspic"><img src="${historyProduct.picUrl}" alt=""></span>
	                                <span class="goodsprice" style="margin-top:0px;">惊爆价：<em class="price">¥${historyProduct.defaultPrice}</em></span>
	                                <span class="goodsname" style="text-align:center;margin-top:0px;">${historyProduct.productName}</span>
	                            	</a>
	                            </li>
	                          </#list>
	                        </#if>
                           
                        </ul>
                	</div>
            	</div>
    
    
    </div>
            
               
                
	        </div>
	    </div>
	</div>
</div>
</div>


<script>
	var realStock=	${product.realStock};
 	var addToCartFlag = true;        
        function addToCart(productId){
        <#if userId?? && userId?has_content>
            if(!addToCartFlag) { return; }//防止多次提交
            addToCartFlag = false;
 			var quantity = $('.textfield').val();
 			if(quantity>realStock){
 				layer.msg("商品库存不足!");
 				return;
 			}
            var submitData={};
            submitData.productId = productId;
            submitData.quantity =quantity;
            submitData.userId = '${userId}';
            $.ajax({
                url  : '${ctx}/cart/add',
                async : true,
                type : "GET",
                dataType : "json",
                data : submitData,
                success : function(result) {
                   if(result.result == 'success') {
                        layer.msg("添加成功!");
                    }if(result.result=='error'){
                        layer.msg(result.message);
                    }
                   addToCartFlag = true;
                },
                error:function(XMLHttpResponse ){
                    layer.msg(XMLHttpResponse.message);
                   	addToCartFlag = true;
                }
            });
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
	    
	function buyNow(productId){
	        <#if userId?? && userId?has_content>
	           	var quantity = $('.textfield').val();
	           	if(quantity>realStock){
	 				layer.msg("商品库存不足!");
	 				return;
 				}
                window.location.href = "${ctx}/cart/buyNow?productId=" + productId + "&quantity=" + quantity;
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
	function toConsultList(productId){
	    <#if userId?? && userId?has_content>
	        window.location.href="${ctx}/product/consultList?productId=${product.productId}&&goodReviewP=${(goodReviewP)?string("#.#")}";
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
	function toReviewList(productId){
	    window.location.href="${ctx}/product/showReviewListPage?productId=${product.productId}&&goToPage=1&&type=0";
	    
	}
$(function(){
    var tabbox = $(".detail-tabbox"),tabboxwrap = $(".detail-tabbox-wrap");
    var tabheight = tabbox.height(),tabtop = tabbox.offset().top,footertop = $("#footer").offset().top;
    tabbox.height(tabheight);

    $(window).on("scroll",function(){
        var scrolltop = $(this).scrollTop();
        tabboxwrap.removeAttr("style");
        footertop = $("#footer").offset().top;
        if(scrolltop > tabtop && scrolltop+tabheight <= footertop){
            tabboxwrap.addClass("detail-tabbox-fix");
        }else{
            tabboxwrap.removeClass("detail-tabbox-fix");
            if(scrolltop+tabheight > footertop){
                tabboxwrap.css({
                    position:"absolute",
                    top:footertop-tabheight
                });
            }
        }
    });

    tabbox.find(".detail-tabbar a").on("click",function(e){
        e.preventDefault();
        if($(window).scrollTop() < tabtop) return;
        var target = $(this.hash);
        if(target[0]){
            var top = target.offset().top - tabheight;
            $(window).scrollTop(top);
        }
    });

    var comboNav = $('.combo-nav');
    comboNav.switchable({
        triggers: false,
        panels: 'li',
        easing: 'ease-in-out',
        effect: 'scrollLeft',
        loop : true,
        duration: 0.2,
        next: comboNav.find('.next'),
        prev: comboNav.find('.prev')
    });


    var goodsSideSlide = $('#J_GoodsSideSlide');
    goodsSideSlide.switchable({
        triggers: false,
        panels: 'li',
        easing: 'ease-in-out',
        effect: 'scrollUp',
        steps: 3,
        visible: 3,
        end2end: true,
        autoplay: false,
        prev: goodsSideSlide.find('.prev'),
        next: goodsSideSlide.find('.next')
    });

    var hotsailSlide = $('.hotsail-slide');
    hotsailSlide.switchable({
        triggers: '&bull;',
        putTriggers: 'appendTo',
        panels: 'li',
        easing: 'ease-in-out',
        effect: 'scrollLeft',
        steps: 3,
        visible: 3,
        loop : true,
        autoplay: true
    });

    
})
</script>
</body>
<script>
    with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion='+~(-new Date()/36e5)];
</script>
</html>
