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
        <li><a href="../article">文章管理</a> <span class="divider">&gt;&gt;</span></li>
        <!--  <li><a href="../article">文章列表</a> <span class="divider">&gt;&gt;</span></li> -->
        <li class="active"><#if article?has_content && article.articleId?has_content>编辑文章<#else>新建文章</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="save" method="post">
        <input type="hidden" name="articleId" value="${(article.articleId)!}"/>
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>标题：</label>
                    <div class="controls">
                        <input value="${(article.articleTitle)!?html}" name="articleTitle" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>类型：</label>
                    <div class="controls">
                        <select name="articleType" id="articleType" data-rules="{required:true}" >
						<#if articleTypeList?has_content>
							<#assign currentId = (article.articleType)?default(-1)/>
							<#list articleTypeList as articleType>
                                <option <#if articleType.typeId==currentId>selected="selected"</#if> value="${articleType.typeId!}">${articleType.typeName!?html}</option>
							</#list>
						</#if>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>作者：</label>
                    <div class="controls">
                        <input value="${(article.articleAuthor)!?html}" name="articleAuthor" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>发布：</label>
                    <div class="controls">
					<#assign radioValue="1"/>
					<#if article?has_content &&  article.articleIsPublication?has_content && !(article.articleIsPublication)>
						<#assign radioValue="0"/>
					</#if>
                        <label class="radio">
                            <input type="radio"  name="articleIsPublication" value="1" <#if radioValue=="1">checked="checked" </#if>/>是
                        </label>&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="articleIsPublication" value="0" <#if  radioValue=="0">checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>
            <div id="editorContent" class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>内容：</label>
                    <div class="controls control-row-auto">
                    	<input type="hidden" id="editors" name="articleContent" value='${(article.articleContent)!}'/>
                        <script type="text/plain" id="editor" name="articleContents" >${(article.articleContent)!}</script>
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
                        href:'/admin/sa/decorate/article',
                        isClose: true,
                        reload: true
                    })
                }
            }
        });

		 form.on('beforesubmit', function(){
		 		var editor=  UE.getEditor('editor').getContent();
		 		$('#editors').val(editor);
	            if(editor == '') {
	            	app.showError('文章内容不能为空!');
                    return false;
	            }
            
            
           

            return true;
        })
        form.render();
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: 1000, initialFrameHeight: 300});
        window.msg_editor.render("editor");
		
		$('button[type="reset"]').click(function(){
        	window.msg_editor.setContent('${(article.articleContent)!?js_string}');
        });
       
    });

   
   
</script>
</body>
</html>