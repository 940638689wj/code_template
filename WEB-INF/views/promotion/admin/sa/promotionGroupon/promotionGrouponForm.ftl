<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/promotionGroupon?statusCd=${statusCd!1}">团购列表</a><span
                class="divider">&gt;&gt;</span></li>
        <li class="active"><#if promotionGrouponDTO?has_content>编辑<#else>添加</#if>团购</li>
    </ul>

    <form id="J_Form" class="form-horizontal">
        <div id="edit-div" class="form-content">
            <input type="hidden" name="promotionId" id="promotionId" value="${(promotionGrouponDTO.promotionId)!}"/>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购名称：</label>
                    <div class="controls">
                        <input value="${(promotionGrouponDTO.promotionName)!}" name="promotionName" id="promotionName"
                               data-rules="{required:true,maxlength:30}" class="input-normal control-text"
                               <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1) >disabled="disabled"</#if>>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">描述：</label>
                    <div class="controls">
                        <textarea value="${(promotionGrouponDTO.groupcouponDesc)!}" name="groupcouponDesc"
                                  id="groupcouponDesc"
                                  data-rules="{maxlength:255}" class="input-normal control-row1"
                                  <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>></textarea>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>虚拟销售量：</label>
                    <div class="controls">
                        <input value="${(promotionGrouponDTO.grouponInitSaleNum)!}" name="grouponInitSaleNum"
                               id="grouponInitSaleNum"
                               data-rules="{required:true,regexp: /^\+?[1-9]\d*$/}"
                               data-messages="{regexp:'请输入大于0的整数！'}"
                               class="input-normal control-text"
                               <#if statusCd?has_content && statusCd==-1>disabled="disabled"</#if>/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购最大销售量：</label>
                    <div class="controls">
                        <input value="${(promotionGrouponDTO.grouponMaxSaleNum)!}" name="grouponMaxSaleNum"
                               id="grouponMaxSaleNum"
                               data-rules="{required:true,regexp: /^\+?[1-9]\d*$/}"
                               data-messages="{regexp:'请输入大于0的整数！'}"
                               class="input-normal control-text"
                               <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1) >disabled="disabled"</#if>/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>每人限购量：</label>
                    <div class="controls">
                        <input value="${(promotionGrouponDTO.grouponPersonQuotaNum)!}" name="grouponPersonQuotaNum"
                               id="grouponPersonQuotaNum"
                               data-rules="{required:true,regexp: /^\+?[1-9]\d*$/}"
                               data-messages="{regexp:'请输入大于0的整数！'}"
                               class="input-normal control-text"
                               <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>团购价格：</label>
                    <div class="controls">
                        <input value="${(promotionGrouponDTO.grouponPrice)!}" name="grouponPrice" id="grouponPrice"
                               data-rules="{required:true,number:true,min:0}" class="input-normal control-text"
                               <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>启用状态：</label>

                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="statusCd" value="1" checked="checked"
                                   <#if promotionGrouponDTO?has_content && promotionGrouponDTO.statusCd == 1 >checked="checked" </#if>/>是
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="statusCd" value="0"
                                   <#if !promotionGrouponDTO?has_content ||
                                   (promotionGrouponDTO?has_content && promotionGrouponDTO.statusCd == 0) >checked="checked" </#if>/>否
                        </label>
                    </div>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>有效日期：</label>
                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                    <input name="enableStart" id="enableStart" data-tip="{text : '起始日期'}" data-rules="{required:true}"
                           <#if promotionGrouponDTO?has_content>value="${(promotionGrouponDTO.enableStartTime)!?date}"</#if>
                           data-messages="{required:'起始日期不能为空'}" class="input-small calendar" type="text"
                           <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                    <label>&nbsp;至&nbsp;</label>
                    <input name="enableEnd" id="enableEnd" data-tip="{text : '结束日期'}" data-rules="{required:true}"
                           <#if promotionGrouponDTO?has_content>value="${(promotionGrouponDTO.enableEndTime)!?date}"</#if>
                           data-messages="{required:'结束日期不能为空'}" class="input-small calendar" type="text"
                           <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                </div>
            </div>

            <div class="control-group">
                <label class="control-label"><s>*</s>团购券使用日期：</label>
                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                    <input name="allowUseStart" id="allowUseStart" data-tip="{text : '起始日期'}"
                           data-rules="{required:true}"
                           <#if promotionGrouponDTO?has_content>value="${(promotionGrouponDTO.allowUseStartTime)!?date}"</#if>
                           data-messages="{required:'起始日期不能为空'}" class="input-small calendar" type="text"
                           <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                    <label>&nbsp;至&nbsp;</label>
                    <input name="allowUseEnd" id="allowUseEnd" data-tip="{text : '结束日期'}" data-rules="{required:true}"
                           <#if promotionGrouponDTO?has_content>value="${(promotionGrouponDTO.allowUseEndTime)!?date}"</#if>
                           data-messages="{required:'结束日期不能为空'}" class="input-small calendar" type="text"
                           <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员级别：</label>
                    <div class="controls control-row-auto">
                    <#assign isAllUserLevel = (promotionGrouponDTO.isAllUserLevelJoin)?default(false)/>
                        <label class="checkbox">
                            <input <#if isAllUserLevel>checked="checked" </#if>
                                   id="allUserLevel" name="allUserLevel" value='1' type="checkbox"
                                   <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                            全选
                        </label><br>

                    <#if userLevelList?? && (userLevelList?size > 0)>
                        <#assign temp = 1>
                        <#list userLevelList as userLevel>
                            <#assign userLevelId = (userLevel.userLevelId)?string>
                            <#assign userLevelSelect = false/>
                            <#if (userLevelXrefMap[userLevelId])??>
                                <#assign userLevelSelect = true/>
                            </#if>

                            <label class="checkbox">
                                <input name="userLevel" <#if userLevelSelect> checked='checked' </#if> type="checkbox"
                                       value="${(userLevel.userLevelId)!}"
                                       <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1)>disabled="disabled"</#if>/>
                            ${(userLevel.userLevelName)!}
                            </label>&nbsp;&nbsp;

                            <#if temp % 6 == 0>
                                <br>
                            </#if>
                            <#assign temp = temp + 1 >
                        </#list>
                    </#if>
                    </div>
                </div>
            </div>

            <div id="edit-div" class="well control-group">
                <input type="hidden" name="productId" value="">
                <input type="hidden" name="crowdFundProductAmt" value="${(crowdFundDTO.crowdFundProductAmt)!}">
                <div class="row" id="productInfo">
                    <ul class="toolbar">
                        <li>
                            <button id="choiceProductBtn" type="button" class="button button-info"
                                    <#if (promotionGrouponDTO?has_content && promotionGrouponDTO.auditStatusCd==1) || (statusCd?has_content && statusCd==-1) >disabled="disabled"</#if>>
                                <i class="icon icon-white icon-envelope"></i> 选择商品
                            </button>
                        </li>
                    </ul>
                    <hr>
                    <div class="search-grid-container">
                        <div id="productGrid"></div>
                    </div>
                </div>
            </div>
            <div class="actions-bar">
            <#if statusCd?has_content && statusCd==-1>
            	<a href="${ctx}/admin/sa/promotionGroupon?statusCd=${statusCd!1}" class="button button-primary">返回</a>
            <#else>
            	<button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            </#if>
            </div>

        </div>
    </form>
