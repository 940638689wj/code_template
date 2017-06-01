<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <title></title>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="/admin/sa/promotion/guaGuaka/list">${gameName!}</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew>新增<#else>编辑</#if>${gameName!}</li>
    </ul>
<#if isNew>
    <div class="orderstatus clearfix">
        <div class="steps">
            <ul>
                <li class="step-first step-active">
                    <div class="stepind">1</div>
                    <div class="stepname" style="width: 130px;">1.设置${gameName!}规则</div>
                </li>
                <li class="step-last">
                    <div class="stepind">2</div>
                    <div class="stepname" style="width: 130px;">2.设置${gameName!}页面</div>
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
                aria-disabled="false" aria-pressed="false"><span class="bui-tab-item-text">设置${gameName!}规则</span></li>
            <li class="bui-tab-panel-item bui-tab-item" aria-disabled="false" aria-pressed="false">
                <a href="/admin/sa/promotion/guaGuaka/detail?awardId=${(awards.id)!}">
                    <span class="bui-tab-item-text">设置${gameName!}页面</span>
                </a>
            </li>
        </ul>
    </div>
</#if>
    <form id="J_Form" class="form-horizontal" action="/admin/sa/promotion/guaGuaka/edit" method="post">
        <input type="hidden" id="id" name="id" value="${(awards.id)!}"/>
        <input type="hidden" name="gameName" value="${gameName!}"/>
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
                    <label class="control-label">单用户每天最多(次)：</label>
                    <div class="controls">
                        <input value="${(awards.oneDayTimes)!}"
                               name="oneDayTimes" class="input-normal control-text" data-rules="{positiveNum:true}">
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">需达到消费额：</label>
                    <div class="controls">
                        <input value="${(awards.consumeAmt)!}" name="consumeAmt"
                               data-rules="{number:true,positiveNum:true}"
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
                        <input class="calendar calendar-time control-text" name="startTime" data-rules="{required:true}"
                               value="${(awards.startTime)?string('yyyy-MM-dd HH:mm:ss')}">
                    <#else>
                        <input class="calendar calendar-time control-text" name="startTime"
                               data-rules="{required:true}">
                    </#if>
                        <span>至</span>
                    <#if (awards.endTime)?has_content>
                        <input class="calendar calendar-time control-text" name="endTime" data-rules="{required:true}"
                               value="${(awards.endTime)?string('yyyy-MM-dd HH:mm:ss')}">
                    <#else>
                        <input class="calendar calendar-time control-text" name="endTime" data-rules="{required:true}">
                    </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><s>*</s>状态：</label>
                    <div class="controls">
                    <#assign enable = true />
                    <#if (awards.status)?? && awards.status == 0>
                        <#assign enable = false />
                    </#if>
                        <label class="radio">
                            <input type="radio" name="status" value="1" <#if enable>checked="checked" </#if>/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="status" value="0" <#if !enable>checked="checked" </#if>/>禁用
                        </label>
                    </div>
                </div>
            </div>
        <#--<div class="row">-->
        <#--<div class="control-group">-->
        <#--<label class="control-label"><s></s>领奖条件：</label>-->
        <#--<div class="controls">-->
        <#--<input name="shareLimit" value="${(awards.shareLimit)!}"-->
        <#--data-rules="{number:true,positiveNum:true}"-->
        <#--class="control-text" style="width:30px"/>人通过玩家推广链接玩游戏并刮到同样的图案-->
        <#--</div>-->
        <#--</div>-->
        <#--</div>-->
        </div>

        <div class="well">
            <div class="row">送出奖品：</div>
        <#list awardsItemList as item>
            <#assign currWinCnt = item.currWinCount>
            <#if item.name == "积分">
                <div class="row">
                    <div class="control-group">
                        <div class="controls">
                            <input id="pointCk" name="pointCk" checked="checked" type="checkbox"/>
                            <label style="width:40px;" for="pointCk">积分&nbsp;&nbsp;&nbsp;:</label>
                        </div>
                        <div class="controls">
                            <input name="sendPoint" value="${(item.winningValue)!}" data-rules="{number:true}"
                                   class="input-normal control-text" style="width:50px;"
                                   <#if currWinCnt &gt;0>readonly="readonly"</#if>/>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项个数：</label>
                            <input id="countPoint" name="countPoint" value="${(item.count)!}"
                                   data-rules="{required:true,number:true}" class="input-normal control-text"
                                   style="width:60px;" <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项概率：</label>
                            <input id="probabilityPoint" name="probabilityPoint" value="${(item.probability)!}"
                                   data-rules="{required:true,max:100,number:true,countPro:true}"
                                   class="input-normal control-text probabilityCount" style="width:60px;">%
                        </div>
                        <#if currWinCnt &gt;0>
                            <div class="tips-wrap">
                                <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                                    <div class="tips-content">该奖项已有人中奖，只能更改中奖率，不能更改其他设置！</div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            <#elseif item.name == "优惠劵">
                <div class="row">
                    <div class="control-group">
                        <div class="controls">
                            <input name="discountCk" id="discountCk" checked="checked" type="checkbox"/>
                            <label style="width:40px;" for="discountCk">优惠劵:</label>
                        </div>
                        <div class="controls">
                            <input class="control-text" name="offerDName" id="offerDName" readonly="readonly"/>
                            <input class="control-text" name="offerDId" id="offerDId" value="${(item.winningValue)!}"
                                   type="hidden"/>
                            <input id="btnSelectDiscount" class="button" type="button" value="选择优惠劵"
                                   <#if currWinCnt &gt;0>disabled</#if>/>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项个数：</label>
                            <input id="countDiscount" name="countDiscount" value="${(item.count)!}"
                                   data-rules="{required:true,number:true,count_limit:true}"
                                   class="input-normal control-text" style="width:60px;"
                                   <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项概率：</label>
                            <input id="probabilityDiscount" name="probabilityDiscount" value="${(item.probability)!}"
                                   data-rules="{required:true,max:100,number:true,countPro:true}"
                                   class="input-normal control-text probabilityCount" style="width:60px;">%
                        </div>
                        <#if currWinCnt &gt;0>
                            <div class="tips-wrap">
                                <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                                    <div class="tips-content">该奖项已有人中奖，只能更改中奖率，不能更改其他设置！</div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            <#elseif item.name == "红包">
                <div class="row">
                    <div class="control-group">
                        <div class="controls">
                            <input name="redPkgCk" id="redPkgCk" checked="checked" type="checkbox"/>
                            <label style="width:40px;" for="redPkgCk">红包&nbsp;&nbsp;&nbsp;:</label>
                        </div>
                        <div class="controls">
                            <input class="control-text" name="offerRName" id="offerRName" readonly="readonly"/>
                            <input class="control-text" name="offerRId" id="offerRId" value="${(item.winningValue)!}"
                                   type="hidden"/>
                            <input id="btnSelectRedPkg" class="button" type="button" value="选择红包"
                                   <#if currWinCnt &gt;0>disabled</#if>/>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项个数：</label>
                            <input id="countRedPkg" name="countRedPkg" value="${(item.count)!}"
                                   data-rules="{required:true,number:true,count_limit:true}"
                                   class="input-normal control-text" style="width:60px;"
                                   <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项概率：</label>
                            <input id="probabilityRedPkg" name="probabilityRedPkg" value="${(item.probability)!}"
                                   data-rules="{required:true,max:100,number:true,countPro:true}"
                                   class="input-normal control-text probabilityCount" style="width:60px;">%
                        </div>
                        <#if currWinCnt &gt;0>
                            <div class="tips-wrap">
                                <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                                    <div class="tips-content">该奖项已有人中奖，只能更改中奖率，不能更改其他设置！</div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            <#else>
                <div class="row">
                    <div class="control-group">
                        <div class="controls">
                            <input name="productCk" id="productCk" checked="checked" type="checkbox">
                            <label style="width:40px;" for="productCk">奖品&nbsp;&nbsp;&nbsp;:</label>
                        </div>
                        <div class="controls">
                            <input name="nameProduct" value="${(item.winningValue)!}" class="input-normal control-text"
                                   style="width:120px;">
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项个数：</label>
                            <input id="countProduct" name="countProduct" value="${(item.count)!}"
                                   data-rules="{required:true,number:true}" class="input-normal control-text"
                                   style="width:60px;" <#if currWinCnt &gt;0>readonly="readonly"</#if>>
                        </div>
                        <div class="controls">
                            <label class="control-label" style="width: 80px;"><s>*</s>奖项概率：</label>
                            <input id="probabilityProduct" name="probabilityProduct" value="${(item.probability)!}"
                                   data-rules="{required:true,max:100,number:true,countPro:true}"
                                   class="input-normal control-text probabilityCount" style="width:60px;">%
                        </div>

                        <#--<div class="controls">-->
                            <#--<label class="control-label">奖品图片：</label>-->
                            <#--<div class="controls file-btn">-->
                                <#--<button class="button button-small">上传奖品图</button>-->
                                <#--<input id="file_cardBackImage" name="file" type="file" class="inp-file"-->
                                       <#--onchange="javascript:assetChange(this.value,'cardBackImage');">-->
                            <#--</div>-->
                        <#--</div>-->
                        <#--<#assign assetUrl = "">-->
                        <#--<#if (item.itemPicUrl)?has_content>-->
                            <#--<#assign assetUrl =item.itemPicUrl >-->
                        <#--</#if>-->
                        <#--<div class="controls control-row-auto">-->
                            <#--<input type="hidden" id="itemPicUrl" name="itemPicUrl"-->
                                   <#--value="<#if (assetUrl)?has_content>${assetUrl}</#if>"-->
                                   <#--class="input-normal control-text">-->

                        <#--</div>-->
                        <#--<div class="controls control-row-auto">-->
                            <#--<a href="${assetUrl}" title="点击预览">-->
                                <#--<img id="imageView_cardBackImage" src="${assetUrl}" style="height:55px;">-->
                            <#--</a>-->
                        <#--</div>-->
                        <#if currWinCnt &gt;0>
                            <div class="tips-wrap">
                                <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                                    <div class="tips-content">该奖项已有人中奖，只能更改中奖率和奖品图，不能更改其他设置！</div>
                                </div>
                            </div>
                        </#if>
                    </div>
                </div>
            </#if>
        </#list>
            *所有的概率总和不能超过100，即概率为100的情况下，一定会从奖项中抽取到一个奖品。
        </div>
