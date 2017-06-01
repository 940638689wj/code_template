<div class="form-horizontal" xmlns="http://www.w3.org/1999/html">
	<script>
    var errg = "只能输入8个汉字或16个字母";
       function onblu(td){
       var name = $(td).val();
         if(strlen(name)>16)
                {
                    app.showError(errg);
                  $(td).val("");
                    return;
                }
       }
     //计算字符串长度(可同时字母和汉字，字母占一个字符，汉字占2个字符)
    function strlen(str){
        var len = 0;
        for (var i=0; i<str.length; i++) {
            var c = str.charCodeAt(i);
            //单字节加1
            if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
                len++;
            }
            else {
                len+=2;
            }
        }
        return len;
    }
		function showCont(){
			switch($("input[name=scoreDisCountTypeCd]:checked").attr("value")){
			  case "1":
			  //alert("one");
			   	$("#scoreDiscountValue2").val("");
			  	$("#scoreDiscountValue2").attr("readonly",true);
			  	$("#scoreDiscountValue1").removeAttr("readonly");			   			   
			   break;
			  case "2":
			  	$("#scoreDiscountValue1").val("");
			 	$("#scoreDiscountValue1").attr("readonly",true);
			 	$("#scoreDiscountValue2").removeAttr("readonly");		
			 //alert("two");
			   break;
			  default:
			   	break;
			 }
		}
		function showTime(){
			switch($("input[name=productStatusCd]:checked").attr("id")){
			  case "1":
			  	$("#time").hide();			   			   
			   	break;
			  case "2":
			  	$("#time").hide();
			  	break;
			  case "3":
			  	$("#time").show();	
			   	break;
			  default:
			   	break;
			 }
		}
		function changePointType(){
			switch($("input[name=productPointTypeCd]:checked").attr("value")){
			  case "1":
			  	//alert("one");
			  	$("#productPointValue2").val("");
			  	$("#productPointValue2").attr("readonly",true);
			  	$("#productPointValue2").removeAttr("name");
			  	$("#productPointValue1").attr("name","productPointValue");
			  	$("#productPointValue1").removeAttr("readonly");
			  	//alert($("#productPointValue1").attr("name"));
			   	break;
			  case "2":
			  	//alert("two");
			  	$("#productPointValue1").val("");
			  	$("#productPointValue1").attr("readonly",true);
			  	$("#productPointValue1").removeAttr("name");		  	
			  	$("#productPointValue2").attr("name","productPointValue");
			  	$("#productPointValue2").removeAttr("readonly");
			  	break;
			  default:
			   	break;
			 }
		}
		//模拟点击
		function selectInput(Input){
			var input = $(Input);
			input.prev().trigger('click');
		}
		function selectInput2(Input){
			var input = $(Input);
			//alert(input.attr("id"))
			if(input.attr("id")=="productPointValue1"){
				$("#productPointTypeCd1").trigger('click');
			}else if(input.attr("id")=="productPointValue2"){
				$("#productPointTypeCd2").trigger('click');
			}
		}
	$(function(){
		
		$('#productFieldContainer').on('click','#addProductField',function(){
            var targetPannel = $("#productFieldPannel").clone();
            targetPannel.removeAttr("id");
            targetPannel.find("input[name='productFieldName']").val('');
            targetPannel.find("input[name='productFieldValue']").val('');

            targetPannel.show();
            targetPannel.insertBefore("#productFieldPannel");
        });

        $('#productFieldContainer').on('click','.delProductField',function(){
            var delItem = $(this).closest('.control-group');
            delItem.remove();
        });
			// 商品属性
	        $('#productAttributeContainer').on('click','#addProductAttribute',function(){
	            var targetPannel = $("#productAttributePannel").clone();
	            targetPannel.removeAttr("id");
	            targetPannel.find("input[name='productAttributeName']").val('');
	            targetPannel.find("input[name='productAttributeValue']").val('');

	            targetPannel.show();
	            targetPannel.insertBefore("#productAttributePannel");
	        });

	        $('#productAttributeContainer').on('click','.delProductAttribute',function(){
	            var delItem = $(this).closest('.control-group');
	            delItem.remove();
	        });
	      

	});

	</script>
 
