<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>个人资料</title>   
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
     <script src="${ctx}/static/js/laydate-v1.1/laydate/laydate.js"></script>
</head>
<body class="page-login">
<#include "include/header.ftl"/>
<div class="center-layout">
<#include "include/menu.ftl"/>
<#include "include/addrSelect.ftl">
    <div class="center-content">
        <div class="content-titel"><h3>会员中心<span><em>_</em>个人资料</span></h3></div>
        <div class="mcbox">
            <ul>
                <li>
                    <div class="form-hd">手机号码</div>
                    <div class="form-bd">
                        <input type="text" class="textfield" id="phone" readonly="readonly" value="${user.phone!}">
                    </div>
                </li>
                <li>
                    <div class="form-hd">昵称</div>
                    <div class="form-bd">
                        <input type="text" class="textfield" id="nickName" value="${user.nickName!}">
                    </div>
                </li>
                <li>
                    <div class="form-hd">性别</div>
                    <div class="form-bd">
                        <input type="radio" name="gender" id="gender1" <#if user.sexCd?? && user.sexCd?has_content && user.sexCd == 0>checked="true"  </#if> > <label for="gender1">男</label>&nbsp;&nbsp;&nbsp;&nbsp;
                        <input type="radio" name="gender" id="gender2" <#if user.sexCd?? && user.sexCd?has_content && user.sexCd == 1>checked="true"  </#if> > <label for="gender2">女</label>
                    </div>
                </li>
                <li>
                    <div class="form-hd">出生日期</div>
                    <div class="form-bd">
                    	<input type="test" class="textfield input-date" onclick="laydate();" id="dateOfBrith" value='<#if user.birthday?has_content>${(user.birthday)?string("yyyy-MM-dd")}</#if>'>
                        <!-- <select>
                            <option value="">年</option>
                        </select>
                        <select>
                            <option value="">月</option>
                        </select>
                        <select>
                            <option value="">日</option>
                        </select> -->
                    </div>
                </li>
                <li>
                    <div class="form-hd">所在地区</div>
                    <div class="form-bd">
                        <select id="provinceId">
                            <option value="">选择省</option>
                        </select>
                        <select id="cityId">
                           <option value="">选择城市</option>
                        </select>
                        <select id="countyId">
                            <option value="">选择区县</option>
                        </select>
                    </div>
                </li>
                <li>
                    <div class="form-hd">街道地址</div>
                    <div class="form-bd">
                        <textarea id="street" value="">${user.street!}</textarea>
                    </div>
                </li>
                <#--
                <li>
                    <div class="form-hd">真实姓名</div>
                    <div class="form-bd">
                        <input type="text" class="textfield" id="realName" value="${user.userName!}">
                    </div>
                </li>
                -->
                <li>
                    <div class="form-hd">身份证号</div>
                    <div class="form-bd">
                        <input type="text" class="textfield" id="identityId" value="${user.identityId!}">
                    </div>
                </li>
                <li>
                    <div class="form-btnbar"><a href="javascript:void(0)" class="btn-action" onclick="submit();">保存</a></div>
                </li>
            </ul>
        </div>
    </div>
</div>
<script>
    $(function () {
        addChangeEven("provinceId",["countyId"],["选择县/区"],"cityId","选择城市");
        addChangeEven("cityId",[],[],"countyId","选择县/区");
        findChildByParentId("provinceId", 0, "选择省");
        <#if user?? && user.provinceId?has_content>
        findChildByParentId("cityId", ${user.provinceId!}, "选择城市");
        $("#provinceId").val("${user.provinceId!}");
        findChildByParentId("countyId", ${user.cityId!}, "选择县/区");
        $("#cityId").val("${user.cityId!}");
            $("#countyId").val("${user.countyId!}");
    	</#if>
    });

    function submit() {
    	//日期处理
        $holdDate = $("#dateOfBrith").val();
        var holdDate=new Date($holdDate.replace("-", "/").replace("-", "/"));
        var genderArray = $("input[name='gender']");
        var gender = null;
        if (!$("#nickName").val()) {
            layer.msg("昵称不能为空！");
            return;
        }
        //性别处理
        for (i = 0; i < genderArray.length; i++) {
            if (genderArray[i].checked) {
                gender = i;
            }
        }
        if(gender == null){
            layer.msg("请选择性别！");
            return;
        }
        if (!$("#dateOfBrith").val()) {
            layer.msg("出生日期不能为空！");
            return;
        }
        if(!$("#provinceId").val() || !$("#cityId").val() || !$("#countyId").val()){
            layer.msg("请选择所在地区（省市县）！");
            return ;
        }
        if(!$("#street").val()){
            layer.msg("街道地址不能为空！")
            return;
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
		   layer.msg("身份证号码不正确！");
		   $('#identity').focus();
		   return false;
		  }
		 }
        

        $.post("${ctx}/account/userInfo/updateUser", {
                    nickName: $("#nickName").val(),
                    sexCd: gender,
                    birthday:holdDate,
                    provinceId:$("#provinceId").val(),
                    cityId:$("#cityId").val(),
                    countyId:$("#countyId").val(),
                    street:$("#street").val(),
                   // userName:$("#realName").val(),
                    identityId:$("#identityId").val()
                },
                function (data) {
                    if (data.result == "success") {
                        layer.msg("保存成功！");
                        location.reload();
                    }
                }, "json");
    }

</script>
</body>
</html>