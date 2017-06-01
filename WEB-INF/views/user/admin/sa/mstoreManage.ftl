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
                	<input type="hidden" id="mstoreStatusCd" name="mstoreStatusCd"/>
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
                            <label class="control-label">上级微店主手机号：</label>
                            <div class="controls">
                                <input type="text" name="parentUserPhone" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
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
                        <div class="control-group span10">
                            <label class="control-label">所属分公司：</label>
                            <div class="controls">
                                <select class="span4" name="branchId" id="branchId">
                                	<option value="">-- 请选择 --</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">所属办事处：</label>
                            <div class="controls">
                                <select class="span4" name="officeId" id="officeId">
                                	<option value="">-- 请选择 --</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">微店主状态：</label>
                            <div class="controls">
                                <select name="statusCd">
                                	<option value=1>启用</option>
                                	<option value=0>禁用</option>
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

    <div id="bulkChanges" class="hide">
        <div class="form-horizontal">
            <div class="form-content">
                <div class="row">
		            <div class="control-group">
		                <label class="control-label">所属大区：</label>
		                <div class="controls">
		                    <select class="span4" name="regionId1" id="regionId1">
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
		                    <select class="span4" name="branchId1" id="branchId1">
		                    	<option value="">-- 请选择 --</option>
		                    </select>
		                </div>
		            </div>
		        </div>
		        <div class="row">
		            <div class="control-group">
		                <label class="control-label">所属办事处：</label>
		                <div class="controls">
		                    <select class="span4" name="officeId1" id="officeId1">
		                    	<option value="">-- 请选择 --</option>
		                    </select>
		                </div>
		            </div>
		        </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">返利：</label>
                        <div class="controls control-row-auto">
                            <input id="commissionRate" name="commissionRate" class="input-small control-text">%<br/>
                            <span style="display:none;" id="errorContent" class="x-field-error x-form-error"><span class="x-icon x-icon-mini x-icon-error">!</span><label class="x-field-error-text" id="erroText"></label></span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
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
            {text:'微店主列表',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

	BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
	        {title:'ID',dataIndex:'userId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='userId' value='" + value + "'>";
        	}},
        	{title:'微店主手机号',dataIndex:'phone',width:100,renderer : function(value, rowObj){
                return '<a href="${ctx}/admin/sa/mstore/toMstoreIndex?userId='+rowObj.userId+'">'+value+'</a>';
        	}},
         	{title:'微店名称',dataIndex:'mstoreName',width:120, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
         	{title:'姓名',dataIndex:'userName',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'身份证号',dataIndex:'identityId',width:180, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'大区',dataIndex:'regionName',width:120, renderer : function(value, rowObj){
	        	return app.grid.format.encodeHTML(value);
            }},
            {title:'分公司',dataIndex:'branchName',width:120, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'办事处',dataIndex:'officeName',width:120, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'微店等级',dataIndex:'mstoreLevelName',width:70, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'微店状态',dataIndex:'mstoreStatusText',width:100, renderer : function(value, rowObj){
                return value;
            }},
            {title:'审核通过时间',dataIndex:'auditTime',width:140, renderer : function(value, rowObj){
            	if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
            {title:'微店销售金额',dataIndex:'totalSalesAmt',width:120, renderer : function(value, rowObj){
                if(null!=value){return value;}
            }}, 
            {title:'上级会员',dataIndex:'parentUserPhone',width:120, renderer : function(value, rowObj){
                if(null!=value){return value;}
            }} 
        ];
        var store = Search.createStore('${ctx}/admin/sa/mstore/grid_json2',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar:{
                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                items:[
                {btnCls : 'button button-small',text:'批量修改',handler:update},
                {btnCls : 'button button-small',text:'导出',handler:exportMstore},
                {btnCls : 'button button-small',text:'导出二维码',handler:batchExportUserRqCodes}
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

    function update(){
    	var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择微店主!");
                return false;
            }
        	var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].userId);
            }
        	userIds= selectedContentIds.join(",");
        	
            BUI.use('bui/overlay',function(Overlay){
          	var dialog = new Overlay.Dialog({
            title:'批量修改',
            width:400,
            height:300,
            closeAction : 'destroy', //每次关闭dialog释放
            //配置DOM容器的编号
            contentId:'bulkChanges',
            success:function () {
            	if(	$("#erroText").html()==null || 	$("#erroText").html()==''){
            		  var regionId=$('#regionId1').val();
		              var branchId=$('#branchId1').val();
		              var officeId=$('#officeId1').val();
		              var commissionRate=$("#commissionRate").val();
		              
		              app.ajax('${ctx}/admin/sa/mstore/update1',{
		              regionId:regionId,branchId:branchId,officeId:officeId,userIds:userIds,commissionRate:commissionRate
		              },function(data){
		              		if(data){
		              			app.showSuccess("修改成功");
		              			location.href=location.href;
		              		}
		              });
		              
		              this.close();
            	}
            }
          });
          dialog.show();
          });
    }

    $(function(){
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
    	
    	//大区选择1
	    $("#regionId1").on('change',function(){
	    		var regionId = $(this).val();
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					$('#branchId1').empty();
	    					$("#branchId1").append("<option value=''>-- 请选择 --</option>");
	    					if(data.rowCount && data.rowCount >0){
	                            $.each(data.rows, function(i, row){
	                                $("#branchId1").append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
	                            });
	                        }
	    				}
	    			});
	    		}
	    	});
	    	
	    //分公司选择1
	    $("#branchId1").on('change',function(){
    		var branchId = $(this).val();
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					$('#officeId1').empty();
	    				$("#officeId1").append("<option value=''>-- 请选择 --</option>");
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId1').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
	    
    });
    
    //批量导出微店主二维码
    function batchExportUserRqCodes(){
    	var selectedContent= grid.getSelection();
        var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].userId);
        }
    	userIds= selectedContentIds.join(",");
    	var params=$("#searchForm").serialize();
        location.href="${ctx}/admin/sa/user/batchExportUserRqCodes?"+params+"&userIds="+userIds+"&t=2";
		BUI.Message.Alert("导出成功");
    }
    
    //导出
	function exportMstore(){
		var userIds='';
		var selectedContent = grid.getSelection();
		var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].userId);
        }
    	userIds= selectedContentIds.join(",");
		var params=$("#searchForm").serialize();
		location.href ="${ctx}/admin/sa/mstoreExcel/exportMstore?"+params+"&userIds="+userIds;
    	BUI.Message.Alert("导出成功");
	}
	
	$("#commissionRate").unbind("input");
	$("#commissionRate").bind("input",function(){
		var val=$(this).val();
		//验证是否为数字
		if(isNaN(val)){
			$("#errorContent").css("display","block");
			$("#erroText").html("请输入数字类型！");
			return;
		}else{
			//数字必须在0到100之间
			if(val<0 || val>100){
				$("#errorContent").css("display","block");
				$("#erroText").html("返利不能大于100！");
				return;
			}
		}
		$("#erroText").html('');
		$("#errorContent").css("display","none");
	});
</script>
</body>
</html>  