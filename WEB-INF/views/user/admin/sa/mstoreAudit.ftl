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
                        <div class="control-group span13">
                            <label class="control-label">手机号：</label>
                            <div class="controls">
                                <input type="text" name="phone" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">用户名：</label>
                            <div class="controls">
                                <input type="text" name="userName" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">上级微店主手机号：</label>
                            <div class="controls">
                                <input type="text" name="parentPhone" class="control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">省份：</label>
                            <div class="controls">
                                <select name="provinceId" id="selectProvince" class="span3">
						            <option value="">-- 选择省份 --</option>
						            <#if provinceList?? && provinceList?has_content>
						                <#list provinceList as item>
						                   <option value="${item.id}">${(item.areaName)!?html}</option>
						                </#list>
						            </#if>
						        </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">城市：</label>
                            <div class="controls">
                                <select name="cityId" id="selectCity" class="span3">
						            <option value="">-- 选择城市 --</option>
						            <#if cityList?? && cityList?has_content>
						                <#list cityList as item>
						                   <option value="${item.id}">${(item.areaName)!?html}</option>
						                </#list>
						            </#if>
						        </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">县区：</label>
                            <div class="controls">
                                <select name="countyId" id="selectCountry" class="span3">
							            <option value="">-- 选择县/区 --</option>
							            <#if countyList?? && countyList?has_content>
							                <#list countyList as item>
							                   <option value="${item.id}">${(item.areaName)!?html}</option>
							                </#list>
							            </#if>
							     </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">申请时间：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input name="applyStartDate" class="control-text input-small calendar" type="text"><label>&nbsp;-&nbsp;</label>
                                <input name="applyEndDate" class="control-text input-small calendar" type="text">
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

    <div id="auditAgreed" class="hide">
        <form class="form-horizontal">
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
      </form>
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
            {text:'待审核微店主',value:'2'},
            {text:'已拒绝列表',value:'4'}
        ]
    });
    tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
        	var mstoreStatusCd=item.get('value');
        	$("#mstoreStatusCd").val(mstoreStatusCd);
	        window.location.href = "${ctx}/admin/sa/mstore/mstoreList?mstoreStatusCd="+mstoreStatusCd;
	    });

	BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
	            var editStr = '&nbsp;<a href=\'javascript:auditAgreed("'+rowObj.userId+'")\'>审核</a>';
	            return editStr;
	        }},
	        {title:'ID',dataIndex:'userId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='userId' value='" + value + "'>";
        	}},
        	{title:'会员手机号',dataIndex:'phone',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
        	}},
         	{title:'姓名',dataIndex:'userName',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'身份证号码',dataIndex:'identityId',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'省份',dataIndex:'provinceName',width:80, renderer : function(value, rowObj){
	        	return app.grid.format.encodeHTML(value);
            }},
            {title:'城市',dataIndex:'cityName',width:70, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'县区',dataIndex:'countyName',width:70, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'会员状态',dataIndex:'statusText',width:100, renderer : function(value, rowObj){
                return value;
            }},
            {title:'上级会员',dataIndex:'parentPhone',width:120, renderer : function(value, rowObj){
                if(null!=value){return value;}
            }}, 
            {title:'申请时间',dataIndex:'mstoreApplyTime',width:140, renderer : function(value, rowObj){
            	if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/user/grid_json?mstoreStatusCd=${(mstoreStatusCd)!'2'}',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar:{
                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                items:[
                {btnCls : 'button button-small',text:'批量同意',handler:function(e){auditAgreed(null);}},
                {btnCls : 'button button-small',text:'批量拒绝',handler:auditRefused,visible:${tabIndex!'0'}==0?true:false}
                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
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

    

    function auditAgreed(userId){
    	var userIds='';
    	if(null!=userId && ''!=userId){
    		userIds= userId;
    	}else{
    		var selectedContent = grid.getSelection();
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
                selectedContentIds.push(selectedContent[i].userId);
            }
        	userIds= selectedContentIds.join(",");
    	}
    	
            BUI.use('bui/overlay',function(Overlay){
          	var dialog = new Overlay.Dialog({
            title:'审核',
            width:400,
            height:300,
            closeAction : 'destroy', //每次关闭dialog释放
            //配置DOM容器的编号
            contentId:'auditAgreed',
            success:function () {
              var regionId=$('#regionId1').val();
              var branchId=$('#branchId1').val();
              var officeId=$('#officeId1').val();
              
              app.ajax('${ctx}/admin/sa/mstore/update',{
              regionId:regionId,branchId:branchId,officeId:officeId,userIds:userIds,f:'s'
              },function(data){
              		if(app.ajaxHelper.handleAjaxMsg(data)){
              			app.showSuccess("审核成功");
              			location.href=location.href;
              		}
              });
              
              this.close();
            }
          });
        dialog.show();
        });
    }

    function auditRefused(){
    	var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择申请!");
            return false;
        }
    	if(window.confirm("是否确认拒绝申请？")){
    		var selectedContent = grid.getSelection();
            if(selectedContent.length <= 0){
                BUI.Message.Alert("请选择会员!");
                return false;
            }
            if(selectedContent.length < 2){
                BUI.Message.Alert("选择的申请条数不能低于2条!");
                return false;
            }
            var regionId=$('#regionId1').val();
            var branchId=$('#branchId1').val();
            var officeId=$('#officeId1').val();
              
        	var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].user.userId);
            }
        	userIds= selectedContentIds.join(",");
        	app.ajax('${ctx}/admin/sa/mstore/update',{
              regionId:regionId,branchId:branchId,officeId:officeId,userIds:userIds,f:'r'
              },function(data){
              		if(app.ajaxHelper.handleAjaxMsg(data)){
              			app.showSuccess("已拒绝微店主的申请！");
              			location.href=location.href;
              		}
              });
    	}
    }

    $("#selectProvince").on('change', function(){
            var selectProvince = $(this).val();
            $("#provinceId").val(selectProvince);
            if(selectProvince && selectProvince != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/userStore/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectProvince},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectCity", "-- 选择城市 --");
                            cleanSelectContent("selectCountry", "-- 选择县/区 --");

                            $.each(data.rows, function(i, row){
                                $("#selectCity").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectCity", "-- 选择城市 --");
                            cleanSelectContent("selectCountry", "-- 选择县/区 --");
                        }
                    }
                });
            }else{
                $('#selectCity').empty();
                cleanSelectContent("selectCity", "-- 选择城市 --");
                cleanSelectContent("selectCountry", "-- 选择县/区 --");
            }
        });

        $("#selectCity").on('change', function(){
            var selectCity = $(this).val();
            $("#cityId").val(selectCity);
            if(selectCity && selectCity != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/common/area/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectCity},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectCountry", "-- 选择县/区 --");

                            $.each(data.rows, function(i, row){
                                $("#selectCountry").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectCountry", "-- 选择县/区 --");
                        }
                    }
                });
            }else{
                $('#selectCountry').empty();
                cleanSelectContent("selectCountry", "-- 选择县/区 --");
            }
        });

        $("#selectCountry").on('change', function(){
            $("#countryId").val($(this).val());
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
        
        function cleanSelectContent(selectId, remark){
	        $('#'+selectId+'').empty();
	        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
	    }
    
</script>
</body>
</html>  