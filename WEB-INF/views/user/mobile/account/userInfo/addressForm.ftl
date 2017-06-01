<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
    <meta charset="UTF-8">
    <title>我的住址</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui/mui.picker.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui/mui.poppicker.css" />
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/info/personalData"></a>
	            <h1 class="mui-title">我的住址</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
        <div class="mui-content">
        	<input type="hidden" id="province" name="province" value=""/>
        	<input type="hidden" id="city" name="city" value="" />
        	<input type="hidden" id="county" name="county" value="" />
            <ul class="tbviewlist">
                <li>
                    <div class="hd">所在地区</div>
                    <div class="bd">
                        <input id="showCityPicker" type="text" placeholder="省-市-区/县" value="<#if province?has_content || city?has_content || county?has_content>${province!}-${city!}-${county!}</#if>" />
                    </div>
                </li>
                <li>
                    <div class="hd"></div>
                    <div class="bd"><textarea name="street" id="street" placeholder="详细地址（街道/门牌号）" value="${street!}">${street!}</textarea></div>
                </li>
            </ul>
            <div class="mui-content-padded mt30 align-center">
                <button id="saveBtn" class="mui-btn mui-btn-primary mui-btn-block mb20">确定</button>
            </div>
        </div>
    </div>
<script src="${ctx}/static/mobile/js/mui/mui.picker.js"></script>
<script src="${ctx}/static/mobile/js/mui/mui.poppicker.js"></script>
<script src="${ctx}/static/mobile/js/mui/city.data-1.js" type="text/javascript" charset="utf-8"></script>
<script>
     $("#saveBtn").on('click',function() {
     		var address = $('#showCityPicker').val();
    		var street = $('#street').val();
	    	if(address==""){
	    		mui.toast("请填写省市区！");
	            return;
	    	}
	    	
	    	if(street==""){
	    		mui.toast("请填写详细地址！");
	            return;
	    	}else if(street.length > 255 ) {
	    		mui.toast("详细地址的长度不能超过255！");
	            return;
	    	}
	    	
       		$.ajax({
	            type: "POST",
	            url: "${ctx}/m/account/info/myAddressSave",
	            dataType: "json",
	            data: {province:$('#province').val(),city:$('#city').val(),county:$('#county').val(),street:$('#street').val()},
	            success: function(data) {
	            	if(data.result=='success'){
	           // 		mui.toast("保存成功!");
	            		window.location.href="${ctx}/m/account/info/personalData";
	            	}
	            }
        });
     });
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
</script>
</body>
</html>