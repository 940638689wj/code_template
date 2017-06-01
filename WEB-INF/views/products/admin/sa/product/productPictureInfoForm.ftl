<input type="hidden" name="primaryImg" id="primaryImg" value="">
<input type="hidden" name="altImg" id="altImg" value="">
<div class="prd-pics">
    <div class="prd-upload">
        <div class="prd-upload-icon"><img id="primary_image_review" src="" style="display: none;width: 150px;height: 150px;"></div>
        <p>本地上传图片大小不能超过500K<br>最佳尺寸建议 800px * 800px<br>本类目下您最多可上传 5 张图片</p>
    </div>
    <div class="prd-thumblist">
        <p><em>800*800</em> 以上的图片可以在宝贝详情页主图提供图片放大功能</p>
        <ul>
            <li class="prd-thumb-main" id="primaryPicContainer">
                <input type="file" id="primaryPicFileObj" style="opacity:0;filter:alpha(opacity:0);z-index:999;cursor:pointer;position: absolute; bottom: 0; width: 100%;height: 100%;" name="file" onchange="javascript:uploadPrimaryPicFile(this);">
                <a class="uploadPicTip" id="uploadPrimaryTip">商品主图<br>上传</a>
                <img class="uploadPicImg" src="" alt="" style="display: none;"/>
            </li>
            <li class="prd-thumb-main" id="altPicContainer" name="altPicContainerName">
                <input type="file" id="altPicFileObj" style="opacity:0;filter:alpha(opacity:0);z-index:999;cursor:pointer;position: absolute; bottom: 0; width: 100%;height: 100%;" name="file" onchange="javascript:uploadAltPicFile(this);" multiple="multiple">
                <a class="uploadPicTip">商品图<br>上传</a>
                <img class="uploadPicImg" src="" alt="" style="display: none;"/>
                <div class="prd-thumb-tool" style="display: none;"><a class="thumb-delete" href="javascript:void(0);">删除</a></div>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    var picUploadPath = "${ctx}/common/staticAsset/upload/product";

    var picType;
    var maxAltImageCount = 4; //列表图最大上传数目

    initPic();

    function initPic(){
        <#if productPicInfoList?? && productPicInfoList?has_content>
            <#list productPicInfoList as productPicInfo>
                <#if productPicInfo.isDefaultPic==1>
                    var primaryUrl = '${productPicInfo.picUrl?default('')}';
                    var primaryId = '${productPicInfo.productPicId}';
                    initPrimaryPic(primaryId, primaryUrl);
                <#else>
                    var altUrl = '${productPicInfo.picUrl?default('')}';
                    var altId = '${productPicInfo.productPicId}';
                    initAltPic(altId, altUrl);
                </#if>
            </#list>
        </#if>
    }

    function initPrimaryPic(primaryId, primaryUrl){
        hasImageEvent(0, primaryUrl, 'media', 'primary');
        primaryImageMediaArray[0] = primaryUrl;
        $("#primaryImg").val(primaryImageMediaArray);
    }

    function initAltPic(altId, altUrl){
        var mediaCount = altImageMediaArray.length;
        hasImageEvent(mediaCount , altUrl, 'media', 'alt');
        altImageMediaArray[mediaCount] = altUrl;
        $("#altImg").val(altImageMediaArray);
        //alert($("input[name='altImg']").val());
    }

    function uploadPrimaryPicFile(obj){
        if($(obj).parent().length<=0){//修复chrome36的bug.ajax上传clone多次调用onchange
            return;
        }
        picType = 'primary';
        doUpload(obj);
    }

    function uploadAltPicFile(obj){
        if($(obj).parent().length<=0){//修复chrome36的bug.ajax上传clone多次调用onchange
            return;
        }
        picType = 'alt';
        doUpload(obj);
    }

    function doUpload(obj){
        var validSuccess = true;
        if(obj.files){
            var files = obj.files;
            for(var i = 0; i < files.length; i++){
                validSuccess = validFile(files[i].name);
                if(!validSuccess){
                    break;
                }
            }

            if(!validSuccess){
                return false;
            }

            if(picType == "alt"){
                if((getAltPicCount() + files.length) > maxAltImageCount){
                    BUI.Message.Alert("列表图最多只能上传" + maxAltImageCount + "张图!");
                    return false;
                }
            }
        } else {
            var fileName = obj.value;
            validSuccess = validFile(fileName);

            if(picType == "alt"){
                if((getAltPicCount() + 1) > maxAltImageCount){
                    BUI.Message.Alert("列表图最多只能上传" + maxAltImageCount + "张图!");
                    return false;
                }
            }
        }

        $.ajaxFileUpload({
            url : picUploadPath,
            secureuri: false,
            fileElementId: obj.id,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                picUploadSuccessHander(data);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }

    function validFile(fileName){

        if(fileName == null || jQuery.trim(fileName).length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert(fileName + "文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);
        suffix = jQuery.trim(suffix).toLowerCase();

        if(suffix.length <= 0 ||
                ("jpg" != suffix && "png" != suffix && "jpeg" != suffix)){
            BUI.Message.Alert(suffix + "文件格式暂不支持!");
            return false;
        }

        return true;
    }

    function picUploadSuccessHander(data){
        if(picType == "primary"){
            uploadPrimarySuccess(data);
        } else {
            uploadAltSuccess(data);
        }
    }

    /**
     * 上传主图成功
     *
     * @param uploadResult
     */
    function uploadPrimarySuccess(serverResult) {
        var url = serverResult.displayUrl;
        hasImageEvent('primary_imageView', url, 'upload', 'primary');
        if(primaryImageMediaArray.length > 0){
            primaryImageMediaArray.splice(0, primaryImageMediaArray.length);
        }
        primaryImageArray[0] = serverResult.displayUrl;
        $("#primaryImg").val(primaryImageArray);
    }

    /**
     * 上传其他图成功
     *
     * @param serverResult
     */
    function uploadAltSuccess(serverResult) {
        var url = serverResult.displayUrl;
        var altImageCount = altImageArray.length;
        hasImageEvent(altImageCount, url, 'upload', 'alt');
        altImageArray[altImageCount] = serverResult.displayUrl;
        //$("#altImg").val(altImageArray);
    }

    /**
     * 当元素中被添加入图片
     *
     */
    function hasImageEvent(picIndex, url, imageFromType, picType){
        if(picType == "primary"){
           var primaryPicContainer = $("#primaryPicContainer");
           var image = primaryPicContainer.find(".uploadPicImg");
           image.attr("src", url);
           image.attr("data-image-form-type", imageFromType);
           primaryPicContainer.find(".uploadPicTip").hide();
           image.show();

           $("#primary_image_review").attr("src", url);
           $("#primary_image_review").show();
        } else {
           var targetPicContainer = $("#altPicContainer").clone();
           targetPicContainer.find("input[name='file']").remove();
           targetPicContainer.removeAttr("id");
           var image = targetPicContainer.find(".uploadPicImg");
           image.attr("src", url);
           image.attr("data-image-form-type", imageFromType);
           image.attr("data-image-index", picIndex);
           targetPicContainer.hover(function(){
               imageMouseOver(targetPicContainer);
           }, function(){
               imageMouseOut(targetPicContainer);
           });
           targetPicContainer.find(".uploadPicTip").hide();
           image.show();
           targetPicContainer.find(".thumb-delete").on('click',function(){
              deleteAltPic(picIndex, imageFromType, targetPicContainer);
           });
           targetPicContainer.insertBefore("#altPicContainer");

           showOrHideUploader();
        }
    }

    /**
     * 鼠标移动到上面的事件
     *
     */
    function imageMouseOver(obj){
        $(obj).find(".prd-thumb-tool").show();
    }

    function toolMouseOver(obj){
        return false;
    }

    /**
     * 鼠标移出事件
     *
     */
    function imageMouseOut(obj){
        $(obj).find(".prd-thumb-tool").hide();
    }

    function toolMouseOut(obj){
        return false;
    }

    function deleteAltPic(index, imageFromType, obj){
        delete altImageArray[index];
        obj.remove();
        showOrHideUploader();
        var altPic = $('li[name="altPicContainerName"]');
        var altPicStr = "";
		$(altPic).each(function(i, item){
			altPicStr += $(this).find("img").attr("src")+",";
		});
		if(altPicStr.length > 0){
			altPicStr = altPicStr.substring(0, altPicStr.length-2);
		}
		//alert(altPicStr)
        $("#altImg").val(altPicStr);
    }

    /**
     * 判断显示或隐藏上传控件的条件，并执行操作
     *
     */
    function showOrHideUploader(){
       var altPicContainerCount = getAltPicCount();
       //列表图最大只能有9个，所以当已经存在9个的时候，后面的上传区域应该隐藏
       if(altPicContainerCount >= 9){
           $("#altPicContainer").hide();
       } else {
           $("#altPicContainer").show();
       }
    }

    function getAltPicCount(){
       return ($("li[name='altPicContainerName']").length - 1);
    }
</script>