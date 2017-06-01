<script type="text/javascript" src="${ctx}/static/admin/js/skuCreator.js?t=0417_0958"></script>
<script type="text/javascript" src="${ctx}/static/admin/js/validator.js"></script>
<#--<script type="text/javascript" src="${ctx}/static/admin/js/skuBuilder.js?t=20140524"></script>-->
<link rel="stylesheet" href="${ctx}/static/js/artDialog/skins/chrome.css" />

<#assign hasOptionFlag=false/>
<input type="hidden" name="fakedSkuId" value="">
<input type="hidden" name="fakedSkuSalePrice" value="">
<input type="hidden" name="fakedSkuQuantity" value="">
<input type="hidden" name="fakedSkuOuterId" value="">
<input type="hidden" name="fakedSkuCommodityCode" value="">

<input type="hidden" name="optionId" value="">
<input type="hidden" name="optionValueId" value="">
<input type="hidden" name="optionValueLabel" value="">
<input type="hidden" name="optionValuePicUploaderId" value="">
<input type="hidden" name="optionValuePicUploaderAssetId" value="">
<input type="file" id="picFileObj" name="file" onchange="javascript:doUploadOptionValuePic(this);" style="display: none;">

<div id="skuOptionContainer" offset="-40" align="top" data-tip="规格会显示在前台让客户选取.常见规格如S/M/L/XL等.并且每个规格配备独立的外部ID(对接其他系统识别编码)和库存.也可以独立配备销售价格.如图">
    <div class="control-group">
		<label class="control-label control-label-maxlong">商品规格：</label>
		<div class="controls control-row-auto" style="width: 530px;">
            <em id="notModifyTip" style="display: none; color: red; font-size: 14px;">(该商品已经选择规格,对规格暂时不支持修改!)</em>
			<#if isNew || !(hadOptionMap?? && hadOptionMap?has_content)>
				<span id="noSkuOptionTip">没有商品规格</span>
			<#else>
                <span id="noSkuOptionTip" style="display: none;">没有商品规格</span>
			</#if>

			<#-- 已经拥有的规格 -->
			<#if hadOptionList?? && hadOptionList?has_content>
				<#assign productOptionValueAssetMap=""/>
				<#if (product.productOptionValueAssetMap)??>
					<#assign productOptionValueAssetMap=product.productOptionValueAssetMap />
				</#if>

                <div class="spec-box">
					<#list hadOptionList as hadOption>
						<#assign hasOptionFlag=true/>
						<#assign allowUploadPic = "0">
						<#if (hadOption.picRequired)?has_content && (hadOption.picRequired)>
							<#assign allowUploadPic = "1">
						</#if>

						<div class="skuOptionPannel">
                            <div class="spec-title">
								<select name="skuOption" class="skuOptionSelect" <#if hasOptionFlag>disabled="true" </#if>>
									<option value="-1">请选择</option>
									<#list allOptionList as option>
										<option value="${option.skuTypeId}" <#if option.skuTypeId == hadOption.id>selected="selected" </#if>>${option.skuTypeDesc?html}</option>
									</#list>
								</select>
								
								<#if !hasOptionFlag>
                                    <a href="javascript:void(0);" class="delSkuOptionPannel">&times;</a>
								</#if>
                            </div>

                            <div class="spec-con">
                                <ul>
									<#-- 已经拥有的规格值 -->
									<#assign optionId=hadOption.id?string/>
									
                                    <div class="optionValuePannel" data-option-id="${optionId}" data-option-label="${hadOption.label?html}" data-option-pic="${allowUploadPic}">
										<#if hadOptionValueMap??>
											<#if hadOptionValueMap[optionId]??>
												<#assign curOptionValueMap = hadOptionValueMap[optionId]>
												<#list curOptionValueMap?keys as idKey>
													
													<#assign tmpOptionValue=curOptionValueMap[idKey]/>
                                                        <#assign optionValueId=(tmpOptionValue.id)?string/>

                                                        <#-- 商品规格值别名，优先级：高 -->
                                                        <#assign optionValueProductAliasValue = "">
                                                        <#if productOptionValueAliasLabelMap?? && productOptionValueAliasLabelMap[idKey]??>
                                                            <#assign optionValueProductAliasValue = productOptionValueAliasLabelMap[idKey]>
                                                        </#if>

                                                        <#-- 规格值名称，优先级：低 -->
                                                        <#assign optionValueAttributeValue = (tmpOptionValue.label)!?html>
                                                        <#assign optionValueLabelValue =  optionValueAttributeValue>
                                                        <#if optionValueProductAliasValue?? && optionValueProductAliasValue?has_content>
                                                            <#assign optionValueLabelValue = optionValueProductAliasValue>
                                                        </#if>
                                                        
                                                        <li class="optionValueLi" data-optionvalue-id="${optionValueId}"
                                                            data-optionvalue-text="${optionValueLabelValue!?html}"
                                                            data-option-id="${optionId}">
															
                                                            <div class="spec-item">
                                                                <span id="${optionId}-${optionValueId}" class="optionValueLabel" style="cursor:pointer;">${optionValueLabelValue!?html}</span>
                                                                <input id="optionValueInput-${optionId}-${optionValueId}" type="text" class="optionValueInput"
                                                                       data-option-optionvalue-id="${optionId}-${optionValueId}"
                                                                       value="${optionValueLabelValue!?html}" style="display:none;width: 50px;margin-top: 2px;"
                                                                       onchange="javascript:optionValueLabelChange(this);"
                                                                       onblur="javascript:optionValueLabelBlur(this);">&nbsp;

                                                                <#if !hasOptionFlag>
                                                                    <a href=":void(0);" class="delOptionValue">&times;</a>
                                                                </#if>
                                                            </div>

                                                            <#if allowUploadPic=="1">
                                                                <div class="add-img">
                                                                    <#assign productOptionValueXrefAssetUrl = "">
                                                                    <#assign assetId = "">
                                                                    <#if productOptionValueAssetMap?is_hash>
                                                                        <#assign productOptionValueAsset = (productOptionValueAssetMap[optionValueId])!>
                                                                        <#if productOptionValueAsset??>
                                                                            <#assign productOptionValueXrefAssetUrl = (productOptionValueAsset.fullUrl)!>
                                                                            <#assign assetId=(productOptionValueAsset.id)!/>
                                                                        </#if>
                                                                    </#if>

                                                                    <#if productOptionValueXrefAssetUrl?has_content>
                                                                        <span style="display: none;" class="doUploadOptionValuePic">+加图</span>
                                                                        <img id="img_${optionId}_${optionValueId}" assetId="${assetId!}" class="optionValueImg" style="width:35px;height:35px;" src="/admin/cmsstatic${productOptionValueXrefAssetUrl!}?smallThumbnail">
                                                                        <a href="javascript:void(0);" class="delOptionValuePic">&times;</a>
                                                                    <#else>
                                                                        <span class="doUploadOptionValuePic">+加图</span>
                                                                        <img id="img_${optionId}_${optionValueId}" assetId="" class="optionValueImg" style="display:none;width:35px;height:35px;" src="">
                                                                        <a href="javascript:void(0);" style="display: none;" class="delOptionValuePic">&times;</a>
                                                                    </#if>
                                                                </div>
                                                            </#if>
                                                        </li>
                                                    
												</#list>
											</#if>
										</#if>
                                    </div>
                                   
                                </ul>
                            </div>
						</div>
					</#list>
                </div>
			<#else>
                <div class="spec-box" style="display: none;"></div>
			</#if>

			<#-- 模板 -->
			<#if allOptionList?has_content>
				<div id="skuOptionPannel" class="skuOptionPannel" style="display:none;">
					<div class="spec-title">
						<select name="skuOption" class="skuOptionSelect">
							<option value="-1">请选择</option>
							<#list allOptionList as option>
								<option value="${option.skuTypeId}">${option.skuTypeDesc?html}</option>
							</#list>
						</select>
						<a href="javascript:void(0);" class="delSkuOptionPannel">&times;</a>
					</div>

					<div class="spec-con">
						<ul>
                            <div class="optionValuePannel" data-option-id="" data-option-label="" data-option-pic="">

							</div>
							<li>
								<div class="add-new">
									<a class="link" href="javascript:void(0);">+添加</a>
									<div class="layer" style="width: 230px;left:-108px;">
										<select name="skuOptionValue" class="skuOptionValueSelect">
											<option value="-1">请选择</option>
										</select>
										&nbsp;
										<#--<a href="javascript:void(0);" class="button button-primary optionValueSelectedConfirm">确认</a>&nbsp;-->
										<a href="javascript:void(0);" class="button J_btnclose">关闭</a>
										<b class="arr"><s></s></b>
									</div>
								</div>
							</li>
						</ul>
					</div>
				</div>
			<#else>
                <em>您还没有设置任何商品规格，请点击<a href="${ctx}/admin/adminProductOption" style="color:#0000ff; font-size: 14px;">这里</a>添加商品规格！</em>
			</#if>
		</div>
	</div>

	<#-- 存放 optionValue 的模板 -->
    <li id="optionValueLi1" class="" data-optionvalue-id="" data-optionvalue-text=""
        data-option-id="" style="display: none;">
        <div class="spec-item">
            <span id="" class="optionValueLabel" style="cursor:pointer;"></span>
            <input id="" type="text" class="optionValueInput"
                   data-option-optionvalue-id=""
                   value="" style="display:none;width: 50px;margin-top: 2px;"
                   onchange="javascript:optionValueLabelChange(this);"
                   onblur="javascript:optionValueLabelBlur(this);">&nbsp;

            <a href="javascript:void(0);" class="delOptionValue">&times;</a>
        </div>
        <div class="add-img">
            <span class="doUploadOptionValuePic">+加图</span>
            <img id="" assetId="" class="optionValueImg" style="display:none;width:35px;height:35px;" src="">
            <a href="javascript:void(0);" style="display: none;" class="delOptionValuePic">&times;</a>
        </div>
    </li>
    <li id="optionValueLi0" class="" data-optionvalue-id="" data-optionvalue-text=""
        data-option-id="" style="display: none;">
        <div class="spec-item">
            <span id="" class="optionValueLabel" style="cursor:pointer;"></span>
            <input id="" type="text" class="optionValueInput"
                   data-option-optionvalue-id=""
                   value="" style="display:none;width: 50px;margin-top: 2px;"
                   onchange="javascript:optionValueLabelChange(this);"
                   onblur="javascript:optionValueLabelBlur(this);">&nbsp;

            <a href="javascript:void(0);" class="delOptionValue">&times;</a>
        </div>
    </li>

	<#if !hasOptionFlag>
        <div class="control-group">
            <label class="control-label control-label-maxlong"></label>
            <div class="controls">
                <a href="javascript:void(0);" id="addSkuOption" class="button">添加规格项目</a>
            </div>
        </div>
	</#if>


	<div class="control-group">
        <label class="control-label control-label-maxlong">商品库存：</label>
        <div class="controls control-row-auto" style="width: 530px;">
			<div id="Sku_Grid">

			</div>
        </div>
    </div>
