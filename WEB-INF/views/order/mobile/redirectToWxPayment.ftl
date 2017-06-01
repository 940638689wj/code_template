<html>
<#assign ctx = request.contextPath>
<body>
<input type="hidden" id="orderNumber" name="orderNumber" value="${(orderNumber)!}">
<input type="hidden" id="appId" name="appId" value="${appId!}">

<a href="#" id="getBrandWCPayRequest"></a>
<div  style="height: 100%;width: 100%;text-align: center"> <br>  <br><br><br><br><br>
    <br>  <br><br><br><br><br>
    <h1> 请稍后...</h1>
</div>

<script src="${ctx}/static/mobile/js/zepto.js"></script>
<script src="${ctx}/static/mobile/js/md5.js"></script>
<script src="${ctx}/static/mobile/js/sha1.js"></script>
<script>
    $(function(){
        var appId=$("#appId").val();
        var getWxOpenIdUrl="${getWxOpenIdUrl!}";
        var state=$("#orderNumber").val();
        window.location.href="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+appId+"&redirect_uri="+getWxOpenIdUrl+"&response_type=code&scope=snsapi_base&state="+state+"#wechat_redirect"
    })
</script>
</body>
</html>
