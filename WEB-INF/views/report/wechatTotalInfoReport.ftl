<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
	<#include "../../../includes/sa/header.ftl"/>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
        
        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group control-row-auto">
	                <div class="controls ml0">
	                    <div class="pull-left">
		                    <span class="mr5">渠道：</span>
		                    <#assign storeTypeList=storeTypeList?default("")/>
	                        <#if storeTypeList?? && storeTypeList?has_content>
		                        <#list storeTypeList as list>
		                        	<#if list.codeId!='1'>
				                        <label>
				                            <input type="checkbox" id="channelType" name="channelType" value=${list.codeId} />${list.codeCnName}
				                        </label>
				                        &nbsp;&nbsp;
			                        </#if>
		                        </#list>
	                        </#if>
	                    </div>
                    	<div class="pull-left">
                    		<input name="storeName" id="storeName" class="control-text" placeholder="店铺名称">
                    	</div>
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>
                        <div class="pull-left">
                        	<button id="user_search" name="user_search" type="submit" class="button button-primary ml">搜索</button>
                            <button id="export" type="button"class="button button-primary" >导出</button>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
	//导出
	$("#export").click(function(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/report/wechatTotalInfoReport/exportWechatTotalInfoReport?"+params;
    	BUI.Message.Alert("导出成功");
	});
</script>
<script type="text/javascript">
	$(function(){
		var x = 5;
	    var y = 5;
	    $(".qrCodeSmallImg").live('mouseover', function (ev) {
	        var curTrigger = $(this);
	        var channelId = curTrigger.attr("data-store-id");
	        var rqCodeImageGenerateUrl = "${ctx}/report/wechatTotalInfoReport/viewWxQrCode";
	        rqCodeImageGenerateUrl += "?channelId=" + channelId;
	        var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='" + rqCodeImageGenerateUrl + "'><\/div>"; //创建 div 元素
	        $("body").append(tooltip);	//把它追加到文档中
	        $("#tooltip").css({
	            "top": (ev.pageY + y) + "px",
	            "left": (ev.pageX + x) + "px"
	        }).show("fast");	  //设置x坐标和y坐标，并且显示
	    }).live('mouseout', function () {
	        $("#tooltip").remove();	 //移除
	    }).live('mouseover', function (e) {
	        $("#tooltip").css({
	            "top": (e.pageY + y) + "px",
	            "left": (e.pageX + x) + "px"
	        });
	    });
	});
</script>
<script type="text/javascript">
	var grid;
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'扫码关注统计',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '渠道id',dataIndex :'channelId',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '名称',dataIndex :'storeName',width:200, renderer:function(value,rowObj){
				return value;
			}},
			{title : '渠道',dataIndex :'channelTypeDesc',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '二维码',dataIndex :'channelId',width:100, renderer:function(value,rowObj){
				return '<img data-store-item-no="' + value + '" data-store-id="'+value+'" class="qrCodeSmallImg" src="${ctx}/qrCode/generate?content=test" style="width:30px;height: 30px;cursor: pointer;" />';
			}},
			{title : '扫码关注数量',dataIndex :'hasFollewedCnt',width:100, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '取消关注数量',dataIndex :'cancelFollowedCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '剩余关注数量',dataIndex :'currentFollowedCnt',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '扫码关注并注册数量',dataIndex :'followedRegCnt',width:100, renderer:function(value,rowObj){
				return value;
			}}
		];
		
		var store = Search.createStore('${ctx}/report/wechatTotalInfoReport/grid_json',{pageSize:15});
		var gridCfg = Search.createGridCfg(columns,
			{   width: '100%',
				height:getContentHeight(),
	            // 底部工具栏
	            bbar:{
	                // pagingBar:表明包含分页栏
	                pagingBar:true
	            },
	            plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
			});
	
		var search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            btnId:'user_search'
		});
		grid = search.get('grid');
	});
	
</script>
</body>
</html>  