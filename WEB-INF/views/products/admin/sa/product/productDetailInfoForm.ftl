<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
</head>
<body>
    <div class="container">
        <ul class="breadcrumb">
            <li><a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">商品管理</a> <span class="divider">&gt;&gt;</span></li>
            <li class="active"><#if !isNew>编辑<#else>添加</#if>详细信息</li>
        </ul>
        <#if !isNew>
            <div id="tab">
                <ul class="bui-tab nav-tabs">
	                <li href="${ctx}/admin/sa/productManage/addOrEdit?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	                    <span class="bui-tab-item-text">基本信息</span>
	                </li>
	                <li href="${ctx}/admin/sa/productManage/details?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
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
	                <li class="first"><i class="num">1</i>基本信息</li>
	                <li class="last current"><i class="num">2</i>商品详情</li>
                </ol>
            </div>
        </#if>
        <div class="clearfix" style="position: relative; padding-left: 208px;">
            <#include "productInfo.ftl">
            <div style="min-width: 416px;margin-left: 20px;">
            	<div style="padding-bottom: 5px;">
					<ul class="bui-tab link-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
						<li id="pcDetailHref" class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
							<a href="javascript:switchToPcTab();">电脑端</a>
						</li>
						<li id="mobileDetailHref" class="bui-tab-item bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
							<a href="javascript:switchToMobileTab();">手机端</a>
						</li>
					</ul>
				</div>
                <form id="D_Form" class="form-horizontal" action="${ctx}/admin/sa/productManage/updateDetailInfo" method="post">
                    <input type="hidden" id="productId" name="productId" value="<#if product?? && product.productId??>${(product.productId)!}</#if>"/>
                    <input type="hidden" name="isNew" value="<#if isNew??>${isNew?string("true","false")}</#if>"/>
                    <div class="row" id="pcDetailContainer">
                        <div class="control-group">
                        	<#--<label class="control-label"><s>*</s>详细描述：</label>-->
                            <div class="controls control-row-auto">
                                <script type="text/plain" id="productDetailDesc" name="productDetailDesc"><#if productExtend?? && (productExtend.productDetailDesc)??>${(productExtend.productDetailDesc)!}</#if></script>
                            </div>
                        </div>
                    </div>
					<div class="row" id="mobileDetailContainer" style="display: none;">
		                <div class="control-group">
		                <#--<label class="control-label"><s>*</s>详细描述：</label>-->
		                    <div class="controls control-row-auto">
		                        <script type="text/plain" id="productMDetailDesc" name="productMDetailDesc"><#if productExtend?? && (productExtend.productMDetailDesc)??>${(productExtend.productMDetailDesc)!}</#if></script>
		                    </div>
		                </div>
		            </div>
                    <div class="row form-actions actions-bar">
                        <div class="span13 offset3 ">
                            <button type="submit" class="button button-primary">保存</button>
                        	<#if !isNew><a class="button" onclick="goBackList()">返回</a></#if>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
    <script type="text/javascript">
    	function switchToMobileTab(){
            $("#pcDetailHref").removeClass("bui-tab-item-selected");
            $("#pcDetailHref").removeClass("bui-tab-item-hover");
            $("#mobileDetailHref").addClass("bui-tab-item-selected");
            $("#mobileDetailHref").addClass("bui-tab-item-hover");
            $("#pcDetailContainer").hide();
            $("#mobileDetailContainer").show();
        }

        function switchToPcTab(){
            $("#mobileDetailHref").removeClass("bui-tab-item-selected");
            $("#mobileDetailHref").removeClass("bui-tab-item-hover");
            $("#pcDetailHref").addClass("bui-tab-item-selected");
            $("#pcDetailHref").addClass("bui-tab-item-hover");
            $("#mobileDetailContainer").hide();
            $("#pcDetailContainer").show();
        }
        function goBackList() {
            /*if (window.parent.globalSearchs.productSearch) {
                window.parent.globalSearchs.productSearch.load();
            }
            top.topManager.openPage({
                id: 'product',
                isClose: true

            })
            return false;*/
            var status= ${product.productStatusCd}
            window.location.href="${ctx}/admin/sa/productManage/list?productStatusCd="+status;
        }
        $(function() {
            var productId = '${(product.productId)!"null"}';
            window.msg_editor = new UE.ui.Editor({
                initialFrameWidth: 1000,
                initialFrameHeight: 300,
                elementPathEnabled: false,
                wordCount: false,
                imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=productDetail&id=" + productId + "&platform=admin",
                imagePath: ""
            });
            window.msg_editor.render("productDetailDesc");
            window.msg_editor2 = new UE.ui.Editor({
                initialFrameWidth: 1000,
                initialFrameHeight: 300,
                elementPathEnabled: false,
                wordCount: false,
                imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=productDetail&id=" + productId + "&platform=admin",
                imagePath: ""
            });
            window.msg_editor2.render("productMDetailDesc");
            $("li[href]").click(function () {
                var href = $(this).attr("href");
                window.location.href = href;
            });
            var dForm = new Form.Form({
                srcNode: '#D_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                    	//alert(data.data.id);
                        app.showSuccess("信息保存成功！");
                        if(data.data.id==1){
                          	window.location.href="${ctx}/admin/sa/productManage/list?productStatusCd=1";
                        }else if(data.data.id==2){
                          	window.location.href="${ctx}/admin/sa/dishesManage/list?productStatusCd=2";
                        }
                	/* <#if isNew>
                        app.page.open({
                            id: 'productManage',
                            isClose: true,
                            reload: true
                        })
                    </#if>*/

                    }
                }
            });
            dForm.render();
        });
    </script>
</body>
</html>