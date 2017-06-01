<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>个人资料</title>
</head>
<body>
	<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/shopperIndex"></a>
	        <h1 class="mui-title">个人资料</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="mui-content">
            <div class="toptip">
                <div>提示：如联系方式或个人信息变更请务必及时与平台客服联系更改</div>
            </div>
            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">${(shopper.shopperName)!?html}</div>
                                <div class="c">姓名</div>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">${(shopper.identityNum)!?html}</div>
                                <div class="c">身份证号</div>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">${(shopper.shopperNum)!?html}</div>
                                <div class="c">员工号</div>
                            </a>
                        </li>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">${(shopper.phone)!?html}</div>
                                <div class="c">手机号</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>


 
</body>
</html>