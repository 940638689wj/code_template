<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list">众筹</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew>新增<#else>编辑</#if>众筹</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="save" method="post">
        <input type="hidden" name="promotionId" value="${(crowdFundDTO.promotionId)!}"/>
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>众筹名称：</label>
                    <div class="controls">
                        <input value="${(crowdFundDTO.promotionName)!?html}" name="promotionName" data-rules="{required:true,maxlength:50}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">众筹描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="promotionDesc" class="control-row4 input-large" data-rules="{maxlength:255}">${(crowdFundDTO.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <#assign statusCd='1'/>
                    <#if crowdFundDTO?? && crowdFundDTO?has_content && crowdFundDTO.statusCd == 0>
                        <#assign statusCd='0'/>
                    </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1" <#if statusCd=="1">checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0" <#if statusCd=="0">checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>众筹金额：</label>
                    <div class="controls">
                        <input <#if crowdFundDTO??>disabled</#if> value="${(crowdFundDTO.crowdFundPerAmt)!?html}" name="crowdFundPerAmt" data-messages="{regexp:'请输入合法的金额，且不能大于12位'}" data-rules="{required:true,regexp:/^([1-9]\d{0,11}|0)(\.\d{1,2})?$/}" class="input-normal control-text">
                    说明：必须能被货品金额整除。
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label">次数限制：</label>
                    <div class="controls">
                        <input <#if crowdFundDTO??>disabled</#if> value="${(crowdFundDTO.personalJoinLimit)!?html}" name="personalJoinLimit" data-messages="{regexp:'请输入整数，且不能大于11位'}" data-rules="{regexp:/^\d{0,11}$/}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>有效日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (crowdFundDTO.enableStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="${(crowdFundDTO.enableStartTime)?string('yyyy-MM-dd HH:mm:ss')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="">
                        </#if>
                            <span>至</span>
                        <#if (crowdFundDTO.enableEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="${(crowdFundDTO.enableEndTime)?string('yyyy-MM-dd HH:mm:ss')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        <div id="edit-div" class="well control-group">
        	<input type="hidden" name="productId" value="">
        	<input type="hidden" name="crowdFundProductAmt" value="${(crowdFundDTO.crowdFundProductAmt)!}">
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

        <div class="row form-actions actions-bar">
            <div class="span13 offset3 ">
                <button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var dialogregion = null;
    var choiceProductDialog = null;
    var selectProductId;

    BUI.use('bui/overlay',function(Overlay){
        choiceProductDialog = new Overlay.Dialog({
            title:'商品列表',
            width: 838,
            height: 460,
            loader : {
                url : '${ctx}/admin/sa/promotion/productDialog/productList?productTypeCd=1&&single=1&showSku=1',
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
        <#if !crowdFundDTO??>
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
            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : selectProductId,
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
            selectProductId = "";

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
            <#if productId??>
            	selectProductId = ${productId};
            </#if>
            buildProductGrid();

            if(selectProductId){
                productStore.load();
            }
        }
	}
	//添加新的商品
	function productChoiceEvent(selectedProduct){
		if(selectedProduct.length > 0) {
			selectProductId = selectedProduct[0].productId;
		}
        reloadProductCondition();
    }
	//重新加载数据
    function reloadProductCondition(){
        if(!productStore){
            buildProductGrid();
            if(selectProductId){
                productStore.load();
            } else {
                var records = productStore.getResult();
                productStore.remove(records);
            }
        } else {
            if(selectProductId){
                var params = { //配置初始请求的参数
                    start : 0,
                    "in_id" : selectProductId
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
    	<#--弹出商品选择框-->
    	$("#choiceProductBtn").on('click', function(){
    		<#--编辑时不能选择商品-->
    		<#if crowdFundDTO??>
    			return;
    		</#if>
            choiceProductDialog.get('loader').load();
            choiceProductDialog.show();
        });
    
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
            	setTimeout("remainTime()",1100);
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/crowdFund/list";
                }
            }
        });
        
        //表单提交前的验证
        form.on('beforesubmit', function(){
        	btn=document.getElementById('save');
			btn.disabled=true;
        
            if(!selectProductId) {
            	app.showError('请选择商品!');
                setTimeout("remainTime()",1100);
                return false;
            }
            
            var crowdFundPerAmt =  $('input[name="crowdFundPerAmt"]').val();
            var productPrice = productStore.getResult()[0].defaultPrice;
            if(crowdFundPerAmt && productPrice && (parseFloat(productPrice)*100%(parseFloat(crowdFundPerAmt)*100))/100 != 0) {
            	app.showError('众筹金额必须能被货品金额整除!');
                setTimeout("remainTime()",1100);
                return false;
            } 
            
            $('input[name="productId"]').val(selectProductId);
            $('input[name="crowdFundProductAmt"]').val(productPrice);
            return true;
        })
        form.render();
        
        initProductCondition();
        
        //重置按钮
        $('.actions-bar button[type="reset"]').click(function() {
        	//如果是编辑操作,只重置启用状态
            <#if crowdFundDTO??>
            	$('.controls input[name="statusCd"][value="${(crowdFundDTO.statusCd)!default(1)}"]').attr("checked",true);
            	return;
            </#if>
            $('.controls input[name="statusCd"][value="1"]').attr("checked",true);
        });
    });
</script>
</body>
</html>