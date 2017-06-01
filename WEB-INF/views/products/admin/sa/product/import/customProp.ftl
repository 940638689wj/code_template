<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" ></script>
    <script type="text/javascript">
        var productOptionMapJson = ${productOptionMapJson};

        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#customPropForm'
            });

            form.on("beforesubmit", function(){
               return collectData();
            });
            form.render();
        });

        /**
         * 收集数据
         *
         */
        function collectData() {
            var collectSuccess = true;
            var collectErrorInfo = "";

            $("select[data-prop-container='propSelector']").each(function(){
                var _selfOptionSelectorValue = $(this).val();
                if(_selfOptionSelectorValue == "-1"){
                    var propId = $(this).attr("data-prop-id");
                    var propLabelInput = $("input[data-custom-prop-txt-id='customTxt_" + propId + "']").val();
                    if(propLabelInput == ""){
                        collectSuccess = false;
                        collectErrorInfo = "请输入商品属性[" + propId + "]";
                        return false;
                    }
                }
            });

            if(collectSuccess){
                $("select[data-prop-value-container='propValueSelector']").each(function(){
                    var _selfOptionValueSelectorValue = $(this).val();
                    if(_selfOptionValueSelectorValue == "-1"){
                        var propValueId = $(this).attr("data-prop-value-id");
                        var propValueLabelInput = $("input[data-custom-prop-value-txt-id='customTxt_"+propValueId+"']").val();
                        if(propValueLabelInput == ""){
                            collectSuccess = false;
                            collectErrorInfo = "请输入商品属性值[" + propValueId + "]";
                            return false;
                        }
                    }
                });
            }


            if(!collectSuccess){
                BUI.Message.Alert(collectErrorInfo);
                return false;
            } else {
                $("#customPropBtn").html("处理商品中...");
                $("#customPropBtn").attr("disabled","disabled");
            }

            return true;
        }

        function propChange(obj){
            var _self = $(obj);
            var _selfPropId = _self.attr("data-prop-id");
            var _selfValue = _self.val();
            if(_selfValue == -1){
                $("input[data-custom-prop-txt-id='customTxt_"+_selfPropId+"']").show();
            } else {
                $("input[data-custom-prop-txt-id='customTxt_"+_selfPropId+"']").hide();
            }
            renderOptionValueSelect(_selfPropId, _selfValue);
        }

        /**
         * 重新渲染规格值下拉选择框，该事件是当属性规格选择框发生变化之后触发的
         *
         * propId：taobao对应的propID；
         * optionId: 我司的商品规格属性ID;（注意optionId == -1的时候，即规格值的下拉框应该全部清空掉!）
         */
        function renderOptionValueSelect(propId, optionId){
            $("select[data-value-id-for-prop='"+propId+"']").each(function(){
                $(this).empty();
                var firstOptionDom = "<option value='-1'>新增商品规格值</option>";
                $(this).append(firstOptionDom);
                var productOptions = productOptionMapJson[optionId];
                for(var productOptionKey in productOptions){
                    var optionDom = "<option value='" + productOptionKey + "'>" + productOptions[productOptionKey] + "</option>";
                    $(this).append(optionDom);
                }
            });

            $("input[data-custom-value-id-for-prop='customTxt_"+propId+"']").each(function(){
               $(this).show();
            });
        }

        function propValueChange(obj){
            var _self = $(obj);
            var _selfPropValueId = _self.attr("data-prop-value-id");
            var _selfValue = _self.val();
            if(_selfValue == -1){
                $("input[data-custom-prop-value-txt-id='customTxt_"+_selfPropValueId+"']").show();
            } else {
                $("input[data-custom-prop-value-txt-id='customTxt_"+_selfPropValueId+"']").hide();
            }
        }

        /**
         * 重新跳转到上传文件页面
         *
         */
        function goToUploadFile(){
            window.location.href="${ctx}/admin/adminProduct/import";
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/adminProduct.html">商品管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">导入商品</li>
    </ul>
    <div class="flow-steps">
        <ol class="num4">
            <li id="secondStep" class="first current-prev done"><i class="icon-ok"></i>导入商品文件</li>
            <li id="thirdStep" class="current"><i class="num">2</i>自定义商品规格</li>
            <li id="fourthStep" class="last"><i class="num">3</i>自定义商品信息</li>
        </ol>
    </div>
    <form id="customPropForm" class="form-horizontal" method="post" action="saveCustomPropInfo">
        <table cellspacing="0" class="table table-bordered">
            <thead>
            <tr>
                <th>商品(淘宝)销售属性ID</th>
                <th>商品(淘宝)销售属性名称</th>
                <th>商品(淘宝)销售规格值</th>
                <th>商品规格（规格值）</th>
            </tr>
            </thead>
            <tbody>
            <#if productPropList?has_content && (productPropList?size > 0) >
                <#list productPropList as productProp>
                <!-- 属性ID -->
                <input type="hidden" name="propId" value="${(productProp.propId)!}">
                    <#assign productOptionIdFromProp = (productProp.productOptionId)?default(0)>
                    <#assign productOptionFromProp = "">
                <tr>
                    <td><p>${(productProp.propId)!}</p></td>
                    <td><p>${(productProp.propLabel)!?html}</p></td>
                    <td><p>${(productProp.propLabel)!?html}</p></td>
                    <td>
                        <#assign customTxtDisplay = "">
                        <!-- 属性对应的规格值 -->
                        <select name="propOption_${(productProp.propId)!}" data-prop-container="propSelector" data-prop-id="${(productProp.propId)!}" onchange="javascript:propChange(this);">
                            <option value="-1">新增商品规格</option>
                            <#if productOptionList?has_content && (productOptionList?size > 0)>
                                <#list productOptionList as productOption>
                                    <#assign defaultSelected = "">
                                    <#if productOptionIdFromProp?? && productOptionIdFromProp == productOption.skuTypeId>
                                        <#assign defaultSelected = "selected=\"selected\"">
                                        <#assign customTxtDisplay = "style=\"display:none;\"">
                                        <#assign productOptionFromProp = productOption>
                                    </#if>
                                    <option ${defaultSelected} value="${(productOption.skuTypeId)!}">${(productOption.skuTypeDesc)!}</option>
                                </#list>
                            </#if>
                        </select>
                        <input name="propCustomLabel_${(productProp.propId)!}" data-custom-prop-txt-id="customTxt_${(productProp.propId)!}" type="text" value="${(productProp.propLabel)!}" ${customTxtDisplay}>
                    </td>
                </tr>
                    <#assign productPropValueList = productProp.propValueList>
                    <#if productPropValueList?has_content && (productPropValueList?size > 0)>
                        <#list productPropValueList as productPropValue>
                            <input type="hidden" name="propValueId" value="${(productPropValue.propValueId)!}">
                            <#assign productOptionValueForProductSeq = -1>
                            <#if (productPropValue.seq)?? && (productPropValue.seq)?has_content>
                                <#assign productOptionValueForProductSeq = (productPropValue.seq)?first>
                            </#if>
                            <input type="hidden" name="propValueSeq" value="${productOptionValueForProductSeq}">
                            <#assign productOptionValueIdFromPropValue = (productPropValue.productOptionValueId)?default(0)>
                            <#assign productOptionValueFromPropValueList = ""/>
                            <#if productOptionFromProp?? && productOptionFromProp?has_content && (productOptionFromProp.allowedValues)??>
                            <!-- 匹配到的规格存在productOption -->
                                <#assign productOptionValueFromPropValueList = productOptionFromProp.allowedValues/>
                            </#if>
                        <tr>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${(productPropValue.propValueId)!}</td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${(productPropValue.propValueLabel)!?html}</td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${(productPropValue.propValueDefaultLabel)!?html}</td>
                            <td>
                                <#assign customTxtDisplay = "">
                                <select name="propValueOptionValue_${productOptionValueForProductSeq}_${(productPropValue.propValueId)!}" data-prop-value-container="propValueSelector" data-value-id-for-prop= "${(productProp.propId)!}" data-prop-value-id="${(productProp.propId)!}-${(productPropValue.propValueId)!}-${productOptionValueForProductSeq}" onchange="javascript:propValueChange(this);">
                                    <option value="-1">新增商品规格值(别名)</option>
                                    <#if productOptionValueFromPropValueList??
                                    && productOptionValueFromPropValueList?has_content && (productOptionValueFromPropValueList?size > 0)>
                                        <#list productOptionValueFromPropValueList as temp>
                                            <#assign defaultSelected = "">
                                            <#if productOptionValueIdFromPropValue?? && productOptionValueIdFromPropValue == temp.skuKey>
                                                <#assign defaultSelected = "selected=\"selected\"">
                                                <#assign customTxtDisplay = "style=\"display:none;\"">
                                            </#if>
                                            <option ${defaultSelected} value="${(temp.skuKey)!}">${(temp.skuValue)!}</option>
                                        </#list>
                                    </#if>
                                </select>
                                <input name="propValueCustomLabel_${productOptionValueForProductSeq}_${(productPropValue.propValueId)!}" data-custom-value-id-for-prop="customTxt_${(productProp.propId)!}" data-custom-prop-value-txt-id="customTxt_${(productProp.propId)!}-${(productPropValue.propValueId)!}-${productOptionValueForProductSeq}" type="text" value="${(productPropValue.propValueLabel)!}" ${customTxtDisplay}>
                            </td>
                        </tr>
                        </#list>
                    </#if>
                </#list>
            <#else>
                <tr>
                    <td colspan="4" style="text-align: center;font-weight: bold;font-size: 14px;">导入商品无任何规格!</td>
                </tr>
            </#if>
            </tbody>
        </table>
        <div class="row actions-bar">
            <div class="form-actions offset7">
                <button type="submit" id="customPropBtn" class="button button-primary">下一步</button>
                <button type="reset" class="button" onclick="javascript:goToUploadFile();">返回</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>