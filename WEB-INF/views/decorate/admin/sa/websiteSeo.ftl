<#assign ctx = request.contextPath>
<#assign platformTypes = ''>
<#assign expressTypes=[]/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li class="active">SEO设置</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/decorate/websiteSeo/saveWebsiteSeo" method="post">
        <input type="hidden" name="id" value="${(seo.id)!}"/>
    <div id="edit-div" class="form-content">
        <div class="row">
            <div class="control-group">
                <label class="control-label">title：</label>
                <div class="controls control-row4">
                    <textarea class="input-large"  rows="10" cols="250" value="${(seoTitle.configValue)!?html}" name="title" ></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label">keywords：</label>
                <div class="controls control-row4">
                    <textarea class="input-large"  rows="10" cols="250" value="${(seoKeywords.configValue)!?html}" name="keywords" ></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label">description：</label>
                <div class="controls control-row4">
                    <textarea class="input-large"  rows="10" cols="250" value="${(seoDescription.configValue)!?html}" name="description" ></textarea>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label">其它：</label>
                <div class="controls control-row4 control-row-auto">
                    <textarea class="input-large"  rows="10" cols="250" style="height: 100px;" value="${(seoOthers.configValue)!?html}" name="others" data-rules="{maxlength:500}" ></textarea>
                </div>
            </div>
        </div>
    </div>
        <div class="actions-bar">
            <button id="save" type="submit" class="button button-primary">保存</button>
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
                if (data = 'success') {
                    app.showSuccess("保存成功！");
                }
				setTimeout("remainTime()",1000);
            }
        }).render();
        
	    form.on('beforesubmit', function(){
	    	btn=document.getElementById('save');
			btn.disabled=true;
	    });
		
    });
    
    function remainTime(){
        	btn=document.getElementById('save');
			btn.disabled=false;
    }
</script>
 </body>
 </html>