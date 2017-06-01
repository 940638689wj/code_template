<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">

<!doctype html>
<html lang="en">
<head>
    <title>选择收货地址</title>
</head>
<body>
    <div id="page">
    	<#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/order/confirm"></a>
		            <h1 class="mui-title">选择收货地址</h1> 
	            <a class="mui-icon"><span>编辑</span></a>
	        </header>
		</#if>
        <div class="mui-content">
        <#if userAddressList?? && userAddressList?has_content> 
            <ul class="addresslist">
            	<#list userAddressList as one>
                <li>
                    <div class="addr-item">
                    	<input type="hidden" value="${(one.addrId)!}"/>
                        <span class="name">${one.receiverName!?html}</span>
                        <span class="phone">${one.receiverTel!}</span>
                        <address><#if one.isDefaultAddr==1><i>[默认地址]</i></#if>${one.provinceName!?html}${one.cityName!?html}${one.countyName!?html}${one.receiverAddr!?html}</address>
                    </div>
                    <div class="edit-wrap">
                        <div class="edit-bar">                               
                            <a href="#" data-id='${one.addrId!}' class="addressEdit"><i class="ico ico-edit"></i>编辑</a>
                        </div>
                   </div>
                </li>
                </#list>
            </ul>
        </#if>
        	<div class="fbbwrap">
                <div class="mainbtnbar"><a href="#" class="address_btn">新增收货地址</a></div>
            </div>
        </div>
        <input type="hidden" value="<#if addressType?? && addressType?has_content>${addressType!}</#if>" id="addressType">
    </div>
    <script type="text/javascript">
		$(document).ready(function() {
			var orderUrl = "${ctx}/m/account/order/confirm";
			var chooseAddressUrl = "${ctx}/m/account/address/chooseAddressList";
			var addressType = $('#addressType').val()?$('#addressType').val() : '';
			$('.address_btn').on('click',function() {
				window.location.href="${ctx}/m/account/address/addUserAddress?chooseAddressUrl="+chooseAddressUrl+"&addressType="+addressType;
			});
			
			$('.addr-item').on('click',function() {
				var addressType = $('#addressType').val();
				var addrId = $(this).find('input').val();
				if(addressType == 1) {//地址类型 :1：收货地址，2：发票收货地址
					window.location.href = orderUrl + "?addressId=" + addrId;
				} else {
					window.location.href = orderUrl + "?invoiceAddressId=" + addrId;
				}

			});
			
			$('.addressEdit').click(function() {
				var id = $(this).data('id')
				window.location.href="${ctx}/m/account/address/" + id + "?chooseAddressUrl="+chooseAddressUrl+"&addressType="+addressType;
			});
		})
	</script>
</body>
</html>
