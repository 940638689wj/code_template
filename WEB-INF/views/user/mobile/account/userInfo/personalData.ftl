<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
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
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link heightauto">
                            <a class="itemlink" href="javascript:void(0);">
                                <div class="r">
                                    <div class="userhead" style="background-image: url(${ctx}/static/mobile/images/userhead.jpg);">
                                        <div class="upload-wrap">
                                        	<input id="imgPath_mPortrait" value="" name="mobilePortrait" type="hidden" />
                                        	<input name="file" id="file_mPortrait" class="inp-file" type="file" onchange="javascript:assetChange(this.value,'mPortrait');"/>
                                        	<img class="userhead" id="imageView_mPortrait" src="${user.headPortraitUrl!}" alt=""/>
                                        </div>
                                    </div>
                                </div>
                                <div class="c">头像</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/info/editUserName?userName=${user.userName!}">
                                <div class="r">${user.userName!}</div>
                                <div class="c">会员名</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/info/editSex?sex=${user.sexCd!}">
                                <div class="r"><#if user.sexCd?has_content && user.sexCd?? && user.sexCd==0>男<#elseif user.sexCd?has_content && user.sexCd?? && user.sexCd==1>女<#else>不详</#if></div>
                                <div class="c">性别</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/qrcode/toQrcode?userId=${user.userId!}">
                                <div class="r"><div class="code"></div></div>
                                <div class="c">我的二维码名片</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/address/userAddressManage">
                                <div class="r"></div>
                                <div class="c">我的收货地址</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/invoice/userInvoiceManage">
                                <div class="r"></div>
                                <div class="c">我的发票</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="/m/account/info/birthdayForm?birthday=<#if user.birthday?has_content>${user.birthday?string("yyyy-MM-dd")}</#if>">
                                <div class="r"><#if user.birthday?has_content>${user.birthday?string("yyyy-MM-dd")}</#if></div>
                                <div class="c">生日</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="/m/account/info/editEmail?email=${user.emailAddress!}">
                                <div class="r">${user.emailAddress!}</div>
                                <div class="c">邮箱</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="/m/account/info/idCard?identityId=${user.identityId!}">
                                <div class="r">${user.identityId!}</div>
                                <div class="c">身份证号</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="/m/account/info/myAddress">
                                <div class="r">${province!}${city!}</div>
                                <div class="c">地区</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="/m/account/out">
                                <div class="r"></div>
                                <div class="c">退出</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script>
        function assetChange(fileName,lastFlag){
        if(fileName == null || fileName.trim().length <= 0){
            mui.toast("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            mui.toast("文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);

        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())){
            mui.toast("文件格式错误!");
            return false;
        }
        $.ajaxFileUpload({
            url:'${ctx}/common/staticAsset/upload/lastFlag',
            secureuri: false,
            fileElementId: "file_"+lastFlag,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                loadImage(data.assetUrl,lastFlag);
            },
            error: function (data, status, e) {
                mui.toast("上传失败" + e);
            }
        });
        return false;
    }

    function loadImage(assertUrl,lastFlag) {
        $("#imgPath_"+lastFlag).val(assertUrl);
        $.ajax({
              url : '${ctx}/m/account/info/Portrait_AjaxSave',
              dataType : 'json',
              type: 'post',
              data : {imgUrl: assertUrl},
              success : function(data){
              		mui.toast("上传成功！");
              }
           });
        $("#imageView_"+lastFlag).attr("src", assertUrl);
    }
	</script>
</body>
</html>