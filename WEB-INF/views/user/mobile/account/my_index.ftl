<#assign ctx = request.contextPath>
<#assign isMStore = false/>
<#if user?? && user?has_content && user.mStoreStatusCd?has_content && user.mStoreStatusCd==1>
    <#assign isMStore = true/>
</#if>

<!doctype html>
<html lang="en">
<head>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">个人中心</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="welcometop mycenterbar">
            <div class="hd" style="background-image: url(${(user.headPortraitUrl)!(userHead!)});"><a href="${ctx}/m/account/userInfo">个人资料</a></div>
            <div class="bd">
                <h3>${(user.nickName)!(user.phone)}</h3>
                <p><a class="topup" href="${ctx}/m/account/userRechargeDetail">充值</a>余额:￥${(userConsumeCalc.userBalance)!}</p>
            </div>

            <div class="past <#if sign == 1>selected</#if>">
                <div class="img <#if sign == 0>img swing</#if>"></div>
                <p><#if sign == 1>已</#if>签到</p>
            </div>
        </div>
        <div class="user-list">
            <ul>
                <li>
                    <a href="${ctx}/m/account/userPromotion/toRedPacket?type=1">
                        <div class="c asset-red"></div>
                        <div class="t">红包</div>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/account/userScoreDetail">
                        <div class="c asset-integral"></div>
                        <div class="t">积分</div>
                    </a>
                </li>
                <#if isMStore>
                <li>
                    <a href="${ctx}/m/account/performance">
                        <div class="c asset-achievement"></div>
                        <div class="t">业绩</div>
                    </a>
                </li>
                </#if>
            </ul>
        </div>

        <div class="borderbox">
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink" href="${ctx}/spa/#/m/account/order/list/1/0">
                            <div class="c"><i class="icon order"></i>普通订单</div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="mc-info-list">
                <ul>
                    <li>
                        <a href="${ctx}/spa/#/m/account/order/list/1">
                            <b class="pcico-forpayment"></b>
                            <i class="badge">${allCount.type1!0}</i>
                            <div class="c">待付款</div>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/spa/#/m/account/order/list/2">
                            <b class="pcico-sendgoods"></b>
                            <i class="badge">${allCount.type2!0}</i>
                            <div class="c">待发货</div>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/spa/#/m/account/order/list/3">
                            <b class="pcico-forgoods"></b>
                            <i class="badge">${allCount.type3!0}</i>
                            <div class="c">待收货</div>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/spa/#/m/account/order/list/4">
                            <b class="pcico-evaluate"></b>
                            <i class="badge">${allCount.type4!0}</i>
                            <div class="c">待评价</div>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/spa/#/m/account/order/return/list">
                            <b class="pcico-return"></b>
                            <i class="badge">${allCount.type7!0}</i>
                            <div class="c">退换货</div>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/otherOrder/index">
                            <div class="c"><i class="icon order"></i>分类订单</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="borderbox">
            <div class="tbviewlist">
                <ul>
                	<#if isMStore>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/performance">
                            <div class="c"><i class="icon achievement"></i>我的业绩</div>
                        </a>
                    </li>
                    </#if>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/memberCenter">
                            <div class="r">会员卡、收货地址等</div>
                            <div class="c"><i class="icon personal"></i>会员中心</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/myWallet">
                            <div class="r">优惠券、奖品等</div>
                            <div class="c"><i class="icon mywallet"></i>我的钱包</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/userInfo">
                            <div class="c"><i class="icon personal"></i>个人资料</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="/m/account/accountSecurity">
                            <div class="r">更改密码</div>
                            <div class="c"><i class="icon modify"></i>账户安全</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>



        <div class="globalMenu">
            <#assign showIndex = 5 />
            <#include "${ctx}/includes/mobile/globalmenu.ftl" />
        </div>
    </div>
</div>
<script>
    //签到
    var sign = "${sign}";
    var flagTwo = false;
    var flagPost = false;
    if (sign == 0) {
        $(".past").on("click", function () {
            if(!flagPost){
	                var obj = $(this);
	                $.post("${ctx}/m/account/sign", function (data) {
	                    if(data.result == "success"){
	                      	obj.addClass("selected");
                    		obj.find(".img").removeClass("swing");
                    		obj.find("p").html("已签到");
		                    mui.toast('签到成功');
	                    } else {
	                        mui.toast("签到失败，请稍后再试");
	                    }
	            		flagPost=true;
	                });
            	}else if(flagPost){
            		if(!flagTwo){
                 		setTimeout("mui.toast('今日已签到');",1000);//1000为1秒钟
                 		flagTwo = true;
                	}else if(flagTwo){
                		mui.toast('今日已签到');
                	}
            	}
        });
    }
	
</script>
</body>
</html>