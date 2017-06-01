<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                dataType: 'Json',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("配置信息保存成功！");
                        app.page.open({
                            id: 'setting:wx_config'
                        });
                    }
                }
            });

            form.on('beforesubmit', function(){
                var configType=$("input[name='configTypeActive']:checked").val();

                var shopQrCode=$("input[name='weixin_create_wx_shop_qrcode_config']:checked").val();
                var lowerQrCode=$("input[name='weixin_create_wx_lower_qrcode_config']:checked").val();


                if(shopQrCode=="1" && configType=="false"){
                    BUI.Message.Alert("开启 微信会员微店店铺的二维码 必须开启微信运营!");
                    return false;
                }
                if(lowerQrCode=="1" && configType=="false"){
                    BUI.Message.Alert("开启 微信推广会员下线注册的二维码 必须开启微信运营!");
                    return false;
                }
            });
            form.render();
        });

		//重置Token
		function resetToken(){
            BUI.Message.Confirm('确认要重置Token吗?',function(){
                $.post('${ctx}/admin/sa/wechat/resetToken',function(data) {
                    $("#submitbtn").removeAttr("disabled");
                    if (data.result == "true") {
                        app.showSuccess("设置成功!");
                        app.page.open({
                            id: 'setting:wx_config'
                        });
                    } else {
                        app.showError(data.message || "操作失败");
                    }
                },"json");
            },'question');
		}
    </script>
</head>
<body>
<div class="container">
    <ul class="bui-tab nav-tabs" aria-disabled="false">
    	<li class="bui-tab-item bui-tab-item-selected" aria-disabled="false">
    		<span class="bui-tab-item-text">微信设置</span>
    	</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/wechat/setting" method="post">
        <div id="edit-div" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">URL：</label>
                    <div class="controls">
                        ${URL!}
                    </div>
                </div>
            </div>

            <#if businessConfigList?? && businessConfigList?has_content>
                <#list businessConfigList as config>
                    <#if config.businessConfigKey?? &&
                        config.businessConfigKey != "weixin_create_wx_lower_qrcode_config" &&
                        config.businessConfigKey != "wx_pay_partner_key" &&
                        config.businessConfigKey != "weixin_create_wx_shop_qrcode_config">
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label">
                                    <#if config.businessConfigKey !="wx_pay_sign_key" &&  config.businessConfigKey !="wx_pay_partner_id" &&  config.businessConfigKey !="wx_pay_partner_key">
                                        <s>*</s>
                                    </#if>
                                ${(config.businessConfigKeyLabel)!?html}：</label>

                                <div class="controls">
                                    <#if config.businessConfigKey=="weixin_login_config">
                                        <input type="radio" name="active" value="1"  <#if (config.businessConfigValue)?? && config.businessConfigValue=="1">checked="checked" </#if>>开启 &nbsp; &nbsp; &nbsp;
                                        <input type="radio" name="active" value="0" <#if (config.businessConfigValue)?? && config.businessConfigValue=="0">checked="checked" </#if>>关闭
                                    <#elseif config.businessConfigKey=="weixin_pay_config">
                                        <input type="radio" name="status" value="1"  <#if (config.businessConfigValue)?? && config.businessConfigValue=="1">checked="checked" </#if>>开启 &nbsp; &nbsp; &nbsp;
                                        <input type="radio" name="status" value="0" <#if (config.businessConfigValue)?? && config.businessConfigValue=="0">checked="checked" </#if>>关闭
                                    <#elseif config.businessConfigKey=="weixin_auto_login">
                                        <input type="radio" name="autoStatus" value="1"  <#if (config.businessConfigValue)?? && config.businessConfigValue=="1">checked="checked" </#if>>开启 &nbsp; &nbsp; &nbsp;
                                        <input type="radio" name="autoStatus" value="0" <#if (config.businessConfigValue)?? && config.businessConfigValue=="0">checked="checked" </#if>>关闭
                                    <#else>
                                        <input type="hidden" name="configId" value="${(config.businessConfigId)!}">
                                        <input value="${(config.businessConfigValue)!?html}" name="configValue"
                                            <#if config.businessConfigKey !="wx_pay_sign_key" &&  config.businessConfigKey !="wx_pay_partner_id" &&  config.businessConfigKey !="wx_pay_partner_key">
                                               data-rules="{required:true}"
                                            </#if>
                                               class="input-large control-text">
                                    </#if>
                                </div>
                            </div>
                        </div>
                    </#if>
                </#list>

                <!-- <#list businessConfigList as config>
                    <#if config.businessConfigKey?? && (config.businessConfigKey == "weixin_create_wx_shop_qrcode_config")>
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label">微信关注渠道：</label>
                                <div class="controls control-row-auto">
                                    <label>
                                        <input type="checkbox" value="1" id="weixin_create_wx_shop_qrcode_config" name="weixin_create_wx_shop_qrcode_config" <#if (config.businessConfigValue)?? && config.businessConfigValue=="1">checked </#if>>
                                        会员微店店铺的二维码:图文仅出现微店首页
                                    </label>
                                </div>
                            </div>
                        </div>
                    </#if>
                </#list>

                <#list businessConfigList as config>
                    <#if config.businessConfigKey?? && (config.businessConfigKey == "weixin_create_wx_lower_qrcode_config")>
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label">&nbsp;</label>
                                <div class="controls control-row-auto">
                                    <label>
                                        <input type="checkbox" value="1" id="weixin_create_wx_lower_qrcode_config" name="weixin_create_wx_lower_qrcode_config" <#if (config.businessConfigValue)?? && config.businessConfigValue=="1">checked </#if>>
                                        推广会员下线注册的二维码
                                    </label>
                                </div>
                            </div>
                        </div>
                    </#if>
                </#list> -->
            </#if>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">支付目录：</label>
                    <div class="controls" style="color: red">
                        需要在微信公众平台-微信支付-开发者配置-设置支付目录为:${urlPay!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">授权目录：</label>
                    <div class="controls" style="color: red">
                        需要在微信公众平台-开发者中心-网页授权获取用户基本信息设置为:${url2!}
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-bar">
            <div class="form-actions">
                <div class="span13 offset3 ">
                    <button type="submit" class="button button-primary">保存</button>
					<a class="button button-primary" href="#" onclick="resetToken();">重置Token</a>
				</div>
			</div>
        </div>
    </form>
</div>
</body>
</html>