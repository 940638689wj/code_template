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
                <li class="selected"><a href="/m/pickup/index">提货券码</a></li>
                <li><a href="/m/pickup/phoneIndex">手机验证码</a></li>
            </ul>
        </div>
        <div class="exchange">
            <div class="cue">
                <h3>提货券兑换</h3>
                <p>*根据短信提供的提货券号及密码</p>
            </div>
            <div class="loginform">
                <ul>
                    <li>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap">
                                    <input type="text" placeholder="请输入提货券号" name="codeNum" id="codeNum">
                                    <span class="delete"></span>
                                </div>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="bd">
                            <div class="info">
                                <div class="input-wrap">
                                    <input type="password" placeholder="请输入券密码" name="password" id="password">
                                    <span class="delete"></span>
                                </div>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="btnbar">
                <button class="mui-btn mui-btn-block mui-btn-primary" id="doConfirm">兑换</button>
            </div>

            <dl class="howto">
                <dt>如何兑换</dt>
                <dd>
                    <span>1</span>
                    <p>
                        <strong>输入</strong>
                        <em>输入有效提货券号</em>
                        <i>一个提货券号只能用一次</i>
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
    $(function(){
        $("#doConfirm").click(function(){
            if(hasLogin){
                $.post("${ctx}/m/pickup/verifyPickupCouponCode", {
                    codeNum : $("#codeNum").val(),
                    password : $("#password").val()
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
    })
</script>
</body>
</html>