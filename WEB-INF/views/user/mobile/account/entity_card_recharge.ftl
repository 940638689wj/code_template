<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>实体卡充值</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/myWallet"></a>
        <h1 class="mui-title"><#if cardTypeCd == 1>现金卡充值<#else>积分卡充值</#if></h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <div class="borderbox">
            <ul class="formlist">
                <li>
                    <div class="hd">充值卡充值</div>
                    <div class="bd"><input type="text" placeholder="请输入充值卡账号" id="cardNum"></div>
                </li>
                <li>
                    <input type="password" placeholder="请输入充值卡密码" id="password">
                </li>
            </ul>
            <div class="btnbar mt10">
                <a class="mui-btn mui-btn-block mui-btn-primary" href="javascript:recharge()">充值</a>
            </div>
        </div>
       <p class="loginForget"><span class="fr"><a class="orange" href="${ctx}/m/account/entityCardRecharge/toRecord?cardTypeCd=${cardTypeCd!}">充值记录</a></span></p>
    </div>
</div>
<script type="text/javascript">

    function recharge(){
        var cardNum = document.getElementById('cardNum').value;
        var password = document.getElementById('password').value;
        if(cardNum==null || cardNum == ''){
        	mui.toast("请输入卡号！");
        	 return false;
        }
        if(password==null || password == ''){
        	mui.toast("请输入密码!");
        	return false;
        }
        var btnArray = ['是','否'];
        mui.confirm('','确认充值?',btnArray,function(e){
            if(e.index == 0){
                $.post("${ctx}/m/account/entityCardRecharge/entityRecharge",{
                    cardTypeCd : ${cardTypeCd},
                    cardNum : cardNum,
                    password: password

                },function(data){
                    if(data && data.result == 'true'){
                        mui.toast('充值成功');
                        setTimeout("goto()","1000")
                        
                    }else{
                        mui.toast(data.message);
                        
                    }
                },'json');
            }
        });
    }
function goto(){
	window.location.href="${ctx}/m/account/entityCardRecharge?cardTypeCd="+${cardTypeCd};
}
</script>
</body>
</html>    