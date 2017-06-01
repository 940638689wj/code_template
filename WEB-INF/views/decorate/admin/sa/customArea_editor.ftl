<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<#include "${ctx}/includes/sa/header.ftl"/>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/decorate/customArea/turnToPage" style="font-weight:bold">自定义页面</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if customAreaInfo?? && customAreaInfo?has_content && customAreaInfo.id?has_content>编辑<#else>新建</#if></li>
    </ul>
    <form id="J_Form" name="J_Form" class="form-horizontal" action="${ctx}/admin/sa/decorate/customArea/<#if customAreaInfo?? && customAreaInfo?has_content && customAreaInfo.id?has_content>saveCustomArea<#else>addCustomArea</#if>" method="post">
     <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">自定义页面ID：</label>
                    <div class="controls">
                        <label>${(customAreaInfo.id)!'（由系统自动生成）'}</label>
                        <input type="hidden" name="id" value="${(customAreaInfo.id)!} "/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">访问页面地址：</label>
                    <div class="controls">
                        <label><#if customAreaInfo?? && customAreaInfo?has_content && customAreaInfo.id?has_content>/m/view/${(customAreaInfo.id)}.html<#else>（由系统自动生成）</#if></label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>自定义标题：</label>
                    <div class="controls">
                        <input value="${(customAreaInfo.title)!}" id="title" name="title" type="text" data-rules="{required:true,maxlength:255}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>页面头底部：</label>
                    <div class="controls" data-rules="{required:true}">
                        <input type="radio" name="headerFooter" value="1" checked="checked" /> 包含
                        <input type="radio" name="headerFooter" value="0" <#if customAreaInfo??&&customAreaInfo?has_content &&customAreaInfo.headerFooter=0>checked="checked"</#if> /> 不包含
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>自定义HTML：</label>
                    <div class="controls control-row-auto">
                    	<input type="hidden" id="editors" name="content" value='${(customAreaInfo.content)!}'/>
                        <script type="text/plain" id="editor" name="contents">${(customAreaInfo.content)?default("<p></p>")}</script>
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
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: 1000, initialFrameHeight: 200});
        window.msg_editor.render("editor");

        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                	location.href='${ctx}/admin/sa/decorate/customArea/turnToPage';
                    app.showSuccess("保存成功！");
                }
            }
        }).render();
        form.on('beforesubmit', function(){
        	var title = $('#title').val();
			var content = window.msg_editor.getContent();
	        $('#editors').val(content);
			
			console.log(content);
        	if(title == ""){
				BUI.Message.Alert("请填写标题!");
				return false;
			}
			
			if(title.length > 100){
				BUI.Message.Alert("超过标题长度，请正确填写标题!");
				return false;
			}
			
			if(content == ""){
				BUI.Message.Alert("请输入内容");
				return false;
			}
			
		});
        
        $('button[type="reset"]').click(function(){
        	<#if customAreaInfo??&&customAreaInfo?has_content &&customAreaInfo.headerFooter=1>
        		$('input[name="headerFooter"][value="1"]').attr('checked',true);
        	<#else>
        		$('input[name="headerFooter"][value="0"]').attr('checked',true);
			</#if>
        	window.msg_editor.setContent('${(customAreaInfo.content)!?js_string}');
        });
    })
</script>
<style>
    #edui70_content,#edui57_content{min-height:200px;}
</style>
</body>
</html>