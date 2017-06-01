<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>lbd</title>
<#assign consultDetailList = pageDTO.content>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<script type="text/javascript" src="${ctx}/static/admin/js/bui.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/admin.js"></script>

</head>


<body>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<script type="text/javascript">
	 var productId = ${product.productId};
	
    function goPage(targetPage){
     	window.location.href ="${ctx}/product/list/" + productId + "/showAjaxpage?goToPage="+targetPage;   
    }
	 function doConsult(){
	        var consultContent = $("#textarea_id").val();
	        var errorObj = $("#strError_textarea_id");
	         
	         if(errorObj.is(":visible")){
	            alert("字数超过限制!");
	            return;
	        }
	        if(consultContent.trim().length <= 0){
	            alert("咨询内容不能为空!");
	            return;
	        }
	
	        app.ajaxHelper.submitRequest({
	            url: "${ctx}/m/product/consulting/add",
	            type: 'POST',
	            data: { productId:productId,content : consultContent},
	            success : function(data) {
	                if(app.ajaxHelper.handleAjaxMsg(data)){
	                     $("#textarea_content").val('');
                		alert("提交成功，请耐心等待回复...");
                		$("#textarea_id").val('');
	                } else {
	                    alert("提交失败");
	                }
	            },
	            error: function(xmlHttpRequest, errorStatus, errorThrow){
	                alert(errorStatus + "提交失败，请稍后重试!");
	            }
	        });
	    }
</script>
<#macro countTextArea maxInputNum textareaId = 'textarea_id' textareaname = 'reviewText'>
    <#assign maxNum = maxInputNum>
    <#assign textarea_id = textareaId>
    <#assign textarea_name = textareaname>
    <#include "${ctx}/common/pc/cacl_word_textarea.ftl">
</#macro>
<div id="page">
	<div class="layout">
        <div class="crumb">
			您的位置：<a href="${ctx}/index.html">首页</a>&gt;<a href="#">${(product.productName)!?html}</a> 
		</div>
		<div class="goodsitem">
			<div class="goodspic">
				<a href="#"><img src="${(productPic)!?html}" alt=""></a>
			</div>
			<div class="goodsname">${(product.productName)!?html}</div>
			<div class="goodsprop">
				<p><span class="tit">评价得分：</span>
				<span class="review-star review-star-${((productSumInfo.productMatchScoreAvg)!'0')}"><b></b></span>
				</p>
				<p><span class="tit">评价数：</span><span class="con">${(productSumInfo.mainReviewCnt)?default(0)?string("#.##")}评论，${(goodReviewP)?default(0)?string("#.##")}% 推荐</span></p>
			</div>
			<div class="goodsprice"><span class="tit">售价:</span><span class="con">￥${(product.defaultPrice)!?html}</span></div>
		</div>
		<div id="listAndPaging" class="detail-bd clearfix">
			<#include "consultGridLayout.ftl">
		</div>
		<div class="commentblock">
			<h3>发表咨询</h3>
			<p>你可以对商品价格、库存和购买过程中的任何问题进行咨询，我们会有专业的客服为您答复。因商品的颜色、包装和产地等参数可能会有更改，所以答复仅在当时对提问者有效，其他网友仅供参考！ 咨询的回复时间为：9:00-18:00，请耐心等待客服回复。</p>
			<div class="commentform">
				<ul>
					<li>
						<div class="tit">咨询内容：</div>
						<div class="con">
							<@countTextArea 200></@countTextArea>
						</div>
					</li>
					<li><div class="btnbar">
						<a href="javascript:void(0);" onclick="javascript:doConsult();" class="btn"><span>提 交</span></a>
					</div></li>
				</ul>
			</div>
		</div>
    </div>
</div>


</body>
</html>