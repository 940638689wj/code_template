<#assign ctx = request.contextPath>
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

    <div class="content-top">
	<form id="searchForm" class="form-horizontal search-form">
	    <div class="row">
	    	<div class="search-bar">
                <input id="keywords" name="keywords" class="control-text" type="text" placeholder="提货券名称"/>
                <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                <a class="button" onclick="passAll();">批量同意</a>
                <a class="button" onclick="refuseAll();">批量拒绝</a>
	        </div>
	    </div>
	</form>
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
            {text:'提货券审核',value:'0'},
            {text:'审核日志',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/sa/pickUpCouponAudit/list";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/sa/pickUpCouponAudit/doneList";
	        }
    });

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'操作',dataIndex:'',width:120,renderer : function(value,rowObj){
                var editStr = "<a href=\"javascript:pass(\'" + rowObj.auditId + "')\">同意</a>&nbsp;&nbsp;&nbsp;";
                editStr += "<a href=\"javascript:refuse(\'" + rowObj.auditId + "')\">拒绝</a>&nbsp;&nbsp;&nbsp;";

                return editStr;
            }},
            {title: '编号', dataIndex: 'pickupCouponId', width: 100},
            {
                title: '提货券名称', dataIndex: 'pickupCouponName', width: 100, renderer: function (value, rowObj) {
                return '<a href="${ctx}/admin/sa/pickupcouponCode?pickupCouponId=' + rowObj.pickupCouponId  + '">' + value + '</a>';
            }
            },
            {title: '描述', dataIndex: 'pickupCouponDesc', width: 200},
            {title: '提货门店', dataIndex: 'storeName', width: 100},
            {title: '卡号段', dataIndex: 'cardPrefix', width: 100},
            {
                title: '有效使用时间', dataIndex: '', width: 200, renderer: function (value, rowObj) {
                var cardNum = "";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseStartTime);
                cardNum += " 至 ";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseEndTime);
                return cardNum;
            }
            },
            {title: '发放数量', dataIndex: 'pickupCnt', width: 80},
            {title: '金额', dataIndex: 'pickupAmt', width: 100},
            {title: '状态', dataIndex: 'statusName', width: 80}
        ];
        var store = Search.createStore('/admin/sa/pickUpCouponAudit/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight()
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        grid = search.get('grid');
    });

    /**
     * 同意提货券
     * @param auditId
     */
    function pass(auditId){
        if(!auditId){
            return;
        }
        BUI.Message.Confirm('确定要同意该提货券吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/pickUpCouponAudit/pass/'+auditId,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("提货券审核通过！");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }

    /**
     * 批量同意
     * @returns {boolean}
     */
    function passAll(){
        var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择要同意的提货券!");
            return false;
        }
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].auditId);
        }

        BUI.Message.Confirm('确定要批量同意提货券申请吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/pickUpCouponAudit/passAll',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedContentIds},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已同意了提货券申请!");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }

    /**
     * 拒绝提货券申请
     * @param auditId
     */
    function refuse(auditId){
        if(!auditId){
            return;
        }
        BUI.Message.Confirm('确定要拒绝该提货券吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/pickUpCouponAudit/refuse/'+auditId,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已拒绝了提货券申请!");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }

    /**
     * 批量拒绝
     * @returns {boolean}
     */
    function refuseAll(){
        var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择要拒绝的提货券!");
            return false;
        }
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].auditId);
        }

        BUI.Message.Confirm('确定要批量拒绝提货券申请吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/pickUpCouponAudit/refuseAll',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedContentIds},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已拒绝了提货券申请!");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }


</script>
</body>
</html>  