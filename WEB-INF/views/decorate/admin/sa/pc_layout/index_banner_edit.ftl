<#assign ctx = request.contextPath>
<#assign indexAdBanner = Static["cn.yr.chile.common.constant.DefinedModuleKeys"].INDEX_AD_BANNER.key>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script src="${ctx}/static/admin/js/validator.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">

        function assetChange(fileName, targetFileId){
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
                    ("jpg" != suffix.trim().toLowerCase() && "png" != suffix.trim().toLowerCase())){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            $.ajaxFileUpload({
                url:'${ctx}/common/staticAsset/upload/banner',
                secureuri: false,
                fileElementId: targetFileId,
                dataType: "json",
                method : 'post',
                success: function (data, status) {
                    loadImage(data.assetUrl, targetFileId);
                },
                error: function (data, status, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(assertUrl,targetFileId) {
            var targetFileDom = $("#"+ targetFileId);
            var targetFileType = $(targetFileDom).attr("data-file-type");
            var imageDom = "<img src='"+assertUrl+"' alt=''/>";
            $(targetFileDom).parents(".gdrContent").find(("." + targetFileType)).html(imageDom);
        }
    </script>
</head>
<body>
<form class="form-horizontal" id="gdrContainerForm" method="POST" action="edit">
    <input type="hidden" name="moduleType" value="${bannerModuleType?default(indexAdBanner)}">
    <div class="control-group">
        <label class="control-label" style="width: auto;"><s>*</s>轮播高度：</label>
        <div class="controls" name="largeMainImg">
            <label class="radio" for="normalImgRadio"><input <#if adBannerModel ?? && (adBannerModel.booleanValue)?has_content && !adBannerModel.booleanValue>checked="checked"</#if> id="normalImgRadio" type="radio" name="booleanValue" value="false">420px</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="largeImgRadio"><input  <#if adBannerModel ?? && (adBannerModel.booleanValue)?has_content && adBannerModel.booleanValue>checked="checked"</#if> id="largeImgRadio" type="radio" name="booleanValue" value="true">500px</label>
        </div>
    </div>
    <div class="btn-add"><a href="javascript:void(0);" id="addHref">+亲，新增一张</a></div>

    <div class="actions-bar">
        <div class="form-action">
            <button class="button button-large button-primary">保存</button>
        </div>
    </div>
</form>
<div class="gdrModel" style="display: none;">
    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="id" value="">

    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="bigImg.id" value="">
    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="bigImg.picUrl" value="">


    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="smallTopImg.id" value="">
    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="smallTopImg.picUrl" value="">

    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="smallBottomImg.id" value="">
    <input type="hidden" data-param-obj-name="banners" data-param-attr-name="smallBottomImg.picUrl" value="">

    <div class="clearfix">
        <h3 class="pull-left">第<span name="gdrCountSpan"></span>张</h3>
        <a name="gdrDelHref" class="pull-left offset1" href="javascript:void(0)">删除</a>
    </div>
    <div class="control-group">
        <div class="control-label control-label-auto">
            <input type="text" data-param-obj-name="banners" data-param-attr-name="seq" style="width: 86px;" class="control-text input-small" placeholder="排序值"/>
        </div>
        <div class="controls">
            <input type="text" data-param-obj-name="banners" data-param-attr-name="name" class="control-text input-large" placeholder="广告图名称"/>
        </div>
    </div>
    <div class="control-group">
        <div class="control-label control-label-auto">
            <div class="file-btn">
                <button style="width: 100px;" class="button">上传大图</button>
                <input type="file" class="inp-file" name="file" data-file-type="bigImg"/>
            </div>
        </div>
        <div class="controls control-row1">
            <input type="text" data-param-obj-name="banners" data-param-attr-name="bigImg.linkUrl" data-id="bigImgLinkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
        </div>
        <div class="bui-clear"></div>
        <p class="auxiliary-text">建议图片内容1200px宽，整体图片底色可延伸至1920px以适应宽屏</p>
    </div>
    <div class="control-group">
        <div class="control-label control-label-auto">
            <div class="file-btn">
                <button style="width: 100px;" class="button">上传小图1</button>
                <input type="file" class="inp-file" name="file" data-file-type="smallImg1"/>
            </div>
        </div>
        <div class="controls control-row1">
            <input type="text" data-param-obj-name="banners" data-param-attr-name="smallTopImg.linkUrl" data-id="smallImg1LinkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
        </div>
        <div class="bui-clear"></div>
        <p class="auxiliary-text">建议图片大小：180*180 像素</p>
    </div>
    <div class="control-group">
        <div class="control-label control-label-auto">
            <div class="file-btn">
                <button style="width: 100px;" class="button">上传小图2</button>
                <input type="file" class="inp-file" name="file"  data-file-type="smallImg2"/>
            </div>
        </div>
        <div class="controls control-row1">
            <input type="text" data-param-obj-name="banners" data-param-attr-name="smallBottomImg.linkUrl" data-id="smallImg2LinkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
        </div>
        <div class="bui-clear"></div>
        <p class="auxiliary-text">建议图片大小：180*180 像素</p>
    </div>
    <div class="zx-banner">
        <div class="zx-banner-main bigImg">
            <b>大图</b>
        </div>
        <div class="zx-banner-side smallImg1">
            <b>小图1</b>
        </div>
        <div class="zx-banner-side2 smallImg2">
            <b>小图2</b>
        </div>
    </div>
    <hr>
</div>
<script type="text/javascript">
    BUI.use('common/page');

    $(function(){

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#gdrContainerForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("广告轮播图保存成功!");
                }
            }
        });
        form.on('beforesubmit', function(){
            return collectData(); //收集数据，以JSON字符串的形式传输
        });
        form.render();

        $(".btn-add").bind('click', function(){
            addGdrContainer();
        })

        initGoodsDetailRightContent();
    });

    function collectData(){
        var validResult = true;
        $(".gdrContent").each(function(){
            var gdrContentSeq = $(this).find("input[data-param-attr-name='seq']").val();
            gdrContentSeq = YrValidator.replaceAllSpace(gdrContentSeq);
            if(!YrValidator.isNotNegativeInteger(gdrContentSeq)){
                validResult = false;
                return false;
            }
            var bigImgUrl = $(this).find(".bigImg").find("img").attr("src");
            $(this).find("input[data-param-attr-name='bigImg.picUrl']").val(bigImgUrl);
            var smallTopImgUrl = $(this).find(".smallImg1").find("img").attr("src");
            $(this).find("input[data-param-attr-name='smallTopImg.picUrl']").val(smallTopImgUrl);
            var smallBottomImgUrl = $(this).find(".smallImg2").find("img").attr("src");
            $(this).find("input[data-param-attr-name='smallBottomImg.picUrl']").val(smallBottomImgUrl);
        });

        if(!validResult){
            BUI.Message.Alert("大图排序值格式错误!");
            return false;
        }

        return true;
    }

    //初始化
    function initGoodsDetailRightContent(){
    <#if adBannerModel?has_content && (adBannerModel.definedModuleItems)?has_content>
        <#list adBannerModel.definedModuleItems as bannerTemplate>
            var bannerContent = addGdrContainer();

            $(bannerContent).find("input[data-param-attr-name='id']").val('${(bannerTemplate.id)?default("")}');
            $(bannerContent).find("input[data-param-attr-name='name']").val('${(bannerTemplate.name)?default("")?html}');
            $(bannerContent).find("input[data-param-attr-name='seq']").val('${(bannerTemplate.seq)?default("")?html}');

            <#assign bannerLinks = (bannerTemplate.transientLinks)?default("")>
            <#if bannerLinks?has_content>
                <#list bannerLinks as bannerLink>
                    <#if (bannerLink.seq)?has_content>
                        <#if bannerLink.seq == 1>
                            var bannerContentBigImgId = $(bannerContent).find("input[data-file-type='bigImg']").attr("id");
                            loadImage('${(bannerLink.imgPath)?default("")}', bannerContentBigImgId);
                            $(bannerContent).find("input[data-param-attr-name='bigImg.id']").val('${(bannerLink.id)?default("")}');
                            $(bannerContent).find("input[data-param-attr-name='bigImg.linkUrl']").val('${(bannerLink.href)?default("")}');
                        </#if>
                        <#if bannerLink.seq == 2>
                            var bannerContentSmallImg1Id = $(bannerContent).find("input[data-file-type='smallImg1']").attr("id");
                            loadImage('${(bannerLink.imgPath)?default("")}', bannerContentSmallImg1Id);
                            $(bannerContent).find("input[data-param-attr-name='smallTopImg.id']").val('${(bannerLink.id)?default("")}');
                            $(bannerContent).find("input[data-id='smallImg1LinkUrl']").val('${(bannerLink.href)?default("")}');
                        </#if>
                        <#if bannerLink.seq == 3>
                            var bannerContentSmallImg2Id = $(bannerContent).find("input[data-file-type='smallImg2']").attr("id");
                            loadImage('${(bannerLink.imgPath)?default("")}', bannerContentSmallImg2Id);
                            $(bannerContent).find("input[data-param-attr-name='smallBottomImg.id']").val('${(bannerLink.id)?default("")}');
                            $(bannerContent).find("input[data-id='smallImg2LinkUrl']").val('${(bannerLink.href)?default("")}');
                        </#if>
                    </#if>
                </#list>
            </#if>
        </#list>
    <#else>
        addGdrContainer();
    </#if>
    }

    function addGdrContainer(){
        var gdrContent = $(".gdrModel").clone();
        gdrContent.removeClass("gdrModel");
        gdrContent.addClass("gdrContent");
        var currentGdrContentIndex = (getCurrentGdrContentCount() + 1);
        gdrContent.attr("data-edit-index", currentGdrContentIndex);
        gdrContent.find("span[name='gdrCountSpan']").html("【" + currentGdrContentIndex + "】");

        gdrContent.find("input[data-param-obj-name]").each(function(){
            var objName = $(this).attr("data-param-obj-name");
            var attrName = $(this).attr("data-param-attr-name");
            $(this).attr("name", (objName + "[" + (currentGdrContentIndex - 1) + "]." + attrName));
        });
        //gdrContent.find("input[data-param-attr-name='seq']").val((currentGdrContentIndex - 1));


        gdrContent.find("a[name='gdrDelHref']").bind('click', function(){
            deleteGdrContent(gdrContent);
        });
        gdrContent.find("input[name='file']").each(function(){
            var fileType = $(this).attr("data-file-type");
            $(this).attr("id", (fileType + "_" + currentGdrContentIndex));
        });
        gdrContent.find("input[name='file']").live('change', function(){
            assetChange($(this).val(), $(this).attr("id"));
        });
        gdrContent.insertBefore($("#addHref").parent());
        gdrContent.show();
        resetAddBtnTip();
        return gdrContent;
    }

    function getCurrentGdrContentCount(){
        return $(".gdrContent").length;
    }

    function deleteGdrContent(obj){
        var deleteGdrContentIndex = $(obj).attr("data-edit-index");
        $(obj).remove();
        $(".gdrContent").each(function(){
            var index = $(this).attr("data-edit-index");
            if(parseInt(index) > parseInt(deleteGdrContentIndex)){
                var newIndex = (parseInt(index) - 1);
                $(this).attr("data-edit-index", newIndex);
                $(this).find("span[name='gdrCountSpan']").html("【" + newIndex + "】");

                $(this).find("input[data-param-obj-name]").each(function(){
                    var objName = $(this).attr("data-param-obj-name");
                    var attrName = $(this).attr("data-param-attr-name");
                    $(this).attr("name", (objName + "[" + (newIndex - 1) + "]." + attrName));
                });
                //$(this).find("input[data-param-attr-name='seq']").val((newIndex - 1));

                $(this).find("input[type='file']").each(function(){
                    var fileType = $(this).attr("data-file-type");
                    $(this).attr("id", (fileType + "_" + newIndex));
                });
            }
        });
        resetAddBtnTip();
    }

    function resetAddBtnTip(){
        var tip = "+亲，再来一张";
        if(getCurrentGdrContentCount() == 0){
            tip = "+亲，新增一张"
        }
        $("#addHref").html(tip);
    }


</script>
</body>
</html>