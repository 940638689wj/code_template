<#assign ctx = request.contextPath>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人资料</title>
    <script src="${ctx}/static/js/ajaxupload.js" type="text/javascript"></script>
</head>
<body>
	<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/shopperIndex"></a>
	        <h1 class="mui-title">个人资料</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="mui-content">
           <div class="toptip">
                <div>提示：如联系方式或个人信息变更请务必及时与平台客服联系更改</div>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                  <form id="editShopperForm" name="editShopperForm" action="${ctx}/m/shopper/Portrait_AjaxSave" method="post">
                    <ul>
                    	  <li class="heightauto">
                            <a class="itemlink" id="file_mPortrait" href="javascript:void(0);">
                                <div class="r">
                                    <div class="userhead" id="imageView_mPortrait" <#if (shopper.photoUrl)?has_content>style="background-image: url(${shopper.photoUrl!});"<#else>style="background-image: url(/static/mobile/images/userhead.jpg);"</#if>>
                                     <input id="photoUrl"  name="photoUrl" type="hidden" value="<#if (shopper.photoUrl)?has_content>${shopper.photoUrl!}</#if>" />
                                        <div class="upload-wrap"></div>
                                    </div>
                                </div>
                                <div class="c">头像</div>
                            </a>
                        </li>
                       
                        <li>
                            <a class="itemlink" href="${ctx}/m/shopper/editUserName?userName=${shopper.shopperName!}">
                                <div class="r">${(shopper.shopperName)!?html}</div>
                                <div class="c">姓名</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/shopper/editSex?sex=${shopper.sexCd!}">
                                <div class="r"><#if shopper.sexCd?has_content && shopper.sexCd?? && shopper.sexCd==0>男<#elseif shopper.sexCd?has_content && shopper.sexCd?? && shopper.sexCd==1>女<#else>不详</#if></div>
                                <div class="c">性别</div>
                            </a>
                        </li>
                        <li>
                          	<a href="javascript:void(0);">
                                <div class="r">${(shopper.identityNum)!?html}</div>
                                <div class="c">身份证号</div>
                            </a>
                        </li>
                         <li>
                            <a href="javascript:void(0);">
                                <div class="r">${(shopper.shopperNum)!?html}</div>
                                <div class="c">员工号</div>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">${(shopper.phone)!?html}</div>
                                <div class="c">手机号</div>
                            </a>
                        </li>
                    </ul>
                    
                    </form>
                </div>
            </div>
        </div>
    </div>
    
    
    <div class="reportloadding" style="display: none;">
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
            var button = btn,interval;
            new AjaxUpload(button, {
               action: '${ctx}/common/staticAsset/upload/shopper/',
                data: {},
                name: 'file',
                onSubmit: function(file, ext) {
//                    if (!(ext && /^(jpg|JPG|png|PNG|gif|GIF)$/.test(ext))) {
//                        alert("您上传的图片格式不对，请重新选择！");
//                        return false;
//                    }
                },
                onComplete: function(file, response) {
                    var data = JSON.parse(response);
                    $('.reportloadding').show();//显示转圈圈
                    if (data) {
                    	 $.ajax({
				              url : '${ctx}/m/shopper/Portrait_AjaxSave',
				              dataType : 'json',
				              type: 'post',
				              data : {imgUrl: data.assetUrl},
				              success : function(data){
                                  mui.toast("上传成功！");
                                  $('.reportloadding').hide();
				              }
           			});
                        hidPut.value = data.assetUrl;
                       $(".userhead").css("background-image","url(" + data.assetUrl  +")");;
                    }else{
                        mui.toast("头像上传失败！");
                        $('.reportloadding').hide();
                    }
                }
            });
        }
      

    
	</script>

  
</body>
</html>