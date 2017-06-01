<!DOCTYPE HTML>
<html>
<head>
<#include "../../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">bui表单</span>
                </li>
            </ul>
        </div>
    </div>

    <form id="J_Form" class="form-horizontal" action="/admin/sa/common/demo/form" method="post">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>表单提交结果：</label>
                        <div class="controls">
                            <label class="radio">
                                <input type="radio" name="resultFlag" value="1" checked/>成功
                            </label>&nbsp;&nbsp;
                            <label class="radio">
                                <input type="radio" name="resultFlag" value="0"/>失败
                            </label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>优惠类型：</label>
                        <div class="controls">
                            <label class="radio">
                                <input type="radio" name="promotionType" value="70" checked/>代金券
                            </label>&nbsp;&nbsp;
                            <label class="radio">
                                <input type="radio" name="promotionType" value="73"/>折扣券
                            </label>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="control-group">
                        <label class="control-label">
                            <s>*</s>
                            <span class="promotionType" data-promotionType="70">减免金额</span>
                            <span class="promotionType" data-promotionType="73" style="display: none;">折扣额度</span>：
                        </label>
                        <div class="controls">
                            <input value="" id="discountValue" name="discountValue" data-rules="{required:true}"  class="input-small control-text">

                            &nbsp;&nbsp;
                            <span class="promotionType" data-promotionType="70">元</span>
                            <span class="promotionType" data-promotionType="73" style="display: none;">折</span>
                        </div>
                        <div class="promotionType tips tips-small tips-info tips-no-icon pull-left" data-promotionType="73" style="display: none;">
                            <div class="tips-content">
                                请填写1-9.9之间的数字,精确到小数点后1位
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>登录名：</label>
                        <div class="controls">
                            <input type="text" name="loginName" value="" class="control-text"/>
                            <label class="checkbox">
                                <input type="checkbox" name="openCheck"/>是否开启验证
                            </label>
                        </div>
                    </div>
                </div>


            </div>
            <div class="actions-bar">
                <button type="submit" id="save" class="button button-primary">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
    </form>
</div>
<script type="text/javascript">
    var form = null;
    $(function(){
        var Form = BUI.Form
        form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
            }
        }).render();
        form.on('beforesubmit', function(){
            var submitFlag = false;
            BUI.Message.Confirm('确认要提交表单吗?',function(){
                submitFlag = true;
            },'question');
            return submitFlag;
        });


        $('input[name="openCheck"]').on('change', function(){
            console.log($(this).attr('checked'))
            if($(this).attr('checked') == undefined){
                var field = form.getField('loginName');
                field.clearRules();
            }else{
                var field = form.getField('loginName');
                field.clearRules();
                field.addRules({ required:true,minlength:3,maxlength:15 });
            }
        });

        <#-- 优惠类型 -->
        $('input[name="promotionType"]').on('change', function(){
            showPromotionType($(this).val());
        });
        showPromotionType($($("input[name='promotionType']").filter(":checked").get(0)).attr('value'));
    });

    function showPromotionType(promotionTypeValue){
        $('.promotionType').hide();
        $('span[data-promotionType="'+promotionTypeValue+'"]').show();
        $('div[data-promotionType="'+promotionTypeValue+'"]').show();

        if(promotionTypeValue == "70"){
            var field = form.getField('discountValue');
            field.clearRules();
            field.addRules({ required : true, number: true, min : 1 });
            field.addRule('regexp',/^[0-9]+([.]{1}[0-9]{1})?$/,'只能1位小数!');
        }else if(promotionTypeValue == "73"){
            var field = form.getField('discountValue');
            field.clearRules();
            field.addRules({ required : true, number: true, min : 1 , max: 9.9});
            field.addRule('regexp',/^[0-9]+([.]{1}[0-9]{1})?$/,'只能1位小数!');
        }
    }
</script>
</body>
</html>