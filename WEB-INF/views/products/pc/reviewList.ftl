<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

        <ul>
        <#assign productReviewList = pageDTO.content>
        <#if productReviewList?? && productReviewList?has_content>
            <#list productReviewList as productReview>
            <li>
                <div class="review-user">
                    <div class="userimg"><img src="${(productReview.headPortraitUrl)!?html}"></div>
                    <div class="username"><a href="#">${(productReview.reviewerName)!?html}</a></div>
                </div>
                <div class="review-content">
                    <span class="review-time">${(productReview.reviewTime)?string("yyyy-MM-dd HH:mm:ss ")!}</span>
                    <span class="review-star review-star-${(productReview.productMatchScore)?default(0)}"><b></b></span>

                    <div class="content">
                        <p class="review-exp">
                            <span class="tit">心得：</span><span class="con">${(productReview.reviewContent)!?html}</span>
                        </p>
                        <!--<p class="review-color"><span class="tit">颜色：</span><span class="con">白色</span>
                        </p>

                        <p class="review-type"><span class="tit">型号：</span><span class="con">M</span>
                        </p>-->

                        <p class="review-buytime"><span class="tit">购买时间：</span><span class="con">${(productReview.reviewTime)?string("yyyy-MM-dd HH:mm:ss")!}</span>
                        </p>
                    </div>
                    <#if productReview.pics??>
                    <div class="review-img">
                    	<#list productReview.pics?split(",") as pic>
                        <div class="pic"><a rel="gallery${(productReview.reviewId)!?html}" class="boxer" href="${ctx}${(pic)!}"><img alt="" src="${(pic)!}"></a></div>
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
                        <span>${(productReview.replyTime)?string("yyyy-MM-dd HH:mm:ss")!}</span>
                    </div>
                    </#if> 
                </div>
            </li>
            </#list>  
            <#else>
             	<div class="moudle_prompt">暂无商品评价</div>
            </#if>
        </ul>
        <#if productReviewList?? && productReviewList?has_content>
		    <div class="pr-pager">
		        <div class="pager">
		            <!--<a href="#">&lt;上一页</a>
		            <a href="#">1</a>
		            <a class="cur">2</a>
		            <a>...</a>
		            <a href="#">下一页&gt;</a>-->
		            <@pager pageDTO/>
		        </div>
		    </div>
		</#if>
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
		        <a class="" href="javascript:gotoPage(${type},${page -1});"><i></i>上一页</a>
		    <#else>
		        <a class="disabled"><i></i>上一页</a>
		    </#if>
		    <#if startRangeIndex gt 1>
		        <a href='#'>1</a> <b>...</b>
		    </#if>
		    <#list startRangeIndex..endRangeIndex as currPage>
		        <#if currPage==page>
		            <b class="cur">${page}</b>
		        <#elseif currPage!=0>
		            <a href='javascript:gotoPage(${type},${currPage});'>${currPage}</a>
		        </#if>
		    </#list>
		    <#if endRangeIndex lt totalPages>
		        <b>...</b><a href='#'>${totalPages}</a>
		    </#if>
		    <#if page lt totalPages>
		        <a class="" href="javascript:gotoPage(${type},${page +1});">下一页<i></i></a>
		    <#else>
		        <a class="disabled">下一页<i></i></a>
		    </#if>
		</#macro>
   
   



