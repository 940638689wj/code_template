<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
<meta charset="UTF-8">
<title>Lbd</title>
<script type="text/javascript" src="${ctx}/static/admin/js/bui.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/admin.js"></script>

</head>
<body>
<script type="text/javascript">
	function goPage(targetPage,type){
		var productId = ${product.productId};
     	window.location.href ="${ctx}/product/showReviewListPage?productId="+productId+"&&goToPage="+targetPage+"&&type="+type;   
    }
     $(function(){
  		$(":radio").click(function(){
   		//alert("您是..." + $(this).val());
   		goPage(1,$(this).val())
  		});
  	});
</script>
<div id="page">
	<div class="layout">
        <div class="crumb">
			您的位置：<a href="${ctx}/index.html">首页</a>&gt; <a href="${ctx}/product/${(product.productId)!?html}">${(product.productName)!?html}</a> 
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
		<div class="detail-bd clearfix">
			<div class="detail-reviews">
				<h3 class="hd">商品评价</h3>
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
						<li ><input id="rate-all" value="0"type="radio" name="review-filter" <#if type==0>checked</#if>><label for="rate-all">全部评价</label></li>
						<li ><input id="rate-good" type="radio" value="1" name="review-filter" <#if type==1>checked</#if>><label for="rate-good">好评(${goodReview})</label></li>
						<li ><input id="rate-normal" type="radio" value="2" name="review-filter" <#if type==2>checked</#if>><label for="rate-normal">中评(${mediumReview})</label></li>
						<li ><input id="rate-bad" type="radio" value="3" name="review-filter" <#if type==3>checked</#if>><label for="rate-bad">差评(${badReview})</label></li>
					</ul>
				</div>
				<#assign productReviewList = pageDTO.content>
				<div class="review-list">
					<ul>
						<#if productReviewList?? && productReviewList?has_content>
                    		<#list productReviewList as productReview>
			                <li>
                                <div class="review-user">
                                    <div class="userimg"><img src="${(productReview.headPortraitUrl)!?html}"></div>
                                    <div class="username"><a href="#">${(productReview.reviewerName)!?html}</a></div>
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

                                        <p class="review-buytime"><span class="tit">购买时间：</span><span class="con">${(productReview.createTime)?string("yyyy-MM-dd")!}</span>
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
                                        <span>${(productReview.replyTime)?string("yyyy-MM-dd")!}</span>
                        				</div>
                                	</#if> 
                                </div>
                        	</li>
                        	</#list>
                          </#if>
					</ul>
				</div>
			</div>
			<div class="pagination">
			     <@pager pageDTO/>
			</div>
			<#macro pager pageDTO steps=3>
			    <#assign page = pageDTO.page>
			    <#assign totalPages = pageDTO.totalPage>
			
			    <#assign startRangeIndex = page - steps/>
			    <#if startRangeIndex lt 1>
			        <#assign startRangeIndex = 1/>
			    </#if>
			    <#assign endRangeIndex = page + steps/>
			    <#if endRangeIndex gte totalPages>
			        <#assign endRangeIndex = totalPages/>
			    </#if>
			    <#if page gt 1>
			        <a class="prev" href="javascript:goPage(${page -1},${type});"><i></i>上一页</a>
			    <#else>
			        <a class="prev disabled"><i></i>上一页</a>
			    </#if>
			    <#if startRangeIndex gt 1>
			        <a href='javascript:goPage(1,${type});'>1</a> <b>...</b>
			    </#if>
			    <#list startRangeIndex..endRangeIndex as currPage>
			        <#if currPage==page>
			            <b class="page-cur">${page}</b>
			        <#elseif currPage!=0>
			            <a href='javascript:goPage(${currPage},${type});'>${currPage}</a>
			        </#if>
			    </#list>
			    <#if endRangeIndex lt totalPages>
			        <b>...</b><a href='javascript:goPage(${totalPages},${type});'>${totalPages}</a>
			    </#if>
			    <#if page lt totalPages>
			        <a class="next" href="javascript:goPage(${page+1},${type});">下一页<i></i></a>
			    <#else>
			        <a class="next disabled">下一页<i></i></a>
			    </#if>
			</#macro>
		</div>
    </div>
</div>

</body>
</html>