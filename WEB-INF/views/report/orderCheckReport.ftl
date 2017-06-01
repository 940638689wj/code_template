<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
	<#include "../../../includes/sa/header.ftl"/>
	<#--
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
	-->
</head>
<body>
<div class="container">
    <div class="title-bar">
    	<div class="title-text">订单核报报表
    	</div>
        <div id="tab">
        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                        	<input type="hidden" id="reportedStatusCd" name="reportedStatusCd" value="${reportedStatusCd!}"/>
                        	<span class="mr5">下单时间：</span>
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>
                        
                        <div class="pull-left">
                            <input type="text" id="orderNum" name="orderNum" class="control-text" placeholder="订单号查询">
                        </div>
                        
                        <div class="pull-left">
                        	<button id="user_search" name="user_search" type="submit" class="button button-primary ml">搜索</button>
                            <button id="export" type="button"class="button button-primary" >导出</button>
                            <#if reportedStatusCd??&&reportedStatusCd=="0">
	                            <button id="agree" name="agree" onclick="auditAgreed();" type="button" class="button button-primary">批量审核</button>
                            <#elseif reportedStatusCd??&&reportedStatusCd=="1">
                            	<button id="agree" name="agree" onclick="auditAgreed();" type="button" class="button button-primary">批量审核</button>
	                            <button id="refuse" name="refuse" onclick="auditRefused();" type="button" class="button button-primary">撤销审核</button>
                            <#else>
                            	<button id="refuse" name="refuse" onclick="auditRefused();" type="button" class="button button-primary">撤销审核</button>
                            </#if>
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
		location.href ="${ctx}/report/orderCheckReport/exportOrderCheckReport?"+params;
    	BUI.Message.Alert("导出成功");
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
        	{text:'未核报',value:'0'},
            {text:'待核报',value:'1'},
            {text:'已核报',value:'2'}
        ]
    });
    var reportedStatusCd=0;
    tab.setSelected(tab.getItemAt(${reportedStatusCd!'0'}));
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
        	reportedStatusCd=item.get('value');
        	//$("#reportedStatusCd").val(reportedStatusCd);
	        window.location.href = "${ctx}/report/orderCheckReport/list?reportedStatusCd="+reportedStatusCd;
	    });
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
	            var editStr='';
	            if(rowObj.reportedStatusCd==0 || rowObj.reportedStatusCd==1){
	            	editStr = '&nbsp;<a href=\'javascript:auditAgreed("'+rowObj.orderId+'")\'>审核</a>';
	            }
	            return editStr;
	        }},
	        {title:'订单id',dataIndex:'orderId',width:100,visible:false,renderer : function(value,rowObj){
	            return "<input type='text' name='orderId' value='" + value + "'>";
	        }},
			{title : '订单号',dataIndex :'orderNumber',width:200, renderer:function(value,rowObj){
				var str='<a href="${ctx}/report/orderDetailReport/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
	            return str;
			}},
			{title : '订单状态',dataIndex :'orderStatusCd',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '支付状态',dataIndex :'orderPayStatusCd',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '实付金额',dataIndex :'orderPayAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '优惠券抵扣金额',dataIndex :'orderCouponDiscountAmt',width:100, renderer:function(value,rowObj){				
				return value.toFixed(2);
			}},
			{title : '积分抵扣金额',dataIndex :'orderPointDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '红包抵扣金额',dataIndex :'orderRedEnveDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '购酒券抵扣金额',dataIndex :'orderBalanceDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '分销收入抵扣金额',dataIndex :'orderCommDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '微店收入抵扣金额',dataIndex :'orderDistriDiscountAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '支付类型',dataIndex :'orderPayModeCd',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '支付方式',dataIndex :'orderPayWayCd',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '交易号',dataIndex :'serialNo',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '支付时间',dataIndex :'payamtTime',width:200, renderer:function(value,rowObj){
				if(null!=value){
					return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
				}
			}}
		];
		
		var store = Search.createStore("${ctx}/report/orderCheckReport/grid_json?reportedStatusCd=${(reportedStatusCd)!'0'}",{pageSize:15});
		//var reportedStatusCd=$("#reportedStatusCd").val();
		var gridCfg = Search.createGridCfg(columns,
			{   width: '100%',
				height:getContentHeight(),
				// 顶部工具栏
	            //tbar:{
	                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
	                //items:[
	                //	{btnCls : 'button button-primary ml',text:'批量审核',handler:function(e){auditAgreed();}},
	                //	{btnCls : 'button button-primary ml',text:'撤销审核',handler:function(e){auditRefused();}}
	                
	                //]
	            //},
	            // 底部工具栏
	            bbar:{
	                // pagingBar:表明包含分页栏
	                pagingBar:true
	            },
	            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
			});
	
		var search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            btnId:'user_search'
		});
			
		grid = search.get('grid');
		grid.render();
	});
		
	
	function auditAgreed(orderId){
    	var orderIds='';
    	if(null!=orderId && ''!=orderId){
    		orderIds= orderId;
    	}else{
    		var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择申请!");
                return false;
            }
            if(selectedContent.length < 2){
                BUI.Message.Alert("选择的申请条数不能低于2条!");
                return false;
            }
        	var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].orderId);
            }
        	orderIds= selectedContentIds.join(",");
        	
    	}
    	BUI.Message.Confirm("是否确认审核？",function(){
	    	app.ajax('${ctx}/report/orderCheckReport/update',{
	              orderIds:orderIds,f:'s'
	              },function(data){
	              		if(app.ajaxHelper.handleAjaxMsg(data)){
	              			app.showSuccess("审核成功");
	              			location.href=location.href;
	              		}
	              });
        });
    }

    function auditRefused(){
    	var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择申请!");
            return false;
        }
    	BUI.Message.Confirm("是否确认撤销审核？",function(){
    		var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择订单!");
                return false;
            }
              
        	var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].orderId);
            }
        	orderIds= selectedContentIds.join(",");
        	app.ajax('${ctx}/report/orderCheckReport/update',{
              orderIds:orderIds,f:'r'
              },function(data){
              		if(app.ajaxHelper.handleAjaxMsg(data)){
              			app.showSuccess("已撤销审核！");
              			location.href=location.href;
              		}
              });
    	},'question');
    }
		
</script>
</body>
</html>  