<div class="panel mb10">
    <div class="panel-header"><h3>基本信息</h3></div>
        <div class="panel-body"> 
        	<div class="control-group mb10">
                <label class="control-label control-label-maxlong"><s>*</s>商品名称：</label>
                <div class="controls control-row-auto">
                    <textarea name="productName" data-rules="{maxlength:200}" id="productName"  class="input-large">${(product.productName)!?html}</textarea>
                </div>
            </div>
        	<div class="control-group mb10">
                <label class="control-label control-label-maxlong"><s>*</s>商品描述：</label>
                <div class="controls control-row-auto">
                    <textarea name="productSubTitle" data-rules="{maxlength:200}" id="productSubTitle"  class="input-large">${(productExtend.productSubTitle)!?html}</textarea>
                </div>
            </div>

            <div class="control-group mb10">
                <label class="control-label control-label-maxlong"><s>*</s>配送方式：</label>
                <div class="controls control-row-auto">
                    <div class="mb10">快递配送：
						<#assign isAllAreaJoin = (grouponDTO.isAllAreaJoin)?default(false)/>
                        <a class="button" onclick="selectArea();">+选择城市</a>
                        <input type="hidden" name="isAllAreaJoin" id="isAllAreaJoin" value="<#if isAllAreaJoin>1<#else>0</#if>">
                        <input type="hidden" name="selectProvinceIds" id="selectProvinceIds" <#if provinceIds?? && provinceIds?has_content>value="${provinceIds}" </#if>>
                        <input type="hidden" name="selectCityIds" id="selectCityIds" <#if cityIds?? && cityIds?has_content>value="${cityIds}" </#if>>	                    </div>
                    <div>自提门店：
                        <#list storeList as store>
							<label class="mr10"><input type="checkbox" id="storeIds" name="storeIds" <#if (productStoreMap[store.storeId?string])??>checked = "checked"</#if> value="${(store.storeId)!}">${(store.storeName)!}</label>
	                	</#list>
                    </div>
                </div>
            </div>
           
			<div class="control-group" id="categoryContainer">
                <label class="control-label control-label-maxlong"><s>*</s>商品分类：</label>
                <div class="controls">
					<select name="categoryId" id="categoryId" class="input-normal">
                    	<option value="">--请选择--</option>
	                    <#if parentCategoryList?has_content>
        					<#list parentCategoryList as parentCategory>
				  				<@showCategoryChild  parentCategory 0/>
        					</#list>
        				</#if>
                    </select>
                </div>
            </div>
            <div class="control-group" id="categoryContainer">
                <label class="control-label control-label-maxlong">商品分组：</label>
                <div class="controls">
					<select name="productGroupId" id="productGroupId" class="input-normal">
                    	<option value="">--请选择--</option>
	                    <#if productGroupList?has_content>
        					<#list productGroupList as productGroup>
				  				<option value="${productGroup.productGroupId!}"<#if (product.productGroupId)?has_content && product.productGroupId==productGroup.productGroupId> selected="selected" </#if>>${productGroup.groupName!}</option>
        					</#list>
        				</#if>
                    </select>
                </div>
            </div>
            <div class="control-group">
                <label class="control-label control-label-maxlong">商品品牌：</label>
                <div class="controls">
                    <select name="brandId" id="brandId" class="input-normal">
                        <option value="">--请选择--</option>
                    <#if brandList?has_content>
                        <#list brandList as brand>
                            <#if (product.brandId)?has_content && product.brandId==brand.brandId>
                                <option value="${brand.brandId!}" selected="selected">${brand.brandName!}</option>
                            <#else>
                                <option value="${brand.brandId!}">${brand.brandName!}</option>
                            </#if>
                        </#list>
                    </#if>
                    </select>
                </div>
            </div>
        </div>
        <div class="sample-pic">
            <img src="${ctx}/static/admin/images/edit-pic1.png" alt="">
        </div>
    </div>    
