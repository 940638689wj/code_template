<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="userinfo-box">
            <div class="pic">
            	<img src="<#if (mstoreDTO.headPortraitUrl)??>${(mstoreDTO.headPortraitUrl)!?html}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100">
            </div>
            <div class="code"><img src="${ctx}/admin/network/mstore/getQrImg?userId=${mstoreDTO.userId}"  width="100" height="100"></div>
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
        <form id="fiform" class="form-horizontal">
        	<input type="hidden" name="userId" value="${(mstoreDTO.userId)!?html}"/>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls bui-form-group" data-rules="{dateRange : true}">
                    
                        <input type="text" name="startDate" id="startDate" class="calendar control-text">
                        <span class="mr5">至</span>
                        <input type="text" name="endDate" id="endDate" class="calendar control-text">
                    </div>
                    <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                    
                    <input type="button" value="导出" class="button ml" onclick="exportReward()"/>
                </div>
            </div>
        </form>
    </div>
    <div class="content-body">
        <div id="grid3"></div>
    </div>
</div>
</body>

<script type="text/javascript">
    BUI.use('common/page');
    var grid=null;
    
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
	        {title:'ID',dataIndex:'rewardDetailId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='rewardDetailId' value='" + value + "'>";
        	}},
        	{title:'时间',dataIndex:'createTime',width:140, renderer : function(value, rowObj){
            	if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
        	{title:'奖励金额',dataIndex:'rewardAmt',width:100,renderer : function(value, rowObj){
                if(null!=value){return "￥"+value;}
        	}},
         	{title:'订单',dataIndex:'orderNumber',width:180, renderer : function(value, rowObj){
         		value='<a href="${ctx}/admin/sa/order/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
         		return value;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/network/mstore/grid_json5',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格和拖拉列的大小
            width:'100%',
            height: getContentHeight(),
			width: '100%',
            height: getContentHeight()
        });
        
        var search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'fiform',
            btnId:"btnSearch",
            gridId:"grid3"
        });
        grid = search.get('grid');
        grid.render();
    });
    
    function exportReward(){
    	var startDate=$("#startDate").val();
    	var endDate=$("#endDate").val();
		location.href ="${ctx}/admin/network/mstoreExcel/exportRew?startDate="+startDate+"&endDate="+endDate+"&userId=${(mstoreDTO.userId)!}";
    	BUI.Message.Alert("导出成功");
    	return;
    }

</script>
</body>
</html>  