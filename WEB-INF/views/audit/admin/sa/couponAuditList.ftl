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
                <input id="keywords" name="keywords" class="control-text" type="text" placeholder="优惠券名称"/>
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
            {text:'优惠券审核',value:'0'},
            {text:'审核日志',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/sa/couponAudit/list";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/sa/couponAudit/doneList";
	        }
    });

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'操作',dataIndex:'',width:120,renderer : function(value,rowObj){
                var viewStr = Search.createLink({
                    text: '查看',
                    href: '${ctx}/admin/sa/promotion/coupons/editCoupon?promotionId=' + rowObj.promotionId
                });

                    var editStr = "<a href=\"javascript:pass(\'" + rowObj.auditId + "')\">同意</a>&nbsp;&nbsp;&nbsp;";
                    editStr += "<a href=\"javascript:refuse(\'" + rowObj.auditId + "')\">拒绝</a>&nbsp;&nbsp;&nbsp;";

                return editStr + "&nbsp;" + viewStr;
            }},
            {title:'编号',dataIndex:'promotionId',width:50},
            {title:'名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'描述',dataIndex:'promotionDesc',width:160, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'推送条件',dataIndex:'pushTypeCd', width:150,renderer:function (value,rowObj) {
                var condition = "";
                var money = "";
                money = rowObj.couponPushOrderAmtLimit == null ? 0 : rowObj.couponPushOrderAmtLimit;
                if (value == 1) {
                    condition = "无条件";
                } else if (value == 2) {
                    condition = " 每笔订单完成" + money + "元";
                } else if (value == 3) {
                    condition = "订单支付完成分享用券";
                } else if (value == 4) {
                    condition = "首次注册送券";
                }
                return condition;
            }},
            {title:'数量',dataIndex:'couponTotalNum', width:60},
            {title:'领取数量',dataIndex:'doleCount', width:60},
            {title:'已使用数量',dataIndex:'useCount', width:70},
            {title:'使用起始时间',dataIndex:'enableStartTime',width:135,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'使用结束时间',dataIndex:'enableEndTime',width:135,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'领取地址',dataIndex:'', width:170, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML("/m/coupon/" + rowObj.encryptCode + ".html");
            }},
            {title:'状态',dataIndex:'statusCd',width:50,renderer:function(val, rowObj){
                if(val != null && val == 0){
                    return "禁用";
                } else {
                    return "启用";
                }
            }}
        ];
        var store = Search.createStore('/admin/sa/couponAudit/grid_json',{pageSize:15});
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

    //同意优惠券
    function pass(auditId){
        if(!auditId){
            return;
        }
        BUI.Message.Confirm('确定要同意该优惠券吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/couponAudit/pass/'+auditId,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("优惠券审核通过！");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }

    //批量同意
    function passAll(){
        var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择要同意的优惠券!");
            return false;
        }
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].auditId);
        }

        BUI.Message.Confirm('确定要批量同意优惠券申请吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/couponAudit/passAll',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedContentIds},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已同意了优惠券申请!");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }

    //拒绝优惠券申请
    function refuse(auditId){
        if(!auditId){
            return;
        }
        BUI.Message.Confirm('确定要拒绝该优惠券吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/couponAudit/refuse/'+auditId,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已拒绝了优惠券申请!");
                        search.load();
                    }else{
                        app.showError("审核失败!");
                        search.load();
                    }
                }
            });
        },'question');
    }

    //批量同意
    function refuseAll(){
        var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择要拒绝的优惠券!");
            return false;
        }
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].auditId);
        }

        BUI.Message.Confirm('确定要批量拒绝优惠券申请吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/couponAudit/refuseAll',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedContentIds},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已拒绝了优惠券申请!");
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