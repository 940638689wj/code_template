<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/zTree_master/jquery.ztree.core.js"></script>
	<script type="text/javascript" src="${ctx}/static/admin/js/zTree_master/jquery.ztree.excheck.js"></script>
	<link rel="stylesheet" href="${ctx}/static/admin/css/metroStyle.css" type="text/css">
</head>
<body>
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="${ctx}/admin/sa/productManage/list">商品管理</a> <span class="divider">&gt;&gt;</span></li>
            <li class="active"><#if !isNew>编辑<#else>新增</#if>销售区域价格</li>
        </ul>
        <#if !isNew>
            <div id="tab">
                <ul class="bui-tab nav-tabs">
	                <li href="${ctx}/admin/sa/productManage/addOrEdit?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	                    <span class="bui-tab-item-text">基本信息</span>
	                </li>
	                <li href="${ctx}/admin/sa/productManage/details?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	                    <span class="bui-tab-item-text">详细信息</span>
	                </li>
	                <li href="${ctx}/admin/sa/productManage/price?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
	                    <span class="bui-tab-item-text">商品区域价格</span>
	                </li>
	                <li href="${ctx}/admin/sa/productManage/evalute?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	                    <span class="bui-tab-item-text">商品评价设置</span>
	                </li>
                </ul>
            </div>
        <#else>
            <div class="flow-steps">
	            <ol class="num5">
	                <li class="first"><i class="num">1</i>基本信息</li>
	                <li class="next current"><i class="num">2</i>区域价格设置</li>
	                <li class="last"><i class="num">3</i>商品详情</li>
	            </ol>
            </div>
        </#if>
        <div class="clearfix" style="position: relative;padding-left: 208px;">
        	<#include "productInfo.ftl">
        	<div style="min-width: 416px;margin-left: 20px;">
	        	<form id="D_Form" class="form-horizontal" action="${ctx}/admin/sa/productManage/price/updatePrice" method="post">
		            <input type="hidden" name="productId" value="${(product.productId)!}"/>
		            <input type="hidden" name="idStr" id="idStr" value=""/>
		            <input type="hidden" name="discountStr" id="discountStr" value=""/>
		            <input type="hidden" name="isNew" value="<#if isNew??>${isNew?string("true","false")}</#if>"/>
	                <div class="panel">
	                    <div class="panel-header"><h3>通用销售价格设置</h3></div>
	                    <div class="panel-body">
	                        <div class="control-group">
	                            <label class="control-label"><s>*</s>挂牌价格：</label>
	                            <div class="controls">
	                                <input value="<#if product?? && (product.tagPrice)?? && (product.tagPrice != 0)>${product.tagPrice}</#if>" name="tagPrice" onblur="onbl(this)" id="tagPrice" type="text"
	                                       data-rules="{checkRetailPrice:true,required:true,min:0,number:true}" class="input-small control-text">
	                            </div>
	                            <div class="controls">
	                                &nbsp;&nbsp;<input type="checkbox" <#if ((productSetting)?? && (productSetting.isShowTagPriceText))>checked="checked"</#if> value="<#if ((productSetting)?? && (productSetting.isShowTagPriceText))>true<#else>false</#if>" name="isShowTagPriceText" id="isShowTagPriceText"/>显示"挂牌价格"字眼
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <label class="control-label"><s>*</s>默认销售价格：</label>
	                            <div class="controls">
	                                <input value="<#if product?? && (product.defaultPrice)??>${(product.defaultPrice)!}</#if>" name="defaultPrice" onblur="onbl(this)" id="defaultPrice" type="text" class="input-small control-text" data-rules="{required:true,min:0,number:true}">
	                                &nbsp;&nbsp;
	                                <span id="salePriceChange" style="color: #ff0000;">
	                                    <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
	                                        <div class="tips-content">用户在特定区域外或者无区域的时候显示的价格。</div>
	                                    </div>
	                                </span>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	
	                <div class="panel">
	                    <div class="panel-header">
	                        <h3>会员通用价格设置</h3>
	                    </div>
	                    <div class="panel-body">
	                        <div class="tips-wrap">
	                            <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
	                                <div class="tips-content">
	                                   	如果有单独设置区域价.则会员折扣会在区域价的基础上进行计算。
	                                </div>
	                            </div>
	                        </div>
	                        <br/><br/>
	                        <#if isNew>
	                         	<#if userLevelList?? && (userLevelList?size > 0) >
	                        		<#list userLevelList as userLevel>
		                        		<div class="control-group">
			                                <!--<label class="control-label">会员折扣价：</label>-->
			                                    <label class="control-label">${(userLevel.userLevelName)!?html}折扣价：</label>&nbsp;
			                                <div class="controls">
				                                    <input value="" name="discountPercent" id="${userLevel.userLevelId}" type="text" onblur="onblus(this)" class="input-small control-text" data-rules="{min:1,max:100,number:true}">&nbsp;
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
			                                <label class="control-label">会员折扣价：</label>
			                                <div class="controls">
			                                    <label>${(productPriceUserLevel.userLevelName)!?html}：</label>&nbsp;
				                                <input value="${discount!}" name="discountPercent" id="${(productPriceUserLevel.userLevelId)}" type="text" onblur="onblus(this)" class="input-small control-text" data-rules="{min:1,max:100,number:true}">&nbsp;
						                        <label>%</label>
			                                </div>
			                            </div>
		                            </#list>
		                        </#if>
	                        </#if>
	                    </div>
	                </div>
	
	                <div class="panel">
	                    <div class="panel-header">
	                        <h3>区域价格设置</h3>
	                    </div>
	                    <div class="panel-body">
	                        <div class="control-group">
	                            <label class="control-label">商品状态：<#if product?? && product.productStatusCd == 1>上架<#else>下架</#if></label>
	                            <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
	                                <div class="tips-content">
	                                    	基础商品状态如果为下架.则全部区域为下架状态.不管是否在区域内设置了上架
	                                </div>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                            <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
	                                <div class="tips-content">
	                                    	未添加的区域在前台则按照通用价格显示,单独下架某区域的商品.不会影响到其他区域。
	                                </div>
	                            </div>
	                        </div>
	                        <div class="control-group">
	                     	    <ul id="treeDemo" class="ztree"></ul>
	                            <div class="actions-bar-fixed">
	                                <div class="actions-bar">
	                                    <div class="form-actions offset5">
	                                        <button id="btn_batch_update" class="button button-large">批量修改价格</button>
	                                        <button type="submit" class="button button-large button-primary"><#if isNew>下一步<#else>保存</#if></button>
	                                        <button type="reset" class="button button-large">重置更改</button>
	                                    </div>
	                                </div>
	                            </div>
	                     	</div>
	                    </div>
	                </div>
	        	</form>
	        </div>
        </div>
    </div>
    <div id="dialog_batch_update_price" style="display: none;">
        <form id="form_batch_set_price" action="" class="form-horizontal" method="post">
            <div class="row">
                <div class="control-group">
                    <label class="control-label" style="width: 120px;">批量修改价格：</label>
                    <div class="controls control-row-auto">
                       <div class="controls">
		                 	<input name="tag_Price" id="tag_Price" onblur="onbl(this)" placeholder='挂牌价'data-rules="{required:true,min:0,number : true}" />元
		                 </div>
		                 <div class="controls">
		                 	<input name="sale_Price" id="sale_Price" onblur="onbl(this)"  placeholder='销售价' data-rules="{required:true,min:0,number : true}" />元
		                 </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <script type="text/javascript">
    <#--
        $("#tagPrice").blur( function () {        
            var r = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
            var tagPrice = $("#tagPrice").val();
            if(!r.test(tagPrice)){
            BUI.Message.Alert("小数点太多了！");
            $("#tagPrice").val('');
            return;
            } 
		 } );
		 
		   $("#defaultPrice").blur( function () {        
          var r = /^(([1-9][0-9]*)|(([0]\.\d{1,2}|[1-9][0-9]*\.\d{1,2})))$/;
           var defaultPrice = $("#defaultPrice").val();
            if(!r.test(defaultPrice)){
            BUI.Message.Alert("小数点太多了！");
            $("#defaultPrice").val('');
            return;
            } 
		 } );
	-->
        $(function(){
            var productId = '${(product.productId)!"null"}';
            var isNewAdd = ${isNew?string("true","false")};         
            var tagPrice = $("#tagPrice").val();
            var defaultPrice = $("#defaultPrice").val();
         
            //挂牌价不能低于销售价
            Form.Rules.add({
                name: 'checkRetailPrice',  //规则名称
                msg: '挂牌价不能低于销售价',//默认显示的错误信息
                validator: function (value, baseValue, formatMsg) { //验证函数，验证值、基准值、格式化后的错误信息
                    var tagPrice = $("#tagPrice").val();
            		var defaultPrice = $("#defaultPrice").val();                        
                    if (tagPrice && $.isNumeric(tagPrice) && defaultPrice && $.isNumeric(defaultPrice)) {
                        if (Number(tagPrice) < Number(defaultPrice)) {
                            $("#tagPrice").focus();
                            return formatMsg;
                        }
                    }
                }
            });
            var form = new Form.Form({
                srcNode: '#D_Form',
                submitType: 'ajax',
                dataType: 'Json',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
	                    if(isNewAdd){
	                        app.page.open({
	                            href: '${ctx}/admin/sa/productManage/details?productId=' + data.data + '&isAddNew=1'
	                        });
	                    }else{
	                        app.showSuccess("信息保存成功！");
	                    }
                    }
                }
            });
            form.on('beforesubmit', function () {
				getAllNodes();
				userDiscount();
            });
            form.render();
			
			// 是否显示挂牌价格字眼
	        $("#isShowTagPriceText").on('click',function(){
	        	if($(this).val()=="false"){
	        		$(this).val("true");
	        	}else{
	        		$(this).val("false");
	        	}
	        });
	        
                var setting = {
			        view: {
			            addDiyDom: addDiyDom,
			            //removeHoverDom: removeHoverDom,
			            selectedMulti: true
			        },
			        check: {
			            enable: true
			        },
			        data: {
			            simpleData: {
			                enable: true
			            }
			        }
			    };

			    var zNodes =[
				    <#if areaList?? && (areaList?size > 0)>
				    	<#list areaList as area>
				    		<#if area.level == 0>
				    			{id:${area.id}, pId:-1, name:"${area.areaName}", <#if productRegionPriceList?? && (productRegionPriceList?size > 0)>open:true</#if>},
				    		<#elseif area.level == 1>
				    			{id:${area.id}, pId:${area.parentAreaId}, name:"${area.areaName}",<#if productRegionPriceList?? && (productRegionPriceList?size > 0)>open:true</#if>},
				    		<#elseif area.level == 2>
				    			{id:${area.id}, pId:${area.parentAreaId}, name:"${area.areaName}"},
				    		</#if>
				    	</#list>
				    </#if>
			    ];
				
			    $(document).ready(function(){
			        var treeObj= $.fn.zTree.init($("#treeDemo"), setting, zNodes);
			         var treeObj1 = $.fn.zTree.getZTreeObj("treeDemo");
			         var nodes = treeObj1.transformToArray(treeObj1.getNodes());
			        if(!isNewAdd){
				    	for(var i = 0; i < nodes.length; i++){
				    		<#if productRegionPriceList?? && (productRegionPriceList?size > 0)>
				        		<#list productRegionPriceList as productRegionPrice>
				        			<#assign regionId = productRegionPrice.regionPriceId>
				        			if(nodes[i].id==${regionId}){
				        				$("#addBtn_"+nodes[i].tId).val(${productRegionPrice.tagPrice});
				        				$("#addBtn2_"+nodes[i].tId).val(${productRegionPrice.salePrice})
				        			}
				        		</#list>
				        	</#if>
				    	}
			        }
			    });
				
			    var newCount = 1;
			    function addDiyDom(treeId, treeNode) {
			        var sObj = $("#" + treeNode.tId + "_span");
			        if (treeNode.editNameFlag || $("#addBtn_"+treeNode.tId).length>0) return;
			        var addStr = "&nbsp;&nbsp;<input type='text' placeholder='挂牌价' onblur='onbl(this)' class='input-small control-text' id='addBtn_" + treeNode.tId + "'>"+
			                "&nbsp;&nbsp;&nbsp;&nbsp;"+
			                "<input type='text' placeholder='销售价' onblur='onbl(this)' class='input-small control-text' id='addBtn2_" + treeNode.tId + "'>";
			        sObj.after(addStr);
			    };
			    
			    // 获取所有的节点
			    function getAllNodes(){
			        var treeObj1 = $.fn.zTree.getZTreeObj("treeDemo");
			    	var idStr = '[';
			    	var nodes = treeObj1.transformToArray(treeObj1.getNodes());
			    	if(nodes.length > 0){
				    	for(var i = 0; i < nodes.length; i++){
				    		if($("#addBtn2_"+nodes[i].tId).val()!=null && $("#addBtn2_"+nodes[i].tId).val()!=""){
				    			idStr += '{';
				    			idStr += 'id:\"'+nodes[i].id+'\",pid:\"'+ nodes[i].pId + '\",tagPrice:\"'+ $("#addBtn_"+nodes[i].tId).val() +'\",salePrice:\"'+ $("#addBtn2_"+nodes[i].tId).val() +'\"';
				    			idStr += '},';
				    		}
				    	}
				    	if(idStr.length > 2){
				    		idStr = idStr.substring(0,idStr.length-1);
				    	}
			    	}
				    idStr += ']';
				    $("#idStr").val(idStr);
			    }
    			
    			// 获取打折关系
    			function userDiscount(){
    				var discount = $('input[name="discountPercent"]');
    				var discountStr = "[";	
    				for(var i = 0; i < discount.length; i++){
    					if(discount[i].value!=""){
	    					discountStr += '{';
							discountStr += 'value:\"'+discount[i].value+'\",id:\"'+ discount[i].id +'\"';
							discountStr += '},';
						}
    				}
    				if(discountStr.length > 2){
    					discountStr = discountStr.substring(0,discountStr.length-1);
    				}
				    discountStr += ']';	
				    $("#discountStr").val(discountStr);
    			}
    			
            $("li[href]").click(function () {
                var href = $(this).attr("href");
                window.location.href = href;
            });
            $("#btn_batch_update").click(function (e) {
            	//var treeObj1 = $.fn.zTree.getZTreeObj("treeDemo");
                e.preventDefault();
                getRegionArray("请选择至少一条记录进行操作！", function (regionArr) {
                    new BUI.Overlay.Dialog({
                        title: "批量设置价格",
                        width: 500,
                        contentId: "dialog_batch_update_price",
                        closeAction: "destroy",
                        buttons: [
                            {
                                text: "确定",
                                elCls: "button button-primary",
                                handler: function () {
                                    var tag_Price = $("#tag_Price").val();
				                    var sale_Price = $("#sale_Price").val();
                                    if(sale_Price==""){
                                    	BUI.Message.Alert("销售价不能为空！");
                                    	return false;
                                    }
                                    if(tag_Price==""){
                                    	BUI.Message.Alert("挂牌价不能为空！");
                                    	return false;
                                    }
				                    if (tag_Price && $.isNumeric(tag_Price) && sale_Price && $.isNumeric(sale_Price)) {
				                        if (Number(tag_Price) < Number(sale_Price)) {
				                            $("#tag_Price").focus();
				                            BUI.Message.Alert("挂牌价不能低于销售价！");
				                            return false;
				                        }
				                    }
                                    for (var i = 0; i < regionArr.length; i++) {
                                        $('#addBtn_'+ regionArr[i]).val($("#tag_Price").val());
										$('#addBtn2_'+ regionArr[i]).val($("#sale_Price").val());
                                    }
                                    this.close();
                                }
                            },
                            {
                                text: "取消",
                                elCls: "button",
                                handler: function () {
                                    this.close();
                                }
                            }
                        ]
                    }).show();
                });
            });
            
            function getRegionArray(nullMsg, callback) {
	                var treeObj = $.fn.zTree.getZTreeObj("treeDemo");
	                var selects = treeObj.getCheckedNodes(true);
                if (selects.length < 1) {
                    return BUI.Message.Alert(nullMsg);
                }
                var regionArr = [];
                for(var i = 0; i < selects.length; i++){
                	regionArr.push(selects[i].tId);
                }
                regionArr && regionArr.length && callback && typeof callback === "function" && callback(regionArr);
                return regionArr;
            }
        });
        //会员折扣
        function onblus(e){
         //  var tid = $('.control-group .controls input[id="aid"]').val();
         //  alert(tid);

          var r = /^([1-9]\d?|100)$/;　　//0-100的正整数  

         var tid = $(e).val();
         if(tid==null || tid ==""){//为空判断
           return;
         }
          if(!r.test(tid)){
           BUI.Message.Alert("请输入100以内的整数！");
           $(e).val("");
           return;              
         }        
          -->
        }
       //正则表达式
       function onbl(t){
         var td = $(t).val();  
         if(td==null || td ==""){//为空判断
           return;
         }
           var reg = /^\d+(\.{0,1}\d+){0,1}$/;   ///^\+?[1-9]\d*$/;
	         if(!reg.test(td)){
	          BUI.Message.Alert("输入值不合法!");
	          $(t).val("");  
	          return ;
	        }
       }
     
        
    </script>
</body>
</html>