<div class="panel mb10">
    <div class="panel-header"><h3>会员价格</h3></div>
        <div class="panel-body"> 
        	<div class="control-group" >
                <label class="control-label control-label-maxlong"><s>*</s>销售价格：</label>
                <div class="controls">
                    <input value="${(product.defaultPrice)!?html}" name="defaultPrice" id="defaultPrice" type="text" class="input-middle control-text" data-rules="{min:0,number:true,max:999999}">
                	<label><input type="checkbox" name="unShowSalePrice" <#if productSetting?? && (productSetting.isShowSalePrice)??&&productSetting.isShowSalePrice == 0 >checked='checked'</#if>>不在前台显示</label>
                </div>
            </div>
            <div class="control-group" >
                <label class="control-label control-label-maxlong"><s>*</s>吊牌价：</label>
                <div class="controls">
                    <input value="${(product.tagPrice)!?html}" name="tagPrice" id="tagPrice" type="text" class="input-middle control-text" data-rules="{min:0,number:true,max:999999}">
                	<label><input type="checkbox" id="unShowTagPrice" name="unShowTagPrice" <#if productSetting?? && (productSetting.isShowTagPrice)??&&productSetting.isShowTagPrice == 0 >checked='checked'</#if>>不在前台显示</label>
                </div>
            </div>

            <div class="control-group mb10" id="userExclusive">
                <label class="control-label control-label-maxlong">会员专享价：</label>
                <div class="controls control-row-auto">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>会员</th>
                                <th><label><input type="checkbox" name="allowPayTypeCds" value="1" <#if productSetting?? && (productSetting.allowPayTypeCds)?? && (productSetting.allowPayTypeCds)?contains('1')>checked="checked"</#if> >现金</label></th>
                                <th><label><input type="checkbox" name="allowPayTypeCds" value="2" <#if productSetting?? && (productSetting.allowPayTypeCds)?? && (productSetting.allowPayTypeCds)?contains('2')>checked="checked"</#if> >积分</label></th>
                                <th><label><input type="checkbox" name="allowPayTypeCds" value="3" <#if productSetting?? && (productSetting.allowPayTypeCds)?? && (productSetting.allowPayTypeCds)?contains('3')>checked="checked"</#if> >现金+积分</label></th>
                                <th><label><input type="checkbox" name="allowPayTypeCds" value="4" <#if productSetting?? && (productSetting.allowPayTypeCds)?? && (productSetting.allowPayTypeCds)?contains('4')>checked="checked"</#if> >白鹭卡积分</label></th>
                                <th><label><input type="checkbox" name="allowPayTypeCds" value="5" <#if productSetting?? && (productSetting.allowPayTypeCds)?? && (productSetting.allowPayTypeCds)?contains('5')>checked="checked"</#if> >现金+白鹭卡积分</label></th>
                            </tr>
                        </thead>
                        <tbody>
                        <#if isNew>
	                        <#if userLevelList?? && (userLevelList?size > 0) >
	                			<#list userLevelList as userLevel>
		                            <tr>
		                                <td>${(userLevel.userLevelName)!?html}</td>
		                                <td>￥<input type="text" value="" class="control-text input-maxsmall" name="onlyCashAmtMap[${userLevel.userLevelId}]"></td>
		                                <td><input type="text" value="" class="control-text input-maxsmall" name="onlyScoreAmtMap[${userLevel.userLevelId}]">积分</td>
		                                <td>￥<input type="text" value="" class="control-text input-maxsmall" name="cwsCashAmtMap[${userLevel.userLevelId}]"><span class="red ml">+</span><input type="text" name="cwsScoreAmtMap[${userLevel.userLevelId}]" value="" class="control-text input-maxsmall ml">积分</td>
		                                <td><input type="text" value="" class="control-text input-maxsmall" name="xmairCardScoreAmtMap[${userLevel.userLevelId}]">积分</td>
		                                <td>￥<input type="text" value="" class="control-text input-maxsmall" name="cwxmairCashAmtMap[${userLevel.userLevelId}]"><span class="red ml">+</span> <input type="text" value="" name="cwxmairXmairScoreAmtMap[${userLevel.userLevelId}]" class="control-text input-maxsmall ml">积分</td>
		                            </tr>
	                            </#list>
	                    	</#if>
                    	<#else>
                    		 <#if productPriceUserLevelXrefList?? && (productPriceUserLevelXrefList?size > 0) >
	                		 	<#list productPriceUserLevelXrefList as productPriceUserLevel>
	                		 		<tr>
		                                <td>${(productPriceUserLevel.userLevelName)!?html}</td>
		                                <td>￥<input type="text" value="${(productPriceUserLevel.onlyCashAmt)?default("")}" class="control-text input-maxsmall" name="onlyCashAmtMap[${productPriceUserLevel.userLevelId}]" ></td>
		                                <td><input type="text" value="${(productPriceUserLevel.onlyScoreAmt)?default("")}" class="control-text input-maxsmall" name="onlyScoreAmtMap[${productPriceUserLevel.userLevelId}]">积分</td>
		                                <td>￥<input type="text" value="${(productPriceUserLevel.cwsCashAmt)?default("")}" class="control-text input-maxsmall" name="cwsCashAmtMap[${productPriceUserLevel.userLevelId}]"><span class="red ml">+</span><input type="text" name="cwsScoreAmtMap[${productPriceUserLevel.userLevelId}]" value="${(productPriceUserLevel.cwsScoreAmt)?default("")}" class="control-text input-maxsmall ml">积分</td>
		                                <td><input type="text" value="${(productPriceUserLevel.xmairCardScoreAmt)?default("")}" class="control-text input-maxsmall" name="xmairCardScoreAmtMap[${productPriceUserLevel.userLevelId}]">积分</td>
		                                <td>￥<input type="text" value="${(productPriceUserLevel.cwxmairCashAmt)?default("")}" class="control-text input-maxsmall" name="cwxmairCashAmtMap[${productPriceUserLevel.userLevelId}]"><span class="red ml">+</span> <input type="text" value="${(productPriceUserLevel.cwxmairXmairScoreAmt)?default("")}" name="cwxmairXmairScoreAmtMap[${productPriceUserLevel.userLevelId}]" class="control-text input-maxsmall ml">积分</td>
	                            	</tr>
	                		 	</#list>
                    		 </#if>
                    	</#if>
                        </tbody>
                    </table>
                </div>
            </div>

		<!--	<#if isNew>
                 	<#if userLevelList?? && (userLevelList?size > 0) >
                		<#list userLevelList as userLevel>
                    		<div class="control-group">
                                <label class="control-label control-label-maxlong">会员折扣价：</label>
                                <label class="control-label control-label-maxlong">${(userLevel.userLevelName)!?html}折扣价：</label>&nbsp;
                                <div class="controls">
	                                    <input value="" name="productDiscountMap[${userLevel.userLevelId}]" id="${userLevel.userLevelId}" type="text" onblur="onblus(this)" class="input-middle control-text" data-rules="{min:1,max:100,number:true}">&nbsp;
			                            <label>%</label>
                                </div>
                            </div>
                        </#list>
                    </#if>
               	<#else>
                     <#if productPriceUserLevelXrefList?? && (productPriceUserLevelXrefList?size > 0) >
                		<#list productPriceUserLevelXrefList as productPriceUserLevel>
                			<#assign discount = "">
                			<#if (productPriceUserLevel.discountPercent)?? && (productPriceUserLevel.discountPercent)?has_content>
                				<#assign discount = (productPriceUserLevel.discountPercent?eval * 100)?string("0.####")>
                			</#if>
                    		<div class="control-group">
                                <label class="control-label control-label-maxlong">会员折扣价：</label>
                                <div class="controls">
                                    <label>${(productPriceUserLevel.userLevelName)!?html}：</label>&nbsp;
	                                <input value="${discount!}" name="productDiscountMap[${(productPriceUserLevel.userLevelId)}]" id="${(productPriceUserLevel.userLevelId)}" type="text" onblur="onblus(this)" class="input-middle control-text" data-rules="{min:1,max:100,number:true}">&nbsp;
			                        <label>%</label>
                                </div>
                            </div>
                        </#list>
                    </#if>
                </#if>-->

            <div class="control-group">
                <label class="control-label control-label-maxlong">购买后得到积分：</label>
                <div class="controls">
                    <input type="text" value="${(productSetting.productReturnScore)!}" data-rules="{maxlength:8}" class="control-text input-normal" name="productReturnScore" id="productReturnScore">
                </div>
            </div>
   	</div>
