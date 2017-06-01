<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>收货地址</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/memberCenter"></a>
        <h1 class="mui-title">收货地址</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
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
                        <a href="${ctx}/m/account/userAddress/toUpdateAddress?addrId=${receiveAddress.addrId!}"><i
                                class="ico ico-edit"></i>编辑</a>
                        <a href="javascript:deleteAddr('${receiveAddress.addrId!}')"><i
                                class="ico ico-delete"></i>删除</a>
                    </div>
                </div>
            </li>
        </#list>
        </ul>
        <div class="fbbwrap">
            <div class="mainbtnbar"><a href="${ctx}/m/account/userAddress/toUpdateAddress"
                                       class="address_btn">新增收货地址</a></div>
        </div>
    </div>
</div>
<script>
	<#--判别是否是从订单确认页面中跳转过来的-->
	var addressType = getCookie('addressType');// 从cookie中获取： 地址类型 1：收货地址
	if(addressType == 1) {
		$('.mui-icon-left-nav').attr('href','${ctx}/m/account/order/submitOrder');
	}
    $(function () {
		$('.addresslist').on('click','.addr-item',function() {
			var addrId = $(this).find('.addrId').val();
			if(!addrId) { return; }
			if(addressType == 1) {
				delCookie('addressType');
				window.location.href="${ctx}/m/account/order/submitOrder?addrId=" + addrId;
			}
		});
		
    });

    function deleteAddr(addrId) {
        var btnArray = ['否', '是'];
        mui.confirm('', '删除该地址？', btnArray, function (e) {
            if (e.index == 1) {
                $.post("${ctx}/m/account/userAddress/deleteAddress", {
                    addrId: addrId
                }, function (data) {
                    if(data.result=="success"){
                    	if(addressType == 1) {
                    		window.location.href="${ctx}/m/account/userAddress";
                    	} else {
	                        window.location.href="${ctx}/m/account/userAddress";
                    	}
                    } else if (data.result=="error") {
                        mui.toast("删除失败，请稍后再试");
                    }
                }, "json");
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
                        if(addressType == 1) {
                    		window.location.href="${ctx}/m/account/userAddress";
                    	} else {
	                        window.location.href="${ctx}/m/account/userAddress";
                    	}
                    } else if (data.result=="error") {
                        mui.toast("修改失败，请稍后再试");
                    }
                }, "json");
            }else{
            	window.location.href="${ctx}/m/account/userAddress";
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