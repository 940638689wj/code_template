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
            {text:'商品品牌',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'名称',dataIndex:'brandName',width:150, renderer:function(value, rowObj){
                var str = "";
                str = "<a href='javascript:editBrand(\""+rowObj.brandId+"\");'>"+value+"</a>";	
                return str;
            }},
            {title:'排序',dataIndex:'displayId',width:100},
            {title:'图片',dataIndex:'brandImgUrl',width:120, renderer:function(value, rowObj){
            	var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" style="width:50px;height: 50px;"/>';
            	}else{
            		img_url = '<img src="" style="width:50px;height: 50px;"/>';
            	}
                return img_url;
            }},
            {title:'地址',dataIndex:'brandPageUrl',width:400, renderer:function(value, rowObj){
                return "/m/brand/detail/"+rowObj.brandId+".html";
            }},
            {title:'创建时间',dataIndex:'createTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'状态',dataIndex:'brandStatusCd',width:120, renderer:function(value, rowObj){
            	var statusName = "";
            	if(value==1){
            		statusName = "启用";
            	}else{
            		statusName = "禁用";
            	}
                return statusName;
            }},
            {title:'操作',dataIndex:'brandStatusCd',width:120, renderer:function(value, rowObj){
                var delStr = "";
<@securityAuthorize ifAnyGranted="delete">
                delStr = "<a href='javascript:removeBrand(\""+rowObj.brandId+"\");'>删除</a>";
</@securityAuthorize>
                return delStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/brand/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新增品牌',btnCls : 'button button-small button-primary',handler:addNew}
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
        window.location.href = "${ctx}/admin/sa/brand/form";
    }

    function editBrand(obj){
        window.location.href = "${ctx}/admin/sa/brand/form?brandId="+obj;
    }
    function removeBrand(objId){
        $.post("${ctx}/admin/sa/brand/removeBrand",{"productBrandId":objId},function(data){
           if(data.result=="success"){
               BUI.Message.Alert('删除成功',function(){
                   window.location.href = "${ctx}/admin/sa/brand/list";
               },'question');
           }else{
              BUI.Message.Alert(data.message);
           }
        });
    }
</script>
</body>
</html>