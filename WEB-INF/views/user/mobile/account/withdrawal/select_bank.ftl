<#assign ctx = request.contextPath> <#assign staticPath = ctx +
"/static/mobile">
<!doctype html>
<html lang="en">
<head>
	<!--<meta charset="UTF-8">-->
	<title>选择银行</title>
	<!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="format-detection" content="telephone=no" />-->
</head>
<body>
	<div id="page">
		<#if showTitle?? && showTitle>
			<header class="mui-bar mui-bar-nav">
				<a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
				<h1 class="mui-title">选择银行</h1>
				<a class="mui-icon"></a>
			</header>
        </#if>

		<div class="mui-content">
			<ul class="tbviewlist bank-list">
				<#list list as r>
					<li>
						<a href="${ctx}/m/account/withdrawal/bank?price=${price!}&type=${type!}&bankType=${r.codeId}" class="itemlink">
							<i class="ico"><img src="${staticPath}/images/bank/bank-${r.codeId}.png" alt="" /></i>${r.codeCnName}
						</a>
					</li>
				</#list>
			</ul>
		</div>
	</div>
</body>
</html>