<script style="text/javascript">
    // 图片上传
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
        var suffixStr = suffix.trim().toLocaleLowerCase();
        if(suffix.trim().length <= 0 || ("jpg" != suffixStr && "png" != suffixStr && "jpeg" != suffixStr && "gif" != suffixStr && "bmp" != suffixStr)){
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
                loadImage(data.displayAssetUrl,data.assetUrl,lastFlag);
                $("#imgshow_"+lastFlag).show();
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }
    //设置预览
    function loadImage(url,assetUrl,lastFlag) {
        $('#'+lastFlag+'Url').val(assetUrl);
        $("#"+lastFlag).attr("src", assetUrl);
    }
    //删除图片
    function delItem(lastFlag){
        $('#'+lastFlag+'Url').val('');
        $('#'+lastFlag).attr('src',"");
        $("#imgshow_"+lastFlag).hide();
    }

    $("button[type=reset]").click(function () {
        $('#cardImageUrl,#backImageUrl').val('');
        $('#cardImage,#backImage').attr('src',"");
        $("#imgshow_cardImage,#imgshow_backImage").hide();
    });
</script>