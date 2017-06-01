<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
	<script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script> 
	<script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script src="${staticPath}/admin/js/echarts.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
        
        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controlscontrol-row-auto  ml0">                      
                                    
                        <!--input type="hidden" id="originPlatformCd" name="originPlatformCd"-->
                        
                      
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                        <label class="control-label control-label-auto mr30">收款总额：<span class="red" id="orderTxCnts">￥${total}</span></label>
                    </div>
                </div>
            </div>
        </form>
    </div>
	
	<div class="content-body">
        <div id="grid"></div>
	</div>
</div>


<script type="text/javascript">
	//导出
	function generateAllReport(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/admin/sa/report/payCount/exportPayCount?"+params;
    	BUI.Message.Alert("导出成功");
	};
	
</script>
<script type="text/javascript">
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'收款单',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			
			{title : '订单号',dataIndex :'orderNumber',width:200, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '支付完成时间',dataIndex :'orderPayTime',width:200, renderer: BUI.Grid.Format.datetimeRenderer},
			{title : '支付金额',dataIndex :'orderPayAmt',width:200, renderer:function(value,rowObj){				
				return value;
			}},
			
			{title : '支付方式',dataIndex :'codeCnName',width:200, renderer:function(value,rowObj){				
				return value;
			}},
			{title : '付款会员',dataIndex :'phone',width:200, renderer:function(value,rowObj){
					return value;
			
			}}
		];
		
				
		var store = Search.createStore('${ctx}/admin/sa/report/payCount/grid_json',{pageSize:20});
		var gridCfg = Search.createGridCfg(columns,{
			tbar: {
                items: [
                    {text: '导出全部报表', btnCls: 'button button-small', handler: generateAllReport}
                ]
            },
			plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
			width: '100%',
			height:	getContentHeight(),
            // 底部工具栏,pagingBar:表明包含分页栏
            //bbar:{
              //  pagingBar:true
            //}
		});
	
        search = new Search({
			gridId:'grid',
			store : store,
			gridCfg : gridCfg,
			formId:'searchForm_select',
            //btnId:'user_search'
		});
        var grid = search.get('grid');
        grid.render();





    });
    
  
	
	

</script>

</body>
</html>  