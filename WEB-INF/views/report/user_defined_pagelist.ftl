<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="../css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="../css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="../css/main.css" rel="stylesheet" type="text/css"/>
    <link href="../css/page.css" rel="stylesheet" type="text/css"/>
    <link href="../css/theme-01.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
    </div>
    <div class="content-top">
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript" src="../js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="../js/bui.js"></script>
<script type="text/javascript" src="../js/config.js"></script>
<script type="text/javascript" src="../js/admin.js"></script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'自定义页面',value:'1'}
        ]
    });
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        $('#log').text(item.get('text') + ' ' + item.get('value'));
    });
    tab.setSelected(tab.getItemAt(0));

    var Grid = BUI.Grid,
            Toolbar = BUI.Toolbar,
            Data = BUI.Data;
    var Grid = Grid,
            Store = Data.Store,
            columns = [{
                title : '自定义标题',
                dataIndex :'a',
                width:400
            },{
                title : '查看次数',
                dataIndex :'b',
                width:150
            },{
                title : '访问地址',
                dataIndex : 'c',
                width:200
            },{
                title : '创建时间',
                dataIndex : 'd',
                width:200
            },{
                title : '操作',
                dataIndex : 'e',
                width:200
            }],
            data = [{a:'1231231231231231',e:'<a href="#">编辑</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href="#">删除</a>'}];

    var store = new Store({
                data : data,
                autoLoad:true,
                pageSize:'20'
            }),
            grid = new Grid.Grid({
                width: '100%',
                height: getContentHeight(),
                render:'#grid',
                columns : columns,
                // 顶部工具栏
                tbar:{
                    // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                    items:[{
                        //xclass:'bar-item-button',默认的是按钮
                        btnCls : 'button button-small',
                        text:'新建',
                    }]
                },
                // 底部工具栏
                bbar:{
                    // pagingBar:表明包含分页栏
                    pagingBar:true
                },
                store : store
            });
    grid.render();

</script>
</body>
</html>  