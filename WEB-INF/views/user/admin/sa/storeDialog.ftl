<#assign ctx = request.contextPath>
<div class="container">
    <div class="row">
        <form id="searchForm" class="form-horizontal search-form">
            <div class="row">
	            <div class="control-group">
		            <label class="control-label">门店名称：</label>
		            <div class="controls">
		                <input type="text" name="storeName" class="control-text">
		            	<button id="btnSearch" type="submit" class="button button-primary">搜索</button>
		            </div>
	            </div>
            </div>
            
            </div>
        </form>
    </div>
    <div class="search-grid-container">
        <div id="grid"></div>
    </div>
</div>
<script src="/static/admin/js/common/search-min.js"></script>
<script type="text/javascript">
    BUI.use(['common/search'], function (Search) {
        var grid;
        var columns = [
        	{title:'ID',dataIndex:'storeId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='storeId' value='" + value + "'>";
        	}},
            {title:'门店编码',dataIndex:'storeNumber',width:120, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'门店名称',dataIndex:'storeName',width:300, renderer : function(value, rowObj){
	        	return value;
            }},
            {title:'状态',dataIndex:'statusCd',width:80, renderer : function(value, rowObj){
            	if(value==1){
            		return '启用';
            	}else{
            		return '<span style="color:red;">冻结</span>';
            	}
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/user/storeGridJson',{pageSize:5});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
        });
        gridCfg = Search.createGridCfg(columns, {
                plugins: [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
                multiSelect: false
            });
        var search = new Search({
            gridId: "grid",
            formId: "searchForm",
            btnId: "btnSearch",
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get('grid');
        top.getSelectedRecords = window.getSelectedRecords = function () {
            var selections = grid.getSelection();
            return selections;
        };
    });
    
</script>