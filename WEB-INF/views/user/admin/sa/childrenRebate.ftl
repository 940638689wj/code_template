<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
	<#include "../../../includes/sa/header.ftl"/>
    <style>
    #rebateSearchForm.form-horizontal .controls{line-height:20px;}
    </style>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="userinfo-box">
            <div class="pic">
            	<img src="<#if (mstoreDTO.headPortraitUrl)??>${(mstoreDTO.headPortraitUrl)!?html}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100">
            </div>
            <div class="code"><img src="${ctx}/admin/sa/user/getQrImg?userId=${mstoreDTO.userId}"  width="100" height="100"></div>
            <ul>
                <li>微店主手机号：${(mstoreDTO.phone)!?html}</li>
                <li>微店名称：${(mstoreDTO.mstoreName)!?html}</li>
                <li>微店等级：${(mstoreDTO.mstoreLevelName)!?html}</li>
                <li>审核通过时间：${((mstoreDTO.auditTime)?string("yyyy-MM-dd hh:mm"))!}</li>
                <li>销售总额：${(mstoreDTO.totalSalesAmt)!0}</li>
            </ul>
        </div>
    </div>
    <div class="content-top">
            <form id="rebateSearchForm" class="form-horizontal">
            	<input type="hidden" name="userId" value="${(mstoreDTO.userId)!?html}"/>
                <div class="row">
                    <div class="control-group control-row-auto">
                        <div class="controls bui-form-group" data-rules="{dateRange : true} ">
                            <input type="text" id="startDate" name="startDate" class="calendar control-text">
                            <span class="mr5">至</span>
                            <input type="text" id="endDate" name="endDate" class="calendar control-text">
                        </div>
                        <button id="btnSearch1" type="submit" class="button button-primary">搜索</button>
                        <input type="button" value="导出" class="button ml" onclick="exportDist()"/>
                    </div>
                </div>
            </form>
    </div>
        <div class="content-body">
            <div id="grid2"></div>
        </div>
</div>
</body>

<script type="text/javascript">
	
	BUI.use('common/page');
	var grid=null;
	
	BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'ID',dataIndex:'distributionDetailId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='scoreDetailId' value='" + value + "'>";
        	}},
            {title:'时间',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
            	if(null!=value){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
            }},
            {title:'返利金额',dataIndex:'rebateAmt',width:100, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;};
            }},
            {title:'订单',dataIndex:'orderNumber',width:180, renderer : function(value, rowObj){
            	value='<a href="${ctx}/admin/sa/order/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
                return value;
            }}
        ];
        var store = Search.createStore('/admin/sa/mstore/grid_json4',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格和拖拉列的大小
            width:'100%',
            height: getContentHeight(),
        });
        
        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg,
                    formId:"rebateSearchForm",
                    btnId:"btnSearch1",
                    gridId:"grid2"
                    //
                });
        grid = search.get('grid');
        grid.render();

    });
    
	function exportDist(){
		var formSerialize = $("#rebateSearchForm").serialize();
		location.href ="${ctx}/admin/sa/userExcel/exportDist?t=3&"+formSerialize;
    	BUI.Message.Alert("导出成功");
    }
    
</script>
</body>
</html>