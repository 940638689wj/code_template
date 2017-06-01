<#assign ctx = request.contextPath>
<#assign platformTypes = ''>
<#assign expressTypes=[]/>
<!DOCTYPE HTML>
<html>
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
	<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="../articleType">文章分类</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if articleType?has_content && articleType.articleTypeId?has_content>编辑分类<#else>新加分类	</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="<#if articleType?has_content && articleType.articleTypeId?has_content>update<#else>insert</#if>" method="post">
        <input type="hidden" name="articleTypeId" value="${(articleType.articleTypeId)!?html}"/>
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input value="${(articleType.typeName)!?html}" name="typeName" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>排序：</label>
                    <div class="controls">
                        <input value="${(articleType.displayID)!?html}" name="displayID" data-rules="{required:true,number:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>显示在首页：</label>
                    <div class="controls">
					<#assign radioValue="1"/>
					<#if articleType?has_content &&  articleType.isDisplayInHome?has_content && articleType.isDisplayInHome==0>
						<#assign radioValue="0"/>
					</#if>
                        <label class="radio">
                            <input type="radio"  name="isDisplayInHome" value="1" <#if radioValue=="1">checked="checked" </#if>/>是
                        </label>&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="isDisplayInHome" value="0" <#if  radioValue=="0">checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>文章模型：</label>
                    <div class="controls">
                        <select name="articleModelTypeCd" id="articleModelTypeCd" data-rules="{required:true}" >
						<#if articleModelTypeList?has_content>
							<#assign currentId = 1/>
							<#list articleModelTypeList as articleModelTypeDTO>
                                <option <#if articleModelTypeDTO.articleModelTypeCd==1>selected="selected"</#if> value="${articleModelTypeDTO.articleModelTypeCd!}">${articleModelTypeDTO.articleModelTypeName!?html}</option>
							</#list>
						</#if>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>分类描述：</label>
                    <div class="controls">
                    	<textarea name="typeDesc" class="input-large bui-form-field" data-tip="{text:''}" data-rules="{required:true}" type="text" aria-disabled="false" aria-pressed="false">${(articleType.typeDesc)!?html}</textarea>
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
    $(function(){
        var Form = BUI.Form

       
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    app.page.open({
                        href:'/admin/sa/decorate/articleType',
                        isClose: true,
                        reload: true
                    })
                }
            }
        });
        
        form.render();
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: 1000, initialFrameHeight: 300});
        window.msg_editor.render("editor");

       
    });
   
</script>
</body>
</html>