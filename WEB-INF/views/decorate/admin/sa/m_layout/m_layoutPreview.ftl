<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title>首页模板</title>
    <link rel="stylesheet" href="${ctx}/static/decoration/mobile/css/decoration.css"/>
    <#include "${ctx}/includes/sa/header.ftl"/>
	<#include "${ctx}/macro/sa/roma_macro.ftl"/>
</head>
<script>
    var args = {};
    (function () {
        var result = {},
                params = location.search && location.search.substring(1),
                arr = params.split("&");
        for(var i = 0; i < arr.length; i++){
            var t = arr[i].split("=");
            result[t[0]] = t[1];
        }
        args = result;
    })();

    var url = "${ctx}/admin/sa/mobile/layoutManage/toPreviewPage/${(id)!}?previewType=${(previewType)!}";
</script>
<body>
<div class="dcm-page">
    <div class="dcm-preview preview-page">
        <div class="dcm-preview-box">
            <div class="dcm-preview-box-page">
                <iframe id="J_Iframe" frameborder="0" ></iframe>
                <#--<iframe src="${ctx}/admin/layoutManage/toPreviewPage/${(layoutId)!}?platform=m&previewType=${(previewType)!}" frameborder="0"></iframe>-->
            </div>
        </div>
        <div class="dcm-preview-btn">
            <a href="javascript:void(0)" onclick="pushLayout(${(id)!})">立刻使用</a>
        </div>
    </div>
</div>
</body>
<script>
    document.getElementById("J_Iframe").src = url;
    function pushLayout(id){
        if(!id){
            return;
        }
        BUI.Message.Confirm('确定要立即使用吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/mobile/layoutManage/m/pushLayout/'+id,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("成功!");
                        location.reload();
                    }else{
                        app.showError("失败!");
                    }
                }
            });
        },'question');
    }
</script>
</html>