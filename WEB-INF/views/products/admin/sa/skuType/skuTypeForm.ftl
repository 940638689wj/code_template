<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list">普通规格</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if skuType?has_content && skuType.id?has_content>编辑普通规格<#else>新增普通规格</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/skuType/save" method="post">
        <input type="hidden" name="skuTypeId" value="${(skuType.skuTypeId)!}"/>
        <div id="productOptionForm" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>规格名称：</label>
                    <div class="controls">
                        <input value="${(skuType.skuTypeDesc)!}" name="skuTypeDesc" id="skuTypeDesc" type="text" data-rules="{required:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">排序值：</label>
                    <div class="controls">
                        <input value="${(skuType.displayId)!}" name="displayId" id="displayId" type="text" data-rules="{min:0,number:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
           
    </div>
    <div class="actions-bar">
        <button type="submit" class="button button-primary">保存</button>
        <button type="reset" class="button">重置</button>
    </div>
    </form>
</div>
<script type="text/javascript">
	// BUI框架提交保存
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/skuType/list";
                }
            }
        }).render();
        
       
    });
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
        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        $.ajaxFileUpload({
            url:'${ctx}/common/staticAsset/upload/brand',
            secureuri: false,
            fileElementId: "file_"+lastFlag,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                loadImage(data.displayAssetUrl,data.assetUrl,lastFlag);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }
    //设置预览
    function loadImage(url,assetUrl,lastFlag) {
        $('#brandImgUrl').val(assetUrl);
        $("#imageView_"+lastFlag).attr("src", assetUrl);
        $("#imgPath_"+lastFlag).val(assetUrl);
        $("#imgArea_"+lastFlag).show();
    }
    
    //删除图片
    function delItem(){
    	$('#brandImgUrl').val(' ');
    	$('#imageView_cardBackImage').attr('src',"");
    }
    
</script>
</body>
</html>