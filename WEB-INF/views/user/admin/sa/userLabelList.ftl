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
        <div id="tab">

        </div>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
	var isDefault_=0;
	var search;
	var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'会员标签',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search','common/page'],function (Search) {
    var columns = [
        {title:'排序',dataIndex:'id',width:40,  renderer : function(value, rowObj){
                return value;
        }},
        {title:'名称',dataIndex:'name',width:100, renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }},
         {title:'是否启用',dataIndex:'statusCd',width:70, renderer : function(value, rowObj){
           if (value == 0) {
                    return "否";
                } else if (value == 1) {
                    return "是";
                }
        }},
       
        {title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
        
            var editStr="";
            editStr += '&nbsp;<a href=\'javascript:editUserLabel(\"' + rowObj.id + '\")\'>编辑</a>';
<@securityAuthorize ifAnyGranted="delete">
            editStr += '&nbsp;<a href=\'javascript:deleteUserLabel(\"' + rowObj.id + '\")\'>删除</a>';
</@securityAuthorize>
            return editStr;
        }}
        
        
    ];
     var userType = Search.createStore('/admin/sa/userLabel/grid_json1',{pageSize:20});
     var gridCfg = Search.createGridCfg(columns,{
    		 plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],
     		
            width: '100%',
            height: getContentHeight(),
            render:'#grid',
            columns : columns
	        , tbar : {
	            items : [
	                {text : '新建',btnCls : 'button button-small button-primary',handler:addFunction},
                <@securityAuthorize ifAnyGranted="delete">
	                 {text : '批量删除',btnCls : 'button button-small',handler:deleteAll}
                </@securityAuthorize>
	            ]
	        }
        });
        search = new Search({
            store : userType,
            gridCfg : gridCfg
        });
        grid = search.get('grid');
        grid.render();
        
        function addFunction(){
	        window.location.href = "${ctx}/admin/sa/userLabel/userLabelForm/0";
	    }
        function deleteAll(){
        	var selectedLabel = grid.getSelection();
        	if(selectedLabel.length<=0){
        		BUI.Message.Alert("请选择需要删除的标签");
        		return false;
        	}
        	
        	var selectedLabelIds = [];
        	
        	for(var i=0;i<selectedLabel.length;i++){
        		
        		selectedLabelIds.push(selectedLabel[i].id);
        	}
 
        	BUI.Message.Confirm("确定要批量删除会员标签吗？",function(){
        		$.ajax({
        			url: '${ctx}/admin/sa/userLabel/deleteAllLabel',
        			dataType : 'json',
        			type: 'POST',
        			data : {labelIds : selectedLabelIds},
        			success : function(data){
        				if(data.result == "true"){
        					app.showSuccess("批量删除成功!")
        					search.load();
        				}else{
        					BUI.Message.Alert(data.message);
        				}
        			}
        		});
        	
        	},'question');
        }
});

function editUserLabel(id){
    window.location.href = "${ctx}/admin/sa/userLabel/userLabelForm/"+id;
}
function deleteUserLabel(id){
	BUI.Message.Confirm('确认删除该会员标签吗？',function(){
		$.ajax({
			url: "${ctx}/admin/sa/userLabel/deleteUserLabel",
			dataType: "json",
			type : "POST",
			data: {id:id},
			success: function(data){
				if(app.ajaxHelper.handleAjaxMsg(data)){
					app.showSuccess("删除成功");
					search.load();
				}
			}
		
		});
	
	},'question')






 }

</script>
</body>
</html>  