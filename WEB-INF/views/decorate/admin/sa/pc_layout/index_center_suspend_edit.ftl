<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
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
                url:'${ctx}/common/staticAsset/upload/customTemplate',
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
            assertUrl = assertUrl;
            var targetFileDom = $("#"+ targetFileId);
            var targetFileType = $(targetFileDom).attr("data-file-type");
            var imageDom = "<img style='width: 360px;height: 360px;' src='"+assertUrl+"' alt=''/>";
            $(targetFileDom).parents(".centerSuspendContent").find(("." + targetFileType)).html(imageDom);
        }
    </script>
</head>
<body>
<#--<div id="tab">
    <ul class="bui-tab nav-tabs">
        <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">首页广告弹窗</span></li>
    </ul>
</div>-->
<form class="form-horizontal" id="centerSuspendContainerForm" method="POST" action="${ctx}/admin/sa/pc/decorate/centerSuspend/edit">
    <input type="hidden" name="centerSuspendJson" value="">
    <div class="centerSuspendModel" style="display: none;">
        <div class="clearfix">
            <h3 class="pull-left">第<span name="centerSuspendCountSpan"></span>张</h3>
            <a name="centerSuspendDelHref" class="pull-left offset1" href="javascript:void(0)">删除</a>
        </div>
        <div class="control-group">
            <div class="control-label control-label-auto">
                <div class="file-btn">
                    <button style="width: 120px;" class="button">弹窗广告图片</button>
                    <input type="file" class="inp-file" name="file" data-file-type="centerSuspendImg"/>
                </div>
            </div>
            <div class="controls control-row1">
                <input type="text" data-id="centerSuspendImgLinkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
            </div>
            <div class="bui-clear"></div>
            <p class="auxiliary-text">建议图片大小：500*500 像素</p>
        </div>
        <div class="zx-banner zx-banner-detail-side centerSuspendImg">
            <b>图片预览区</b>
        </div>
    </div>

    <div class="btn-add"><a href="javascript:void(0);" id="addHref">+亲，新增一张</a></div>

    <div class="actions-bar">
        <div class="form-action">
            <button class="button button-large button-primary">保存</button>
        </div>
    </div>
</form>
<script type="text/javascript">
    BUI.use('common/page');

    $(function(){

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#centerSuspendContainerForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("首页广告弹窗保存成功!");
                }
            }
        });
        form.on('beforesubmit', function(){
            return collectData(); //收集数据，以JSON字符串的形式传输
        });
        form.render();

        $(".btn-add").bind('click', function(){
            addCenterSuspendContainer();
        })

        initCenterSuspendContent();
    });

    //初始化
    function initCenterSuspendContent(){
    <#if centerSuspendCustomTemplates?has_content>
        <#list centerSuspendCustomTemplates as centerSuspendTemplate>
            var centerSuspendContent = addCenterSuspendContainer();
            var centerSuspendContentImgId = $(centerSuspendContent).find("input[data-file-type='centerSuspendImg']").attr("id");
            loadImage('${(centerSuspendTemplate.picUrl)?default("")}', centerSuspendContentImgId);
            $(centerSuspendContent).find("input[data-id='centerSuspendImgLinkUrl']").val('${(centerSuspendTemplate.linkUrl)?default("")}');
        </#list>
    <#else>
        //addCenterSuspendContainer();
    </#if>
    }

    function addCenterSuspendContainer(){
        var centerSuspend = $(".centerSuspendModel").clone();
        centerSuspend.removeClass("centerSuspendModel");
        centerSuspend.addClass("centerSuspendContent");
        var currentCenterSuspendContentIndex = (getCurrentCenterSuspendContentCount() + 1);
        centerSuspend.attr("data-edit-index", currentCenterSuspendContentIndex);
        centerSuspend.find("span[name='centerSuspendCountSpan']").html("【" + currentCenterSuspendContentIndex + "】");
        centerSuspend.find("a[name='centerSuspendDelHref']").bind('click', function(){
            deleteCenterSuspendContent(centerSuspend);
        });
        centerSuspend.find("input[name='file']").each(function(){
            var fileType = $(this).attr("data-file-type");
            $(this).attr("id", (fileType + "_" + currentCenterSuspendContentIndex));
        });
        centerSuspend.find("input[name='file']").live('change', function(){
            assetChange($(this).val(), $(this).attr("id"));
        });
        centerSuspend.insertBefore($(".centerSuspendModel"));
        centerSuspend.show();
        resetAddBtnTip();
        return centerSuspend;
    }

    function collectData(){

        var validResult = true;
        var centerSuspendContentArray = [];
        $(".centerSuspendContent").each(function(){
            var centerSuspendContentObj = {};
            var editIndex = $(this).attr("data-edit-index");
            var centerSuspendImgUrl = $(this).find(".centerSuspendImg").find("img").attr("src");
            if(editIndex){
                if(!centerSuspendImgUrl || centerSuspendImgUrl == ""){
                    BUI.Message.Alert("弹窗广告图片不能为空!");
                    validResult = false;
                    return false;
                }
                centerSuspendContentObj["index"] = editIndex;
                centerSuspendContentObj["picUrl"] = centerSuspendImgUrl;
                var centerSuspendImgLinkUrl = $(this).find("input[data-id='centerSuspendImgLinkUrl']").val();
                centerSuspendContentObj["linkUrl"] = centerSuspendImgLinkUrl;
                centerSuspendContentObj["openNewWin"] = true;

                centerSuspendContentArray.push(centerSuspendContentObj);
            }
        });

        $("input[name='centerSuspendJson']").val(JSON.stringify(centerSuspendContentArray));
        return validResult;
    }

    function getCurrentCenterSuspendContentCount(){
        return $(".centerSuspendContent").length;
    }

    function deleteCenterSuspendContent(obj){
        var deleteCenterSuspendContentIndex = $(obj).attr("data-edit-index");
        $(obj).remove();
        $(".centerSuspendContent").each(function(){
            var index = $(this).attr("data-edit-index");
            if(parseInt(index) > parseInt(deleteCenterSuspendContentIndex)){
                var newIndex = (parseInt(index) - 1);
                $(this).attr("data-edit-index", newIndex);
                $(this).find("span[name='centerSuspendCountSpan']").html("【" + newIndex + "】");
                $(this).find("input[type='file']").each(function(){
                    var fileType = $(this).attr("data-file-type");
                    $(this).attr("id", (fileType + "_" + newIndex));
                });
            }
        });
        resetAddBtnTip();
    }

    function resetAddBtnTip(){
        var tip = "+亲，新增一张";
        if(getCurrentCenterSuspendContentCount() >= 1){
            tip = "+亲，再来一张";
            $("#addHref").parent().hide();
        } else {
            $("#addHref").parent().show();
        }
        $("#addHref").html(tip);
    }


</script>
</body>
</html>