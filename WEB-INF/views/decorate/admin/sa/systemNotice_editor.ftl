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
        <li><a href="${ctx}/admin/sa/decorate/systemNotice/turnToPage" style="font-weight:bold">通知管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if NoticeInfo?? && NoticeInfo?has_content && NoticeInfo.id?has_content>编辑通知<#else>新加通知</#if></li>
    </ul>
    <form id="J_Form" name="J_Form" class="form-horizontal" action="${ctx}/admin/sa/decorate/systemNotice/<#if NoticeInfo?? && NoticeInfo?has_content && NoticeInfo.id?has_content>saveSystemNotice<#else>addSystemNotice</#if>" method="post">
     <div class="form-content">
            <div class="row">
            	<input type="hidden" name="id" value="${(NoticeInfo.id)!} "/>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>标题：</label>
                    <div class="controls">
                        <input value="${(NoticeInfo.title)!}" id="title" name="title" type="text"  class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>是否重要客户：</label>
                    <div class="controls">
                        <input type="radio" name="isImportant" value="1" checked="checked" /> 是
                        <input type="radio" name="isImportant" value="0" <#if NoticeInfo?? && NoticeInfo?has_content &&NoticeInfo.isImportant==0>checked="checked"</#if> /> 否
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>接收用户：</label>
                    <div class="controls">
                        <input type="checkbox" name="receivedCd" value="1" <#if NoticeInfo?? && NoticeInfo?has_content &&NoticeInfo.receivedCd?contains("1")>checked="checked"</#if> /> 顾客
                        <input type="checkbox" name="receivedCd" value="2" <#if NoticeInfo?? && NoticeInfo?has_content &&NoticeInfo.receivedCd?contains("2")>checked="checked"</#if> /> 门店
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">链接：</label>
                    <div class="controls">
                        <label><#if NoticeInfo?? && NoticeInfo?has_content && NoticeInfo.id?has_content>/m/notice/${(NoticeInfo.id)}.html<#else>（由系统自动生成）</#if></label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>内容：</label>
                    <div class="controls control-row-auto">
                    	<input type="hidden" id="editors" name="content" value='${(NoticeInfo.content)!}'/>
                        <script type="text/plain" id="editor" name="contents">${(NoticeInfo.content)?default("<p></p>")}</script>
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
                    app.showSuccess("保存成功！");
                	window.location.href='${ctx}/admin/sa/decorate/systemNotice/turnToPage';
                }
            }
        }).render();
        
        form.on('beforesubmit', function(){
        	var title = $('#title').val();
        	var receivedCd = $("input[name='receivedCd']:checked");
			var content = window.msg_editor.getContent();
			$('#editors').val(content);
			
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
			
			if(receivedCd.length < 1){
				BUI.Message.Alert("请选择接收用户");
				return false;
			}
		});
		
		$('button[type="reset"]').click(function(){
			<#if NoticeInfo?? && NoticeInfo?has_content && NoticeInfo.isImportant ==1>
        		$('input[name="isImportant"][value="1"]').attr('checked',true);
        	<#else>
        		$('input[name="isImportant"][value="0"]').attr('checked',true);
        	</#if>
        	window.msg_editor.setContent('${(NoticeInfo.content)?default("<p></p>")}');
        });
		
    })

</script>
<style>
    #edui70_content,#edui57_content{min-height:200px;}
</style>
</body>
</html>