<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>产品参数</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="css/mui.css" />
    <link rel="stylesheet" type="text/css" href="css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="css/frames.css" />
    <link rel="stylesheet" type="text/css" href="css/module.css" />
    <link rel="stylesheet" type="text/css" href="css/mui/mui.picker.css" />
    <link rel="stylesheet" type="text/css" href="css/mui/mui.poppicker.css" />
    <script type="text/javascript" src="js/zepto.js"></script>
    <script type="text/javascript" src="js/mui.min.js"></script>
    <script type="text/javascript" src="js/yrmobile.js"></script>
    <script type="text/javascript" src="js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav"></a>
		            <h1 class="mui-title">产品参数</h1>
	            <a class="mui-icon"></a>
	        </header>
       	</#if>

        <div class="mui-content">
            <ul class="tbviewlist">
              <#if productAttrList?? && productAttrList?has_content>    
              <#list productAttrList as pro>          
                <li>
                    <div class="hd"><#if pro!=null>${pro.attrName!}:</#if></div>
                    <div class="bd"><#if pro!=null>${pro.attrValue!}</#if></div>
                </li>
                </#list>
               <#else>
         <div class="mui-content">
            <div class="iconinfo">
                <i class="ico ico-addempty"></i>
                <strong>暂时没有相关参数介绍！</strong>
            </div>
         </div>
              </#if>
            </ul>
        </div>
    </div>
</body>
</html>