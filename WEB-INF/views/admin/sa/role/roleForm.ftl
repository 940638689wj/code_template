<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>

    <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css?v=" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js?v=" type="text/javascript"></script>
    <script src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.excheck-3.5.min.js?v=" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/role/list">岗位列表</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if role?has_content && role.roleId?has_content>编辑岗位<#else>添加岗位</#if></li>
    </ul>


    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/role/roleForm" method="post">
        <input type="hidden" name="roleId" value="${(role.roleId)!}"/>

        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>岗位名称：</label>
                    <div class="controls">
                        <input  value="${(role.roleDesc)!?html}" name="roleDesc" id="roleDesc" type="text" data-rules="{required:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>是否启用：</label>

                    <div class="controls">
                    <#assign radioValue="100"/>
                    <#if role?has_content && (role.roleStatusCd)?has_content && role.roleStatusCd == 101>
                        <#assign radioValue="101"/>
                    </#if>

                        <label class="radio">
                            <input type="radio" name="roleStatus" value="101"
                                   <#if radioValue=="101">checked="checked" </#if>/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="roleStatus" value="100"
                                   <#if radioValue=="100">checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">岗位授权:</label>

                    <div class="controls control-row-auto">
                        <div id="resourceTree" class="ztree" style="margin-top:3px;float:left;"></div>
                        <input type="hidden" id="selectedIds" name="selectedIds" value="${selectedIds!}"/>
                    </div>
                </div>
            </div>
        </div>

        <#--<@securityAuthorize ifAnyGranted="PERMISSION_MAIN_PREFERENTIAL_CONFIGURATION_EDIT">-->
            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        <#--</@securityAuthorize>-->

    </form>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
            	 if(data.result == "success"){
                    app.showSuccess("保存成功！");
                    window.location.href = "${ctx}/admin/sa/role/list";
                }else{
                    BUI.Message.Alert(data.message);
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
            <#if allResourceList??>
                <#list allResourceList as resource>
                    {
                        id: '${resource.resourceId}',
                        pId: '<#if (resource.parentResId)??>${resource.parentResId}<#else>0</#if>',
                        name: '${resource.resourceName}'
                    },
                </#list>
            </#if>
        ];
        // 初始化树结构
        var tree = $.fn.zTree.init($("#resourceTree"), setting, zNodes);
        // 默认选择节点
        <#if selectIdList??>
            <#list selectIdList as selectId>
                var node = tree.getNodeByParam("id", ${selectId!});
                try {
                    tree.checkNode(node, true, false);
                } catch (e) {
                }
            </#list>
        </#if>
        // 默认展开全部节点
        tree.expandAll(true);
        
         // 重置后选择启用并清空树
        $("button[type='reset']").click(function(){
        	$("input[name='roleStatus']:first").attr("checked",true);
        	tree.checkAllNodes(false);
        });
    })
</script>
 </body>
 </html>