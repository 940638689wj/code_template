<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
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
    var search;
    var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'门店列表',value:'0'},
        ]
    });
    tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
    
	tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/sa/userStore/storeManageList";
	        }
	    });
	    
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title : '门店名称',dataIndex :'storeId',width:150, renderer : function(value, rowObj){
                var detailStr='<a href="${ctx}/admin/sa/userStore/storeForm?storeId='+rowObj.storeId+'">'+rowObj.storeName+'</a>';
                return detailStr;
            }},
            {title : '联系方式',dataIndex : 'telephone',width:150},
            {title : '地址',dataIndex : 'detailAddress',width:300, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title : '提货时间',dataIndex : '',width:300, renderer : function(value, rowObj){
            	var str;
                str = 'AM&nbsp;'+ rowObj.deliveryTimeAmStart;
                str += '&nbsp;至&nbsp;'+rowObj.deliveryTimeAmEnd;
                str += '&nbsp;&nbsp;&nbsp;PM&nbsp;'+rowObj.deliveryTimePmStart;
                str += '&nbsp;至&nbsp;'+rowObj.deliveryTimePmEnd;
                return str;
            }},
            {title : '状态',dataIndex : 'statusCd' ,withd:40, renderer : function(value,rowObj){
            	var type="";
            	if(value==1){
            		type="启用";
            	}else if(value==0){
            		type="禁用";
            	}else{
            		type="删除";
            	}
            	return type;
            }},
            {title : '操作',dataIndex : 'storeId',width:120,renderer : function(value,obj){
					var editStore = '&nbsp;<a href=\'javascript:editStore(\"' + value + '\")\'>编辑</a>';
                    var deDelete = "";
<@securityAuthorize ifAnyGranted="delete">
					deDelete = '&nbsp;&nbsp;<a href=\'javascript:conformCancel(\"' + value + '\")\'>删除</a>';
</@securityAuthorize>
					return editStore + '&nbsp;&nbsp;&nbsp;' + deDelete;

            }}
           
        ];
        var store = Search.createStore("${ctx}/admin/sa/userStore/store_grid_json",{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	tbar : {
                items : [
                    {text : '新建',btnCls : 'button button-small',handler:addStore},
<@securityAuthorize ifAnyGranted="delete">
                    {text : '批量删除',btnCls : 'button button-small',handler:deleteStores}
</@securityAuthorize>
                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
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

	//新建门店
	function addStore() {
        window.location.href = "${ctx}/admin/sa/userStore/storeForm";
    }

    //编辑门店
    function editStore(storeId) {
        window.location.href = "${ctx}/admin/sa/userStore/storeForm?storeId="+storeId;
    }

    //批量删除门店
    function deleteStores() {
        var selectedStores = grid.getSelection();
        if (selectedStores.length <= 0) {
            BUI.Message.Alert("请选择需要删除的门店!");
            return false;
        }
        var selectedStoreIds = [];
        for (var i = 0; i < selectedStores.length; i++) {
            selectedStoreIds.push(selectedStores[i].storeId);
        }
        var storeIds = selectedStoreIds.join(",")
        BUI.Message.Confirm('确定要删除选中门店吗?', function () {
            $.ajax({
                url: '${ctx}/admin/sa/userStore/deleteStore',
                dataType: 'json',
                type: 'POST',
                data: {storeIds:storeIds},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("门店删除成功!");
                        location.href=location.href;
                    } else {
                        app.showError("门店删除失败!");
                        location.href=location.href;
                    }
                }
            });
        }, 'question');
    }
    

    function conformCancel(value){
    	BUI.Message.Confirm('确定要删除选中门店吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/userStore/deleteStore',
	                dataType : 'json',
	                type: 'POST',
	                data : {storeIds : value},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess("门店删除成功。");
                            location.href=location.href;
	                    }else{
	                        app.showError("门店删除失败!");
                            location.href=location.href;
	                    }
	                }
	            });
	        },'question');
    
    }
</script>
</body>
</html>