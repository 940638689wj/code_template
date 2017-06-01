<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
    <title></title>
	<#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div class="container">	
    <div class="title-bar">
        <div id="tab"></div>
    </div>
	<div class="content-top">
      
           	<form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0" method="get">
                <div class="controls ml0" style="height:30px">
                  <#--  <select name="countryId" id="countryId">
			            <option value="0">全国 </option>
			        </select>
                    <select name="provinceId" id="provinceId">
			            <option value="">选择省份</option>
			            <#if provinceList?? && provinceList?has_content>
			                <#list provinceList as province>
			                    <option value="${(province.id)!}">${(province.areaName)!}</option>
			                </#list>
			            </#if>
			        </select>-->
                    <select name="countyId" id="countyId">
			            <option value="">选择区/县</option>
			            <#if CountyList?? && CountyList?has_content>
			                <#list CountyList as county>
			                
			                    <option value="${(county.id)!}" >${(county.areaName)!}</option>
			                </#list>
			            </#if>
			        </select>
			        <select name="town" id="town">
			            <option value="">选择镇</option>
			        </select>
			        <select name="street" id="street">
			            <option value="">选择街道</option>
			        </select>
                    <button type="submit" id="btnSearch" class="button button-primary">查询</button>
                </div>
                </form>
    </div>
     <div class="content-body">
        <div id="grid"></div>
    </div>
        
        <div class="search-content" id="regionPrice">
	        <form class="form-horizontal search-form">
	            <div class="row">
	                <div class="control-group span10">
	                    <label class="control-label">设置零售价：</label>
	                    <div class="controls">
	                        <input id="salePrice" name="salePrice" class="control-text" placeholder="输入零售价" data-rules="{required:true,min:0,number:true}">
	                    </div>
	                </div>
	            </div>
	
	            <div class="row">
	                <div class="control-group span10">
	                    <label class="control-label">设置挂牌价：</label>
	                    <div class="controls">
	                        <input name="tagPrice" id="tagPrice" class="control-text" placeholder="输入挂牌价" data-rules="{required:true,min:0,number:true}">
	                    </div>
	                </div>
	            </div>
	        </form>
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
		            {text:'区域管理',value:'0'}
		        ]
		    });
		    tab.setSelected(tab.getItemAt(0));
		    BUI.use(['common/search','common/page'],function (Search) {
		        var columns = [
		           {title:'地区名称',dataIndex:'areaName',width:175,renderer:function(value,rowObj){
						return value;
					}},
		            {title:'排序',dataIndex:'sort',width:150},
		            {title:'操作',dataIndex:'',width:100, renderer:function(value, rowObj){
		                var str = "";
		                var str1= rowObj.isDisplayed==1?"隐藏":"显示";
		                str+= '<a href=\'javascript:hide(' + rowObj.id + ')\'>'+str1+'</a>&nbsp;&nbsp;&nbsp;&nbsp;';
		                
		                str+= "<a href='javascript:edit(\""+rowObj.id+"\");'>"+"编辑"+"</a>";
		                
		                
		                return str;
		            }},
		        ];
		        var store = Search.createStore('${ctx}/admin/sa/regisonProductManage/grid_leftJson',{pageSize:50});
		        var gridCfg = Search.createGridCfg(columns,{
		            plugins : [BUI.Grid.Plugins.ColumnResize],
		            width:'100%',
		            height: getContentHeight(),
		            tbar : {
		                items : [
		                    {text : '新增区域',btnCls : 'button button-small button-primary',handler:addNew},
		                 	{text : '删除',btnCls : 'button button-small button-primary',handler:deleteArea},
		                 	{text : '导入',btnCls : 'button button-small button-primary',handler:importArea},
		                 	{text : '导出',btnCls : 'button button-small button-primary',handler:exportArea}
		                    
		                ]
		            },
		            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
		            
		          
		        });
		
		        search = new Search({
		        	gridId:'grid',
		            store : store,
		            gridCfg : gridCfg,
		            formId:'searchForm_select',
            		btnId:"btnSearch"
		        });
		        grid = search.get('grid');
		    });
	    
	    function addNew(){
        		window.location.href = "${ctx}/admin/sa/regisonProductManage/form";
    	}
	    function edit(obj){
        		window.location.href = "${ctx}/admin/sa/regisonProductManage/form?id="+obj;
    	}
	    function hide(obj){
        		window.location.href = "${ctx}/admin/sa/regisonProductManage/hide?id="+obj;
    	}
    	function importArea(){
        		window.location.href = "${ctx}/admin/sa/regisonProductManage/areaImport";
    	}
    	//删除
	    function deleteArea(){
	    	
	    	var selectedGoods = grid.getSelection();
	        if(selectedGoods.length <= 0){
	            BUI.Message.Alert("请选择地区!");
	            return false;
	        }
	
	        var selectedGoodsIds = [];
	        for(var i = 0; i < selectedGoods.length ; i++){
	            selectedGoodsIds.push(selectedGoods[i].id);
	        }
	
	        BUI.Message.Confirm('确认删除这些地区吗？',function(){
	            $.ajax({
	                url :'${ctx}/admin/sa/regisonProductManage/deleteArea',
	                dataType : 'json',
	                type: 'POST',
	                data : {id : selectedGoodsIds},
	                success : function(data){
	                    app.showSuccess(data.result);
	                    location.reload(); 
	                }
	            });
	        },'question');
	    }
	// 导出
    function exportArea(){
    	window.location.href = "${ctx}/admin/sa/regisonProductManage/exportArea?" + $('#searchForm').serialize();
    }
	    <#--
	    var grid;
    	var search;
	    BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	            {
			            title : '名称',
			            dataIndex :'productName',
			            width:200
			        },{
			            title : '挂牌价',
			            dataIndex :'tagPrice',
			            width:100
			        },{
			            title : '零售价',
			            dataIndex : 'salePrice',
			            width:100
			        },{
			            title : '产品图片',
			            dataIndex : 'picUrl',
			            width:200,
			            renderer : function(value, rowObj){
			                var img_url = "";
			            	if(value!=null){
			            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
			            	}else{
			            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
			            	}
			                return img_url;
		            	}
			            
			        },{
			            title : '操作',
			            dataIndex : 'regionPriceId',
			            width:250,
			            renderer : function(value, rowObj){
			                var operStr = '<a href="javascript:upShelf('+ rowObj.regionPriceId +','+ rowObj.productId +');">上架</a>';
			                return operStr;
		            	}
			        }
	        ];
		    BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
	        BUI.Picker.Picker.ATTRS.align.value.offset = [0, -200];
	        var store = Search.createStore('',{pageSize:15});
	        var gridCfg = Search.createGridCfg(columns,{
	            width: '100%',
	            height: getContentHeight()-46
	        });
	
	        search = new Search({
	        	gridId : 'grid',
	        	store : store,
	            gridCfg : gridCfg,
	            formId : 'searchForm'
	        });
	        grid = search.get('grid');
		});
	
	    BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	            {
			            title : '名称',
			            dataIndex :'productName',
			            width:200
			        },{
			            title : '挂牌价',
			            dataIndex :'tagPrice',
			            width:100
			        },{
			            title : '零售价',
			            dataIndex : 'salePrice',
			            width:100
			        },{
			            title : '产品图片',
			            dataIndex : 'picUrl',
			            width:200,
			            renderer : function(value, rowObj){
			                var img_url = "";
			            	if(value!=null){
			            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
			            	}else{
			            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
			            	}
			                return img_url;
		            	}
			            
			        },{
			            title : '操作',
			            dataIndex : 'regionPriceId',
			            width:250,
			            renderer : function(value, rowObj){
			                var operStr = '<a href="javascript:upShelf('+ rowObj.regionPriceId +','+ rowObj.productId +');">上架</a>';
			                return operStr;
		            	}
			        }
	        ];
		    BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
	        BUI.Picker.Picker.ATTRS.align.value.offset = [0, -200];
	        var store = Search.createStore('',{pageSize:15});
	        var gridCfg = Search.createGridCfg(columns,{
	            width: '100%',
	            height: getContentHeight()-46
	        });
	
	        search = new Search({
	        	gridId : 'grid2',
	        	store : store,
	            gridCfg : gridCfg,
	            formId : 'searchForm'
	        });
	        grid = search.get('grid');
		});
	    
	    -->
	    

        $(function(){
        	$("#countyId").on('change', function(){
	            var countyId = $(this).val();
	            $("#countyId").val(countyId);
	            if(countyId!=null && countyId!=""){
	                $.ajax({
	                    url : '${ctx}/admin/sa/regisonProductManage/findChildByParentId',
	                    dataType : 'json',
	                    type: 'GET',
	                    data : {parentId: countyId},
	                    success : function(data){
	                        if(data.rowCount!=null && data.rowCount >0){
	                            cleanSelectContent("town", "选择镇");
	                            cleanSelectContent("street", "选择街道");
	                            //alert(1)
	                            $.each(data.rows, function(i, row){
	                                $("#town").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
	                            });
	                        }else{
	                            cleanSelectContent("town", "选择镇");
	                            cleanSelectContent("street", "选择街道");
	                        }
	                    }
	                });
	            }else{
	                $('#town').empty();
	                cleanSelectContent("town", "选择镇 ");
	                cleanSelectContent("street", "选择街道");
	            }
	        });
	        
	        $("#town").on('change', function(){
	            var town = $(this).val();
	            $("#town").val(town);
	            if(town!=null && town!=""){
	                $.ajax({
	                    url : '${ctx}/admin/sa/regisonProductManage/findChildByParentId',
	                    dataType : 'json',
	                    type: 'GET',
	                    data : {parentId: town},
	                    success : function(data){
	                        if(data.rowCount!=null && data.rowCount >0){
	                            cleanSelectContent("street", "选择街道");
	                            $.each(data.rows, function(i, row){
	                                $("#street").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
	                            });
	                        }else{
	                            cleanSelectContent("street", "选择街道");
	                        }
	                    }
	                });
	            }else{
	                $('#street').empty();
	                cleanSelectContent("street", "选择街道 ");
	            }
	        });
	        // 查询
	        //$("#btnSearch").on("click",function(){
	        //	searchRegionProduct();
	        //});
	    	    	
        });
        
       	// function searchRegionProduct(){
       	// 	fullMask.show();
		//	leftJson();	
		//	fullMask.hide();
        //}
        
        document.onkeydown=function(){
           if (event.keyCode == 13){
              searchRegionProduct();
           }
        }
        
        function leftJson(){
        	var countyId = $("#countyId").val();
        	var town = $("#town").val();
        	var street = $("#street").val();
        
        	$.ajax({
                url : '${ctx}/admin/sa/regisonProductManage/grid_leftJson',
                async: false,
                dataType : 'json',
                type: 'POST',
                data : {"countyId": countyId, "town": town, "street": street},
                success : function(data){
                	$("#grid").empty();
                	leftGrid(data.rows);
                	<#--
                	var left = eval('[' + data.leftObj + ']');
                	var right = eval('[' + data.rightObj + ']');
					leftGrid(left);
					rightGrid(right);
					-->
                }
            });
        }
        
        function rightJson(){
        	var countryId = $("#countryId").val();
        	var provinceId = $("#provinceId").val();
        	var cityId = $("#cityId").val();
        	var leftProductName = $("#leftProductName").val();
        	var rightProductName = $("#rightProductName").val();
        	$.ajax({
                url : '${ctx}/admin/sa/regisonProductManage/grid_rightJson',
                async: false,
                dataType : 'json',
                type: 'POST',
                data : {"countryId": countryId, "provinceId": provinceId, "cityId": cityId, "leftProductName": leftProductName, "rightProductName": rightProductName},
                success : function(data){
                	$("#grid2").empty();
                	rightGrid(data.rows);
                	<#--
                	var left = eval('[' + data.leftObj + ']');
                	var right = eval('[' + data.rightObj + ']');
					leftGrid(left);
					rightGrid(right);
					-->
                }
            });
        }
        
        function cleanSelectContent(selectId, remark){
	        $('#'+selectId+'').empty();
	        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
	    }
       
       function upShelf(regionPriceId, productId){
       	    $("#regionPriceId").val(regionPriceId);
       	    $("#productId").val(productId);
       		dialog.show();
       }
       
       function downShelf(regionPriceId, productId){
	       $.ajax({url: '${ctx}/admin/sa/regisonProductManage/downShelf',
		        async: false,
		        type:'post',
		        dataType: 'json',
		        data: {"regionPriceId" : regionPriceId,"productId" : productId},
		        success: function (data) {
					if(data.result){
						BUI.Message.Alert('下架成功!',function(){
							searchRegionProduct();
						});
		        	}else{
		        		BUI.Message.Alert('商品无该区域定价!');
		        		return false;
		        	}
		        }
	       });  
       }
</script>
</body>
</html>  