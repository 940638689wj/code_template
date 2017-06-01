<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>选择收货地址</title>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">选择收货地址</h1>
        <!--<a class="mui-icon"><span>编辑</span></a>-->
    </header>

    <div class="mui-content">
        <ul class="addresslist">
            <#list userReceiveAddressManageList as receiveAddress>
                <li>
                    <div class="addr-item">
                        <input type="hidden" class="addrId" value="${receiveAddress.addrId!}"/>
                        <span class="name">${receiveAddress.receiverName!}</span>
                        <span class="phone">${receiveAddress.receiverTel!}</span>
                        <p>
                            <span>${receiveAddress.receiverProvinceName!}</span><span>${receiveAddress.receiverCityName!}</span><span>${receiveAddress.countyName!}</span>
                        </p>
                        <p>${receiveAddress.receiverAddr!}</p>
                    </div>
                    <div class="edit-wrap">
                        <label><input type="radio" name="rdo_addr" id="pay_1"
                                      <#if receiveAddress.isDefaultAddr==1>checked="checked"
                                      <#else>onclick="setDefaultAddress('${receiveAddress.addrId!}')"</#if>>
                            <#if receiveAddress.isDefaultAddr==1>默认地址<#elseif receiveAddress.isDefaultAddr==0>设为默认</#if>
                        </label>
                        <div class="edit-bar">
                            <a href="javascript:editAddr('${receiveAddress.addrId!}')">
                                <i class="ico ico-edit"></i>编辑
                            </a>
                            <a href="javascript:deleteAddr('${receiveAddress.addrId!}')">
                                <i class="ico ico-delete"></i>删除
                            </a>
                        </div>
                    </div>
                </li>
            </#list>
        </ul>
		<input type="hidden" name="orderId" id="orderId" value="${orderId!}">
        <div class="fbbwrap">
            <div class="mainbtnbar">
                <a href="javascript:void(0);" class="address_btn">新增收货地址</a>
            </div>
        </div>
    </div>
</div>
<script>
    var flag = true;
    var returnUlr = null;
    <#--判别是否是从订单确认页面中跳转过来的-->
    var fromType = getCookie('c_from_type');
    if(fromType == "1"){
        // 普通 订单
        returnUlr = "/m/account/order/submitOrder";
    }else if(fromType == "2"){
        // 搭配套餐 订单
        returnUlr = "/m/account/collocation/submitOrder";
    }else if(fromType == "3"){
        // 众筹领取奖品 订单
        var promotionId = getCookie('promotionId');
        delCookie('promotionId');
        returnUlr = "/m/account/crowdfundingOrder/submitOrder?promotionId="+ promotionId;
    }else if(fromType == "4"){
        // 提货券 订单

        returnUlr = "/m/account/pickupOrder/submitOrder";
    }else if(fromType == "5"){
    	//预售订单
    	var preSaleOrderId = getCookie('preSaleOrderId');
    	returnUlr = "/m/account/preSaleOrder/submitOrderForRemain?&orderId="+preSaleOrderId;
    }

    $(function () {
        console.log(fromType);

        $('.mui-icon-left-nav').attr('href', returnUlr);

        $('.addresslist').on('click','.addr-item',function() {
            var addrId = $(this).find('.addrId').val();
            if(!addrId) {
                return;
            }
            console.log("fromType="+fromType)

            delCookie('c_from_type');
			if(fromType == "3"){
				window.location.href = returnUlr + "&addrId=" + addrId;
			}else if(fromType == "5"){
				delCookie('preSaleOrderId');
				window.location.href = returnUlr + "&addrId=" + addrId;
            }else if(fromType == "4"){
                window.location.href = returnUlr + "?addressId=" + addrId;
			}else{
                testAddress(addrId,returnUlr);
            }
			
        });

        $('.address_btn').click(function(){
            window.location.href = "${ctx}/m/account/userAddress/toUpdateAddress?returnUrl=/m/account/userAddress/selectAddressList";
        });
    });

    function editAddr(addrId){
        window.location.href =  '${ctx}/m/account/userAddress/toUpdateAddress?returnUrl=/m/account/userAddress/selectAddressList&addrId='+addrId;
    }

    function deleteAddr(addrId) {
        var btnArray = ['否', '是'];
        mui.confirm('', '删除该地址？', btnArray, function (e) {
            if (e.index == 1) {
                $.post("${ctx}/m/account/userAddress/deleteAddress", {
                    addrId: addrId
                }, function (data) {
                    if(data.result=="success"){
                        window.location.href = "/m/account/userAddress/selectAddressList?fromType="+fromType;
                    } else if (data.result=="error") {
                        mui.toast("删除失败，请稍后再试");
                    }
                }, "json");
            }
        });
    }

    function testAddress(addrId,returnUlr) {
        if(!flag) return;
        $.ajax({
            url: '${ctx}/m/account/order/testAddress',
            async: true,
            type: 'GET',
            dataType: 'json',
            data: {'addrId':addrId},
            beforeSend: function () {
                flag = false;
            },
            success: function (result) {
                flag = true;
                if(result.result == 'success') {
                    window.location.href = returnUlr + "?addressId=" + addrId+"&orderId="+orderId;
                } else {
                    mui.toast(result.message);
                }
            },
            error: function (XMLHttpResponse) {
                flag = true;
                console.log('请求未成功');
            }
        });
    }

    function setDefaultAddress(addrId) {
        var btnArray = ['否', '是'];
        mui.confirm('', '修改默认地址？', btnArray, function (e) {
            if (e.index == 1) {
                $.post("${ctx}/m/account/userAddress/setDefaultAddress", {
                    addrId: addrId
                }, function (data) {
                    if(data.result=="success"){
                        mui.toast("修改成功!");
                        location.reload();
                    } else if (data.result=="error") {
                        mui.toast("修改失败，请稍后再试");
                    }
                }, "json");
            }else{
                location.reload();
            }
        });
    }

    //获取cookie
    function getCookie(name) {
        var arr=document.cookie.split('; ');
        var i=0;
        for(i=0;i<arr.length;i++)
        {
            var arr2=arr[i].split('=');

            if(arr2[0]==name)
            {
                var getC = decodeURIComponent(arr2[1]);
                return getC;
            }
        }

        return '';
    }

    //删除cookie
    function delCookie(name) {
        var LT = new Date();
        LT.setTime(LT.getTime()-10000);
        var XN = getCookie(name);
        if( XN != null)
            document.cookie= name + "="+XN+";path=/;expires="+LT.toGMTString();
    }

</script>
</body>
</html>