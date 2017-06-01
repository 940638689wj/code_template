<#assign ctx = request.contextPath> <#assign staticPath = ctx +
"/static/mobile">
<!doctype html>
<html lang="en">
<head>
	<!--<meta charset="UTF-8">-->
	<title>提现到财付通</title>
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
				<h1 class="mui-title">提现到财付通</h1>
				<a class="mui-icon"></a>
			</header>
        </#if>

		<div class="mui-content">
			<ul class="tbviewlist">
				<li>
					<div class="bd" style="display: -webkit-box;">
						<div style="margin-right: 10px; color: #000; max-width: 100px; min-width: 80px;">财付通</div>
						<div style="-webkit-box-flex: 1;">
							<input type="text" name="account" id="account" placeholder="请输入财付通账号">
						</div>
					</div>
				</li>
			</ul>
			<div class="mui-content-padded">
				<button type="button" id="but" class="mui-btn mui-btn-primary mui-btn-block">提交申请</button>
			</div>
		</div>
		<#if list??>
		<div class="mui-content">
			<div class="borderbox">
				<div class="list-title">选择账号</div>
				<ul class="tbviewlist paytypes withdrawal-history">
					<#list list as account>
						<li>
							<div class="c" onclick="selectAccount('${(account.openingAccountNo)!}');">
								<i class="payico payico-bankcard"></i>财务通:${(account.openingAccountNo)!}
							</div>
						</li>
					</#list>
				</ul>
			</div>
		</div>
		</#if>
	</div>

	<script type="text/javascript">
	$(function(){
		$('#but').click(function(){
			var account=$('#account').val();
			var price=${price!'0'};
			var type=${type!'0'};
			var bankType=12;
			if(account==''||account==null){
				mui.toast('请输入财付通账号');
				return;
			}
			$.post('${ctx}/m/account/withdrawal/apply',{price:price,type:type,account:account,bankType:bankType},
			function(data){
				if(data){
					$('#but').attr("disabled","true");
					location.href='${ctx}/m/account/withdrawal/prompt?type=1';
				}else{
					location.href='${ctx}/m/account/withdrawal/prompt?type=0';
				}
			});
		});
	});
	
	function selectAccount(account){
		$('#account').attr('value',account);
	}
</script>
</body>
</html>