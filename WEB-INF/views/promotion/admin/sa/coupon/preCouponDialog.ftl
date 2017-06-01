<#assign ctx = request.contextPath>
<div class="container">
	<button id="exportPreCoupon" type="button" class="button button-primary">导出</button>
	<div class="search-grid-container">
		<div id="couponGrid"></div>
	</div>
</div>
<script src="/static/admin/js/common/search-min.js"></script>
<script type="text/javascript">
	var promotionType = ${promotionType!0};
	/**
	 * 构建预生成优惠券表格
	 *
	 */
	BUI.use(['common/search'], function (Search) {
		var grid;
		var columns = [
				{title: '优惠券码', dataIndex: 'couponCode', width: 160},
				{title: '优惠券面额', dataIndex: 'discountValueShow', width: 120,renderer: function (value,rowObj) {
					//54抵用券 55折扣券
					if(promotionType == 54){
						return value + "元";
					}else if(promotionType == 55){
						return value + "折";
					}
				}},
				{title: '优惠券使用条件', dataIndex: 'conditionExpressionValue', width: 120}
		];
        var store = Search.createStore('${ctx}/admin/sa/promotion/coupon/preCoupon/grid_json?promotionId=${promotionId}',{pageSize:10});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%'
        });
        var search = new Search({
            gridId: "couponGrid",
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get('grid');
    });
    
	$(function(){
		$("#exportPreCoupon").click(function(){
			window.location.href = "${ctx}/admin/sa/promotion/coupon/preCoupon/exportPreCoupon?promotionId=${promotionId}";
		});
	});
</script>