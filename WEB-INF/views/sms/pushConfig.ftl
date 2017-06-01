<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>

<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <style>
        .inner-block-label{
            margin-left: 15px;;
            display: inline-block;
            width: 500px;
        }
    </style>
</head>
<body>
<div class="form-horizontal">
    <form id="J_Form" action="${ctx}/admin/sa/sms/pushConfig" method="post">
        <div id="tab"></div>
        <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
            <div class="tips-content">
                要使用短信推送.请先接入短信运营商.如需帮助.请联系逸锐售后
            </div>
        </div>

        <#--<a style="float: right;" class="button" href="${ctx}/admin/sa/sms/wildcard/detail"><span>通配符查看</span></a>-->
        <div class="panel">
            <div class="panel-header"><h3>消费者短信</h3></div>
            <div class="panel-body">

                <div class="control-group">
                    <label class="control-label">注册验证：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if normalRegister?? && normalRegister>checked="checked"</#if> type="radio" name="data['sms_register']" value="1"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">开启后将会在用户输入手机号后系统给手机发送一条验证码进行手机验证</label>
                            <a title="短信验证" edit-template="SMS_REGISTER_MSG" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">登录验证：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if normalLogin?? && normalLogin>checked="checked"</#if> type="radio" name="data['sms_login']" value="1"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">开启后将会在用户输入手机号后系统给手机发送一条动态密码进行登录</label>
                            <a title="登录验证" edit-template="SMS_LOGIN_MSG" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                    </div>
                </div>

                </br>
                <div class="control-group">
                    <label class="control-label">订单生成推送信息：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderCreate?? && orderCreate>checked="checked"</#if> type="radio" name="data['sms_order_created']" value="1"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">开启后订单生成之后${(unpayAlterTime)?default(3)}小时消费者未付款则推送提示给消费者督促付款</label>
                            <a title="订单生成短信" edit-template="SMS_ORDER_CREATE_MSG" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderCreate?? && orderCreate)>checked="checked"</#if> type="radio" name="data['sms_order_created']" value="0"/>&nbsp;&nbsp;关闭</label>
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
                </br>
                <div class="control-group">
                    <label class="control-label">已付款通知：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderPay?? && orderPay>checked="checked"</#if> type="radio" name="data['sms_order_pay']" value="1" class="sms_order_pay"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">消费者付款后发送订单已确认信息</label>
                            <a title="已付款通知" edit-template="SMS_ORDER_PAY_MSG" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderPay?? && orderPay)>checked="checked"</#if> type="radio" name="data['sms_order_pay']" value="0" class="sms_order_pay"/>&nbsp;&nbsp;关闭</label>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
                </br>
                <div class="control-group">
                    <label class="control-label">发货通知：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderSend?? && orderSend>checked="checked"</#if> type="radio" name="data['sms_order_send']" value="1" class="sms_order_send"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">订单指派门店后，则消费者收到派单通知</label>
                            <a title="派单通知" edit-template="SMS_ORDER_SEND_MSG" receive-msg="请在确认收货后回复“是”," link-tel="4008008888" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderSend?? && orderSend)>checked="checked"</#if> type="radio" name="data['sms_order_send']" value="0" class="sms_order_send"/>&nbsp;&nbsp;关闭</label>
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
                </br>
                <div class="control-group">
                    <label class="control-label">订单完成：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderCompleted?? && orderCompleted>checked="checked"</#if> type="radio" name="data['sms_order_completed']" value="1" class="sms_order_completed"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">订单变为已收货后，用户将会收到信息</label>
                            <a title="订单完成信息" edit-template="SMS_ORDER_COMPLETE_MSG" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderCompleted?? && orderCompleted)>checked="checked"</#if> type="radio" name="data['sms_order_completed']" value="0" class="sms_order_completed"/>&nbsp;&nbsp;关闭</label>
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="panel">
            <div class="panel-header"><h3>门店端短信</h3></div>
            <div class="panel-body">
                <div class="control-group">
                    <label class="control-label">派单通知：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderSendForStore?? && orderSendForStore>checked="checked"</#if> type="radio" name="data['sms_order_send_for_store']" value="1" class="sms_order_send_for_store"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">订单指派到门店后店长手机号收到信息</label>
                            <a title="门店派单通知" edit-template="SMS_ORDER_SEND_FOR_STORE_MSG" receive-msg="确认请回复“是”.拒绝请回复“否”" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderSendForStore?? && orderSendForStore)>checked="checked"</#if> type="radio" name="data['sms_order_send_for_store']" value="0" class="sms_order_send_for_store"/>&nbsp;&nbsp;关闭</label>
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
                </br>
                <div class="control-group">
                    <label class="control-label">取消订单：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderCancelForStore?? && orderCancelForStore>checked="checked"</#if> type="radio" name="data['sms_order_cancel_for_store']" value="1" class="sms_order_cancel_for_store"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">订单取消后将会发送给订单原指派门店</label>
                            <a title="取消派单" edit-template="SMS_ORDER_CANCEL_FOR_STORE_MSG" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderCancelForStore?? && orderCancelForStore)>checked="checked"</#if> type="radio" name="data['sms_order_cancel_for_store']" value="0" class="sms_order_cancel_for_store"/>&nbsp;&nbsp;关闭</label>
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
                </br>
                <div class="control-group">
                    <label class="control-label">已确认订单：</label>
                    <div class="controls">
                        <div>
                            <label><input <#if orderConfirmForStore?? && orderConfirmForStore>checked="checked"</#if> type="radio" name="data['sms_order_confirm_for_store']" value="1" class="sms_order_confirm_for_store"/>&nbsp;&nbsp;开启</label>
                            <label class="inner-block-label">门店接受订单后.将会发送消息给门店</label>
                            <a title="门店已确认订单通知" edit-template="TEMPLATE_SMS_ORDER_CONFIRM_SEND_FOR_STORE_MSG" receive-msg="请在送达商品后回复“是”,异常情况请回复“否”" link-tel="4008888888" un-check="<#if storeCanConfirmOrder?? && !storeCanConfirmOrder>由于已关闭门店收货权限，开关默认无法启用。</#if>" class="button" href="javascript:;"><span>编辑模板</span></a>
                        </div>
                        <div>
                            <label><input <#if !(orderConfirmForStore?? && orderConfirmForStore)>checked="checked"</#if> type="radio" name="data['sms_order_confirm_for_store']" value="0" class="sms_order_confirm_for_store"/>&nbsp;&nbsp;关闭</label>
                            <label class="inner-block-label"></label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-bar-fixed">
            <div class="actions-bar">
                <div class="form-actions">
                    <button id="save" type="submit" class="button button-large button-primary">保存</button>
                    <button type="reset" class="button button-large">重置</button>
                </div>
            </div>
        </div>
    </form>