</div>
<!--<div class="panel mb10">
    <div class="panel-header"><h3>积分</h3></div>
        <div class="panel-body"> 
        	<div class="control-group" >
                <label class="control-label control-label-maxlong">积分最多抵扣：</label>
                <div class="controls">
	                <div>
	                    <input type="radio" name="scoreDisCountTypeCd"  value="1" onclick="showCont()" <#if (productSetting.scoreDisCountTypeCd)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==1)>checked="checked"</#if>>
	                    <input value="<#if (productSetting)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==1)>${(productSetting.scoreDiscountValue)!?html}</#if>" onclick="selectInput(this)" id="scoreDiscountValue1"  name= "scoreDiscountValue" type="text" data-rules="{min:0,number:true}" class="input-small control-text" readonly="true"  >&nbsp;元
	                </div>
	                <div> 
	                    <input type="radio" name="scoreDisCountTypeCd"  value="2" onclick="showCont()" <#if (productSetting.scoreDisCountTypeCd)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==2)>checked="checked"</#if>>
	                    <input value="<#if (productSetting)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==2)>${(productSetting.scoreDiscountValue)!?html}</#if>" onclick="selectInput(this)" id="scoreDiscountValue2"  name= "scoreDiscountValue" type="text" data-rules="{min:0,max:100,number:true}" class="input-small control-text" readonly="true"  >&nbsp;%
	               	</div>
                </div>
            </div>
   		</div>
