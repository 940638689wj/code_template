<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<#macro showCategoryOptions parent level currentId currentParentId>
    <#if currentId?has_content && currentId!=-1 && parent?has_content && parent.categoryId==currentId>
        <#return>
    </#if>
    <#if parent?has_content>
        <option <#if parent.categoryId==currentParentId>selected="selected"</#if> value="${parent.categoryId}"><#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${parent.categoryName!}</option>
    </#if>
    <#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
            <@showCategoryOptions child level+1 currentId currentParentId/>
        </#list>
    </#if>
</#macro>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/category/list?productTypeCd=${(productTypeCd)!}"><#if productTypeCd==1>商品<#else>菜品</#if>分类</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if productCategory?has_content && productCategory.categoryId?has_content>添加<#if productTypeCd==1>商品<#else>菜品</#if>分类<#else>编辑商品分类</#if></li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/category/save" method="post">

        <input type="hidden" name="productTypeCd" value="${(productTypeCd)!}"/>
        
        <div class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>名称：</label>
                        <div class="controls">
                            <input value="" name="categoryName" data-rules="{required:true}" class="input-normal control-text">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>上级分类：</label>
                        <div class="controls">
                            <select name="parentCategoryId">
                            <option value="">顶层分类</option>
                            <#if parentCategoryList?? && parentCategoryList?has_content>
			                	<#list parentCategoryList as parentCategory>
			                    <option value="${(parentCategory.categoryId)!}" <#if productCategory??&&productCategory?has_content><#if parentCategory.categoryId==productCategory.categoryId>selected="selected"</#if></#if>>${(parentCategory.categoryName)!}</option>
			                	</#list>
			            		</#if>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>显示顺序</label>
                        <div class="controls">
                            <input value="" name="displayId" data-rules="{required:true}" class="input-normal control-text">
                        </div>
                    </div>
                </div>
                <!-- 类别分组 -->
                
                <#--<div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>是否启用：</label>
                        <#assign radioValue="N"/>
                        <#if archievd?has_content&&archievd=="Y">
                            <#assign radioValue="Y"/>
                        </#if>
                        <label class="radio">
                            <input type="radio"  name="archived" value="N" <#if radioValue=="N">checked="checked" </#if>/>是
                        </label>&nbsp;&nbsp;
                        <label>
                            <input type="radio" name="archived" value="Y" <#if  radioValue=="Y">checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>-->
        </div>
        <div class="actions-bar">
            <div class="form-actions">
				<button type="submit" class="button button-primary">保存</button>
				<button type="reset" class="button">重置</button>
			</div>
        </div>
    </form>
</div>
<script type="text/javascript">
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                    <#if  productTypeCd==1>
                    window.location.href="${ctx}/admin/sa/category/list?productTypeCd=1";                   	
                    <#else>
                    window.location.href="${ctx}/admin/sa/category/list?productTypeCd=2";                   	
                    </#if>
                }
            }
        });

        form.on('beforesubmit', function(){
            var displayOrder = $("input[name='displayId']").val();
            displayOrder = displayOrder.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
            if(!(/(^[1-9]\d*$)/.test(displayOrder))){
                BUI.Message.Alert("商品类别显示顺序必须为正整数!");
                return false;
            }

            

            return true;
        });

        form.render();
    });
</script>
 </body>
 </html>