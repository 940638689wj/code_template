<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>

<!DOCTYPE HTML>
<html>
<head>
    <title></title>
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
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">微信用户管理</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="content-body">
        <div class="wx-user-manage">
            <div class="wx-user-manage-side">
                <div class="tree-tit">
                    <a href="javascript:void(0);" onclick="locateGroup('-1');">全部用户<span class="count">(${(userCount)?default('0')})</span></a>

                </div>
                <ul class="tree-list">
                    <#if groups??>
                        <#list groups as group>
                            <#if group.groupId != 0>
                                <li>
                                     <#if group.groupTypeCd != "0">
                                        <div class="tree-edit">
                                           <#-- <@security.authorize ifAnyGranted="PERMISSION_MAIN_WX_USER_MANAGE_EDIT">-->
                                            <a class="wxicon edit-gray" href="javascript:void(0);" onclick="openEditGroupDialog('${group.groupId}');">编辑</a>
                                           <#-- </@security.authorize>-->
                                            <a class="wxicon del-gray" href="javascript:void(0);" onclick="deleteGroup('${group.groupId}');">删除</a>
                                        </div>
                                     </#if>
                                    <a href="javascript:void(0);" onclick="locateGroup('${group.groupId}');">${group.groupName}<span class="count">(${group.wxUserCount?default('0')})</span></a>
                                </li>
                            </#if>
                        </#list>
                    </#if>
                </ul>
                <div class="tree-ft">
                    <#--<@security.authorize ifAnyGranted="PERMISSION_MAIN_WX_USER_MANAGE_EDIT">-->
                        <a href="javascript:void(0);" onclick="openAddGroupDialog();"><i class="icon-plus"></i>新建分组</a>
                    <#--</@security.authorize>-->
                </div>
                <#if blackList?? && blackList?has_content>
                <div class="tree-tit">
    				<a href="javascript:void(0);" onclick="locateGroup('${blackList.groupId}');">${(blackList.groupName)}<span class="count">(${blackList.wxUserCount?default('0')})</span></a>
				</div>
				</#if>
</div>
<div class="wx-user-manage-main">
<div class="toolbar">
<#--	<@security.authorize ifAnyGranted="PERMISSION_MAIN_WX_USER_MANAGE_EDIT">-->
    <button id="btn" class="button button-primary">添加到<span class="x-caret x-caret-down"></span></button>
<#--</@security.authorize>-->
</div>
<form id="searchForm" method="post">
<input type="hidden" name="groupId" id="groupId" value="${groupId!}">
</form>
<div id="grid"></div>
</div>
</div>
</div>

<div id="modifyNickNameContent" class="well" style="display: none;">
<input type="hidden" name="userId" id="userId" value=""/>
<label>新昵称：</label>
<input value="" name="nickName" id="nickName" type="text" data-rules="{required:true}"
class="input-normal control-text">
</div>
</div>
<script type="text/javascript">
var grid;
var search;

BUI.use(['common/search','common/page'],function (Search) {
    var columns = [
        {
            title: '头像', dataIndex: 'headImgUrl', width: 100, renderer: function (value, rowObj) {
            if (value) {
                return '<img src="' + value + '" style="width:80px;height: 80px;" />';
            } else {
                return '<img src="${staticPath}/admin/images/defaultHeadImg.jpg" />';
            }
        }
        },
        {title: '昵称', dataIndex: 'nickName', width: 150},
        {title: '分组', dataIndex: 'groupName', width: 120},
    <#--{title : '归属门店',dataIndex : 'storeName', width:150},-->
        {
            title: '操作', dataIndex: 'id', width: 300, renderer: function (value, rowObj) {
            var remarkStr;
        <#--<@security.authorize ifAnyGranted="PERMISSION_MAIN_WX_USER_MANAGE_EDIT_NAME">-->
            remarkStr = '<button class="button" onclick="modifyNickName(' + value + ');">修改昵称</button>';


            remarkStr = remarkStr + '&nbsp;<button class="button" onclick="viewUserDetail(' + value + ');">查看详细信息</button>';

            return remarkStr;
        }
        }
    ];

var store = Search.createStore('${ctx}/admin/sa/wechat/grid_json',{pageSize:15});

var gridCfg = Search.createGridCfg(columns,
{   width: '100%',
height: getContentHeight(),
plugins : [BUI.Grid.Plugins.CheckSelection]// 插件形式引入多选表格
});

search = new Search({
gridId:'grid',
formId:'searchForm',
store : store,
gridCfg : gridCfg
});
grid = search.get('grid');
});

