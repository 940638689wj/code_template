<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<#assign ctx = request.contextPath>
<div class="prd-pics" style="position:absolute; left: 0; top: 0; width: 200px;">
    <div class="prd-upload">
        <div class="prd-upload-icon">
            <#if productPicInfo?? && productPicInfo.picUrl?has_content>
                <#assign imageMap = productPicInfo.picUrl/>
                <img id="primary_image_review" data-image-form-type="media" src="${imageMap?default('')}" style="width: 150px;height: 150px;">
            </#if>
        </div>
    </div>
    <div class="prd-thumblist" style="padding:0 20px;">
        <p style="text-align: left;"><#if product?? && (product.productName)??>${(product.productName)!?html}</#if></p>
	    <p style="text-align: left;"><#if product?? && (product.tagPrice)??><em>吊牌价:</em> ${(product.tagPrice)!?html}</#if></p>
        <p style="text-align: left;"><#if product?? && (product.defaultPrice)??><em>销售价格:</em>${(product.defaultPrice)!?html}</#if></p>
        <hr>
        <#if productSumInfo??>
	        <p style="text-align: left;">
	            评价得分：
	            
	           <!-- <img src="${ctx}/images/star-off.png"> -->
			<span class="review-star review-star-${productSumInfo.productMatchScoreAvg}"><b></b></span>
	        </p>
	        <p style="text-align: left;">评价数：${productSumInfo.mainReviewCnt}</p>
    	</#if>
    </div>
</div>