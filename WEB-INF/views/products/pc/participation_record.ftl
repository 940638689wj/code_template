<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
 <div class="zc-record">
	<div class="record-bar"><p>时间</p><span>会员</span><em>购买数量</em></div>
	<div class="record-list">
	<ul>
	<#assign dealRecordList = dealRecordPageDTO.content>
        <#if dealRecordList?? && dealRecordList?has_content>
            <#list dealRecordList as dealRecord>
            <li><p>${(dealRecord.createTime)?string("yyyy-MM-dd HH:mm:ss")!}</p><span>${(dealRecord.createTime)?string("yyyy-MM-dd HH:mm:ss")!}</span><em>${(dealRecord.quantity)!?html}</em></li>
	        </#list> 
        <#else>
         	<div class="moudle_prompt">暂无成交记录</div>
        </#if>
	</ul>
	</div>
</div>
	<#if dealRecordList?? && dealRecordList?has_content>
		    <div class="pr-pager">
		        <div class="pager">
		            <!--<a href="#">&lt;上一页</a>
		            <a href="#">1</a>
		            <a class="cur">2</a>
		            <a>...</a>
		            <a href="#">下一页&gt;</a>-->
		            <@pager dealRecordPageDTO/>
		        </div>
		    </div>
		</#if>
  		<#macro pager dealRecordPageDTO steps=3>
		    <#assign page_record = dealRecordPageDTO.page>
		    <#assign totalPages_record = dealRecordPageDTO.totalPage>
		
		    <#assign startRangeIndex_record = page_record - steps/>
		    <#if startRangeIndex_record lt 1>
		        <#assign startRangeIndex_record = 1/>
		    </#if>
		    <#assign endRangeIndex_record = page_record + steps/>
		    <#if endRangeIndex_record gte totalPages_record>
		        <#assign endRangeIndex_record = totalPages_record/>
		    </#if>
		    <#if page_record gt 1>
		        <a class="" href="javascript:gotoRecordPage(${page_record -1});"><i></i>上一页</a>
		    <#else>
		        <a class="disabled"><i></i>上一页</a>
		    </#if>
		    <#if startRangeIndex_record gt 1>
		        <a href='#'>1</a> <b>...</b>
		    </#if>
		    <#list startRangeIndex_record..endRangeIndex_record as currPage_record>
		        <#if currPage_record==page_record>
		            <b class="cur">${dealRecordPage}</b>
		        <#elseif currPage_record!=0>
		            <a href='javascript:gotoRecordPage(${currPage_record});'>${currPage_record}</a>
		        </#if>
		    </#list>
		    <#if endRangeIndex_record lt totalPages_record>
		        <b>...</b><a href='#'>${totalPages_record}</a>
		    </#if>
		    <#if page_record lt totalPages_record>
		        <a class="" href="javascript:gotoRecordPage(${page_record +1});">下一页<i></i></a>
		    <#else>
		        <a class="disabled">下一页<i></i></a>
		    </#if>
		</#macro>