</div>

<#include "${ctx}/includes/sa/productDialog.ftl"/>
<script type="text/javascript">
    var opt = {};
    opt.selectType = 2;
    opt.showSku = 1;
    opt.selector = '#productGrid';
    opt.choiceProductBtn = '#choiceProductBtn';
    opt.productIds = '${productIds!}';
    <#if promotionGrouponDTO?has_content>
    opt.disabledOpt = true;
    </#if>
    createDialog(opt);

		function remainTime(){
			btn=document.getElementById('save');
			btn.disabled=false;
		}
		
    $(function () {
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
            }
        }).render();

        //未使用bui提交
        form.on('beforesubmit', function () {
			btn=document.getElementById('save');
			btn.disabled=true;
            var auditStatusCd = '${(promotionGrouponDTO.auditStatusCd)!0}';//审核状态 0：未审核 1：审核通过 2：审核不通过

            var param = {};
            param.statusCd = $("input[name='statusCd']:checked").val();
            param.grouponInitSaleNum = $("#grouponInitSaleNum").val();

            //id存在为修改，不存在为添加
            if ($("#promotionId").val()) {
                param.promotionId = $("#promotionId").val();
            }

            //审核未通过，启用状态固定为禁用，其余可任意修改
            if (auditStatusCd != '1') {
                var today = new Date();
                today.setDate(today.getDate() - 1);
                var enableStart = Date.parse(($("#enableStart").val() + "").replace(new RegExp("\\-", "gi"), "/"));
                if (enableStart < today) {
                    app.showError('活动日期不得小于当天！');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                var allowUseStart = Date.parse(($("#allowUseStart").val() + "").replace(new RegExp("\\-", "gi"), "/"));
                if (allowUseStart < enableStart) {
                    app.showError('有效使用日期不得小于活动起始日期！');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                var list = productStore.getResult();
                if ($("input[name='userLevel']:checked").length == 0) {
                    app.showError('请选择会员');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                if (list.length == 0) {
                    app.showError('请选择商品');
                    setTimeout("remainTime()",1100);
                    return false;
                }
                param.promotionName = $("#promotionName").val();
                param.groupcouponDesc = $("#groupcouponDesc").val();
                param.grouponMaxSaleNum = $("#grouponMaxSaleNum").val();
                param.grouponPersonQuotaNum = $("#grouponPersonQuotaNum").val();
                param.grouponPrice = $("#grouponPrice").val();
                param.enableStart = $("#enableStart").val();
                param.enableEnd = $("#enableEnd").val();
                param.allowUseStart = $("#allowUseStart").val();
                param.allowUseEnd = $("#allowUseEnd").val();
                //会员等级集合
                var userLevelIdList = [];
                $("input[name='userLevel']:checked").each(function () {
                    userLevelIdList.push($(this).val());
                });
                param.userLevelIdList = userLevelIdList;
                //选中商品id集合
                var productIdList = [];
                for (var i = 0; i < list.length; i++) {
                    productIdList.push(list[i].productId);
                }
                param.productIdList = productIdList;
            }

            //提交表单
            $.ajax({
                type: "POST",
                url: "${ctx}/admin/sa/promotionGroupon/save",
                data: JSON.stringify(param),//将对象序列化成JSON字符串
                dataType: "json",
                contentType: 'application/json;charset=utf-8', //设置请求头信息
                success: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        if($("#promotionId").val()){
                            app.showSuccess("修改成功");
                        } else {
                            app.showSuccess("新建成功");
                        }
                        window.location.href = '${ctx}/admin/sa/promotionGroupon?statusCd=' + '${statusCd!1}';
                    }
                }
            });
            return false;

        });
        form.render();

        //全选按钮
        $("#allUserLevel").on("change", function () {
            if ($(this).attr("checked")) {
                $("input[name='userLevel']").attr("checked", true);
            } else {
                $("input[name='userLevel']").attr("checked", false);
            }
        });
    })
</script>
</body>
</html>