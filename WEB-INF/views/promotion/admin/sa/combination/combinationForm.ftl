<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
	<script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/promotion/combination/list">搭配套餐</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if (promotion.promotionId)??>编辑<#else>新增</#if>搭配套餐</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/promotion/combination/save" method="post">
        <input type="hidden" name="promotionId" id="promotionId" value="${(promotion.promotionId)!}">

        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>搭配套餐名称：</label>
                    <div class="controls">
                        <input value="${(promotion.promotionName)!?html}" name="promotionName" data-rules="{required:true,maxlength:50}" class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>搭配套餐描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="promotionDesc" data-rules="{required:true,maxlength:255}" class="control-row4 input-large">${(promotion.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <#assign statusCd=0/>
                    <#if (promotion.promotionId)?? && (promotion.statusCd)?? && promotion.statusCd == 1>
                        <#assign statusCd=1/>
                    </#if>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1" <#if statusCd==1>checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0" <#if statusCd==0>checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>有效使用日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (promotion.enableStartTime)?has_content>
                            <input disabled type="text" class="calendar calendar-time control-text" name="enableStartTime" data-rules="{required:true}" value="${(promotion.enableStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar calendar-time control-text" name="enableStartTime" data-rules="{required:true}" value="">
                        </#if>
                        <span>至</span>
                        <#if (promotion.enableEndTime)?has_content>
                            <input disabled type="text" class="calendar calendar-time control-text" name="enableEndTime" data-rules="{required:true}" value="${(promotion.enableEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar calendar-time control-text" name="enableEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员级别：</label>
                    <div class="controls control-row-auto">
                        <#assign isAllUserLevel = (promotion.isAllUserLevelJoin)?default(false)/>
                        <label class="checkbox">
                            <input <#if promotion??>disabled</#if><#if isAllUserLevel> checked="checked" </#if> id="allUserLevel" name="allUserLevel" value='1' type="checkbox">
                            全选
                        </label><br>

                        <#if userLevelList?? && (userLevelList?size > 0)>
                            <#assign temp = 1>
                            <#list userLevelList as userLevel>
                                <#assign userLevelId = (userLevel.userLevelId)?string>
                                <#assign userLevelSelect = false/>
                                <#if (userLevelXrefMap[userLevelId])??>
                                    <#assign userLevelSelect = true/>
                                </#if>

                                <label class="checkbox">
                                    <input name="userLevel" <#if promotion??>disabled</#if> <#if userLevelSelect> checked='checked' </#if> type="checkbox" value="${(userLevel.userLevelId)!}">
                                    ${(userLevel.userLevelName)!}
                                </label>&nbsp;&nbsp;

                                <#if temp % 6 == 0>
                                    <br>
                                </#if>
                                <#assign temp = temp + 1 >
                            </#list>
                        </#if>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label">活动详情：</label>
                    <div class="controls control-row-auto">
                        <script type="text/plain" id="editor" name="promotionLongDesc">${(promotion.promotionLongDesc)?default("<p></p>")}</script>
                    </div>
                </div>
            </div>

            <div id="edit-div" class="well control-group">
	        	<input type="hidden" name="selectProductIds" value="">
	        	<input type="hidden" name="combinationPrices" value="">
	            <div class="row" id="productInfo">
	                <ul class="toolbar">
	                    <li><button id="choiceProductBtn" type="button" class="button button-info"><i class="icon icon-white icon-envelope"></i> 选择商品</button></li>
	                </ul>
	                <hr>
	                <div class="search-grid-container">
	                    <div id="productGrid"></div>
	                </div>
	            </div>
	        </div>
            
            <div class="actions-bar">
                <button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>


<script type="text/javascript">
    var dialogregion = null;
    var choiceProductDialog = null;
    var selectProductIds = [];

    BUI.use('bui/overlay',function(Overlay){
        choiceProductDialog = new Overlay.Dialog({
            title:'商品列表',
            width: 838,
            height: 460,
            loader : {
                url : '${ctx}/admin/sa/promotion/productDialog/productList?productTypeCd=1&showSku=1',
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
        {title: '吊牌价', dataIndex: 'tagPrice', width: 100},
        {title: '销售价', dataIndex: 'defaultPrice', width: 100},
        {title: '搭配价', dataIndex: 'price', width: 180,renderer : function(value,obj){
            if(value) {
        		value = '<input type="text" <#if promotion??>disabled</#if> id="combinationPrice_'+ obj.productId +'" value="'+value+'">';
        	} else {
        		value = '<input type="text" id="combinationPrice_'+ obj.productId +'">';
        	}
            return value;
        }},
        <#if !promotion??>
	        {title: '操作',dataIndex:'',width:120,renderer : function(value,obj){
	            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
	            return delStr;
	        }}
        </#if>
    ];
    
    var productStore;
    var productGrid;
    function buildProductGrid(){
        productStore = new Store({
            <#if promotion??>
	            url : '${ctx}/admin/sa/promotion/productDialog/combinationProduct/grid_json',
        	<#else>
	            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
        	</#if>
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : selectProductIds.join(','),
                <#if promotion??>
                "promotionId" : ${(promotion.promotionId)!},
                </#if>
            },
            pageSize : 5
        });
        
        productGrid = new Grid.Grid({
            render : '#productGrid',
            columns : productColumns,
            store: productStore,
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:false
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
    
    //删除商品操作
    function deleteProduct(record){
        BUI.Message.Confirm('确认删除记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + selectProductIds.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            selectProductIds = tempArray;

            reloadProductCondition();
        },'question');
    }
    
    /**
    * 初始化
    */
    
    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initProductCondition(){
	    var isNew = $('input[name="promotionId"]').val();//如果promotionId有就是编辑操作
	    
	    if(!isNew){
	       buildProductGrid();
	    }else {
            <#if productIds?? && productIds?has_content>
            	<#assign ids = "'" +productIds+"'">
            	var productIds = ${ids};
            	selectProductIds = productIds.split(',');
            </#if>
            buildProductGrid();

            if(selectProductIds.length > 0){
                productStore.load();
            }
        }
	}
	//添加新的商品时，去除重复商品
	function productChoiceEvent(selectedProduct){
        var oldProductStr = "";
        oldProductStr = "," + selectProductIds.join(',') + ",";
        for(var i = 0; i < selectedProduct.length; i++){
            var id = selectedProduct[i].productId;
            if(oldProductStr.indexOf("," + id + ",") < 0){
                selectProductIds.push(id);
            }
        }
        reloadProductCondition();
    }
	//重新加载数据
    function reloadProductCondition(){
        if(!productStore){
            buildProductGrid();
            if(selectProductIds.length > 0){
                productStore.load();
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        } else {
            if(selectProductIds.length > 0){
                var params = { //配置初始请求的参数
                    start : 0,
                    "in_id" : selectProductIds.join(",")
                };
                productStore.load(params);
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        }
    }
    
    //延时启用保存按钮
	function remainTime(){
		//打开提交按钮
		btn=document.getElementById('save');
		btn.disabled=false;
	}
    
	
    $(function(){
    	<#--富文本编辑器初始化-->
    	window.msg_editor = new UE.ui.Editor({initialFrameWidth: 1000, initialFrameHeight: 200});
        window.msg_editor.render("editor");
        
    	//会员操作
        $("#allUserLevel").on('change', function(){
            $("input[name='userLevel']").prop("checked", this.checked);
        });
        <#if isAllUserLevel>
            $("#allUserLevel").trigger('change');
        </#if>
        
        $("input[name='userLevel']").on('change', function(){
            var $subs = $("input[name='userLevel']");
            $("#allUserLevel").prop("checked", $subs.length == $subs.filter(":checked").length ? true :false);
        });
        
		//点击选择商品显示商品列表窗口
        $("#choiceProductBtn").on('click', function(){
        	<#--编辑时，不能选择商品-->
        	<#if promotion??>
        		return;
        	</#if>
            choiceProductDialog.get('loader').load();
            choiceProductDialog.show();
        });   

		//表单提交
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/combination/list";
                }
            }
        });
        
        //提交表单之前，检查：如果选择的是指定商品，却没有选择商品则给提示
        form.on('beforesubmit', function(){
        	btn=document.getElementById('save');
			btn.disabled=true;
        	
        	var selectUserLevelCount=$("input[name='userLevel']").filter(":checked").length;
            if(selectUserLevelCount <1){
                app.showError('请选择会员级别!');
                setTimeout("remainTime()",1100);
                return false;
            }
                
            if(selectProductIds.length < 2){
                app.showError('请至少选择2件商品!');
                setTimeout("remainTime()",1100);
                return false;
            }
            var combinationPrices = [];
            for(var i = 0; i < selectProductIds.length; i++) {
            	var productId = selectProductIds[i];
            	var combinationPrice = $('#combinationPrice_'+productId).val();
            	if(combinationPrice == '') {
            		app.showError('请填写商品的组合价格!');
            		setTimeout("remainTime()",1100);
            		return false;
            	}
            	
               var reg = /^(([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/;
	           if(!reg.test(combinationPrice)){
	               app.showError('请填写大于0的合法商品组合价格,且整数位不能超过16位!');
	               setTimeout("remainTime()",1100);
            	   return false;
               }
            	
            	combinationPrices[i] = combinationPrice;
            }
            $('input[name="selectProductIds"]').val(selectProductIds.join(','));
			$('input[name="combinationPrices"]').val(combinationPrices.join(','));
            return true;
        })
        
        form.render();
        
        initProductCondition();
        
        //重置按钮
        $('.actions-bar button[type="reset"]').click(function() {
        	//如果是编辑操作,只重置启用状态
            <#if (promotion.promotionId)??>
            	$('.controls input[name="statusCd"][value="${(promotion.statusCd)!default(1)}"]').attr("checked",true);
            	return;
            </#if>
            $('.controls input[name="statusCd"][value="1"]').attr("checked",true);
        });
    });

	//显示选择地区的窗口
    function selectArea(){
        dialogregion.show();
    }
    
</script>
</body>
</html>