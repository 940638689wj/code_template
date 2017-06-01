<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
</head>
<body>
    <script>
        function assetChange(fileName){
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
                url:'${ctx}/common/staticAsset/upload/specarea',
                secureuri: false,
                fileElementId: "file",
                dataType: "json",
                method : 'post',
                success: function (data, status) {
                    loadImage(data.adminDisplayAssetUrl,data.assetUrl);
                },
                error: function (data, status, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(url,assertUrl) {
            $("#imgPath").val(assertUrl);
            $("#imageView").attr("src", assertUrl);
            $("#imgArea").show();
        }
    </script>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/linkForm" method="post">
        <input type="hidden" name="itemId" value="${(item.id)!}"/>
        <div class="form-content">
            <input type="hidden" name="linkId" value="${(link.id)!}">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">图片：</label>
                    <div class="controls control-row-auto">
                        <div class="cover-area">
                            <div class="cover-hd">
                                <input id="file" name="file" type="file" onchange="javascript:assetChange(this.value);"/>
                                <input id="imgPath" value="${(link.imgPath)!}" name="imgPath" type="hidden" />
                            </div>
                            <p id="upload-tip" class="upload-tip">图片建议尺寸：370像素 * 150像素</p>
                            <p id="imgArea" class="cover-bd" <#if !(link?has_content && link.imgPath?has_content)> style='display: none;'</#if>  >
                                <img  id="imageView" src="${(link.imgPath)!}" style="width: 370px;">
                            </p>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">链接地址：</label>
                    <div class="controls">
                        <input value="${(link.href)!}" name="href"  class="input-large control-text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">文字提示：</label>
                    <div class="controls">
                        <input value="${(link.alt)!?html}" name="alt" class="input-large control-text">
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">排序：</label>
                    <div class="controls">
                        <input value="${(link.seq)?default('10')}" name="seq" data-rules="{required:true,number:true}" class="input-large control-text">
                    </div>
                </div>
            </div>
        </div>

        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("保存成功！")
                        window.location.href='${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/edit?id='+${(item.id)!};
                    }
                }
            }).render();
        });
    </script>
</body>
</html>