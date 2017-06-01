<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
    	<div id="tab"></div>
    </div>

    <div class="content-body">
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
            {text:'商品规格',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'名称',dataIndex:'skuTypeDesc',width:150, renderer:function(value, rowObj){
                var str = "";
                str = "<a href='javascript:editSkuType(\""+rowObj.skuTypeId+"\");'>"+value+"</a>";	
                return str;
            }},
            {title:'排序',dataIndex:'displayId',width:75,renderer:function(value,rowObj){
				return value;
			}},
            
            {title:'创建时间',dataIndex:'createTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'操作',dataIndex:'',width:100, renderer:function(value, rowObj){
                var str = "";
                str = "<a href='javascript:findSkuKeyValue(\""+rowObj.skuTypeId+"\");'>"+"查看规格内容"+"</a>";
                return str;
            }},
        ];
        var store = Search.createStore('${ctx}/admin/sa/skuType/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新增规格',btnCls : 'button button-small button-primary',handler:addNew}
                ]
            },
          
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });

    function addNew(){
        window.location.href = "${ctx}/admin/sa/skuType/form";
    }

    function editSkuType(obj){
        window.location.href = "${ctx}/admin/sa/skuType/form?skuTypeId="+obj;
    }
    function findSkuKeyValue(obj){
        window.location.href = "${ctx}/admin/sa/skuType/skuKeyValueList?skuTypeId="+obj;
    }
</script>
</body>
</html>