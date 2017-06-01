<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>登录</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="${ctx}/static/css/fsboxer.css">
</head>
<body class="page-login">
<input type='hidden' id="successUrl" value='${successUrl!}'>
<#include "include/header.ftl"/>
<div id="page">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>账户安全<span><em>_</em>账户安全</span></h3></div>
            <div class="payment">
                <div class="tabbox">
                    <ul class="tabbar">
                        <li class="<#if type??&&type?has_content&&type==1>selected</#if>">
                            <a href="${ctx}/account/userChangePaw?type=1"><span>修改登录密码</span></a>
                        </li>
                        <li class="<#if type??&&type?has_content&&type==2>selected</#if>">
                            <a href="${ctx}/account/userChangePaw?type=2"><span>修改支付密码</span></a>
                        </li>
                    </ul>
                    <div class="verifybox">
                        <ul class="payform">
                            <li class="payform-item">
                                <div class="payform-hd"><#if type==1>当前登陆密码：<#elseif type==2 && payPwd==1>当前支付密码<#elseif type==2 &&payPwd==0>当前登陆密码</#if></div>
                                <div class="payform-bd">
                                    <input class="textfield" type="password" name="password" id="password">
                                </div>
                            </li>
                            <li class="payform-item">
                                <div class="payform-hd">新密码：</div>
                                <div class="payform-bd">
                                    <input class="textfield" type="password" name="newPassword" id="newPassword">
                                </div>
                            </li>
                            <li class="payform-item">
                                <div class="payform-hd">确认新密码：</div>
                                <div class="payform-bd">
                                    <input class="textfield" type="password" name="rptPassword" id="rptPassword">
                                </div>
                            </li>
                            <li class="payform-item">
                                <div class="form-btnbar"><a href="#" class="v-btn" id="submit"><span>确定</span></a></div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function () {
        $("#menu_resetPaw").addClass("current");
        $.fn.raty.defaults.path = 'images';
        $('.ratestar').raty({
            readOnly: true,
            score: function () {
                return $(this).attr('data-score');
            }
        });
    });

    $("#submit").click(function () {
        var password = $("#password").val();
        var newPassword = $("#newPassword").val();
        var rptPassword = $("#rptPassword").val();
        var passwoedType = ${type!1}
        var successUrl = $("#successUrl").val();
        var vpassword =  new RegExp("^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,12}$");
        var reg = new RegExp(/^\d{6}$/);
        if (!password) {
            layer.msg("当前密码不能为空！");
            return;
        }
        if (!newPassword) {
            layer.msg("新密码不能为空！");
            return;
        }
        if(${type}==1 && !vpassword.test(newPassword)){
            layer.msg('请输入6至12位数字加字母的组合!');
            return false;
        }
        if (${type}==1 && newPassword.length < 6 || newPassword.length > 12) {
            layer.msg('请输入6至12位长度的密码！');
            return false;
        }
        if(${type}==2 && !reg.test(newPassword)){
            layer.msg('支付密码必须为6位数字！');
            return false;
        }
        if (${type}==2 && newPassword.length != 6) {
            layer.msg('支付密码必须为6位！');
            return false;
        }
        if (!rptPassword) {
            layer.msg("确认新密码不能为空！");
            return;
        }
        if (newPassword != rptPassword) {
            layer.msg("两次输入的密码不同！");
            return;
        }
		
        $.post("${ctx}/account/userChangePaw/resetPaw", {
                    password: password,
                    newPassword: newPassword,
                    type: passwoedType,
                	successUrl : successUrl              
                },
                function (data) {
                    if (data.result == "success") {
                        layer.msg("保存成功！");
                        if(data.submitOrderUrl !=null ){
                            window.location.href = "${ctx}"+data.submitOrderUrl;
						} else if(data.successUrl != null) {
							window.location.href = "${ctx}"+data.successUrl;
						} else {
                            location.reload();
                        }
                    } else {
                        layer.msg(data.message || "修改失败,请稍后再试!");
                    }
                }, "json");
    });

</script>
</body>
</html>