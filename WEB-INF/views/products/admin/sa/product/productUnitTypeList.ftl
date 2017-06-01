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
    <div class="content-top">
        <div class="bui-inline-block">
             <button type="button" class="button button-primary" onclick="javascript:addUnitType();">新增</button>
        </div>
	</div>
	<div class="content-body"> 
		<div id="grid">
		</div>
	</div>
</div>
<script type="text/javascript">
    var search;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'商品单位维护',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [		
			{title : '单位编码',dataIndex :'unitEnName',width:150, renderer:function(value,rowObj){
				return value;
			}}, 
			{title : '单位名称',dataIndex :'unitCnName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '操作',width:200,renderer:function(value,rowObj){
				var str = "<a href='javascript:delUnitType(\""+rowObj.unitId+"\");'>删除</a>&nbsp;";
			   return str; 
			}},
		];
				
		var store = Search.createStore('${ctx}/admin/sa/productManage/unit/grid_json',{pageSize:15});
				
		var gridCfg = Search.createGridCfg(columns,
			{   width: '100%',
				height: getContentHeight()
			});
	
		search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
		});
		var grid = search.get('grid');
		
		});
		
		function delUnitType(oval){
			$.ajax({
                    url : '${ctx}/admin/sa/productManage/delUnitType?unitId='+oval,
                    dataType : 'json',
                    type: 'POST',
                    success : function(data){
                        if(data.data){
                            BUI.Message.Alert('删除成功!');
                            search.load();
                        }else{
                            BUI.Message.Alert('删除失败!');
                        }
                    }
                });
		}
		
		function addUnitType(){
			window.location.href = "${ctx}/admin/sa/productManage/addUnitType";
		}
		
</script>
<body>
</html>  