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
        <div id="tab">
        </div>
    </div>

    <div class="content-top">
        <form id="searchForm" class="form-horizontal search-form">
            <div class="row mb10">
                <input type="text" class="control-text" name="productName" placeholder="促销名称">
                <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                <button onclick="addFunction()" class="button button-primary">新建【${typeStr!}】促销</button>
            </div>
        </form>
    </div>
    
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
</body>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'${typeStr!}促销列表',value:'0'},
            {text:'过期${typeStr!}促销列表',value:'1'},
            {text:'禁用${typeStr!}促销列表',value:'2'}
        ]
    });
    tab.setSelected(tab.getItemAt(${status?default(0)}));
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="0"){
            window.location.href = "/admin/sa/promotion/orderSales/list?type=${type!}";
        }else if(item.get('value')=="1"){
            window.location.href = "/admin/sa/promotion/orderSales/list?type=${type!}&statusCd=1";
        }else{
            window.location.href = "/admin/sa/promotion/orderSales/list?type=${type!}&statusCd=0";
        }
    });

	var store;
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'编号',dataIndex:'promotionId',width:80},
            {title:'促销名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'促销描述',dataIndex:'promotionDesc',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'优惠类型',dataIndex:'promotionTypeCd', width:100, renderer: function(val, rowObj){
                var offerType = '${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_DISCOUNT_TYPE.getFriendlyType()}';
                if(${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getType()} == val){
                    offerType = '${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getFriendlyType()}';
                } else if (${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getType()} == val){
                    offerType = '${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getFriendlyType()}';
                } 
                return offerType;
            }},
            {title:'起始时间',dataIndex:'enableStartTime',width:140,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'结束时间',dataIndex:'enableEndTime',width:140,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'状态',dataIndex:'statusCd',width:140,renderer:function(val, rowObj){
                if(val != null && val == 0){
                    return "禁用";
                } else {
                    return "启用";
                }
            }},
            {title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
                var str = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/promotion/orderSales/edit?promotionId=' + rowObj.promotionId + '&type=${type!}'
                });
                /*
               viewCodeStr = '';
               if(rowObj.statusCd != null && rowObj.statusCd == 0){
                	viewCodeStr += "<a href=\"javascript:changeStatus(\'" + rowObj.promotionId + "','"+rowObj.statusCd +"')\">启用</a>";
                } else {
                    viewCodeStr += "<a href=\"javascript:changeStatus(\'" + rowObj.promotionId + "','"+rowObj.statusCd +"')\">禁用</a>";
                }
                */
<@securityAuthorize ifAnyGranted="delete">
                str += '&nbsp;<a href="javascript:del(' + rowObj.promotionId + ');">删除</a>';
</@securityAuthorize>
                return str;
            }}
        ];
        store = Search.createStore('/admin/sa/promotion/orderSales/grid_json?type=${type!}&status=${status!}',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
    function addFunction(){
        app.page.open({
            href:'${ctx}/admin/sa/promotion/orderSales/edit?type=${type!}'
        });
    }
    
    function changeStatus(id){
    	BUI.Message.Confirm('确认要更改么？',function(){
		     $.ajax({
		     url:"${ctx}/admin/sa/promotion/redPacket/changeStatus",
		     type:"post",
		     dataType:"json",
		     data:{"promotionId":id },
		     });
		      location.reload();
    	},'question');
    }
    
    function del(id) {
    	BUI.Message.Confirm('确认删除这条活动？',function(){
            $.post('${ctx}/admin/sa/promotion/del',{'promotionId':id},function(data) {
            	if(data && data.result) {
            		app.showSuccess('删除成功！');
            		store.load();
            	}
            },'json');
        },'question');
    }
</script>


</html>