</div>
<div id="dialog" class="well" style="display: none;">
    <div class="control-group">
        <label class="control-label"></label>
        <div class="controls">
            <textarea id="template" style="width: 320px;height: 120px;"></textarea>
        </div>
    </div>
    <div class="control-group" id="readOnlyPanel">
        <label class="control-label"><input id="enableReceive" type="checkbox"/>短信回执</label>
        <div class="controls">
            <textarea id="readOnlyContent" readonly="readonly" style="width: 320px;height: 22px;"></textarea>
        </div>
    </div>
    <div class="control-group" id="reveive_panel">
        <label class="control-label">客服联系</label>
        <div class="controls">
            <textarea id="receive" style="width: 320px;height: 44px;"></textarea>
        </div>
    </div>
</div>
<script type="text/javascript">
    BUI.use(["bui/tab", "bui/form", "bui/overlay"], function (Tab, Form, Overlay) {
        var tab = new Tab.Tab({
            render: "#tab",
            elCls: "nav-tabs",
            autoRender: true,
            children: [
                {text: "短信推送", value: "0"}
            ]
        });
        tab.setSelected(tab.getItemAt(0));

        var form = new Form.Form({
            srcNode: "#J_Form",
            submitType: "ajax",
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    setTimeout("remainTime()",1000);
                }
            }
        }).render();

        form.on('beforesubmit', function(){
	    	btn=document.getElementById('save');
			btn.disabled=true;
	    });

        $("[edit-template]").click(function() {
            var key = $(this).attr("edit-template"), title = $(this).attr("title"), receiveMsg = $(this).attr("receive-msg"), linkTel = $(this).attr("link-tel"), unCheckMsg = $(this).attr("un-check");
            $.post("${ctx}/admin/sa/sms/template/findByKey", {key: key}, function(data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    var content = data.data || "";
                    var array = content.split(/\\n/);
                    $("#template").val(array[0] || "");
                    debugger;
                    linkTel = array[2] || (receiveMsg && linkTel && array[1]) || linkTel || "";
                    $("#readOnlyContent").val(receiveMsg);
                    $("#receive").val(linkTel);
                    receiveMsg ? $("#readOnlyPanel").show() : $("#readOnlyPanel").hide();
                    linkTel ? $("#reveive_panel").show() : $("#reveive_panel").hide();
                    if (unCheckMsg) {
                        $("#enableReceive").attr({disabled: true, title: unCheckMsg});
                        $("#enableReceive").attr("checked", false);
                    } else {
                        $("#enableReceive").attr({disabled: false, title: ""});
                        $("#enableReceive").attr("checked", data.receive);
                    }

                }
            });
            new Overlay.Dialog({
                contentId: "dialog",
                title: title || '模板编辑',
                buttons: [{
                    text: '保存',
                    elCls: 'button button-primary',
                    handler: function(){
                        var content = $("#template").val() || "", enableReceive = !!($("#enableReceive:checked").length);
                        if ($("#readOnlyContent").val() && enableReceive) {
                            content += "\\n" + $("#readOnlyContent").val();
                        }
                        if ($("#receive").val()) {
                            content += "\\n" + $("#receive").val();
                        }
                        $.post("${ctx}/admin/sa/sms/template/save", {key: key, value: content, enableReceive: enableReceive}, function(data) {
                            if (app.ajaxHelper.handleAjaxMsg(data)) {
                                app.showSuccess("操作成功！");
                            }
                        });
                        this.close();
                    }
                }, {
                    text:'取消',
                    elCls : 'button button-primary',
                    handler : function(){
                        this.close();
                    }
                }],
                mask:true,
                closeAction : "destroy"
            }).show();
        });
    });
    $(function() {
    	//添加重置按钮的处理
    	$('.actions-bar button[type="reset"]').click(function() {
    		$('.controls input[name="data['+'\'sms_order_created\''+']"][value="0"]').attr("checked",true);
    		$('.controls input[name="data['+'\'sms_order_pay\''+']"][value="0"]').attr("checked",true);
			$('.controls input[name="data['+'\'sms_order_send\''+']"][value="0"]').attr("checked",true);
			$('.controls input[name="data['+'\'sms_order_completed\''+']"][value="0"]').attr("checked",true);
			$('.controls input[name="data['+'\'sms_order_send_for_store\''+']"][value="0"]').attr("checked",true);
			$('.controls input[name="data['+'\'sms_order_cancel_for_store\''+']"][value="0"]').attr("checked",true);
			$('.controls input[name="data['+'\'sms_order_confirm_for_store\''+']"][value="0"]').attr("checked",true);
    	});
    });

    function remainTime(){
        	btn=document.getElementById('save');
			btn.disabled=false;
    }
</script>
</body>
</html>