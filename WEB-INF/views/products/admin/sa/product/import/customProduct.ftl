<#assign ctx = request.contextPath>
<#macro showProductCategoryOptions parent level currentId currentParentId selectedCategoryId>
    <#if parent?has_content>
    <option <#if selectedCategoryId != -1 && parent.categoryId==selectedCategoryId>selected="selected"</#if> value="${parent.categoryId}">
        <#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${parent.categoryName!}</option>
    </#if>
    <#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
            <@showProductCategoryOptions child level+1 currentId currentParentId selectedCategoryId/>
        </#list>
    </#if>
</#macro>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
    <script type="text/javascript">

        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#customProductForm',
                submitType: 'ajax',
                dataType: 'Json',
                callback: function (data) {
                    $("#importSuccessBtn").html("下一步");
                    $("#importSuccessBtn").removeAttr("disabled");
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        BUI.Message.Confirm('导入商品成功！',function(){
                            window.location.href = "${ctx}/admin/sa/productManage/list?productStatusCd=1";
                        },'question');
                        <#--window.location.href = "${ctx}/admin/sa/productManage/list?productStatusCd=1";-->
                    }
                }
            });

            form.on("beforesubmit", function(){
                var collectResult = collectData();
                if(collectResult){
                    $("#importSuccessBtn").html("处理中...");
                    $("#importSuccessBtn").attr("disabled","disabled");
                }
            });
            form.render();
        });

        /**
         * 收集数据
         *
         */
        function collectData() {
            return true;
        }

        /**
         * 重新跳转到自定义属性
         *
         */
        function goToCustomProp(){
            window.location.href = "${ctx}/admin/sa/importProduct/import/customProductInfo";
        }

        function toggleProductSku(obj){
            var _self = $(obj);
            var productSeq = _self.attr("data-seq-id");
            if(productSeq){
                var skuContainer = $("#skuContainer_" + productSeq);
                if(skuContainer && skuContainer.length){
                    skuContainer.toggle();
                    switchToggleBtn(obj);
                } else {
                    app.ajaxHelper.submitRequest({
                        url:'getProductSku',
                        data:{seq:productSeq},
                        success:function(data){
                            if(data && data.length){
                                buildProductSkuTable(productSeq, data);
                                skuContainer = $("#skuContainer_" + productSeq);
                                if(skuContainer && skuContainer.length){
                                    skuContainer.toggle();
                                    switchToggleBtn(obj);
                                }
                            } else {
                                BUI.Message.Alert("该产品没有货品信息!");
                            }
                        }
                    });
                }
            }
        }

        function buildProductSkuTable(productSeq, data){
            var targetTr = $("tr[data-seq-id="+productSeq+"]");
            if(targetTr && targetTr.length){
                $("input[name='productSkuSign_"+productSeq+"']").val("1");
                var newRow = "<tr id=\"skuContainer_"+productSeq+"\" style=\"display: none;\">" +
                                "<td colspan=\"6\">" +
                                    "<table cellspacing=\"0\" class=\"table table-bordered\">" +
                                        "<caption>货品信息</caption>";
                newRow += "<thead><th>序号</th>";
                var propLabelList = data[0]['skuPropLabelList'];
                if(propLabelList && propLabelList.length){
                    for(var j = 0; j < propLabelList.length; j++){
                        newRow += "<th>" + propLabelList[j] + "</th>";
                    }
                }
                newRow += "<th>库存</th><th>外部ID</th></thead>";
                newRow += "<tbody>"
                for(var i = 0; i < data.length; i++){
                    var targetSku = data[i];
                    var skuVirtualId = targetSku['skuVirtualId'];
                    var skuId = targetSku['skuId'];
                    if(!skuId){
                        skuId = "";
                    }
                    var skuAmount = targetSku['skuAmount'];
                    if(!skuAmount){
                        skuAmount = 0;
                    }
                    var propValueLabel = targetSku['skuPropValueLabelList'];
                    newRow += "<tr>";
                    newRow += "<td>" + (i + 1) +"</td>";
                    if(propValueLabel && propValueLabel.length){
                        for(var z = 0; z < propValueLabel.length; z++){
                            newRow += "<td>"+propValueLabel[z]+"</td>";
                        }
                    }
                    newRow += "<td><input type=\"text\" name=\"skuAmount_" + productSeq + "_" + skuVirtualId + "\" value=\"" + skuAmount + "\"></td>";
                    newRow += "<td><input type=\"text\" name=\"skuId_" + productSeq + "_" + skuVirtualId + "\" value=\"" + skuId + "\"></td>"
                    newRow += "</tr>";
                }
                newRow += "</tbody></table></td></tr>";
                targetTr.after(newRow);
            }
        }

        function switchToggleBtn(obj){
            var _self = $(obj);
            if(_self.hasClass("icon-minus")){
                _self.removeClass("icon-minus");
                _self.addClass("icon-plus");
                _self.attr("title","展开货品信息");
            } else {
                _self.removeClass("icon-plus");
                _self.addClass("icon-minus");
                _self.attr("title","收起货品信息");
            }
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">商品管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">导入商品</li>
    </ul>
    <div class="flow-steps">
        <ol class="num4">
            <li id="secondStep" class="first done"><i class="icon-ok"></i>导入商品文件</li>
            <li id="thirdStep" class="current-prev"><i class="icon-ok"></i>自定义商品规格</li>
            <li id="fourthStep" class="last current"><i class="num">3</i>自定义商品信息</li>
        </ol>
    </div>
    <form id="customProductForm" class="form-horizontal" method="post" action="customProductInfo">
        <table cellspacing="0" class="table table-bordered">
            <thead>
            <tr>
                <th style="width:10px;"></th>
                <th style="width:25px;">序号</th>
                <th style="width:220px;">商品名称</th>
                <th style="width:120px;">商品类别</th>
                <th>商品价格</th>
                <th>商品库存</th>
            </tr>
            </thead>
            <tbody>
                <#if allProductList?? && (allProductList?size > 0)>
                    <#list allProductList as productDTO>
                        <tr data-seq-id="${productDTO.seq}">
                                <td><span title="展开货品信息" style="cursor: pointer;" class="icon-plus" onclick="javascript:toggleProductSku(this);" data-seq-id="${productDTO.seq}">+</span></td>
                            <td>${(productDTO_index + 1)}</td>
                            <td>${(productDTO.productName)!}</td>
                            <td>
                                <select name="categoryId_${productDTO.seq}">
                                    <#assign selectedCategoryId = (productDTO.categoryId)?default(-1)>
                                    <#if allParentCategoryList?has_content>
                                        <#list allParentCategoryList as parentCategory>
                                            <#assign currentId = (parentCategory.categoryId)?default(-1)/>
                                            <#assign currentParentId=(parentCategory.categoryId)?default(-1)/>
                                            <@showProductCategoryOptions  parentCategory 0 currentId currentParentId selectedCategoryId/>
                                        </#list>
                                    </#if>
                                </select>
                            </td>
                            <td>${(productDTO.productPrice)!}</td>
                            <td>${(productDTO.productAmount)?default(0)}</td>
                        </tr>
                        <input type="hidden" name="productSkuSign_${productDTO.seq}" value="0">
                        <#assign skuDTOList = (productDTO.skuList)!>
                    </#list>
                </#if>
            </tbody>
        </table>
        <div class="row actions-bar">
            <div class="form-actions offset7">
                <button id="importSuccessBtn" type="submit" class="button button-primary">下一步</button>
                <button type="reset" class="button" onclick="javascript.history.go(-1);">返回</button>
                <#--goToCustomProp()-->
            </div>
        </div>
    </form>
</div>
</body>
</html>