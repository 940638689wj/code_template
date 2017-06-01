<#assign ctx = request.contextPath> <#assign staticPath = ctx +
"/static/mobile">
<!doctype html>
<html lang="en">
<head>
	<!--<meta charset="UTF-8">-->
	<title>提现申请</title>
	<!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes" />
	<meta name="apple-mobile-web-app-status-bar-style" content="black" />
	<meta name="format-detection" content="telephone=no" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
	<link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
	<script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
	<script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
	<script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
	<script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
	<div id="page">
		<#if showTitle?? && showTitle>
			<header class="mui-bar mui-bar-nav">
				<a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
				<h1 class="mui-title">提现申请</h1>
				<a class="mui-icon"></a>
			</header>
        </#if>
		<div class="mui-content">
			<div class="borderbox">
				<ul class="formlist">
					<li class="item-vertical">
						<div class="hd">
							<div class="fr orange">${(price?string.currency)!}</div>
							可提金额
						</div>
						<div class="bd">
							<input type="number" id="price" placeholder="本次最多提现${price?string.currency}" class="mui-numbox-input">
						</div>
					</li>
				</ul>
			</div>
			<div class="borderbox">
				<div class="list-title">提现到</div>
				<ul class="tbviewlist paytypes">
					<li>
						<a class="itemlink" id="alipay">
							<div class="c"><i class="payico payico-alipay"></i>支付宝</div>
						</a>
					</li>
					
					<li>
						<a class="itemlink" id="wx">
							<div class="c"><i class="payico payico-tenpay"></i>财付通</div>
						</a>
					</li>
					
					<li>
						<a class="itemlink" id="bank">
							<div class="c"><i class="payico payico-bankcard"></i>银行卡</div>
						</a>
					</li>
				</ul>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			$('#price').keyup(function() {
				var p = ${price!'0'};
				var price = $('#price').val();
				if(price<0){
					mui.toast('提现不能为负数');
					$('#price').val('');
					return false;
				}
				if (price > p) {
					mui.toast('最多能提现' + p);
					$('#price').val(p);
					return false;
				}
			});
			//提现到支付宝
			$('#alipay').click(function() {
				var price = $('#price').val();
				if (price == '' || price == null
						|| parseFloat(price) == 0) {
					mui.toast('请输入提现金额');
					return false;
				}
				location.href = "${ctx}/m/account/withdrawal/alipay?price=" + price + "&type=${type}";
				
			});
			
			//提现到微信财付通
			$('#wx').click(function() {
				var price = $('#price').val();
				if (price == '' || price == null
						|| parseFloat(price) == 0) {
					mui.toast('请输入提现金额');
					return false;
				}
				location.href = "${ctx}/m/account/withdrawal/tencentPay?price=" + price + "&type=${type}";
			});
			
			//提现到银行卡
			$('#bank').click(function() {
				var price = $('#price').val();
				if (price == '' || price == null
						|| parseFloat(price) == 0) {
					mui.toast('请输入提现金额');
					return false;
				}
				location.href = "${ctx}/m/account/withdrawal/bank?price=" + price + "&type=${type}";
			});
		});
	</script>
</body>
</html>