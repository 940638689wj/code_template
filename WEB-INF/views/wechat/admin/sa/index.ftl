<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#assign staticPath = ctx + "/static">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/theme-01.css" rel="stylesheet" type="text/css"/>
</head>
<body>
<div class="container">
	<ul class="bui-tab nav-tabs" aria-disabled="false">
    	<li class="bui-tab-item bui-tab-item-selected" aria-disabled="false">
    		<span class="bui-tab-item-text">微信首页</span>
    	</li>
    </ul>
	<!--
    <div class="title-bar">
        <div class="tips tips-large tips-notice tips-no-icon mt15">
            <div class="tips-content">
                <h2>最新公告</h2>
                <p>福建首家接通 <span style="font-size: 16px;">微支付</span>的微商城，马上来开通微支付，0元接入微商城！</p>
            </div>
        </div>
    </div>
	-->
    <div class="content-body">
        <div class="wxhome-chart">
            <div class="wxchart-info">
                <h3>新增会员</h3>
                <ul>
                    <li class="wxinfo-today"><span>今日新增会员</span><em>${userCountToday?default('0')}</em></li>
                    <li><span>昨日新增会员</span><em>${userCountYesterday?default('0')}</em></li>
                </ul>
                <div class="wxinfo-ft">目前会员共计${allUserCount?default('0')}名</div>
            </div>
            <div class="wxchart-info">
                <h3>新增消息</h3>
                <ul>
                    <li class="wxinfo-today"><span>今日新增消息</span><em>${userMsgCountToday?default('0')}</em></li>
                    <li><span>昨日新增消息</span><em>${userMsgCountYesterday?default('0')}</em></li>
                </ul>
                <div class="wxinfo-ft">目前消息共计${allUserMsgCount?default('0')}条</div>
            </div>
        </div>
    </div>


</div>
</body>

<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/config.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>
</body>
</html>  