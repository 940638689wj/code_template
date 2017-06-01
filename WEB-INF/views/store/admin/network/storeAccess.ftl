<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
   <#include "${ctx}/includes/sa/header.ftl"/>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <div class="title-text">门店信息</div>
        <div class="userinfo-box">
            <div class="pic"><img src="<#if (store.storeLogoUrl)??>${store.storeLogoUrl}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100"></div>
                        <div class="code"><img src="${ctx}/admin/network/userStore/getQrImg?storeId=${store.storeId}"  width="100" height="100"></div>
            <ul>
                <li>门店编码：${(store.storeNumber)!''}</li>
                <li>门店名称：${(store.storeName)!''}</li>
                <li>注册时间：${(store.createTime?string('yyyy-MM-dd HH:mm:ss'))!''}</li>
            </ul>
        </div>
    </div>
    <form id="storeReviewListSearchForm" class="form-horizontal search-form" style="display: none;">
        <input type="hidden" name="eq_storeRatingSummary.store.storeId" value="${(store.storeId)!}"/>
        <input name="sort" value="reviewSubmittedDate desc" type="hidden"/>
        <input name="eq_reviewFlag" value="1" type="hidden"/>
    </form>
    <div id="storeReviewListGrid"></div>
</body>
<script type="text/javascript">
 		var searchReviewList;
        BUI.use(['common/search','common/page'],function (Search) {
            var columns = [
                {title:'会员手机号',dataIndex:'reviewerPhone',width:120},
                {title:'姓名',dataIndex:'reviewName',width:100},
                {title:'卖家的服务态度',dataIndex:'saleServiceAttrScore',width:120},
                {title:'卖家的发货速度',dataIndex:'saleShipSpeedScore',width:100},
                {title:'评价提交时间',dataIndex:'reviewTime',width:140, renderer: BUI.Grid.Format.dateRenderer}

            ];
            var store = Search.createStore('${ctx}/admin/network/userStore/storeDetailReviewList_grid_json?storeId=${(store.storeId)!}');
            var gridCfg = Search.createGridCfg(columns,{
                width: '99.5%',
                plugins : [BUI.Grid.Plugins.CheckSelection],
                tbar : {
                    items : [
                        {text : '<i class="icon-plus"></i>新加评价',btnCls : 'button button-small',handler:addFunction},
                        {text : '<i class="icon-question"></i>编辑',btnCls : 'button button-small',handler:editFunction},
                        {text : '<i class="icon-remove"></i>删除',btnCls : 'button button-small',handler:deleteFunction}
                    ]
                }
            });
            searchReviewList = new Search({
                formId:"storeReviewListSearchForm",
                store : store,
                gridCfg : gridCfg,
                gridId:'storeReviewListGrid'
            });
            var grid = searchReviewList.get('grid');
            grid.render();
        
		//添加
        function addFunction(){
            app.page.open({
                href:'${ctx}/admin/network/userStore/toAddStoreAccess?storeId='+${(store.storeId)!}
            });
        }
        //编辑
        function editFunction(){
        	var  selectedContent= grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择会员!");
                return false;
            }
            if(selectedContent.length > 1){
                BUI.Message.Alert("请选择一条评价进行编辑");
                return false;
            }
            var reviewId=selectedContent[0].reviewId;
            app.page.open({	
                href:'${ctx}/admin/network/userStore/toUpdateStoreAccess?reviewId='+reviewId
            });
        }
        //删除
        function deleteFunction(){
       		var  selectedContent= grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择会员!");
                return false;
            }
            
            BUI.Message.Confirm('确认要删除该条目吗？',function(){
                var selectedContentIds = [];
	            for(var i = 0; i < selectedContent.length ; i++){
	                selectedContentIds.push(selectedContent[i].reviewId);
	            }
	        	reviewIds= selectedContentIds.join(",");
	        	
                app.ajax("${ctx}/admin/network/userStore/delReview", 
                {reviewIds: reviewIds}, function (data) {
                    if(data){
                        app.showSuccess("删除成功！")
                        location.href='${ctx}/admin/network/userStore/toStoreAccess?storeId=${(store.storeId)!}';
                        search.load();
                    }else{
                        app.showSuccess("删除失败");
                        search.load();
                    }
                })

            });
        }
    });
		
</script>
</body>
</html>  