var Menu = BUI.Menu;
var dropMenu1 = new Menu.PopMenu({
trigger : '#btn',
autoRender : true,
width : 140,
children : [
<#if groups??>
<#list groups as group>
{id:"${group.groupId}",content : "${group.groupName}"},
</#list>
</#if>
]
});
dropMenu1.on('itemselected',function(){
//group id: dropMenu1.getSelectedValue() 标示控件的唯一编号，默认会自动生成
//dropMenu1.getSelectedText()
var selectedUser = grid.getSelection();
if(selectedUser.length <= 0){
BUI.Message.Alert("请选择需要移动分组的用户!");
return false;
}

var selectedUserIds = [];
for(var i = 0; i < selectedUser.length ; i++){
selectedUserIds.push(selectedUser[i].id);
}

var userIds=selectedUserIds.join(',');
var groupId=dropMenu1.getSelectedValue();
var url='${ctx}/admin/sa/wechat/removeUserGroup';
var data={userIds:userIds,groupId:groupId};

app.ajax(url,data,function(data){
if(data.result=="true"){
app.showSuccess("操作成功!");
app.page.open({
href:'${ctx}/admin/sa/wechat/userList'
});
}else{
app.showError(data.error);
}
});
});

//修改备注
var dialog;
var Overlay = BUI.Overlay
dialog = new Overlay.Dialog({
title:'修改昵称',
width:350,
height:100,
//配置DOM容器的编号
contentId:'modifyNickNameContent',
success:function () {
var dialogObj = this;

var userId=$("#userId").val();
var nickName=$("#nickName").val();
$.ajax({
url : '${ctx}/admin/sa/wechat/modifyNickName',
dataType : 'json',
type: 'POST',
data : {userId : userId,nickName:nickName},
success : function(data){
if(data.result == "true"){
    dialogObj.close();
    app.showSuccess("修改成功!");
    app.page.open({
        href:'${ctx}/admin/sa/wechat/userList'
    });
}else{
    BUI.Message.Alert('修改昵称失败!');
}
}
});
}
});

function modifyNickName(value){
$("#userId").val(value);
$("#nickName").val("");
dialog.show();
}

//查看用户详细信息
function viewUserDetail(value){
app.page.open({
href:'${ctx}/admin/sa/wechat/userDetail?userId='+value
});
}

//定位到分组
function locateGroup(value){
app.page.open({
href:'${ctx}/admin/sa/wechat/userList?groupId='+value
});
}

//新增分组-弹出框口
var addGroupDialog = new Overlay.Dialog({
title:'添加分组',
contentId:'addGroup',
width:450,
height:150,
loader : {
url : '${ctx}/admin/sa/wechat/groupForm',
autoLoad : false, //不自动加载
params : {a : 'a'},//附加的参数
lazyLoad : false //不延迟加载
},
mask:true,
buttons:[{ text:'确定', elCls : 'button', handler : function(){ 
	$("button[type='submit']").trigger("click");
 } }, { text:'取消', elCls : 'button', handler : function(){ this.close(); } } ]

});

function openAddGroupDialog(){
addGroupDialog.show();
addGroupDialog.get('loader').load({a : 'param'});
}

//修改分组-弹出框口
var editGroupDialog = new Overlay.Dialog({
title:'修改分组',
contentId:'editGroup',
width:450,
height:150,
loader : {
url : '${ctx}/admin/sa/wechat/groupForm',
autoLoad : false, //不自动加载
params : {groupId : 'a'},//附加的参数
lazyLoad : false //不延迟加载
},
mask:true,
buttons:[{ text:'确定', elCls : 'button', handler : function(){ 
	$("button[type='submit']").trigger("click");
 } }, { text:'取消', elCls : 'button', handler : function(){ this.close(); } } ]
});

function openEditGroupDialog(value){
editGroupDialog.show();
editGroupDialog.get('loader').load({groupId : value});
}

//删除
function deleteGroup(groupId){
BUI.Message.Confirm('确认要删除分组吗？',function(){
$.ajax({
url: "${ctx}/admin/sa/wechat/groupDelete?groupId="+groupId,
type:"get",
dataType: "text",
success: function(data){
if(data=="success"){
    app.showSuccess("删除成功!");
    app.page.open({
        href:'${ctx}/admin/sa/wechat/userList'
    });
}else{
    app.showError("删除失败！");

}
}
});
},'question');
}
</script>
<body>
</html>  