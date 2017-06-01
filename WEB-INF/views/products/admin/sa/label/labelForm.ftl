<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
             <ul class="breadcrumb" aria-disabled="false" aria-pressed="false">
                 <li aria-disabled="false" aria-pressed="false"><a href="${ctx}/admin/sa/label/list">个性化分类管理</a><span class="divider">&gt;&gt;</span></li>
                 <li class="active"><#if productLabel?? && productLabel?has_content>编辑个性化分类<#else>新增个性化分类</#if></li>  
            </ul>
        </div>
    </div>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/label/save" method="post">
    	<input type="hidden" name="labelId" value="<#if (productLabel.labelId)?has_content>${productLabel.labelId}</#if>">
        <input type="hidden" name="productIds" id="IDs">
        <div id="edit-div" class="form-content">
        	
        	<div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:132px;"><s>*</s>个性化编码：</label>
                    <div class="controls">
                        <input value="${(productLabel.labelNum)!?html}" name="labelNum" data-rules="{required:true,regexp:/^([A-Za-z]|[0-9]){1,20}$/}" data-messages="{regexp:'请输入正确的编码！'}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:132px;"><s>*</s>个性化名称：</label>
                    <div class="controls">
                        <input value="${(productLabel.labelName)!?html}" name="labelName" data-rules="{required:true,regexp:/^([\u4e00-\u9fa5]|[A-Za-z]|[0-9]){1,20}$/}" data-messages="{regexp:'请输入正确的名称！'}" class="input-normal control-text">
                    </div>
                </div>
            </div>
			<div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:132px;">个性化图片：</label>
                     <div class="controls">	
						<input id="file_cardBackImage" name="file" type="file" onchange="javascript:assetChange(this.value,'cardBackImage');">
					</div>
                </div>
            </div>
            <div class="row" style="height:100">
                <div class="control-group">  
                 	<label class="control-label" style="width:132px;">图像预览：</label>
                  	<div class="controls control-row-auto" >                             						                     							
						<input type="hidden" id="labelImgUrl" name="labelImgUrl" value="<#if (productLabel.labelImgUrl)?has_content>${productLabel.labelImgUrl}</#if>" class="input-normal control-text">   
						<img id="imageView_cardBackImage" width="100px" height="100px" src="<#if (productLabel.labelImgUrl)?has_content>${productLabel.labelImgUrl}</#if>" >          
                		(图片：建议90*90像素的JPG、PNG)
                		<input type="button" onclick="delItem();" value=删除图片></input>
                	</div>
               	</div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:132px;"><s>*</s>启用状态：</label>
                    <#assign labelStatusCd=0/>
	                <#if productLabel?? && productLabel?has_content>
	                	<#if productLabel.labelStatusCd?has_content && productLabel.labelStatusCd == 1>
	                    	<#assign labelStatusCd=1/>
	                	</#if>
	                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="labelStatusCd" value="1" <#if labelStatusCd==1>checked="checked" </#if> checked/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="labelStatusCd" value="0" <#if labelStatusCd==0>checked="checked" </#if> />禁用
                        </label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:132px;"><s>*</s>是否在商品列表显示：</label>
                    <#assign isShowInProductList=0/>
	                <#if productLabel?? && productLabel?has_content>
	                	<#if productLabel.isShowInProductList?has_content && productLabel.isShowInProductList == 1>
	                    	<#assign isShowInProductList=1/>
	                	</#if>
	                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="isShowInProductList" value="1" <#if isShowInProductList==1>checked="checked" </#if> checked />是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="isShowInProductList" value="0" <#if isShowInProductList==0>checked="checked" </#if>" />否
                        </label>
                    </div>
                </div>
            </div>
            <#if productLabel?? && productLabel?has_content>
	            <div class="row">
	                <div class="control-group">
	                    <label class="control-label">网址：</label>
	                    <div class="controls">
	                        /m/label/<#if (productLabel.labelId)?has_content>${productLabel.labelId}</#if>.html
	                    </div>
	                </div>
	            </div>
			</#if>
			
			<div class="row" id="productInfo">
                <ul class="toolbar">
                    <li>
                        <button id="choiceProductBtn" type="button" class="button button-info">
                            <i class="icon icon-white icon-envelope"></i>选择商品
                        </button>
                    </li>
                </ul>
                <hr>
                <div class="search-grid-container">
                    <div id="productGrid"></div>
                </div>
            </div>
			
            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
	var dialog = null;
	
	// BUI框架提交保存
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    window.location.href = "${ctx}/admin/sa/label/list";
                }
            }
        }).render();
        
		//初始化类别之后的按钮单击之后，能够弹出对话框，列出该类别的所有商品列表
		var Overlay = BUI.Overlay
		dialog = new Overlay.Dialog({
			title:'商品列表',
			width: 1000,
			height: 400,
			loader : {
				url : '${ctx}/admin/sa/label/productDialog',
				autoLoad : false, //不自动加载
				lazyLoad : false //不延迟加载
			},
			buttons:[{
				text:'选 择',
				elCls : 'button button-primary',
				handler : function(){
					this.close();
					productChoiceEvent(getSelectedRecords());
				}
			}],
			mask:true
		});
		initProductCondition();
        initChoiceProductBtnEvent();
		submitIDs();
		
		//点击重置的时候也把图片给重置掉
		$('button[type="reset"]').click(function() {
			$('#labelImgUrl').val('${(productLabel.labelImgUrl)!}');
			$('#imageView_cardBackImage').attr("src","${(productLabel.labelImgUrl)!}");
			<#if productLabel?? && productLabel?has_content && productLabel.labelStatusCd==1>
				$('input[name="labelStatusCd"][value="1"]').attr("checked",true);
			<#else>
				$('input[name="labelStatusCd"][value="0"]').attr("checked",true);
			</#if>
			<#if productLabel?? && productLabel?has_content && productLabel.isShowInProductList==1>
				$('input[name="isShowInProductList"][value="1"]').attr("checked",true);
			<#else>
				$('input[name="isShowInProductList"][value="0"]').attr("checked",true);
			</#if>
			
		});
    });
    
    /**
     * 构建商品表格
     *
     */
    var Grid = BUI.Grid,
            Data = BUI.Data,
            Store = Data.Store;
    var productColumns = [
        {title: '商品ID', dataIndex: 'productId', width: 80},
        {
            title: '商品名称',
            dataIndex: 'productName',
            width: 120,
            renderer: function (value) {
                return app.grid.format.encodeHTML(value);
            }
        },
        {title: '品牌名称', dataIndex: 'brandName', width: 120},
        {title: '分类名称', dataIndex: 'categoryName', width: 120},
        {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
        {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
        {title: '更新时间', dataIndex: 'lastUpdateTime', width: 180,renderer:BUI.Grid.Format.datetimeRenderer},
        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
            return delStr;
        }}
    ];
    
    var productStore;
    var productGrid;
    function buildProductGrid(){
        productStore = new Store({
            url : '${ctx}/admin/sa/label/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : productConditionIdArray.join(",")
            },
            pageSize : 5
        });
        productGrid = new Grid.Grid({
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            render:'#productGrid',
            columns : productColumns,
            store: productStore,
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:true
            },
            loadMask:true
        });

        //监听事件，删除一条记录
        productGrid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                deleteProduct(record);
            }
        });

        productGrid.render();
    }

    function deleteProduct(record){
        BUI.Message.Confirm('确认删除记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + productConditionIdArray.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            productConditionIdArray = tempArray;

            reloadProductCondition();
        },'question');
    }

	/**
     * 初始化
     *
     * @type {Array}
     */
    var productConditionIdArray = [];
    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initProductCondition(){
	    var isNew = ${isNew};
	    if(isNew){
	        buildProductGrid();
	    }else {
            <#if productLabelXrefList?? && productLabelXrefList?has_content>
                <#list productLabelXrefList as key>
                    productConditionIdArray.push(${key.productId});
                </#list>
            </#if>
            buildProductGrid();

            if(productConditionIdArray.length > 0){
                productStore.load();
            }
        }
	}
	//初始化点击商品列表，显示商品弹出窗口
    function initChoiceProductBtnEvent(){
        $("#choiceProductBtn").on('click', function(){
            dialog.get('loader').load();
            dialog.show();
        });
    }

	//去除选中的重复商品
    function productChoiceEvent(selectedProduct){
        var oldProductStr = "";
        oldProductStr = "," + productConditionIdArray.join(',') + ",";
        for(var i = 0; i < selectedProduct.length; i++){
            var id = selectedProduct[i].productId;
            if(oldProductStr.indexOf("," + id + ",") < 0){
                productConditionIdArray.push(id);
            }
        }
        reloadProductCondition();
    }

	//重新加载数据
    function reloadProductCondition(){
        if(!productStore){
            buildProductGrid();
            if(productConditionIdArray.length > 0){
                productStore.load();
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        } else {
            if(productConditionIdArray.length > 0){
                var params = { //配置初始请求的参数
                    start : 0,
                    "in_id" : productConditionIdArray.join(",")
                };
                productStore.load(params);
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        }
    }
    
    //提交时收取所有商品的ID，并存放在一个隐藏的文本框中
    function submitIDs() {
    	$('.button-primary').on('click',function(){
        	$("#IDs").val(productConditionIdArray.join(","));
        });
    }
    
    // 图片上传
    function assetChange(fileName,lastFlag){
        if(fileName == null || fileName.trim().length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }
        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        var suffix = fileName.substr(suffixIndex + 1);
        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        $.ajaxFileUpload({
            url:'${ctx}/common/staticAsset/upload/label',
            secureuri: false,
            fileElementId: "file_"+lastFlag,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                loadImage(data.displayAssetUrl,data.assetUrl,lastFlag);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }
    //设置预览图片
    function loadImage(url,assetUrl,lastFlag) {
        $('#labelImgUrl').val(assetUrl);
        $("#imageView_"+lastFlag).attr("src", assetUrl);
        $("#imgPath_"+lastFlag).val(assetUrl);
        $("#imgArea_"+lastFlag).show();
    }
    
    //删除图片
    function delItem(){
    	$('#labelImgUrl').val(' ');
    	$('#imageView_cardBackImage').attr('src',"");
    }
    
</script>
</body>
</html>