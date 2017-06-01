<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
</head>
<body>
<script>

    function assetChange(fileName,lastFlag){
        if(fileName == null || fileName.trim().length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);

        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())){
            BUI.Message.Alert("文件格式错误!");
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
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }

    function loadImage(assertUrl,lastFlag) {
        $("#imgPath_"+lastFlag).val(assertUrl);
        if("pcLogo" == lastFlag){
            $("#tip_pcLogo").html("替换图片");
            if(!$("#uploadBox_pcLogo").hasClass("upload-box-haspic")){
                $("#uploadBox_pcLogo").addClass("upload-box-haspic");
            }
            if(!($("#imageView_pcLogo").length)){
                $("<div class='upload-img'><img id='imageView_pcLogo' src='' alt=''></div>").appendTo($("#uploadBox_pcLogo"));
            }
        }
        if("userHeadImage" == lastFlag){
            $("#tip_userHeadImage").html("替换图片");
            if(!$("#uploadBox_userHeadImage").hasClass("upload-box-haspic")){
                $("#uploadBox_userHeadImage").addClass("upload-box-haspic");
            }
            if(!($("#imageView_userHeadImage").length)){
                $("<div class='upload-img'><img id='imageView_userHeadImage' src='' alt=''></div>").appendTo($("#uploadBox_userHeadImage"));
            }
        }
        if("backgroundSystem" == lastFlag){
            $("#tip_backgroundSystem").html("替换后台管理左上角图片");
            if(!$("#uploadBox_backgroundSystem").hasClass("upload-box-haspic")){
                $("#uploadBox_backgroundSystem").addClass("upload-box-haspic");
            }
            if(!($("#imageView_backgroundSystem").length)){
                $("<div class='upload-img'><img id='imageView_backgroundSystem' src='' alt=''></div>").appendTo($("#uploadBox_backgroundSystem"));
            }
        }
        if("mobileLogo" == lastFlag){
            $("#tip_mobileLogo").html("替换背景图片");
            if(!$("#uploadBox_mobileLogo").hasClass("upload-box-haspic")){
                $("#uploadBox_mobileLogo").addClass("upload-box-haspic");
            }
            if(!($("#imageView_mobileLogo").length)){
                $("<div class='upload-img'><img id='imageView_mobileLogo' src='' alt=''></div>").appendTo($("#uploadBox_mobileLogo"));
            }
        }
        if("mobileMenuLogo" == lastFlag){
            $("#tip_pc").html("替换图片");
            if(!$("#uploadBox_mobileMenuLogo").hasClass("upload-box-haspic")){
                $("#uploadBox_mobileMenuLogo").addClass("upload-box-haspic");
            }
            if(!($("#imageView_mobileMenuLogo").length)){
                $("<div class='upload-img'><img id='imageView_mobileMenuLogo' src='' alt=''></div>").appendTo($("#uploadBox_mobileMenuLogo"));
            }
        }
        if("loginBackgroundImage" == lastFlag){
            $("#tip_loginBackgroundImage").html("替换图片");
            if(!$("#uploadBox_loginBackgroundImage").hasClass("upload-box-haspic")){
                $("#uploadBox_loginBackgroundImage").addClass("upload-box-haspic");
            }
            if(!($("#imageView_loginBackgroundImage").length)){
                $("<div class='upload-img'><img id='imageView_loginBackgroundImage' src='' alt=''></div>").appendTo($("#uploadBox_loginBackgroundImage"));
            }
        }
        if("mobileFavImg" == lastFlag){
            $("#tip_mobileFavImg").html("替换图片");
            if(!$("#uploadBox_mobileFavImg").hasClass("upload-box-haspic")){
                $("#uploadBox_mobileFavImg").addClass("upload-box-haspic");
            }
            if(!($("#imageView_mobileFavImg").length)){
                $("<div class='upload-img'><img id='imageView_mobileFavImg' src='' alt=''></div>").appendTo($("#uploadBox_mobileFavImg"));
            }
        }
        $("#imageView_"+lastFlag).attr("src", assertUrl);
    }
