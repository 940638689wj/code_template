<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
<style>
	.pic:hover img{
		position:relative;
		width:200px;
		height:150px;
		transform: scale(3);  
        transition: all 1s ease 0s;  
        -webkit-transform: scale(3);  
        -webkit-transform: all 1s ease 0s;
	}
</style>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/user/review">评价管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">评价编辑</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/user/review/updateReview" method="post">
        <input type="hidden" name="reviewId" value="${(productReview.reviewId)!}"/>

        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>评价Id：</label>
                    <div class="controls">
                        <label>${(productReview.reviewId)!}</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员名称：</label>
                    <div class="controls">
                        <label>${(user.loginName)!}</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>产品ID：</label>
                    <div class="controls">
                        <label>${(productReview.productId)!}</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>评价时间：</label>
                    <div class="controls">
                        <label>${((productReview.reviewTime)?string('yyyy-MM-dd'))!}</label>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>评价内容：</label>

                    <div class="controls control-row-auto">
                        <textarea <#if !(canModify?? && canModify)>disabled</#if> name="reviewText" class="input-large" type="text">${(productReview.reviewContent)!}</textarea>
                        <#if !(canModify?? && canModify)>审核后不可编辑</#if>
                    </div>
                </div>
            </div>
            <br/>
			<div class="row">
                <div class="control-group">
                    <label class="control-label">图片信息：</label>
                    <div class="controls control-row-auto img">
                    <#if productReviewPicInfo?has_content>
                    	<#list productReviewPicInfo as prpi>
                        <a href="javascript:void(0)" class="pic"><img src="${(prpi.picUrl)!}" style="width:120px; height:90px;"/></a>&nbsp;&nbsp;
                        </#list>
                    </#if>
                    </div>
                </div>
            </div>
            <br>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>评价等级：</label>
                    <div class="controls">
                        <input value="${(productReview.productMatchScore)!}" <#if !(canModify?? && canModify)>disabled</#if> name="productMatchScore" id="reviewRating" type="text" data-rules="{required:true,min:1,max:5,number:true,regexp:/^\d+$/}" data-messages="{regexp:'请输入整数'}"
                               class="input-normal control-text">
                        <#if !(canModify?? && canModify)>审核后不可编辑</#if>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>状态：</label>
                    <#if canModify?? && canModify>
                        <div id="statusType" class="controls" data-rules="{required:true}">
                            <input type="hidden" id="status" value="${(productReview.reviewStatusCd)!'2'}" name="strReviewStatus">
                        </div>
                    <#else>
                        <div class="controls">
                            ${DICT('REVIEW_STATUS_CD','${(productReview.reviewStatusCd)!2}')}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">回复内容：</label>
                    <div class="controls control-row-auto">
                        <textarea name="reviewReplyText" class="input-large" type="text">${(productReview.replyContent)!}</textarea>
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
<script type="text/javascript">
    $(function(){
        var Select = BUI.Select,
                Data = BUI.Data;
        var item = [{text:"审核通过", value: "1"},{text:"待审核", value: "2"},{text:"审核拒绝", value: "3"}];
        var select = new Select.Select({
            render:'#statusType',
            valueField:'#status',
            items: item
        });
        select.render();

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功!")
                    window.location.href="${ctx}/admin/sa/user/review";
                }
            }
        }).render();
    });
</script>
</body>
</html>