<#assign ctx = request.contextPath>
<#macro showCategoryChild parent level>
    <#if parent?has_content>           	
   		<option value="${(parent.categoryId)!}"><#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${(parent.categoryName)!?html}</option>
    </#if>
	<#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
             <@showCategoryChild child level+1 />
        </#list>
    </#if>    
</#macro>
<div class="container">
    <div class="row">
        <form id="searchForm" class="form-horizontal search-form">
         <input type="hidden" name="productStatusCd" id="productStatusCd" value="1"/>
            <div class="row">
            	<div class="control-group span6">
                    <label class="control-label" style="width: 60px;">产品ID：</label>
                    <div class="controls">
                        <input class="input-normal control-text bui-form-field" name="productId">
                    </div>
                </div>
            	<div class="control-group span6">
                    <label class="control-label" style="width: 60px;">产品名称：</label>
                    <div class="controls">
                        <input class="input-normal control-text bui-form-field" name="productName">
                    </div>
                </div>
                <div class="control-group span6">
                    <label class="control-label" style="width: 60px;">选择分类：</label>
                    <div class="controls">
                    	<select name="categoryId" id="categoryId">
                            <option value="">--请选择--</option>
                            <#if productCategoryList?has_content>
	        					<#list productCategoryList as parentCategory>
					  				<@showCategoryChild  parentCategory 0/>
	        					</#list>
        					</#if>
                        </select>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group span6">
                	<label class="control-label" style="width: 60px;">选择品牌：</label>
                    <div class="controls">
                        <select name="brandId" id="brandId">
                            <option value="">--请选择--</option>
                            <#if productBrandList?? && productBrandList?has_content>
                            	<#list productBrandList as productBrand>
                            		<#if productBrand?has_content>
                            			<option value="${productBrand.brandId}">${productBrand.brandName}</option>
                            		</#if>
                            	</#list>
                            </#if>
                        </select>
                    </div>
                </div>
                <div class="span2">
                    <button  type="button" id="btnSearch" class="button button-primary">搜索</button>
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
            {title: '商品ID', dataIndex: 'productId', width: 80},
            {
                title: '商品名称',
                dataIndex: 'productName',
                width: 120,
                renderer: function (value) {
                    return app.grid.format.encodeHTML(value);
                }
            },
            {title: '品牌名称', dataIndex: 'brandName', width: 120},
            {title: '分类名称', dataIndex: 'categoryName', width: 120},
            {title: '商品成本价', dataIndex: 'tagPrice', width: 100},
            {title: '商品零售价', dataIndex: 'defaultPrice', width: 100},
            {title: '库存', dataIndex: 'sum', width: 80},
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/productDialog/grid_json2',{pageSize:5});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            plugins: [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
            multiSelect: false
        });
        /*
        gridCfg = Search.createGridCfg(columns, {
                plugins: [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
                multiSelect: false
            });
            */
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