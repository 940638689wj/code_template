<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>浏览历史</title>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">浏览历史</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="borderbox">
                <div class="browse-title">5月18日</div>
                <ul class="prd-list browse-lst">
                    <li>
                        <a href="#">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <h3>耐克正品2013新款FREE5.0赤足系列男子跑步鞋536840-003YK</h3>
                            <p><span class="price-browse"><em>¥</em>1290.00</span></p>
                            <span class="source">来源：福建省厦门市软件园店</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <h3>耐克正品2013新款FREE5.0赤足系列男子跑步鞋536840-003YK</h3>
                            <p><span class="price-browse"><em>¥</em>1290.00</span></p>
                            <span class="source">来源：福建省厦门市软件园店</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <h3>耐克正品2013新款FREE5.0赤足系列男子跑步鞋536840-003YK</h3>
                            <p><span class="price-browse"><em>¥</em>1290.00</span></p>
                            <span class="source">来源：福建省厦门市软件园店</span>
                        </a>
                    </li>
                </ul>
            </div>
            <div class="borderbox">
                <div class="browse-title">5月17日</div>
                <ul class="prd-list browse-lst">
                    <li>
                        <a href="#">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <h3>耐克正品2013新款FREE5.0赤足系列男子跑步鞋536840-003YK</h3>
                            <p><span class="price-browse"><em>¥</em>1290.00</span></p>
                            <span class="source">来源：福建省厦门市软件园店</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <h3>耐克正品2013新款FREE5.0赤足系列男子跑步鞋536840-003YK</h3>
                            <p><span class="price-browse"><em>¥</em>1290.00</span></p>
                            <span class="source">来源：福建省厦门市软件园店</span>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <h3>耐克正品2013新款FREE5.0赤足系列男子跑步鞋536840-003YK</h3>
                            <p><span class="price-browse"><em>¥</em>1290.00</span></p>
                            <span class="source">来源：福建省厦门市软件园店</span>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>