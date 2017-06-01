<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
	
	<script src="${staticPath}/js/printOrder.js"></script>
</head>
<body>
  <form id="searchForm" class="form-horizontal">
				<div class="row">
	                <div class="controls ml0">
	                    <div class="controls control-row-auto">
	                        <input type="text" placeholder="编号" name="storeNumber"  class="input-normal control-text mr">
	                        <input type="text" placeholder="姓名" name="contacts" class="input-normal control-text mr">
	                        <input type="text" placeholder="联系方式" name="telephone"  class="input-normal control-text mr">
	                        <input type="text" placeholder="店名" name="storeName"  class="input-normal control-text mr">
	                        <input type="text" placeholder="区域" name="village"  class="input-normal control-text mr">
	                        <button id="btnSearch" class="button button-primary">查询</button>
	                    </div>
	                </div>
                </div>
			</form>
  <div class="content-body">
    <div id="grid"></div>
    </div>
<script type="text/javascript">
  	 BUI.use('common/search',function (Search) {
	     columns = [    
	                    {title : '门店编号',dataIndex : 'storeId',width:"80px"},
		 		        {title : '姓名',dataIndex : 'contacts',width:"100px"},
		 		        {title : '联系方式',dataIndex : 'telephone',width:"200px"},
		 		        {title : '门店店名',dataIndex : 'storeName',width:"80px"},
		 		        {title : '区域',dataIndex : 'village',width:"150px"},
		 		  
		 		    ],
		        
		        
		      store = Search.createStore('${ctx}/admin/sa/order/store_grid_json',{
		       
		        pageSize : 15,
		        autoSync : true //保存数据后，自动更新
		      }),
		      
		      gridCfg = Search.createGridCfg(columns,{
		    	width:'100%',
		    	height:300,    
		        plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.AutoFit] // 插件形式引入多选表格
		      });
		
		    var  search = new Search({
		        store : store,
		        gridCfg : gridCfg
		      }),
		      grid = search.get('grid');
		    top.getSelectedRecords = window.getSelectedRecords = function () {
	            var selections = grid.getSelection();
	            return selections;
	        };
		  });
		
		  
		      
         
		  
	
		  
</script>
</body>
</html>  