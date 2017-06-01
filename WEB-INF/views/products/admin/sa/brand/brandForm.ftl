<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="breadcrumb" aria-disabled="false" aria-pressed="false">
                 <li aria-disabled="false" aria-pressed="false"><a href="${ctx}/admin/sa/brand/list">商品品牌管理</a><span class="divider">&gt;&gt;</span></li>
                 <li class="active"><#if productBrand?? && productBrand?has_content>编辑品牌<#else>新增品牌</#if></li>  
            </ul>
        </div>
    </div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/brand/save" method="post">
    	<input type="hidden" name="brandId" value="<#if (productBrand.brandId)?has_content>${productBrand.brandId}</#if>">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>品牌：</label>
                    <div class="controls">
                        <input value="${(productBrand.brandName)!?html}" name="brandName" data-rules="{required:true,regexp:/^([\u4e00-\u9fa5]|[A-Za-z]|[0-9]){1,20}$/}"
                                data-messages="{regexp:'请输入正确的品牌名称！'}"class="input-normal control-text">
                    </div>
                    <div id="info"></div>
                </div>
            </div>
			<div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>排序：</label>
                    <div class="controls">
                        <input value="${(productBrand.displayId)!?html}" name="displayId" data-rules="{min:0,number:true,required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>状态：</label>
                    <#assign brandStatusCd=0/>
	                <#if productBrand?? && productBrand?has_content && productBrand.brandStatusCd == 1>
	                     <#assign brandStatusCd=1/>
	                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="brandStatusCd" value="1" <#if brandStatusCd==1>checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="brandStatusCd" value="0" <#if brandStatusCd==0>checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
            <#if productBrand?? && productBrand?has_content>
	            <div class="row">
	                <div class="control-group">
	                    <label class="control-label">网址：</label>
	                    <div class="controls">
	                        /m/brand/detail/<#if (productBrand.brandId)?has_content>${productBrand.brandId}</#if>.html
	                    </div>
	                </div>
	            </div>
			</#if>
			<div class="row">
                <div class="control-group">
                    <label class="control-label">图片：</label>
                     <div class="controls">	
						<input id="file_cardBackImage" name="file" type="file" onchange="javascript:assetChange(this.value,'cardBackImage');" >
					</div>
                </div>
            </div>
            <div class="row" style="height:100">
                <div class="control-group">  
                 	<label class="control-label">图像预览</label>
                  	<div class="controls control-row-auto" >                             						                     							
						<input type="hidden" id="brandImgUrl" name="brandImgUrl" value="<#if (productBrand.brandImgUrl)?has_content>${productBrand.brandImgUrl}</#if>" class="input-normal control-text" >   
						<img id="imageView_cardBackImage" width="100px" height="100px" src="<#if (productBrand.brandImgUrl)?has_content>${productBrand.brandImgUrl}</#if>" >          
                		(图片：建议90*90像素的JPG、PNG)
                		<input type="button" onclick="delItem();" value=删除图片></input>
                	</div>
               	</div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>内容：</label>
                    <div class="controls control-row-auto">
                        <script type="text/plain" id="brandDescription" name="brandDescription"><#if (productBrand.brandDescription)?has_content>${productBrand.brandDescription}</#if></script>
                    </div>
                </div>
            </div>
            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
<script type="text/javascript">
	<#--// BUI框架提交保存-->
    $(function(){
        <#--$("input[name='brandName']").on('keyup',function (){-->
            <#--var _this = $("input[name='brandName']");-->
            <#--var errorC = $(".x-field-error");-->
            <#--_this.parent().find(".remoteError").remove();-->
            <#--if(_this.val() !=null && _this.val() !="" && errorC !=undefined && errorC.length ==0){-->
                <#--var errorStr ="<span class='x-field-error remoteError'><span class='x-icon x-icon-mini x-icon-error'>!</span><label class='x-field-error-text'>该名称已存在</label></span>";-->
                <#--//不能为空！</label></span>';-->
                <#--$.post("${ctx}/admin/sa/brand/getBrandName",{"brandName":_this.val()},function (data){-->
                    <#--console.log(data);-->
                    <#--if(data.result =="success"){-->
                        <#--_this.parent().find(".remoteError").remove();-->
                        <#--_this.parent().append(errorStr);-->
                        <#--return false;-->
                    <#--}else{-->
                        <#--_this.parent().find(".remoteError").remove();-->
                    <#--}-->
                <#--});-->
            <#--}-->
        <#--});-->


        var brandId = ${(productBrand.brandId)!"0"};
        window.msg_editor = new UE.ui.Editor({
            initialFrameWidth: 900,
            initialFrameHeight: 300,
            elementPathEnabled: false,
            wordCount: false,
            imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=productBrand&id=" + brandId + "&platform=admin",
            imagePath: ""
        });
        window.msg_editor.render("brandDescription");
        $("li[href]").click(function () {
            var href = $(this).attr("href");
            window.location.href = href;
        });

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if(!data){
                    app.showError("保存失败！该名称已存在");
                    return false;
                }
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/brand/list";
                }
            }
        }).render();


        <#--//根据name获取字段-->
        <#--var field = form.getField('brandName');-->
                <#--//设置异步请求配置项-->
        <#--field.set('remote',{-->
            <#--url : '${ctx}/admin/sa/brand/getBrandName',-->
            <#--dataType : 'json',-->
            <#--callback : function (data) {-->
                <#--//处理数据，此处也可以根据结果显示请求数据的验证结果，-->
                <#--// return errorMsg; 即可-->
                <#--if(data.result =="error")-->
                <#--$('#info').text(BUI.JSON.stringify(data.message));-->
            <#--}-->
        <#--});-->


        //点击重置的时候也把图片给重置掉
		$('button[type="reset"]').click(function() {
			$('#brandImgUrl').val('${(productBrand.brandImgUrl)!}');
			$('#imageView_cardBackImage').attr("src","${(productBrand.brandImgUrl)!}");
			<#if productBrand?? && productBrand?has_content && productBrand.brandStatusCd==1>
				$('input[name="brandStatusCd"][value="1"]').attr("checked",true);
			<#else>
				$('input[name="brandStatusCd"][value="0"]').attr("checked",true);
			</#if>
		});
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