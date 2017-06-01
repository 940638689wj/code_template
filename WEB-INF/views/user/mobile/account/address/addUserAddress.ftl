<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<#assign  adminRealName = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getAdminRealName()?default("")/>


<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html" lang="en">
<head>
	<title>管理收货地址</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui/mui.picker.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui/mui.poppicker.css" />
	<script src="${staticPath}/mobile/js/mui/mui.picker.js"></script>
	<script src="${staticPath}/mobile/js/mui/mui.poppicker.js"></script>
	<script src="${staticPath}/mobile/js/mui/city.data-1.js" type="text/javascript" charset="utf-8"></script>

</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a href="javascript:history.go(-1)" class="mui-icon mui-icon-left-nav"></a>
	            <h1 class="mui-title"><#if addressListForm??>修改收货地址<#else>新增收货地址</#if></h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <form id="J_Form" name="J_Form" action="${ctx}/m/account/address/save" method="post">
             <input type="hidden" name="addrId" value="<#if addressListForm??>${(addressListForm.addrId)!}</#if>"/>
             <input type="hidden" id="province" name="province" value=""/>
        	 <input type="hidden" id="city" name="city" value="" />
        	 <input type="hidden" id="county" name="county" value="" />
        	  <input type="hidden" id="isDefaultAddr" name="isDefaultAddr" value="<#if addressListForm??>${(addressListForm.isDefaultAddr)!}</#if>" />
            <ul class="tbviewlist">
                <li class="input-wrap">
                    <div class="hd">联系人</div>
                    <div class="bd"><input type="text" placeholder="您的姓名" name="receiverName" value="<#if addressListForm??>${(addressListForm.receiverName)!}</#if>"></div>
                    <span class="delete"></span>
                </li>
                <li class="input-wrap">
                    <div class="hd">联系电话</div>
                    <div class="bd"><input id="receiverTel" type="number" placeholder="您的手机号" name="receiverTel" value="<#if addressListForm??>${(addressListForm.receiverTel)!}</#if>"></div>
                    <span class="delete"></span>
                </li>
                  <li>
                    <div class="hd">所在地区</div>
                    <div class="bd">
                        <input id="showCityPicker" type="text" placeholder="省-市-区/县" value="<#if province?has_content || city?has_content || county?has_content>${province!}-${city!}-${county!}</#if>" />
                    </div>
                </li>
               <li>
                    <div class="hd"></div>
                    <div class="bd"><textarea textarea id="receiverAddr" name="receiverAddr" placeholder="详细地址（街道/门牌号）"><#if addressListForm??>${(addressListForm.receiverAddr)!}</#if></textarea></div>
                </li>
            </ul>
            <div class="mui-content-padded mt30 align-center">
                <butnto type="button" class="mui-btn mui-btn-primary mui-btn-block mb20" id="Oksave">确定</button>
            </div>
        </div>
    </div>

<script>

 

    (function($, doc) {
        $.init();
        $.ready(function() {
            var cityPicker = new $.PopPicker({
                layer: 3
            });
            cityPicker.setData(cityData3);
            var showCityPickerButton = doc.getElementById('showCityPicker');
            showCityPickerButton.addEventListener('tap', function(event) {
                var obj = this;
                var province = doc.getElementById('province');
                var city = doc.getElementById('city');
                var county = doc.getElementById('county');
                cityPicker.show(function(items) {
                   obj.value = (items[0] || {}).text + " - " + (items[1] || {}).text + " - " + (items[2] || {}).text;
                    county.value = (items[2] || {}).value;
                    province.value = (items[0] || {}).value;
                    city.value = (items[1] || {}).value;
                    //返回 false 可以阻止选择框的关闭
                    //return false;
                });
            }, false);
        });
    })(mui, document);

 $(function(){
    $("#Oksave").click(function(){
     var receiverName = $("input[name='receiverName']").val();
     var receiverTel = $("input[name='receiverTel']").val();
     var receiverAddr = $("#receiverAddr").val();
     var province = $("#province").val();
     var city = $("#city").val();
     var county = $("#county").val();
     var addrId =$("input[name='addrId']").val();
     
     var chooseAddressUrl = getUrlParams['chooseAddressUrl'];// 从地址中获取：选择地址列表URL
     var addressType = getUrlParams['addressType'];// 从地址中获取： 地址类型 1：收货地址，2：发票收货地址
         if(receiverName == ""){
                mui.toast('请输入用户名!');
                return false;
         }else if(receiverName.length > 50) {
         		mui.toast('用户名长度不能超过50!');
                return false;
         }
         
         if(!checkTelephone(receiverTel)) {
         	return;
         }
         
         <#if addressListForm??>
         <#else>
         if(province == '') {
         		mui.toast('请选择省份!');
                return false;
         }
         
         if(city == '') {
         		mui.toast('请选择城市!');
                return false;
         }
         </#if>
         
         if(receiverAddr == ""){
                mui.toast('请输入详细地址!');
                return false;
         }else if(receiverAddr.length > 100) {
         		mui.toast('详细地址长度不能超过100!');
                return false;
         }
         var data={};
         data.receiverName =receiverName;
         data.receiverAddr =receiverAddr;
         data.receiverTel = receiverTel;
         data.province = province;
         data.city = city;
         data.isDefaultAddr = isDefaultAddr;
         data.county =county;
         data.addrId =addrId;
         $.post('${ctx}/m/account/address/save',{'addrId':addrId,'receiverName':receiverName,'receiverTel':receiverTel,'receiverAddr':receiverAddr,'province':province,'city':city,'county':county},function(data){
	              if(data){
                   	    mui.toast('成功保存！');
                   	    if(chooseAddressUrl && addressType) {
                   	    	window.location.href=chooseAddressUrl+"?addressType="+addressType;
                   	    } else if(addressType){
                   	    	window.location.href="${ctx}/m/account/order/confirm";
                   	    }else{
                   	    	window.location.href="${ctx}/m/account/address/userAddressManage";
                   	    }
	               	}else{
	               		mui.toast('保存失败！');
	               	}
	               	
	               	
               });        
         
  });
    
        $(".input-wrap").each(function () {
            var wrap = $(this),
                    input = wrap.find("input"),
                    del = wrap.find(".delete");
            del.on("click", function () {
                input.val("").focus();
                del.hide();
            });
            input.on("input propertychange", function () {
                if($.trim(this.value) != ""){
                    del.show();
                }else{
                    del.hide();
                }
            });
        });
    })
    
    // 校验手机号码格式
    function checkTelephone(telephone) {
        var mobileReg = new RegExp("^(1[0-9]{10})$");
        if (!telephone) {
            mui.toast('请输入联系电话!');
            return false;
        }
        if (!mobileReg.test(telephone)) {
            mui.toast('手机号格式不正确!');
            return false;
        }
        return true;
    }
</script>
</body>
</html>