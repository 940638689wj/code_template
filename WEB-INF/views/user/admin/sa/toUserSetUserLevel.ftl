<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <form id="edit_Form" class="form-horizontal" action="${ctx}/admin/sa/user/setUserLevel" method="post">
        <input type="hidden" name="userId" id="userId" value="${(userInfoDTO.userId)!}"/>

        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>会员等级：</label>
                    <div class="controls">
                        <select name="userLevelId" id="userLevelId">
                        <#list userLevelList as userLevel>
                            <option value="${userLevel.userLevelId!}"
                                    <#if (userInfoDTO.userLevelId)?? && (userInfoDTO.userLevelId == userLevel.userLevelId)>selected="selected"</#if>>
                            ${userLevel.userLevelName!?html}</option>
                        </#list>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">归属上级会员：</label>
                    <div class="controls">
                        <label>${(userInfoDTO.parentPhone)!}</label>&nbsp;&nbsp;&nbsp;
                        <a href="javascript:setParentUser();" class="button">修改</a>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">会员折扣：</label>
                    <div class="controls">
                        <label>消费享受</label>&nbsp;
                        <input id="discount" name="discount" type="text" class="control-text"
                               data-rules="{min:0,max:9.9,number:true}"
                               value="<#if (userInfoDTO.discountPercent)?? && (userInfoDTO.discountPercent)?has_content>${((userInfoDTO.discountPercent)*10)?string("0.##")}</#if>">折
                    </div>
                    <div class="tips tips-small tips-info tips-no-icon pull-left">
                        <div class="tips-content">单个会员的折扣以此为准，若不填则默认为会员等级设定的折扣。</div>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-bar">
            <button id="save" type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>

</div>
</body>

<script type="text/javascript">
    var dialog;
    $(function () {
        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#edit_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                }
                //延迟1秒，打开提交按钮
                setTimeout("$('#save').attr('disabled',false)", 1200);
            }
        }).render();
        form.on('beforesubmit', function () {
            if ($("#userLevelId").val() == "-1") {
                alert("请选择会员等级");
                return false;
            }
            //提交前屏蔽提交按钮,避免重复提交
            $("#save").attr("disabled", "true");
            return true;
        });

        <#--//初始化类别之后的按钮单击之后，能够弹出对话框，列出该类别的所有产品列表-->
        <#--var Overlay = BUI.Overlay-->
        <#--dialog = new Overlay.Dialog({-->
            <#--title: '会员列表',-->
            <#--width: 1000,-->
            <#--height: 380,-->
            <#--loader: {-->
                <#--url: '${ctx}/admin/adminCustomer/customerDialogList',-->
                <#--autoLoad: false, //不自动加载-->
                <#--lazyLoad: false, //不延迟加载-->
                <#--appendParams: {isPopularize: '3'}-->
            <#--},-->
            <#--buttons: [{-->
                <#--text: '设  置',-->
                <#--elCls: 'button button-primary',-->
                <#--handler: function () {-->
                    <#--this.close();-->
                    <#--customerChoiceEvent(getSelectedRecords());-->
                <#--}-->
            <#--}, {-->
                <#--text: '取消设置',-->
                <#--elCls: 'button button-primary',-->
                <#--handler: function () {-->
                    <#--cancelChoice();-->
                    <#--this.close();-->
                    <#--deleteHigherCustomer();-->
                <#--}-->
            <#--}],-->
            <#--mask: true-->
        <#--});-->

        <#--initChoiceCustomerBtnEvent();-->
    });

//    function initChoiceCustomerBtnEvent() {
//        $("#choiceCustomerBtn").on('click', function () {
//            var params = { //配置初始请求的参数
//                choiceType: 'radio'
//            };
//            dialog.get('loader').load(params);
//            dialog.show();
//        });
//    }
//
//    function customerChoiceEvent(selectedCustomer) {
//        if (selectedCustomer.length > 0) {
//            $("input[name='higherLevelCustomerId']").val(selectedCustomer[0].id);
//            var containerHtml = "<span style='color: #ff0000;'>" + selectedCustomer[0].username + "</span>&nbsp;&nbsp;";
//            $("#higherCustomerContainer").html(containerHtml);
//        } else {
//            $("input[name='higherLevelCustomerId']").val("");
//            $("#higherCustomerContainer").text("");
//        }
//    }
//
//    function deleteHigherCustomer() {
//        $("input[name='higherLevelCustomerId']").val("");
//        $("#higherCustomerContainer").text("");
//    }


    /**
     * 设置归属上级会员
     *
     * @returns {boolean}
     */
    function setParentUser() {
        var params = { //配置初始请求的参数
            choiceType: 'radio'
        };
        higherUserLevelDialog.get('loader').load(params);
        higherUserLevelDialog.show();
    }

    var higherUserLevelDialog;
    var Overlay = BUI.Overlay;
    higherUserLevelDialog = new Overlay.Dialog({
        title: '会员列表',
        width: 780,
        height: 500,
        loader: {
            url: '${ctx}/admin/sa/user/userDialogList',
            autoLoad: false, //不自动加载
            lazyLoad: false, //不延迟加载
            appendParams: {mstoreStatusCd: '1'}
        },
        buttons: [{
            text: '选 择',
            elCls: 'button button-primary',
            handler: function () {
                var selectedHigherCustomer = getSelectedRecords();
                if (selectedHigherCustomer.length <= 0) {
                    BUI.Message.Alert("请选择上级会员!");
                    return false;
                }

                this.close();
                customerChoiceEvent(selectedHigherCustomer);
            }
        }, {
            text: '取消选择',
            elCls: 'button button-primary',
            handler: function () {
                this.close();
            }
        }],
        mask: true
    });

    function customerChoiceEvent(selectedHigherCustomer) {
        var userId = $("#userId").val();
        var postData = {userIds: userId};
        if (selectedHigherCustomer.length > 0) {
            postData.parentUserId = selectedHigherCustomer[0].userId;
        }

        $.ajax({
            url: '${ctx}/admin/sa/user/setParentUserId',
            dataType: 'json',
            type: 'POST',
            data: postData,
            success: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("修改成功!");
                }
            }
        });
    }
</script>
</body>
</html>