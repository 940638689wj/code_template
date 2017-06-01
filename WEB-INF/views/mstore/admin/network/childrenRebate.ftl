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
            <div class="code"><img src="${ctx}/admin/network/mstore/getQrImg?userId=${(mstoreDTO.userId)!}"  width="100" height="100"></div>
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
        <form id="chform" class="form-horizontal">
        	<input type="hidden" name="userId" value="${(mstoreDTO.userId)!?html}"/>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls bui-form-group" data-rules="{dateRange : true}">
                        <input type="text" id="startDate" name="startDate" class="calendar control-text">
                        <span class="mr5">至</span>
                        <input type="text" id="endDate"  name="endDate" class="calendar control-text">
                    </div>
                    <button id="sub1" type="submit" class="button button-primary">搜索</button>
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

 $.fn.type=function(key){
		var orderStatus={1:'发展分销返利',2:'URL返利',3:'下级微店主返利'};
		return orderStatus[key];
	}
	
    BUI.use('common/page');
    var grid=null;
    
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
	        {title:'ID',dataIndex:'distributionDetailId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='distributionDetailId' value='" + value + "'>";
        	}},
        	{title:'时间',dataIndex:'createTime',width:140, renderer : function(value, rowObj){
            	if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
            {title:'返利类型',dataIndex:'distributionTypeCd',width:100,renderer : function(value, rowObj){
        		return $.fn.type(value);
        	}},
        	{title:'返利金额',dataIndex:'rebateAmt',width:100,renderer : function(value, rowObj){
                if(null!=value){return "￥"+value;}
        	}},
         	{title:'订单',dataIndex:'orderNumber',width:180, renderer : function(value, rowObj){
         		value='<a href="${ctx}/admin/sa/order/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
         		return value;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/network/mstore/grid_json4',{pageSize:15});
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
            formId :"chform",
            btnId:"sub1",
            gridId:"grid2"
        });
        grid = search.get('grid');
        grid.render();
    });

	function exportDist(){
    	var startDate=$("#startDate").val();
    	var endDate=$("#endDate").val();
		location.href ="${ctx}/admin/network/mstoreExcel/exportDist?startDate="+startDate+"&endDate="+endDate+"&userId=${(mstoreDTO.userId)!}";
    	BUI.Message.Alert("导出成功");
    }

</script>
</body>
</html>  