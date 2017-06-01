<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我要开店</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui/mui.picker.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui/mui.poppicker.css" />
</head>
<body>
    <div id="page" class="page-openshop">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav"></a>
	            <h1 class="mui-title">我要开店</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="openshop">
                <p>亲，恭喜你！你已经发现了赚钱的秘方！<br>填写申请，自己开店，享受店铺收益吧！</p>
                <form id="J_Form">
                	<input type="hidden" id="province" value=""/>
        			<input type="hidden" id="city" value="" />
        			<input type="hidden" id="county" value="" />
	                <ul>
	                    <li><input type="text" placeholder="姓名" value="${(user.userName)!}" name="userName"></li>
	                    <li><input type="tel" placeholder="手机号" value="${(user.phone)!}" name="phone"></li>
	                    <li><input type="text" placeholder="身份证（不能为空！）" name="identityId"></li>
	                    <li>
	                    <input id="showCityPicker" type="text" placeholder="省-市-区/县" value="<#if province?has_content || city?has_content || county?has_content>${province!}-${city!}-${county!}</#if>" />
	                    </li>
	                    <li><button type="button" id="applyMstore" class="mui-btn mui-btn-block mui-btn-danger">提交申请</button></li>
	                </ul>
                </form>
            </div>
        </div>
    </div>
	<script src="${ctx}/static/mobile/js/mui/mui.picker.js"></script>
	<script src="${ctx}/static/mobile/js/mui/mui.poppicker.js"></script>
	<script src="${ctx}/static/mobile/js/mui/city.data-1.js" type="text/javascript" charset="utf-8"></script>
    <script type="text/javascript">
$(function(){
    $('#applyMstore').click(function(){
    	var userName = $("[name=userName]").val();
    	var phone = $("[name=phone]").val();
    	var identityId = $("[name=identityId]").val();
    	var province = $('#province').val();
        var city = $('#city').val();
        var county = $('#county').val();
    	
    	if(!userName || $.trim(userName) == ""){
        	mui.toast('请填写微店主姓名!');
        	return false;
        }
		if(!phone || $.trim(phone) == ""){
			mui.toast('请填写微店主手机号!');
			return false;
		}
		/*验证手机号格式*/
		var telReg = /^(0|86|17951)?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
		if(!telReg.test(phone)){
			mui.toast('请正确填写手机号!');
			return false;
		}
		/*验证身份证号*/
		if(!identityId || $.trim(identityId) == ""){
			mui.toast('请填写微店主身份证号!');
			return false;
		}
		if(!validateIdCard(identityId)){
			mui.toast('无效的身份证号!');
			return false;
		};
		if(!province || $.trim(province) == "" || !city || $.trim(city) == "" || !county || $.trim(county) == ""){
			mui.toast('请选择省市区!');
			return false;
		}
		
		var user = {};
		user.userId = ${(user.userId)!};
		user.userName = userName;
		user.phone = phone;
		user.identityId = identityId;
		user.provinceId = province;
		user.cityId = city;
		user.countyId = county;
		
		//
		window.location.href = "${ctx}/m/account/mstoreUser/openShop?userJson=" + JSON.stringify(user);
		/* $.post('${ctx}/m/account/mstoreUser/openShop',{userJson: JSON.stringify(user)},function(){
			
		}); */
	});
});

/*验证身份证号格式*/
function validateIdCard(idCard){
	//15位和18位身份证号码的正则表达式
	var regIdCard=/^(^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$)|(^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])((\d{4})|\d{3}[Xx])$)$/;

	//如果通过该验证，说明身份证格式正确，但准确性还需计算
	if(regIdCard.test(idCard)){
		if(idCard.length==18){
			var idCardWi=new Array( 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ); //将前17位加权因子保存在数组里
			var idCardY=new Array( 1, 0, 10, 9, 8, 7, 6, 5, 4, 3, 2 ); //这是除以11后，可能产生的11位余数、验证码，也保存成数组
			var idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
			for(var i=0;i<17;i++){
				idCardWiSum+=idCard.substring(i,i+1)*idCardWi[i];
			}
			var idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
			var idCardLast=idCard.substring(17);//得到最后一位身份证号码

			//如果等于2，则说明校验码是10，身份证号码最后一位应该是X
			if(idCardMod==2){
				if(idCardLast=="X"||idCardLast=="x"){
					return true;
				}else{
					return false;
				}
			}else{
				//用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
				if(idCardLast==idCardY[idCardMod]){
					return true;
				}else{
					return false;
				}
			}
		}
	}else{
		return false;
	}
}

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
</script>
</body>
</html>