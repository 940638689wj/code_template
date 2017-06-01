<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
 	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

    <link rel="stylesheet" href="${staticPath}/admin/css/emotion.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/weixin/emotion.js"></script>

</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="/admin/sa/wechat/keywordList">关键词回复</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if eventCondition?has_content && eventCondition.id?has_content>编辑关键词<#else>添加关键词</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="keywordForm" method="post">
        <input type="hidden" name="id" value="${(eventCondition.id)!}"/>
        <div id="keywordForm" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>规则名称：</label>
                    <div class="controls">
                        <input value="${(eventCondition.name)!?html}" name="name" id="name" type="text" data-rules="{required:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>关键词：</label>
                    <div class="controls">
                        <input value="${(eventCondition.keyword)!?html}" name="keyword" id="keyword" type="text" data-rules="{required:true}"
                               class="input-large control-text">
                    </div>
                    <div class="tips tips-small tips-info tips-no-icon pull-left">
                        <div class="tips-content">亲,多个关键词可以使用英文逗号“,”分隔，拒绝中文逗号“，”喔!</div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">匹配规则：</label>
                    <div class="controls">
                        <select class="span4" name="matchType" id="matchType">
                            <option value="fuzzy" <#if (eventCondition.matchType)?? && eventCondition.matchType == "fuzzy">selected</#if>>模糊匹配</option>
                            <option value="all" <#if (eventCondition.matchType)?? && eventCondition.matchType == "all">selected</#if>>全匹配</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">回复全部：</label>
                    <div class="controls">
                        <input type="checkbox" name="isReplyAll" <#if isReplyAll?? && isReplyAll>checked="" </#if>>
                    </div>
                    <div class="tips tips-small tips-info tips-no-icon pull-left">
                        <div class="tips-content">&nbsp;&nbsp;&nbsp;适用于有多条回复的内容,未勾选系统将随机选择一条消息进行回复!</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-bar">
            <div class="form-actions">
				<button type="submit" class="button button-primary">保存</button>
				<button type="reset" class="button">重置</button>
			</div>
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
                        href:'/admin/sa/wechat/keywordList',
                        isClose: true,
                        reload: true
                    })
                }
            }
        }).render();
    });
</script>


</body>
</html>