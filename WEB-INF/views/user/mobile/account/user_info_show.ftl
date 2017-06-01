<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>个人资料</title>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
	        <h1 class="mui-title">个人资料</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="mui-content">
            <div class="toptip">
                <div>提示：手机号不可修改！</div>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                    	<li class="heightauto">
                            <a class="itemlink" id="file_mPortrait" href="javascript:void(0);">
                                <div class="r">
                                    <div class="userhead" id="imageView_mPortrait" <#if (user.headPortraitUrl)?has_content>style="background-image: url(${user.headPortraitUrl!});"<#else>style="background-image: url(/static/mobile/images/userhead.jpg);"</#if>>
                                    	 <input id="photoUrl"  name="photoUrl" type="hidden" value="<#if (user.headPortraitUrl)?has_content>${user.headPortraitUrl!}</#if>" />
                                    </div>
                                </div>
                                <div class="c">头像</div>
                            </a>
                        </li> 
                         <li>
                            <a href="javascript:void(0);">
                                <div class="r">
									${(user.phone)!}
								</div>
                                <div class="c">手机号</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser"> <!--href="${ctx}/m/account/userInfo/toUpdateNickName" -->
                                <div class="r">${(user.nickName)!}</div>
                                <div class="c">昵称</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser"> <!-- href="${ctx}/m/account/userInfo/toUpdateSex" -->
                                <div class="r">${(user.userName)!}</div>
                                <div class="c">真实姓名</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser"><!-- href="${ctx}/m/account/userInfo/toUpdateSex" -->
                                <div class="r">
									<#if user.sexCd==0>男
									<#elseif user.sexCd==1>女
									<#elseif user.sexCd==2>不详
									</#if>
								</div>
                                <div class="c">性别</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">
									<#if user.birthday?has_content>${(user.birthday)?string("yyyy-MM-dd")}</#if>
								</div>
                                <div class="c">出生日期</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">
									${(user.identityId)!}
								</div>
                                <div class="c">身份证</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">
									${userInfoDTO.provinceName!}-${userInfoDTO.cityName!}-${userInfoDTO.countyName!}
								</div>
                                <div class="c">地区</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">
									${(user.street)!}
								</div>
                                <div class="c">详细地址</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="reportloadding" style="display: none">
        <div class="spinnerwrap">
            <div class="spinner8">
                <div class="spinner-container container1">
                    <div class="circle1"></div>
                    <div class="circle2"></div>
                    <div class="circle3"></div>
                    <div class="circle4"></div>
                </div>
                <div class="spinner-container container2">
                    <div class="circle1"></div>
                    <div class="circle2"></div>
                    <div class="circle3"></div>
                    <div class="circle4"></div>
                </div>
                <div class="spinner-container container3">
                    <div class="circle1"></div>
                    <div class="circle2"></div>
                    <div class="circle3"></div>
                    <div class="circle4"></div>
                </div>
            </div>
            <p>上传中...</p>
        </div>
    </div>
</div>
<script src="${ctx}/static/mobile/js/ajaxupload.js" type="text/javascript"></script>
<script>
		$(function(){
             init('file_mPortrait','imageView_mPortrait','photoUrl','');
        });
        
       function init(btnId,imgId,hidId,linkId) {
            //初始化图片上传
            var btn = document.getElementById(btnId);
            var img = document.getElementById(imgId);
            var hidImgName = document.getElementById(hidId);
            g_AjxUploadImg(btn, img, hidImgName,linkId);
        }
        
          //图片上传
        function g_AjxUploadImg(btn, img, hidPut,linkId) {
            new AjaxUpload(btn, {
               action: '${ctx}/common/staticAsset/upload/user/',
                data: {},
                name: 'file',
                onSubmit: function(file, ext) {
                    if (!(ext && /^(jpg|JPG|png|PNG|gif|GIF)$/.test(ext))) {
                        mui.toast("您上传的图片格式不对，请重新选择！");
                        return false;
                    }
                },
                onComplete: function(file, response) {
                    var data = JSON.parse(response);
                    if (data) {
                        $('.reportloadding').show();//显示转圈圈
                    	 $.ajax({
				              url : '${ctx}/m/account/userInfo/portrait_AjaxSave',
				              dataType : 'json',
				              type: 'post',
				              data : {imgUrl: data.assetUrl},
				              success : function(data){
				              		mui.toast("上传成功！");
                                    $('.reportloadding').hide();
				              }
           				});
                        hidPut.value = data.assetUrl;
                       $(".userhead").css("background-image","url(" + data.assetUrl  +")");
                    }else{
                        mui.toast("头像上传失败！");
                        $('.reportloadding').hide();
                    }
                }
            });
        }
        function edit(){
        	window.location.href = "${ctx}/";
        }
</script>
</body>
</html>