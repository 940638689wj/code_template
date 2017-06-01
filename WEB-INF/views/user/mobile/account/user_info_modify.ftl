<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>个人资料</title>
	<link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.picker.min.css" />
	<script src="/static/js/jquery-1.11.0.min.js"></script>
	<script src="/static/layer/layer.js"></script>
</head>
<body>

<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userInfo"></a>
        <h1 class="mui-title">修改个人资料</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">

        <div class="loginform">
            <ul>
                <li>
                    <div class="hd">昵称</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" value="${(user.nickName)!}" id="nickName"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">性别</div>
                    <div class="bd">
                        <div class="info gender">
                            <div class="input-wrap">
                                <select id="sexCd">
                                	<#if user.sexCd==0>
                                	<option value="0" name="gender">男</option>
                                    <option value="1" name="gender">女</option>
                                	<#elseif user.sexCd==1>
                                    <option value="1" name="gender">女</option>
                                	<option value="0" name="gender">男</option>
                                	<#elseif user.sexCd==2>
                                	<option value="2" name="gender">请选择</option>
                                 	<option value="0" name="gender">男</option>
                                    <option value="1" name="gender">女</option>                               	
                                	</#if>
                                </select>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">出生日期</div>
                    <div class="bd">
                        <div class="info">
                           <div class="input-wrap"><input type="text" id="dateOfBrith" data-options='{"type":"date","beginYear":1960,"endYear":2050}' class="btn" value="<#if user.birthday?has_content>${(user.birthday)?string("yyyy-MM-dd")}</#if>"></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">身份证</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" value="${(user.identityId)!}" id="identityId"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">地区</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" value="<#if userInfoDTO.provinceName?? && userInfoDTO.provinceName?has_content>${userInfoDTO.provinceName!}省</#if><#if userInfoDTO.cityName?? && userInfoDTO.cityName?has_content>-${userInfoDTO.cityName!}</#if><#if userInfoDTO.countyName?? && userInfoDTO.countyName?has_content>-${userInfoDTO.countyName!}</#if>" id="showCityPicker"></div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="hd">详细地址</div>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap"><input type="text" value="${(user.street)!}" id="street"><span class="delete"></span></div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="btnbar">
            <button class="mui-btn mui-btn-block mui-btn-primary" onclick="submit();">提交</button>
        </div>
    </div>
</div>
<script>
function submit(){
	if($("#nickName").val()==null || $("#nickName").val()==""){
		 layer.msg("请输入昵称！");
		 return false;
	}
	//性别处理
	var genderArray = $("option[name='gender']");
    var gender ='';
  	gender = $("#sexCd").val();
  	if(gender == 2 ){
  		 layer.msg("请选择性别！");
  		 return false;
  	}

    //日期处理
     var holdDate = $("#dateOfBrith").val();
     if(holdDate == null || holdDate == ""){
     	layer.msg("请选择日期!")
     	return false;
     }
  
  // 验证身份证 
	function isCardNo(card) { 
	 var pattern = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
	 return pattern.test(card); 
	} 
    if($.trim($('#identityId').val()).length == 0) { 
	  layer.msg("身份证不能为空！");
	  $('#identity').focus();
	  return false;
	 } else {
	  if(!isCardNo($.trim($('#identityId').val()))) {
	 // alert($.trim($('#identityId').val()));
	   layer.msg("身份证号码不正确！");
	   $('#identity').focus();
	   return false;
	  }
	 }
	 
     //地区处理
     var area = $("#showCityPicker").val();
     if(area == null || area == ""){
     	 layer.msg("请选择地址！");
     	 return false;
     }
     var areaArray =[];
     areaArray = area.split('-');
   
     if($("#street").val() == null || $("#street").val()==""){
     	layer.msg("请填写详细地址！")
     	return false;
     }  
   
	 
    console.log("昵称:"+$("#nickName").val());
     console.log("真实姓名:"+$("#realName").val());
     console.log("性别:"+gender);
      console.log("出生日期:"+holdDate);
      console.log("身份证:"+$("#identityId").val());
       console.log("省:"+areaArray[0]);
        console.log("市:"+areaArray[1]);
         console.log("区:"+areaArray[2]);
          console.log("地址:"+$("#street").val());
         
          
	 $.post("${ctx}/m/account/userInfo/updateUserInfo", {
	        nickName: $("#nickName").val(),
	        birthday:holdDate,
	        sexCd : gender,
	        identityId:$("#identityId").val(),
	        province:areaArray[0],
	        city:areaArray[1],
	        county:areaArray[2],
	        street:$("#street").val()
	    },
	    function (data) {
	        if (data.result == "success") {
	            layer.msg("保存成功！");
	            location.href = "${ctx}/m/account";
	        }else{
	        	layer.msg(data.message)
	        }
	    }, "json");
}
</script>
<script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
<script src="${staticPath}/mobile/js/city.data-3.js"></script>
<script>
    (function($, doc) {
        $.init();
        //var result = $('#result')[0];
        var btns = $('.btn');
        btns.each(function(i, btn) {
            btn.addEventListener('tap', function() {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                var obj = this;
                var picker = new $.DtPicker(options);
                picker.show(function(rs) {
                    obj.value = rs.text;
                    picker.dispose();
                });
            }, false);
        });

        $.ready(function() {
            var cityPicker3 = new $.PopPicker({
                layer: 3
            });
            cityPicker3.setData(cityData3);
            var showCityPickerButton = doc.getElementById('showCityPicker');
            showCityPickerButton.addEventListener('tap', function(event) {
                cityPicker3.show(function(items) {
                    showCityPickerButton.value =  (items[0] || {}).text + "-" + (items[1] || {}).text + "-" + (items[2] || {}).text;
                });
            }, false);
        });

    })(mui, document);
</script>
</body>
</html>