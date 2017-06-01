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
                 <li aria-disabled="false" aria-pressed="false"><a href="${ctx}/admin/sa/category/list">系列分类管理</a><span class="divider">&gt;&gt;</span></li>
                 <li class="active"><#if productCategory?? && productCategory?has_content>编辑分类<#else>新增分类</#if></li>  
            </ul>
        </div>
    </div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/category/save" method="post">
    	<input type="hidden" name="categoryId" value="<#if (productCategory.categoryId)?has_content>${productCategory.categoryId}</#if>">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>系列编码：</label>
                    <div class="controls">
                        <input value="${(productCategory.categoryNum)!?html}" name="categoryNum" data-rules="{required:true,regexp:/^([A-Za-z]|[0-9]){1,20}$/}" data-messages="{regexp:'请输入正确的编码！'}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>系列名称：</label>
                    <div class="controls">
                        <input value="${(productCategory.categoryName)!?html}" name="categoryName" data-rules="{required:true,regexp:/^([\u4e00-\u9fa5]|[A-Za-z]|[0-9]){1,20}$/}" data-messages="{regexp:'请输入正确的名称！'}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>系列类型：</label>
                    <div class="controls">             
                    	  <select id="categoryTypeId" name="categoryTypeId">
                    	  	  <#if categoryTypeList?? &&categoryTypeList?has_content>
                    	  	  		<#list categoryTypeList as categoryType>
                    	  	  			<option value="${categoryType.categoryTypeId}"
                    	  	  			<#if productCategory?? && productCategory?has_content>
                    	  	  				<#if productCategory.categoryTypeId == categoryType.categoryTypeId>
                    	  	  					selected
                    	  	  				</#if>
                    	  	  			</#if>
                    	  	  			>${categoryType.categoryTypeName}</option>
                    	  	  		</#list>
                    	  	  </#if>    	  	  					      
						  </select>
                    </div>
                </div>
            </div>
			<div class="row">
                <div class="control-group">
                    <label class="control-label">系列图片：</label>
                     <div class="controls">	
						<input id="file_cardBackImage" name="file" type="file" onchange="javascript:assetChange(this.value,'cardBackImage');">
					</div>
                </div>
            </div>
            <div class="row" style="height:100">
                <div class="control-group">  
                 	<label class="control-label">图像预览</label>
                  	<div class="controls control-row-auto" >                             						                     							
						<input type="hidden" id="categoryImgUrl" name="categoryImgUrl" value="<#if (productCategory.categoryImgUrl)?has_content>${productCategory.categoryImgUrl}</#if>" class="input-normal control-text" >   
						<img id="imageView_cardBackImage" width="100px" height="100px" src="<#if (productCategory.categoryImgUrl)?has_content>${productCategory.categoryImgUrl}</#if>" >          
                		(图片：建议90*90像素的JPG、PNG)
                		<input type="button" onclick="delItem();" value=删除图片></input>
                	</div>
               	</div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <#assign categoryStatusCd=0/>
	                <#if productCategory?? && productCategory?has_content && productCategory.categoryStatusCd == 1>
	                     <#assign categoryStatusCd=1/>
	                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="categoryStatusCd" value="1" <#if categoryStatusCd==1>checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="categoryStatusCd" value="0" <#if categoryStatusCd==0>checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
            <#if productCategory?? && productCategory?has_content>
	            <div class="row">
	                <div class="control-group">
	                    <label class="control-label">网址：</label>
	                    <div class="controls">
	                        /m/category/<#if (productCategory.categoryId)?has_content>${productCategory.categoryId}</#if>.html
	                    </div>
	                </div>
	            </div>
			</#if>
            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
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
                    window.location.href="${ctx}/admin/sa/category/list";
                }
            }
        }).render();
        
        //点击重置的时候也把图片给重置掉
		$('button[type="reset"]').click(function() {
			$('#categoryImgUrl').val('${(productCategory.categoryImgUrl)!}');
			$('#imageView_cardBackImage').attr("src","${(productCategory.categoryImgUrl)!}");
			<#if productCategory?? && productCategory?has_content && productCategory.categoryStatusCd == 1>
				$('input[name="categoryStatusCd"][value="1"]').attr("checked",true);
			<#else>
				$('input[name="categoryStatusCd"][value="0"]').attr("checked",true);
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
            url:'${ctx}/common/staticAsset/upload/category',
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
        $('#categoryImgUrl').val(assetUrl);
        $("#imageView_"+lastFlag).attr("src", assetUrl);
        $("#imgPath_"+lastFlag).val(assetUrl);
        $("#imgArea_"+lastFlag).show();
    }
    //删除图片
    function delItem(){
    	$('#categoryImgUrl').val(' ');
    	$('#imageView_cardBackImage').attr('src',"");
    }
    //长度校验
    function lengthCat(e){
      var categoryNum1 = $(e).val();
      var reg = /^\+?[1-9]{1,8}\d*$/;
      
    }  
</script>
</body>
</html>