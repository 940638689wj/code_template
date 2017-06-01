<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<!doctype html>
<html lang="en">
<head>
	<title>套餐详情</title>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
    	<#if productId?has_content>
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/product/${productId!}"></a>
        <#else>
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        </#if>
        <h1 class="mui-title">套餐详情</h1>
        <a class="mui-icon"></a>
    </header>
    <input type="hidden" id="promotionId" value="${promotionId!}"/>
    <input type="hidden" id="userId" value="${userId!}"/>
    <div class="mui-content">
        <div class="borderbox">
            <h3 class="title">套餐详情</h3>
            <ul class="prd-list b-bottom" id="pro_list">
               <!--<li>
                    <div class="pic">
                        <img src="images/goodspic.jpg">
                    </div>
                    <div class="r">
                        <p class="name">商品标题商品标题商品标题…</p>
                        <div class="price">
                            <div class="price-real">¥<em>6.90</em></div>
                            <span class="price-origin">¥6.90</span>
                        </div>
                        <p class="participant">数量：1</p><span class="specifications">规格：1L</span>
                    </div>
                </li>
                <li>
                    <div class="pic">
                        <img src="images/goodspic.jpg">
                    </div>
                    <div class="r">
                        <p class="name">商品标题商品标题商品标题…</p>
                        <div class="price">
                            <div class="price-real">¥<em>6.90</em></div>
                            <span class="price-origin">¥6.90</span>
                        </div>
                        <p class="participant">数量：1</p>
                    </div>
                </li> -->
            </ul>
        </div>
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                    <li>
                        <a href="javascript:void(0);">
                            <div class="r orange">立省￥<em id="economizePrice"><em></div>
                            <div class="c">套餐价：
                                <div class="price">
                                <i class="price-real">¥<em id="combTotalAmt"></em></i>
                                <i class="price-origin">¥<em id="defaultTotalAmt"><em></i>
                                </div>
                            </div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="group-ordernum">
                <ul>
                    <li>
                        <div class="r">
                            <div class="number-widget">
                                <div class="number-minus disabled"></div>
                                <input class="number-text" type="number" id="buyNum" value="1">
                                <div class="number-plus"></div>
                            </div>
                        </div>
                        <div class="c">最多可购买<span id="limitNum">199</span>套</div>
                    </li>
                </ul>
            </div>
        </div>
		
        <div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in content-cartwrap-in">
                        <div class="r">
                            <div class="main-info"><i>实付：</i>¥<span id="payAmt"></span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap">
                    <#--<a class="button" href="${ctx}/m/account/combProductOrder/toCombProductOrder">确定</a>-->
                    <a class="button" href="#" onClick="toOrder()">确定</a>
                </div>
            </div>
        </div>
		
    </div>
</div>
<script>
var disableDesc ="商品";
var isDisable = false;
$(function(){
	getCombproductList();
})

function getCombproductList(){
	var promotionId = $("#promotionId").val();
	$.ajax({
    		url  : '${ctx}/m/product/combProductList',
        	type : "GET",
			dataType : "json",
			data : {"promotionId":promotionId},
			success : function(data) {
				if(data!=null){
					$("#limitNum").html(data.limitNum);
					var htmlStr='';
					var dataLength = data.combProductList.length;
					if(dataLength>0){
						for(var i=0;i<dataLength;i++){
							if(data.combProductList[i].productStatusCd==1){
								htmlStr+='<li><div class="pic"><img src="${ctx}'+data.combProductList[i].productPicUrl+'"></div>';
		                		htmlStr+='<div class="r"><p class="name">'+data.combProductList[i].productName+'</p><div class="price">';
		                        htmlStr+='<div class="price-real">¥<em class="combPrice">'+(data.combProductList[i].price).toFixed(2)+'</em></div>';
		                        htmlStr+='<span class="price-origin" >¥<em class="defaultPrice">'+(data.combProductList[i].defaultPrice).toFixed(2)+'</em></span></div><p class="participant">数量：1</p>';
		                        if(data.combProductList[i].skuDesc!=null && data.combProductList[i].skuDesc!="" ){
		                        	 htmlStr+='<p class="participant">'+data.combProductList[i].skuDesc+'</p>';
		                        }
	                        	htmlStr+='</div></li>';
							}else{
								isDisable=true;
								disableDesc+=data.combProductList[i].productName+",";
								htmlStr+='<li class="disable"><div class="pic"><img src="${ctx}'+data.combProductList[i].productPicUrl+'"></div>';
		                		htmlStr+='<div class="r"><p class="name">'+data.combProductList[i].productName+'</p>';
	                        	htmlStr+='<p class="name orange">商品已失效</p></div></li>';
							}
						}
						disableDesc+="已下架！"
						$("#pro_list").append(htmlStr);
						account();
					}
				}
			}
		});
}

//计算金额
function account(){
	var combTotalAmt = 0;
	var defaultTotalAmt = 0;
	var buyNum = $("#buyNum").val();
	$(".combPrice").each(function(){
		combTotalAmt+=eval($(this).html());
	});
	$(".defaultPrice").each(function(){
		defaultTotalAmt+=eval($(this).html());
	});
	$("#combTotalAmt").html(combTotalAmt.toFixed(2));
	$("#defaultTotalAmt").html(defaultTotalAmt.toFixed(2));
	$("#economizePrice").html((eval(defaultTotalAmt)-eval(combTotalAmt)).toFixed(2));
	$("#payAmt").html(eval(combTotalAmt*buyNum).toFixed(2));
}

	var cartList = $(".number-widget");
	var payAmt=$("#combTotalAmt").html();
	//加数量
	cartList.on('click','.number-plus',function() {
		var realStock = $("#limitNum").html();//限购数量
		var number = $(this).parent().find('.number-text').val();
		if(number == realStock) {
		  $(this).parent().find(".number-plus").attr("class","number-plus disabled");
			return;
		}
		
		if(eval(number) > eval(realStock)) {
	    	mui.toast("商品的购买数量不能超过"+realStock);
	    	$(this).parent().find(".number-plus").attr("class","number-plus disabled");
			$(this).parent().find('.number-text').val(1);
			return;
	    }
	
		$(this).parent().find(".number-minus").attr("class","number-minus");
		number++;
		$(this).parent().find('.number-text').val(number);
		account();
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
		account();
	});
	
	 //直接改变商品的数量
	cartList.on('change','.number-text',function() {
		var realStock = $("#limitNum").html();//限购数量
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
	    account();
	});
	
	function toOrder(){
		var realStock = $("#limitNum").html();//限购数量
		var buyNum = $("#buyNum").val();
		var pid = $("#promotionId").val();
		if(realStock<=0){
			mui.toast("库存不足，无法购买！");
			return false;
		}
		if(isDisable){
			mui.toast(disableDesc);
			return false;
		}
		location.href="${ctx}/m/account/order/submitOrder?pid="+pid+"&num="+buyNum;
	}
</script>
</body>
</html>