<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>提现到银行卡</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
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
	            <h1 class="mui-title">提现到银行卡</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <ul class="tbviewlist">
                <li class="mc-info-link">
                    <a class="itemlink" href="${ctx}/m/account/withdrawal/selectBank?price=${(price)!}&type=${type!}">
                        <div class="r">${DICT('BANK_TYPE_CD','${(bankType)!}')}</div>
                        <div class="c">选择银行</div>
                    </a>
                </li>
                <li>
                    <div class="bd"><input type="number" id="account" placeholder="请输入银行账号"></div>
                </li>
                <li>
                    <div class="bd"><input type="text" id="name" placeholder="请输入收款人姓名"></div>
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
                	<#if account.bankTypeCd==1>
                    <li>
                        <div class="c"><i class="payico payico-alipay"></i>支付宝:${(account.openingAccountNo)!}</div>
                    </li>
                    <#else>
                    <li>
                        <div class="c" onclick="selectAccount('${(account.openingAccountNo)!}','${(account.openingAccountName)!}');"><i class="payico payico-bankcard"></i><P>${(account.openingAccountName)!}<span>${DICT('BANK_TYPE_CD','${account.bankTypeCd}')}(${(account.openingAccountNo)!})</span></P></div>
                    </li>
                    </#if>
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
			var name=$('#name').val();
			var price=${price!'0'};
			var type=${type!'0'};
			var bankType=${(bankType!'1')!};
			if(account==''||account==null){
				mui.toast('请输入银行卡账号');
				return;
			}
			if(name==''||name==null){
				mui.toast('请输入收款人姓名');
				return;
			}
			$.post('${ctx}/m/account/withdrawal/apply',{price:price,type:type,account:account,name:name,bankType:bankType},
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
	
	function selectAccount(account,name){
		$('#account').attr('value',account);
		$('#name').attr('value',name);
	}
</script>

</body>
</html>