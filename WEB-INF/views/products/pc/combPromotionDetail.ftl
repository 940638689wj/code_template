<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title></title>
   <script src="${ctx}/static/js/jquery.imagezoom.min.js"></script>
	<script src="${ctx}/static/js/boxer.min.js"></script>
	<link rel="stylesheet" href="${staticPath}/css/fsboxer.css">
</head>
<body class="page-list">

<div id="main">
    <div class="shoptb">
        <div class="shoptb-hd">
            <table>
                <tbody>
                <tr>
                    <td class="td-product">搭配套餐1</td>
                    <td class="td-price">价格</td>
                    <td class="td-amount">数量</td>
                    <td class="td-total">库存</td>
                </tr>
                </tbody>
            </table>
        </div>
        <input type="hidden" id="promotionId" value="${promotionId!}">
       <div id="productList">
        <!--<div class="shoptb-row">
            <table>
                <tbody>
                <tr>
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
                    <td class="td-total"><em>￥50</em></td>
                    <td class="td-amount">1</td>
                    <td class="td-price"><span class="text-red">199</span>件</td>
                </tr>
                </tbody>
            </table>
        </div>
        
        <div class="shoptb-row shoptb-disabled">
            <table>
                <tbody>
                <tr>
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
                    <td class="td-total"><em>￥50</em></td>
                    <td class="td-amount">1</td>
                    <td class="td-price"><span class="text-red">199</span>件</td>
                </tr>
                </tbody>
            </table>
        </div>-->
        </div>
        <div class="shoptb-foot-wrap">
            <div class="shoptb-foot">
                <div class="tbft-r">
                    <div class="btn-buy" id="buyNow">
                        <a href="#" onClick="toOrder()"><span>立即购买</span></a>
                    </div>
                </div>
                <div class="tbft-total">
                    <ul>
                    	<!--一套的价格-->
                    	<input type="hidden" id="combPrice" value="0"/>
                    	<input type="hidden" id="defaultPrice" value="0"/>
                    	
                        <li>原价：￥<em id="defaultPriceAmt">0.00</em></li>
                        <li>搭配价：<span class="price-real">￥<em id="combPriceAmt">0.00</em></span></li>
                        <li>
                            <span class="amount-widget tc">
                                <input type="number" class="textfield" value="1">
                                <span class="increase"></span>
                                <span class="decrease increase-disabled"></span>
                            </span>
                            <span class="ml20" id="limitNum">限购0套</span>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
var disableDesc ="商品";
var limit = 0;
$(function(){
	getCombproductList();
})

function getCombproductList(){
	var promotionId = $("#promotionId").val();
	$.ajax({
    		url  : '${ctx}/product/getCombPromotionDetail',
        	type : "GET",
			dataType : "json",
			data : {"promotionId":promotionId},
			success : function(data) {
				var combTotalAmt = 0;
			    var defaultTotalAmt = 0;
				if(data!=null){
					$("#limitNum").html("限购"+data.limitNum+"套");
					var htmlStr='';
					var dataLength = data.combProductList.length;
					if(dataLength>0){
						limit =data.limitNum;
						$(".td-product").html(data.combProductList[0].promotionName);
						for(var i=0;i<dataLength;i++){
							combTotalAmt+=eval(data.combProductList[i].price);
							defaultTotalAmt+=eval(data.combProductList[i].defaultPrice);
							if(data.combProductList[i].productStatusCd==1){
								htmlStr+='<div class="shoptb-row"><table><tbody><tr><td class="td-product">';
							}else{
								disableDesc+=data.combProductList[i].productName+",";
								$("#buyNow").addClass("btn-buy-disabled");
								htmlStr+='<div class="shoptb-row"><tr><td class="td-product">';
							}
		                    htmlStr+='<div class="first-column">'+
					                '<div class="img"><a href="#"><img src="${ctx}'+data.combProductList[i].productPicUrl+'"></a></div>'+
					                '<div class="info">'+
	                                '<div class="name"><a href="../goods_detail.html" target="_blank">'+data.combProductList[i].productName+'</a></div>';
                        			if(data.combProductList[i].skuDesc!=null && data.combProductList[i].skuDesc!="" ){
	                                	htmlStr+='<div class="prop"><span>'+data.combProductList[i].skuDesc+'</span></div>';
	                                }
                            htmlStr+='</div></div></td><td class="td-total">￥<em class="combPrice">'+(data.combProductList[i].price).toFixed(2)+'</em></td>'+
					                '<td class="td-amount">1</td>'+
					                '<td class="td-price"><span class="text-red">'+data.combProductList[i].realStock+'</span>件</td>'+
					                '</tr></tbody></table></div>';
						}
						disableDesc+="已下架！"
						$("#productList").append(htmlStr);
						$("#defaultPriceAmt").html(defaultTotalAmt.toFixed(2));
						$("#combPriceAmt").html(combTotalAmt.toFixed(2));
						$("#combPrice").val(combTotalAmt);
						$("#defaultPrice").val(defaultTotalAmt);
					}
				}
			}
		});
}

