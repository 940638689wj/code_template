<script src="/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
<script>
    // 分页组件
    avalon.component('ms-uploadImg', {
        template: '<div class="con">' +
        '<div class="m-imgshow">' +
        '<div class="thumbnail-list" :for="($index, picUrl) in @picUrlList">' +
        '<div class="img">' +
        '<img :attr="{src: picUrl}">' +
        '<div class="operate">' +
        '<i class="del" :click="delPic($index)">删除</i>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="thumbnail-list" :visible="@picUrlList.length < 5">' +
        '<div class="image-upload">' +
        '<input type="file" name="file" class="filefield" id="uploadInput" :change="uploadImg($event);">' +
        '</div>' +
        '</div>' +
        '<span class="upload-num">最多上传<span class="text-red">5</span>张</span>' +
        '</div>' +
        '</div>',
        defaults: {
            index: 0, // 排序
            num: 5, // 图片数量
            picUrlList: [],
            updatePicUrl: null,
            // 上传图片
            uploadImg: function (e) {
                var obj = this;
                var fileName = e.target.value;
                if (fileName == null || fileName.trim().length <= 0) {
                    layer.msg("请选择文件!");
                    return false;
                }

                var suffixIndex = fileName.lastIndexOf('.');
                if (suffixIndex <= 0) {
                    layer.msg("文件格式错误!");
                    return false;
                }

                var ext = fileName.substr(suffixIndex + 1);

                if (!(ext && /^(jpg|png|gif|bmp|pcx|tiff|jpeg|tga|exif|fpx|svg)$/.test(ext.toLowerCase()))) {
                    layer.msg("文件格式错误!");
                    return false;
                }

                $.ajaxFileUpload({
                    url: '/common/staticAsset/upload/lastFlag',
                    fileElementId: "uploadInput",
                    dataType: "json",
                    method: 'post',
                    success: function (data) {
                        obj.picUrlList.push(data.assetUrl);
                        obj.updatePicUrl(obj.picUrlList, obj.index);
                    },
                    error: function (data, status, e) {
                        layer.msg("上传失败" + e);
                    }
                });
            },
            // 删除图片
            delPic: function (i) {
                this.picUrlList.removeAt(i);
                this.updatePicUrl(this.picUrlList, this.index)
            }

        }
    });

</script>