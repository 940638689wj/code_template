<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/promotion/sales/list">促销活动</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if (promotion.promotionId)??>编辑<#else>新增</#if>促销活动信息</li>
    </ul>

    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/promotion/sales/save" method="post">
        <input type="hidden" name="promotionId" id="promotionId" value="${(promotion.promotionId)!}">

        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input value="${(promotion.promotionName)!?html}" name="promotionName" data-rules="{required:true,maxlength:50}" class="input-normal control-text">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>描述：</label>
                    <div class="controls control-row-auto">
                        <textarea name="promotionDesc" data-rules="{required:true,maxlength:255}" class="control-row4 input-large">${(promotion.promotionDesc)!?html}</textarea>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>优惠类型：</label>
                    <#assign promotionTypeCd=1/>
                    <#if (promotion.promotionId)??>
                        <#assign promotionTypeCd = (promotion.promotionTypeCd)?default(1)/>
                    </#if>

                    <div class="controls" id = "promotionTypeCd">
                        <label class="radio">
                            <input type="radio" <#if (promotion.promotionId)??>disabled</#if> name="promotionTypeCd" value="1" <#if promotionTypeCd==1>checked="checked" </#if>/>满折
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" <#if (promotion.promotionId)??>disabled</#if> name="promotionTypeCd" value="2" <#if promotionTypeCd==2>checked="checked" </#if>/>满减
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" <#if (promotion.promotionId)??>disabled</#if> name="promotionTypeCd" value="3" <#if promotionTypeCd==3>checked="checked" </#if>/>满赠
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" <#if (promotion.promotionId)??>disabled</#if> name="promotionTypeCd" value="4" <#if promotionTypeCd==4>checked="checked" </#if>/>限时降价
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" <#if (promotion.promotionId)??>disabled</#if> name="promotionTypeCd" value="5" <#if promotionTypeCd==5>checked="checked" </#if>/>包邮
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>优惠类型：</label>
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
                    <label class="control-label"><s>*</s>渠道：</label>
                    <#assign promotionChannelCds=(promotion.promotionChannelCds)?default("")/>
                    <div class="controls">
                        <label class="radio">
                            <#--总店/商城-->
                            <input type="checkbox" <#if (promotion.promotionId)??>disabled</#if> name="promotionChannel" value="1" <#if promotionChannelCds?contains('1')>checked="checked" </#if>/>总店
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <#--微店-->
                            <input type="checkbox" <#if (promotion.promotionId)??>disabled</#if> name="promotionChannel" value="2" <#if promotionChannelCds?contains('2')>checked="checked" </#if>/>微店
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>有效使用日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (promotion.enableStartTime)?has_content>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="${(promotion.enableStartTime)?string('yyyy-MM-dd')}" disabled>
                        <#else>
                            <input type="text" class="calendar control-text" name="enableStartTime" data-rules="{required:true}" value="">
                        </#if>
                        <span>至</span>
                        <#if (promotion.enableEndTime)?has_content>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="${(promotion.enableEndTime)?string('yyyy-MM-dd')}" disabled>
                        <#else>
                            <input type="text" class="calendar control-text" name="enableEndTime" data-rules="{required:true}" value="">
                        </#if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员注册时间：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <#if (promotion.regStartTime)?has_content>
                            <input type="text" class="calendar control-text" name="regStartTime" data-rules="{required:true}" value="${(promotion.regStartTime)?string('yyyy-MM-dd')}" disabled>
                        <#else>
                            <input type="text" class="calendar control-text" name="regStartTime" data-rules="{required:true}" value="">
                        </#if>
                            <span>至</span>
                        <#if (promotion.regEndTime)?has_content>
                            <input type="text" class="calendar control-text" name="regEndTime" data-rules="{required:true}" value="${(promotion.regEndTime)?string('yyyy-MM-dd')}" disabled>
                        <#else>
                            <input type="text" class="calendar control-text" name="regEndTime" data-rules="{required:true}" value="">
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
                            <input <#if isAllUserLevel> checked="checked" </#if> id="allUserLevel" name="allUserLevel" value='1' type="checkbox"
                            <#if (promotion.promotionId)??>disabled</#if> >
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
                                    <input name="userLevel" id="userLevel_${(userLevel.userLevelId)!}" <#if userLevelSelect> checked='checked' </#if> type="checkbox" 
                                    	value="${(userLevel.userLevelId)!}" <#if (promotion.promotionId)??>disabled</#if> >
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
                    <label class="control-label">活动城市：</label>
                    <div class="controls">
                        <#assign isAllAreaJoin = (promotion.isAllAreaJoin)?default(false)/>

                        <a class="button" onclick="selectArea();">+选择地区</a>
                        <input type="hidden" name="isAllAreaJoin" id="isAllAreaJoin" value="<#if isAllAreaJoin>1<#else>0</#if>">
                        <input type="hidden" name="selectProvinceIds" id="selectProvinceIds" <#if provinceIds?? && provinceIds?has_content>value="${provinceIds}" </#if>>
                        <input type="hidden" name="selectCityIds" id="selectCityIds" <#if cityIds?? && cityIds?has_content>value="${cityIds}" </#if>>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>活动产品：</label>
                    <div class="controls control-row-auto">
                        <#assign isAllProduct = (promotion.isAllProductJoin)?default(false)/>
                        <label class="checkbox">
                            <input name="activityProducts" id="allProduct"  <#if isAllProduct> checked="checked" </#if> value='1' type="radio"
                            <#if (promotion.promotionId)??>disabled</#if> >
                            全选
                        </label>&nbsp;&nbsp;
                        <label class="checkbox">
                            <input name="activityProducts" id="appointProduct" <#if !isAllProduct> checked='checked' </#if> value="0" type="radio"
                            <#if (promotion.promotionId)??>disabled</#if> >
                            指定产品
                        </label>
                    </div>
                </div>
            </div>
            
            <div class="row hide" id="productInfo">
                <ul class="toolbar">
                    <li>
                        <input type="hidden" name="selectProductIds" id="selectProductIds" <#if productIds?? && productIds?has_content>value="${productIds}"</#if>>
                        <input type="hidden" name="lowerPriceArr" id="lowerPriceArr">
                        <input type="hidden" name="userLimitNumArr" id="userLimitNumArr">
                        <button id="choiceProductBtn" type="button" class="button button-info">
                        <i class="icon icon-white icon-envelope"></i> 选择商品</button>
                    </li>
                </ul>
                <hr>
                <div class="search-grid-container">
                    <div id="productGrid"></div>
                </div>
            </div>
            
            <#if (promotion.quotaNum)?has_content>
            	<div class="row" id="quotaNum">
	                <div class="control-group">
	                    <label class="control-label">限购数：</label>
	                    <div class="controls">
	                        <input value="${(promotion.quotaNum)!}" name="quotaNum" data-rules="{regexp:/^((1-9)?|([1-9][0-9]*))$/}" 
	                        	data-messages="{regexp:'请输入整数'}" class="input-normal control-text" disabled >
	                    </div>
	                </div>
	            </div>
            <#else>
	            <div class="row hide" id="quotaNum">
	                <div class="control-group">
	                    <label class="control-label">限购数：</label>
	                    <div class="controls">
	                        <input name="quotaNum" data-rules="{regexp:/^((1-9)?|([1-9][0-9]{0,9}))$/}" 
	                        	data-messages="{regexp:'请输入整数,且不能超过10位数'}" class="input-normal control-text" >
	                    </div>
	                </div>
	            </div>
            </#if>
            
            <div class="row promotionContent"  id="fullDiscount">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <#if orderTotalConditionRuleList?? && orderTotalConditionRuleList?has_content>
                        	<#if promotion?? && promotion.promotionTypeCd == 1>
                            <#list orderTotalConditionRuleList as conditionRule>
                                <div class="ConditionPanel">
                                	<label class="control-label"><s>*</s>满折条件：</label>
                                    <input <#if (promotion.promotionId)??>disabled</#if> value="${(conditionRule.conditionExpressionValue)!}" name="discountCondition" class="input-small control-text" 
                                    	data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}">
                                    &nbsp;&nbsp;&nbsp;
									<s>*</s>满额折扣(%)：
                                    <input <#if (promotion.promotionId)??>disabled</#if> value="${(conditionRule.discountValueShow)!}" name="discountValue" class="input-small control-text" data-rules="{regexp:/^(([1-9]?)|([1-9][0-9]))$/}" 
                                    	data-messages="{regexp:'请输入大于0小余100的折扣值'}">
                                </div>
                            </#list>
                            </#if>
                        <#else>
                            <div class="ConditionPanel">
                            	<label class="control-label"><s>*</s>满折条件：</label>
                                <input value="" name="discountCondition" class="input-small control-text" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" 
                                	data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}">
                                &nbsp;&nbsp;&nbsp;
								<s>*</s>满额折扣(%)：
                                <input value="" name="discountValue" class="input-small control-text" data-rules="{regexp:/^(([1-9]?)|([1-9][0-9]))$/}"  data-messages="{regexp:'请输入大于0小余100的折扣值'}">
                                &nbsp;&nbsp;&nbsp;
                                <a href="javascript:void(0);" class="addCondition">+增加满折条件</a>
                                <a href="javascript:void(0);" class="delCondition" style="display: none;">删除满折条件</a>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
            
            <div class="row hide promotionContent" id="fullSubtract">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <#if orderTotalConditionRuleList?? && orderTotalConditionRuleList?has_content>
                        	<#if promotion?? && promotion.promotionTypeCd == 2>
                            <#list orderTotalConditionRuleList as conditionRule>
                                <div class="ConditionPanel">
                                	<label class="control-label"><s>*</s>满减条件：</label>
                                    <input <#if (promotion.promotionId)??>disabled</#if> value="${(conditionRule.conditionExpressionValue)!}" name="subtractCondition" class="input-small control-text" 
                                    	data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}">
                                    &nbsp;&nbsp;&nbsp;
									<s>*</s>满减金额：
                                    <input <#if (promotion.promotionId)??>disabled</#if> value="${(conditionRule.discountValueShow)!}" name="subtractValue" class="input-small control-text" 
                                    	data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}">
                                    &nbsp;&nbsp;&nbsp;
                                    <#if (orderTotalConditionRuleList?size == 1)>
                                    <label class="radio">
			                            <input type="checkbox" name="isRuleAdded" id="isRuleAdded"  <#if conditionRule.isRuleAdded?has_content> checked="checked" </#if> value='1' type="radio"
			                            <#if (promotion.promotionId)??>disabled</#if> >
			                                                                      上不封顶
			                        </label>&nbsp;&nbsp;
			                        </#if>
                                </div>
                            </#list>
                            </#if>
                        <#else>
                            <div class="ConditionPanel">
                            	<label class="control-label"><s>*</s>满减条件：</label>
                                <input value="" name="subtractCondition" class="input-small control-text" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" 
                                	data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}">
                                &nbsp;&nbsp;&nbsp;
								<s>*</s>满减金额：
                                <input value="" name="subtractValue" class="input-small control-text" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" 
                                	data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}">
                                &nbsp;&nbsp;&nbsp;
                                <label class="radio">
		                            <input type="checkbox" name="isRuleAdded" id="isRuleAdded" value='1' type="radio">
		                                                                      上不封顶
		                        </label>&nbsp;&nbsp;
                                <a href="javascript:void(0);" class="addCondition">+增加满减条件</a>
                                <a href="javascript:void(0);" class="delCondition" style="display: none;">删除满减条件</a>
                            </div>
                        </#if>
                    </div>
                </div>
            </div>
            
            <div class="row hide promotionContent" id="fullGift">
                <div class="control-group">
                    <div class="controls control-row-auto" style="width:100%;">
                    	<#if conditionGiftMap?? && conditionGiftMap?has_content>
                    		<#list conditionGiftMap?keys as key>
                    			<div class="ConditionPanel" style="width:100%;">
		                    		<label class="control-label"><s>*</s>满赠条件：</label>
			                        <input value="${key}" name="fullGiftCondition" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" 
			                        	data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}" class="input-normal control-text" disabled >
			                        &nbsp;&nbsp;&nbsp;
		                            <div class="row">
						                <ul class="toolbar">
						                    <li>
						                        <input type="hidden" name="fullGiftProductIds" class="fullGiftProductIds" value="${conditionGiftMap[key]!}">
						                        <button id="bp_${key_index}" type="button" class="button button-info">
						                        <i class="icon icon-white icon-envelope"></i> 选择商品</button>
						                    </li>
						                </ul>
						                <hr>
						                <div class="search-grid-container">
						                    <div id="p_${key_index}" class="search-pid"></div>
						                </div>
						            </div>
		                        </div>
                    		</#list>
                    	<#else>
	                    	<div class="ConditionPanel" style="width:100%;">
	                    		<label class="control-label"><s>*</s>满赠条件：</label>
		                        <input name="fullGiftCondition" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" 
		                        	data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}" class="input-normal control-text"  >
		                        &nbsp;&nbsp;&nbsp;
	                            <a href="javascript:void(0);" class="addCondition">+增加满赠条件</a>
	                            <a href="javascript:void(0);" class="delCondition" style="display: none;">删除满赠条件</a>
	                            <div class="row">
					                <ul class="toolbar">
					                    <li>
					                        <input type="hidden" name="fullGiftProductIds" class="fullGiftProductIds" >
					                        <button id="bp_0" type="button" class="button button-info">
					                        <i class="icon icon-white icon-envelope"></i> 选择商品</button>
					                    </li>
					                </ul>
					                <hr>
					                <div class="search-grid-container">
					                    <div id="p_0" class="search-pid"></div>
					                </div>
					            </div>
	                        </div>
                    	</#if>
                    </div>
                </div>
            </div>
            
            <#if promotionConditionList?? && promotionConditionList?has_content>
            	<#list promotionConditionList as promotionCondition>
            		<#if promotionCondition.promotionRuleTypeCd == 4>
            			<#assign pinkageCondition = promotionCondition.conditionExpression?default('')>
            		<#else>
            			<#assign pinkageNumber = promotionCondition.conditionExpression?default('')>
            		</#if>
            	</#list>
            <#else>
            </#if>
            <div class="row hide promotionContent" id="pinkageCondition">
                <div class="control-group">
                    <label class="control-label">订单总额满足条件：</label>
                    <div class="controls">
                        <input value="${(pinkageCondition)!}" name="pinkageCondition" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" 
                        	data-messages="{regexp:'请输入大于0的合法金额,且整数位不能超过16位'}" class="input-normal control-text" <#if (promotion)?has_content> disabled </#if> > 元
                    </div>
                </div>
            </div>
            
            <div class="row hide promotionContent" id="pinkageNumber">
                <div class="control-group">
                    <label class="control-label">订单商品满足件数：</label>
                    <div class="controls">
                        <input value="${(pinkageNumber)!}" name="pinkageNumber" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,9}))$/}" 
                        	data-messages="{regexp:'请输入整数,且位数不能大于10位'}" class="input-normal control-text" <#if (promotion)?has_content> disabled </#if> > 件
                    </div>
                </div>
            </div>

            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>

