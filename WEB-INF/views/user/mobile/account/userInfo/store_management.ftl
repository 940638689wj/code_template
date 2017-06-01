<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
<meta charset="UTF-8">
<title>微店管理</title>
<!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />-->
</head>
<body>
    <div id="page">
    	<#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="javascript:window.location.href='${ctx}/m/account/mstoreUser/sellerIndex?mstoreId=${mstore.userId}'"></a>
	            <h1 class="mui-title">微店管理</h1>
	            <a class="mui-icon"></a>
	        </header>
		</#if>
        <div class="mui-content">
            <div class="dec-top" id="logoUrl" style="background-image: url('<#if mstore.logoUrl??>${mstore.logoUrl}</#if>');">
                <div class="upload-link">
                    <a href="javascript:void(0)">修改店铺招贴</a>
                </div>
                <div class="upload-wrap">
                    <input id="file_storeLogo" name="file" onchange="javascript:assetChange(this.value,'storeLogo');" type="file" style="cursor:pointer;">
                </div>
            </div>

            <div class="borderbox">
                <div class="tbviewlist">
                    <ul>
                        <li class="mc-info-link">
                            <a class="itemlink" href="javascript:void(0);">
                                <div class="r">
                                </div>
                                <div class="c" onclick="javascript:window.location.href='${ctx}/m/account/mstoreUser/toEditStoreName'">店铺名称<span>${mstore.mstoreName}</span></div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="mui-content-padded mt30 align-center">
                <a class="mui-btn mui-btn-primary mui-btn-block mb20" href="javascript:window.location.href='${ctx}/m/account/productmanager/findSaleProducts'">商品管理</a>
                <a href="${ctx}/m/account/mstoreUser/mstoreIndex"><i class="ico-preview"></i>查看店铺</a>
            </div>
        </div>

    </div>
<script>
    // 图片上传
 function assetChange(fileName,lastFlag){
        if(fileName == null || fileName.trim().length <= 0){
            mui.toast("请选择文件!");
            return false;
        }

        var suffixIndex = fileName.lastIndexOf('.');
        if(suffixIndex <= 0){
            mui.toast("文件格式错误!");
            return false;
        }

        var suffix = fileName.substr(suffixIndex + 1);

        if(suffix.trim().length <= 0 ||
                ("jpg" != suffix.trim() && "png" != suffix.trim())){
            mui.toast("文件格式错误!");
            return false;
        }
        $.ajaxFileUpload({
            url:'${ctx}/common/staticAsset/upload/lastFlag',
            secureuri: false,
            fileElementId: "file_"+lastFlag,
            dataType: "json",
            method : 'post',
            success: function (data, status) {
                loadImage(data.assetUrl,lastFlag);
            },
            error: function (data, status, e) {
                mui.toast("上传失败" + e);
            }
        });
        return false;
    }

    function loadImage(assertUrl,lastFlag) {
        $.ajax({
              url : '${ctx}/m/account/mstoreUser/updateMstoreLogo',
              dataType : 'json',
              type: 'post',
              data : {logoUrl: assertUrl},
              success : function(data){
              		mui.toast("上传成功！");
              }
           });
        $("#logoUrl").css("backgroundImage","url("+assertUrl+")") ;
        //$("#imageView_"+lastFlag).attr("src", assertUrl);
    }


</script>
</body>
</html>