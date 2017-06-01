<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>

    <style>
        .level-box{ position: relative; border: 1px solid #e0e3e8; overflow: hidden; *zoom:1; margin-bottom: 10px; font-size: 14px;}
        .level-list ul{ margin-top: -1px;}
        .level-list li{border-top:1px dashed #e5e5e5; padding-left: 550px; height: 88px;}
        .levelbox-title{ margin: -1px 0 0 -1px; height: 50px;}
        .levelbox-title h3{ float: left; background: #5f52a0; color: #fff; line-height: 48px; height: 48px; padding: 0 50px; font-size: 16px; -webkit-border-radius: 0 0 10px 10px; -moz-border-radius: 0 0 10px 10px; border-radius: 0 0 10px 10px;}
        .level-pic{ float: left; width: 550px; text-align: center; padding: 30px 0;}
        .level-box-form{ margin-left: 550px;}
    </style>

    <script type="text/javascript" src="${ctx}/static/admin/js/validator.js?t=20140611"></script>
</head>
<body>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">商品返利</span></li>
        </ul>
    </div>

    <div class="level-box">
        <div class="level-pic">
            <img src="${ctx}/static/admin/images/pic/member_level_2.png" alt=""/>
        </div>
        <div class="level-box-form">
            <div class="form-horizontal">
                <div class="control-group" style="margin-top: 120px;">
                    <label class="control-label control-label-auto"><s>*</s>商品返利 &nbsp;=&nbsp;  商品金额 &nbsp;*&nbsp;</label>

                    <div class="controls">
                        <input  name="shopInShopRebateRatio" class="input-small control-text" type="text" data-rules="{min:0,max:100,number:true}" value="<#if shopInShopRebateRatio?? && shopInShopRebateRatio?has_content>${((shopInShopRebateRatio)*100)?string("0.##")}</#if>"> %
                        <br/><br/>
                        <a href="javascript:void(0);" onclick="saveShopInShopRebateRatio();" class="button button-primary">保存</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script type="text/javascript">

    function saveShopInShopRebateRatio(){
        var shopInShopRebateRatio = $("input[name='shopInShopRebateRatio']").val();
        if(validData(shopInShopRebateRatio,'返利'))
        {
            app.ajax("${ctx}/admin/sa/userPromotion/save/rebateUrl",{shopInShopRebateRatio:shopInShopRebateRatio},function(data){
                if(app.ajaxHelper.handleAjaxMsg(data)){
                    app.showSuccess("保存成功!");
                }
            })
        }
    }

    function validData(rebateRatioVal,msg){
        rebateRatioVal = YrValidator.replaceAllSpace(rebateRatioVal);
        if(rebateRatioVal != "" && !jQuery.isNumeric(rebateRatioVal)){
            BUI.Message.Alert(msg+"比例必须为正数值型!");
            return false;
        }
        return true;
    }
</script>
</body>
</html>