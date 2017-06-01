<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery.regionMgr.js" xmlns:form="http://www.w3.org/1999/html"></script>
</head>
<body>

    <div class="title-bar">
        <div id="tab"></div>
    </div>

	<div id="content" class="hide">
      <form class="form-horizontal">
          <div class="row">
            <div class="control-group span10">
                <label class="control-label">所属大区：</label>
                <div class="controls">
              <select name="regionId1" id="regionId1" class="span4" <#if org.orgLevelCd gt 0>disabled</#if> >
	            <option value="">-- 大区选择 --</option>
	            <#if org.orgLevelCd==3>
	            <option value="${(parent1.orgId)!}" selected="selected" >${(parent1.orgFullName)!}</option>
	            <#elseif org.orgLevelCd==2>
	            <option value="${(parent.orgId)!}" selected="selected" >${(parent.orgFullName)!}</option>
	            <#elseif org.orgLevelCd==1>
	            <option value="${(org.orgId)!}" selected="selected" >${(org.orgFullName)!}</option>
	            <#else>
	            <#if orgList?? && orgList?has_content>
	                <#list orgList as item>
	                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
	                </#list>
	            </#if>
	            </#if>
	        </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group span10">
                <label class="control-label">所属分公司：</label>
                <div class="controls">
           <select name="branchId1" id="branchId1" class="span4" <#if org.orgLevelCd gt 1>disabled</#if> >
	            <option value="">-- 分公司选择 --</option>
	            <#if org.orgLevelCd == 1>
	            <#list list as item>
	             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
	            </#list>
	            <#elseif org.orgLevelCd == 2>
	             <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
	           	 <#elseif org.orgLevelCd == 3>
	           	 <option value="${(parent.orgId)!}" selected="selected"  >${(parent.orgFullName)!}</option>
	            </#if>
	        </select>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group span10">
                <label class="control-label">所属办事处：</label>
                <div class="controls">
                    <select name="officeId1" id="officeId1" class="span4" <#if org.orgLevelCd gt 2>disabled</#if>>
			            <option value="">-- 办事处选择 --</option>
			            <#if org.orgLevelCd == 2>
			            <#list list as item>
			             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
			            </#list>
			            <#elseif org.orgLevelCd == 3>
			            <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
			            </#if>
	       			 </select>
                </div>
            </div>
        </div>
      </form>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" class="control-text" placeholder="门店名称" id="shortcut_storeName"/><button onclick="shortSearch()"><i class="icon-search"></i></button>
            </div>
            <div class="search-content">
            		<input type="hidden" name="storeId" value="${(parentId)!}">
                    <input type="hidden" name="sort" value="createDate desc">
                    <input type="hidden" name="chainStore" value="1">
                <form id="searchForm" name="searchForm" class="form-horizontal search-form">
                    <div class="row">
                        <div class="control-group span">
                            <label class="control-label">门店编码：</label>
                            <div class="controls">
                                <input id="storeNumber" name="storeNumber" class="control-text" >
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span">
                            <label class="control-label">门店名称：</label>
                            <div class="controls">
                                <input name="storeName" id="storeName" class="control-text" >
                            </div>
                        </div>
                    </div>
                   <!-- <div class="row">
                        <div class="control-group span">
                            <label class="control-label">门店属性：</label>
                            <div class="controls">
                                <input name="storePropertyCd" id="storePropertyCd" class="control-text" >
                            </div>
                        </div>
                    </div> -->
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">所属大区：</label>
                            <div class="controls">
                          <select name="regionId" id="regionId" class="span4" <#if org.orgLevelCd gt 0>disabled</#if> >
				            <option value="">-- 大区选择 --</option>
				            <#if org.orgLevelCd==3>
				            <option value="${(parent1.orgId)!}" selected="selected" >${(parent1.orgFullName)!}</option>
				            <#elseif org.orgLevelCd==2>
				            <option value="${(parent.orgId)!}" selected="selected" >${(parent.orgFullName)!}</option>
				            <#elseif org.orgLevelCd==1>
				            <option value="${(org.orgId)!}" selected="selected" >${(org.orgFullName)!}</option>
				            <#else>
				            <#if orgList?? && orgList?has_content>
				                <#list orgList as item>
				                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
				                </#list>
				            </#if>
				            </#if>
				        </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">所属分公司：</label>
                            <div class="controls">
                                 <select name="branchId" id="branchId" class="span4" <#if org.orgLevelCd gt 1>disabled</#if> >
				            <option value="">-- 分公司选择 --</option>
				            <#if org.orgLevelCd == 1>
				            <#list list as item>
				             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
				            </#list>
				            <#elseif org.orgLevelCd == 2>
				             <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
				           	 <#elseif org.orgLevelCd == 3>
				           	 <option value="${(parent.orgId)!}" selected="selected"  >${(parent.orgFullName)!}</option>
				            </#if>
				        </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">所属办事处：</label>
                            <div class="controls">
                                <select name="officeId" id="officeId" class="span4" <#if org.orgLevelCd gt 2>disabled</#if>>
						            <option value="">-- 办事处选择 --</option>
						            <#if org.orgLevelCd == 2>
						            <#list list as item>
						             <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
						            </#list>
						            <#elseif org.orgLevelCd == 3>
						            <option value="${(org.orgId)!}" selected="selected"  >${(org.orgFullName)!}</option>
						            </#if>
				       			 </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">门店星级：</label>
                            <div class="controls">
                                <select class="span4" name="storeLevelId" id="storeLevelId">
                                	<option value="">-- 请选择 --</option>
                                	<#if storeLevels??>
                                	<#list storeLevels as item>
                                		<option value="${(item.levelId)!}">${(item.levelName)!}</option>
                                	</#list>	
                                	</#if>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">门店状态：</label>
                            <div class="controls">
                                <select class="span3" name="statusCd" id="statusCd">
                                	<option value="">--请选择--</option>
                                	<option value="1">启用</option>
                                	<option value="0">冻结</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">允许自提：</label>
                            <div class="controls">
                            <select class="span3" name="isSelf" id="isSelf">
                                	<option value="">--请选择--</option>
                                	<option value="1">是</option>
                                	<option value="0">否</option>
                                </select>
                            </div>
                        </div>
                    </div>
                   <#--> <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">开店时间：</label>

                            <div class="controls bui-form-group " data-rules="{dateRange : true}">
                                <input name="beginTime" id="beginTime"
                                       data-tip="{text : '起始日期'}"
                                       class="input-small calendar control-text" type="text"><label>
                                &nbsp;-&nbsp;</label>
                                <input name="endTime" id="endTime"
                                       data-tip="{text : '结束日期'}"
                                       class="input-small calendar control-text" type="text">
                            </div>
                        </div>
                    </div> -->

                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" name="btnSearch" type="button" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="grid"></div>
    </div>

    <div>
        <input type="hidden"  name="storeIds" value=""/>

        <div id="storeTypeContent" class="well" style="display: none;">
            <label>选择门店类型：</label>
            <select name="storeTypeId" id="storeTypeId">
                <#if storeOtherTypeList?has_content>
                    <#list storeOtherTypeList as storeType>
                        <option value="${storeType.id}">${(storeType.name)!?html}</option>
                    </#list>
                </#if>
            </select>
        </div>
    </div>

    <div id="rqCodeLargeImageContainer" style="display: none">
        <div class="panel-body">
            <div><img src="<#--/rqCode/generate?content=test-->"></div>
        </div>
    </div>
