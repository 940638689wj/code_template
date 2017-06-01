<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <title>提货券兑换</title>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">提货券兑换</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li><a href="/m/pickup/index">提货券码</a></li>
                <li class="selected"><a href="/m/pickup/phoneIndex">手机验证码</a></li>
            </ul>
        </div>
        <div class="exchange">
            <div class="cue">
                <h3>提货券兑换</h3>
                <p>*根据手机号接收到的短信验证码</p>
            </div>
            <div class="loginform">
                <ul>
                    <li>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap"><input type="number" placeholder="请输入手机号" class="pickupPhone"><span class="delete"></span></div>
                                <div class="toobtain">获取短信验证码</div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap"><input type="number" placeholder="请输入短信验证码" class="verifyCode"><span class="delete"></span></div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="btnbar">
                <a class="mui-btn mui-btn-block mui-btn-primary" href="javascript:;" id="doConfirm">兑换</a>
            </div>
            <dl class="howto">
                <dt>如何兑换</dt>
                <dd>
                    <span>1</span>
                    <p>
                        <strong>输入</strong>
                        <em>输入有效手机号</em>
                        <i>必须是有收到提货券的手机号</i>
                    </p>
                </dd>
                <dd>
                    <span>2</span>
                    <p>
                        <strong>确认</strong>
                        <em>确认兑换商品</em>
                        <i>兑换后的商品不可以退换哦</i>
                    </p>
                </dd>
                <dd>
                    <span>3</span>
                    <p>
                        <strong>提交</strong>
                        <em>提交兑换订单，选择自提或者是快递配送。</em>
                    </p>
                </dd>
            </dl>
        </div>
    </div>
</div>
<script type="text/javascript">
    var hasLogin = <#if userId?? && userId?has_content>true<#else>false</#if>;
    var clickStatus = true;//是否可以发送验证码
    $(function(){
        $(".toobtain").click(function() {
            sendSmsMsg();
        });
        $("#doConfirm").click(function(){
            if(hasLogin){
                var phone = $('.pickupPhone').val();
                if(!checkTelephone(phone)) {
                    return;
                }
                $.post("${ctx}/m/pickup/verifyPhone", {
                    'verifyCode' : $(".verifyCode").val(),
                    'phone' : phone
                }, function(data){
                    if(data && data.result == "success"){
                        window.location.href = "${ctx}/m/pickup/selectPackage";
                    }else{
                        mui.toast(data.message || "操作失败,请稍后再试!");
                    }
                }, "json");
            }else{
                var btnArray = ['确认', '关闭'];
                mui.confirm('', '您还未登录，请先登录！', btnArray, function(e) {
                    if (e.index == 0) {
                        window.location.href = "${ctx}/m/login?successUrl="+window.location.href;
                    }
                })
            }
        })

        //发送短信
        function sendSmsMsg(){
            if(!clickStatus) {
                return;
            }
            var phone = $('.pickupPhone').val();
            if(!checkTelephone(phone)) {
                return;
            }

            $.post("${ctx}/m/pickup//verifyPickupPhone", {
                'phone' : phone
            }, function(data){
                if(data && data.result == "success"){
                    clickStatus = false;
                    $(".toobtain").addClass("disabled");
                    var times = 60;
                    var timer = setInterval(function () {
                        if (--times <= 0) {
                            $(".toobtain").removeClass("disabled");
                            clickStatus = true;
                            $(".toobtain").text("获取短信验证码");
                            clearInterval(timer);
                        } else {
                            $(".toobtain").text("重新获取" + times + "s");
                        }
                    }, 1000);
                    window.onunload = function () {
                        clearInterval(timer);
                    };
                }else{
                    mui.toast(data.message || "获取短信验证码失败,请稍后再试!");
                    $('#randomImage').trigger("click");
                }
            }, "json");
        }

        // 校验手机号码格式
        function checkTelephone(telephone) {
            var mobileReg = new RegExp("^(1[0-9]{10})$");
            if (!telephone) {
                mui.toast('请填写手机号!');
                return false;
            }
            if (!mobileReg.test(telephone)) {
                mui.toast('手机号格式不正确!');
                return false;
            }
            return true;
        }
    })
</script>
</body>
</html>