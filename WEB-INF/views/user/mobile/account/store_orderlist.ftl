<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>微店订单</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav"></a>
	            <h1 class="mui-title">微店订单</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="balance-top" style="background-image:url(images/sis-decoration-top.jpg);">
                <h3>待返利总额<span>(元)</span></h3>
                <p>3,800.00</p>
            </div>
            <div class="store-orderList">
                <ul>
                    <li>
                        <div class="hd">
                            <div class="pic"><img src="images/goodsbigpic.jpg"><i>1</i></div>
                            <div class="info">
                                <p>创建时间：2016-04-25 14:36:08</p>
                                <span class="complete">已返利</span>
                            </div>
                        </div>
                        <div class="bd">
                            <div class="clinch">
                                <p>成交金额</p>
                                <span>360.00</span>
                            </div>
                            <div class="commission">
                                <p>返佣金额</p>
                                <span>360.00</span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="hd">
                            <div class="pic"><img src="images/goodsbigpic.jpg"><i>1</i></div>
                            <div class="info">
                                <p>创建时间：2016-04-25 14:36:08</p>
                                <span class="stay">待返利</span>
                            </div>
                        </div>
                        <div class="bd">
                            <div class="clinch">
                                <p>成交金额</p>
                                <span>360.00</span>
                            </div>
                            <div class="commission">
                                <p>返佣金额</p>
                                <span>360.00</span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="hd">
                            <div class="pic"><img src="images/goodsbigpic.jpg"><i>1</i></div>
                            <div class="info">
                                <p>创建时间：2016-04-25 14:36:08</p>
                                <span class="failure">已失效</span>
                            </div>
                        </div>
                        <div class="bd">
                            <div class="clinch">
                                <p>成交金额</p>
                                <span>360.00</span>
                            </div>
                            <div class="commission">
                                <p>返佣金额</p>
                                <span>360.00</span>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>

    </div>
<script>



</script>
</body>
</html>