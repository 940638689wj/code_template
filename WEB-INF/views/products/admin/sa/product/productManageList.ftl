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
	    <@selectFast productBrandList "brandId" "brandName" "所有品牌" "product_brandId" "product_brandId"></@selectFast>
	    <@selectFast productGroupList "productGroupId" "groupName" "所有分组" "product_productGroupId" "product_productGroupId"></@selectFast>

		<select name="product_categoryId" id="product_categoryId" class="input-normal">
                    	<option value="">所有分类</option>
	                    <#if productCategoryList?has_content>
        					<#list productCategoryList as parentCategory>
				  				<@showCategoryChild  parentCategory 0/>
        					</#list>
        				</#if>
                    </select>
            <div class="tips-wrap tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i
                    class="icon icon-white icon-volume-up"></i></span>
                <div class="tips-content">提示: 当用户付款成功后才减库存</div>
            </div>

	</div>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" class="control-text" placeholder="商品名称" id="short_productName" /><button onclick="shortSearch()"></button>
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                	<input type="hidden" id="productTypeCd" name="productTypeCd" value="1">
                	<input type="hidden" name="productStatusCd" id="productStatusCd" value="${(productStatusCd)!}"/>
                	<input type="hidden" name="categoryId" id="categoryId" value="">
                	<input type="hidden" name="brandId" id="brandId" value="">
                	<input type="hidden" name="productGroupId" id="productGroupId" value="">
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">商品ID：</label>
                            <div class="controls">
                                <input id="productId" name="productId" class="control-text" placeholder="输入商品ID">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">商品名称：</label>
                            <div class="controls">
                                <input name="productName" id="productName" class="control-text" placeholder="输入商品名称">
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
	    <div>
        <input type="hidden"  name="productIds" value=""/>
	     <div id="setProductBrandContent" class="well" style="display: none;">
            <div class="form-horizontal">
                <div class="form-content">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:120px;">商品品牌：</label>
                            <div class="controls">
                                <select name="productBrandId" id="productBrandId">
                                    <option value="-1">请选商品品牌</option>
                                    <#if productBrandList?has_content>
                                        <#list productBrandList as brand>
                                            <option value="${brand.brandId}">${(brand.brandName)!?html}</option>
                                        </#list>
                                    </#if>
                                </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
        	</div>
        </div>
        <div>
		<div id="productGroup" class="well" style="display: none;">
            <input type="hidden"  name="groupIds" value=""/>
            <div class="form-horizontal">
                <div class="form-content">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:120px;">商品分组：</label>
                            <div class="controls">
                                <select name="groupIdf" id="groupIdf" class="input-normal">
			                    	<option value="">所有分组</option>
				                    <#if productGroupList?has_content>
                                        <#list productGroupList as group>
                                            <option value="${group.productGroupId}">${(group.groupName)!?html}</option>
                                        </#list>
                                    </#if>
			                    </select>
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
                            <label class="control-label" style="width:120px;">商品分类：</label>
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
					                    <input   id="productPointValue1"  name= "" type="text" data-rules="{min:0,number:true}" class="input-small control-text"   >&nbsp;元
					                </div>
					                <div>
					                    <input type="radio" name="scoreDisCountTypeCd"  value="2" onclick="showCont()" >
					                    <input   id="productPointValue2"  name= "" type="text" data-rules="{min:0,max:100,number:true}" class="input-small control-text"   >&nbsp;%
					               	</div>
				                </div>
	                        </div>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	    <div id="productPointTypeCdContent" class="well" style="display: none;">
	           <input type="hidden"  name="productPointTypeCdIds" value=""/>
	            <form id="batchSetPointForm" class="form-horizontal" method="post">
	                <div id="edit-div" class="form-content">
	                    <div class="row">
	                        <div class="control-group">
	                         <label class="control-label control-label-maxlong">单产品基础业绩点：</label>
				                <div class="controls">
					                <div>
					                    <input type="radio" name="productPointTypeCd" id="productPointTypeCd1" value="1" onclick="showCont2()" >
					                    <input   id="pointValue1"  name= "" type="text" data-rules="{min:0,number:true}" class="input-small control-text"   >&nbsp;业绩点
					                </div>
					                <div>
					                    <input type="radio" name="productPointTypeCd" id="productPointTypeCd2" value="2" onclick="showCont2()" >
					                    商品金额&nbsp;<s style="color: red;">*</s><input   id="pointValue2"  name= "" type="text" data-rules="{min:0,max:100,number:true}" class="input-small control-text"   >&nbsp;%
					               	</div>
				                </div>
	                        </div>
	                    </div>
	                </div>
	            </form>
	        </div>
	    </div>
	    <div id="setShowStock" class="well" style="display: none;">
            <label class="control-label">前台不显示：</label>
            <input type="checkbox" id="hideStock" >
        </div>
       	<div id="setShowPrice" class="well" style="display: none;">
            <label class="control-label">前台不显示：</label>
            <input type="checkbox" id="hidePrice" >
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
			{text:'上架商品',value:'1'},
            {text:'下架商品',value:'2'}
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
                    href: "${ctx}/admin/sa/productManage/addOrEdit?productId=" + rowObj.productId
                });
                var deleteStr ="";
