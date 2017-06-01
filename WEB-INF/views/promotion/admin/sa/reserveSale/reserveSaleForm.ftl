
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
        <li><a href="list">预售</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew>新增<#else>编辑</#if>预售</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="save" method="post">
        <input type="hidden" name="promotionId" value="${(reserveSaleDTO.promotionId)!}"/>
        <input type="hidden" name="promotionTypeCd" value="60">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>预售名称：</label>
                    <div class="controls">
                        <input value="${(reserveSaleDTO.promotionName)!?html}" name="promotionName" data-rules="{required:true,maxlength:50}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">预售描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="promotionDesc" class="control-row4 input-large" data-rules="{maxlength:255}">${(reserveSaleDTO.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <#assign statusCd='1'/>
                    <#if reserveSaleDTO?? && reserveSaleDTO?has_content && reserveSaleDTO.statusCd == 0>
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
                    <label class="control-label"><s>*</s>有效使用日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (reserveSaleDTO.enableStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="${(reserveSaleDTO.enableStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="">
                        </#if>
                            <span>至</span>
                        <#if (reserveSaleDTO.enableEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="${(reserveSaleDTO.enableEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>付尾款有效期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (reserveSaleDTO.allowPayRemainderStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="allowPayRemainderStartTime" data-rules="{required:true}" value="${(reserveSaleDTO.allowPayRemainderStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="allowPayRemainderStartTime" data-rules="{required:true}" value="">
                        </#if>
                            <span>至</span>
                        <#if (reserveSaleDTO.allowPayRemainderEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="allowPayRemainderEndTime" data-rules="{required:true}" value="${(reserveSaleDTO.allowPayRemainderEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="allowPayRemainderEndTime" data-rules="{required:true}" value="">
                        </#if>
                        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                            <div class="tips-content">备注：付尾款有效期参考有效使用日期内</div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label">预计发货时间：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (reserveSaleDTO.sendTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="sendTime" data-rules="{required:true}" value="${(reserveSaleDTO.sendTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="sendTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>
        </div>
        
        <div id="edit-div" class="well control-group">
        	<input type="hidden" name="productId" value="">
        	<input type="hidden" name="reserveSalePrice" value="${(crowdFundDTO.reserveSalePrice)!}">
            <div class="row" id="productInfo">
                <ul class="toolbar">
                    <li><button id="choiceProductBtn" type="button" class="button button-info" <#if !isNew>disabled</#if>><i class="icon icon-white icon-envelope"></i> 选择商品</button></li>
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
                url : '${ctx}/admin/sa/promotion/productDialog/productList?productTypeCd=1&single=1&promotionType=60',
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
        {title: '预付定金', dataIndex: 'price', width: 160,renderer : function(value,obj){
        	if(value) {
        		value = '<input type="text" disabled class="price" value="'+value+'">';
        	} else {
        		value = '<input type="text" class="price">';
        	}
            return value;
        }},
        <#if isNew>
	        {title: '操作',dataIndex:'',width:120,renderer : function(value,obj){
	            return '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
	        }}
        </#if>
    ];
    
    var productStore;
    var productGrid;
    function buildProductGrid(){
        productStore = new Store({
        	<#if reserveSaleDTO??>
	            url : '${ctx}/admin/sa/promotion/productDialog/combinationProduct/grid_json',
        	<#else>
	            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
        	</#if>
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : selectProductId,
                <#if reserveSaleDTO??>
                "promotionId" : ${(reserveSaleDTO.promotionId)!},
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
            	selectProductId = ${productId!};
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
    	<#--弹出选择商品框-->
    	$("#choiceProductBtn").on('click', function(){
    		<#--编辑时商品不能选择-->
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
                    window.location.href = "${ctx}/admin/sa/promotion/reserveSale/list";
                }
            }
        });
        
        //表单提交前的验证
        form.on('beforesubmit', function(){
        	btn=document.getElementById('save');
			btn.disabled=true;
        	
        	//判断付尾款有效期是否在有效使用日期范围内
        	var enableStartTime=document.getElementsByName("enableStartTime");
        	var enableEndTime=document.getElementsByName("enableEndTime");
        	var est=enableStartTime[0].value;
        	var eet=enableEndTime[0].value;
        	//付尾款有效期日期
        	var allowPayRemainderStartTime=document.getElementsByName("allowPayRemainderStartTime");
        	var allowPayRemainderEndTime=document.getElementsByName("allowPayRemainderEndTime");
        	var aprst=allowPayRemainderStartTime[0].value;
        	var apret=allowPayRemainderEndTime[0].value;
        	//根据日期字符串转换成日期 ,先替换日期格式
			var regEx = new RegExp("\\-","gi"); 
			est=est.replace(regEx,"/"); 
			eet=eet.replace(regEx,"/"); 
			aprst=aprst.replace(regEx,"/"); 
			apret=apret.replace(regEx,"/"); 
			//转换
			est=Date.parse(est);
			eet=Date.parse(eet);
			aprst=Date.parse(aprst);
			apret=Date.parse(apret);			
        	//判断       	
        	if(aprst < est || aprst > eet || apret < est || apret > eet){
        		app.showError('付尾款日期必须在有效使用日期范围内!');
                setTimeout("remainTime()",1100);
                return false;
        	}
        	//发货时间必须晚于有效使用日期
        	var sendTime=document.getElementsByName("sendTime");
        	var st=sendTime[0].value;
        	st=st.replace(regEx,"/");
        	st=Date.parse(st);
        	if(st<eet){
        		app.showError('预计发货时间必须在有效使用日期之后!');
        		setTimeout("remainTime()",1100);
        		return false;
        	}
        	
            if(!selectProductId) {
            	app.showError('请选择商品!');
                setTimeout("remainTime()",1100);
                return false;
            }
            
            var reserveSalePrice =  $('.price').val();
            var numReg = new RegExp(/^([1-9]\d{0,11})(\.\d{1,2})?$/);
            
            
            if(!reserveSalePrice) {
            	app.showError('商品预售金额不能为空');
                setTimeout("remainTime()",1100);
                return false;
            } else if(reserveSalePrice.match(numReg) == null){
            	app.showError('请输入合法的商品金额，且不能大于12位');
                setTimeout("remainTime()",1100);
                return false;
            }
            var product = productStore.getResult()[0];
            if(parseFloat(product.defaultPrice) < parseFloat(reserveSalePrice)) {
                app.showError('预付定金不能超过商品的销售金额！');
                setTimeout("remainTime()",1100);
                return false;
            }
            $('input[name="productId"]').val(selectProductId);
            $('input[name="reserveSalePrice"]').val(reserveSalePrice);
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