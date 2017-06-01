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
                <input id="keywords" name="keywords" class="control-text" type="text" placeholder="团购名称"/>
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
            {text:'团购审核',value:'0'},
            {text:'审核日志',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/sa/grouponAudit/list";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/sa/grouponAudit/doneList";
	        }
    });

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'操作',dataIndex:'',width:120,renderer : function(value,rowObj){
                var viewStr = Search.createLink({
                    text: '查看',
                    href: '${ctx}/admin/sa/promotionGroupon/toSave?promotionId=' + rowObj.promotionId
                });

                    var editStr = "<a href=\"javascript:pass(\'" + rowObj.auditId + "')\">同意</a>&nbsp;&nbsp;&nbsp;";
                    editStr += "<a href=\"javascript:refuse(\'" + rowObj.auditId + "')\">拒绝</a>&nbsp;&nbsp;&nbsp;";

                return editStr + "&nbsp;" + viewStr;
            }},
            {title:'编号',dataIndex:'promotionId',width:50},
            {title:'团购名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'虚拟销售量',dataIndex:'grouponInitSaleNum',width:160},
            {title:'团购最小量',dataIndex:'grouponInitSaleNum', width:80},
            {title:'团购最大量',dataIndex:'grouponMaxSaleNum', width:60},
            {title:'每人限购量',dataIndex:'grouponPersonQuotaNum', width:60},
            {title:'起始时间',dataIndex:'enableStartTime',width:135,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'结束时间',dataIndex:'enableEndTime',width:135,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'状态',dataIndex:'statusCd',width:50,renderer:function(val, rowObj){
                if(val != null && val == 0){
                    return "禁用";
                } else {
                    return "启用";
                }
            }},
            {title:'访问地址',dataIndex:'', width:170, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML("/m/groupon/" + rowObj.encryptCode + ".html");
            }}
        ];
        var store = Search.createStore('/admin/sa/grouponAudit/grid_json',{pageSize:15});
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
     * 同意团购
     * @param auditId
     */
    function pass(auditId){
        if(!auditId){
            return;
        }
        BUI.Message.Confirm('确定要同意该团购吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/grouponAudit/pass/'+auditId,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("团购审核通过！");
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
            BUI.Message.Alert("请选择要同意的团购!");
            return false;
        }
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].auditId);
        }

        BUI.Message.Confirm('确定要批量同意团购申请吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/grouponAudit/passAll',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedContentIds},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已同意了团购申请!");
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
     * 拒绝团购申请
     * @param auditId
     */
    function refuse(auditId){
        if(!auditId){
            return;
        }
        BUI.Message.Confirm('确定要拒绝该团购吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/grouponAudit/refuse/'+auditId,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已拒绝了团购申请!");
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
            BUI.Message.Alert("请选择要拒绝的团购!");
            return false;
        }
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].auditId);
        }

        BUI.Message.Confirm('确定要批量拒绝团购申请吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/couponAudit/refuseAll',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedContentIds},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("已拒绝了团购申请!");
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