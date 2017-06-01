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
            <input type="hidden" value="${promotionType!}" name="promotionType">
            <input type="hidden" value="1" name="isproductList">
            <input type="hidden" value="${productTypeCd!}" name="productTypeCd">
            <input type="hidden" value="${showSku!}" name="showSku">
            <div class="row">
            	<div class="control-group span6">
                    <label class="control-label" style="width: 60px;">商品ID：</label>
                    <div class="controls">
                        <input class="input-normal control-text bui-form-field" data-rules="{number:true}" name="productId">
                    </div>
                </div>
            	<div class="control-group span6">
                    <label class="control-label" style="width: 60px;">商品名称：</label>
                    <div class="controls">
                        <input class="input-normal control-text bui-form-field" name="productName">
                    </div>
                </div>
                <div class="control-group span6">
                    <label class="control-label" style="width: 60px;">选择商品：</label>
                    <div class="controls">
                    	<select name="categoryId" id="categoryId">
                            <option value="">--请选择--</option>
                            <#if productCategoryList?? && productCategoryList?has_content>
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
            <#if showSku?? && showSku?has_content>
                {title: '规格', dataIndex: 'skuKeyJsonStr', width: 150},
            </#if>
            {title: '品牌名称', dataIndex: 'brandName', width: 120},
            {title: '分类名称', dataIndex: 'categoryName', width: 120},
            {title: '吊牌价', dataIndex: 'tagPrice', width: 100},
            {title: '销售价', dataIndex: 'defaultPrice', width: 100},
            {title: '库存', dataIndex: 'realStock', width: 80}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/productDialog/grid_json',{pageSize:5});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: 260,
            plugins: [<#if single?has_content && single == 1>BUI.Grid.Plugins.RadioSelection<#else> BUI.Grid.Plugins.CheckSelection</#if>],// 插件形式引入多选表格
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