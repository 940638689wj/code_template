<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
	<script type="text/javascript" src="${ctx}/static/admin/js/jquery.easydropdown.min.js"></script>
	<script type="text/javascript" src="${ctx}/static/admin/js/validator.js?v=roma31"></script>
	
</head>
<body>
<#macro showCategoryChild parent level>
    <#if parent?has_content>           	
   		<option value="${(parent.categoryId)!}"><#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${(parent.categoryName)!?html}</option>
    </#if>
	<#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
             <@showCategoryChild child level+1 />
        </#list>
    </#if>    
</#macro>
<div class="container">
    <div class="title-bar">
    	<div id="tab"></div>
    </div>
    <div class="content-top">
	    <div id="tab1" class="bui-inline-block"></div>
	    <@selectFast storeList "storeId" "storeName" "所有门店" "product_storeId" "product_storeId"></@selectFast>
		<select name="product_categoryId" id="product_categoryId" class="input-normal">
                    	<option value="">所有分类</option>
	                    <#if productCategoryList?has_content>
        					<#list productCategoryList as parentCategory>
				  				<@showCategoryChild  parentCategory 0/>
        					</#list>
        				</#if>
                    </select>
	</div>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" class="control-text" placeholder="菜品名称" id="short_productName" /><button onclick="shortSearch()"></button>
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                	<input type="hidden" id="productTypeCd" name="productTypeCd" value="2">
                	<input type="hidden" name="productStatusCd" id="productStatusCd" value="${(productStatusCd)!}"/>
                	<input type="hidden" name="categoryId" id="categoryId" value="">
                	<input type="hidden" name="storeId" id="storeId" value="">
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">菜品ID：</label>
                            <div class="controls">
                                <input id="productId" name="productId" class="control-text" placeholder="输入菜品ID">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">菜品名称：</label>
                            <div class="controls">
                                <input name="productName" id="productName" class="control-text" placeholder="输入菜品名称">
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
    	<div id="setStoceWarningContent" class="well" style="display: none;">
            <div class="form-horizontal">
                <div class="form-content">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:130px;">设置全局库存预警:</label>
                            <div class="controls control-row-auto">
                            <input type="text" name="stock" class="control-text" id="stock">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    

        <div id="userLevelContent" class="well" style="display: none;">
            <input type="hidden"  name="customerIds" value=""/>
            <div class="form-horizontal">
                <div class="form-content">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:120px;">菜品分类：</label>
                            <div class="controls">
                                <select name="categoryIdf" id="categoryIdf" class="input-normal">
			                    	<option value="">所有分类</option>
				                    <#if productCategoryList?has_content>
			        					<#list productCategoryList as parentCategory>
							  				<@showCategoryChild  parentCategory 0/>
			        					</#list>
			        				</#if>
			                    </select>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
	        <div id="maxMoneyByPointContent" class="well" style="display: none;">
	           <input type="hidden"  name="scoreDisCountIds" value=""/>
	            <form id="batchSetPointForm" class="form-horizontal" method="post">
	                <div id="edit-div" class="form-content">
	                    <div class="row">
	                        <div class="control-group">
	                         <label class="control-label control-label-maxlong">积分最多抵扣：</label>
				                <div class="controls">
					                <div>
					                    <input type="radio" name="scoreDisCountTypeCd"  value="1" onclick="showCont()" >
					                    <input   id="scoreDiscountValue1"  name= "" type="text" data-rules="{min:0,number:true}" class="input-small control-text"   >&nbsp;元
					                </div>
					                <div> 
					                    <input type="radio" name="scoreDisCountTypeCd"  value="2" onclick="showCont()" >
					                    <input   id="scoreDiscountValue2"  name= "" type="text" data-rules="{min:0,max:100,number:true}" class="input-small control-text"   >&nbsp;%
					               	</div>
				                </div>
	                        </div>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	    <div id="setShowStock" class="well" style="display: none;">
            <label class="control-label">设置隐藏库存：</label>
            <input type="checkbox" id="hideStock" >
        </div>
