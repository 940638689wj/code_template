<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
    <title></title>

    <script type="text/javascript">
        var awardsId = '${(awards.id)!""}';
        var isNewAdd = ${isNew?string("true","false")};
        var couponDialog = null;
        var userDialog = null;
        var awardsItemIdForChoiceCouponOffer;
        var awardsItemIdForChoiceUser;

        $(function () {
            var Form = BUI.Form;
            Form.Rules.add({
                name: 'positiveNum',  //规则名称
                msg: '请输入正整数!',//默认显示的错误信息
                validator: function (value, baseValue, formatMsg, group) { //验证函数，验证值、基准值、格式化后的错误信息、goup控件
                    if (!(/^(0|\+?[1-9][0-9]*)$/.test(value))) {
                        return formatMsg;
                    }
                    return false;
                }
            });


            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        if (isNewAdd) { //新增，保存完成之后，进入下一步：页面配置
                            addNextStep(data);
                        } else { //若为编辑，保存完成之后，保留原页面，提示保存成功
                            editSaveSuccess(data);
                        }
                    }
                }
            });

            form.on('beforesubmit', function () {
                return collectData();
            });

            form.render();

            //初始化类别之后的按钮单击之后，能够弹出对话框，列出优惠券列表
            var Overlay = BUI.Overlay;
            couponDialog = new Overlay.Dialog({
                title: '优惠劵列表',
                width: 1000,
                height: 380,
                loader: {
                    url: '${ctx}/admin/sa/promotion/coupons/couponOfferDialogList',
                    autoLoad: false, //不自动加载
                    lazyLoad: false //不延迟加载
                },
                buttons: [{
                    text: '选 择',
                    elCls: 'button button-primary',
                    handler: function () {
                        this.close();
                        couponOfferChoiceEvent(getSelectedRecords());
                    }
                }],
                mask: true
            });

            //初始化类别之后选中指定中奖人，能够弹出对话框，列出会员列表
            var Overlay = BUI.Overlay
            userDialog = new Overlay.Dialog({
                title: '会员列表',
                width: 1000,
                height: 380,
                loader: {
                    url: '${ctx}/admin/sa/user/productDialog/list',
                    autoLoad: false, //不自动加载
                    lazyLoad: false //不延迟加载
                },
                buttons: [{
                    text: '选 择',
                    elCls: 'button button-primary',
                    handler: function () {
                        this.close();
                        userChoiceEvent(getSelected());
                    }
                }],
                mask: true
            });

            initWinFlagEvent();
            initUsePointFlagEvent();
            initCouponFlagEvent();
            initCouponOfferChoiceEvent();
            initUserFlagEvent();
            initUserChoiceEvent();
        });

        function addNextStep(data) {
            app.page.open({
                href: '/admin/sa/promotion/awardsOffer/detail?awardId=' + data.data + '&isAddNew=1'
            });
        }

        <#--优惠券弹出框中选择操作-->
        function couponOfferChoiceEvent(selectedCouponOffer) {
            var index = awardsItemIdForChoiceCouponOffer.split("_")[1];
            var couponOfferIdHidden = $("#couponOfferId_" + index);
            var couponOfferNameLabel = $("#couponOfferName_" + index);
            if (selectedCouponOffer.length > 0) {
                var couponOfferId = selectedCouponOffer[0].promotionId;
                couponOfferIdHidden.val(couponOfferId);
                var couponOfferName = selectedCouponOffer[0].promotionName;
                couponOfferNameLabel.text(couponOfferName);
            } else {
                couponOfferIdHidden.val("");
                couponOfferNameLabel.text("未选择优惠劵!");
            }
        }

        <#--指定中奖人弹出框中选择操作-->
        function userChoiceEvent(selectedUser) {
            var index = awardsItemIdForChoiceUser.split("_")[1];
            var userIdHidden = $("#userIds_" + index)
            if (selectedUser.length > 0) {
                var userIds = "";
                for (var i = 0; i < selectedUser.length; i++) {
                    if (i == 0) {
                        userIds += selectedUser[i].userId;
                    } else {
                        userIds += "," + selectedUser[i].userId;
                    }
                }
                userIdHidden.val(userIds);
            } else {
                userIdHidden.val("");
            }
        }

        function editSaveSuccess(data) {
            app.showSuccess("信息保存成功！");
            app.page.open({
                href: '/admin/sa/promotion/awardsOffer/list'
            })
        }

        function collectData() {
            var totalRating = 0;
            var success = true;
            $(".winningFlagClass").each(function (index, obj) {
                var curObjId = $(obj).attr("id");
                var curTemp = curObjId.split("_")[1];
                var countObj = $("#count_" + curTemp);
                var ratingObj = $("#probability_" + curTemp);
                var usePointObj = $("#usePointFlagHidden_" + curTemp);
                var couponObj = $("#couponFlagHidden_" + curTemp);
                var userObj = $("#userFlagHidden_" + curTemp);
                var checkVal = $(obj).attr("checked");
                if (checkVal || checkVal == "checked") {
                    var countVal = 0;
                    var checkedCount = 0;
                    try {
                        countVal = parseInt(countObj.val());
                        if (isNaN(countVal)) {
                            BUI.Message.Alert("奖项个数格式不规范!");
                            success = false;
                            return false;
                        }
                    } catch (ex) {
                        BUI.Message.Alert("奖项个数格式不规范!");
                        success = false;
                        return false;
                    }

                    var ratingVal = 0;
                    try {
                        ratingVal = parseFloat(ratingObj.val());
                        if (isNaN(ratingVal)) {
                            BUI.Message.Alert("奖项概率格式不规范!");
                            success = false;
                            return false;
                        }
                        if (!(/(^[1-9]\d*$)/.test(ratingVal))) {
                            BUI.Message.Alert("奖项概率必须为正整数!");
                            success = false;
                            return false;
                        }
                    } catch (ex) {
                        BUI.Message.Alert("奖项概率格式不规范!");
                        success = false;
                        return false;
                    }

                    totalRating += ratingVal;

                    var usePointFlagValue = usePointObj.val();
                    var couponFlagValue = couponObj.val();
                    var userFlagValue = userObj.val();

                    if (usePointFlagValue == "1") {
                        checkedCount++;
                        var usePointAmountValue = $("#usePointAmount_" + curTemp).val();
                        usePointAmountValue = usePointAmountValue.replace(/^\s\s*/, '').replace(/\s\s*$/, '');
                        if (!(/(^[1-9]\d*$)/.test(usePointAmountValue))) {
                            BUI.Message.Alert("积分奖励必须为正整数!");
                            success = false;
                            return false;
                        }
                    }

                    if (couponFlagValue == "1") {
                        checkedCount++;
                        //验证优惠劵的ID是否存在
                        var couponOfferId = $("#couponOfferId_" + curTemp).val();
                        if (!(/(^[1-9]\d*$)/.test(couponOfferId))) {
                            BUI.Message.Alert("请选择优惠劵奖励!");
                            success = false;
                            return false;
                        }
                    }

                    if (userFlagValue == "1") {
                        //验证userIds是否存在
                        if (!$("#userIds_" + curTemp).val()) {
                            BUI.Message.Alert("请选择指定中奖人!");
                            success = false;
                            return false;
                        }
                    }

                    if (checkedCount > 1) {
                        BUI.Message.Alert("奖项最多只能设置一项!");
                        success = false;
                        return false;
                    }
                }
            });

            if (!success) {
                return success;
            }

            if (totalRating > 100) {
                BUI.Message.Alert("所有奖项概率之和不能超过100!");
                return false;
            }

            return true;

        }
        <#--是否中奖的操作-->
        function initWinFlagEvent() {
            $(".winningFlagClass").on("change", function () {
                var winFlag = $(this).attr("checked");
                var objId = $(this).attr("id");
                var objHidden = $("#winningFlagHidden_" + objId.split("_")[1]);
                var controlObjArray = $($(this).parent().parent().parent().find(".controls"));
                if (winFlag || winFlag == "checked") {
                    $(controlObjArray[3]).show();
                    $(controlObjArray[4]).show();
                    $(controlObjArray[5]).show();
                    $(controlObjArray[6]).show();
                    $(controlObjArray[7]).show();
                    $(controlObjArray[8]).show();
                    $(controlObjArray[9]).show();
                    objHidden.val("1");
                } else {
                    $(controlObjArray[3]).hide();
                    $(controlObjArray[4]).hide();
                    $(controlObjArray[5]).hide();
                    $(controlObjArray[6]).hide();
                    $(controlObjArray[7]).hide();
                    $(controlObjArray[8]).hide();
                    $(controlObjArray[9]).hide();
                    objHidden.val("0");
                }
            });
        }

        <#--选择积分操作-->
        function initUsePointFlagEvent() {
            $(".usePointFlagClass").on('change', function () {
                var winFlag = $(this).attr("checked");
                var winFlagCheckId = $(this).attr("id");
                var tempIndex = winFlagCheckId.split("_")[1];
                var usePointFlagObjHidden = $("#usePointFlagHidden_" + tempIndex);
                var usePointAmountObj = $("#usePointAmount_" + tempIndex);

                if (winFlag || winFlag == "checked") {
                    usePointAmountObj.show();
                    usePointFlagObjHidden.val("1");
                } else {
                    usePointAmountObj.hide();
                    usePointFlagObjHidden.val("0");
                }
            });
        }

        <#--选择优惠券操作-->
        function initCouponFlagEvent() {
            $(".couponFlagClass").on("change", function () {
                var checkFlag = $(this).attr("checked");
                var objId = $(this).attr("id");
                var objHidden = $("#couponFlagHidden_" + objId.split("_")[1]);
                var couponOfferChoiceBtn = $("#couponOfferChoiceBtn_" + objId.split("_")[1]);
                var couponOfferIdHidden = $("#couponOfferId_" + objId.split("_")[1]);
                var couponOfferNameLabel = $("#couponOfferName_" + objId.split("_")[1]);
                if (checkFlag || checkFlag == "checked") {
                    couponOfferChoiceBtn.show();
                    couponOfferIdHidden.val("");
                    couponOfferNameLabel.text("未选择优惠劵!");
                    couponOfferNameLabel.show();
                    objHidden.val("1");
                } else {
                    couponOfferChoiceBtn.hide();
                    couponOfferNameLabel.hide();
                    objHidden.val("0");
                }
            });
        }

        <#--弹出优惠券列表-->
        function initCouponOfferChoiceEvent() {
            $(".couponOfferChoiceBtn").on('click', function () {
                var id = $(this).attr("id");
                awardsItemIdForChoiceCouponOffer = id;
                var params = { //配置初始请求的参数
                    choiceType: 'radio',
                };
                couponDialog.get('loader').load(params);
                couponDialog.show();
            });
        }

        <#--选择指定中奖人操作-->
        function initUserFlagEvent() {
            $(".userFlagClass").on("change", function () {
                var checkFlag = $(this).attr("checked");
                var objId = $(this).attr("id");
                var objHidden = $("#userFlagHidden_" + objId.split("_")[1]);
                var userChoiceBtn = $("#userChoiceBtn_" + objId.split("_")[1]);
                var userIdsHidden = $("#userIds_" + objId.split("_")[1]);
                userIdsHidden.val("");
                if (checkFlag || checkFlag == "checked") {
                    userChoiceBtn.show();
                    objHidden.val("1");
                <#--弹出指定中奖人列表-->
                    var id = $(this).attr("id");
                    awardsItemIdForChoiceUser = id;
                    var params = {};
                    userDialog.get('loader').load(params);
                    $('.bui-stdmod-footer').show();//显示“选择”按钮
                    userDialog.show();
                } else {
                    userChoiceBtn.hide();
                    objHidden.val("0");
                }
            });
        }

        <#--弹出指定中奖人列表-->
        function initUserChoiceEvent() {
            $(".userChoiceBtn").on('click', function () {
                var id = $(this).attr("id");
                var index = id.split("_")[1];
                var userIds = $("#userIds_" + index).val();
                if (!userIds) {
                    BUI.Message.Alert("您还未选择指定中奖人！" + userIds);
                    return;
                }
                var params = { //配置初始请求的参数
                    in_id: userIds
                };
                userDialog.get('loader').load(params);
                userDialog.show();
                $('.bui-stdmod-footer').hide();//隐藏“选择”按钮
            });
        }

        <#--跳转到下个页面的操作-->
        function goToTabTwo() {
            window.location.href = "detail?awardId=" + awardsId;
        }

        <#--上传图片操作-->
        function assetChange(fileName, fileImageId, hidId) {
            if (fileName == null || fileName.trim().length <= 0) {
                BUI.Message.Alert("请选择文件！");
                return false;
            }

            var suffixIndex = fileName.lastIndexOf('.');
            if (suffixIndex <= 0) {
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            var suffix = fileName.substr(suffixIndex + 1);
            if (suffix.trim().length <= 0 || ("jpg" != suffix.trim() && "JPG" != suffix.trim() && "png" != suffix.trim() && "PNG" != suffix.trim())) {
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            $.ajaxFileUpload({
                url: '${ctx}/common/staticAsset/upload/awardsItem',
                secureuri: false,
                fileElementId: fileImageId,
                dataType: "json",
                method: 'post',
                success: function (data, status) {
                    loadImage(data.adminDisplayAssetUrl, data.assetUrl, hidId);
                },
                error: function (data, status, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(url, assetUrl, hidId) {
            $('#' + hidId).val(assetUrl);
            $("#show_" + hidId).attr("src", assetUrl);
            $("#show_" + hidId).show();
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list">转盘</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew == true>新加转盘<#else>编辑转盘</#if></li>
    </ul>
<#if isNew == true>
    <div class="orderstatus clearfix">
        <div class="steps">
            <ul>
                <li class="step-first step-active">
                    <div class="stepind">1</div>
                    <div class="stepname">1.设置转盘规则</div>
                </li>
                <li class="step-last">
                    <div class="stepind">2</div>
                    <div class="stepname">2.设置转盘页面</div>
                </li>
            </ul>
        </div>
    </div>
<#else>
    <div id="tab">
        <ul class="bui-tab-panel bui-tab nav-tabs bui-tab-panel-hover bui-tab-hover" aria-disabled="false"
            style="width: 800px;" aria-pressed="false">
            <li onclick="javascript:void(0);"
                class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover"
                aria-disabled="false" aria-pressed="false"><span class="bui-tab-item-text">设置转盘规则</span></li>
            <li onclick="javascript:goToTabTwo();" class="bui-tab-panel-item bui-tab-item" aria-disabled="false"
                aria-pressed="false"><span class="bui-tab-item-text">设置转盘页面</span></li>
        </ul>
    </div>
</#if>
    <form id="J_Form" class="form-horizontal" action="edit" method="post">
        <input type="hidden" name="id" value="${(awards.id)!}"/>
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>名称：</label>
                    <div class="controls">
                        <input value="${(awards.title)!?html}" name="title" data-rules="{required:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">需使用积分：</label>
                    <div class="controls">
                        <input value="${(awards.usePoint)!}" name="usePoint" data-rules="{positiveNum:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">单用户每天最多：</label>
                    <div class="controls">
                        <input value="${(awards.oneDayTimes)!}" name="oneDayTimes" data-rules="{positiveNum:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">需达到消费额：</label>
                    <div class="controls">
                        <input value="${(awards.consumeAmt)!}" name="consumeAmt" data-rules="{positiveNum:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">分享送积分币值：</label>
                    <div class="controls">
                        <input value="${(awards.recommendPoint)!}" name="recommendPoint" data-rules="{positiveNum:true}"
                               class="input-normal control-text">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">有效日期：</label>
                    <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                    <#if (awards.startTime)?has_content>
                        <input type="text" class="calendar control-text" name="startTime" data-rules="{required:true}"
                               value="${(awards.startTime)?string('yyyy-MM-dd')}">
                    <#else>
                        <input type="text" class="calendar control-text" name="startTime" data-rules="{required:true}"
                               value="">
                    </#if>
                        <span>至</span>
                    <#if (awards.endTime)?has_content>
                        <input type="text" class="calendar control-text" name="endTime" data-rules="{required:true}"
                               value="${(awards.endTime)?string('yyyy-MM-dd')}">
                    <#else>
                        <input type="text" class="calendar control-text" name="endTime" data-rules="{required:true}"
                               value="">
                    </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>状态：</label>
                <#assign radioValue="1"/>
                <#if awards?? && awards?has_content && awards.status == 0>
                    <#assign radioValue="0"/>
                </#if>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="status" value="1" <#if radioValue=="1">checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="status" value="0" <#if radioValue=="0">checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <div class="well">
        <#if isNew == false>
            <#assign temp = 0>
            <#list awardsItemList as item>
                <input type="hidden" name="item_${temp}" value="${item.id}">
                <#if item_index=0>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:40px;">${(item.seq)?default(temp)}:</label>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项内容：</label><label
                                    class="control-label" style="width: 176px;text-align: left;">谢谢参与</label><input
                                    value="谢谢参与" name="name_${temp}" data-rules="{required:true}"
                                    class="input-normal control-text" style="width:160px;" type="hidden">
                            </div>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项提示：</label><input
                                    value="${(item.tip)!?html}" name="tip_${temp}" data-rules="{required:true}"
                                    class="input-normal control-text" style="width:160px;">
                            </div>
                            <#assign defaultWin = "0">
                            <#assign defaultHide = "style=\"display: none;\"">
                            <div class="controls">
                                <label class="checkbox"><s style="color: red;">系统默认未中奖项</s></label>
                                <input type="hidden" id="winningFlagHidden_${temp}" name="winningFlag_${temp}"
                                       value="0">
                            </div>
                        </div>
                    </div>
                <#else>
                    <#assign currWinCnt = item.currWinCount>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:40px;">${(item.seq)?default(temp)}:</label>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项内容：</label><input
                                    value="${(item.name)!?html}" name="name_${temp}" data-rules="{required:true}"
                                    class="input-normal control-text" style="width:160px;"
                                    <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                            </div>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项提示：</label><input
                                    value="${(item.tip)!?html}" name="tip_${temp}" data-rules="{required:true}"
                                    class="input-normal control-text" style="width:160px;"
                                    <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                            </div>

                            <#assign defaultWin = "0">
                            <#assign defaultHide = "style=\"display: none;\"">
                            <#if ((item.winningFlag)! == 1)>
                                <#assign defaultWin = "1">
                                <#assign defaultHide = "">
                            </#if>
                            <div class="controls">
                                <label class="checkbox">
                                    <input class="winningFlagClass" id="winningFlagBox_${temp}"
                                           value='1' type="checkbox"
                                           <#if defaultWin == "1">checked="checked"</#if>>是否中奖
                                </label>
                                <input type="hidden" id="winningFlagHidden_${temp}" name="winningFlag_${temp}"
                                       value="${defaultWin}">
                            </div>

                            <#assign assetUrl = "">
                            <#if (item.itemPicUrl)?has_content>
                                <#assign assetUrl =item.itemPicUrl >
                            </#if>
                            <#--<div class="controls" ${defaultHide}>-->
                                <#--<input type="hidden" id="itemPicUrl_${(temp)!}" name="itemPicUrl_${(temp)!}"-->
                                       <#--value="<#if (assetUrl)?has_content>${assetUrl}</#if>"-->
                                       <#--class="input-normal control-text">-->
                                <#--<div class="file-btn">-->
                                    <#--<button class="button button-small">上传奖品图</button>-->
                                    <#--<input style="width: 120px;" id="file_${(temp)!}" name="file" type="file"-->
                                           <#--class="inp-file"-->
                                           <#--onChange="assetChange(this.value,'file_${(temp)!}','itemPicUrl_${(temp)!}')">-->
                                <#--</div>-->
                                <#--<img id="show_itemPicUrl_${(temp)!}" src="<#if (assetUrl)?has_content>${assetUrl}</#if>"-->
                                     <#--style="height:55px;<#if !(assetUrl)?has_content>display: none;</#if>"/>-->
                            <#--</div>-->

                            <div class="controls" ${defaultHide}>
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项个数：</label>
                                <input value="${(item.count)!}" id="count_${temp}" name="count_${temp}"
                                       class="input-normal control-text" style="width:60px;"
                                       <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项概率：</label><input
                                    value="${(item.probability)!}" id="probability_${temp}" name="probability_${temp}"
                                    class="input-normal control-text probabilityCount" style="width:60px;">%
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="control-label" style="width: 100px;"><s>*</s>单用户最多：</label><input
                                    value="${(item.oneUserMax)?default(0)!}" id="oneUserMax_${temp}"
                                    name="oneUserMax_${temp}" class="input-normal control-text" style="width:20px;"
                                    <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                            </div>
                            <div class="controls" ${defaultHide}>
                                <#assign defaultUsePointFlagValue = "0">
                                <#if (item.usePointFlag)?? && (item.usePointFlag) == true>
                                    <#assign defaultUsePointFlagValue = "1">
                                </#if>
                                <label class="checkbox">
                                    <input class="usePointFlagClass" id="usePointFlagBox_${temp}"
                                           value='${defaultUsePointFlagValue}'
                                           <#if (item.usePointFlag)?? && (item.usePointFlag) == true>checked="checked"</#if>
                                           type="checkbox" <#if currWinCnt &gt;0>disabled</#if>>送积分</label>
                                <input type="hidden" id="usePointFlagHidden_${temp}" name="usePointFlag_${temp}"
                                       value="${defaultUsePointFlagValue}">
                                <input type="text" class="control-text" id="usePointAmount_${temp}"
                                       name="usePointAmount_${temp}"
                                       style="<#if !((item.usePointFlag)?? && (item.usePointFlag) == true)> display: none; </#if>width:60px;"
                                       value="${(item.usePointAmount)!}"
                                       <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                            </div>
                            <div class="controls" ${defaultHide}>
                                <#assign defaultCouponFlagValue = "0">
                                <#if (item.couponFlag)?? && (item.couponFlag) == true>
                                    <#assign defaultCouponFlagValue = "1">
                                </#if>
                                <label class="checkbox">
                                    <input class="couponFlagClass" id="couponFlagBox_${temp}"
                                           value='${defaultCouponFlagValue}'
                                           <#if (item.couponFlag)?? && (item.couponFlag) == true>checked="checked"</#if>
                                           type="checkbox" <#if currWinCnt &gt;0>disabled</#if>>优惠卷</label>
                                <input type="hidden" id="couponFlagHidden_${temp}" name="couponFlag_${temp}"
                                       value="${defaultCouponFlagValue}">
                                <input type="button" class="couponOfferChoiceBtn" id="couponOfferChoiceBtn_${temp}"
                                       name="couponOfferChoiceBtn" value="选择优惠劵"
                                       style="<#if !((item.couponFlag)?? && (item.couponFlag) == true)>display: none;</#if>"
                                       <#if currWinCnt &gt;0>disabled</#if>>
                                <input type="hidden" id="couponOfferId_${temp}" name="couponOfferId_${temp}"
                                       value="${(item.couponDTO.promotionId)!}">
                                <#if !((item.couponFlag)?? && (item.couponFlag) == true)>
                                    <label id="couponOfferName_${temp}" style="display: none;">未选择优惠劵!</label>
                                <#else>
                                    <label id="couponOfferName_${temp}">${(item.couponDTO.promotionName)!}</label>
                                </#if>
                            </div>

                            <div class="controls" ${defaultHide}>
                                <#assign defaultUserFlagValue = "0">
                                <#if (item.userIds)?? && (item.userIds)?has_content>
                                    <#assign defaultUserFlagValue = "1">
                                </#if>
                                <label class="checkbox">
                                    <input class="userFlagClass" id="userFlagBox_${temp}" value='' type="checkbox"
                                           <#if defaultUserFlagValue == "1">checked="checked"</#if>
                                           <#if currWinCnt &gt;0>disabled</#if>>指定中奖人</label>
                                <input type="hidden" id="userFlagHidden_${temp}" name="userFlag_${temp}"
                                       value="${defaultUserFlagValue}">
                                <input type="button" class="userChoiceBtn" id="userChoiceBtn_${temp}"
                                       name="userChoiceBtn" value="查看指定中奖人" <#if defaultUserFlagValue == "0">
                                       style="display: none;" </#if>>
                                <input type="hidden" id="userIds_${temp}" name="userIds_${temp}"
                                       value="${(item.userIds)!}">
                            </div>
                        <#--<div class="controls" ${defaultHide}>
                            <label class="control-label" style="width: 80px;">获取地址：</label><input value="${(item.couponAddress)!}" name="couponAddress_${temp}"  class="input-normal control-text" style="width:160px;">
                        </div>-->
                            <#if currWinCnt &gt;0>
                                <div class="controls" ${defaultHide}>
                                    <div class="tips-wrap">
                                        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                                            <div class="tips-content">该奖项已有人中奖，只能更改中奖率和单用户最多中奖数，不能更改其他设置！</div>
                                        </div>
                                    </div>
                                </div>
                            </#if>
                        </div>

                    </div>
                </#if>
                <#assign temp = temp + 1>
            </#list>
        <#else>
            <#list 1..12 as i>
                <#if i=1>
                <#--系统默认为中奖项不展示-->
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:40px;">${i}:</label>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;">奖项内容：</label>
                                <label class="control-label" style="width: 176px;text-align: left;">谢谢参与</label>
                                <input value="谢谢参与" name="name_${i}" data-rules="{required:true}"
                                       class="input-normal control-text" style="width:160px;" type="hidden">
                            </div>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项提示：</label><input value=""
                                                                                                              name="tip_${i}"
                                                                                                              data-rules="{required:true}"
                                                                                                              class="input-normal control-text"
                                                                                                              style="width:160px;">
                            </div>
                            <#assign defaultWin = "0">
                            <#assign defaultHide = "style=\"display: none;\"">
                            <div class="controls">
                                <label class="checkbox"><s style="color: red;">系统默认未中奖项</s></label>
                                <input type="hidden" id="winningFlagHidden_${i}" name="winningFlag_${i}" value="0">
                            </div>
                        </div>
                    </div>
                <#else>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="width:40px;">${i}:</label>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项内容：</label>
                                <input value=""
                                       name="name_${i}"
                                       data-rules="{required:true}"
                                       class="input-normal control-text"
                                       style="width:160px;">
                            </div>
                            <div class="controls">
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项提示：</label>
                                <input value=""
                                       name="tip_${i}"
                                       data-rules="{required:true}"
                                       class="input-normal control-text"
                                       style="width:160px;">
                            </div>

                            <#assign defaultWin = "0">
                            <#assign defaultHide = "style=\"display: none;\"">
                            <div class="controls">
                                <label class="checkbox">
                                    <input class="winningFlagClass" id="winningFlagBox_${i}"
                                           value='1' type="checkbox"
                                           <#if defaultWin == "1">checked="checked"</#if>>是否中奖</label>
                                <input type="hidden" id="winningFlagHidden_${i}" name="winningFlag_${i}"
                                       value="${defaultWin}">
                            </div>

                            <#assign assetUrl = "">
                            <#--<div class="controls" ${defaultHide}>-->
                                <#--<input type="hidden" id="itemPicUrl_${(i)!}" name="itemPicUrl_${(i)!}"-->
                                       <#--value="<#if (assetUrl)?has_content>${assetUrl}</#if>"-->
                                       <#--class="input-normal control-text">-->
                                <#--<div class="file-btn">-->
                                    <#--<button class="button button-small">上传奖品图</button>-->
                                    <#--<input style="width: 120px;" id="file_${(i)!}" name="file" type="file"-->
                                           <#--class="inp-file"-->
                                           <#--onChange="assetChange(this.value,'file_${(i)!}','itemPicUrl_${(i)!}')">-->
                                <#--</div>-->
                                <#--<img id="show_itemPicUrl_${(i)!}" style="height:55px;display: none;"/>-->
                            <#--</div>-->

                            <div class="controls" ${defaultHide}>
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项个数：</label>
                                <input value=""
                                       id="count_${i}"
                                       name="count_${i}"
                                       class="input-normal control-text"
                                       style="width:60px;">
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="control-label" style="width: 80px;"><s>*</s>奖项概率：</label>
                                <input value=""
                                       id="probability_${i}"
                                       name="probability_${i}"
                                       class="input-normal control-text"
                                       style="width:60px;">%
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="control-label" style="width: 100px;"><s>*</s>单用户最多：</label>
                                <input value="0" id="oneUserMax_${i}" name="oneUserMax_${i}"
                                       class="input-normal control-text" style="width:20px;">
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="checkbox"><input class="usePointFlagClass" id="usePointFlagBox_${i}"
                                                               value='' type="checkbox">送积分</label>
                                <input type="hidden" id="usePointFlagHidden_${i}" name="usePointFlag_${i}" value="0">
                                <input type="text" id="usePointAmount_${i}" class="control-text"
                                       name="usePointAmount_${i}" style="display: none;width:60px;" value="">
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="checkbox"><input class="couponFlagClass" id="couponFlagBox_${i}" value=''
                                                               type="checkbox">优惠卷</label>
                                <input type="hidden" id="couponFlagHidden_${i}" name="couponFlag_${i}" value="0">
                                <input type="button" class="couponOfferChoiceBtn" id="couponOfferChoiceBtn_${i}"
                                       name="couponOfferChoiceBtn" value="选择优惠劵" style="display: none;">
                                <input type="hidden" id="couponOfferId_${i}" name="couponOfferId_${i}" value="">
                                <label id="couponOfferName_${i}" style="display: none;">未选择优惠劵!</label>
                            </div>
                            <div class="controls" ${defaultHide}>
                                <label class="checkbox">
                                    <input class="userFlagClass" id="userFlagBox_${i}" value=''
                                           type="checkbox">指定中奖人</label>
                                <input type="hidden" id="userFlagHidden_${i}" name="userFlag_${i}" value="0">
                                <input type="button" class="userChoiceBtn" id="userChoiceBtn_${i}" name="userChoiceBtn"
                                       value="查看指定中奖人" style="display: none;">
                                <input type="hidden" id="userIds_${i}" name="userIds_${i}" value="">
                            </div>
                        <#--<div class="controls" ${defaultHide}>
                            <label class="control-label" style="width: 80px;">获取地址：</label><input value="" name="couponAddress_${i}"  class="input-normal control-text" style="width:160px;">
                        </div>-->
                        </div>
                    </div>
                </#if>
            </#list>
        </#if>
        </div>
        <div class="actions-bar">
            <button type="submit" class="button button-primary"><#if isNew>下一步<#else>保存</#if></button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
</div>
</body>
</html>