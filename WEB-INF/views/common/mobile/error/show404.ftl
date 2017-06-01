<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<div id="page">
	<div class="toolbar">
	    <a href="${ctx}/m">首页</a>
	    <h2>404</h2>
	</div>
	<div class="container">
        <div class="containerwrap">
		<div class="iconinfo info-404">
			<i class="ico ico-404"></i>
			<strong>很抱歉，您查看的页面找不到！</strong>
			<p>
				您可以：<br><br>
				1.检查刚才的输入地址<br>
				2.去其他地方逛逛：<a href="${ctx}/m">首页</a>
			</p>
		</div>
        </div>
	</div>
</div>