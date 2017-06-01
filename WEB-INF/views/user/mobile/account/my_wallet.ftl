<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>我的钱包</title>  
</head>
<body>
    <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
            <h1 class="mui-title">我的钱包</h1>
            <a class="mui-icon"></a>
        </header>

        <div class="mui-content">
            <div class="balance-top wallet-top">
                <h3>当前余额</h3>
                <p><span>￥</span>${(userConsumeCalc.userBalance)?default("0")}</p>
            </div>
            <div class="menu-grid">
                <ul>
                    <li>
                        <a href="${ctx}/m/account/userRechargeDetail">
                            <i class="ico ico-coupon"></i>
                            <p>账户充值</p>
                        </a>
                    </li>
                                         <li>
                     	 <a href="${ctx}/m/account/entityCardRecharge?cardTypeCd=1">
                            <i class="ico ico-coupon"></i>
                            <p>现金卡充值</p>
                        </a>
                    </li>   
                     <li>
                     	 <a href="${ctx}/m/account/entityCardRecharge?cardTypeCd=2">
                            <i class="ico ico-coupon"></i>
                            <p>积分卡充值</p>
                        </a>
                    </li> 
                    <li>
                        <a href="${ctx}/m/account/userPromotion/toCoupon?type=1">
                            <i class="ico ico-coupon"></i>
                            <p>优惠券</p>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/m/account/userPromotion/toRedPacket?type=1">
                            <i class="ico ico-coupon"></i>
                            <p>红包</p>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/m/account/userScoreDetail">
                            <i class="ico ico-coupon"></i>
                            <p>积分</p>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/m/account/award/showAward?awardTypeCd=1">
                            <i class="ico ico-coupon"></i>
                            <p>奖品</p>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/m/pickup/showDelivery?usedStatusCd=1">
                            <i class="ico ico-coupon"></i>
                            <p>提货券</p>
                        </a>
                    </li>
                    <li>
                        <a href="${ctx}/m/account/groupPurchaseOrder/list">
                            <i class="ico ico-coupon"></i>
                            <p>团购券</p>
                        </a>
                    </li>
                                 
                </ul>
            </div>
        </div>

    </div>
</body>
</html>