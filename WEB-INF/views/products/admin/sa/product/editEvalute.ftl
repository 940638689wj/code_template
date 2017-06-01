<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8">
	<#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script type="text/javascript" src="/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="/static/admin/js/ueditor/ueditor.all.js"></script>
    <script type="text/javascript" src="/static/js/jquery.raty.min.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/productManage/evalute?productId=${product.productId}">评价管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">新加评价</li>
    </ul>
    <div id="tab">
        <ul class="bui-tab nav-tabs">
	          <li href="${ctx}/admin/sa/productManage/addOrEdit?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	              <span class="bui-tab-item-text">基本信息</span>
	          </li>
	          <li href="${ctx}/admin/sa/productManage/details?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
	              <span class="bui-tab-item-text">详细信息</span>
	          </li>
	          <li href="${ctx}/admin/sa/productManage/evalute?productId=${product.productId}" class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover" aria-disabled="false" aria-pressed="false">
	              <span class="bui-tab-item-text">商品评价设置</span>
	          </li>
        </ul>
    </div>
    <div class="clearfix" style="position: relative; padding-left: 208px;">
        <#include "productInfo.ftl">
        <div style="min-width: 416px;margin-left: 20px;">
            <form id="Evalute_Form" class="form-horizontal" action="${ctx}/admin/sa/productManage/evaluteSave" method="post">
                <input type="hidden" name="productId" value=${product.productId!}>
                <input type="hidden" name="rating" id="star${product.productId}" value="">
                <input type="hidden" name="reviewId" value="${(productReview.reviewId)!''}">
                <div id="edit-div" class="well">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>用户名：</label>
                            <div class="controls">
                                <input  name="reviewerName" value="${(productReview.reviewerName)!?html}"  data-rules="{required:true,maxlength:20}" class="input-normal control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>手机号码：</label>
                            <div class="controls">
                                <input  name="reviewerPhone" value="${(productReview.reviewerPhone)!?html}" class="input-normal control-text" data-messages="{regexp:'请输入正确的手机号码'}" data-rules="{required:true,regexp:/^1\d{10}$/}">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>宝贝符合程度：</label>
                            <div class="controls">
                                <div class="productMatchScore" itemId="${product.productId}"></div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>评价时间：</label>
                            <div class="controls">
                                <#if (productReview.reviewTime)?has_content>
                                    <input type="text" data-rules="{required:true}"  class="calendar control-text" id="reviewTime" name="reviewTime" value="${productReview.reviewTime?string('yyyy-MM-dd')}">
                                <#else>
                                    <input type="text" data-rules="{required:true}"  class="calendar control-text" id="reviewTime" name="reviewTime" value="">
                                </#if>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>评价内容：</label>
                            <div class="controls control-row-auto">
                                <textarea name="reviewContent" data-rules="{required:true}" class="input-large bui-form-field" type="text">${(productReview.reviewContent)!''}</textarea>
                            </div>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">回复内容：</label>
                            <div class="controls control-row-auto">
                                <textarea name="replyContent" class="input-large bui-form-field" id="replyContent"  type="text">${(productReview.replyContent)!''}</textarea>
                            </div>
                        </div>
                    </div>
                    <br/>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label">回复时间：</label>
                            <div class="controls">
                            <#if (productReview.replyTime)?has_content>
                                <input type="text"  class="calendar control-text" id="replyTime" name="replyTime" value="${productReview.replyTime?string('yyyy-MM-dd')}">
                            <#else>
                                <input type="text"  class="calendar control-text" id="replyTime" name="replyTime" value="">
                            </#if>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="actions-bar">
                    <button type="submit" class="button button-primary">保存</button>
                    <button type="reset" class="button">重置</button>
                </div>
            </form>
        </div>
     </div>
</div>
<script type="text/javascript">
    $(function() {
        $("li[href]").click(function () {
            var href = $(this).attr("href");
            window.location.href = href;
        });
        var star = 5;
        <#if productReview?? && productReview.productMatchScore?? && productReview.productMatchScore?has_content>
            star =${(productReview.productMatchScore)!}
        </#if>
        $("input[name='rating']").attr("value", star);

        $.fn.raty.defaults.path = '/static/images';
        $('.productMatchScore').raty({
            score: star,
            hints: ['一星', '二星', '三星', '四星', '五星'],
            width: 120,
            click: function (score, evt) {
                var itemId = $(this).attr('itemId');
                $("#star" + itemId).val(score);
            }
        });
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#Evalute_Form',
            submitType: 'ajax',
            dataType: 'Json',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    app.page.open({
	                     href: '${ctx}/admin/sa/productManage/evalute?productId=${product.productId!}'
	                });
                }
            }
        });
        form.on('beforesubmit', function () {
            var start = $("#reviewTime").val();
            var end = $("#replyTime").val();
            var replyContent = $("#replyContent").val();
            var replyTime = $("#replyTime").val();
            if (end != "") {
                var start_ = new Date(start.replace("-", "/").replace("-", "/"));
                var end_ = new Date(end.replace("-", "/").replace("-", "/"));
                if (start_ > end_) {
                    BUI.Message.Alert("回复时间不得小于评价时间!!");
                    return false;
                }
            }
            if (replyContent != "") {
                if (replyTime == "") {
                    BUI.Message.Alert("回复时间不得为空!");
                    return false;
                }
            }
        });
        form.render();
    });
</script>
</body>
</html>