<#assign ctx = request.contextPath>

<#assign isAllProductJoin = 1>
<#if promotion?? && promotion?has_content && !promotion.isAllProductJoin>
	<#if productType == 1>
    	<#assign isAllProductJoin = 2>
    <#elseif productType == 2>
    	<#assign isAllProductJoin = 3>
    </#if>
</#if>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
	<ul class="breadcrumb">
		<li><a href="list">红包</a> <span class="divider">&gt;&gt;</span></li>
		<li class="active"><#if isNew>新增<#else>编辑</#if>红包</li>
	</ul>
	<form id="J_Form" class="form-horizontal" action="save" method="post">
		<input type="hidden" name="promotionId" value="${(promotion.promotionId)!}"/>
		<div id="edit-div1" class="form-content">
			<div class="row">
				<div class="control-group">
					<label class="control-label">领取地址：</label>
					<div class="controls">
					<#if isNew>
						<label>领取地址在创建完成之后自动分配，请创建成功之后操作【编辑】查看。</label>
					<#else>
						<label>/m/redPacket/${(promotion.encryptCode)!}.html</label>
					</#if>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="control-group">
					<label class="control-label"><s>*</s>名称：</label>
					<div class="controls">
						<input value="${(promotion.promotionName)!?html}" name="promotionName" data-rules="{required:true}" class="input-normal control-text">
					</div>
				</div>
			</div>
			<div class="row" id="offerSign">
				<div class="control-group">
					<label class="control-label">描述：</label>
					<div class="controls control-row-auto">
						<textarea name="promotionDesc" class="control-row4 input-large">${(promotion.promotionDesc)!?html}</textarea>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="control-group">
					<label class="control-label"><s>*</s>启用状态：</label>
                    <#assign statusCd='1'/>
                    <#if promotion?? && promotion?has_content && promotion.statusCd == 0>
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
                        <#if (promotion.enableStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="${(promotion.enableStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="">
                        </#if>
                            <span>至</span>
                        <#if (promotion.enableEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="${(promotion.enableEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
				</div>
			</div>
			<div class="row">
				<div class="control-group">
					<label class="control-label"><s>*</s>有效领取日期：</label>
					<div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (promotionCoupon.couponTakeStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="couponTakeStartTime" data-rules="{required:true}" value="${(promotionCoupon.couponTakeStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="couponTakeStartTime" data-rules="{required:true}" value="">
                        </#if>
                        <span>至</span>
                        <#if (promotionCoupon.couponTakeEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="couponTakeEndTime" data-rules="{required:true}" value="${(promotionCoupon.couponTakeEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="couponTakeEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
				</div>
			</div>
			<div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>红包类型：</label>
                    <div class="controls">
                        <#assign defaultRedEnvelopeValue="1"/>
                        <#if promotionCoupon?? && promotionCoupon?has_content && promotionCoupon.generateRedPacketCnt != 0>
                            <#assign defaultRedEnvelopeValue="2"/>
                        </#if>

                        <label class="radio">
                            <input type="radio" name="redPacketType" value="1" id="ordinaryRed" <#if defaultRedEnvelopeValue=="1">checked="checked" </#if> <#if !isNew>disabled="disabled" </#if>/>普通红包
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="redPacketType" value="2" <#if defaultRedEnvelopeValue=="2">checked="checked" </#if> <#if !isNew>disabled="disabled" </#if>/>群红包
                        </label>
                        <#if promotion??>
                        	<input type="hidden" name="redPacketType" value="${defaultRedEnvelopeValue!}"/>
                        </#if>
                    </div>
                </div>
            </div>
		</div>

		<div id="edit-div2" class="well">
			<#assign isAllProduct = (promotion.isAllProductJoin)?default(true)/>
        	<input type="hidden" name="selectProductIds" id="selectProductIds" value="${productIds!}">
        	<input type="hidden" id="productIds" value="<#if isAllProductJoin == 2>${productIds!}</#if>">
        	<input type="hidden" id="categorys" name="categorys"  value="">
			<div class="row">
				<div class="control-group">
					<label class="control-label" style="width:120px;">
						<input <#if !isNew>disabled</#if> name="activityProducts" type="radio" <#if isAllProductJoin == 1> checked="checked" </#if> id="conditionRule_ALL" value="1"/>
						&nbsp;所有商品
					</label>
					<div class="controls control-row-auto" style="display: none;">
						<input type="text" value="ALL" class="input-normal control-text">
					</div>
				</div>
			</div>

			<div class="row">
                <div class="control-group subTotalCondition">
                    <label class="control-label" style="width:120px;">
                    	<input <#if !isNew>disabled</#if> name="activityProducts" <#if isAllProductJoin == 3> checked="checked" </#if> type="radio" id="conditionRule_category" value="3"/>
                    	&nbsp;商品分类
                    </label>
                </div>
            </div>
            <div class="row hide" id="categoryInfo">
			</div>
			<div class="row">
				<div class="control-group subTotalCondition">
					<label class="control-label" style="width:120px;">
						<input <#if !isNew>disabled</#if> name="activityProducts" <#if isAllProductJoin == 2> checked="checked" </#if> type="radio" id="conditionRule_product" value="2"/>
						&nbsp;指定商品
					</label>
				</div>
			</div>
            <div class="row hide" id="productInfo">
				<ul class="toolbar">
					<li>
						<button id="choiceProductBtn1" type="button" class="button button-info">
							<i class="icon icon-white icon-envelope"></i>选择商品
						</button>
					</li>
				</ul>
				<hr>
				<div class="search-grid-container">
					<div id="productGrid"></div>
				</div>
			</div>
		</div>

		<div id="edit-div4" class="well">
            <div class="row" id="groupRedEnvelopeCountDiv" style="<#if defaultRedEnvelopeValue != "2">display: none;</#if>">
                <div class="control-group">
                    <label class="control-label" style="width:120px;">
                        <s>*</s>群红包个数
                    </label>
                    <div class="controls control-row-auto">
                        <input <#if !isNew>disabled</#if> type="text" name="generateRedPacketCnt" id="groupRedEnvelopeCount" value="${(promotionCoupon.generateRedPacketCnt)!}" class="input-normal control-text" <#if defaultRedEnvelopeValue == "2">data-rules="{min:1,number:true}"</#if>>
                        &nbsp;个
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:120px;">
                        <s>*</s>红包金额：
                    </label>
                    <div class="controls control-row-auto">
                        <#if !isNew && defaultRedEnvelopeValue="2">
                            <#if promotionCoupon?? && promotionCoupon?has_content>${(promotionCoupon.totalCouponValue)!}</#if>
                            <input <#if !isNew>disabled</#if> name="totalCouponValue" type="hidden" value="<#if promotionCoupon?? && promotionCoupon?has_content>${(promotionCoupon.totalCouponValue)!}</#if>" id="execution_amount" >
                        <#elseif defaultRedEnvelopeValue=="1">
                            <input <#if !isNew>disabled</#if> type="text" name="totalCouponValue" value="<#if promotionCoupon?? && promotionCoupon?has_content>${(promotionCoupon.couponValue)!}</#if>" id="execution_amount" class="input-normal control-text" data-rules="{required:true,min:0,number:true}">
                        </#if>
                        &nbsp;元
                    </div>
                    <div class="tips-wrap" id="groupExcuteValue" style="<#if defaultRedEnvelopeValue != "2">display: none;</#if>">
                        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                            <div class="tips-content">每个群红包总金额</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:120px;">
                        <s>*</s>生成数量：
                    </label>
                    <div class="controls control-row-auto">
                        <#if !isNew && defaultRedEnvelopeValue="2">
                            ${(promotionCoupon.couponTotalNum)!}
                            <input value="${(promotionCoupon.couponTotalNum)!}"  name="couponTotalNum" type="hidden" class="input-normal control-text">
                        <#elseif defaultRedEnvelopeValue=="1">
                            <input <#if !isNew>disabled</#if> value="${(promotionCoupon.couponTotalNum)!}"  name="couponTotalNum" data-messages="{regexp:'不是有效的数字'}" data-rules="{regexp:/^[1-9]\d{0,5}$/}" class="input-normal control-text">
                        </#if>
                    </div>
                    <div class="tips-wrap" id="groupNoticeOfferCodeCount" style="<#if defaultRedEnvelopeValue != "2">display: none;</#if>">
                        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                            <div class="tips-content">每个群红包内普通红包数量</div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" id="groupMaxValue" style="<#if defaultRedEnvelopeValue != "2">display: none;</#if>">
                <div class="control-group">
                    <label class="control-label" style="width:120px;">
                        单个红包金额最高
                    </label>
                    <div class="controls control-row-auto">
                        <#if !isNew && defaultRedEnvelopeValue="2">
                            ${(promotionCoupon.singleRedPacketLimit)!}
                            <input <#if !isNew>disabled</#if> name="singleRedPacketLimit" id="singleRedPacketLimit" type="hidden" value="${(promotionCoupon.singleRedPacketLimit)!}" class="input-normal control-text" >
                        <#else>
                            <input <#if !isNew>disabled</#if> type="text" name="singleRedPacketLimit" id="singleRedPacketLimit" value="${(promotionCoupon.singleRedPacketLimit)!}" class="input-normal control-text" data-rules="{min:0,number:true}">
                        </#if>
                        &nbsp;元
                    </div>
                </div>
            </div>

            <div class="row" id="expiredTimeDiv" style="<#if defaultRedEnvelopeValue != "2">display: none;</#if>">
                <div class="control-group">
                    <label class="control-label" style="width:120px;"><s>*</s>领取后过期时间：</label>
                    <div class="controls">
                        <input <#if !isNew>disabled</#if> value="${(promotionCoupon.deadlineHours)!}" name="deadlineHours" id="deadlineHours" <#if defaultRedEnvelopeValue == "2">data-rules="{min:1,number:true}"</#if> class="input-normal control-text">
                        &nbsp;小时
                    </div>
                    <div class="tips-wrap" id="groupNoticeOfferCodeCount">
                        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                            <div class="tips-content">领取过期时间指：群红包可领取的时间段，第一个红包被领取后开始计算过期时间，时间过后就不能再领取了</div>
                        </div>
                    </div>
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
    var selectProductIds = [];

    BUI.use('bui/overlay',function(Overlay){
        choiceProductDialog = new Overlay.Dialog({
            title:'商品列表',
            width: 1000,
            height: 460,
            loader : {
                url : '${ctx}/admin/sa/label/productDialog?productTypeCd=1',
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
        {title: '吊牌价', dataIndex: 'tagPrice', width: 120},
        {title: '销售价', dataIndex: 'defaultPrice', width: 120},
        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
            return delStr;
        }}
    ];
    
    var productStore;
    var productGrid;
    function buildProductGrid(){
        productStore = new Store({
            url : '${ctx}/admin/sa/promotion/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : selectProductIds.join(",")
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
    
    var productCategoryIds;
    <#--初始化商品树形结构-->
    function initProductCategory() {
    	var isAPJ = '${isAllProductJoin}';
    	if(isAPJ == '3') {
    		<#if categoryIds??>
    			productCategoryIds = '${categoryIds!}';
    		</#if>
    		loadProductCategoryHtml(productCategoryIds)
    	}
    }
    
    <#--加载商品类别树形结构-->
    function loadProductCategoryHtml(productCategoryIds){
        $.ajax({
            url : "${ctx}/admin/sa/promotionProductCategoryController/grid_json",
            data : {categoryIds : productCategoryIds},
            type:"get",
            dataType : 'html',
            success : function(data){
                $("#categoryInfo").html(data);
            }
        });
    }
    
    $(function() {
    	<#--编辑时，禁用掉树的选择-->
    	<#if !isNew>

    	</#if>
    	//改变商品单选
		$("input[name='activityProducts']").on('change',function() {
			if($(this).filter(':checked').attr('id') == 'conditionRule_ALL') {
				$('#productInfo').hide();
				$('#categoryInfo').hide();
			} else if($(this).filter(':checked').attr('id') == 'conditionRule_product') {
				$('#productInfo').show();//显示商品列表
				$('#categoryInfo').hide();//隐藏商品类别树形结构
				$('#productGrid').empty();//清空商品列表数据
				selectProductIds = $('#productIds').val() == '' ? [] : $('#productIds').val().split(',');//把所选择的商品Id存放到对应的类型隐藏域中
				productColumn();//重新加载列表的列
				buildProductGrid();//重新加载数据
				if(selectProductIds.length > 0) {
					productStore.load();
				}
			} else if($(this).filter(':checked').attr('id') == 'conditionRule_category') {
				$('#productInfo').hide();
				loadProductCategoryHtml(productCategoryIds);
				$('#categoryInfo').show();
			}
		});
		
		$("#choiceProductBtn1").on('click', function(){
            choiceProductDialog.get('loader').load();
            choiceProductDialog.show();
        });
        $("#choiceProductBtn2").on('click', function(){
        });
        
        <#if isAllProductJoin == 2>
        	$('#productInfo').show();//显示商品列表
        	productColumn();//重新加载列表的列
        <#elseif isAllProductJoin == 3>
        	$('#categoryInfo').show();
        </#if>
        
        //选择条件
		$('input[name="promotionConditionType"]').on('change',function() {
			if($(this).attr('id') == 'conditionRule_subTotal') {
				$('#conditionValue_quantity').val('');
			} else if($(this).attr('id') == 'conditionRule_quantity') {
				$('#conditionValue_subTotal').val('');
			} else {
				$('#conditionValue_quantity').val('');
				$('#conditionValue_subTotal').val('');
			}
		});
		
		//选择优惠
		$('input[name="promotionTypeCd"]').on('change',function() {
			if($(this).attr('id') == 'executeWay_percentOff') {
				$('#execution_amount').val('');
			} else if($(this).attr('id') == 'executeWay_amountOff') {
				$('#execution_percent').val('');
			} else {
				$('#execution_amount').val('');
				$('#execution_percent').val('');
			}
		});
		
		//群红包和普通红包
		$('input[name="redPacketType"]').on('change',function() {
			if($(this).filter(':checked').val() == '1') {//普通红包
				$('#groupRedEnvelopeCountDiv').val('').hide();
				$('#groupExcuteValue').val('').hide();
				$('#groupNoticeOfferCodeCount').val('').hide();
				$('#groupMaxValue').val('').hide();
				$('#expiredTimeDiv').val('').hide();
			}else{//群红包
				$('#groupRedEnvelopeCountDiv').show();
				$('#groupExcuteValue').show();
				$('#groupNoticeOfferCodeCount').show();
				$('#groupMaxValue').show();
				$('#expiredTimeDiv').show();
			}
			
		});
		
		<#if defaultRedEnvelopeValue="1">
			$('#ordinaryRed').trigger('change');
		</#if>
        
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/redPacket/list";
                }
                setTimeout("remainTime()",1200);
            }
        });
        
        //表单提交前的验证
        form.on('beforesubmit', function(){
            var goOn = true;
            var discountReg = new RegExp(/^([1-9])(\.\d*[1-9])?$/);
            var moneyReg = new RegExp(/^([1-9]\d{0,9})$/);
            var numReg = new RegExp(/^[1-9]\d{0,10}$/);
            $("#save").attr('disabled',true);
            
            if($('input[name="redPacketType"]').filter(':checked').length < 1) {
            	app.showError('请选择红包类型!');
            	setTimeout("remainTime()",1200);
                return false;
            }
            
            var totalCouponValue = $('input[name="totalCouponValue"]').val();
            if(totalCouponValue.match(moneyReg) == null) {
            	app.showError('请输入正确的红包金额,金额只能为大于0的整数且不能超过10位数!');
            	setTimeout("remainTime()",1200);
                return false;
            }
            
            var couponTotalNum = $('input[name="couponTotalNum"]').val();
            if(couponTotalNum.match(numReg) == null) {
            	app.showError('请输入正确的红包数量，且数量为大于0小于11位数!');
            	setTimeout("remainTime()",1200);
                return false;
            }
            
            if($('input[name="redPacketType"]').filter(':checked').val() == '2') {//群红包
            	var generateRedPacketCnt = $('input[name="generateRedPacketCnt"]').val();
            	if(generateRedPacketCnt == '') {
            		app.showError('群红包个数不能为空!');
            		setTimeout("remainTime()",1200);
                	return false;
            	}
            	if(generateRedPacketCnt.match(numReg) == null) {
            		app.showError('请输入正确的群红包数量，且数量为大于0小于11位数!');
            		setTimeout("remainTime()",1200);
                	return false;
            	}
            	
            	var singleRedPacketLimit = $('input[name="singleRedPacketLimit"]').val();
            	if(singleRedPacketLimit != '' && singleRedPacketLimit.match(moneyReg) == null) {
            		app.showError('请输入正确的单个红包的最高金额，金额只能为大于0的整数且不能超过10位数!');
            		setTimeout("remainTime()",1200);
                	return false;
            	}
            	
            	var deadlineHours = $('input[name="deadlineHours"]').val();
            	if(deadlineHours == null) {
            		app.showError('红包领取后的过期时间不能为空！');
            		setTimeout("remainTime()",1200);
                	return false;
            	}
            	
            	if(deadlineHours.match(numReg) == null) {
            		app.showError('请输入正确红包领取后的过期时间，只能整数！');
            		setTimeout("remainTime()",1200);
                	return false;
            	}
            	
            }
            
            if(!goOn){
                return false;
            }

            var conditionRuleId = $($("input[name='activityProducts']").filter(":checked").get(0)).attr('id');
            if( conditionRuleId == 'conditionRule_category'){
                // 指定商品类别
                var selectCategorys = getCheckedCategoryIds();
                if(selectCategorys.length < 1){
                    app.showError('请选择商品类别!');
                    setTimeout("remainTime()",1200);
                    return false;
                }
                $('#categorys').val(selectCategorys.join(','));
            }
            
            if(conditionRuleId == 'conditionRule_product') {
            	// 指定商品
                if(selectProductIds.length < 1){
                    app.showError('请选择商品!');
                    setTimeout("remainTime()",1200);
                    return false;
                }
                $('#selectProductIds').val(selectProductIds.join(','));
			}
            return true;
        })
        form.render();
        
        initProductCondition();//编辑时，初始化商品数据
        initProductCategory();//编辑时，初始化商品类型树形数据
        
        //重置按钮
        $('.actions-bar button[type="reset"]').click(function() {
        	<#if promotion??>
        	    $('.controls input[name="statusCd"][value="${(promotion.statusCd)!}"]').attr("checked",true);
            	$('input[name="promotionConditionType"][value="${isExsitOrderCondition!}"]').attr("checked",true);
            	$('input[name="promotionTypeCd"][value="${promotionType!}"]').attr("checked",true);
        	<#else>
	            $('.controls input[name="statusCd"][value="1"]').attr("checked",true);
	            $('input[name="promotionConditionType"][value="1"]').attr("checked",true);
	            $('input[name="promotionTypeCd"][value="53"]').attr("checked",true);
        	</#if>
        });
    });
    
    function productColumn() {
    	productColumns = [
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
	        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
	            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
	            return delStr;
	        }}
	    ];
    }
    
    function remainTime(){
        $("#save").attr('disabled',false);
    }

</script>
</body>
</html>