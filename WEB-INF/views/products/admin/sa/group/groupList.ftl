<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
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
            {text:'商品分组',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'名称',dataIndex:'groupName',width:150},
            {title:'状态',dataIndex:'statusCd',width:120, renderer:function(value, rowObj){
            	var statusName = "";
            	if(value==1){
            		statusName = "启用";
            	}else{
            		statusName = "禁用";
            	}
                return statusName;
            }},
            {title : '操作',width:150, renderer : function(value, rowObj){
                var editStr ="";
                editStr = Search.createLink({
                    text: '编辑',
                    href: "${ctx}/admin/sa/group/form?groupId=" + rowObj.productGroupId
                });
                var deleteStr ="";
<@securityAuthorize ifAnyGranted="delete">
                deleteStr = "<span class='grid-command' onclick=\"javascript:deleteGroup('" + rowObj.productGroupId + "')\">删除</span>";
</@securityAuthorize>
                return editStr+"&nbsp;"+deleteStr;
            }},
        ];
        var store = Search.createStore('${ctx}/admin/sa/group/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新增分组',btnCls : 'button button-small button-primary',handler:addNew}
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
        window.location.href = "${ctx}/admin/sa/group/form";
    }

    function deleteGroup(groupId){
        if(!groupId){
            return;
        }

	    BUI.Message.Confirm('确定要删除该分组吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/group/deleteGroup',
	                dataType : 'json',
	                type: 'POST',
	                data : {groupId : groupId},
	                success : function(data){console.log(data);
	                    if(data.result == "success"){
	                        app.showSuccess("分组删除成功。");
	                        search.load();
	                    }else if(data.result == "error"){
	                        BUI.Message.Alert(data.message);
	                    }else{
	                    	app.showSuccess("分组删除失败!");
	                    }
	                }
	            });
	        },'question');
	 }
    
</script>
</body>
</html>