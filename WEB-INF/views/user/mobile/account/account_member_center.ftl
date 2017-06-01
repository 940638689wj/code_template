<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>会员中心</title>  
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">会员中心</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="member-card">
            <div class="card">
                <div class="hd">
                    <p class="l">
                        <span style="background-image:url(${(user.headPortraitUrl)!(userHead!)});"></span>
                        <em>${(user.userName)!}</em>
                    </p>
                    <p class="r">
                        <span>LV.${(user.userLevelId)!}</span><em>${userLevel.userLevelName}</em>
                    </p>
                </div>
                <div class="bd">当前积分<span>${(userConsumeCalc.totalScore)?default("0")}</span></div>
            </div>
        </div>
        <div class="borderbox">
            <div class="tbviewlist categorylist">
                <ul>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/userAddress">
                            <div class="c">收货地址</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/evaluation/toEvaluation">
                            <div class="c">我的评价</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/myEvaluation">
                            <div class="c">我的咨询</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/collection/toGoods">
                            <div class="c">我的收藏</div>
                        </a>
                    </li>
                    <li>
                        <a class="itemlink" href="${ctx}/m/account/historyView/toBrowseHistoty">
                            <div class="c">浏览历史</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
</script>
</body>
</html>