</div>
<script type="text/javascript">
    var grid;
    var search;
    var Overlay = BUI.Overlay;
    var Tab = BUI.Tab;
    var setStockWaringDialog;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
			{text:'上架菜品',value:'1'},
            {text:'下架菜品',value:'2'}
        ]
    });
    
   	tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
   	tab.on('selectedchange',function (ev) {
	         var item = ev.item;
		        if(item.get('value')=="1"){
		        	$("#productStatusCd").val("1");
		            showButtonOfArchived1();
		        }else if(item.get('value')=="2"){
		        	$("#productStatusCd").val("2");
		            showButtonOfArchived2();
		        }
        	search.load({start:0});
	    });
    
    var Mask = BUI.Mask;
    var fullMask = new Mask.LoadMask({
        el : 'body',
        msg : '正在执行中...'
    });
    
    BUI.use(['common/search','common/page'],function (Search,Page) {
        var columns = [
            {title : '操作',width:150, renderer : function(value, rowObj){
                var editStr ="";
                editStr = Search.createLink({
                    text: '编辑',
                    href: "${ctx}/admin/sa/dishesManage/addOrEdit?productId=" + rowObj.productId
                });
                var deleteStr ="";
                deleteStr = "<span class='grid-command' onclick=\"javascript:deleteProduct0('" + rowObj.productId + "')\">删除</span>";
 
                var topTimeStr="";
                if(rowObj.topTime!=null){
                    topTimeStr = "<span class='grid-command' onclick=\"javascript:topTimeProduct('" + rowObj.productId + "','0')\">取消置顶</span>";
                }else{
                    topTimeStr = "<span class='grid-command' onclick=\"javascript:topTimeProduct('" + rowObj.productId + "','1')\">置顶</span>";
                }
                return editStr+"&nbsp;"+deleteStr+"&nbsp;"+topTimeStr;
            }},
            {title : '图片',dataIndex :'picUrl',width:100, renderer : function(value, rowObj){
                var img_url = "";
            	if(value!=null){
            		img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
            	}else{
            		img_url = '<img src="" style="width:30px;height: 30px;"/>';
            	}
                return img_url;
            }},
            {title : '二维码',dataIndex : 'productId',width:150, renderer : function(value, rowObj){
                return '<img data-product-item-no="' + value + '" data-product-id="'+value+'" class="qrCodeSmallImg" src="${ctx}/qrCode/generate?content=test" style="width:30px;height: 30px;cursor: pointer;" />';
            }},
            <#-- <img src="'+value+'"/> -->
            {title : 'ID',dataIndex : 'productId',width:80},
            {title : '名称',dataIndex : 'productName',width:100,renderer : function(value, rowObj){
                var str = "";
                str = "<span title="+ value +">"+value+"</span>";
                return str;
            }},
            {title : '货号',dataIndex : 'barCode',width:100},            
            {title : '库存',dataIndex : 'sum',width:100},
            {title : '库存预警',dataIndex : 'stockWarningLimit',width:100},            
            {title : '菜品分类',dataIndex : 'categoryName',width:100},
            {title : '销售价',dataIndex : 'defaultPrice',width:80},
            {title : '成本价',dataIndex : 'tagPrice',width:80},
            {title : '创建时间',dataIndex : 'lastUpdateTime',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title : '是否上架',dataIndex : 'productStatusCd',width:75,renderer : function(value, rowObj){
            	var productStatusCdName = "";
            	if(value==1){
            		productStatusCdName = "是";
            	}else{
            		productStatusCdName = "否";
            	}
            	return productStatusCdName;
            }},
            
        ];
        BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
        BUI.Picker.Picker.ATTRS.align.value.offset = [0, -200];
        var store = Search.createStore('${ctx}/admin/sa/productManage/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            tbar : {
                items : [
                    {text : '新增菜品',btnCls : 'button button-small button-primary',handler:addProduct},
                    {text : '复制',btnCls : 'button button-small',handler:copyProduct},
                    {text : '删除',btnCls : 'button button-small',handler:deleteProduct},                    
                    {text : '上架',btnCls : 'button button-small',handler:upShelf},
                   	{text : '下架',btnCls : 'button button-small',handler:downShelf},
                   	{text : '置顶菜品',btnCls : 'button button-small',handler:topTime1Product},
                    {text : '取消置顶菜品',btnCls : 'button button-small',handler:topTime0Product},
                    {text : '设置菜品分类',btnCls : 'button button-small',handler:setCategory},
                    {text : '积分抵扣设置',btnCls : 'button button-small',handler:setMaxmoneyByPoint},
                    {text : '前台隐藏库存',btnCls : 'button button-small', handler: function() {
                            var ids = getSelectProducts4Array();
                            if (!ids || ids.length <= 0) return BUI.Message.Alert("请选择菜品！");
                            var dialog = new BUI.Overlay.Dialog({
                                title: "隐藏金额",
                                width:260,
                                contentId: "setShowStock",
                                closeAction: "destroy",
                                buttons: [
                                    {
                                        text:'确 定',
                                        elCls: 'button button-primary',
                                        handler : function(){
                                            $.post("${ctx}/admin/sa/productManage/setShowPrice", {ids: ids, on: $("#hideStock:checked").length ? "1" : "0"}, function(data) {
                                                if (data && data.result == "success") {
                                                    return BUI.Message.Alert("操作成功！");
                                                }
                                                BUI.Message.Alert((data && data.message) || "操作失败！");
                                            });
                                            dialog.close();
                                        }
                                    }
                                ]
                            });
                            dialog.show();
                        }},
                    {text : '导出',btnCls : 'button button-small',handler:exportDishes},
                    {text : '导出二维码',btnCls : 'button button-small',handler:exportProdunctQrcode}


                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight()
        });
        search = new Search({
        	gridId : 'grid',
        	store : store,
            gridCfg : gridCfg,
            formId : 'searchForm'
        });
        grid = search.get('grid');
        showButtonOfArchived1();
	});
	function setMaxmoneyByPoint(){
        var selectedCustomer = grid.getSelection();
        if(selectedCustomer.length <= 0){
            BUI.Message.Alert("请选择菜品!");
            return false;
        }

        var selectedCustomerIds = [];
        for(var i = 0; i < selectedCustomer.length ; i++){
            selectedCustomerIds.push(selectedCustomer[i].productId);
        }
        $("input[name='scoreDisCountIds']").val(selectedCustomerIds.join(","));
        setMaxMoneyByPointDialog.show();
    }
    setMaxMoneyByPointDialog = new Overlay.Dialog({
            title:'使用积分抵扣设置',
            width:650,
            height:220,
            //配置DOM容器的编号
            contentId:'maxMoneyByPointContent',
            success:function () {
                var dialogObj = this;
                var scoreDisCountTypeCd = $("[name='scoreDisCountTypeCd']:checked").val(),
                    scoreDiscountValue = $("[name='scoreDiscountValue']").val();
                if (isNaN(scoreDiscountValue)) {
                    BUI.Message.Alert("请输入数值!");
                    return false;
                }
                if(scoreDiscountValue==""){
                  	BUI.Message.Alert("请输入数值!");
                    return false;
                }
                if(scoreDiscountValue != "" && !YrValidator.isNotNegativeInteger(scoreDiscountValue)){
                    BUI.Message.Alert("抵扣值必须为正整数!");
                    return false;
                    }
                if(scoreDisCountTypeCd==2){
                	if(scoreDiscountValue>100){
                	 BUI.Message.Alert("不可以超过100%");
                     return false;
                    }
                }
				
                var scoreDisCountIds = $("input[name='scoreDisCountIds']").val();
                var selectedScoreDisCountIdsIds = scoreDisCountIds.split(",");
                if (selectedScoreDisCountIdsIds.length <= 0) {
                    BUI.Message.Alert("请选择菜品!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setPoint',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedScoreDisCountIdsIds, scoreDisCountTypeCd: scoreDisCountTypeCd, scoreDiscountValue: scoreDiscountValue},
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
      function setCategory(){
        var selectedCustomer = grid.getSelection();
	        if(selectedCustomer.length <= 0){
	            BUI.Message.Alert("请选择菜品!");
	            return false;
	        }
	
	        var selectedCustomerIds = [];
	        for(var i = 0; i < selectedCustomer.length ; i++){
	            selectedCustomerIds.push(selectedCustomer[i].productId);
	        }
	        $("input[name='customerIds']").val(selectedCustomerIds.join(","));
	        
	        dialog.show();
    	}
    	 var Overlay = BUI.Overlay
        dialog = new Overlay.Dialog({
            title:'设置菜品分类',
            width:380,
            //配置DOM容器的编号
            contentId:'userLevelContent',
            success:function () {
                var dialogObj = this;
                var categoryIdf = $("#categoryIdf").val();
                if(categoryIdf == "-1"){
                    BUI.Message.Alert("请选择菜品分类!");
                    return false;
                }

                var customerIds = $("input[name='customerIds']").val();
                var selectedCustomerIds = customerIds.split(",");

                if(selectedCustomerIds.length <= 0){
                    BUI.Message.Alert("请选择菜品!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setCategory',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedCustomerIds,categoryId:categoryIdf},
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
	function setWarning(){
        $.ajax({
            url : '${ctx}/admin/sa/productManage/findStock',
            dataType : 'json',
            type: 'POST',
            success : function(data){
                if(data.result == "success"){
                     $("#stock").val(data.stock);
                }else{
                    app.showSuccess("设置失败!");
                }
            }
        });
        setStockWaringDialog.show();
    }
	setStockWaringDialog = new Overlay.Dialog({
            title:'设置全局库存预警',
            width:380,
            //配置DOM容器的编号
            contentId:'setStoceWarningContent',
            success:function () {
                var dialogObj = this;

                var stock = $("input[name='stock']").val();

                if(stock.length <= 0){
                    BUI.Message.Alert("请输入预警值!");
                    return false;
                }
                if(isNaN(stock)){
                    BUI.Message.Alert("格式不合法!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setStock',
                    dataType : 'json',
                    type: 'POST',
                    data : {stock : stock},
                    success : function(data){
                        if(data.result == "success"){
                            dialogObj.close();
                            app.showSuccess('设置成功！');
                        }else{
                            BUI.Message.Alert('设置失败！');
                        }
                    }
                });
            }
        });
        //置顶商品
	    function topTimeProduct(productId,status){
	        if(!productId){
	            return;
	        }
	
	        var msg="置顶";
	        if(status =='0'){
	            msg="取消置顶";
	        }
	
	        BUI.Message.Confirm('确定要'+msg+'菜品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/topTimeProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {productId : productId,status:status},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess('菜品'+msg+'成功。');
	                        search.load();
	                    }else{
	                        app.showSuccess('菜品'+msg+'失败!');
	                    }
	                }
	            });
	        },'question');
	    }
        //批量 置顶商品
	    function topTime1Product(){
	        var selectedProducts = grid.getSelection();
	        if(selectedProducts.length <= 0){
	            BUI.Message.Alert("请选择需要操作的菜品!");
	            return false;
	        }
	
	        var selectedProductIds = [];
	        for(var i = 0; i < selectedProducts.length ; i++){
	            selectedProductIds.push(selectedProducts[i].productId);
	        }
	
	        BUI.Message.Confirm('确定要置顶所选菜品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/topTimeProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {ids : selectedProductIds,status:'1'},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess('菜品置顶成功。');
	                        search.load();
	                    }else{
	                        app.showSuccess('菜品置顶失败!');
	                    }
	                }
	            });
	        },'question');
	    }
	    //批量 取消置顶
	    function topTime0Product(){
	        var selectedProducts = grid.getSelection();
	        if(selectedProducts.length <= 0){
	            BUI.Message.Alert("请选择需要操作的菜品!");
	            return false;
	        }
	
	        var selectedProductIds = [];
	        for(var i = 0; i < selectedProducts.length ; i++){
	            selectedProductIds.push(selectedProducts[i].productId);
	        }
	
	        BUI.Message.Confirm('确定要取消置顶所选菜品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/topTimeProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {ids : selectedProductIds,status:'0'},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess('菜品取消置顶成功。');
	                        search.load();
	                    }else{
	                        app.showSuccess('菜品取消置顶失败!');
	                    }
	                }
	            });
	        },'question');
	    }
		//删除
	    function deleteProduct(){
	    	
	    	var selectedGoods = grid.getSelection();
	        if(selectedGoods.length <= 0){
	            BUI.Message.Alert("请选择菜品!");
	            return false;
	        }
	
	        var selectedGoodsIds = [];
	        for(var i = 0; i < selectedGoods.length ; i++){
	            selectedGoodsIds.push(selectedGoods[i].productId);
	        }
	
	        BUI.Message.Confirm('确认删除所选菜品吗？',function(){
	            $.ajax({
	                url :'${ctx}/admin/sa/productManage/deleteProducts',
	                dataType : 'json',
	                type: 'POST',
	                data : {id : selectedGoodsIds},
	                success : function(data){
	                    app.showSuccess(data.result);
	                    search.load();
	                }
	            });
	        },'question');
	 }
	 function deleteProduct0(productId){
        if(!productId){
            return;
        }

	        BUI.Message.Confirm('确定要删除该菜品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/deleteProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {productId : productId},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess("菜品删除成功。");
	                        search.load();
	                    }else{
	                        app.showSuccess("菜品删除失败!");
	                    }
	                }
	            });
	        },'question');
		 }
	 function getSelectProducts4Array() {
        var selectedProduct = grid.getSelection();
        if (!selectedProduct.length) return null;
        var selectedProductIds = [];
        for(var i = 0; i < selectedProduct.length ; i++){
            selectedProductIds.push(selectedProduct[i].productId);
        }
        return selectedProductIds;
    	}
	 function showCont(){
			 switch($("input[name=scoreDisCountTypeCd]:checked").attr("value")){
			  case "1":
			  //alert("one");
			   $("#scoreDiscountValue2").val("");
			  $("#scoreDiscountValue2").attr("readonly",true);
			  $("#scoreDiscountValue2").attr("disabled",true);
			  $("#scoreDiscountValue1").removeAttr("readonly");
			  $("#scoreDiscountValue1").removeAttr("disabled");
			  $("#scoreDiscountValue1").attr("name","scoreDiscountValue");
			  $("#scoreDiscountValue2").removeAttr("name");
			  
			   break;
			  case "2":
			  $("#scoreDiscountValue1").val("");
			 $("#scoreDiscountValue1").attr("readonly",true);
			 $("#scoreDiscountValue1").attr("disabled",true);
			 $("#scoreDiscountValue2").removeAttr("readonly");
			 $("#scoreDiscountValue2").removeAttr("disabled");
			 $("#scoreDiscountValue2").attr("name","scoreDiscountValue");
			 $("#scoreDiscountValue1").removeAttr("name");
			 
			 
			 //alert("two");
			   break;
			  default:
			   break;
			 }
			}
	// 初始化
    $(function(){
        $("#short_productName").on('keyup',function(){
            $("#productName").val($("#short_productName").val());
            if(event.keyCode ==13){
                $('#btnSearch').click();
            }
        });
        $("#short_productName").on('click',function(){
            $("#productName").val($("#short_productName").val());
        });

        $("#productName").on('keyup',function(){
            $("#short_productName").val($("#productName").val());
        });

        $("#productName").on('click',function(){
            $("#short_productName").val($("#productName").val());
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

        // 商品品牌/分类分组下拉列表事件触发
        $('#product_storeId,#product_categoryId').change(function(){
        	var prifx = $(this).attr("id").split("_")[1];
        //	alert(prifx);
        //	alert($(this).val());
        	$("#"+prifx).val($(this).val());
            $('#btnSearch').click();
        });
        
        var x = 5;
	    var y = 5;
	    $(".qrCodeSmallImg").live('mouseover', function (ev) {
	        var curTrigger = $(this);
	        var productId = curTrigger.attr("data-product-id");
	        var rqCodeImageGenerateUrl = "${ctx}/admin/sa/productManage/viewWxQrCode";
	        rqCodeImageGenerateUrl += "?productId=" + productId;
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

    function shortSearch(){
        $('#btnSearch').click();
    }
        
    //上架、下架 按钮切换
    function showButtonOfArchived1(){
        $("#grid").find("button").each(function(){
            if($(this).text()=="下架"){
            	$(this).parent().show();
            }
            if($(this).text()=="上架"){
            	$(this).parent().hide();
            }
        });
    }
    function showButtonOfArchived2(){
        $("#grid").find("button").each(function(){
            if($(this).text()=="上架"){
            	$(this).parent().show();
            }
            if($(this).text()=="下架"){
            	$(this).parent().hide();
            }
        });
    }
    
    // 新增商品
    function addProduct(){
    	app.page.open({
            href:'${ctx}/admin/sa/dishesManage/addOrEdit'
        });
    }
    
    // 复制
    function copyProduct(){
    	var selectedProduct = grid.getSelection();
            if(selectedProduct.length <= 0){
                BUI.Message.Alert("请选择1件菜品进行复制!");
                return false;
            }

            if(selectedProduct.length > 1){
                BUI.Message.Alert("一次只能选择1件菜品进行复制!");
                return false;
            }

            var showName=subObj(selectedProduct[0]);
            BUI.Message.Confirm('确认要复制 "'+showName+'" 这件菜品吗?',function(){
                fullMask.hide();
                fullMask.show();
                $.ajax({
                    url : '${ctx}/admin/sa/productManage/copyProduct',
                    dataType : 'json',
                    type: 'POST',
                    data : {productId : selectedProduct[0].productId},
                    success : function(data){
                        fullMask.hide();
                        if(data.data){
                            BUI.Message.Alert('复制成功!请到 下架列表操作刚复制的菜品!');
                            search.load();
                        }else{
                            BUI.Message.Alert('复制菜品失败!');
                        }
                    }
                });
            },'question');

            return false;
    }
    
    function subObj(obj){
        var showName="";
        $.each(obj,function(key,val){
            if($.isPlainObject(val) || $.isArray(val)){
                return true
            }else{
                 if("productName" == key){
                     showName = val;
                     return false;
                }
            }
        });
        return showName;
    }
    
    // 上架
    function upShelf(){
    	var selectedGoods = grid.getSelection();
        if(selectedGoods.length <= 0){
            BUI.Message.Alert("请选择菜品!");
            return false;
        }

        var selectedGoodsIds = [];
        for(var i = 0; i < selectedGoods.length ; i++){
            selectedGoodsIds.push(selectedGoods[i].productId);
        }

        BUI.Message.Confirm('确认要设置所选菜品上架吗？',function(){
            $.ajax({
                url : '${ctx}/admin/sa/productManage/productUpOrDownShelf?type=up',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedGoodsIds},
                success : function(data){
                    app.showSuccess(data.result);
                    search.load();
                }
            });
        });
    }
    
    // 下架
    function downShelf(){
       	var selectedGoods = grid.getSelection();
        if(selectedGoods.length <= 0){
            BUI.Message.Alert("请选择菜品!");
            return false;
        }

        var selectedGoodsIds = [];
        for(var i = 0; i < selectedGoods.length ; i++){
            selectedGoodsIds.push(selectedGoods[i].productId);
        }

        BUI.Message.Confirm('确认要设置所选菜品下架吗？',function(){
            $.ajax({
                url : '${ctx}/admin/sa/productManage/productUpOrDownShelf?type=down',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedGoodsIds},
                success : function(data){
                    app.showSuccess(data.result);
                    search.load();
                }
            });
        });
    }
    
    // 导出
    function exportDishes(){
    	window.location.href = "${ctx}/admin/sa/dishesManage/exportDishes?" + $('#searchForm').serialize();
    }
    
    // 导出二维码
    function exportProdunctQrcode(){
    	var paramArray = [];
            paramArray.push("start=0");
            paramArray.push("limit=100000");
            paramArray.push("pageIndex=0");
            if($("#productId").val()!=null && $("#productId").val().length > 0){
                paramArray.push("productId=" + $("#productId").val());
            }
            if($("#categoryId").val()!=null && $("#categoryId").val().length > 0){
                paramArray.push("categoryId=" + $("#categoryId").val());
            }
            if($("#brandId").val()!=null && $("#brandId").val().length > 0){
                paramArray.push("brandId=" + $("#brandId").val());
            }
            if($("#productTypeCd").val()!=null && $("#productTypeCd").val().length > 0){
                paramArray.push("productTypeCd=" + $("#productTypeCd").val());
            }
            if($("#productStatusCd").val()!=null && $("#productStatusCd").val().length > 0){
                paramArray.push("productStatusCd=" + $("#productStatusCd").val());
            } 
            if($("#productName").val()!=null && $("#productName").val().length > 0){
                paramArray.push("productName=" + $("#productName").val());
            }	
			if($("#isEnable3").val()!=null && $("#isEnable3").val().length > 0){
                paramArray.push("isEnable3=" + $("#isEnable3").val());
            } 
            if($("#isEnable2").val()!=null && $("#isEnable2").val().length > 0){
                paramArray.push("isEnable2=" + $("#isEnable2").val());
            }  
            if($("#isEnable1").val()!=null && $("#isEnable1").val().length > 0){
                paramArray.push("isEnable1=" + $("#isEnable1").val());
            }  
            if($("#shelveChannelCds").val()!=null && $("#shelveChannelCds").val().length > 0){
                paramArray.push("shelveChannelCds=" + $("#shelveChannelCds").val());
            }
            if($("#barCode").val()!=null && $("#barCode").val().length > 0){
                paramArray.push("barCode=" + $("#barCode").val());
            }
            window.location.href = "${ctx}/admin/sa/productManage/exportRqCode"+(paramArray.length ? ("?" + paramArray.join("&")) : "");
    }
    
    // 导入商品
    function importProdunct(){
        window.location.href = "${ctx}/admin/sa/productManage/import";
    }
    
    // 维护商品单位
    /*function preserveProductUnit(){
    	 window.location.href = "${ctx}/admin/sa/productManage/unitTypeList";
    }*/
    
   
   

</script>
</body>
</html>