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
            {text:'个性化分类',value:'0'}
        ]
    });
    
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
          	/*!{title:'',width:80, renderer:function(value, rowObj){
            	var checkbox = '<input type="checkbox" name="checkname">';
                return checkbox;
            }},*/
            {title:'个性化分类编码',dataIndex:'labelNum',width:150, renderer:function(value, rowObj){
                var str = "";
                str = "<a href='javascript:editLabel(\""+rowObj.labelId+"\");'>"+value+"</a>";	
                return str;
            }},
            {title:'个性化分类名称',dataIndex:'labelName',width:150, renderer:function(value, rowObj){
                return value;
            }},
            {title:'个性化分类状态',dataIndex:'labelStatusCd',width:150, renderer:function(value, rowObj){
                var statusName = "";
            	if(value==1){
            		statusName = "启用";
            	}else{
            		statusName = "禁用";
            	}
                return statusName;
            }},
            {title:'个性化分类图片',dataIndex:'labelImgUrl',width:200, renderer:function(value, rowObj){
                var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" width="50px" height="50px"/>';
            	}else{
            		img_url = '<img src="" width="50px" height="50px"/>';
            	}
                return img_url;
            }},
            {title:'个性化分类链接',dataIndex:'labelPageUrl',width:150, renderer:function(value, rowObj){
            	var linkName = '/m/label/'+ rowObj.labelId +'.html'
            	return linkName;
            }},
            {title:'是否显示在商品列表',dataIndex:'isShowInProductList',width:150, renderer:function(value, rowObj){
            	var statusName = "";
            	if(value==1){
            		statusName = "是";
            	}else{
            		statusName = "否";
            	}
                return statusName;
            }},
            {title:'创建时间',dataIndex:'createTime',width:200,renderer:BUI.Grid.Format.datetimeRenderer}
        ];
        var store = Search.createStore('${ctx}/admin/sa/label/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新建分类',btnCls : 'button button-small button-primary',handler:addlabel}
                ]
            }
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
        
        
    });
    // 编辑分类
	function addlabel(){
	   window.location.href = "${ctx}/admin/sa/label/form";
	}
        
	// 编辑分类
	function editLabel(obj){
		window.location.href = "${ctx}/admin/sa/label/form?labelId="+obj;
	}
</script>
</body>
</html>