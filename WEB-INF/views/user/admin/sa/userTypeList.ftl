<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
<style>.form-horizontal  .control-label{width:100px;}</style>
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
            {text:'会员类型',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search','common/page'],function (Search) {
    var columns = [
        {title:'ID',dataIndex:'userTypeId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='id' value='" + value + "'>";
        }},
        {title:'会员类型名称',dataIndex:'userTypeName',width:160, renderer : function(value, rowObj){
            return app.grid.format.encodeHTML(value);
        }},
        {title:'更新时间',dataIndex:'createTime',width:160, renderer:BUI.Grid.Format.datetimeRenderer},
        {title:'状态',dataIndex:'statusCd',width:80,renderer : function(value, rowObj){
            var statusCd = "禁用";
            if(value && value == 1){
                statusCd = "启用";
            }
            return statusCd;
        }},
        {title:'操作',dataIndex:'isDefault',width:100,renderer : function(value,rowObj){
        	var btn_text="";
        	var defaultCd=0;
        	if(value==1){
        		btn_text="取消默认";
        	}else{
        		btn_text="设置为默认";
        		defaultCd=1;
        	}
            var editStr="";
            editStr += '&nbsp;<a href=\'javascript:editUserType(\"' + rowObj.userTypeId + '\")\'>编辑</a>';
            editStr += '&nbsp;<a href=\'javascript:setIsDefault(\"' + rowObj.userTypeId + '\",'+defaultCd+')\'>'+btn_text+'</a>';
            return editStr;
        }}
    ];
     var userType = Search.createStore('/admin/sa/userType/grid_json1',{pageSize:10});
     var gridCfg = Search.createGridCfg(columns,{
     		plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight(),
            render:'#grid',
            columns : columns
	        , tbar : {
	            items : [
	                {text : '添加会员类型',btnCls : 'button button-small button-primary',handler:addFunction}
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
	        window.location.href = "${ctx}/admin/sa/userType/userTypeForm/0";
	    }
        
});

function editUserType(userTypeId){
    window.location.href = "${ctx}/admin/sa/userType/userTypeForm/"+userTypeId;
}

function setIsDefault(userTypeId,isDefault){
	app.ajax('${ctx}/admin/sa/userType/setDefault',{
      userTypeId:userTypeId,isDefault:isDefault
      },function(data){
      if(app.ajaxHelper.handleAjaxMsg(data)){
			app.showSuccess("设置成功");
			location.href=location.href;
		}
     });
}
</script>
</body>
</html>  