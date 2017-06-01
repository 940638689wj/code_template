<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/jquery.easydropdown.min.js"></script>
    <script type="text/javascript">
        //全局变量
        var productId = '${(product.productId)!"null"}';
        var isNewAdd = ${isNew?string("true","false")};
        var primaryImageArray = [];
        var primaryImageMediaArray = [];
        var altImageArray = [];
        var altImageMediaArray = [];
        
      $(function () {
            $("li[href]").click(function () {
                var href = $(this).attr("href");
                window.location.href = href;
            });
            var lock =false;
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#Basic_Info_Form',
                errorTpl: '<span class="valid-text" style="line-height: 20px;"><span class="estate error"><span class="x-icon x-icon-mini x-icon-error">!</span><em>{error}</em></span></span>',
                submitType: 'ajax',
                dataType: 'Json',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        if (isNewAdd) { //新增加商品，保存完成之后，进入下一步
                        	//alert(data)
                            addNextStep(data);
                            //setTimeout("remainTime()",1000);
                        } else { //若为编辑商品，保存完成之后，保留原页面，提示保存成功
                        	//alert(data)
                            editSaveSuccess(data);
                          	//数据返回,延迟打开提交按钮,避免重复显示提示信息！
               				setTimeout("remainTime()",1000);
                        }
                    }else{
                    	setTimeout("remainTime()",1000);
                    }
                }
        });
            form.on('beforesubmit', function () {
            	//禁用提交按钮，避免重复提交
            	btn=document.getElementById('save');
				btn.disabled=true;
                var collectDataFlag = collectData();
                var collectOptionDataFlag=collectOptionData();//在 skuTypeList.ftl页面
                var productReturnScore =$("#productReturnScore").val();
        		var vReturnScore = new RegExp("^[1-9]*$");
                
                // 商品分类不能为空
                var categoryFlag = false;
                var categoryId = $("#categoryId").val(); //系列分类

                //将提交按钮设为disabled 
                if (categoryId!=null && categoryId.length > 0) {
                    categoryFlag = true;
                } else {
                    BUI.Message.Alert("商品分类不能为空!");
                    categoryFlag = false;
                     //打开下一步提交按钮
		        	btn=document.getElementById('save');
					btn.disabled=false;
                    return false;
                }
                if(productReturnScore!=null && productReturnScore!=''){
				if(!vReturnScore.test(productReturnScore)){
					BUI.Message.Alert("请输入为正整数的积分！");
				    btn=document.getElementById('save');
					btn.disabled=false;
				    return false;
				}
			}
                return (collectDataFlag && categoryFlag && collectOptionDataFlag);
                //return (collectDataFlag && categoryFlag)
            });
            form.render();
            
        });

        /**
         * 下一步的时候保存该步骤的数据
         */
        function collectData(){
        	var productName = $("#productName").val();         //商品名称 
            var basicUnitTypeCd = $("#basicUnitTypeCd").val(); //基本单位
            var brandId = $("#brandId").val();                 //商品品牌
       		var realStock = $("#realStock").val();             //商品库存
       		var defaultPrice=$("#defaultPrice").val();
       		var productSubTitle=$("#productSubTitle").val();
       		var tagPrice=$("#tagPrice").val();
       		
        	var regu = /^[0-9]*[1-9][0-9]*$/;
        	//alert($("input[name='altImg']").val()+"--------");
        	
        	if(altImageArray.length > 0){
        		//alert($("input[name='altImg']").val());
                var tempAltImgArray = [];
                for(var i = 0; i < altImageArray.length; i++){
                    if(altImageArray[i] && altImageArray[i] != ""){
                        tempAltImgArray.push(altImageArray[i]);
                    }
                }
                var value=$("input[name='altImg']").val();
                //alert(value)
                //alert(tempAltImgArray.join(','))
                if(value!=""){
                	$("input[name='altImg']").val(value+','+tempAltImgArray.join(','));
                }else{
                	$("input[name='altImg']").val(tempAltImgArray.join(','));
                }
                //alert($("input[name='altImg']").val());
            }
        	var primaryImg = $("#primaryImg").val();
			if(primaryImg.length < 1){
			    BUI.Message.Alert("请上传商品主图!");
			     //打开下一步提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
			    return false;
			}
			
			if(defaultPrice == ""){
			 	BUI.Message.Alert("销售价格不能为空");
			 	 //打开下一步提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
			    return false;
			}
			if(tagPrice == ""){
			 	BUI.Message.Alert("成本价不能为空");
			 	 //打开下一步提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
			    return false;
			}
			if(realStock == ""){
			 	BUI.Message.Alert("商品库存不能为空");
			 	 //打开下一步提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
			    return false;
			}
			
           	if(productName == ""){
			 	BUI.Message.Alert("商品名称不能为空!");
			 	 //打开下一步提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
			    return false;
			}
			
			if(productSubTitle == ""){
			 	BUI.Message.Alert("商品描述不能为空");
			 	 //打开下一步提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
			    return false;
			} 
			/*if(basicUnitTypeCd == ""){
			 	BUI.Message.Alert("基本单位不能为空!");
			    return false;
			 }
			
			if(saleUnitTypeCd == ""){
			 	BUI.Message.Alert("销售单位不能为空!");
			    return false;
			}
			
			if(shelveChannelCds.length < 1){
				BUI.Message.Alert("上架渠道不能为空!");
			    return false;
			}
			
			if(mainStoreAllowPayTypeCds.length < 1){
				BUI.Message.Alert("品牌允许支付方式不能为空!");
			    return false;
			}
			
			if(storeAllowPayTypeCds.length < 1){
				BUI.Message.Alert("门店允许支付方式不能为空!");
			    return false;
			}
			
			if(mStoreAllowPayTypeCds.length < 1){
				BUI.Message.Alert("微店允许支付方式不能为空!");
			    return false;
			} 		*/	
			
			return true;
        }

        function addNextStep(data){
            app.page.open({
                //href:'${ctx}/admin/sa/productManage/price?productId=' + data.data + '&isAddNew=1'
                href:'${ctx}/admin/sa/productManage/details?productId=' + data.data.id + '&isAddNew=1'
            });
        }

        function editSaveSuccess(data){
        	if(data.data){
        		app.showSuccess("商品基本信息保存成功！");
        	}else{
        		app.showSuccess("商品编辑失败！");
        	}
        }
        //延时启用保存按钮
	    function remainTime(){
	    		//打开提交按钮
	        	btn=document.getElementById('save');
				btn.disabled=false;
	    }
        
        function isInteger(str){
			var regu = /^[0-9]*[1-9][0-9]*$/;
			return regu.test(str);
		}
		
    </script>