</div>-->
<div class="panel mb10">
    <div class="panel-header"><h3>库存/规格</h3></div>
        <div class="panel-body"> 
        			<#include "skuTypeList.ftl">
        	<div class="control-group" >
                <label class="control-label control-label-maxlong"><s>*</s>总库存：</label>
                <div class="controls">
                	<#if product?has_content && hadOptionList??>
						<input value="${(product.sum)?default("0")}" name="realStock" id="realStock" type="text" class="input-middle control-text" data-rules="{min:0,number:true}" readonly="readonly">
					<#else>
						<input value="${(product.realStock)!?html}" name="realStock" id="realStock" type="text" class="input-middle control-text" data-rules="{min:0,number:true}">
                	</#if>
                	&nbsp;&nbsp;
					<input type="checkbox" id="unShowQuantity" name="unShowQuantity" <#if (productSetting.isShowStock)?? &&(productSetting.isShowStock==1)>checked="checked"</#if>><label for="unShowQuantity">前台不显示</label>
                </div>
            </div>
            <div class="control-group" >
                <label class="control-label control-label-maxlong">库存预警：</label>
                <div class="controls">
                    <input value="${(productSetting.stockWarningLimit)!?html}" name="stockWarningLimit" id="stockWarningLimit" type="text" class="input-middle control-text" data-rules="{min:0,number:true}">
                </div>
            </div>
            <div class="control-group" id="controlGroupOuterId" <#if (hadOptionMap)??>style="display: none;"</#if>>
                <label class="control-label control-label-maxlong">外部ID：</label>
                <div class="controls">
                    <input value="${(product.outsideId)!?html}" name="outsideId" id="outsideId" type="text" class="input-middle control-text">
                </div>
            </div>
            <div class="control-group" id="barCode" <#if (hadOptionMap)??>style="display: none;"</#if>>
                <label class="control-label control-label-maxlong" >货号：</label>
                <div class="controls">
                    <input value="${(product.barCode)!?html}"  type="text" name="barCode"  id="barCode" class="input-middle control-text">
                </div>
            </div>	
        </div>
