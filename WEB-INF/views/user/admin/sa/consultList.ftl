<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <style>
        .form-horizontal  .control-label{width:90px;}
    </style>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
    </div>
    <div class="content-top">
        <form id="searchForm" class="form-horizontal search-form">
            <div class="content-top">
                <input id="loginName" name="loginName" class="control-text" placeholder="用户名">
                &nbsp;&nbsp;
                <button id="btnSearch" type="button" class="button button-primary">搜索</button>
            </div>
        </form>
    </div>

    <div class="content-body">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
    var grid;
    var search;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'咨询管理',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt('0'));

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'编号',dataIndex:'consultID',width:40, renderer : function(value, rowObj){
                return value;
            }},
            {title:'商品名称',dataIndex:'productName',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'会员名称',dataIndex:'loginName',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'咨询内容',dataIndex:'content',width:200, renderer : function(value, rowObj){
                return (value!=null && ""!=null)?value:0;
            }},
            {title:'状态',dataIndex:'consultStatusCd',width:100, renderer : function(value, rowObj){
                if(value == 1){
                    return "审核中";
                }else if(value == 2){
                    return "审核通过";
                }else if(value == 3){
                    return "审核拒绝";
                }
                return "";
            }},
            {title:'提交时间',dataIndex:'createTime',width:140, renderer : function(value, rowObj){
                if(null!=value){
                    return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
            {title:'操作',dataIndex:'consultID',width:100, renderer : function(value,rowObj){
                var editStr = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/user/consult/edit?id='+value
                });
                return editStr;
            }}
        ];

        var store = Search.createStore('${ctx}/admin/sa/user/consult/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
           // plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar:{
                items:[
                ]
            },
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();
    });

</script>
</body>
</html>