</div>
<div class="actions-bar">
    <button type="submit" class="button button-primary"><#if isNew>下一步<#else>保存</#if></button>
    <button type="reset" class="button">重置</button>
</div>
</form>
</div>
<input type="hidden" id="isNew" name="isNew" value="${isNew?string("true","")}"/>
<script type="text/javascript">
    $(function () {
        var awardsId = $("#id").val(), isNewAdd = $("#isNew").val();
        var dialog, dialog2;
        var Form = BUI.Form;
        Form.Rules.add({
            name: 'count_limit',  //规则名称
            msg: '设置的数量不能大于可用数量:',//默认显示的错误信息
            validator: function (value, baseValue, formatMsg, group) { //验证函数，验证值、基准值、格式化后的错误信息、goup控件
                if (group.get("srcNode").next() && group.get("srcNode").next().text()) {
                    var matcher = group.get("srcNode").next().text().match(/\d+/);
                    if (!isNaN(matcher[0]) && (+matcher[0]) < +value) return formatMsg;
                }
                return false;
            }
        });
        Form.Rules.add({
            name: 'countPro',  //规则名称
            msg: '总的中奖几率不能超过100%',//默认显示的错误信息
            validator: function (value, baseValue, formatMsg, group) { //验证函数，验证值、基准值、格式化后的错误信息、goup控件
                if (!(/(^[0-9]\d*$)/.test(value))) {
                    return "奖项概率必须为正整数!";
                }

                var count = 0;
                $(".probabilityCount").each(function (idx, o) {
                    count += (+o.value);
                });
                if (count > 100) {
                    return formatMsg;
                }
                return false;
            }
        });
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
                    if (isNewAdd) {
                        addNextStep(data);
                    } else {
                        app.showSuccess("信息保存成功！");
                        app.page.open({
                            href: '/admin/sa/promotion/guaGuaka/list'
                        })
                    }
                }
            }
        });
        form.render();
        var Overlay = top.BUI.Overlay;
        $("#btnSelectDiscount").click(function () {
            dialog = new Overlay.Dialog({
                id: "dialog1",
                title: '优惠劵列表',
                width: 1200,
                height: 420,
                loader: {
                    url: '/admin/sa/promotion/coupons/couponOfferDialogList',
                    autoLoad: false, //不自动加载
                    lazyLoad: false //不延迟加载
                },
                buttons: [{
                    text: '选 择',
                    elCls: 'button button-primary',
                    handler: function () {
                        var selectedCouponOffer = top.getSelectedRecords();
                        if (selectedCouponOffer) {
                            $("#offerDId").val(selectedCouponOffer[0].promotionId).change();
                            $("#offerDName").val(selectedCouponOffer[0].promotionName);
                        }
                        this.close();
                    }
                }],
                mask: true,
                closeAction: "destroy"
            });
            dialog.get("loader").load({choiceType: "radio", timeStamp: new Date()});
            dialog.show();
        });
        $("#btnSelectRedPkg").click(function () {
            dialog2 = new Overlay.Dialog({
                id: "dialog2",
                title: '红包列表',
                width: 1000,
                height: 420,
                loader: {
                    url: '/admin/sa/promotion/redPacket/redOfferDialogList',
                    autoLoad: false, //不自动加载
                    lazyLoad: false //不延迟加载
                },
                buttons: [{
                    text: '选 择',
                    elCls: 'button button-primary',
                    handler: function () {
                        var selectedCouponOffer = top.getSelectedRecordsRedPkg();
                        if (selectedCouponOffer) {
                            $("#offerRId").val(selectedCouponOffer[0].promotionId).change();
                            $("#offerRName").val(selectedCouponOffer[0].promotionName);
                        }
                        this.close();
                    }
                }],
                mask: true,
                closeAction: "destroy"
            });
            dialog2.get("loader").load({choiceType: "radio", timeStamp: new Date()});
            dialog2.show();
        });
        function addNextStep(data) {
            app.page.open({
                href: '${ctx}/admin/sa/promotion/guaGuaka/detail?isAddNew=1&awardId=' + data.id
            });
        }

        var bindEvent = function () {
            this.checked = true;
            return BUI.Message.Alert("默认都是中奖项，不可去除勾选，不想让用户中奖可以设置中奖率或中奖个数为0");
        };
        $(".well :checkbox").change(bindEvent);
        var bindEvent2 = function () {
            var _this = this;
            $.post("/admin/sa/promotion/guaGuaka/countCode", {offerId: _this.value}, function (data) {
                var msg = $(_this).parent().next().find('.msg_count');
                msg && msg.remove();
                if (data.count < 0) {
                    $(_this).parent().next().append("<label class='msg_count'>[没有可用数量" + 0 + "]</label>");
                } else {
                    $(_this).parent().next().append("<label class='msg_count'>[可用数量:" + (data.count || 0) + "]</label>");
                }
            });
        };
        $("#offerDId,#offerRId").change(bindEvent2).each(function () {
            var _this = this;
            if (!this.value) return;
            $.post("/admin/sa/promotion/guaGuaka/countCode", {offerId: _this.value}, function (data) {
                data.name && $("#" + _this.id.replace("Id", "Name")).val(data.name);
            });
        });
        var offerDId = $("#offerDId").val();
        if (offerDId != null && offerDId != "") {
            $("#offerDId").trigger("change");
        }
        var offerRId = $("#offerRId").val();
        if (offerRId != null && offerRId != "") {
            $("#offerRId").trigger("change");
        }
    });


    function assetChange(fileName, lastFlag) {
        if (fileName == null || fileName.trim().length <= 0) {
            BUI.Message.Alert("请选择文件!");
            return false;
        }
        var suffixIndex = fileName.lastIndexOf('.');
        if (suffixIndex <= 0) {
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        var suffix = fileName.substr(suffixIndex + 1);
        if (suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())) {
            BUI.Message.Alert("文件格式错误!");
            return false;
        }
        $.ajaxFileUpload({
            url: '${ctx}/common/staticAsset/upload/awardsItem',
            secureuri: false,
            fileElementId: "file_" + lastFlag,
            dataType: "json",
            method: 'post',
            success: function (data, status) {
                loadImage(data.displayAssetUrl, data.assetUrl, lastFlag);
            },
            error: function (data, status, e) {
                BUI.Message.Alert("上传失败" + e);
            }
        });
        return false;
    }

    //设置预览
    function loadImage(url, assetUrl, lastFlag) {
        $('#itemPicUrl').val(assetUrl);
        $("#imageView_" + lastFlag).attr("src", assetUrl);
    }
    //删除图片
    function delItem() {
        $('#itemPicUrl').val(' ');
        $('#imageView_cardBackImage').attr('src', "");
    }
</script>
</body>
</html>