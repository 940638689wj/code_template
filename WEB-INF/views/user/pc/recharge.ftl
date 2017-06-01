<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>余额充值</title>

</head>
<body>
   <#include "include/header.ftl"/>
   <div id="page">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>我的钱包<span><em>_</em>账户余额</span></h3></div>
            <p class="title">当前账户余额：<span class="price-real">${(userConsume.userBalance)!0}</span></p>
            <div class="payment">
                <div class="tabbox">
                    <ul class="tabbar">
                        <li class="selected"><a href="javascript:void(0);"><span>在线充值</span></a></li>
                        <li><a href="javascript:void(0);"><span>现金卡充值</span></a></li>
                    </ul>
                    <div class="tabcon">
                        <ul class="payform">
                            <li class="payform-item">
                                <div class="payform-hd">输入充值金额：</div>
                                <div class="payform-bd">
                                    <input type="text" class="textfield" id="rechargeAmt"> 元
                                </div>
                            </li>
                        </ul>
                        <h3 class="title plr0">选择充值方式</h3>
                        <ul class="radiolist">
                            <#if alipayPc??&&alipayPc?has_content&&alipayPc.isActive>
                                <li><input type="radio" name="payWay" value="2" checked="checked"/><label for="bank_1">
                                    <img src="${ctx}/static/images/payment/bank_52.gif" alt=""></label></li>
                            </#if>
                            <#if unionpayMobile??&&unionpayMobile?has_content&&unionpayMobile.isActive>
                                <li><input type="radio" name="payWay" value="4"/><label for="bank_2">
                                    <img src="${ctx}/static/images/payment/bank_unionpay.png" alt=""></label></li>
                            </#if>
                        </ul>
                        <a class="v-btn" href="javascript:submit()">去充值</a>
                    </div>
                    <div class="tabcon" style="display: none;">
                        <ul class="payform">
                            <li class="payform-item">
                                <div class="payform-hd">请输入充值卡号：</div>
                                <div class="payform-bd">
                                    <input type="text" id="cardNum" class="textfield">
                                </div>
                            </li>
                            <li class="payform-item">
                                <div class="payform-hd"> 请输入充值卡密码：</div>
                                <div class="payform-bd">
                                    <input type="password" id="cardPwd" class="textfield">
                                </div>
                            </li>
                        </ul>
                        <a class="v-btn" href="javascript:cardSubmit()">现金卡充值</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
 </div>

<script>
    $(function(){
        $("#menu_recharge").addClass("current");
        
        $(".tabbar li").click(function () {
            var idx = $(this).index();
            $(".tabbar li").removeClass("selected");
            $(this).addClass("selected");
            $(".tabcon").hide().eq(isNaN(idx) ? 0 : idx).show();
        });
    })
    //在线充值提交
    function submit() {
        var rechargeAmt = $("#rechargeAmt").val();
        var payWay = $("input[name='payWay']:checked").val();
        var regRechargeAmt = /^(?!0+(?:\.0+)?$)(?:[1-9]\d*|0)(?:\.\d{1,2})?$/;
        if (!rechargeAmt) {
            layer.msg("请输入充值金额！");
            return;
        }
        if(!regRechargeAmt.test(rechargeAmt)){
            layer.msg("请正确输入充值金额！");
            return;
        }
        if (!payWay) {
            layer.msg("请选择充值渠道！");
            return;
        }
        $.post("${ctx}/account/userRechargeDetail/submitRecharge", {
            payWay: payWay,
            rechargeAmt: rechargeAmt
        }, function (data) {
            if (data.result == "true") {
                window.location.href = "${ctx}/account/recharge/goToPayment.html?localSerialNum=" + data.localSerialNum + "&payWay=" + payWay;
            } else {
                layer.msg("充值失败，请稍后再试！");
            }
        }, "json");
    }    

    function cardSubmit(){
        var cardNum = $("#cardNum").val();
        var cardPwd = $("#cardPwd").val();
        if(cardNum == null || cardNum == ''){
            layer.msg("请输入充值卡号!");
            return false;
        }
        if(cardPwd == null || cardPwd == ''){
            layer.msg("请输入充值卡密码");
            return false;
        }
        layer.confirm('确认充值？',function(){
            $.post("${ctx}/account/userRechargeDetail/entityRecharge",{
                'cardTypeCd' : 1,
                'cardNum' : cardNum,
                'cardPwd' : cardPwd
            },function(data){
                if(data && data.result == 'true'){
                    layer.msg("充值成功！");
                    $("#cardNum").val('');
                    $("#cardPwd").val('');
                }else{
                    layer.msg(data.message);
                }
            },'json')

        })
    }
</script>
</body>
</html>