<#assign ctx = request.contextPath>

<#if type?? && type?has_content>
	<#assign promotionTypeStr = Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_DISCOUNT_TYPE.getFriendlyType()>
	<#if Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getType() == type>
		<#assign promotionTypeStr = Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getFriendlyType()>
	<#elseif Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getType() == type>
		<#assign promotionTypeStr = Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getFriendlyType()>
	</#if>
</#if>
<!DOCTYPE html>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list?type=${type!}">${promotionTypeStr!}促销</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if promotion??>编辑<#else>新增</#if>${promotionTypeStr!}促销</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="save" method="post">
        <input type="hidden" name="promotionId" value="${(promotion.promotionId)!}"/>
        <input type="hidden" name="promotionTypeCd" value="${type!}">
        <!--<input type="hidden" name="discountRuleId" value="${discountRuleId!}">-->
        <!--<input type="hidden" name="conditionId" value="${conditionId!}">-->
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>促销名称：</label>
                    <div class="controls">
                        <input value="${(promotion.promotionName)!?html}" name="promotionName" data-rules="{required:true}" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">促销描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="promotionDesc" class="control-row4 input-large">${(promotion.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>
                    <#assign statusCd='0'/>
                    <#if promotion?? && promotion?has_content && promotion.statusCd == 1>
                        <#assign statusCd='1'/>
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
                    <label class="control-label"><s>*</s>有效日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (promotion.enableStartTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="${(promotion.enableStartTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true,minDate:'${.now?string('yyyy-MM-dd')}'}" value="">
                        </#if>
                            <span>至</span>
                        <#if (promotion.enableEndTime)?has_content>
                            <input disabled type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="${(promotion.enableEndTime)?string('yyyy-MM-dd')}">
                        <#else>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true,minDate:'${.now?string('yyyy-MM-dd')}'}" value="">
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员级别：</label>
                    <div class="controls control-row-auto">
                        <#assign isAllUserLevel = (promotion.isAllUserLevelJoin)?default(true)/>
                        <label class="checkbox">
                            <input <#if promotion??>disabled</#if> <#if isAllUserLevel> checked="checked" </#if> id="allUserLevel" name="allUserLevel" value='1' type="checkbox">
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
                                    <input <#if promotion??>disabled</#if> name="userLevel" <#if userLevelSelect> checked='checked' </#if> type="checkbox" value="${(userLevel.userLevelId)!}">
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
        <div id="edit-div" class="well">
        	<#assign isAllOrder = (promotion.isAllOrderJoin)?default(true)/>
            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:120px;">
                    	<input <#if promotion??>disabled</#if> name="promotionConditionType" type="radio" <#if isAllOrder> checked="checked" </#if> id="conditionRule_ALL" value="7"/>&nbsp;所有订单
                    </label>
                    <div class="controls control-row-auto" style="display: none;">
                        <input <#if promotion??>disabled</#if> type="text" value="" class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group subTotalCondition">
                    <label class="control-label" style="width:120px;">
                    	<input <#if promotion??>disabled</#if> name="promotionConditionType" <#if !isAllOrder && orderTotal??> checked="checked" </#if> type="radio" id="conditionRule_subTotal" value="4"/>&nbsp;当订单总金额满
                    </label>
                    <div class="controls control-row-auto">
                        <input <#if promotion??>disabled</#if> type="text" name="conditionValueSubTotal" value="${orderTotal!}" id="conditionValue_subTotal" class="input-normal control-text">&nbsp;元
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width:120px;">
                    	<input <#if promotion??>disabled</#if> name="promotionConditionType" <#if !isAllOrder && orderQuantity??> checked="checked" </#if> type="radio" id="conditionRule_quantity" value="5"/>&nbsp;当订单商品总数满
                    </label>
                    <div class="controls control-row-auto">
                        <input <#if promotion??>disabled</#if> type="text" name="conditionValueQuantity" value="${orderQuantity!}" id="conditionValue_quantity" class="input-normal control-text">&nbsp;件
                    </div>
                </div>
            </div>
        </div>
        <#assign isVersatile = false>
        <#if promotion?? && promotion?has_content>
            <#assign isVersatile = true>
        </#if>

        <div id="edit-div" class="well">
            <#if (!isVersatile && Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_DISCOUNT_TYPE.getType() == type) ||  
            (isVersatile && promotion.promotionTypeCd == Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_DISCOUNT_TYPE.getType())>
                <div class="row">
                    <div class="control-group percentOffExecution">
                        <label class="control-label" style="width:120px;">
                        	<input <#if promotion??>disabled</#if> checked="checked" type="radio" name="discount"/>&nbsp;订单打&nbsp;
                        </label>
                        <div class="controls control-row-auto">
                            <input <#if promotion??>disabled</#if> type="text" value="${conditionValue!}" name="conditionValue" id="execution_percent" class="input-normal control-text">&nbsp;折出售
                        </div>
                    </div>
                </div>
            </#if>
            <#if (!isVersatile && Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getType() == type) || 
            isVersatile && promotion.promotionTypeCd == Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getType()>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="width:120px;">
                        	<input <#if promotion??>disabled</#if> checked="checked" type="radio" name="reduce"/>订单减去固定价格
                        </label>
                        <div class="controls control-row-auto">
                            <input <#if promotion??>disabled</#if> type="text" value="${conditionValue!}" name="conditionValue" id="execution_amount" class="input-normal control-text">&nbsp;出售
                        </div>
                    </div>
                </div>
            </#if>
            <#if (!isVersatile && Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getType() == type) ||
             isVersatile && promotion.promotionTypeCd == Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getType()>
                <div class="row">
                    <div class="control-group percentOffExecution">
                        <label class="control-label" style="width:120px;">
                        	<input <#if promotion??>disabled</#if> type="radio" name="offerExecute" checked="checked" value=""/>&nbsp;订单免邮费
                        </label>
                        <div class="controls control-row-auto" style="display: none;">
                            <input  <#if promotion??>disabled</#if> type="text" value="0" name="conditionValue" id="execution_fulfillment" class="input-normal control-text">
                        </div>
                    </div>
                </div>
            </#if>
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
	//延时启用保存按钮
	function remainTime(){
		//打开提交按钮
		btn=document.getElementById('save');
		btn.disabled=false;
	}
    $(function(){
        $("#allUserLevel").on('change', function(){
            $("input[name='userLevel']").prop("checked", this.checked);
        });
        $("input[name='userLevel']").on('change', function(){
            var $subs = $("input[name='userLevel']");
            $("#allUserLevel").prop("checked", $subs.length == $subs.filter(":checked").length ? true :false);
        });
        <#if isAllUserLevel>
            $("#allUserLevel").trigger('change');
        </#if>

		$("input[name='isAllOrderJoin']").on('change',function() {
			if($(this).filter(':checked').attr('id') == 'conditionRule_ALL') {
				$('#productInfo').hide();
				$('#foodInfo').hide();
			} else if($(this).filter(':checked').attr('id') == 'conditionRule_product') {
				$('#productInfo').show();
				$('#foodInfo').hide();
				$('#productGrid').empty();
				chooseProductGrid = 'productGrid';
				productColumn();
				buildProductGrid();
			} else if($(this).filter(':checked').attr('id') == 'conditionRule_dishes') {
				$('#productInfo').hide();
				$('#foodInfo').show();
				$('#foodGrid').empty();
				chooseProductGrid = 'foodGrid';
				foodColumn();
				buildProductGrid();
			}
		});

		//选择条件
		$('input[name="promotionConditionType"]').on('change',function() {

			if($(this).attr('id') == 'conditionRule_subTotal') {
				$('#conditionValue_subTotal').val('').attr('disabled',false);
				$('#conditionValue_quantity').val('').attr('disabled',true);
			} else if($(this).attr('id') == 'conditionRule_quantity') {
				$('#conditionValue_subTotal').val('').attr('disabled',true);
				$('#conditionValue_quantity').val('').attr('disabled',false);
			} else {
				$('#conditionValue_quantity').val('').attr('disabled',true);
				$('#conditionValue_subTotal').val('').attr('disabled',true);
			}
		});
		
		<#if isAllOrder>
			$('#conditionRule_ALL').trigger('change');
		</#if>
		<#if !isAllOrder && orderTotal??> 
			$('#conditionRule_subTotal').trigger('change');
		</#if>
		<#if !isAllOrder && orderQuantity??> 
			$('#conditionRule_quantity').trigger('change');
		</#if>
		
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/orderSales/list?type=${type!}";
                }
            }
        });
        
        //表单提交前的验证
        form.on('beforesubmit', function(){
            var goOn = true;
            var discountReg = new RegExp(/^([1-9])(\.\d*[1-9])?$/);
            var moneyReg = new RegExp(/^([1-9]\d{0,15}|0)(\.\d*[1-9])?$/);
            var numReg = new RegExp(/^[1-9]\d{0,9}$/);
            btn=document.getElementById('save');
			btn.disabled=true;
            
            var $pc = $('input[name="promotionConditionType"]').filter(':checked');
            var length = $pc.length;
            if(length != 1) {
            	app.showError('请选择一种条件!');
            	//数据返回,延迟打开提交按钮,避免重复显示提示信息！
            	setTimeout("remainTime()",1100);
	            return false;
            }
        	if($pc.attr('id') == 'conditionRule_subTotal') {
        		if($('#conditionValue_subTotal').val().trim() == '') {
        			app.showError('请输入条件值!');
        			setTimeout("remainTime()",1100);
                	return false;
        		}
        		
        		if($('#conditionValue_subTotal').val().trim().match(moneyReg) == null) {
        			app.showError('请输入合法的金额，且金额不能超过16位数!');
        			setTimeout("remainTime()",1100);
                	return false;
        		}
        	} else if($pc.attr('id') == 'conditionRule_quantity') {
        		if($('#conditionValue_quantity').val().trim() == '') {
        			app.showError('请输入条件值!');
        			setTimeout("remainTime()",1100);
                	return false;
        		}
        		
        		if($('#conditionValue_quantity').val().trim().match(numReg) == null) {
        			app.showError('请输入正确的数量，且数量为大于0小于11位数!');
        			setTimeout("remainTime()",1100);
                	return false;
        		}
        	}
            
            var promotionTypeCd = $("input[name='promotionTypeCd']").val();
            var conditionValue = $("input[name='conditionValue']").val().trim();
            if(promotionTypeCd == ${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_DISCOUNT_TYPE.getType()}) {
	            if(conditionValue == '') {
	            	app.showError('折扣额不能为空!');
	            	setTimeout("remainTime()",1100);
	                return false;
	            }
	            if(conditionValue.match(discountReg) == null) {
	            	app.showError('请输入正确的折扣额,且折扣额为大于0小于10!');
	            	setTimeout("remainTime()",1100);
	                return false;
	            }
            } else if(promotionTypeCd == ${Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getType()}){
            	if(conditionValue == '') {
            		app.showError('金额不能为空!');
            		setTimeout("remainTime()",1100);
	                return false;
            	}
            	if(conditionValue.match(moneyReg) == null) {
	            	app.showError('请输入正确的金额,且金额不能超过16位数!');
	            	setTimeout("remainTime()",1100);
	                return false;
	            }
            }
            
            if(!goOn){
                return false;
            }

            var selectUserLevelCount=$("input[name='userLevel']").filter(":checked").length;
            if(selectUserLevelCount <1){
                app.showError('请选择会员级别!');
                setTimeout("remainTime()",1100);
                return false;
            }
            
            return true;
        })
        form.render();
        
        //initProductCondition();
        
        //重置按钮
        $('.actions-bar button[type="reset"]').click(function() {
        	<#if promotion??>
        	    $('.controls input[name="statusCd"][value="${(promotion.statusCd)!}"]').attr("checked",true);
        	    <#assign val = 1>
        	    <#if orderTotal??>
        	    	<#assign val = 2>
        	    <#elseif orderQuantity??>
        	    	<#assign val = 3>
        	    </#if>
            	$('input[name="promotionConditionType"][value="${val!}"]').attr("checked",true);
        	<#else>
	            $('.controls input[name="statusCd"][value="1"]').attr("checked",true);
	            $('input[name="promotionConditionType"][value="1"]').attr("checked",true);
        	</#if>
        });
    });
</script>
</body>
</html>