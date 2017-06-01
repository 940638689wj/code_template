<#assign ctx = request.contextPath>

<div class="banner" style="background-image: url(/static/images/exchangev_banner.jpg);"></div>
<div class="exchangeinput">
    <div class="layout">
        <p class="info">提货券兑换<span>*根据短信提供的提货券号及密码</span></p>
        <div class="inputaction">
            券号<input type="text" placeholder="请输入提货券号" name="codeNum" id="codeNum">
            密码<input type="password" placeholder="请输入券密码" name="password" id="password">
        </div>

        <a class="btn-action" href="javascript:void(0);" id="doConfirm">兑换</a>
    </div>
</div>

<div id="main">
    <div class="exchange">
        <h3 class="tit">提货券使用流程</h3>
        <div class="process"></div>
        <h3 class="tit">提货券常见问题解答</h3>
        <dl>
            <dt><span>问：</span><p>提货券如何使用？</p></dt>
            <dd><span>答：</span><p>提货券可在电脑上或者手机上使用。使用电脑时需打开商城，从首页进入提货券页面，按照页面流程输入券号密码即可使用；手机端可通过扫一扫券上的二维码进入提货券页面，根据页面流程使用。</p></dd>
        </dl>
        <dl>
            <dt><span>问：</span><p>我的提货券可以充值吗？</p></dt>
            <dd><span>答：</span><p>很抱歉，提货券不支持充值。</p></dd>
        </dl>
        <dl>
            <dt><span>问：</span><p>使用提货券提货时，能开具发票吗？</p></dt>
            <dd><span>答：</span><p>因为购买提货券时已经开具了发票，所以在使用提货券提货时不能再重复开具发票。</p></dd>
        </dl>
        <dl>
            <dt><span>问：</span><p>提货券可以和其他付款方式一起使用吗？</p></dt>
            <dd><span>答：</span><p>提货券仅限于购买商城指定商品，不能与其他付款方式一起使用。</p></dd>
        </dl>
        <dl>
            <dt><span>问：</span><p>我的提货券丢了能补吗？</p></dt>
            <dd><span>答：</span><p>请妥善保管提货券号及密码，提货券不计名、不挂失、不兑换现金、不退换。</p></dd>
        </dl>
        <dl>
            <dt><span>问：</span><p>我使用商城提货后，需要退货的时候能否退现金给我？</p></dt>
            <dd><span>答：</span><p>您好，商城提货券仅限使用一次，不支持退货，如所提商品出现质量问题可联系客服进行更换。</p></dd>
        </dl>
    </div>
</div>

<script type="text/javascript">
    var hasLogin = <#if userId?? && userId?has_content>true<#else>false</#if>;
    $(function(){
        $("#doConfirm").click(function(){
        	var code =$("#codeNum").val();
            if(hasLogin){
                $.post("${ctx}/pickup/verifyPickupCouponCode", {
                    codeNum : code,
                    password : $("#password").val()
                }, function(data){
                    if(data && data.result == "success"){
                        window.location.href = "${ctx}/pickup/selectPackage?codeNum="+code;
                    }else{
                        layer.msg(data.message || "操作失败,请稍后再试!");
                    }
                }, "json");
            }else{
                layer.msg('您还未登录，请先登录！', {
                    time: 0 //不自动关闭
                    ,btn: ['确认', '关闭']
                    ,yes: function(index){
                        layer.close(index);
                        window.location.href = "${ctx}/login?successUrl="+window.location.href;
                    }
                });
            }
        })
    })
</script>