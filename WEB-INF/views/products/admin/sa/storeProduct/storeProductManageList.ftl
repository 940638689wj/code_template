<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
        </div>
    </div>
    
	<div class="content-top">
        <form id="searchForm" class="form-horizontal search-form mb0" method="post">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <select name="regionId" id="regionId" class="span4">
				            <option value="">-- 大区选择 --</option>
				            <#if orgList?? && orgList?has_content>
				                <#list orgList as item>
				                    <option value="${(item.orgId)!}">${(item.orgFullName)!}</option>
				                </#list>
				            </#if>
				        </select>
                        <select name="branchId" id="branchId" class="span4">
				            <option value="">-- 分公司选择 --</option>
				        </select>
	                    <select name="officeId" id="officeId" class="span4">
				            <option value="">-- 办事处选择 --</option>
				        </select>
                        <input placeholder="门店名称" name="storeName" class="input-normal control-text">
                        <button id="btnSearch" class="button button-primary">查询</button>                   
                    </div>
                </div>
            </div>
        </form>
        <button id="addProduct" class="button button-primary">添加商品</button>  
    </div>
    
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
	    var grid;
	    var search;
	    var Overlay = BUI.Overlay;
	    var Tab = BUI.Tab;
	    var tab = new Tab.Tab({
	        render : '#tab',
	        elCls : 'nav-tabs',
	        autoRender: true,
	        children:[
	            {text:'门店商品管理',value:'1'}
	        ]
	    });
	    tab.setSelected(tab.getItemAt(0));
	    BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	            {title : '门店编码',dataIndex : 'storeNumber',width:80,renderer:function(value, rowObj){
                var str = "";
                str = "<a href='javascript:showStoreProduct(\""+rowObj.storeId+"\");'>"+value+"</a>";	
                return str;
            }},
	            {title : '门店名称',dataIndex : 'storeName',width:100},
	            {title : '所属省份',dataIndex : 'provinceName',width:100},
	            {title : '所属城市',dataIndex : 'cityName',width:80}
	        ];
	        BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
	        BUI.Picker.Picker.ATTRS.align.value.offset = [0, -200];
	        var store = Search.createStore('${ctx}/admin/sa/storeProductManage/grid_json',{pageSize:15});
	        var gridCfg = Search.createGridCfg(columns,{
	        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
	            width: '100%',
	            height: getContentHeight()
	        });
	
	        search = new Search({
	        	gridId : 'grid',
	        	store : store,
	            gridCfg : gridCfg,
	            formId : 'searchForm',
            	//btnId:"user_search"
	        });
	        grid = search.get('grid');
        });
       
      
	    
        $(function(){
        	//大区选择
		    $("#regionId").on('change',function(){
		    		//先把分公司和办事处对应的数据清空
		    		$('#branchId').empty();
		    		$("#branchId").append("<option value=''>-- 分公司选择 --</option>");
		    		$('#officeId').empty();
		    		$("#officeId").append("<option value=''>-- 办事处选择 --</option>");
		    		
		    		var regionId = $(this).val();
		    		if(regionId && regionId != ''){
		    		  $('#btnSearch').click();		    		
		    			$.ajax({
		    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
		    				dataType : 'json',
		    				type : 'POST',
		    				data : {parentId : regionId },
		    				success : function (data){
		    					data=JSON.parse(data);
		    					$('#branchId').empty();
		    					$("#branchId").append("<option value=''>-- 分公司选择 --</option>");
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
		    	//先把办事处的数据清空
		    	$('#officeId').empty();
		    	$("#officeId").append("<option value=''>-- 办事处选择 --</option>");
		    	
	    		var branchId = $('#branchId').val();
	    		if(branchId && branchId != ''){
	    		 $('#btnSearch').click();
	    			$.ajax({
	    				url : '${ctx}/admin/sa/userStore/findRegionchildByParentId',
	    				dataType : 'json',
	    				tyoe : 'POST',
	    				data : {parentId : branchId },
	    				success : function (data){
	    					data=JSON.parse(data);
	    					$('#officeId').empty();
		    				$("#officeId").append("<option value=''>-- 办事处选择 --</option>");
	    					if(data.rowCount && data.rowCount >0){
	                            $.each(data.rows, function(i, row){
	                                $('#officeId').append("<option value='"+row.orgId+"'>"+row.orgFullName+"</option>");
	                            });
	                        }
	    				}
	    			});
	    		}
	    	});
	    	
	    	//办事处选择
	    	$("#officeId").on('change',function(){
	    		var officeId = $('#officeId').val();
	    		if(officeId && officeId != ''){
	    			$('#btnSearch').click();
	    		}
	    	});
        });
       
       
        // 展示门店商品
        function showStoreProduct(storeId){
			$.ajax({url: '${ctx}/admin/sa/storeProductManage/storeProductList?storeId='+storeId,
	            async: false,
	            success: function (result) {
	                  if(result.rows<1){
                          BUI.Message.Alert("该门店无商品");
                          return false;
                         }             	
	           	 	  BUI.use(['bui/overlay','bui/grid','bui/data'],function(Overlay,Grid,Data){
			          var Store = Data.Store,
			           columns = [
			             {title: '产品编码', dataIndex: 'productId', width: 120},
		                 {title: '产品名称', dataIndex: 'productName', width: 120},
		                 {title : '产品图片',dataIndex :'picUrl',width:"100px", renderer : function(value, rowObj){
                            var img_url = "";
            	            if(value!=null){
            		       img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	         }else{
            		     img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	        }
                         return img_url;
                        }},
		                 {title: '上架状态', dataIndex: 'productStatusCd', width: 120,renderer : function(value,rowObj){
		                 	var statusName = "";
		                 	if(value==1){
		                 		statusName = "上架";
		                 	}else{
		                 		statusName = "下架";
		                 	}
		            		return statusName;
		                 }},
		                {title:'操作',dataIndex:'productId',width:120,renderer : function(value,rowObj){
		             		var delStr = '<a href=\'javascript:delStoreProduct(\"'+value+'\",\"'+storeId+'\");\'>删除</a>';
		             		return delStr;
		                 }}
			          ],
			          data = result.rows;
			       	 
			       	 var store = new Store({
			            data : data,
			            autoLoad:true,
			            pageSize : 15
			          }),
			          
			          grid = new Grid.Grid({
			            forceFit: true, // 列宽按百分比自适应
			            columns : columns,
			            store : store,
				     
			            bbar:{
	                      pagingBar:true
	                    }
			          });
			 
			       storeDialog = new Overlay.Dialog({
			            title:'商品列表',
			            width:1000,
			            height:400,
			            children : [grid],
			            
			            
			            childContainer : '.bui-stdmod-body',
			            success:function () {
	                       this.close();
	                    }
			          });
			        storeDialog.show();
			      });
	            }  
	        });
		}	
      
      function delStoreProduct(productId,storeId){
	    BUI.Message.Confirm("确认要删除记录吗？",function(){
	    	$.ajax({url: '${ctx}/admin/sa/storeProductManage/delStoreProduct?productId='+productId+'&storeId='+storeId,
	            async: false,
	            success: function (data) {
	            	if(data.data){
	            		app.showSuccess('删除成功。');
	            		storeDialog.close();
	            		showStoreProduct(storeId);
	            		//window.location.href = '${ctx}/admin/sa/storeProductManage/list';
	                  //window.location.href = '${ctx}/admin/sa/storeProductManage/storeProductList?storeId='+storeId;
	            	}      
	            }	
	        });   
			// window.location.href='${ctx}/admin/sa/storeProductManage/delStoreProduct?productId='+productId+'&storeId='+storeId;
			},'question');
        }
       
       
       //添加商品对话框
        
        $('#addProduct').on('click',function () {
        var checkLen = grid.getSelection();
		if(checkLen.length < 1){
			BUI.Message.Alert('请选择门店');
        	return false;
		}else if(checkLen.length > 1){
			BUI.Message.Alert('仅能选择一个门店');
        	return false;
		}
		var storeId = checkLen[0].storeId; 		  	               
        showProduct(storeId);
        });
    

      
    //门店添加商品列表
    function showProduct(storeId){
      $.ajax({url: '${ctx}/admin/sa/storeProductManage/showStoreProduct?storeId='+storeId,
	            async: false,
	            success: function (result) {  
	                  if(result.rows<1){
                          BUI.Message.Alert("无可添加的商品");
                          return false;
                         }         	
	           	 	  BUI.use(['bui/overlay','bui/grid','bui/data'],function(Overlay,Grid,Data){
			          var Store = Data.Store,
			           columns = [
			              {title:'',width:80, renderer:function(value, rowObj){
            	        //var checkbox = '<input type="checkbox" name="product">';
            	        var checkbox = '<input type="checkbox" value="'+rowObj.productId+'" name="productId">';
                        return checkbox;
                          }},			             
			             {title: '产品编码', dataIndex: 'productId', width: 120},
		                 {title: '产品名称', dataIndex: 'productName', width: 120},
		                 {title : '产品图片',dataIndex :'picUrl',width:"100px", renderer : function(value, rowObj){
                            var img_url = "";
            	            if(value!=null){
            		       img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	         }else{
            		     img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	        }
                         return img_url;
                        }},
		                 {title: '产品分类', dataIndex: 'categoryId', width: 120},
		                 {title: '产品品牌', dataIndex: 'brandId', width: 120},	                
			          ],
			          data = result.rows;
			       	 var store = new Store({
			            data : data,
			            autoLoad:true,
			            pageSize : 15
			          }),
			          
			         grid = new Grid.Grid({
			            forceFit: true, // 列宽按百分比自适应
			            columns : columns,
			            store : store,
				        //plugins : [Grid.Plugins.CheckSelection],
			            bbar:{
	                      pagingBar:true
	                    }
			          });
			 
			      dialog = new Overlay.Dialog({
			            title:'商品列表',
			            width:1000,
			            height:400,
			            children : [grid],			           			           
			           buttons:[{
                       text:'选 择',
                       elCls : 'button button-primary',
                       handler : function(){
                         
                       	 //取出选中商品ID
			       	 	 var productId = $("input[name='productId']:checked");
			       	 	 // 判断
			       	 	 if(productId.length < 1){			             
        	                BUI.Message.Alert('请选择要添加的商品');
        	                return false;
		                  }
		                  //获取的值放入数组
		                  var productAttr = [];
                          $(productId).each(function (i,item) {                  
                            productAttr.push(this.value);
                          });
                          //发请求
                          $.ajax({url: '${ctx}/admin/sa/storeProductManage/delUnshelfProduct',
				            async: false,
				            type:'post',
				            dataType: 'json',
				            data: {"storeId" : storeId,"productAttr" : productAttr},
				            success: function (data) {
				                
				            	 if(data.data){
                          			BUI.Message.Alert("添加成功！",function(){
                          			   dialog.close();
                          			   search.load();
                          		  	});
                          		 }
                          		 
				             }
				            });  
                       }
                      }],
			            
			            childContainer : '.bui-stdmod-body',
			            success:function () {
	                       dialog.close();
	                    }
			          });
			      dialog.show();
			      });
	            }  
	        });
    }
    
    
</script>
</body>
</html>  