</div>              
<div class="panel mb10">
    <div class="panel-header"><h3>商品信息</h3></div>
        <div class="panel-body"> 

	    	<div class="control-group mb10">
	            <label class="control-label control-label-maxlong"><s>*</s>上架：</label>
	            <div class="controls control-row-auto">
                 <#if isNew && isSell?? && isSell?has_content && isSell =="1">
                     <span style="color: #ff0909">[当前已设置了上架审核]</span></br>
                    <#else>
                     <label><input type="radio" name="productStatusCd" <#if isAudit?? && isAudit==true>disabled="true"</#if> <#if product?? && productSetting?? && product.productStatusCd?? && product.productStatusCd == 1>checked="checked"</#if> checked="checked" value="1" id="1"onclick="showTime()">立刻上架</label><br>
                 </#if>
                     <label><input type="radio" name="productStatusCd" <#if isAudit?? && isAudit==true>disabled="true"</#if> <#if product?? && productSetting?? && product.productStatusCd?? && product.productStatusCd == 2&&productSetting.productTimingShiefTime??>checked="checked"</#if>value="2" id="3" onclick="showTime()">定时上架</label><input type="text" value="${((productSetting.productTimingShiefTime)?string('yyyy-MM-dd HH:mm:ss'))!}" name="productTimingShiefTime" class="calendar control-text calendar-time ml" id="time"<#if product?? && productSetting?? && product.productStatusCd?? && product.productStatusCd == 2&&productSetting.productTimingShiefTime??>style="display: inline;" <#else>style="display: none;"</#if>><br>
	                <label><input type="radio" name="productStatusCd" <#if isAudit?? && isAudit==true>disabled="true"</#if><#if product?? && productSetting?? && product.productStatusCd?? && product.productStatusCd == 2&&!productSetting.productTimingShiefTime??>checked="checked"</#if><#if isNew && isSell?? && isSell?has_content && isSell =="1">checked="checked"</#if> value="2" id="2"onclick="showTime()">下架</label><#if isAudit?? && isAudit==true><span style="color: red;">&nbsp;&nbsp;[该商品已提交审核]</span></#if><br>
	            </div>
	        </div>
<!--
	       	<div class="control-group" > 
	           	<label class="control-label control-label-maxlong"><s>*</s>上架：</label>
	                <div class="controls control-row-auto">
	                 	<input <#if product?? && product.productStatusCd?? && product.productStatusCd == 1>checked=""</#if> name="productStatusCd" value="1" type="radio" id="productStatusCd" checked="checked"/>是</label>&nbsp;&nbsp;
	                    <input <#if product?? && product.productStatusCd?? && product.productStatusCd == 2>checked="checked"</#if> name="productStatusCd" value="2" type="radio" id="productStatusCd" /><label for="productType1">否</label>
	                </div>
	        </div>
