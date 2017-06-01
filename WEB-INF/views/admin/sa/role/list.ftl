<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" placeholder="岗位名" class="control-text" id="short_roleDesc"/><button onclick="search()"></button>
            </div>

            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">岗位名：</label>
                            <div class="controls">
                                <input type="text" id="roleDesc"  name="roleDesc" class="input-normal control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'岗位管理',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'操作',dataIndex:'roleId',width:70, renderer : function(value, rowObj){
                var editStr="";
                editStr += '&nbsp;<a href=\'javascript:editRole(\"' + value + '\")\'>编辑</a>&nbsp;';
<@securityAuthorize ifAnyGranted="delete">
                editStr += '&nbsp;<a href=\'javascript:delRole(\"' + value + '\")\'>删除</a>';
</@securityAuthorize>
                return editStr;
            }},
            {title:'岗位描述',dataIndex:'roleDesc',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'状态',dataIndex:'roleStatusCd',width:80,renderer : function(value, rowObj){
                var roleStatusCd = "禁用";
                if(value && value == 101){
                    roleStatusCd = "启用";
                }
                return roleStatusCd;
            }},
            {title:'创建时间',dataIndex:'createTime',width:300, renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'更新时间',dataIndex:'lastUpdateTime',width:200,renderer:BUI.Grid.Format.datetimeRenderer}
        ];
        var store = Search.createStore('${ctx}/admin/sa/role/grid_json');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '添加岗位',btnCls : 'button button-small button-primary',handler:addRole}
                ]
            }
        });

        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                });
        var grid = search.get('grid');

    });

    function addRole(){
        window.location.href = "${ctx}/admin/sa/role/roleForm/0";
    }
    function editRole(roleId){
        window.location.href = "${ctx}/admin/sa/role/roleForm/"+roleId;
    }

    $(function(){
        //点击 右上角搜索框
        var mask;
        $('.title-bar-side .search-bar input').on('focus',function(){
            var $this = $(this);
            $this.addClass("focused");
            if(!mask)
                mask = $('<div></div>').css({
                    'position':'absolute',
                    'left':0,
                    'top':0,
                    'width':'100%',
                    'height':'100%'
                }).appendTo(document.body);
            mask.on('click',function(){
                $this.removeClass("focused");
                mask.remove();
                mask = null;
            });
        });

        $("#short_roleDesc").on('keyup',function(){
            $("#roleDesc").val($("#short_roleDesc").val());
            if(event.keyCode ==13)
            {
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#short_roleDesc").on('click',function(){
            $("#roleDesc").val($("#short_roleDesc").val());
        });
    })

    function search(){
        $('#btnSearch').click();
    }

    function delRole(value){
        BUI.Message.Confirm('确认要删除该条目吗？',function(){
            $.ajax({
                url: "${ctx}/admin/sa/role/deleteRole",
                type:"post",
                dataType: "json",
                data:{roleId:value},
                success: function(data){
                    if(data.result=="success"){
                        app.showSuccess("删除成功！");
                        search();
                    }else{
                        app.showError("无法删除!");
                    }
                }
            });
        },'question');
    }
</script>
 </body>
 </html>