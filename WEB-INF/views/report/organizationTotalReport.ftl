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
		                    <span class="mr5">所属大区：</span>
		                    <select name="regionId" id="regionId" class="span4">
					            <option value="">-- 请选择 --</option>
					            <#if orgList?? && orgList?has_content>
					                <#list orgList as item>
					                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
					                </#list>
					            </#if>
					        </select>
					        
		                    <span class="mr5">所属分公司：</span>
		                    <select name="branchId" id="branchId" class="span4">
					            <option value="">-- 请选择 --</option>
					        </select>
					        
		                    <span class="mr5">所属办事处：</span>
		                    <select name="officeId" id="officeId" class="span4">
					            <option value="">-- 请选择 --</option>
					        </select>
	                    </div>
                    	<div class="pull-left">
                    		&nbsp;&nbsp;&nbsp;&nbsp;
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
		//大区选择
	    $("#regionId").on('change',function(){
	    		var regionId = $(this).val();
	    		$('#branchId').empty();
	    		$("#branchId").append("<option value=''>-- 请选择 --</option>");
	    		$('#officeId').empty();
	    		$("#officeId").append("<option value=''>-- 请选择 --</option>");
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/report/organizationTotalReport/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					if(data.rowCount && data.rowCount >0){
	                            $.each(data.rows, function(i, row){
	                                $("#branchId").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
	                            });
	                        }
	    				}
	    			});
	    		}
	    	});
	    	
	    //分公司选择
	    $("#branchId").on('change',function(){
    		var branchId = $('#branchId').val();
    		$('#officeId').empty();
	    	$("#officeId").append("<option value=''>-- 请选择 --</option>");
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/report/organizationTotalReport/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
</script>
<script type="text/javascript">
	//导出
	$("#export").click(function(){
		var params=$("#searchForm_select").serialize();
		location.href ="${ctx}/report/organizationTotalReport/exportOrganizationTotalReport?"+params;
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
        	{text:'组织发展统计',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	BUI.use(['common/search','common/page'],function (Search) {
	var columns = [
			{title : '大区',dataIndex :'areaName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '分公司',dataIndex :'branchName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '办事处',dataIndex :'officeName',width:100, renderer:function(value,rowObj){
				return value;
			}},
			{title : '销售额',dataIndex :'txAmt',width:100, renderer:function(value,rowObj){
				return value.toFixed(2);
			}},
			{title : '门店数',dataIndex :'storeCnt',width:100, renderer:function(value,rowObj){				
				if(value){
					return value;
				}else{
					return 0;
				}
			}},
			{title : '微店主数',dataIndex :'mStoreCnt',width:100, renderer:function(value,rowObj){
				if(value){
					return value;
				}else{
					return 0;
				}
			}},
			{title : '会员数',dataIndex :'memberCnt',width:100, renderer:function(value,rowObj){
				if(value){
					return value;
				}else{
					return 0;
				}
			}},
			{title : '购买会员数',dataIndex :'txMemberCnt',width:100, renderer:function(value,rowObj){
				if(value){
					return value;
				}else{
					return 0;
				}
			}}
		];
		
		var store = Search.createStore('${ctx}/report/organizationTotalReport/grid_json',{pageSize:15});
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