</head>
<body>
<#macro showCategoryChild parent level>
    <#if parent?has_content>
    <#if product??>  
     <#assign categoryId = product.categoryId>
     </#if>        	
   		<option value="${(parent.categoryId)!}" <#if product??&&(parent.categoryId == categoryId)>selected="selected"</#if>><#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${(parent.categoryName)!?html}</option>
    </#if>
	<#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
             <@showCategoryChild child level+1 />
        </#list>
    </#if>    
</#macro>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">商品管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if product?has_content && product.productId?has_content>编辑商品<#else>添加商品</#if></li>
    </ul>
    <#if !isNew>
        <div id="tab">
            <ul class="bui-tab nav-tabs">
                <li href="${ctx}/admin/sa/productManage/addOrEdit?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">基本信息</span>
                </li>
                <li href="${ctx}/admin/sa/productManage/details?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">详细信息</span>
                </li>
                <li href="${ctx}/admin/sa/productManage/evalute?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">商品评价设置</span>
                </li>
            </ul>
        </div>
    <#else>
        <div class="flow-steps">
            <ol class="num5">
                <li class="first current"><i class="num">1</i>基本信息</li>
                <li class="last"><i class="num">2</i>商品详情</li>
            </ol>
        </div>
    </#if>
    <form id="Basic_Info_Form" action="${ctx}/admin/sa/productManage/updateProductInfo" method="post">
        <input type="hidden" name="productId" value="${(product.productId)!}"/>
        <input type="hidden" name="isNew" value="<#if isNew??>${isNew?string("true","false")}</#if>"/>
        <div class="prdbasic clearfix">
            <div class="prd-colside">
                <div class="wrap">
                    <#include "productPictureInfoForm.ftl">
                    <#if isNew?? && !isNew>
                        <#include "productRqCodeImageForm.ftl">
                    </#if>
                </div>
            </div>
            <div class="prd-colmain">
                <div class="wrap">
                    <#include "productBasicInfoForm.ftl">
                </div>
            </div>
        </div>
        <div class="row actions-bar">
            <div class="form-actions offset7">
                <button type="submit" class="button button-primary" id="save"><#if isNew>下一步<#else>确定</#if></button>
                <#if !isNew><a class="button" href="${ctx}/admin/sa/productManage/list?productStatusCd=1">返回商品列表</a></#if>
            </div>
        </div>
    </form>
</div>

</body>
</html>