-->	        
        	<div class="control-group" >
				<label class="control-label control-label-maxlong">重量：</label>
				<div class="controls">
					<input value="${(productExtend.productWeight)!?html}" type="text" name="productWeight" data-rules="{min:0,number:true}" class="input-small control-text">

					<select name="productWeightUnitCd" class="input-small">
						<option value="0" <#if productExtend?? && productExtend.productWeightUnitCd == 0>selected="selected"</#if>>无</option>
						<option value="1" <#if productExtend?? && productExtend.productWeightUnitCd == 1>selected="selected"</#if>>克(g)</option>
						<option value="2" <#if productExtend?? && productExtend.productWeightUnitCd == 2>selected="selected"</#if>>千克(kg)</option>
						<option value="3" <#if productExtend?? && productExtend.productWeightUnitCd == 3>selected="selected"</#if>>吨(t)</option>
					</select>
                    <input type="checkbox" id="hiddenWeight" name="hiddenWeight" <#if (productSetting.isShowWeight)?? && (productSetting.isShowWeight==1)>checked="checked"</#if>>
                    <label for="hiddenWeight">不在前台显示</label>
				</div>
			</div>
			<div class="control-group" data-tip="商品的计量单位.如1个/1件/1台等.这里输入的文字会体现在前台.展示如图">
                <label class="control-label control-label-maxlong">计量单位：</label>
                <div class="controls">
                    <input value="${(productExtend.productMeasureUnit)!?html}" type="text" name="productMeasureUnit" class="input-small control-text">
                </div>
            </div>
            
            <div class="control-group" data-tip="可以设置>1以上的数目,加上真实的销量,就是前台的总销量.如不填写则前台显示真实销量.如图"data-tip="可以设置>1以上的数目,加上真实的销量,就是前台的总销量.如不填写则前台显示真实销量.如图">
				<label class="control-label control-label-maxlong">虚拟销量<#--自定义销量--><#--原始销售件数-->：</label>
				<div class="controls">
					<input value="${(product.virtualSaleCnt)!?html}" type="text" name="virtualSaleCnt"  class="input-small control-text" data-rules="{min:0,number:true,max:99999999}">
				</div>
			</div>
			<div class="control-group">
                <label class="control-label control-label-maxlong">单产品基础业绩点：</label>
                <div class="controls">
                    <label><input type="radio" name="productPointTypeCd" id="productPointTypeCd1" onclick="changePointType()" <#if productSetting??&&productSetting.productPointTypeCd??&&productSetting.productPointTypeCd==1>checked="checked"</#if> value="1"></label>
                    <input type="text"  onclick="selectInput2(this)"  id="productPointValue1"  data-rules="{min:0,number:true}" class="input-small control-text" readonly="true" <#if productSetting??&&productSetting.productPointTypeCd??&&productSetting.productPointTypeCd==1> value="${productSetting.productPointValue!}" name="productPointValue"</#if> >业绩点
                    <label class="ml"><input type="radio" name="productPointTypeCd" id="productPointTypeCd2" onclick="changePointType()" <#if productSetting??&&productSetting.productPointTypeCd??&&productSetting.productPointTypeCd==2> checked="checked" </#if> value="2"></label>商品金额<s style="color: red;">*</s>
                    <input type="text"  onclick="selectInput2(this)"  id="productPointValue2"   type="text" data-rules="{min:0,max:100,number:true}" class="input-small control-text" readonly="true" <#if productSetting??&&productSetting.productPointTypeCd??&&productSetting.productPointTypeCd==2> value="${productSetting.productPointValue!}" name="productPointValue"</#if> >%
                </div>
            </div>
			 <div class="control-group" data-tip="以下商品字段会按照新增顺序.显示在商品详情页上.具体展示如图">

                <div id="productFieldContainer">
                    <div class="control-group ">
                        <label class="control-label control-label-maxlong">
                            <a href="javascript:void(0);" id="addProductField" class="button">+商品字段</a>
                        </label>
                        <div class="controls" style="width:180px;">

                        </div>
                    </div>

                    <div class="productFieldContent">
                        <#if (productFieldList)?? && productFieldList?has_content>
                            <#list productFieldList as productField>
                                <div class="control-group">
                                    <label class="control-label control-label-maxlong">
                                        <input type="text" name="productFieldName" value="${(productField.attrName)!}" class="input-small control-text">：
                                    </label>
                                    <div class="controls">
                                        <input type="text" name="productFieldValue" value="${(productField.attrValue)!}" class="input-short control-text">
                                        <a href="javascript:void(0);" class="delProductField">删除</a>
                                    </div>
                                </div>
                            </#list>
                        </#if>

                            <div id="productFieldPannel" class="control-group" style="display:none;">
                                <label class="control-label control-label-maxlong">
                                    <input type="text" name="productFieldName" value="" class="input-small control-text" placeholder="自定义字段">：
                                </label>
                                <div class="controls">
                                    <input type="text" name="productFieldValue" value="" class="input-normal control-text" placeholder="自定义内容">
                                    <a href="javascript:void(0);" class="delProductField">删除</a>
                                </div>
                            </div>

                    </div>
                </div>
            </div>
		</div>
</div>                 


<!--  -->        

</div>
    <div id="areaContent" class="hide">
        <div class="area-list">
            <div class="item">
                <div class="hd">
                    <label class="checkbox" for="isAllCountry">
                        <input type="checkbox" id="isAllCountry" <#if isAllAreaJoin>checked</#if> <#if (grouponDTO.promotionId)??>disabled</#if> />全国
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

                                        <input <#if provinceSelect> checked='checked' </#if> type="checkbox" name="province_" data-province="${province_index}" value="${province.id}" class="provinceSing"
                                        <#if (grouponDTO.promotionId)??> disabled </#if> id="province_${province_index}" />${(province.areaName)!}
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
                                                    <input type="checkbox" name="city_" data-province="${province_index}" data-city="${city_index}" class="citySing" value="${city.id}" <#if citySelect> checked='checked' </#if>
                                                    id="city_${province_index}_${city_index}" <#if (grouponDTO.promotionId)??> disabled </#if>/><span>${(city.areaName)!}</span>
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
        <div class="area-list-chooes">
            <div class="hd">已选地区</div>
            <div class="bd" id="citysName">
            <#--<#if provinceList?? && provinceList?has_content>
                <#list provinceList as province>
                    <#assign cityList = cityMap[province.id?string]?default("")/>
                    <#if cityList?is_sequence && cityList?size gt 0>
                        <#list cityList as city>
                            <#assign citySelect = false/>
                            <#if (cityXrefMap[city.id?string])??>
                                <p id="${(city.id)!}">${(city.areaName)!}</p>
                            </#if>
                        </#list>
                    </#if>
                </#list>
            </#if>-->
            </div>
        </div>
    </div>
