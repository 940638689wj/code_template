<html>
<#assign ctx = request.contextPath>
<body>
<input type="hidden" id="partnerId" name="partnerId" value="${partnerId!}">
<input type="hidden" id="partnerKey" name="partnerKey" value="${partnerKey!}">
<input type="hidden" id="appId" name="appId" value="${appId!}">
<input type="hidden" id="paySignKey" name="paySignKey" value="${paySignKey!}">
<input type="hidden" id="perPayId" name="perPayId" value="${perPayId!}">
<input type="hidden" id="orderNo" name="orderNo" value="${orderNo!}">
<a href="#" id="getBrandWCPayRequest"></a>

<div id="page">
    <div class="container">
        <div class="containerwrap">
            <div class="incontainer">
                <div class="contentwrap">

                </div>
            </div>
        </div>
    </div>
</div>
<script src="${ctx}/static/mobile/js/md5.js"></script>
<script src="${ctx}/static/mobile/js/sha1.js"></script>
<script>
    var oldTimeStamp;//记住timestamp，避免签名时的timestamp与传入的timestamp时不一致
    var oldNonceStr; //记住nonceStr,避免签名时的nonceStr与传入的nonceStr不一致
    var status;
    var count = 0;

    // 普通订单
    var redirectUrl = "${ctx}/m/account/orderHeader/orderHeaderDetail?orderId=${orderId!}";
    <#if orderDetailPageUrl?? && orderDetailPageUrl?has_content>
        redirectUrl = "${orderDetailPageUrl!}";
    </#if>

    function getPartnerId() {
        return $('#partnerId').val();
    }

    function getPartnerKey() {
        return $('#partnerKey').val();
    }

    function getAppId() {
        return $('#appId').val();
    }

    function getPaySignKey() {
        return $('#paySignKey').val();
    }

    function getTimeStamp() {
        var timestamp = new Date().getTime();
        var timestampstring = timestamp.toString();//一定要转换字符串
        oldTimeStamp = timestampstring;
        return timestampstring;
    }

    function getNonceStr() {
        var $chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var maxPos = $chars.length;
        var noceStr = "";
        for (i = 0; i < 32; i++) {
            noceStr += $chars.charAt(Math.floor(Math.random() * maxPos));
        }
        oldNonceStr = noceStr;
        return noceStr;
    }


    function getOtherSign() {
        var appId = getAppId();
        var timeStamp = oldTimeStamp;
        var nonceStr = oldNonceStr;
        var package = "prepay_id=" + $("#perPayId").val();
        var signType = "MD5";
        var stringTemp = "appId=" + appId + "&nonceStr=" + nonceStr + "&package=" + package + "&signType=" + signType + "&timeStamp=" + timeStamp + "&key=" + getPaySignKey();
        var sign = ("" + CryptoJS.MD5(stringTemp)).toUpperCase();
        return sign;
    }


    document.addEventListener('WeixinJSBridgeReady', function onBridgeReady() {
        oldNonceStr = getNonceStr();
        oldTimeStamp = getTimeStamp();
        var perPayId = "prepay_id=" + $("#perPayId").val();
        //公众号支付
        WeixinJSBridge.invoke('getBrandWCPayRequest', {
            "appId": getAppId(), //公众号名称，由商户传入
            "timeStamp": oldTimeStamp.toString(), //时间戳
            "nonceStr": oldNonceStr, //随机串
            "package": perPayId,
            "signType": "MD5",
            "paySign": getOtherSign() //微信签名
        }, function (res) {
            //alert(res.err_msg);
            if (res.err_msg == "get_brand_wcpay_request:ok") {
                //alert("准备调用");
                findPayOrder();
            } else if (res.err_msg == "get_brand_wcpay_request:cancel") {
                mui.toast("取消支付!", true);
                setTimeout(function () {
                }, 1000);
                window.location.href = redirectUrl;
            } else {
                mui.toast("微信支付出错!", true);
                setTimeout(function () {
                }, 1000);
                window.location.href = redirectUrl;
            }
        });
        WeixinJSBridge.log('yo~ ready.');
    }, false)


    function findPayOrder() {
//        alert("orderNo");
        $.ajax({
            type: "GET",
            url: "${ctx}/m/payment/order/checkOrder",
            dataType: "json",
            data: {orderNo: $("#orderNo").val()},
            success: function (msg) {
                if (msg.result == "success") {
                    window.location.href = redirectUrl;
                } else {
                    if (count < 7) {
                        count++;
                        setInterval('findPayOrder()', 5000);
                    } else {
                        window.location.href = redirectUrl;
                    }
                }
            }
        });
    }

    $(function () {
        $('.incontainer').find('[width],[height]').css({width: 'auto', height: 'auto'});
        mui.toast('请稍等...');
        setTimeout(function () {
        }, 2000000);
    });

</script>
</body>
</html>