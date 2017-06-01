<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>提现规则<</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
</head>
<body>
    <div id="page">
    <#if showTitle?? && showTitle>
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
            <h1 class="mui-title">提现规则</h1>
            <a class="mui-icon"></a>
        </header>
	</#if>
        <div class="mui-content">
            <div class="article-det">
            	<#if amtMin??>
            	<h2 class="artcle-det-tit">最小提现金额:${amtMin!0}</h2>
            	</#if>
                <h2 class="artcle-det-tit">提现规则</h2>
                <div class="article-main">
                    <p>${withdrawalRule!}</p>
                </div>
            </div>
        </div>
    </div>
</body>
</html>