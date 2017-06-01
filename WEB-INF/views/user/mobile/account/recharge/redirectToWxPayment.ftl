<html>
<#assign ctx = request.contextPath>
<body>
<input type="hidden" id="orderNumber" name="orderNumber" value="${(orderNumber)!}">
<input type="hidden" id="payTotal" name="payTotal" value="${(payTotal)!}">
<input type="hidden" id="partnerId" name="partnerId" value="${partnerId!}">
<input type="hidden" id="partnerKey" name="partnerKey" value="${partnerKey!}">
<input type="hidden" id="appId" name="appId" value="${appId!}">
<input type="hidden" id="appKey" name="appKey" value="${appKey!}">
<input type="hidden" id="notifyUrl" name="notifyUrl" value="${notifyUrl!}">
<input type="hidden" id="ip" name="ip" value="${ip!}">

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

    function getNonceStr()
    {
        var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var maxPos = $chars.length;
        var noceStr = "";
        for (i = 0; i < 32; i++) {
            noceStr += $chars.charAt(Math.floor(Math.random() * maxPos));
        }
        return noceStr;
    }

    function getAppId()
    {
        return $('#appId').val();
    }

    function getAppKey()
    {
        return $('#appKey').val();
    }
    function getPartnerId()
    {
        return $('#partnerId').val();
    }

    function getPartnerKey()
    {
        return $('#partnerKey').val();
    }

</script>
</body>
</html>
