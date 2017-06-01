<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-bar">
            <div id="tab"></div>
        </div>
        <div class="content-top">
            <div id="tab1"></div>
            <div class="title-bar-side">
                <div class="search-bar">
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal span24">
                        <input name="sort" value="id desc" type="hidden"/>
                        <input type="hidden" name="eq_visible" value="0">
                    </form>
                </div>
            </div>
        </div>
        <div class="content-body">
            <div id="grid">

            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
var Tab = BUI.Tab;
var search;
var grid;
var tab = new Tab.Tab({
    render : '#tab',
    elCls : 'nav-tabs',
    autoRender: true,
    children:[
        {text:'后台管理员',value:'0'}
    ]
});
tab.setSelected(tab.getItemAt(0));

BUI.use(['common/search','common/page'],function (Search) {
    var columns = [
        {title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
            var editStr="";
                    editStr += '&nbsp;<a href=\'javascript:editAdminUser(\"' + rowObj.adminUserId + '\")\'>编辑</a>';
              //  editStr += '&nbsp;<a href=\'javascript:copyAdminUser(\"' + rowObj.adminUserId + '\")\'>复制</a>';
<@securityAuthorize ifAnyGranted="delete">
                     editStr += '&nbsp;<a href=\'javascript:delAdminUser(\"' + rowObj.adminUserId + '\")\'>删除</a>';
</@securityAuthorize>
            return editStr;
        }},
        {title:'帐号',dataIndex:'userName',width:100, renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }},
        {title:'姓名',dataIndex:'realName',width:100, renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }},
        {title:'角色',dataIndex:'roles',width:250, renderer : function(value, rowObj){
            return (value);
        }},
        {title:'状态',dataIndex:'adminUserStatusCd',width:80,renderer : function(value, rowObj){
            var adminUserStatusCd = "禁用";
            if(value && value == 101){
                adminUserStatusCd = "启用";
            }
            return adminUserStatusCd;
        }},
        {title:'创建时间',dataIndex:'createTime',width:160, renderer:BUI.Grid.Format.datetimeRenderer},
        {title:'最后登录时间',dataIndex:'lastLoginTime',width:160,renderer:BUI.Grid.Format.datetimeRenderer},
        {title:'最后登录ip',dataIndex:'lastLoginIp',width:160,renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }}
    ];
    var store = Search.createStore('grid_json');
    var gridCfg = Search.createGridCfg(columns,{
    	plugins : [BUI.Grid.Plugins.ColumnResize],
        stripeRows : false,
        width: '100%',
        height: getContentHeight(),
        render:'#grid',
        columns : columns
        , tbar : {
            items : [
                {text : '添加管理员',btnCls : 'button button-small button-primary',handler:addFunction}
            ]
        }
    });

    search = new Search({
        store : store,
        gridCfg : gridCfg
    });
    grid = search.get('grid');


    del=function(value){
        BUI.Message.Confirm('确认要删除该条目吗？',function(){
            $.ajax({
                url: "${ctx}/admin/sa/adminUser/deleteAdminUser",
                type:"post",
                dataType: "json",
                data:{adminUserId:value},
                success: function(data){
                    if(data.result=="success"){
                        app.showSuccess("删除成功！");
                        search.load();
                    }else{
                        app.showError("无法删除!");
                    }
                }
            });
        },'question');
    }

    grid.render();

    function addFunction(){
        window.location.href = "${ctx}/admin/sa/adminUser/adminUserForm/0";
    }

    var Form = BUI.Form
    var form = new Form.Form({
        srcNode: '#JForm',
        submitType: 'ajax',
        callback: function (data) {
            if (app.ajaxHelper.handleAjaxMsg(data)) {
                app.showSuccess("保存成功！")
            }
        }
    });

    form.on('beforesubmit', function(){
        var userId=$('#userId').val();
        if(userId==""){
            alert("请选择用户");
            return false;
        }
    });
    form.render();
});


function delAdminUser(value){
    BUI.Message.Confirm('确认要删除该条目吗？',function(){
        $.ajax({
            url: "${ctx}/admin/sa/adminUser/deleteAdminUser",
            type:"post",
            dataType: "json",
            data:{adminUserId:value},
            success: function(data){
                if(data.result=="success"){
                    app.showSuccess("删除成功！");
                    search.load();
                }else{
                    app.showError("无法删除!");
                }
            }
        });
    },'question');
}

function copyAdminUser(adminUserId){
    window.location.href = "${ctx}/admin/sa/adminUser/copyAdminUser/"+adminUserId;
}

function editAdminUser(adminUserId){
    window.location.href = "${ctx}/admin/sa/adminUser/adminUserForm/"+adminUserId;
}
</script>

</body>
</html>