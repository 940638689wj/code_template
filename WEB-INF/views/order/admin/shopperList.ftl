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
	                    <div class="bui-form-group">
	                        <input type="text" placeholder="编号" name="shopperNum"  class="input-normal control-text mr">
	                        <input type="text" placeholder="姓名" name="shopperName" class="input-normal control-text mr">
	                        <input type="text" placeholder="联系方式" name="phone"  class="input-normal control-text mr">
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
		 		        {title : '编号',dataIndex : 'shopperNum',width:"80px"},
		 		        {title : '姓名',dataIndex : 'shopperName',width:"100px"},
		 		        {title : '联系方式',dataIndex : 'phone',width:"200px"},
		 		        {title : '处理中订单',dataIndex : 'countNo',width:"80px"},
		 		        {title : '状态',dataIndex : 'workStatusCd',width:"150px", renderer: function (val, obj) {
				                if (val  == 1) {
				                    return "空闲"
				                }else if(val == 0){
				                    return "休息"
				                }else if(val == 2){
				                return "繁忙";
				                }
				                return "";
            	         }},
		 		  
		 		    ],
		        
		        
		      store = Search.createStore('${ctx}/admin/sa/order/shopper_grid_json',{
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