<script type="text/javascript">
    var search;
    var grid;
    var Overlay = BUI.Overlay;
    var setStoreTypeDialog;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'渠道店',value:'0'},
            {text:'加盟店',value:'1'},
        ]
    });
    tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
    
	tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/network/userStore/storeManageList?storeType=2";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/network/userStore/storeManageList?storeType=3";
	        }
	    });
	    
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title : '门店编号',dataIndex :'storeNumber',width:"100px", renderer : function(value, rowObj){
                var detailStr='<a href="${ctx}/admin/network/userStore/toStoreDetailIndex?storeId='+rowObj.storeId+'">'+value+'</a>';
                return detailStr;
            }},
            {title : '门店名称',dataIndex : 'storeName',width:"150px", renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title : '门店属性',dataIndex : 'storePropertyCd',width:"100px",renderer : function(value, rowObj){
            	if(value=='1'){
            		value="烟酒店";
            	}
            	return value;
            }},

            {title : '所属大区',dataIndex : 'regionName',width:"100px"},
            {title : '所属分公司',dataIndex : 'branchName',width:"100px"},
            {title : '联系人',dataIndex : 'contacts',width:"100px"},
            {title : '门店电话',dataIndex : 'telephone',width:"100px"},
            {title : '门店星级',dataIndex : 'storeLevelId',width:"100px"},
            {title : '门店状态',dataIndex : 'statusCd',width:"100px",renderer : function(value, rowObj){
            	if(value=='1'){
            		value="开启";
            	}else if(value=='0'){
            		value="冻结";
            	}
            	return value;
            }},
            {title : '是否自提',dataIndex : 'isSelf',width:"100px",renderer : function(value, rowObj){
            	if(value=='1'){
            		value="是";
            	}else if(value=='0'){
            		value="否";
            	}
            	return value;
            }},
            {title : '省份',dataIndex : 'provinceName',width:"100px"},
            {title : '城市',dataIndex : 'cityName',width:"100px"},
            {title : '县区',dataIndex : 'countyName',width:"100px"},
            {title : '地址',dataIndex : 'detailAddress',width:"100px"},
        ];
        BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
        BUI.Picker.Picker.ATTRS.align.value.offset = [0, -200];
        var store = Search.createStore("${ctx}/admin/network/userStore/store_grid_json?storeType=${storeType!'1'}");
        var gridCfg = Search.createGridCfg(columns,{
            tbar : {
                items : [
                    {text : '新增门店',btnCls : 'button button-small button-primary',handler:addStore},
                    {text : '允许自提',btnCls : 'button button-small',handler:selfOk},
                    {text : '取消自提',btnCls : 'button button-small',handler:selfNo},
                    {text : '导出门店二维码',btnCls : 'button button-small',handler:batchExportStoreRqCodes},
                    {text : '导出门店',btnCls : 'button button-small',handler:batchExportStore},
                    {text : '导入门店',btnCls : 'button button-small',handler:importStore},
                    {text : '批量修改',btnCls : 'button button-small',handler:update}
                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格和拖拉列的大小
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();

        function addStore(){
            app.page.open({
                href:'/admin/network/userStore/storeForm'
            });
        }
		
        function batchExportStoreRqCodes(){
        	var  selectedContent= grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择门店!");
                return false;
            }
            var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].storeId);
            }
        	storeIds= selectedContentIds.join(",");
            location.href='${ctx}/admin/network/userStore/batchExportStoreRqCodes?storeIds='+storeIds;
			BUI.Message.Alert("导出成功");
        }
        //批量修改
        function update(){
        	var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择门店!");
                return false;
            }
            
        	var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].storeId);
            }
        	storeIds= selectedContentIds.join(",");
        	
            BUI.use('bui/overlay',function(Overlay){
          	var dialog = new Overlay.Dialog({
           // title:'配置DOM',
            width:400,
            height:300,
            closeAction : 'destroy', //每次关闭dialog释放
            //配置DOM容器的编号
            contentId:'content',
            success:function () {
            
              var regionId=$('#regionId1').val();
              var branchId=$('#branchId1').val();
              var officeId=$('#officeId1').val();
              if(regionId==""||regionId==null){
              		BUI.Message.Alert("请选择大区");
              		return;
              }
              if(branchId==""||branchId==null){
              		BUI.Message.Alert("请选择分公司");
              		return;
              }
              if(officeId==""||officeId==null){
              		BUI.Message.Alert("请选择办事处");
              		return;
              }
              app.ajax('${ctx}/admin/network/userStore/update',{
              regionId:regionId,branchId:branchId,officeId:officeId,storeIds:storeIds
              },function(data){
              		if(data){
              			app.showSuccess("修改成功");
              			location.href=location.href;
              		}
              });
              
              this.close();
            }
          });
          dialog.show();
        
      });
        }
        //导出门店
        function batchExportStore(){
        		var a=$('#searchForm').serialize();
    			location.href ="${ctx}/admin/network/storeExcel/exportStore?storeType=${(storeType!'1')!}&"+a;
    			BUI.Message.Alert("导出成功");
        }
		//到导入页面
        function importStore(){
            location.href ="${ctx}/admin/network/storeExcel/import";
        }
        
		//开启自提
		function selfOk(){
			var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择门店!");
                return false;
            }
            
			 BUI.Message.Confirm("确认取消自提？",function(){
			 
                var selectedContentIds = [];
                for(var i = 0; i < selectedContent.length ; i++){
                    selectedContentIds.push(selectedContent[i].storeId);
                }
                app.ajax("${ctx}/admin/network/userStore/isSelf", 
                {storeIds: selectedContentIds.join(","),isSelf:true}, function (data) {
                    if(data){
                        app.showSuccess("设置成功！")
                        search.load();
                    }else{
                        app.showSuccess("设置失败");
                        search.load();
                    }
                })
            })
		}
		//取消自提
		function selfNo(){
			var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择门店!");
                return false;
            }
		 BUI.Message.Confirm("确认取消自提？",function(){
		 	var selectedContentIds = [];
                for(var i = 0; i < selectedContent.length ; i++){
                    selectedContentIds.push(selectedContent[i].storeId);
                }
                 app.ajax("${ctx}/admin/network/userStore/isSelf", 
                {storeIds: selectedContentIds.join(","),isSelf:false}, function (data) {
                    if(data){
                        app.showSuccess("设置成功！")
                        search.load();
                    }else{
                        app.showSuccess("设置失败");
                        search.load();
                    }
                })
		 
		 });
		}

        <#--设门店 类型-->
        setStoreTypeDialog = new Overlay.Dialog({
            title:'设置门店类型',
            width:300,
            height:200,
            contentId:'storeTypeContent',
            success:function () {
                var dialogObj = this;

                var storeTypeId = $("#storeTypeId").val();
                if(storeTypeId == "-1"){
                    BUI.Message.Alert("请选择门店类型!");
                    return false;
                }

                var storeIds = $("input[name='storeIds']").val();
                var selectedStoreIds = storeIds.split(",");

                if(selectedStoreIds.length <= 0){
                    BUI.Message.Alert("请选择门店!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/storeManager/setStoreOtherType',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedStoreIds,storeTypeId:storeTypeId},
                    success : function(data){
                        if(data.result == "success"){
                            dialogObj.close();
                            app.showSuccess('设置成功！');
                            search.load();
                        }else{
                            BUI.Message.Alert('设置失败！');
                        }
                    }
                });
            }
        });
    });

    function setStoreType(){
        var selectedStore = grid.getSelection();
        if(selectedStore.length <= 0){
            BUI.Message.Alert("请选择门店!");
            return false;
        }

        var selectedStoreIds = [];
        for(var i = 0; i < selectedStore.length ; i++){
            selectedStoreIds.push(selectedStore[i].storeId);
        }

        $("input[name='storeIds']").val(selectedStoreIds.join(","));
        setStoreTypeDialog.show();
    }

    function conformCancel(value){
        BUI.Message.Confirm('确认要删除该条目吗？',function(){
            $.ajax({
                url: "${ctx}/admin/storeManager/storeInvalid?storeId="+value,
                type:"get",
                dataType: "text",
                error: function(data){
                    app.showSuccess("删除失败!");
                },
                success: function(data){
                    if(data=="success"){
                        app.showSuccess("删除成功!");
                        window.location.href="${ctx}/admin/storeManager/storeList?storeId=${parentId?default('1')}";
                    }else{
                        app.showSuccess("删除失败!");
                    }
                }
            });
        },'question');
    }

    $(function(){
    	//大区选择
	    $("#regionId").on('change',function(){
	    		var regionId = $(this).val();
	    		$('#branchId').empty();
	    		$("#branchId").append("<option value=''>-- 请选择 --</option>");
	    		$('#officeId').empty();
	    		$("#officeId").append("<option value=''>-- 请选择 --</option>");
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
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
    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
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
	    
	    //大区选择1
	    $("#regionId1").on('change',function(){
	    		var regionId = $(this).val();
	    		$('#branchId1').empty();
	    		$("#branchId1").append("<option value=''>-- 请选择 --</option>");
	    		$('#officeId1').empty();
	    		$('#officeId1').val('');
	    		$('#branchId1').val('');
	    		$("#officeId1").append("<option value=''>-- 请选择 --</option>");
	    		if(regionId && regionId != ''){
	    			$.ajax({
	    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : regionId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					
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
    		$('#officeId1').empty();
    		$('#officeId1').val('');
	    	$("#officeId1").append("<option value=''>-- 请选择 --</option>");
    		if(branchId && branchId != ''){
    			$.ajax({
    				url : '${ctx}/admin/network/userStore/findRegionchildByParentId',
    				dataType : 'json',
    				tyoe : 'POST',
    				data : {parentId : branchId },
    				success : function (data){
    					data=JSON.parse(data);
    					if(data.rowCount && data.rowCount >0){
                            $.each(data.rows, function(i, row){
                                $('#officeId1').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }
    				}
    			});
    		}
    	});
	    
	        $("#shortcut_storeName").on('keyup',function(){
	            $("#storeName").val($("#shortcut_storeName").val());
	            if(event.keyCode ==13){
	                $('#btnSearch').click();
	            }
	        });

        $("#shortcut_storeName").on('click',function(){
            $("#storeName").val($("#shortcut_storeName").val());
        });

        $("#storeName").on('keyup',function(){
            $("#shortcut_storeName").val($("#storeName").val());
        });

        $("#storeName").on('click',function(){
            $("#shortcut_storeName").val($("#storeName").val());
        });

        //点击 右上角搜索框
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
    })

    function shortSearch(){
        $('#btnSearch').click();
    }

    var x = 20;
    var y = -150;
    $(".storeRqCodeSmallImg").live('mouseover', function(ev){
        var curTrigger = $(this);
        <#--
        var curStoreId = curTrigger.attr("data-store-id");
        var curStoreName = curTrigger.attr("data-store-name");
        var curStoreNo = curTrigger.attr("data-store-no");
        var rqCodeImageGenerateUrl = "/rqCode/generate";
        rqCodeImageGenerateUrl += "?title=" + ((curStoreNo && curStoreNo != "") ? ("StoreNo_" + curStoreNo) : curStoreName);
        var content = "${mobileUrl}/store/"+curStoreId+"/show.html?f=qr";
        content = encodeURIComponent(content);
        rqCodeImageGenerateUrl += "&content=" + content;
        -->

        var curStoreId = curTrigger.attr("data-store-id");
        var rqCodeImageGenerateUrl = "${ctx}/admin/storeManager/viewWxQrCode";
        rqCodeImageGenerateUrl += "?storeId=" + curStoreId;
        var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='"+ rqCodeImageGenerateUrl +"'><\/div>"; //创建 div 元素
        $("body").append(tooltip);	//把它追加到文档中
        $("#tooltip")
                .css({
                    "top": (ev.pageY+y) + "px",
                    "left":  (ev.pageX+x)  + "px"
                }).show("fast");	  //设置x坐标和y坐标，并且显示
    }).live('mouseout',function(){
        $("#tooltip").remove();	 //移除
    }).live('mouseover', function(e){
        $("#tooltip")
                .css({
                    "top": (e.pageY+y) + "px",
                    "left":  (e.pageX+x)  + "px"
                });
    });
</script>
</body>
</html>