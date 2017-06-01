<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html lang="en">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <meta charset="UTF-8">
    <title>咨询</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}/css/global.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}/css/mobile.css" />
    <script type="text/javascript" src="${staticResourcePath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/mobile.js"></script>
</head>
<body>
<div id="page">

    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/product/${(productId)!}"></a>
        <h1 class="mui-title">咨询</h1>
        <a class="mui-icon"></a>
    </header>


    <div class="mui-content">
        <div class="publishconsult">
            <p class="title">咨询内容：</p>
            <textarea name="consult" id="consultContentTxt"></textarea>
        </div>
        <div class="btnbar">
            <a class="mui-btn mui-btn-block mui-btn-primary" href="#" id="submitConsultBtn" onclick="javascript:doConsult();">提交咨询</a>
        </div>
    </div>
</div>
<script>
        var productId = '${(productId)!}';
        function doConsult(){
            var consultContent = $("#consultContentTxt").val();
            if(consultContent.trim().length <= 0){
                mui.toast("咨询内容不能为空!");
                return;
            }

            app.ajaxHelper.submitRequest({
                url: "${ctx}/m/product/consulting/add",
                type: 'POST',
                data: { productId:productId,content : consultContent},
                success : function(data) {
                    if(app.ajaxHelper.handleAjaxMsg(data)){
                        $("#consultContentTxt").val('');
                        mui.toast("提交成功，请耐心等待回复...");
                        window.location.href="${ctx}/m/product/"+productId;
                    } else {
                        mui.toast("提交失败");
                    }
                },
                error: function(xmlHttpRequest, errorStatus, errorThrow){
                    mui.toast(errorStatus + "提交失败，请稍后重试!");
                }
            });
        }
    </script>
</body>
</html>