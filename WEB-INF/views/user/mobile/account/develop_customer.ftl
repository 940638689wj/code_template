<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>发展会员</title>  
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/performance"></a>
        <h1 class="mui-title">发展客户</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="develop">
            <div class="qrcode">
                <div class="userhead" style="background-image: url(${(user.headPortraitUrl)!(userHead!)})"></div>
                <h3>Hi，我是${(user.nickName)!((user.loginName)!)}</h3>
                <img src="${ctx}/m/account/performance/getQrCode">
                <p>长按此图识别二维码，来和我一起赚钱吧！</p>
            </div>
            <div class="share-foot">
                <div class="t">复制链接－发送给朋友 or 分享朋友圈</div>
                <input type="text" value="${urlHead!}/m/register?uid=${(user.userId)!}">
            </div>
        </div>
    </div>
</div>


</body>
</html>