<script>
    $(function(){
        showChoiceCity();
    })
	var dialogregion = null;
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
	            width:700,
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
	    });
	//显示选择地区的窗口
    function selectArea(){
        dialogregion.show();
        
    }
    function showChoiceCity(){
        $("#citysName").empty();
        var htmStr = '';
        $(".citySing").each(function(){
            if($(this).is(':checked')){
                htmStr +='<p id="+$(this).val()+">'+$(this).parent().find("span").html()+'</p>';
            }
        })
        $("#citysName").append(htmStr);
    }

	$(function(){
		//全国操作
	        $("#isAllCountry").on('change', function(){
	            $("input[name='province_']").prop("checked", this.checked);
	            $("input[name='city_']").prop("checked", this.checked);
	            if(this.checked){
	                $('#isAllAreaJoin').val("1");
	            }else{
	                $('#isAllAreaJoin').val("0");
	            }
                showChoiceCity();
	        });
	        <#if isAllAreaJoin>
	        	$("#isAllCountry").trigger('change');
	        </#if>
	        
			//省、市操作
	        $("input[name='province_']").on('change', function(){
	            var province = $(this).attr("data-province");
	            $("input[name='city_'][data-province='"+province+"']").prop("checked", this.checked);
                showChoiceCity();
	        });
	
	        $("input[name='city_']").on('change', function(){
	            var province = $(this).attr("data-province");
	            var $subs = $("input[name='city_'][data-province='"+province+"']");
	            $("input[name='province_'][data-province='"+province+"']").prop("checked" , $subs.length == $subs.filter(":checked").length ? true :false);
                showChoiceCity();
	        });

        $("#defaultPrice").on('keyup',function(){
            var defalutPc = $(this).val();
            var tagPc= $("#tagPrice").val();
            var unShowSalePc = $('input[name="unShowSalePrice"]');
            var unShowTagPc = $('input[name="unShowTagPrice"]');
            var re=/^\d*\.{0,1}\d{0,3}$/;
            var str = '<span class="valid-text errorVali" style="line-height: 20px;">' +
                    '<span class="estate error"><span class="x-icon x-icon-mini x-icon-error">!' +
                    '</span><em>销售价不高于吊牌价！</em></span></span>';
            //必须是number才能进来
            unShowSalePc.parent().find(".errorVali").remove();
            if(tagPc !=null && defalutPc !=null &&  re.exec(defalutPc) != null &&  eval(defalutPc)<=eval(999999)){
                if(eval(defalutPc) > eval(tagPc)){
                    unShowSalePc.parent().append(str);
                    return false;
                }else{
                    unShowTagPc.parent().find(".errorValidate").remove();
                    unShowSalePc.parent().find(".errorVali").remove();
                }
            }else{
                unShowSalePc.parent().find(".errorVali").remove();
            }

        });

        $("#tagPrice").on('keyup',function(){
            var tagPc = $(this).val();
            var defalutPc= $("#defaultPrice").val();
            var unShowSalePc = $('input[name="unShowSalePrice"]');
            var unShowTagPc = $('input[name="unShowTagPrice"]');
            var re=/^\d*\.{0,1}\d{0,3}$/;
            var str = '<span class="valid-text errorValidate" style="line-height: 20px;">' +
                    '<span class="estate error"><span class="x-icon x-icon-mini x-icon-error">!' +
                    '</span><em>吊牌价不低于销售价！</em></span></span>';
            //必须是number才能进来
            unShowTagPc.parent().find(".errorValidate").remove();
            if(tagPc !=null && defalutPc !=null &&  re.exec(tagPc) != null && eval(tagPc)<=eval(999999)){
                if(eval(defalutPc) > eval(tagPc)){
                    unShowTagPc.parent().append(str);
                    return false;
                }else{
                    unShowTagPc.parent().find(".errorValidate").remove();
                    unShowSalePc.parent().find(".errorVali").remove();
                }
            }else{
                unShowTagPc.parent().find(".errorValidate").remove();
            }

        });
	});
</script>