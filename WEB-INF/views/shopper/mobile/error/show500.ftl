<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<div id="page">
	<div class="toolbar">
	    <a href="javascript:history.back()">返回</a>
	    <h2><#if errorMsg??>访问出错<#else>服务器出错</#if></h2>
	</div>
	<div class="container">
        <div class="containerwrap">
		<div class="iconinfo info-500">
			<i class="ico ico-globe"></i>
			<strong>${errorMsg?default("服务器出错，请过会再试!")}</strong>
			<div class="btnbar">
				<a href="${ctx}/m/shopper" class="button">个人中心</a>
			</div>
		</div>
        </div>
	</div>
</div>