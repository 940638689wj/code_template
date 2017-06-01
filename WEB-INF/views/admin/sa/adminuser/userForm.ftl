<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
    <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css?v=" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js?v=" type="text/javascript"></script>
    <script src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js?v=" type="text/javascript"></script>
</head>
<body>
<div class="container">
<#assign isNew = true>
<#if adminUser?has_content && adminUser.adminUserId?has_content>
    <#assign isNew = false>
</#if>

    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/adminUser/list">后台管理员</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew>新建管理员<#else>编辑管理员</#if></li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/adminUser/save" method="post">
        <div id="edit-div" class="form-content">
            <input type="hidden" name="adminUserId" value="${(adminUser.adminUserId)!}"/>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>账号：</label>

                    <div class="controls">
                    <#if isNew>
                        <input value="${(adminUser.userName)!}" type="text" id="userName" name="userName"
                               data-rules="{required:true,maxlength:50}" class="input-normal control-text">
                    <#else>
                    ${adminUser.userName!?html}
                    </#if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>姓名：</label>

                    <div class="controls">
                        <input value="${(adminUser.realName)!?html}" name="realName" data-rules="{required:true,maxlength:30}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>是否启用：</label>

                    <div class="controls">
                        <#assign radioValue="100"/>
                        <#if adminUser?has_content && (adminUser.adminUserStatusCd)?has_content && adminUser.adminUserStatusCd == 101>
                            <#assign radioValue="101"/>
                        </#if>

                        <label class="radio">
                            <input type="radio" name="userStatusCd" value="101"
                                   <#if radioValue=="101">checked="checked" </#if>/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="userStatusCd" value="100"
                                   <#if radioValue=="100">checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>登录密码</label>

                    <div class="controls">
                        <input name="strPassword" id="strPassword" type="password"
                               <#if isNew>data-rules="{required:true,minlength:6,maxlength:50}"</#if>
                               class="input-normal control-text">
                    <#if !isNew><span style="color: red">&nbsp;不修改密码请放空</span></#if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>确认密码</label>

                    <div class="controls">
                        <input name="currentPasswordVerify" type="password"
                               <#if isNew>data-rules="{required:true,equalTo:'#strPassword'}"</#if> class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">分配角色:</label>

                    <div class="controls control-row-auto">
                        <div id="zTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <input type="hidden" id="selectedIds" name="selectedIds" value="${selectedIds!}"/>
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

<script type="text/javascript">
    $(function () {
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    window.location.href = "${ctx}/admin/sa/adminUser/list";
                }
            }
        }).render();

        form.on('beforesubmit', function () {
            var ids = [], nodes = tree.getCheckedNodes(true);
            for (var i = 0; i < nodes.length; i++) {
                ids.push(nodes[i].id);
            }
            $("#selectedIds").val(ids);
            return true;
        });

        var setting = {
            check: {enable: true, nocheckInherit: true}, view: {selectedMulti: false},
            data: {simpleData: {enable: true}}, callback: {
                beforeClick: function (id, node) {
                    tree.checkNode(node, !node.checked, true, true);
                    return false;
                }
            }
        };

        var zNodes = [
            <#if allRoleList??>
                <#list allRoleList as role>
                    {
                        id: '${role.roleId}',
                        pId: '0',
                        name: '${role.roleDesc}'
                    },
                </#list>
            </#if>
        ];
        // 初始化树结构
        var tree = $.fn.zTree.init($("#zTree"), setting, zNodes);
        // 默认选择节点
        <#if selectIdList??>
            <#list selectIdList as selectId>
                var node = tree.getNodeByParam("id", ${selectId});
                try {
                    tree.checkNode(node, true, false);
                } catch (e) {
                }
            </#list>
        </#if>
        // 默认展开全部节点
        tree.expandAll(true);
        
        // 重置后选择启用
        $("button[type='reset']").click(function(){
        	$("input[name='userStatusCd']:first").attr("checked",true);
        });
    });
</script>
</body>
</html>