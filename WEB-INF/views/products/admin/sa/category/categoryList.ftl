<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<#macro showCategoryChild parent level>
    <#if parent?has_content>
        <tr>
            <td><#if level gt 0><#list 0..level*8 as one>&nbsp;</#list></#if>${(parent.categoryName)!?html}</td>
            <td>${(parent.displayId)!}</td>
            <td><a href="${ctx}/m/products/${(parent.categoryId)!}.html" target="_Blank">/m/products/${(parent.categoryId)!}.html</a></td>
            <td>
                <a href="${ctx}/admin/sa/category/add?categoryId=${parent.categoryId}&&productTypeCd=${(productTypeCd)!}">编辑</a>&nbsp;&nbsp;&nbsp;
                <@securityAuthorize ifAnyGranted="delete">
                <a href="javascript:deleteCategory('${(parent.categoryId)!}')">删除</a>&nbsp;&nbsp;&nbsp;
                </@securityAuthorize>
                <a href="${ctx}/admin/sa/category/add?categoryId=${(parent.categoryId)!}&&productTypeCd=${(productTypeCd)!}&&type=1">添加子类</a>
            </td>
        </tr>
    </#if>
	<#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
             <@showCategoryChild child level+1 />
        </#list>
    </#if>    
    </#macro>
<div class="container">
    <input type="hidden" name="productTypeCd" id="productTypeCd" value="${(productTypeCd)!}"/>
    <div class="title-bar">
        <div id="tab">
      </div>
     		<ul class="toolbar">
                   <li><a class="button button-small button-primary" onclick="javascript:add();">添加</a></li>
            </ul>
	 <table cellspacing="0" class="table table-bordered">
        <thead>
        <tr>
            <th>名称</th>
            <th>显示顺序</th>
            <th>访问地址</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody>
        <#if parentCategoryList?has_content>
        <#list parentCategoryList as parentCategory>
				  <@showCategoryChild  parentCategory 0/>

        </#list>
        </#if>
        </tbody>
    </table>
    
    
    <div id="showDisplay" style="display: none">
        <form class="form-horizontal" >
            <div  class="form-content" >
            	<input type="hidden" id="categoryId"  name="categoryId" value=""/>
                <div class="control-group">
                    <label class="control-label"><s>*</s>商品系列排序：</label>
                    <div class="controls">
                        <input value="" name="displayId" id="displayId" class="input-normal control-text">
                    </div>
                </div>
                <div class="control-group">
					<span style="color:red;margin-left:30px;">备注：数值越大越靠前</span>
                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
	var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'商品分类',value:'1'}/*,
            {text:'菜品分类',value:'2'}*/
        ]
    });
    
	tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
        	var productTypeCd=item.get('value');
        	$("#productTypeCd").val(productTypeCd);
        	
	        window.location.href = "${ctx}/admin/sa/category/list?productTypeCd="+productTypeCd;
	    });

	function deleteCategory(categoryId){
            BUI.Message.Confirm('确认要删除么？',function(){
                var postData = {categoryId:categoryId};
                app.ajaxHelper.submitRequest({
                    url:'${ctx}/admin/sa/category/delete',
                    data:postData,
                    success:function(data){
                        if (app.ajaxHelper.handleAjaxMsg(data)) {
                            app.showSuccess("删除成功!")
                        <#if  productTypeCd==1>
                    		window.location.href="${ctx}/admin/sa/category/list?productTypeCd=1";                   	
                   		<#else>
                    		window.location.href="${ctx}/admin/sa/category/list?productTypeCd=2";                   	
                    	</#if>
                        }
                    }});
            },'question');
        }
   
	 function goOtherList(){
            window.location.href = "${ctx}/admin/sa/category/list?productTypeCd=0";
        }
     function goList(){
            window.location.href = "${ctx}/admin/sa/category/list?productTypeCd=1";
        }
     function add(){
            window.location.href = "${ctx}/admin/sa/category/add?productTypeCd=${(productTypeCd)!}";
        }   
	
	// 新增分类
    function addCategory(){
        $.post("${ctx}/admin/sa/category/categoryTypeExist",
        null,
        function(data){
        	if(data){
        		window.location.href = "${ctx}/admin/sa/category/form";
        	}else{
        		BUI.Message.Alert('请检查是否存在系列类型或者是否启用！');
        		return false;
        	}
        });
    }
	// 排序
	function sort(){
		var grid = search.get('grid');
		var selection = grid.getSelection();
		if(selection.length < 1){
			BUI.Message.Alert('请选择商品系列信息！');
        	return false;
		}else if(selection.length > 1){
			BUI.Message.Alert('请选择一条商品系列信息！');
        	return false;
		}
		$("#categoryId").val(selection[0].categoryId);
		$("#displayId").val(selection[0].displayId);
		dialog.show();
	}
	// 设置系列类型
	function setCategoryType(){
		window.location.href = "${ctx}/admin/sa/category/type/list";
	}
	// 编辑分类
    function editCategory(obj){
        window.location.href = "${ctx}/admin/sa/category/form?categoryId="+obj;
    }
</script>
</body>
</html>