<div id="areaContent" class="hide">
    <div class="area-list">
        <div class="item">
            <div class="hd">
                <label class="checkbox" for="isAllCountry">
                	<input type="checkbox" id="isAllCountry" <#if isAllAreaJoin>checked</#if> <#if (promotion.promotionId)??>disabled</#if> />全国
                </label>
            </div>
            <div class="bd">
                <#if provinceList?? && provinceList?has_content>
                    <ul>
                        <#list provinceList as province>
                            <#assign provinceSelect = false/>
                            <#if (provinceXrefMap[province.id?string])??>
                                <#assign provinceSelect = true/>
                            </#if>
                            <li>
                                <#assign cityList = cityMap[province.id?string]?default("")/>
                                <label class="checkbox" for="province_${province_index}">
                                    <input type="checkbox" name="province_" data-province="${province_index}"  value="${province.id}" <#if provinceSelect> checked='checked' </#if>  
                                    <#if (promotion.promotionId)??> disabled </#if> id="province_${province_index}" />${(province.areaName)!}
                                    <#if cityList?is_sequence && cityList?size gt 0><em>(${cityList?size})</em><i class="x-caret x-caret-down"></i></#if>
                                </label>

                                <#if cityList?is_sequence && cityList?size gt 0>
                                    <div class="area-droplist">
                                        <#list cityList as city>
                                        	<#assign citySelect = false/>
                                            <#if (cityXrefMap[city.id?string])??>
                                                <#assign citySelect = true/>
                                            </#if>
                                            <label class="checkbox" for="city_${province_index}_${city_index}">
                                                <input type="checkbox" name="city_" data-province="${province_index}" data-city="${city_index}" value="${city.id}" <#if citySelect> checked='checked' </#if>
                                                id="city_${province_index}_${city_index}" <#if (promotion.promotionId)??> disabled </#if>/>${(city.areaName)!}
                                            </label>
                                        </#list>
                                    </div>
                                </#if>
                            </li>
                        </#list>
                    </ul>
                </#if>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var dialogregion = null;
    var choiceProductDialog = null;
    var selectProductIds = [];//存放所选择的商品
    var fullGiftProductIds = [];
    var fullGiftId = 'p_0';
    var cloneIdNum = 1;//存放复制后id的后缀数
    var promotionType = 1;//活动类型默认为1：满折（2：满减，3：满赠，4：限时降价，5：包邮）

    BUI.use('bui/overlay',function(Overlay){
        $(".area-list .bd li").each(function(){
            var li = $(this),
                    labelbox = li.find(".checkbox").eq(0),
                    droplist = li.find(".area-droplist");
            if(droplist[0]){
                li.hover(function(){
                    labelbox.addClass("current");
                    droplist.show();
                },function(){
                    labelbox.removeClass("current");
                    droplist.hide();
                })
            }
        });

        dialogregion = new Overlay.Dialog({
            title:'选择地区',
            width:680,
            height:400,
            mask:true,
            buttons:[
                {
                    text:'确定',
                    elCls : 'button button-primary',
                    handler : function(){
                        var selectProvinceIds = [];
                        var selectCityIds = [];
                        $("input[name='province_']").filter(":checked").each(function(){
                            selectProvinceIds.push($(this).val());
                        });
                        $("input[name='city_']").filter(":checked").each(function(){
                            selectCityIds.push($(this).val());
                        });

                        $("#selectProvinceIds").val(selectProvinceIds.join(','));
                        $("#selectCityIds").val(selectCityIds.join(','));

                        this.close();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ],
            contentId : 'areaContent'
        });

        choiceProductDialog = new Overlay.Dialog({
            title:'商品列表',
            width: 1000,
            height: 460,
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
        
    });
    
    BUI.use(['bui/overlay','bui/grid','bui/data'],function(Overlay,Grid,Data){
          var Store = Data.Store,
           columns = [
            {title : '商品编号',dataIndex :'productId', width:100},
            {title : '商品名称',dataIndex :'productName', width:300},
            {title : '商品挂牌价',dataIndex :'tagPrice', width:200},
            {title : '商品零售价',dataIndex : 'defaultPrice',width:200}
          ];
        var store = new Store({
            url : '${ctx}/admin/sa/promotion/sales/productIsGift/grid_json',
            autoLoad:true,
            pageSize : 15,
          }),
          grid = new Grid.Grid({
           	forceFit: true, // 列宽按百分比自适应
            columns : columns,
            store : store,
            multipleSelect : true,//多选
            plugins : [BUI.Grid.Plugins.CheckSelection],//插件的形式引入多选
            bbar:{
                  pagingBar:true
                }
          });
 
 
      var dialog = new Overlay.Dialog({
            title:'赠品列表',
            width:920,
            height:400,
            children : [grid],
			childContainer : '.bui-stdmod-body',
			buttons:[{
                text:'选 择',
                elCls : 'button button-primary',
                handler : function(){
                    this.close();
                    giftProductChoiceEvent(grid.getSelection());
                }
            }],
          });

        $('#fullGift').on('click','.button',function () {
          fullGiftId = $(this).attr('id').replace('b','');
          
          //如果是编辑操作，就经用掉选择商品或赠品的按钮icon-envelope
          <#if promotion?? && promotion?has_content>
          	return false;
          </#if>
          
          /*每次点击选择赠品的时候,都对fullGiftProductIds进行处理*/
          var currentProductIds = $(this).prev('.fullGiftProductIds').val();//获取所点击节点中隐藏域的值
          if(currentProductIds) {
          	if(fullGiftProductIds.join(',') != currentProductIds) {//如果全局的fullGiftProductIds，与隐藏域的值不相等，那就代表操作的是一个新的赠品
          		fullGiftProductIds = currentProductIds.split(',');
          	}
          }else{//没有值就清空fullGiftProductIds
          	fullGiftProductIds = [];
          }
          
          giftProductColumn();
          buildGiftProductGrid();
          dialog.show();
        });
      });
    
    
    
    /**
     * 构建商品表格
     *
     */
    var Grid = BUI.Grid,
            Data = BUI.Data,
            Store = Data.Store;
    var productColumns = [];
    <#if promotion?? && promotion.promotionTypeCd == 4>
    	productColumns2();
    <#else>
		productColumns1();
    </#if>
    
    //赠品表格
    var giftproductColumns = [];
    giftProductColumn();
    
    var productStore;
    var productGrid;
    function buildProductGrid(){
        productStore = new Store({
        	<#if promotion ?? && promotion.promotionTypeCd?? && promotion.promotionTypeCd == 4>
            	url : '${ctx}/admin/sa/promotion/combination/combinationProduct/grid_json',
            <#else>
	            url : '${ctx}/admin/sa/label/productDialog/grid_json',
            </#if>	
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : selectProductIds.join(","),
                promotionId:$('#promotionId').val()
            },
            pageSize : 5
        });
        productGrid = new Grid.Grid({
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
    
    /*赠品*/
    var giftProductStore;
    var giftProductGrid;
    function buildGiftProductGrid(){
        giftProductStore = new Store({
            url : '${ctx}/admin/sa/label/productDialog/grid_json',
            autoLoad:false, //自动加载数据
            params : { //配置初始请求的参数
                sort : 'id desc',
                "in_id" : fullGiftProductIds.join(",")
            },
            pageSize : 5
        });
        giftProductGrid = new Grid.Grid({
            render:'#' + fullGiftId,
            columns : giftproductColumns,
            store: giftProductStore,
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:true
            },
            loadMask:true
        });

        //监听事件，删除一条记录
        giftProductGrid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
            	fullGiftId = sender.parents('.search-pid').attr('id');//记录点击的是哪块赠品
                var record = ev.record;
                deleteGiftProduct(record);
            }
        });
        
        $('#'+fullGiftId).empty();

        giftProductGrid.render();
    }
    
    //删除商品操作
    function deleteProduct(record){
    	//如果是编辑操作，则该操作禁止
        <#if promotion?? && promotion?has_content>
        	return;
        </#if>
        BUI.Message.Confirm('确认删除记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + selectProductIds.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            selectProductIds = tempArray;
			
			//删除商品不重载数据
			productStore.remove(record);
			
            //reloadProductCondition();
        },'question');
    }
    
    //删除赠品操作
    function deleteGiftProduct(record){
    	//如果是编辑操作，则该操作禁止
        <#if promotion?? && promotion?has_content>
        	return;
        </#if>
        BUI.Message.Confirm('确认删除记录？',function(){
            var recordId = "," + record.productId + ",";
            var originProductIdStr = "," + fullGiftProductIds.join(",") + ",";
            originProductIdStr = originProductIdStr.replace(recordId, ",");

            var tempArray = originProductIdStr.split(',');
            tempArray.pop();
            tempArray.shift();
            fullGiftProductIds = tempArray;
            
            //删除商品不重载数据
            giftProductStore.remove(record);
            
			$('#'+fullGiftId).parent().parent().find('.fullGiftProductIds').val(fullGiftProductIds.join(','));//把操作后的数据记录在对应的隐藏域中
            //reloadGiftProductCondition();
        },'question');
    }
    /**
    * 初始化
    *
    * @type {Array}
    */
    
    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initProductCondition(){
	    var isNew = $('#promotionId').val();//如果promotionId有就是编辑操作
	    
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
                var records = giftProductStore.getResult();
                productStore.remove(records);
            }
        }
    }
    
    //判断是否是添加操作还是编辑操作，在进行数据初始化
    function initGiftProductCondition(){
	    var isNew = $('#promotionId').val();//如果promotionId有就是编辑操作
	    
	    if(!isNew){
	       buildGiftProductGrid();
	    }else {   
            var productIds = '';
            <#if conditionGiftMap?? && conditionGiftMap?has_content>
        		<#list conditionGiftMap?keys as key>
        			productIds = '${conditionGiftMap[key]!}';
            		fullGiftProductIds = productIds.split(',');
            		fullGiftId = 'p_${key_index}';
            		giftProductColumn();
            		buildGiftProductGrid();
            		if(fullGiftProductIds.length > 0){
		                giftProductStore.load();
		            }
        		</#list>
        	</#if>
        }
	}
	
    //添加新的商品时，去除重复商品
	function giftProductChoiceEvent(selectedProduct){
        var oldProductStr = "";
        oldProductStr = "," + fullGiftProductIds.join(',') + ",";
        for(var i = 0; i < selectedProduct.length; i++){
            var id = selectedProduct[i].productId;
            if(oldProductStr.indexOf("," + id + ",") < 0){
                fullGiftProductIds.push(id);
            }
        }
        reloadGiftProductCondition();
    }
	//重新加载数据
    function reloadGiftProductCondition(){
        if(!giftProductStore){
            buildGiftProductGrid();
            if(fullGiftProductIds.length > 0){
                giftProductStore.load();
            } else {
                var records = giftProductStore.getResult();
                giftProductStore.remove(records);
            }
            $('#'+fullGiftId).parent().parent().find('.fullGiftProductIds').val(fullGiftProductIds.join(','));//把操作后的数据记录在对应的隐藏域中
        } else {
            if(fullGiftProductIds.length > 0){
                var params = { //配置初始请求的参数
                    start : 0,
                    "in_id" : fullGiftProductIds.join(",")
                };
                giftProductStore.load(params);
            } else {
                var records = giftProductStore.getResult();
                giftProductStore.remove(records);
            }
            $('#'+fullGiftId).parent().parent().find('.fullGiftProductIds').val(fullGiftProductIds.join(','));//把操作后的数据记录在对应的隐藏域中
        }
    }
    
	
    $(function(){
    	//选择优惠类型
    	$('#promotionTypeCd').change(function() {
    		initPromotionTypeCd();
    	});
    	
    	<#if promotion??>
    		initPromotionTypeCdEdit();//编辑的时候使用该方法调整页面的效果
    	</#if>
    	
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
        
		//全国操作
        $("#isAllCountry").on('change', function(){
            $("input[name='province_']").prop("checked", this.checked);
            $("input[name='city_']").prop("checked", this.checked);
            if(this.checked){
                $('#isAllAreaJoin').val("1");
            }else{
                $('#isAllAreaJoin').val("0");
            }
        });

        <#if isAllAreaJoin>
            $("#isAllCountry").trigger('change');
        </#if>
		//省、市操作
        $("input[name='province_']").on('change', function(){
            var province = $(this).attr("data-province");
            $("input[name='city_'][data-province='"+province+"']").prop("checked", this.checked);
        });

        $("input[name='city_']").on('change', function(){
            var province = $(this).attr("data-province");
            var $subs = $("input[name='city_'][data-province='"+province+"']");
            $("input[name='province_'][data-province='"+province+"']").prop("checked" , $subs.length == $subs.filter(":checked").length ? true :false);
        });
        
        //点击添加条件,on处理
        $('#fullGift').on('click','.addCondition',function(){
            addCondition($(this));
        });
        
        //点击添加条件
        $('.addCondition').click(function(){
            addCondition($(this));
        });
        
        //点击删除条件,on处理
        $('#fullGift').on('click','.delCondition',function(){
            deleteCondition($(this));
        });
        
        //点击删除条件
        $('.delCondition').click(function(){
            deleteCondition($(this));
        });
        
        //选择上不封顶
        $('#isRuleAdded').on('click',function() {
        	if($(this).filter(":checked").length < 1) {
        		$(this).parent().parent().find('.addCondition').show();
        	} else {
        		$(this).parent().parent().find('.addCondition').hide();
        	}
        });

		//点击选择商品显示商品列表窗口
        $("#choiceProductBtn").on('click', function(){
        	//如果是编辑操作，则该操作禁止
            <#if promotion?? && promotion?has_content>
            	return;
            </#if>
            var selectChannelCount = $("input[name='promotionChannel']").filter(":checked");
            var shelveChannelCds = '';//渠道
            if(selectChannelCount.length < 1) {
            	app.showError('请选择渠道!');
                return false;
            } else {
            	shelveChannelCds = '';
            	selectChannelCount.each(function() {
            		shelveChannelCds += ',' + $(this).val(); 
            	});
            }
            
            choiceProductDialog.get('loader').load({'shelveChannelCds':shelveChannelCds});
            choiceProductDialog.show();
        });

        initActivityRadioEvent();
        
        <#if !isAllProduct>
            $("input[name='activityProducts']").trigger('change');
        </#if>
        
        //initPromotionTypeCd();
		
		//表单提交
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!");
                    window.location.href = "${ctx}/admin/sa/promotion/sales/list";
                }
            }
        });
        
        //提交表单之前的检查
        form.on('beforesubmit', function(){
        	var selectChannelCount=$("input[name='promotionChannel']").filter(":checked").length;
            if(selectChannelCount <1){
                app.showError('请选择渠道!');
                return false;
            }
            
        	var selectUserLevelCount=$("input[name='userLevel']").filter(":checked").length;
            if(selectUserLevelCount <1){
                app.showError('请选择会员级别!');
                return false;
            }
            
            if($($("input[name='activityProducts']").filter(":checked").get(0)).attr('id') == "appointProduct"){
                // 指定商品
                if(selectProductIds.length < 1){
                    app.showError('请选择商品!');
                    return false;
                }
                $('#selectProductIds').val(selectProductIds.join(','));
            }
            
            //根据所选择优惠类型的验证数据
            if(!testPromotionTypeCd()) {
            	return false;
            }

            return true;
        })
        
        form.render();
        
        initProductCondition();
        initGiftProductCondition();
        
        //重置按钮
        $('.actions-bar button[type="reset"]').click(function() {
        	//如果是编辑操作,只重置启用状态
            <#if promotion?? && promotion?has_content>
            	$('.controls input[name="statusCd"][value="${(promotion.statusCd)!default(1)}"]').attr("checked",true);
            	return;
            </#if>
            $('.controls input[name="statusCd"][value="1"]').attr("checked",true);
            $('.controls input[name="statusCd"][value="1"]').parent().trigger('change');
            $('.controls input[name="promotionTypeCd"][value="1"]').attr("checked",true);
            $('.controls input[name="promotionTypeCd"][value="1"]').parent().trigger('change');
            $('#allProduct').attr("checked",true);
            $('#allProduct').trigger('change');
        });
    });

	//显示选择地区的窗口
    function selectArea(){
        dialogregion.show();
    }
	
	//根据活动产品单选的结果，看是否显示选择商品按钮
    function initActivityRadioEvent(){
        $("input[name='activityProducts']").on('change', function(){
            var id = $(this).attr('id');
            if (id == "appointProduct") {
                $("#productInfo").show();
                $("#quotaNum").hide();
                 $("#quotaNum").val('');//清空限购数的值
                  $("#quotaNum").trigger('change');//防止错误提示的不正常显示
                //reloadProductCondition();
            } else {
                $("#productInfo").hide();
                $("#quotaNum").show();
            }
        });
    }
    
    //根据优惠类型单选的结果，显示对应的字段（新增的时候）
    function initPromotionTypeCd() {
    	promotionType = $("#promotionTypeCd input:checked").val();
    	if($('#promotionId').val() == '') {
    		clienCondition();
    	}
    	switch(promotionType) {
    		case '1': 
    			$('.promotionContent').hide();
    			$('#fullDiscount').show();
    			$('#productGrid').empty();
				productColumns1();
			    buildProductGrid();
    			break;
    		case '2': 
    			$('.promotionContent').hide();
    			$('#fullSubtract').show();
    			$('#productGrid').empty();
				productColumns1();
			    buildProductGrid();
    			break;
    		case '3': 
    			$('.promotionContent').hide();
    			$('#fullGift').show();
    			$('#productGrid').empty();
				productColumns1();
			    buildProductGrid();
			    giftProductColumn();
			    buildGiftProductGrid();
    			break;
    		case '4': 
    			$('.promotionContent').hide();
    			$('#allProduct').parent().hide();
				$('#productGrid').empty();
				productColumns2();
			    buildProductGrid();
    			break;
    		case '5': 
    			$('.promotionContent').hide();
    			$('#pinkageCondition').show();
    			$('#pinkageNumber').show();
    			$('#productGrid').empty();
				productColumns1();
			    buildProductGrid();
    			break;
    	}
    }
    
    //根据优惠类型单选的结果，显示对应的字段(编辑的时候)
    function initPromotionTypeCdEdit() {
    	promotionType = $("#promotionTypeCd input:checked").val();
    	if($('#promotionId').val() == '') {
    		clienCondition();
    	}
    	switch(promotionType) {
    		case '1': 
    			$('.promotionContent').hide();
    			$('#fullDiscount').show();
    			break;
    		case '2': 
    			$('.promotionContent').hide();
    			$('#fullSubtract').show();
    			break;
    		case '3': 
    			$('.promotionContent').hide();
    			$('#fullGift').show();
    			break;
    		case '4': 
    			$('.promotionContent').hide();
    			$('#allProduct').parent().hide();
    			break;
    		case '5': 
    			$('.promotionContent').hide();
    			$('#pinkageCondition').show();
    			$('#pinkageNumber').show();
    			break;
    	}
    }
    
    //提交表单时，根据优惠类型单选的结果，给出对应提示
    function testPromotionTypeCd() {
    	var promotionTypeCd = $("#promotionTypeCd input:checked").val();
    	var result = true;
    	switch(promotionTypeCd) {
    		case '1': 
    			if($('input[name="discountCondition"]').val() == '') {
    				app.showError('折扣条件不能为空！');
    				result = false;
    			}
    			if($('input[name="discountValue"]').val() == '') {
    				app.showError('满额折扣不能为空！');
    				result = false;
    			}
    			break;
    		case '2': 
    			if($('input[name="subtractCondition"]').val() == '') {
    				app.showError('满减条件不能为空！');
    				result = false;
    			}
    			if($('input[name="subtractValue"]').val() == '') {
    				app.showError('满减金额不能为空！');
    				result = false;
    			}
    			break;
    		case '3': 
    			$('input[name="fullGiftCondition"]').each(function() {
    				if($(this).val() == '') {
	    				app.showError('满赠条件不能为空！');
	    				result = false;
    				}
    			});
    			
    			$('input[name="fullGiftProductIds"]').each(function() {
    				if($(this).val() == '') {
	    				app.showError('请选择要赠送的商品！');
	    				result = false;
    				}
    			});
    			break;
    		case '4': 
    			var lowerPriceArr = [];//存放商品的限时降价金额
	            var userLimitNumArr = [];//存放商品的限购数
	            for(var i = 0; i < selectProductIds.length; i++) {
	            	var productId = selectProductIds[i];
	            	var lowerPrice = $('#lowerPrice'+productId).val();
	            	var userLimitNum = $('#userLimitNum'+productId).val();
	            	if(lowerPrice == '') {
	            		app.showError('请填写商品的限时降价金额!');
	            		return false;
	            	}
	            	
	               var reg = /^(([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/;
		           if(!reg.test(lowerPrice)){
		               app.showError('请填写大于0的合法商品限时降价金额,且整数位不能超过16位!');
	            	   return false;
	               }
	               
	               if(userLimitNum == '') {
	               		app.showError('请填写商品的限购数!');
	            		return false;
	               }
	               
	               var regNum = /^([1-9][0-9]{0,10})$/;
		           if(!regNum.test(userLimitNum)){
		               app.showError('请填写大于0的正整数,且不能超过11位!');
	            	   return false;
	               }
	            	
	            	lowerPriceArr[i] = lowerPrice;
	            	userLimitNumArr[i] = userLimitNum;
	            }
	            
	            $('#lowerPriceArr').val(lowerPriceArr.join(','));
	            $('#userLimitNumArr').val(userLimitNumArr.join(','));
    			break;
    		case '5': 
    			if($('input[name="pinkageCondition"]').val() == '' && $('input[name="pinkageNumber"]').val() == '') {
    				app.showError('订单总额满足条件或订单商品满足件数，至少填写一项！');
    				result = false;
    			}
    			break;
    	}
    	return result;
    }
    
    //清空所有的条件和值，并防止错误提示的不正常显示
    function clienCondition() {
    	//满扣
    	$('input[name="discountCondition"]').val('');//清空对应的值
    	$('input[name="discountCondition"]').trigger('change');//防止错误提示的不正常显示
    	$('input[name="discountValue"]').val('');
    	$('input[name="discountValue"]').trigger('change');
    	//满减
    	$('input[name="subtractCondition"]').val('');
    	$('input[name="subtractCondition"]').trigger('change');
    	$('input[name="subtractValue"]').val('');
    	$('input[name="subtractValue"]').trigger('change');
    	//满赠
    	$('input[name="fullGiftCondition"]').val('');
    	$('input[name="fullGiftCondition"]').trigger('change');
    	$('input[name="fullGiftProductIds"]').val('');
    	$('input[name="fullGiftProductIds"]').trigger('change');
    	$('#fullGift .controls').html(giftHtml());
    	//限时降价

    	//包邮
    	$('input[name="pinkageCondition"]').val('');
    	$('input[name="pinkageCondition"]').trigger('change');
    	$('input[name="pinkageNumber"]').val('');
    	$('input[name="pinkageNumber"]').trigger('change');
    }
    
    //添加满赠商品的html
    function giftHtml() {
    	var div = '';
        
        div += '<div class="ConditionPanel" style="width:100%;">';
		div += '    <label class="control-label"><s>*</s>满赠条件：</label>';
	    div += '    <input name="fullGiftCondition" data-rules="{regexp:/^([1-9]?|([1-9][0-9]{0,15})|(([0]\.\d{1,2}|[1-9][0-9]{0,15}\.\d{1,2})))$/}" ';
	    div += '    data-messages="{regexp:\'请输入大于0的合法金额,且整数位不能超过16位\'}" class="input-normal control-text"  >';
	    div += '    &nbsp;&nbsp;&nbsp;';
	    div += '    <a href="javascript:void(0);" class="addCondition">+增加满赠条件</a>';
	    div += '    <a href="javascript:void(0);" class="delCondition" style="display: none;">删除满赠条件</a>';
	    div += '    <div class="row">';
	    div += '        <ul class="toolbar">';
	    div += '            <li>';
	    div += '                <input type="hidden" name="fullGiftProductIds" class="fullGiftProductIds" >';
	    div += '                <button id="bp_0" type="button" class="button button-info">';
	    div += '                <i class="icon icon-white icon-envelope"></i> 选择商品</button>';
	    div += '            </li>';
	    div += '        </ul>';
	    div += '        <hr>';
	    div += '        <div class="search-grid-container">';
	    div += '            <div id="p_0" class="search-pid"></div>';
	    div += '        </div>';
	    div += '    </div>';
	    div += '</div>';
        
        return div;
    } 
    
    //删除条件处理
    function deleteCondition(_this) {
        _this.closest(".ConditionPanel").remove();
        if($('input[name="isRuleAdded"]').length == 1) {
        	$('input[name="isRuleAdded"]').parent().show();
        }
    }
    
    //添加条件处理
    function addCondition(_this) {
    	var parentPanel = _this.closest(".ConditionPanel");

        var cloneCondition = parentPanel.clone(true);
        //清空复制过来的值
        var inputArr=cloneCondition.find("input");
        inputArr.each(function (){
            $(this).val("");
            if($(this).attr('name') == "fullGiftCondition") {
            	var productIsGiftGrid = $(this).parent().find('.search-grid-container');
            	//改变id值
            	if(productIsGiftGrid) {
                	var id = productIsGiftGrid.find('div').attr("id");
                	id = 'p_' + cloneIdNum;
                	productIsGiftGrid.find('div').attr("id",id).empty();
                }
                var productIsGiftBt = $(this).parent().find('.button-info');
                //改变id值
                if(productIsGiftBt) {
                	var id = productIsGiftBt.attr('id');
                	id = 'bp_' + cloneIdNum;
                	productIsGiftBt.attr("id",id);
                }
                cloneIdNum++;
            }
            
            if($(this).attr('name') == "isRuleAdded") {
            	$('input[name="isRuleAdded"]').parent().hide();
            	$(this).parent().hide();
            }
            
        });
        cloneCondition.find(".delCondition").show();

        cloneCondition.insertAfter(parentPanel);
    }
    
    //构建商品表格
    function productColumns1() {
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
	        {title: '品牌名称', dataIndex: 'brandName', width: 120},
	        {title: '分类名称', dataIndex: 'categoryName', width: 120},
	        {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
	        {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
	        <#if promotion?? && promotion?has_content>
	        	{title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
		            var delStr = '<span title="删除商品信息">删除</span>';
		            return delStr;
		        }}
	        <#else>
		        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
		            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
		            return delStr;
		        }}
	        </#if>
	    ];
    }
    
    //构建商品表格（多了限时降价金额和限购数）
    function productColumns2() {
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
	        {title: '品牌名称', dataIndex: 'brandName', width: 120},
	        {title: '分类名称', dataIndex: 'categoryName', width: 120},
	        {title: '商品挂牌价', dataIndex: 'tagPrice', width: 120},
	        {title: '商品零售价', dataIndex: 'defaultPrice', width: 120},
	        {title: '限时降价金额', dataIndex: 'price', width: 180,renderer : function(value, obj) {
	        	value = value || '';
	            return '<input type="text" id="lowerPrice'+obj.productId+'" data-rules="{required:true}"  value="' + value + '" <#if (promotion.promotionId)??>disabled</#if>/>';
	        }},
	        {title: '限购数', dataIndex: 'userLimitNum', width: 180,renderer : function(value, obj) {
	        	value = value || '';
	            return '<input type="text" id="userLimitNum'+obj.productId+'" data-rules="{required:true}"  value="' + value + '" <#if (promotion.promotionId)??>disabled</#if>/>';
	        }},
	        <#if promotion?? && promotion?has_content>
	        	{title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
		            var delStr = '<span title="删除商品信息">删除</span>';
		            return delStr;
		        }}
	        <#else>
		        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
		            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
		            return delStr;
		        }}
	        </#if>
	    ];
    }
    
    //构建赠品表格
    function giftProductColumn() {
	    giftproductColumns = [
	        {title: '商品ID', dataIndex: 'productId', width: 120},
	        {
	            title: '商品名称',
	            dataIndex: 'productName',
	            width: 200,
	            renderer: function (value) {
	                return app.grid.format.encodeHTML(value);
	            }
	        },
	        {title: '商品挂牌价', dataIndex: 'tagPrice', width: 150},
	        {title: '商品零售价', dataIndex: 'defaultPrice', width: 150},
	        <#if promotion?? && promotion?has_content>
	        	{title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
		            var delStr = '<span title="删除商品信息">删除</span>';
		            return delStr;
		        }}
	        <#else>
		        {title:'操作',dataIndex:'',width:120,renderer : function(value,obj){
		            var delStr = '<span class="grid-command btn-del" title="删除商品信息">删除</span>';
		            return delStr;
		        }}
	        </#if>
	    ];
    }
</script>
</body>
</html>