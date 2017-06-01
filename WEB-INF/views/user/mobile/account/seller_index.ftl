<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title></title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
    <div id="page">
        <div class="seller-headwrap">
            <div class="btnbar">
                <a class="btn-action fl" href="${ctx}/m/account/index">个人中心</a>
                <a class="btn-action fr" href="${ctx}/m/account/mstoreUser/toStoreManagement">微店管理</a>
            </div>
            <div class="mc-head">
                <div class="pic">
                    <div class="userhead" style="background-image: url(${userHead});"></div>
                </div>
                <div class="namewrap"><p class="name">${mstoreName}</p></div>
            </div>
            <div class="seller-earnings">
                <p>今日收益（元）</p>
                <span id="todayAmt">${todayAmt}</span>
                <a href="#" class="eyes"></a>
            </div>
        </div>
        <div class="mui-content">
            <div class="seller-grid-four seller-grid-four-onb">
                <ul>
                    <li><a href="${ctx}/m/account/mstoreUser/commissionList"><img src="${staticResourcePath}images/grid-four_icon01.png"><p>佣金收益</p></a></li>
                    <li><a href="${ctx}/m/account/mstoreUser/distributeList"><img src="${staticResourcePath}images/grid-four_icon02.png"><p>返利收益</p></a></li>
                    <li><a href="${ctx}/m/account/mstoreUser/rewardList"><img src="${staticResourcePath}images/grid-four_icon03.png"><p>首单奖励</p></a></li>
                    <li><a href="${ctx}/m/account/mstoreUser/withdrawalPage"><img src="${staticResourcePath}images/grid-four_icon04.png"><p>提现</p></a></li>
                </ul>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/rankingList">
                                <div class="c">店铺排名<#if ranking??> (第${ranking!0}名)</#if></div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/order/mstoreorderlist">
                                <div class="c">微店订单</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/myClient">
                                <div class="c">我的客户</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/myLowerMstoreList">
                                <div class="c">下级微店</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/toQrCode">
                                <div class="c">推广微店</div>
                            </a>
                        </li>
                        <li class="mc-info-link">
                            <a class="itemlink" href="${ctx}/m/account/mstoreUser/tNoticeList/2">
                                <div class="c">政策公告</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- <div class="globalMenu">
            <div class="gbt-wrap">
                <ul>
                    <li>
                        <a href="#">
                            <span class="gbt-ico iconfont">&#xf015</span>
                            <span class="gbt-text">首页</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="gbt-ico iconfont">&#xf009</span>
                            <span class="gbt-text">分类</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="gbt-ico iconfont">&#xf07a</span>
                            <span class="gbt-text">购物车</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <span class="gbt-ico iconfont">&#xf007</span>
                            <span class="gbt-text">我的</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div> -->
    </div>
    <script type="text/javascript">
    $(function(){
		//点击切换*显示今日收益金额
		var amt = ${todayAmt!0};
		$(".eyes").toggle(
			function(){$("#todayAmt").html("****");},
			function(){	$("#todayAmt").html(amt);}
		);
	});
	</script>
</body>
</html>