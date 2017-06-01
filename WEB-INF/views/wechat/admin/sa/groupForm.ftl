<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>

	<#assign ctx = request.contextPath>
	<#assign staticPath = ctx + "/static">
    <link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

</head>
<body>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/wechat/groupForm" method="post">
		<input type="hidden" name="groupId" value="${(group.groupId)!}">
        <div id="groupForm" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>分组名称：</label>
                    <div class="controls">
                        <input value="${(group.groupName)!}" name="name" id="name" type="text" data-rules="{required:true}"
                               class="input-normal control-text">
						<!-- &nbsp;&nbsp;&nbsp; -->
                        <button type="submit" class="button button-primary" style="display:none;">保存 </button> 
                    </div>
                </div>
            </div>
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
                    app.page.open({
                        href:'${ctx}/admin/sa/wechat/userList',
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