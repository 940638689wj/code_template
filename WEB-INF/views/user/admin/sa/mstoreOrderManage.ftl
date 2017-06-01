<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
	<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
    </div>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <form>
                    <input class="control-text" type="text" placeholder="查询"/>
                    <button></button>
                </form>
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <div class="row">
                        <div class="control-group span13">
                            <label class="control-label">下单时间：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input name="startDate" class="control-text input-small calendar" type="text"><label>&nbsp;-&nbsp;</label>
                                <input name="endDate" class="control-text input-small calendar" type="text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">微店主手机号：</label>
                            <div class="controls">
                                <input type="text" name="phone" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">微店名称：</label>
                            <div class="controls">
                                <input type="text" name="mstoreName" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">所属大区：</label>
                            <div class="controls">
                                <select class="span4" name="regionId" id="regionId">
	                                <option value="">-- 请选择 --</option>
						            <#if orgList?? && orgList?has_content>
						                <#list orgList as item>
						                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
						                </#list>
						            </#if>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">所属分公司：</label>
                            <div class="controls">
                                <select class="span4" name="branchId" id="branchId">
                                	<option value="">-- 请选择 --</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">所属办事处：</label>
                            <div class="controls">
                                <select class="span4" name="officeId" id="officeId">
                                	<option value="">-- 请选择 --</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
	var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'微店订单列表',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
	
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
	        {title:'ID',dataIndex:'userId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='userId' value='" + value + "'>";
        	}},
         	{title:'微店名称',dataIndex:'mstoreName',width:120, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
        	{title:'微店主手机号',dataIndex:'phone',width:100,renderer : function(value, rowObj){
                return '<a href="${ctx}/admin/sa/mstore/toMstoreIndex?userId='+rowObj.userId+'">'+value+'</a>';
        	}},
         	{title:'订单号',dataIndex:'orderNumber',width:170, renderer : function(value, rowObj){
         		//return app.grid.format.encodeHTML(value);
         		return '<a href="${ctx}/admin/sa/order/toOrderInfo?orderId='+rowObj.orderId+'">'+value+'</a>';
            }},
            {title:'订单状态',dataIndex:'orderStatusCd',width:80, renderer : app.grid.format.randerMstoreOrderStatus},
            {title:'订单支付状态',dataIndex:'orderPayStatusCd',width:90, renderer : function(value, rowObj){
	        	if(value==1){
	        		return "未支付";
	        	}else if(value==2){
	        		return "已支付";
	        	}
            }},
            {title:'下单时间',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
                if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
            {title:'订单总额',dataIndex:'orderTotalAmt',width:120, renderer : function(value, rowObj){
                if(null!=value){
                	return value;
                }
            }},
            {title:'订单优惠总额',dataIndex:'orderDiscountAmt',width:120, renderer : function(value, rowObj){
                if(null!=value){
                	return value;
                }
            }},
            {title:'佣金',dataIndex:'commissionAmt',width:120, renderer : function(value, rowObj){
                if(null!=value){
                	return value;
                }
            }},
            {title:'返给上级金额',dataIndex:'commissionAmt',width:120, renderer : function(value, rowObj){
                if(null!=value){
                	return value;
                }
            }},
            {title:'首单奖励',dataIndex:'rewardAmt',width:120, renderer : function(value, rowObj){
                if(null!=value){
                	return value;
                }
            }},
            {title:'上级会员',dataIndex:'parentPhone',width:120, renderer : function(value, rowObj){
                if(null!=value){
                	return value;
                }
            }},
            {title:'所属大区',dataIndex:'regionName',width:120, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'所属分公司',dataIndex:'branchName',width:120, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'所属办事处',dataIndex:'officeName',width:120, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/mstore/grid_json6',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar:{
                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                items:[
                {btnCls : 'button button-small',text:'导出',handler:exportMstoreOrders}
                ]
            },
			width: '100%',
            height: getContentHeight()
        });
        
        var search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();
    });

    var mask;
    $('.title-bar-side .search-bar input').on('focus',function(){
        var $this = $(this);
        var searchCon = $this.closest('.title-bar-side').find('.search-content');
        $this.addClass("focused");
        if(!mask)
            mask = $('<div></div>').css({
                'position':'absolute',
                'left':0,
                'top':0,
                'width':'100%',
                'height':'100%'
            }).appendTo(document.body);
        searchCon.show(400);
        mask.on('click',function(){
            $this.removeClass("focused");
            mask.remove();
            mask = null;
            searchCon.hide(400);
        });
    });

    //大区选择
	    $("#regionId").on('change',function(){
	    		var regionId = $(this).val();
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					$('#branchId').empty();
	    					$("#branchId").append("<option value=''>-- 请选择 --</option>");
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
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					$('#officeId').empty();
	    				$("#officeId").append("<option value=''>-- 请选择 --</option>");
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
    	
    //导出
	function exportMstoreOrders(){
		var orderNumbers='';
    	var selectedContent= grid.getSelection();
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].orderNumber);
        }
    	orderNumbers= selectedContentIds.join(",");
		var params=$("#searchForm").serialize();
		location.href ="${ctx}/admin/sa/mstoreExcel/exportMstoreOrders?"+params+"&orderNumbers="+orderNumbers;
    	BUI.Message.Alert("导出成功");
	}
</script>
</body>
</html>  