</script>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">基本设置</span></li>
        </ul>
    </div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/decorate/saveBaseSetting" method="post">
        <div class="control-group">
            <label class="control-label control-label-auto">商城名称：</label>
            <div class="controls"><input class="control-text" name="siteName" type="text" value="${(siteName)!?html}"/></div>
        </div>
        <div class="row-fluid">
            <div class="span12">
                <h3>PC商城 LOGO <a href="javascript:void(0)" id="btnDel_pcLogo" name="delBtn">&nbsp;删除&nbsp;</a><small class="auxiliary-text">图片：建议 200*90 像素的png格式</small></h3>
                <input id="imgPath_pcLogo" value="${(pcLogo)!}" name="pcLogo" type="hidden" />
                <div id="uploadBox_pcLogo" class="upload-box <#if pcLogo?has_content>upload-box-haspic</#if>" style="width: 200px;">
                    <div class="upload-ph"><span id="tip_pcLogo">+</span><input name="file" id="file_pcLogo" class="inp-file" type="file" onchange="javascript:assetChange(this.value,'pcLogo');"/></div>
                    <div class="upload-img"><img id="imageView_pcLogo" src="<#if pcLogo?has_content>${pcLogo}</#if>" alt=""/></div>
                </div>
                <div class="bui-clear"></div>
                <br/>
                <h3>商城通用会员头像 <a href="javascript:void(0)" id="btnDel_userHeadImage" name="delBtn">&nbsp;删除&nbsp;</a><small class="auxiliary-text">图片：建议 120*120 像素的png格式</small></h3>
                <input id="imgPath_userHeadImage" value="${userHeadImage!}" name="userHeadImage" type="hidden" />
                <div id="uploadBox_userHeadImage" class="upload-box upload-box-haspic " style="width: 120px;">
                    <div class="upload-ph"><span id="tip_userHeadImage">+</span><input class="inp-file" name="file" type="file" onchange="javascript:assetChange(this.value,'userHeadImage');" id="file_userHeadImage"/></div>
                    <div class="upload-img"><img id="imageView_userHeadImage" src="<#if userHeadImage?has_content>${userHeadImage}</#if>" alt=""/></div>
                </div>
                <#--<div class="upload-intropic"><img id="imageView_userHeadImage" src="<#if userHeadImage?has_content>${userHeadImage}<#else>/static/admin/images/zx_head.png</#if>" alt=""/></div>-->
           		<div class="bui-clear"></div>
                <br/>
                <h3>后台系统左上角 LOGO<a href="javascript:void(0)" id="btnDel_backgroundSystem" name="delBtn">&nbsp;删除&nbsp;</a><small class="auxiliary-text">图片：建议 200*60 像素的png格式</small></h3>
                <input id="imgPath_backgroundSystem" value="${backgroundSystem!}" name="backgroundSystem" type="hidden" />
                <div id="uploadBox_backgroundSystem" class="upload-box upload-box-haspic " style="width: 120px;">
                    <div class="upload-ph"><span id="tip_backgroundSystem">+</span><input class="inp-file" name="file" type="file" onchange="javascript:assetChange(this.value,'backgroundSystem');" id="file_backgroundSystem"/></div>
                    <div class="upload-img"><img id="imageView_backgroundSystem" src="<#if backgroundSystem?has_content>${backgroundSystem}</#if>" alt=""/></div>
                </div>
            </div>
            <div class="span12">
                <h3>移动商城 LOGO <a href="javascript:void(0)" id="btnDel_mobileLogo" name="delBtn">&nbsp;删除&nbsp;</a><small class="auxiliary-text">(图片：建议 200*90 像素的png格式)</small></h3>
                <input id="imgPath_mobileLogo" value="${mobileLogo!}" name="mobileLogo" type="hidden" />
                <div id="uploadBox_mobileLogo" class="upload-box <#if mobileLogo?has_content>upload-box-haspic</#if>" style="width: 200px;">
                    <div class="upload-ph"><span id="tip_mobileLogo">+</span><input name="file" id="file_mobileLogo" class="inp-file" type="file" onchange="javascript:assetChange(this.value,'mobileLogo');"/></div>
                    <div class="upload-img"><img id="imageView_mobileLogo" src="<#if mobileLogo?has_content>${mobileLogo}</#if>" alt=""/></div>
                </div>
                <div class="bui-clear"></div>
                <br/>
                <h3>PC商城登录页面背景图<a href="javascript:void(0)" id="btnDel_loginBackgroundImage" name="delBtn">&nbsp;删除&nbsp;</a>
                    <small class="auxiliary-text">图片：建议 1900*570 像素的png格式</small>
                </h3>
                <input id="imgPath_loginBackgroundImage" value="${loginBackgroundImage!}" name="loginBackgroundImage" type="hidden" />
                <div id="uploadBox_loginBackgroundImage" class="upload-box <#if loginBackgroundImage?has_content>upload-box-haspic</#if>">
                    <div class="upload-ph"><span id="tip_loginBackgroundImage">+</span><input name="file" id="file_loginBackgroundImage" class="inp-file" type="file" onchange="javascript:assetChange(this.value,'loginBackgroundImage');"/></div>
                    <div class="upload-img"><img id="imageView_loginBackgroundImage" src="<#if loginBackgroundImage?has_content>${loginBackgroundImage}</#if>" alt=""/></div>
                </div>
                <#--<h3>移动商城  悬浮菜单  <a href="javascript:void(0)" id="btnDel_mobileMenuLogo" name="delBtn">&nbsp;删除&nbsp;</a><small class="auxiliary-text">(图片：建议 80*80 像素的png格式)</small></h3>
                <input id="imgPath_mobileMenuLogo" value="${mobileMenuLogo!}" name="mobileMenuLogo" type="hidden" />
                <div id="uploadBox_mobileMenuLogo" class="upload-box upload-box-round upload-box-round-s <#if mobileMenuLogo?has_content>upload-box-haspic</#if>">
                    <div class="upload-ph"><span id="tip_mobileMenuLogo">+</span><input id="file_mobileMenuLogo" class="inp-file" name="file" type="file" onchange="javascript:assetChange(this.value,'mobileMenuLogo');"/></div>
                    <div class="upload-img" style="line-height:1.5;"><img id="imageView_mobileMenuLogo" src="<#if mobileMenuLogo?has_content>${mobileMenuLogo}</#if>" alt=""/></div>
                </div>-->
                <#--<div class="upload-intropic" style="margin-left: -100px;"><img src="/static/admin/images/zx_mobilemenu.png" alt=""/></div>-->
            </div>
        </div>
        <br/>
        <#-- <div class="row-fluid">
            <div class="span12">
                <h3>PC商城登录页面背景图<a href="javascript:void(0)" id="btnDel_loginBackgroundImage" name="delBtn">&nbsp;删除&nbsp;</a>
                    <small class="auxiliary-text">图片：建议 1900*570 像素的png格式</small>
                </h3>
                <input id="imgPath_loginBackgroundImage" value="${loginBackgroundImage!}" name="loginBackgroundImage" type="hidden" />
                <div id="uploadBox_loginBackgroundImage" class="upload-box <#if loginBackgroundImage?has_content>upload-box-haspic</#if>">
                    <div class="upload-ph"><span id="tip_loginBackgroundImage">+</span><input name="file" id="file_loginBackgroundImage" class="inp-file" type="file" onchange="javascript:assetChange(this.value,'loginBackgroundImage');"/></div>
                    <div class="upload-img"><img id="imageView_loginBackgroundImage" src="<#if loginBackgroundImage?has_content>${loginBackgroundImage}</#if>" alt=""/></div>
                </div>
            </div>
            <div class="span12">
                <h3>移动商城生成的桌面图标
                	<a href="javascript:void(0)" id="btnDel_mobileFavImg" name="delBtn">&nbsp;删除&nbsp;</a>
                    <div class="title-intro">
                        <small class="auxiliary-text">(图片：建议 144*144 像素的png格式)</small>
                    </div>
                </h3>
                <input id="imgPath_mobileFavImg" value="${mobileFavImg!}" name="mobileFavImg" type="hidden" />
                <div id="uploadBox_mobileFavImg" class="upload-box upload-box-round upload-box-round-corner <#if mobileFavImg?has_content>upload-box-haspic</#if>">
                    <div class="upload-ph"><span id="tip_mobileFavImg">+</span><input id="file_mobileFavImg" class="inp-file" name="file" type="file" onchange="javascript:assetChange(this.value,'mobileFavImg');"/></div>
                    <div class="upload-img" style="line-height:1.5;"><img id="imageView_mobileFavImg" src="<#if mobileFavImg?has_content>${mobileFavImg}</#if>" alt=""/></div>
                </div>
            </div>
        </div>-->
    <#--<@securityAuthorize ifAnyGranted="decorate:basic_setting">-->
        <div class="actions-bar">
            <div class="form-action">
                <button class="button button-large button-primary" id="save">保存</button>
            </div>
        </div>
    <#--</@securityAuthorize>-->
    </form>
</div>
<script type="text/javascript">
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    setTimeout(function(){
                    	$("#save").attr("disabled",false);
                    },1000);
                    //window.location.href='${ctx}/admin/sa/decorate/site/edit';
                }
            }
        }).render();
        
        form.on('beforesubmit', function(){
			$("#save").attr("disabled",true);
	    });
        
        $("a[name='delBtn']").on('click', function(){
            var delTargetType = $(this).attr("id").split("_")[1];
            $("input[name='"+delTargetType+"']").val("");
            $("#imageView_"+delTargetType).attr("src","");
            $("#tip_"+delTargetType).html("+");

            if($("#imageView_"+delTargetType).attr("default-val")){
                $("#imageView_"+delTargetType).attr("src",$("#imageView_"+delTargetType).attr("default-val"));
            }
        });
    });
</script>
</body>
</html>