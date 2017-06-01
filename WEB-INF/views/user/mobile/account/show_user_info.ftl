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
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">个人资料</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="mui-content">
            <div class="toptip">
                <div>提示：可修改头像、会员名、性别，手机号不可修改</div>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="heightauto">
                            <a class="itemlink" id="file_mPortrait" href="javascript:void(0);">
                                <div class="r">
                                    <div class="userhead" id="imageView_mPortrait"
                                         <#if (user.headPortraitUrl)?has_content>style="background-image: url(${user.headPortraitUrl!});"
                                         <#else>style="background-image: url(/static/mobile/images/userhead.jpg);"</#if>>
                                        <input id="photoUrl" name="photoUrl" type="hidden"
                                               value="<#if (user.headPortraitUrl)?has_content>${user.headPortraitUrl!}</#if>"/>
                                    </div>
                                </div>
                                <div class="c">头像</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">${(user.nickName)!(user.loginName)!}</div>
                                <div class="c">会员名</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
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
                            <a class="itemlink" href="javascript:void(0)">
                                <div class="r">${(userInfoDTO.phone)!}</div>
                                <div class="c">手机号</div>
                            </a>

                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">${(userInfoDTO.provinceName)!}
                                    省-${(userInfoDTO.cityName)!}-${(userInfoDTO.countyName)!}</div>
                                <div class="c">地区</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" href="${ctx}/m/account/userInfo/toUpdateUser">
                                <div class="r">${(userInfoDTO.street)!}</div>
                                <div class="c">地址</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="btnbar">
                <a class="mui-btn mui-btn-block mui-btn-primary" href="javascript:logout()" type="submit"
                   id="saveBtn">退出登录</a>
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
    function logout() {
        var btnArray = ['否', '是'];
        mui.confirm('', '确认退出？', btnArray, function (e) {
            if (e.index == 1) {
                window.location.href = "${ctx}/m/account/logout"
            }
        });
    }
    $(function () {
        init('file_mPortrait', 'photoUrl');
    });

    function init(btnId, hidId) {
        //初始化图片上传
        var btn = document.getElementById(btnId);
        var hidPut = document.getElementById(hidId);
        new AjaxUpload(btn, {
            action: '${ctx}/common/staticAsset/upload/user/',
            data: {},
            name: 'file',
            onSubmit: function (file, ext) {
                if (!(ext && /^(jpg|png|gif|bmp|pcx|tiff|jpeg|tga|exif|fpx|svg)$/.test(ext.toLowerCase()))) {
                    mui.toast("您上传的图片格式不对，请重新选择！");
                    return false;
                }
            },
            onComplete: function (file, response) {
                var data = JSON.parse(response);
                if (data) {
                    $('.reportloadding').show();//显示转圈圈
                    $.ajax({
                        url: '${ctx}/m/account/userInfo/portrait_AjaxSave',
                        dataType: 'json',
                        type: 'post',
                        data: {imgUrl: data.assetUrl},
                        success: function (data) {
                            mui.toast("上传成功！");
                            $('.reportloadding').hide();
                        }
                    });
                    hidPut.value = data.assetUrl;
                    $(".userhead").css("background-image", "url(" + data.assetUrl + ")");
                } else {
                    mui.toast("头像上传失败！");
                    $('.reportloadding').hide();
                }
            }
        });
    }


</script>
</body>
</html>