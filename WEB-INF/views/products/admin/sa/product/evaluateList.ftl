<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li>
            <a href="${ctx}/admin/sa/productManage/list">商品管理</a> <span class="divider">&gt;&gt;</span>
        </li>
        <li class="active">评价管理</li>
    </ul>
    <div id="tab">
        <ul class="bui-tab nav-tabs">
	          <li href="${ctx}/admin/sa/productManage/addOrEdit?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	              <span class="bui-tab-item-text">基本信息</span>
	          </li>
	          <li href="${ctx}/admin/sa/productManage/details?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	              <span class="bui-tab-item-text">详细信息</span>
	          </li>
	          <li href="${ctx}/admin/sa/productManage/evalute?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
	              <span class="bui-tab-item-text">商品评价设置</span>
	          </li>
        </ul>
    </div>
    <div class="clearfix" style="position: relative;padding-left: 208px;">
        <#include "productInfo.ftl">
        <div style="min-width: 416px;margin-left: 20px;">
            <form id="searchForm">
             <!--<input type="hidden" name="eq_ratingSummary.itemId" value="${(product.productId)!}"/>-->
            	<input type="hidden" name="reviewStatus" value="2"/>            	
            </form>
            <div class="search-grid-container">
                <div id="grid"></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title: '会员手机号码', dataIndex: 'reviewerPhone', width: 100, renderer: function (value) {
                return app.grid.format.encodeHTML(value);
            }},
            {title: '会员名称', dataIndex: 'reviewerName', width: 100, renderer: function (value) {
                return app.grid.format.encodeHTML(value);
            }},
            {title: '评价内容', dataIndex: 'reviewContent', width: 250, renderer: function (value){
                return app.grid.format.encodeHTML(value);
            }},
            {title: '宝贝与描述符合程度', dataIndex: 'productMatchScore', width: 100},
            {title: '评价提交时间', dataIndex:'reviewTime', width:100, renderer: BUI.Grid.Format.dateRenderer},
            {title: '回复内容', dataIndex:'replyContent', width:100, renderer: function (value){
                return app.grid.format.encodeHTML(value);
            }},
            {title: '回复时间', dataIndex: 'replyTime',width: 150, renderer: BUI.Grid.Format.dateRenderer}
        ];
        var store = Search.createStore('${ctx}/admin/sa/productManage/evalute/grid_json?productId=' +${(product.productId)!},{pageSize:15});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '<i class="icon-plus"></i>新加评价', btnCls: 'button button-small', handler: addFunction},
                    {text: '编辑', btnCls: 'button button-small', handler: editFunction},
                    {text: '删除', btnCls: 'button button-small', handler: delFunction}
                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight()
        });
		
		        
        var search = new Search({
        	gridId : 'grid',
        	store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
        
		// 新增评价
        function addFunction() {
            app.page.open({
                href: '${ctx}/admin/sa/productManage/evaluteEdit?productId=' +${(product.productId)!}
            });
        }
        
        // 编辑评价
        function editFunction() {
            var selectedGoods = grid.getSelection();
	        if(selectedGoods.length <= 0){
	            BUI.Message.Alert("请选择商品评价信息!");
	            return false;
	        }
			if(selectedGoods.length > 1){
	            BUI.Message.Alert("请选择一条商品评价信息!");
	            return false;
	        }
	        
	  		window.location.href = '${ctx}/admin/sa/productManage/evaluteEdit?productId=' +${(product.productId)!}+ '&reviewId='+selectedGoods[0].reviewId;

        }
        
        // 删除评价
        function delFunction() {
           	var selectedGoods = grid.getSelection();
	        if(selectedGoods.length <= 0){
	            BUI.Message.Alert("请选择商品!");
	            return false;
	        }
	
	        var selectedGoodsIds = [];
	        for(var i = 0; i < selectedGoods.length ; i++){
	            selectedGoodsIds.push(selectedGoods[i].reviewId);
	        }
            BUI.Message.Confirm('确认要删除该条目吗？', function () {
                $.ajax({
                    url: "${ctx}/admin/sa/productManage/evaluteDel",
                    type: "POST",
                    dataType: "json",
                    data : {reviewId : selectedGoodsIds, productId : ${(product.productId)!}},
                    success: function (data) {
                       	app.showSuccess("删除成功！")
                       	search.load();
                      window.location.href = '${ctx}/admin/sa/productManage/evalute?productId=' +${(product.productId)!};
                    }
                });
            });
        }
        
        $("li[href]").click(function () {
             var href = $(this).attr("href");
             window.location.href = href;
        });
    });
</script>
</body>
</html>