//计算金额
function account(){
	
	var combPrice = $("#combPrice").val();
	var defaultPrice = $("#defaultPrice").val();
	var buyNum = $(".textfield").val();
	$("#defaultPriceAmt").html((eval(defaultPrice)*eval(buyNum)).toFixed(2));
    $("#combPriceAmt").html((eval(combPrice)*eval(buyNum)).toFixed(2));
}

	var cartList = $(".amount-widget");
	var payAmt=$("#combTotalAmt").html();
	//加数量
	cartList.on('click','.increase',function() {
		var number = $(this).parent().find('.textfield').val();
		if(number == limit) {
		  $(this).parent().find(".increase").attr("class","increase disabled");
			return;
		}
		
		if(eval(number) > eval(limit)) {
	    	 layer.msg("商品的购买数量不能超过"+limit);
	    	$(this).parent().find(".increase").attr("class","increase disabled");
			$(this).parent().find('.textfield').val(1);
			return;
	    }
	
		$(this).parent().find(".decrease").attr("class","decrease");
		number++;
		$(this).parent().find('.textfield').val(number);
		account();
	});
	
	//减数量
	cartList.on('click','.decrease',function() {
		var number = $(this).parent().find('.textfield').val();
		if(number == 1 ) {
		  $(this).parent().find(".decrease").attr("class","decrease disabled");
			return;
		}
	
		$(this).parent().find(".increase").attr("class","increase");
		
		number--;
		$(this).parent().find('.textfield').val(number);
		account();
	});
	
	 //直接改变商品的数量
	cartList.on('change','.textfield',function() {
		var num = $(this).val();
		var reg = new RegExp("^[1-9][0-9]*$");
		if(!reg.test(num)){  
			//还原原来的数量
			$(this).parent().find('.textfield').val(1);
	        layer.msg('商品数量只能输入正整数！');
	        return;
	    }
	
	    if(parseInt(num) > limit) {
	    	 layer.msg("商品的购买数量不能超过"+limit);
			$(this).parent().find('.textfield').val(1);
			return;
	    }
	    $(this).parent().find('.textfield').val(num);
	    account();
	});
	
	function toOrder(){
		var buyNum = $(".textfield").val();
		var pid = $("#promotionId").val();
		if(limit<=0){
			 layer.msg("库存不足，无法购买！");
			return false;
		}
		if($("#buyNow").hasClass("btn-buy-disabled")){
			 layer.msg(disableDesc);
			return false;
		}
		location.href="${ctx}/account/order/submitOrder?pid="+pid+"&num="+buyNum;
	}
</script>
<script>
    $(function(){
        $(".topshopcart").hover(getCartContent, removeCartContent);
    })
    function getCartContent(){
        $(".topshopcart").addClass("cart-hover");
    }
    function removeCartContent(){
        $(".topshopcart").removeClass("cart-hover");
    }
</script>
</body>
</html>