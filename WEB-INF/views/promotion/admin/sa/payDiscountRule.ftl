<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">付款减免规则</span></li>
        </ul>
    </div>

    <div class="content-body">
        <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/payDiscountRule/saveConfig" method="post">
            <div class="row">
                <div class="control-group span20">
                    <h3>设置会员付款次数享受对应的折扣减免</h3>
                </div>
            </div>
            <div class="content-body">
                <table cellspacing="0" class="table table-bordered">
                    <thead>
                    <tr>
                        <th style="width: 100px;">状态</th>
                        <th style="width: 100px;">会员付款次数</th>
                        <th style="width: 100px;">减免金额</th>
                    </tr>
                    </thead>
                    <#if payDiscountRuleList?has_content>
                        <#list payDiscountRuleList as storePayOfferRule>
                            <tr>
                                <input type="hidden" name="id" value="${storePayOfferRule.ruleId}">
                                <td>
                                    <input type="checkbox" name="status_${storePayOfferRule.ruleId}"  <#if (storePayOfferRule.statusCd)?? && storePayOfferRule.statusCd == 1 >checked="checked" </#if>>启用
                                </td>
                                <td>第${(storePayOfferRule.payTimes)!}次付款</td>
                                <td><input value="${(storePayOfferRule.discountValue)!}" data-val="payDiscountRule" name="value_${storePayOfferRule.ruleId}"  type="text"class="input-large control-text"></td>
                            </tr>
                        </#list>
                    </#if>
                </table>
            </div>
            <div class="content-foot">
                <div class="actions-bar">
                    <button type="submit" class="button button-primary">保存</button>
                </div>
            </div>
        </form>
    </div>

</div>

<script type="text/javascript">
    var Form = BUI.Form
    var form = new Form.Form({
        srcNode: '#J_Form',
        submitType: 'ajax',
        callback: function (data) {
            if (app.ajaxHelper.handleAjaxMsg(data)) {
                app.showSuccess("保存成功!");
            }
        }
    });
    form.on('beforesubmit', function() {
        var currentIndex = 1;
        var hasContinue = true;

        $('input[data-val="payDiscountRule"]').each(function(i){
            var currentValue = $(this).val();
            if(!/^\d*$/.test(currentValue)){
                app.showError('减免的金额必须为正整数!');
                $(this).focus();
                hasContinue = false;
                return false;
            }

            currentIndex++;
        });

        //return false;
        if(hasContinue){
            return true;
        }else{
            return false;
        }
    })
    form.render();
</script>

</body>
</html>