</div>

<#--新增规格弹窗内容-->
<div id="optionValuecontent" style="display: none">
        <input type="hidden"  id="productOptionValueId" >
        <input type="hidden"  id="productOptionId" >
        
        <label for="attributeValue"><s style="color: #ff0000">*</s>名称:</label>&nbsp;&nbsp;&nbsp;
        <input id="attributeValue" type="text" class="input-normal control-text">
        <br>
        <br>
        <label for="optionDisplayOrder"><s style="color: #ff0000">*</s>排序:</label>&nbsp;&nbsp;&nbsp;
        <input id="optionDisplayOrder" type="text" class="input-normal control-text">
</div>


<script>
    var preSelection ;
    var newOptionMap={};
    var optionMap={};
	var optionValueMap={};
	var optionAndOptionValueMap={};
	<#if allOptionList?? && allOptionList?has_content>
		<#list allOptionList as option>
        	var optionId='${option.skuTypeId}';
			var optionLabel='${option.skuTypeDesc!}';
			var optionIndex=gridColumnDataIndexPrefix+'${option.skuTypeId}';

			<#assign allowUploadPic = "0">
			<#if (option.picRequired)?has_content && (option.picRequired)>
				<#assign allowUploadPic = "1">
			</#if>
        	var optionAllowUploadPic='${allowUploadPic}';

        	var tempOptionValueMap={};
			<#if optionValues?size gt 0>
				<#list optionValues as optionValue>
						<#if optionValue.skuTypeId= option.skuTypeId >
                        var optionValId='${optionValue.skuKey}';
                        var optionValName='${(optionValue.skuValue)!?js_string}';

                        var objOptionValue = new Object();
                        objOptionValue.id=optionValId;
                        objOptionValue.name=optionValName;

                        tempOptionValueMap[optionValId]=objOptionValue;
                        optionValueMap=objOptionValue;
                        </#if>
				</#list>

            	optionAndOptionValueMap[optionId]=tempOptionValueMap;
			</#if>

        	var objOption = new Object();
        	objOption.id=optionId;
        	objOption.label=optionLabel;
        	objOption.index=optionIndex;
        	objOption.allowUploadPic=optionAllowUploadPic;

        	optionMap[optionId]=objOption;
		</#list>
	</#if>

    //选择的商品规格ID/标签(显示表格头使用)
    var selectedProductOptionIdArray = [];
    var selectedProductOptionLabel = [];
    var selectedProductOptionIndex = [];
    var skuOuterIdMap,skuQuantityMap,skuSalePriceMap,skuCommodityCodeMap;
	<#if skuOuterIdMapJson??>
    	skuOuterIdMap = ${skuOuterIdMapJson};
	</#if>
	
	<#if skuSalePriceMapJson??>
    	skuSalePriceMap = ${skuSalePriceMapJson};
	</#if>
	<#if skuQuantityMapJson??>
    	skuQuantityMap = ${skuQuantityMapJson};
	</#if>
	<#if skuCommodityCodeMapJson??>
    	skuCommodityCodeMap = ${skuCommodityCodeMapJson};
	</#if>
    //sku构造对象
    var skuBuilder;
    var currentUploadId;
    var uploadPath;

	//TODO
    var sekectedSkuOptionIdArray = [];

	$(function(){
		var closeLayer,activeLayer;
        closeLayer = function(){
            activeLayer.hide();
            $('body').off('click',closeLayer);
        }
		$('body').on('click','.add-new .link',function(){
			if($(this).attr('data-content') == "categoryAdd")
				return ;

            activeLayer = $(this).next('.layer');
            activeLayer.show();
            $('body').on('click',closeLayer);
            $('body').on('click','.J_btnclose',closeLayer);
        });
        $('body').on('click','.layer',function(e){
			e.stopPropagation();
        });


		//添加一个 商品规格pannel 到 .spec-box
        $('#skuOptionContainer').on('click','#addSkuOption',function(){
            if(getSkuOptionPannelArrayFromSkuOptionContainer().length <2){
                BUI.Message.Confirm('确认要修改规格价格？点击确认将只能设置规格不能设置会员专享价',function(){
                    var targetPannel = $("#skuOptionPannel").clone();
                    targetPannel.removeAttr("id");

                    targetPannel.show();
                    //targetPannel.insertBefore("#skuOptionPannel");
                    $(".spec-box").append(targetPannel);
                    $(".spec-box").show();

                <#--
                targetPannel.find(".skuOptionSelect").easyDropDown({
                    cutOff: 10
                });
                -->
                    $("#noSkuOptionTip").hide();
                    $("#controlGroupOuterId").hide();
                    $("#barCode").hide();

                    $("#userExclusive input").attr('disabled',true);
                    $("#userExclusive").hide();
                },'question');
            }else{
                var targetPannel = $("#skuOptionPannel").clone();
                targetPannel.removeAttr("id");

                targetPannel.show();
                //targetPannel.insertBefore("#skuOptionPannel");
                $(".spec-box").append(targetPannel);
                $(".spec-box").show();

            <#--
            targetPannel.find(".skuOptionSelect").easyDropDown({
                cutOff: 10
            });
            -->
                $("#noSkuOptionTip").hide();
                $("#controlGroupOuterId").hide();
                $("#barCode").hide();
            }
        });

		//删除一个 商品规格pannel
		$("#skuOptionContainer").on('click',".delSkuOptionPannel",function(){
            var delItem = $(this).closest('.skuOptionPannel');
            delItem.remove();
			if(getSkuOptionPannelArrayFromSkuOptionContainer().length <2){
                $(".spec-box").hide();
                $("#noSkuOptionTip").show();
                $("#controlGroupOuterId").show();
	            $("#barCode").show();

                $("#userExclusive").show();//显示
                $("#userExclusive input").attr('disabled',false);//启用会员专享价块
			}

            refreshSkuOptionArray();
            skuOptionSelectEvent2(getSelectedOptionArray());
            createSkuGridEvent();
		});

		//第1个下拉框 -- option 下拉项值改变事件
        $("#skuOptionContainer").on('change',".skuOptionSelect",function(){
			var $select=$(this);
            var curVal=$select.val();

			if(curVal=='-1'){
                skuOptionSelectEvent1($select);
                return ;
			}

			if(sekectedSkuOptionIdArray.indexOf(curVal) != -1){
                $select.val("-1");
                BUI.Message.Alert("规格名不能相同");

                skuOptionSelectEvent1($select);
                return false;
			}

            skuOptionSelectEvent1($select);
        });
//        保存的弹窗规格
        function saveOptionValue(curVal){
            $.ajax({
                url : '${ctx}/admin/sa/skuType/skuKeyValue/update',
                dataType : 'json',
                type: 'POST',
                data : {
                    'skuTypeId':$('#productOptionId').val(),
                    'skuValue':$("#attributeValue").val(),
                    'displayId':$("#optionDisplayOrder").val(),
                    'skuKey':'',
                },
                success : function(data){
                    if(data.result == "success"){
                        var optionValueId=data.optionValueId;
                        var optionValueName = data.optionValueName;
                        $("#productOptionValueId").val(optionValueId);
                        var newOptionValue;
                        if(newOptionMap[curVal]){
                            newOptionValue=newOptionMap[curVal];
                        }else{
                            newOptionValue=new Array();
                        }
                        newOptionValue.push("<option value='"+optionValueId+"'>"+optionValueName+"</option>");
                        newOptionMap[curVal]=newOptionValue;
                        app.showSuccess("规格添加成功!");
                        var optionValueSelectDom=skuOptionPannel.find(".skuOptionValueSelect")[0];
                        var $optionValueSelect=$(optionValueSelectDom);
                        $optionValueSelect.append("<option value='"+optionValueId+"'>"+optionValueName+"</option>");
                        $($optionValueSelect).find("option:last").attr("selected",true);
//                        $($optionValueSelect).find("option:last").remove();
//                        $optionValueSelect.append("<option value='"+curVal+"' id='newOption'  style='color:red;'>新增一个y</option>");
                        var $optionValuePannel=getJqueryObj(preSelection,".optionValuePannel");
                        rebuildOptionView(optionValueId,optionValueName,$optionValuePannel);

                    }else{
                        app.showError(data.message);
                    }
                }
            });
        }
        // 弹窗
        var Overlay = BUI.Overlay
        var dialog = new Overlay.Dialog({
            //配置DOM容器的编号
            contentId:'optionValuecontent',
            success:function () {
                var input_content =$("#attributeValue").val();
                if(input_content.trim().length>0){
                    saveOptionValue(preSelection.val());
                    $("#attributeValue").val("");
                }else{
                    alert("请输入规格名称");
                    return false;
                }
                dialog.close();
            }
        });
		//第2个下拉框 -- optionValue 下拉改变事件
        $("#skuOptionContainer").on('change',".skuOptionValueSelect",function(){
            var $select=$(this);
            preSelection=$select;
            var curVal=$select.val();
            if(curVal=='-1'){
                return ;
            }

			var curTxt=$select.find("option:selected").text();
            var $optionValuePannel=getJqueryObj($select,".optionValuePannel");

			if(getOptionValueIdArrayFromPannel($optionValuePannel).indexOf(curVal) != -1){
                BUI.Message.Alert("已经添加了相同的规格值");
				return false;
			}

            var name = $select.find("option:selected").attr("id");
            if(name=="newOption"){
                $("#productOptionId").val($select.val())
                dialog.show();
            }else{
                rebuildOptionView(curVal,curTxt,$optionValuePannel);
            }
        });


        function rebuildOptionView(curVal,curTxt,$optionValuePannel){
            //是否需要规格图片
            var targetId="#optionValueLi0";
            if($optionValuePannel.attr('data-option-pic') == "1"){
                targetId="#optionValueLi1";
            }

            var optionId=$optionValuePannel.attr('data-option-id');
            var targetLi=$(targetId).clone();
            targetLi.removeAttr('id');
            targetLi.addClass('optionValueLi');
            targetLi.attr('data-optionvalue-id',curVal);
            targetLi.attr('data-optionvalue-text',curTxt);
            targetLi.attr('data-option-id',optionId);
            //targetSpan.prepend(curTxt);

            //label赋值
            targetLi.find('.optionValueLabel').each(function(){
                $(this).attr('id',optionId+'-'+curVal);
                $(this).text(curTxt);
                return false;
            });

            //给input 赋值
            targetLi.find('.optionValueInput').each(function(){
                $(this).attr('id','optionValueInput-'+optionId+'-'+curVal);
                $(this).val(curTxt);
                $(this).attr('data-option-optionvalue-id',optionId+'-'+curVal);
                return false;
            });

            if($optionValuePannel.attr('data-option-pic') == "1"){
                //给img 赋值
                targetLi.find('.optionValueImg').each(function(){
                    $(this).attr('id','img_'+optionId+'_'+curVal);
                    return false;
                });
            }

            targetLi.show();
            $optionValuePannel.append(targetLi);
            createSkuGridEvent();
        }
		//optionValue 删除 事件
		$("#skuOptionContainer").on('click',".delOptionValue",function(){
			$(this).closest('.optionValueLi').remove();
            createSkuGridEvent();
		});

        //optionValue 上传图片 事件
        $("#skuOptionContainer").on('click',".doUploadOptionValuePic",function(){
            var $optionValueLi=$(this).closest('.optionValueLi');
			var optionId=$optionValueLi.attr('data-option-id');
			var optionValueId=$optionValueLi.attr('data-optionValue-id');
            currentUploadId=optionId+'-'+optionValueId;

			$("#picFileObj").click();
        });

        //optionValue 删除图片 事件
        $("#skuOptionContainer").on('click',".delOptionValuePic",function(){
			$(this).prev('.optionValueImg').attr('src','');
			$(this).prev('.optionValueImg').attr('assetId','');
			$(this).prev('.optionValueImg').hide();

            $(this).prev('.optionValueImg').prev('.doUploadOptionValuePic').show();
			$(this).hide();
        });

		//sku表格 有商品库存值,则禁用 总库存 字段
		$("#Sku_Grid").on('blur',".sku_count",function(){
			var total=0;
			$(".sku_count").each(function(i,val){
				var temp=$(this).val();
				if($.isNumeric(temp)){
                    var curVal=Math.round(Number(temp));
                    $(this).val(curVal);

					total=total+curVal;
				}else{
					$(this).val(0);
				}
			});
			//alert(total)
			var tagName=$('#realStock')[0].tagName;
			//alert(tagName)
			if(total > 0){
				if(tagName == "LABEL"){
					$('#realStock').html(total);
				}else if(tagName == "INPUT"){
                    $('#realStock').val(total);
					$('#realStock').attr('disabled',true);
				}
			}else{
                if(tagName == "LABEL"){
                    $('#realStock').html(0);
                }else if(tagName == "INPUT"){
                    $('#realStock').val(0);
                    $('#realStock').remove('disabled');
                }
			}
		});

		//规格值label点击 变成可编辑
		$('#skuOptionContainer').on('click','.optionValueLabel',function(){
			var $curLab=$(this);
			var id=$curLab.attr('id');

			$curLab.hide();
			$("#optionValueInput-"+id).show();
			$("#optionValueInput-"+id).focus();
		});

        initOption();
	});

    /**
     * 	商品规格数据
     */
    function collectOptionData(){
        var validResult = true;

        $("input[name='optionId']").val(selectedProductOptionIdArray.join(','));

        var selectedOptionValueIdArray = [];
        var selectedOptionValueLabelArray = [];
        var optionValueArray=collectAllSelectedOptionValue();
		if(optionValueArray && optionValueArray.length >0){
            $.each(optionValueArray, function(i,val){
                selectedOptionValueIdArray.push(val.id);
                var newOptionValueLabel = val.text;
                newOptionValueLabel = YrValidator.replaceAllSpace(newOptionValueLabel);
                if(newOptionValueLabel == ""){
                    BUI.Message.Alert("商品规格值名称不能为空!");
                    validResult = false;
                    return false;
                }

                selectedOptionValueLabelArray.push(newOptionValueLabel);
            });
        }

        if(!validResult){
            return false;
        }

        $("input[name='optionValueId']").val(selectedOptionValueIdArray.join(","));
        $("input[name='optionValueLabel']").val(selectedOptionValueLabelArray.join("~|~"));

        var optionValueUploaderId = [];
        var optionValueUploaderAssetId = [];

		$('.optionValueImg').each(function(i,obj){
			var optionValueId=$(this).attr('id').split('_')[2];

            optionValueUploaderId.push(optionValueId);
            var assetId = $(this).attr('assetId') ? $(this).attr('assetId') : "";
            optionValueUploaderAssetId.push(assetId);
		});

        $("input[name='optionValuePicUploaderId']").val(optionValueUploaderId.join(","));
        $("input[name='optionValuePicUploaderAssetId']").val(optionValueUploaderAssetId.join(","));

        var fakedSkuIdArray = [];
        var fakedSkuCountArray = [];
        var fakedSkuOuterIdArray = [];
        var fakedSkuSalePriceArray = [];
        var fakedSkuCommodityCodeArray= [];
        if(skuBuilder){
            var allSkus = skuBuilder.getAllRecords();
            if(allSkus){
                for(var i = 0; i < allSkus.length; i++){
                    var fakedSkuId = allSkus[i].id;
                    //alert(fakedSkuId);
                    var skuCount = YrValidator.replaceAllSpace($("#sku_count_"+fakedSkuId).val());
                    var skuOuterId = YrValidator.replaceAllSpace($("#sku_outerId_"+fakedSkuId).val());
                    var skuSalePrice = YrValidator.replaceAllSpace($("#sku_salePrice_"+fakedSkuId).val());
					var skuCommodityCode = YrValidator.replaceAllSpace($("#sku_commodityCode_"+fakedSkuId).val());
					
                    if(skuCount != "" && !YrValidator.isNotNegativeInteger(skuCount)){
                        BUI.Message.Alert("货品库存必须为正整数!");
                        validResult = false;
                        break;
                    }
					//alert(skuSalePrice);
                    if(skuSalePrice != "" && !YrValidator.isPositiveFloatingPointNumber(skuSalePrice)){
                        BUI.Message.Alert("货品销售价格必须为正数!");
                        validResult = false;
                        break;
                    }

                    fakedSkuIdArray.push(fakedSkuId);
                    fakedSkuCountArray.push(skuCount);
                    fakedSkuOuterIdArray.push(skuOuterId);
                    fakedSkuSalePriceArray.push(skuSalePrice);
                    fakedSkuCommodityCodeArray.push(skuCommodityCode);
                }
            }
        }

        if(!validResult){
            return false;
        }

        $("input[name='fakedSkuId']").val(fakedSkuIdArray.join(','));
        $("input[name='fakedSkuQuantity']").val(fakedSkuCountArray.join(','));
        $("input[name='fakedSkuSalePrice']").val(fakedSkuSalePriceArray.join(','));
        $("input[name='fakedSkuOuterId']").val(fakedSkuOuterIdArray.join(','));
        $("input[name='fakedSkuCommodityCode']").val(fakedSkuCommodityCodeArray.join(','));

        return true;
    }

    /**
     * 初始化已经选择了的商品规格
     */
    function initOption() {
        selectedProductOptionIdArray = [];
        selectedProductOptionLabel = [];
        selectedProductOptionIndex = [];

		<#if hadOptionList?? && (hadOptionList?size > 0)>
			<#list hadOptionList as productOption>
				selectedProductOptionIdArray.push('${(productOption.id)!}');
				selectedProductOptionLabel.push('${(productOption.label)!}');
				selectedProductOptionIndex.push(gridColumnDataIndexPrefix + '${(productOption.id)!}');
			</#list>
		</#if>

        if(selectedProductOptionIdArray.length > 0){
            $("#notModifyTip").show();

            //TODO 禁用规格 涉及的几个按钮
            //$("input[name='product_option']").each(function(){
            //    $(this).attr("disabled", "true");
            //});

            buildSkuGridWithoutData(selectedProductOptionLabel, selectedProductOptionIdArray);

            //TODO
            //$("div[name='product_option']").each(function(){
            //    $(this).find("input:checkbox:checked").each(function(){
            //       $(this).attr("disabled", "true");
            //   });
            //});
            var allSelectedOptionValue = collectAllSelectedOptionValueWithOption();
            //generateOptionValuePicRecord(allSelectedOptionValue, serverOptionAssets);
            var skuArray = buildSku(allSelectedOptionValue);
            var gridDataStore = convertToGridDataStore(skuArray);
            skuBuilder.loadStore(gridDataStore);
        }
    }

	//option选中 后执行的动作
	function skuOptionSelectEvent1($selected){
        //把当前选择的 option[第1个下拉框] 的 optionValue[第2个下拉框] 显示出来
        showOptionValue($selected);

        refreshSkuOptionArray();

        skuOptionSelectEvent2(getSelectedOptionArray());
	}

    /**
     * 规格值(optionValue)--改变 事件,只需要 修改里面的数据行
     */
    function createSkuGridEvent() {
        var allSelectedOptionValue = collectAllSelectedOptionValueWithOption();
        //generateOptionValuePicRecord(allSelectedOptionValue);
        generateSkuRecord(allSelectedOptionValue);
    }

    /**
	 * option 下拉项值改变事件,sku表格重新生成
	 *
     * option 改变 需要先 清除表格，再重新生成 表格，，且里面无数据行
     */
    function skuOptionSelectEvent2(selectedOptions) {
        selectedProductOptionIdArray = [];
        selectedProductOptionLabel = [];
        selectedProductOptionIndex = [];

        for(var i = 0 ; i < selectedOptions.length; i++){
            selectedProductOptionIdArray.push(selectedOptions[i].id);
            selectedProductOptionLabel.push(selectedOptions[i].label);
            selectedProductOptionIndex.push(selectedOptions[i].index);
        }

        //destoryAllOptionValuePicRecord();

        if(selectedProductOptionIdArray.length > 0){
            buildSkuGridWithoutData(selectedProductOptionLabel, selectedProductOptionIdArray);
        } else {
            if(skuBuilder){
                $("#Sku_Grid").html("");
                skuBuilder.reset();
            }
        }
    }

	//获取 所有选中的 optionValue，并带上 option
    function collectAllSelectedOptionValueWithOption(){
        var optionArray = [];
        var optionValuePannelDomArray = $(".optionValuePannel");

        for(var i = 0; i < optionValuePannelDomArray.length-1; i++)
		{
            var optionValueArray = [];

            var optionAllowUploadPic = $(optionValuePannelDomArray[i]).attr("data-option-pic");
            var picOptionLabel = $(optionValuePannelDomArray[i]).attr("data-option-label");

            var optionValueDTOArray = getOptionValueDTOArrayFromPannel($(optionValuePannelDomArray[i]));
			<#-- var tempOptionValueArray=getOptionValueArrayFromOptionValueMap(optionValueIdArray); -->

            $.each(optionValueDTOArray, function(i,val){
				var optionValueId=val.id;
				var optionId=val.optionId;
                var optionIdAndOptionValueId = optionId+'-'+optionValueId;
                var optionValueLabel = (val.text || "").replace(/-/g, "@@");

                optionValueArray.push(optionIdAndOptionValueId  + "-" + optionValueLabel + "-" + optionAllowUploadPic + "-" + picOptionLabel);
            });

            optionArray.push(optionValueArray);
        }
        return optionArray;
    }

    //获取 所有选中的 optionValue
    function collectAllSelectedOptionValue(){
        var optionValueArray = [];

        var optionValuePannelDomArray = $(".optionValuePannel");

        for(var i = 0; i < optionValuePannelDomArray.length-1; i++)
        {
            var optionValueDTOArray = getOptionValueDTOArrayFromPannel($(optionValuePannelDomArray[i]));
            optionValueArray=$.merge(optionValueArray,optionValueDTOArray);
        }
        return optionValueArray;
    }

	//获取所有 skuOptionPannel
	function getSkuOptionPannelArrayFromSkuOptionContainer(){
		var allSkuOptionPannel=[];
		$('#skuOptionContainer').find('.skuOptionPannel').each(function(){
            allSkuOptionPannel.push($(this));
		});

		return allSkuOptionPannel;
	}

	//获取当前 optionValuePannel下所有 optionValue 的 id
	function getOptionValueIdArrayFromPannel(optionValuePannel){
		var selectedOptionValueArray=[];
        optionValuePannel.children('.optionValueLi').each(function(){
            selectedOptionValueArray.push($(this).attr('data-optionValue-id'));
		});

		return selectedOptionValueArray;
	}

    //获取当前 optionValuePannel下所有 optionValue 的 dto
    function getOptionValueDTOArrayFromPannel(optionValuePannel){
        var optionValueDTOArray=[];
        optionValuePannel.children('.optionValueLi').each(function(){
            var optionValue = new Object();
			var optionId=$(this).attr('data-option-id');
			var optionValueId=$(this).attr('data-optionvalue-id');

            optionValue.id=optionValueId;
            optionValue.optionId=optionId;

            //optionValue.text=$(this).attr('data-optionvalue-text');
            optionValue.text=$("#optionValueInput-"+optionId+"-"+optionValueId).val();

            optionValueDTOArray.push(optionValue);
        });

        return optionValueDTOArray;
    }

    //TODO 获取当前所有 option下拉框 选中的值
    function refreshSkuOptionArray(){
        sekectedSkuOptionIdArray.length=0;

        $(".skuOptionSelect").each(function(i,obj){
            var $object = $(obj);
            var objectVal=$object.val();

            if(objectVal != "-1"){
                sekectedSkuOptionIdArray.push(objectVal);
            }
        });
    }

    //获取当前所有 option下拉框 选中的 id值
    function getSelectedOptionIdArray(){
        var selectedOptionIdArray = [];
        $(".skuOptionSelect").each(function(i,obj){
            var $object = $(obj);
            var objectVal=$object.val();

            if(objectVal != "-1"){
                selectedOptionIdArray.push(objectVal);
            }
        });

		return selectedOptionIdArray;
    }

    //获取当前所有 option下拉框 选中的值(对象)
    function getSelectedOptionArray(){

        var selectedOptionIdArray=getSelectedOptionIdArray();
        var selectedOptionArray = [];

		$.each(selectedOptionIdArray,function(i,val){
			if(optionMap[val]){
                var objOption = optionMap[val];
                selectedOptionArray.push(objOption);
			}
        });

		return selectedOptionArray;
    }

	function curSkuOptionPannel(obj){
		return skuOptionPannel = obj.closest('.skuOptionPannel');
	}

	function getJqueryObj(obj,tagName){
        var parentObj=curSkuOptionPannel(obj);
        var dom=parentObj.find(tagName)[0];
		var $obj=$(dom);

		return $obj;
	}

	//根据第1个下拉框选择的 option，来显示 第2个下拉框的 optionValue
	function showOptionValue(obj){
        var skuOptionPannel=curSkuOptionPannel(obj);

		//optionValue 下拉框
        var optionValueSelectDom=skuOptionPannel.find(".skuOptionValueSelect")[0];
        var $optionValueSelect=$(optionValueSelectDom);
        $optionValueSelect.empty();
        $optionValueSelect.prepend('<option value="-1">请选择</option>');
        var curVal=obj.val();
        //$optionValueSelect.append("<option value='"+curVal+"' id='newOption'  style='color:red;'>新增一个z</option>");
        if(optionAndOptionValueMap[curVal])
		{
			var optionValueMap=optionAndOptionValueMap[curVal];
            $.each(optionValueMap,function(key,value){
                $optionValueSelect.append('<option value='+key+'>'+value.name+'</option>');
            });
		}
        if(newOptionMap[curVal]){
            var newOptionValue=newOptionMap[curVal];
            for(var i=0;i<newOptionValue.length;i++){
                $optionValueSelect.append(newOptionValue[i]);
            }
        }

		<#--
		if($optionValueSelect.data('rendered') == true){
            $optionValueSelect.easyDropDown('destroy');
		}
        $optionValueSelect.closest('.layer').show();
        $optionValueSelect.easyDropDown({
            cutOff: 10
        });
        $optionValueSelect.data('rendered',true);
        $optionValueSelect.closest('.layer').hide();
		-->

        var allowUploadPic="0";
		if(optionMap[curVal])
		{
			var option=optionMap[curVal];
			if(option.allowUploadPic == '1'){
                allowUploadPic="1";
			}
		}

        //var optionValuePannelArray=obj.siblings(".optionValuePannel");
        var optionValuePannelDom=skuOptionPannel.find(".optionValuePannel")[0];
		var $optionValuePannel=$(optionValuePannelDom);

        //if(optionValuePannelArray && optionValuePannelArray.length>0){
            //var optionValuePannel=optionValuePannelArray.first();
			$optionValuePannel.attr('data-option-id',obj.val());
			$optionValuePannel.attr('data-option-label',obj.find("option:selected").text());
			$optionValuePannel.attr('data-option-pic',allowUploadPic);

			//清空 optionValuePannel下 的 optionValue
			$optionValuePannel.html('');
        //}
	}

	//根据 optionValue 的id, 从 optionValueMap 中获取 optionValue
	function getOptionValueArrayFromOptionValueMap(optionValueIdArray){
		var optionValueArray=[];

		if(optionValueIdArray && optionValueIdArray.length > 0 && optionValueMap)
		{
            $.each(optionValueIdArray,function(i,val){
                if(optionValueMap[val])
				{
                    optionValueArray.push(optionValueMap[val]);
				}
            });
        }

		return optionValueArray;
	}

    /**
     * 规格值文本框--文本内容改变事件
     *
     * @param obj
     */
    function optionValueLabelChange(obj){

        var id=$(obj).attr('data-option-optionvalue-id');

        var newValueLabel = $(obj).val();
        newValueLabel = newValueLabel.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
        if(newValueLabel == ""){
            $(obj).focus();
            return false;
        }

        $("#"+id).text($(obj).val());

        var optionId = id.split("-")[0];
        var optionValueId = id.split("-")[1];
        skuBuilder.updateOptionLabel(optionId, optionValueId, newValueLabel);
    }

    function optionValueLabelBlur(obj){
        var newValueLabel = $(obj).val();
        newValueLabel = newValueLabel.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
        if(newValueLabel == ""){
            $(obj).focus();
            return false;
        }
        var flag = 0;
        $(".optionValueLabel").each(function() {
            console.log($(this).text());
            if ($(this).text() == newValueLabel) {
                flag++;
            }
        });
        if (flag > 1) {
            return BUI.Message.Alert("不能设置相同的规格名（包含别名）！");
        }
		var id=$(obj).attr('data-option-optionvalue-id');
        $(obj).hide();

		$("#"+id).show();
    }


    /**
     * 规格值图片 上传
     *
     */
    function doUploadOptionValuePic(obj){
        var optionValueId = currentUploadId.split("-")[1];
        uploadPath = "${ctx}/admin/adminAsset/productOptionValue/" + optionValueId + "/uploadAsset"

        var fileName = obj.value;
        if(fileName == null || jQuery.trim(fileName).length <= 0){
            BUI.Message.Alert("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);
        suffix = jQuery.trim(suffix);

        if(jQuery.trim(suffix).length <= 0 ||
                ("jpg" != jQuery.trim(suffix.toLowerCase()) && "png" != jQuery.trim(suffix.toLowerCase()))){
            BUI.Message.Alert("文件格式错误!");
            return false;
        }

        $.ajaxFileUpload({
            url : uploadPath,
            secureuri: false,
            fileElementId: obj.id,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                optionValuePicUploadSuccessHandler(data);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }

    function optionValuePicUploadSuccessHandler(data){
        var optionId = currentUploadId.split("-")[0];
        var optionValueId = currentUploadId.split("-")[1];

        $('#img_'+optionId+'_'+optionValueId).attr('src',data.adminDisplayAssetUrl);
        $('#img_'+optionId+'_'+optionValueId).attr('assetId',data.assetId);

		$('#img_'+optionId+'_'+optionValueId).show();
        $('#img_'+optionId+'_'+optionValueId).prev('.doUploadOptionValuePic').hide();

        $('#img_'+optionId+'_'+optionValueId).next(".delOptionValuePic").show();
    }

    function deleteOptionValuePic(data){
        /*var optionId = data.split("-")[0];
        var currentPicGridBuilder =  optionValuePicBuilder[(optionValuePicGridColumnDataIndexPrefix + optionId)];
        if(currentPicGridBuilder){
            currentPicGridBuilder.deleteRecordPic(data);
        }*/
    }


	//-----构建表格
    function buildSkuGridWithoutData(options, optionIds){
        if(!skuBuilder){
            skuBuilder = new YrSkuBuilder('Sku_Grid');
        } else {
            $("#Sku_Grid").html("");
            skuBuilder.reset();
        }
        skuBuilder.addOptions(options, optionIds);
        skuBuilder.buildGridColumn();
        skuBuilder.buildGrid();
        skuBuilder.renderGrid();
    }

    function generateSkuRecord(allSelectedOptionValue){
        var skuArray = buildSku(allSelectedOptionValue);
        var gridDataStore = convertToGridDataStore(skuArray);
        var json = JSON.stringify(gridDataStore);
        skuBuilder.loadStore(gridDataStore);

        
    }

    function buildSku(allOptionValueArray) {
        var skuArray = [];

        if(allOptionValueArray.length == 1){
            skuArray = allOptionValueArray[0];
        } else if (allOptionValueArray.length > 1){
            skuArray = arrayCombine(allOptionValueArray);
        }

        return skuArray;
    }

    function convertToGridDataStore(mergedArray){
        var gridDataArray = [];

        for(var i = 0; i < mergedArray.length; i++){
            var gridData = new Object();
            var selfSku = mergedArray[i];

            var selfOptionValue = selfSku.split('~|~');
            var idArray = [];
            for(var j = 0; j < selfOptionValue.length; j++){
                var tempOptionId = selfOptionValue[j].split('-')[0];
                var tempOptionDataIndex = gridColumnDataIndexPrefix + tempOptionId;
                var tempOptionDataValueIndex = gridColumnDataIndexPrefix + gridColumnDataValueIndexPrefix + tempOptionId;
                var tempOptionValueId = selfOptionValue[j].split('-')[1];
                var tempOptionValueLabel = selfOptionValue[j].split('-')[2];
                //idArray.push(tempOptionId);
                idArray.push(tempOptionValueId);
                gridData[tempOptionDataIndex] = tempOptionValueLabel;
                gridData[tempOptionDataValueIndex] = tempOptionValueId;
            }
            idArray.sort(function(a, b){
                var aInt = parseInt(a);
                var bInt = parseInt(b);
                return aInt - bInt;
            });
            gridData.id = idArray.join('-');
			//alert(gridData.id);
            if(skuQuantityMap && skuQuantityMap[gridData.id]){
                gridData.serverSku = true;
                gridData.count = skuQuantityMap[gridData.id];
            }
            if(skuSalePriceMap && skuSalePriceMap[gridData.id]){
                gridData.salePrice = skuSalePriceMap[gridData.id];
            }
            if(skuOuterIdMap && skuOuterIdMap[gridData.id]){
                gridData.outerId = skuOuterIdMap[gridData.id];
            }
            if(skuCommodityCodeMap && skuCommodityCodeMap[gridData.id]){
                gridData.commodityCode = skuCommodityCodeMap[gridData.id];
            }
            gridDataArray.push(gridData);
        }

        return gridDataArray;
    }

    function arrayCombine(items){
        var base = items[0]

        return mulit(base, items.slice(1))

        function mulit(base, leftArr){
            var multiplier = leftArr[0];

            var newBase = [];
            for(var i = 0, len = base.length; i < len; i++){
                var b = base[i];
                for(var j = 0, len2 = multiplier.length; j < len2; j++){
                    var m = multiplier[j];
                    newBase.push(b+'~|~'+m);
                }
            }

            var _left = leftArr.slice(1);
            if(_left.length){
                return mulit(newBase, _left);
            }else{
                return newBase;
            }
        }
    }
</script>