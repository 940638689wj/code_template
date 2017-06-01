<div class="form-horizontal">
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
			//模拟点击
		function selectInput(Input){
			var input = $(Input);
			input.prev().trigger('click');
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
                <label class="control-label control-label-maxlong"><s>*</s>菜品名称：</label>
                <div class="controls control-row-auto">
                    <textarea name="productName" data-rules="{maxlength:200}" id="productName"  class="input-large">${(product.productName)!?html}</textarea>
                </div>
            </div>
        	<div class="control-group mb10">
                <label class="control-label control-label-maxlong"><s>*</s>菜品描述：</label>
                <div class="controls control-row-auto">
                    <textarea name="productSubTitle" data-rules="{maxlength:200}" id="productSubTitle"  class="input-large">${(productExtend.productSubTitle)!?html}</textarea>
                </div>
            </div>
			<div class="control-group" id="categoryContainer">
                <label class="control-label control-label-maxlong"><s>*</s>菜品分类：</label>
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
           
            <div class="control-group">
                <label class="control-label control-label-maxlong"><s>*</s>归属门店：</label>
                <div class="controls">
                    <select name="blgStoreId" id="blgStoreId" class="input-normal">
                        <option value="">--请选择--</option>
                    <#if storeList?has_content>
                        <#list storeList as store>
                            <#if (productExtend.blgStoreId)?has_content && productExtend.blgStoreId==store.storeId>
                                <option value="${store.storeId!}" selected="selected">${store.storeName!}</option>
                            <#else>
                                <option value="${store.storeId!}">${store.storeName!}</option>
                            </#if>
                        </#list>
                    </#if>
                    </select>
                </div>
            </div>
            <!--<div class="control-group">
                <label class="control-label control-label-maxlong"><s>*</s>运费模板：</label>
                <div class="controls">
                    <select name="templateAreaId" id="templateAreaId" class="input-normal">
                        <option value="">--请选择--</option>
                    <#if expressTemplateList?has_content>
                        <#list expressTemplateList as expressTemplate>
                            <#if (productExtend.templateAreaId)?has_content && productExtend.templateAreaId==expressTemplate.templateId>
                                <option value="${expressTemplate.templateId!}" selected="selected">${expressTemplate.templateName!}</option>
                            <#else>
                                <option value="${expressTemplate.templateId!}">${expressTemplate.templateName!}</option>
                            </#if>
                        </#list>
                    </#if>
                    </select>
                </div>
            </div>-->
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
                    <input value="${(product.defaultPrice)!?html}" name="defaultPrice" id="defaultPrice" type="text" class="input-middle control-text" data-rules="{min:0,number:true}">
                </div>
            </div>
			
                <#if isNew>
                 	<#if userLevelList?? && (userLevelList?size > 0) >
                		<#list userLevelList as userLevel>
                    		<div class="control-group">
                                <!--<label class="control-label control-label-maxlong">会员折扣价：</label> -->
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
                				<#assign discount = (productPriceUserLevel.discountPercent?eval * 100)?string("#")>
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
                </#if>
            <div class="control-group" >
                <label class="control-label control-label-maxlong"><s>*</s>成本价：</label>
                <div class="controls">
                    <input value="${(product.tagPrice)!?html}" name="tagPrice" id="tagPrice" type="text" class="input-middle control-text" data-rules="{min:0,number:true}">
                </div>
            </div>
   	</div>
</div>
<div class="panel mb10">
    <div class="panel-header"><h3>积分</h3></div>
        <div class="panel-body"> 
        	<div class="control-group" >
                <label class="control-label control-label-maxlong">积分最多抵扣：</label>
                <div class="controls">
	                <div>
	                    <input type="radio" name="scoreDisCountTypeCd"  value="1" onclick="showCont()" <#if (productSetting.scoreDisCountTypeCd)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==1)>checked="checked"</#if>>
	                    <input value="<#if (productSetting)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==1)>${(productSetting.scoreDiscountValue)!?html}</#if>" onclick="selectInput(this)" id="scoreDiscountValue1"  name= "scoreDiscountValue" type="text" data-rules="{min:0,number:true}" class="input-small control-text"   >&nbsp;元
	                </div>
	                <div> 
	                    <input type="radio" name="scoreDisCountTypeCd"  value="2" onclick="showCont()" <#if (productSetting.scoreDisCountTypeCd)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==2)>checked="checked"</#if>>
	                    <input value="<#if (productSetting)?? && (productSetting.scoreDisCountTypeCd)?has_content&&(productSetting.scoreDisCountTypeCd==2)>${(productSetting.scoreDiscountValue)!?html}</#if>" onclick="selectInput(this)" id="scoreDiscountValue2"  name= "scoreDiscountValue" type="text" data-rules="{min:0,max:100,number:true}" class="input-small control-text"   >&nbsp;%
	               	</div>
                </div>
            </div>
   		</div>
</div>
<div class="panel mb10">
    <div class="panel-header"><h3>库存/规格</h3></div>
        <div class="panel-body"> 
        			<!--<#include "skuTypeList.ftl">-->
        	<div class="control-group" >
                <label class="control-label control-label-maxlong">总库存：</label>
                <div class="controls">
                	<#if product?has_content && hadOptionList??>
						<label id="realStock">${(product.sum)?default("0")}</label>
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
            <!--<div class="control-group" id="controlGroupOuterId" <#if (hadOptionMap)??>style="display: none;"</#if>>
                <label class="control-label control-label-maxlong">外部ID：</label>
                <div class="controls">
                    <input value="${(product.outsideId)!?html}" name="outsideId" id="outsideId" type="text" class="input-middle control-text">
                </div>
            </div>-->
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
          <div class="control-group" > 
           	<label class="control-label control-label-maxlong"><s>*</s>上架：</label>
                <div class="controls control-row-auto">
                 	<input <#if product?? && product.productStatusCd?? && product.productStatusCd == 1>checked="checked"</#if> name="productStatusCd" value="1" type="radio" id="productStatusCd" checked="checked"/>是</label>&nbsp;&nbsp;
                    <input <#if product?? && product.productStatusCd?? && product.productStatusCd == 2>checked="checked"</#if> name="productStatusCd" value="2" type="radio" id="productStatusCd" /><label for="productType1">否</label>
                </div>
           </div>
        	<div class="control-group" >
				<label class="control-label control-label-maxlong">重量：</label>
				<div class="controls">
					<input value="${(productExtend.productWeight)!?html}" type="text" name="productWeight" data-rules="{min:0,number:true}" class="input-small control-text">

					<select name="productWeightUnitCd" class="input-small">
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
					<input value="${(product.virtualSaleCnt)!?html}" type="text" name="virtualSaleCnt"  class="input-small control-text" data-rules="{min:0,number:true}">
				</div>
			</div>
			 <div class="control-group" data-tip="以下商品字段会按照新增顺序.显示在商品详情页上.具体展示如图">

                <div id="productFieldContainer">
                    <div class="control-group ">
                        <label class="control-label control-label-maxlong">
                            <a href="javascript:void(0);" id="addProductField" class="button">+菜品字段</a>
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