<@securityAuthorize ifAnyGranted="delete">
                deleteStr = "<span class='grid-command' onclick=\"javascript:deleteProduct0('" + rowObj.productId + "')\">删除</span>";
</@securityAuthorize>
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
//            {title : '货号',dataIndex : 'barCode',width:100},
            {title : '库存',dataIndex : 'sum',width:100},

            {title : '库存预警',dataIndex : 'stockWarningLimit',width:100},
//            {title : '品牌',dataIndex : 'brandName',width:100},
            {title : '系列分类',dataIndex : 'categoryName',width:100},
            {title : '销售价',dataIndex : 'defaultPrice',width:80},
            {title : '吊牌价',dataIndex : 'tagPrice',width:80},
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
                    {text : '新增商品',btnCls : 'button button-small button-primary',handler:addProduct},
                    {text : '导入商品',btnCls : 'button button-small',handler:importProduct},
                    {text : '商品入库',btnCls : 'button button-small',handler:putIntoStorage},
                    {text : '导入价格',btnCls : 'button button-small',handler:importPrice},
                    {text : '复制',btnCls : 'button button-small',handler:copyProduct},
                <@securityAuthorize ifAnyGranted="delete">
                    {text : '删除',btnCls : 'button button-small',handler:deleteProduct},
                </@securityAuthorize>
                    {text : '上架',btnCls : 'button button-small',handler:upShelf},
                   	{text : '下架',btnCls : 'button button-small',handler:downShelf},
                   	{text : '设置全局库存预警',btnCls : 'button button-small',handler:setWarning},
                   	{text : '置顶商品',btnCls : 'button button-small',handler:topTime1Product},
                    {text : '取消置顶商品',btnCls : 'button button-small',handler:topTime0Product},
                    {text : '设置品牌',btnCls : 'button button-small',handler:setProductBrand},
                    {text : '设置商品分组',btnCls : 'button button-small',handler:setGroup},
                    {text : '设置商品分类',btnCls : 'button button-small',handler:setCategory},
                    {text : '前台隐藏库存',btnCls : 'button button-small', handler: function() {
                            var ids = getSelectProducts4Array();
                            if (!ids || ids.length <= 0) return BUI.Message.Alert("请选择商品！");
                            var dialog = new BUI.Overlay.Dialog({
                                title: "隐藏库存",
                                width:260,
                                contentId: "setShowStock",
                                closeAction: "destroy",
                                buttons: [
                                    {
                                        text:'确 定',
                                        elCls: 'button button-primary',
                                        handler : function(){
                                            $.post("${ctx}/admin/sa/productManage/setShowStock", {ids: ids, on: $("#hideStock:checked").length ? "1" : "0"}, function(data) {
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
                     {text : '前台隐藏商品金额',btnCls : 'button button-small', handler: function() {
                            var ids = getSelectProducts4Array();
                            if (!ids || ids.length <= 0) return BUI.Message.Alert("请选择商品！");
                            var dialog = new BUI.Overlay.Dialog({
                                title: "隐藏商品金额",
                                width:260,
                                contentId: "setShowPrice",
                                closeAction: "destroy",
                                buttons: [
                                    {
                                        text:'确 定',
                                        elCls: 'button button-primary',
                                        handler : function(){
                                            $.post("${ctx}/admin/sa/productManage/setShowPrice", {ids: ids, on: $("#hidePrice:checked").length ? "0" : "1"}, function(data) {
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
                    {text : '导出',btnCls : 'button button-small',handler:exportProduct},
                    {text : '导出明细',btnCls : 'button button-small',handler:exportDetailProduct},
                    {text : '导出二维码',btnCls : 'button button-small',handler:exportProdunctQrcode},
					{text : '设置单产品业绩点',btnCls : 'button button-small',handler:setProductPointTypeCd}
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
	function setProductPointTypeCd() {
        $("#pointValue1").val("");
        $("#pointValue2").val("");
        $("#productPointTypeCd1").attr("checked", false);
        $("#productPointTypeCd2").attr("checked", false);

        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择商品!");
            return false;
        }
        if (selectedCustomer.length == 1) {
            $.post('${ctx}/admin/sa/productManage/getPoint',{"productId":selectedCustomer[0].productId},function (data){
               if(data.result=="success"){
                   console.log(data);
                   if(data.data.productPointTypeCd!=null) {
                       if (data.data.productPointTypeCd == 1) {
                           $("#productPointTypeCd1").attr("checked", true);
                           $("#pointValue1").val(data.data.productPointValue);
                       } else if (data.data.productPointTypeCd == 2) {
                           $("#productPointTypeCd2").attr("checked", true);
                           $("#pointValue2").val(data.data.productPointValue);
                       }
                   }
               }else{
                   app.showError("查询失败，请刷新重试！");
                   return;
               }
            });
            $("input[name='productPointTypeCdIds']").val(selectedCustomer[0].productId);
        } else {
            var selectedCustomerIds = [];
            for (var i = 0; i < selectedCustomer.length; i++) {
                selectedCustomerIds.push(selectedCustomer[i].productId);
            }
            $("input[name='productPointTypeCdIds']").val(selectedCustomerIds.join(","));
         }
        setProductPointTypeCdDialog.show();
    }
    setProductPointTypeCdDialog = new Overlay.Dialog({
            title:'设置单产品业绩点',
            width:650,
            height:220,
            //配置DOM容器的编号
            contentId:'productPointTypeCdContent',
            success:function () {
                var dialogObj = this;
                var productPointTypeCd = $("[name='productPointTypeCd']:checked").val(),
                    productPointValue = $("[name='pointValue']").val();
                if (isNaN(productPointValue)) {
                    BUI.Message.Alert("请输入数值!");
                    return false;
                }
                if(productPointValue==""){
                  	BUI.Message.Alert("请输入数值!");
                    return false;
                }
                if(productPointValue != "" && !YrValidator.isNotNegativeInteger(productPointValue)){
                    BUI.Message.Alert("抵扣值必须为正整数!");
                    return false;
                    }
                if(productPointTypeCd==2){
                	if(productPointValue>100){
                	 BUI.Message.Alert("不可以超过100%");
                     return false;
                    }
                }

                var productPointTypeCdIds = $("input[name='productPointTypeCdIds']").val();
                var selectedProductPointTypeCdIds = productPointTypeCdIds.split(",");
                if (selectedProductPointTypeCdIds.length <= 0) {
                    BUI.Message.Alert("请选择商品!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setProductPointTypeCd',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedProductPointTypeCdIds, productPointTypeCd: productPointTypeCd, productPointValue: productPointValue},
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
    function putIntoStorage(){
            app.page.open({
                href:'${ctx}/admin/sa/putIntoStock'
            	//href:'${ctx}/admin/sa/productManage/putIntoStock'
            });
        }
	function setMaxmoneyByPoint(){
        var selectedCustomer = grid.getSelection();
        if(selectedCustomer.length <= 0){
            BUI.Message.Alert("请选择商品!");
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
                    productPointValue = $("[name='productPointValue']").val();
                if (isNaN(productPointValue)) {
                    BUI.Message.Alert("请输入数值!");
                    return false;
                }
                if(productPointValue==""){
                  	BUI.Message.Alert("请输入数值!");
                    return false;
                }
                if(productPointValue != "" && !YrValidator.isNotNegativeInteger(productPointValue)){
                    BUI.Message.Alert("抵扣值必须为正整数!");
                    return false;
                    }
                if(scoreDisCountTypeCd==2){
                	if(productPointValue>100){
                	 BUI.Message.Alert("不可以超过100%");
                     return false;
                    }
                }

                var scoreDisCountIds = $("input[name='scoreDisCountIds']").val();
                var selectedScoreDisCountIdsIds = scoreDisCountIds.split(",");
                if (selectedScoreDisCountIdsIds.length <= 0) {
                    BUI.Message.Alert("请选择商品!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setPoint',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedScoreDisCountIdsIds, scoreDisCountTypeCd: scoreDisCountTypeCd, productPointValue: productPointValue},
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
      function setGroup(){
        var selectedGroupId = grid.getSelection();
	        if(selectedGroupId.length <= 0){
	            BUI.Message.Alert("请选择商品!");
	            return false;
	        }

	        var selectedGroupIds = [];
	        for(var i = 0; i < selectedGroupId.length ; i++){
	            selectedGroupIds.push(selectedGroupId[i].productId);
	        }
	        $("input[name='groupIds']").val(selectedGroupIds.join(","));

	        setGroupDialog.show();
    	}
    	 var Overlay = BUI.Overlay
        setGroupDialog = new Overlay.Dialog({
            title:'设置商品分组',
            width:380,
            //配置DOM容器的编号
            contentId:'productGroup',
            success:function () {
                var dialogObj = this;
                var groupIdf = $("#groupIdf").val();
                if(categoryIdf == "-1"){
                    BUI.Message.Alert("请选择商品分组!");
                    return false;
                }

                var groupIds = $("input[name='groupIds']").val();
                var selectedGroupIds = groupIds.split(",");

                if(selectedGroupIds.length <= 0){
                    BUI.Message.Alert("请选择商品!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setGroup',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedGroupIds,groupId:groupIdf},
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
	            BUI.Message.Alert("请选择商品!");
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
            title:'设置商品分类',
            width:380,
            //配置DOM容器的编号
            contentId:'userLevelContent',
            success:function () {
                var dialogObj = this;
                var categoryIdf = $("#categoryIdf").val();
                if(categoryIdf == "-1"){
                    BUI.Message.Alert("请选择商品分类!");
                    return false;
                }

                var customerIds = $("input[name='customerIds']").val();
                var selectedCustomerIds = customerIds.split(",");

                if(selectedCustomerIds.length <= 0){
                    BUI.Message.Alert("请选择商品!");
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
        <#--设置商品 品牌-->
        var Overlay = BUI.Overlay
        setProductBrandDialog = new Overlay.Dialog({
            title:'设置商品品牌',
            width:380,
            //配置DOM容器的编号
            contentId:'setProductBrandContent',
            success:function () {
                var dialogObj = this;

                var productBrandId = $("#productBrandId").val();
                if(productBrandId == "-1"){
                    BUI.Message.Alert("请选择商品品牌!");
                    return false;
                }

                var productIds = $("input[name='productIds']").val();
                var selectedProductIds = productIds.split(",");

                if(selectedProductIds.length <= 0){
                    BUI.Message.Alert("请选择商品!");
                    return false;
                }

                $.ajax({
                    url : '${ctx}/admin/sa/productManage/setProductBrand',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : selectedProductIds,productBrandId:productBrandId},
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
        function setProductBrand(){
	        var selectedProduct = grid.getSelection();
	        if(selectedProduct.length <= 0){
	            BUI.Message.Alert("请选择商品!");
	            return false;
	        }

	        var selectedProductIds = [];
	        for(var i = 0; i < selectedProduct.length ; i++){
	            selectedProductIds.push(selectedProduct[i].productId);
	        }

	        $("input[name='productIds']").val(selectedProductIds.join(","));
	        setProductBrandDialog.show();
    	}
        //置顶商品
	    function topTimeProduct(productId,status){
	        if(!productId){
	            return;
	        }

	        var msg="置顶";
	        if(status =='0'){
	            msg="取消置顶";
	        }

	        BUI.Message.Confirm('确定要'+msg+'商品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/topTimeProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {productId : productId,status:status},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess('商品'+msg+'成功。');
	                        search.load();
	                    }else{
	                        app.showSuccess('商品'+msg+'失败!');
	                    }
	                }
	            });
	        },'question');
	    }
        //批量 置顶商品
	    function topTime1Product(){
	        var selectedProducts = grid.getSelection();
	        if(selectedProducts.length <= 0){
	            BUI.Message.Alert("请选择需要操作的商品!");
	            return false;
	        }

	        var selectedProductIds = [];
	        for(var i = 0; i < selectedProducts.length ; i++){
	            selectedProductIds.push(selectedProducts[i].productId);
	        }

	        BUI.Message.Confirm('确定要置顶所选商品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/topTimeProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {ids : selectedProductIds,status:'1'},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess('商品置顶成功。');
	                        search.load();
	                    }else{
	                        app.showSuccess('商品置顶失败!');
	                    }
	                }
	            });
	        },'question');
	    }
	    //批量 取消置顶
	    function topTime0Product(){
	        var selectedProducts = grid.getSelection();
	        if(selectedProducts.length <= 0){
	            BUI.Message.Alert("请选择需要操作的商品!");
	            return false;
	        }

	        var selectedProductIds = [];
	        for(var i = 0; i < selectedProducts.length ; i++){
	            selectedProductIds.push(selectedProducts[i].productId);
	        }

	        BUI.Message.Confirm('确定要取消置顶所选商品吗?',function(){
	            $.ajax({
	                url : '${ctx}/admin/sa/productManage/topTimeProduct',
	                dataType : 'json',
	                type: 'POST',
	                data : {ids : selectedProductIds,status:'0'},
	                success : function(data){
	                    if(data.result == "success"){
	                        app.showSuccess('商品取消置顶成功。');
	                        search.load();
	                    }else{
	                        app.showSuccess('商品取消置顶失败!');
	                    }
	                }
	            });
	        },'question');
	    }
		//删除
	    function deleteProduct(){

	    	var selectedGoods = grid.getSelection();
	        if(selectedGoods.length <= 0){
	            BUI.Message.Alert("请选择商品!");
	            return false;
	        }

	        var selectedGoodsIds = [];
	        for(var i = 0; i < selectedGoods.length ; i++){
	            selectedGoodsIds.push(selectedGoods[i].productId);
	        }

	        BUI.Message.Confirm('确认删除所选商品吗？',function(){
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

        BUI.Message.Confirm('确定要删除该商品吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/productManage/deleteProduct',
                dataType : 'json',
                type: 'POST',
                data : {productId : productId},
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("商品删除成功。");
                        search.load();
                    }else{
                        app.showSuccess("商品删除失败!");
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
			  $("#productPointValue2").val("");
			  $("#productPointValue2").attr("readonly",true);
			  $("#productPointValue2").attr("disabled",true);
			  $("#productPointValue1").removeAttr("readonly");
			  $("#productPointValue1").removeAttr("disabled");
			  $("#productPointValue1").attr("name","productPointValue");
			  $("#productPointValue2").removeAttr("name");
			   break;
			  case "2":
			 $("#productPointValue1").val("");
			 $("#productPointValue1").attr("readonly",true);
			 $("#productPointValue1").attr("disabled",true);
			 $("#productPointValue2").removeAttr("readonly");
			 $("#productPointValue2").removeAttr("disabled");
			 $("#productPointValue2").attr("name","productPointValue");
			 $("#productPointValue1").removeAttr("name");
			   break;
			  default:
			   break;
			 }
	}
	function showCont2(){
		switch($("input[name=productPointTypeCd]:checked").attr("value")){
			  case "1":
			  //alert("one");
			  $("#pointValue2").val("");
			  $("#pointValue2").attr("readonly",true);
			  $("#pointValue2").attr("disabled",true);
			  $("#pointValue1").removeAttr("readonly");
			  $("#pointValue1").removeAttr("disabled");
			  $("#pointValue1").attr("name","pointValue");
			  $("#pointValue2").removeAttr("name");
			   break;
			  case "2":
			 $("#pointValue1").val("");
			 $("#pointValue1").attr("readonly",true);
			 $("#pointValue1").attr("disabled",true);
			 $("#pointValue2").removeAttr("readonly");
			 $("#pointValue2").removeAttr("disabled");
			 $("#pointValue2").attr("name","pointValue");
			 $("#pointValue1").removeAttr("name");
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
        $('#product_brandId,#product_categoryId,#product_productGroupId').change(function(){
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
            href:'${ctx}/admin/sa/productManage/addOrEdit'
        });
    }

    // 复制
    function copyProduct(){
    	var selectedProduct = grid.getSelection();
            if(selectedProduct.length <= 0){
                BUI.Message.Alert("请选择1件商品进行复制!");
                return false;
            }

            if(selectedProduct.length > 1){
                BUI.Message.Alert("一次只能选择1件商品进行复制!");
                return false;
            }

            var showName=subObj(selectedProduct[0]);
            BUI.Message.Confirm('确认要复制 "'+showName+'" 这件商品吗?',function(){
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
                            BUI.Message.Alert('复制成功!请到 下架列表操作刚复制的商品!');
                            search.load();
                        }else{
                            BUI.Message.Alert('复制商品失败!');
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
            BUI.Message.Alert("请选择商品!");
            return false;
        }

        var selectedGoodsIds = [];
        for(var i = 0; i < selectedGoods.length ; i++){
            selectedGoodsIds.push(selectedGoods[i].productId);
        }

        BUI.Message.Confirm('确认要设置所选商品上架吗？',function(){
            $.ajax({
                url : '${ctx}/admin/sa/productManage/productUpOrDownShelf?type=up',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedGoodsIds},
                success : function(data){
                    if(data.resultType=="1"){
                        app.showError(data.result);
                    }else{
                        app.showSuccess(data.result);
                    }
                    search.load();
                }
            });
        });
    }

    // 下架
    function downShelf(){
       	var selectedGoods = grid.getSelection();
        if(selectedGoods.length <= 0){
            BUI.Message.Alert("请选择商品!");
            return false;
        }

        var selectedGoodsIds = [];
        for(var i = 0; i < selectedGoods.length ; i++){
            selectedGoodsIds.push(selectedGoods[i].productId);
        }

        BUI.Message.Confirm('确认要设置所选商品下架吗？',function(){
            $.ajax({
                url : '${ctx}/admin/sa/productManage/productUpOrDownShelf?type=down',
                dataType : 'json',
                type: 'POST',
                data : {id : selectedGoodsIds},
                success : function(data){
                    if(data.resultType=="1"){
                        app.showError(data.result);
                    }else{
                        app.showSuccess(data.result);
                    }
                    search.load();
                }
            });
        });
    }

    // 导出
    function exportProduct(){
    	window.location.href = "${ctx}/admin/sa/productManage/exportProduct?" + $('#searchForm').serialize();
    }
    //导出商品明细--最多导出9999条
    function exportDetailProduct() {
        window.location.href = "${ctx}/admin/sa/productManage/exportDetailProduct?" + $('#searchForm').serialize()+ "&start=0&pageSize=9999";
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
    function importProduct(){
        window.location.href = "${ctx}/admin/sa/productManage/import";
    }
    // 商品价格
    function importPrice(){
        window.location.href = "${ctx}/admin/sa/productManage/importPrice";
    }
    // 维护商品单位
    /*function preserveProductUnit(){
    	 window.location.href = "${ctx}/admin/sa/productManage/unitTypeList";
    }*/




</script>
</body>
</html>