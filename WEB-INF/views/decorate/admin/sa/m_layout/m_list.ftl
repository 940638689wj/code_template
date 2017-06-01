<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<#include "${ctx}/includes/sa/header.ftl"/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">移动商城首页装修</span></li>
        </ul>
    </div>

    <div class="content-top">
        <div class="mb10">
            <a class="button button-primary" href="javascript:addFrame();">+新增微信商城模板</a>&nbsp;&nbsp;&nbsp;&nbsp;
            <div class="tips tips-small tips-info tips-no-icon bui-inline-block">
                <div class="tips-content">可以新建多个不同的手机商城首页，随时切换使用。针对手机首页。</div>
            </div>
        </div>
    </div>

    <div class="content-body">
    <#if decorationList?? && decorationList?has_content>
        <#list decorationList as decoration>
            <div class="form-panel clearfix frame-select-item   <#if decoration.publish>current</#if> ">
                <div class="pull-left">
                    <div class="pic"><img src="${ctx}/static/admin/images/img_layout.png" alt=""/></div>
                    <h3><span id="span_${(decoration.id)!}"><em>${decoration.name!}</em></span> &nbsp;<a id="a_${(decoration.id)!}" href="javascript:editName(${(decoration.id)!})"><i class="icon-edit"></i></a></h3>
                    <div class="publish-info">
                        <#if decoration.updateTime??>
                            最后修改时间：<em>${decoration.lastUpdateTime?string("yyyy-MM-dd HH:mm:ss")}</em>
                        <#elseif decoration.createTime??>
                            创建时间：<em>${decoration.createTime?string("yyyy-MM-dd HH:mm:ss")}</em>
                        </#if>
                        <br><#if decoration.publish>已发布<#else>未发布</#if>
                    </div>
                </div>
                <div class="pull-right">
                    <a class="button button-large" href="javascript:preview('${(decoration.id)!}');">预览</a>
            <@securityAuthorize ifAnyGranted="delete">
                    <a class="button button-large" href="javascript:delLayout(${(decoration.id)!})">删除</a>
            </@securityAuthorize>
                    <a class="button button-large button-primary" href="javascript:editFrame('${(decoration.id)!}');">编辑</a>
                    <#if decoration.publish>
                    <#else>
                        <a class="button button-large button-primary" href="javascript:pushLayout(${(decoration.id)!})">发布</a>
                    </#if>
                </div>
            </div>
        </#list>
    <#else>
        <div class="nodata-content">
            您还没有新增首页哦，快去建立一个吧~
            <p><a class="button button-large button-primary" href="javascript:addFrame();">+新增框架</a></p>
        </div>
    </#if>
    </div>

</div>
</body>

<script type="text/javascript">

    function saveName(span, id, oldName) {
        var newName = $(this).val();
        span.html(newName);
        $("#a_" + id).show();
        //判断文本有没有修改
        if (newName != oldName) {
            $.ajax({
                url: '${ctx}/admin/sa/mobile/layoutManage/updateLayoutName?id=' + id + '&newName=' + newName,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("修改成功!");
                        //location.reload();
                    } else {
                        app.showError("修改失败!");
                    }
                }
            });
        }
    }

    function editName(id){
        $("#a_"+id).hide();
        var span = $("#span_"+id);
        var oldName = $.trim(span.text());
        var input = $("<input type='text' value='" + oldName + "'/>");
        span.html(input);
        input.click(function () { return false; });
        //获取焦点
        input.trigger("focus");
        //文本框失去焦点后提交内容,重新变为文本
        input.blur(function () {
            saveName.call(this, span, id, oldName);
        });
        //文本框 按回车键后提交内容,重新变为文本
        input.keydown(function () {
            var ev= window.event||e;
            if(ev.keyCode == 13){
                saveName.call(this, span, id, oldName);
            }
        });
    }

    function delLayout(id){
        if(!id){
            return;
        }
        BUI.Message.Confirm('确定要删除此框架吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/mobile/layoutManage/delLayout/'+id,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("删除成功!");
                        location.reload();
                    }else{
                        app.showError("禁用失败!");
                    }
                }
            });
        },'question');
    }

    function pushLayout(id){
        if(!id){
            return;
        }
        BUI.Message.Confirm('确定要发布吗?',function(){

            $.ajax({
                url : '${ctx}/admin/sa/mobile/layoutManage/m/pushLayout/'+id,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("发布成功!");
                        location.reload();
                    }else{
                        app.showError("发布失败!");
                    }
                }
            });
        },'question');
    }

    function addFrame(){
        window.location.href="${ctx}/admin/sa/mobile/layoutManage/toEditLayout/0";
    }

    function preview(id){
        window.location.href="${ctx}/admin/sa/mobile/layoutManage/toPreview/"+id+"?previewType=0";
    }

    function editFrame(id){
        window.location.href="${ctx}/admin/sa/mobile/layoutManage/toEditLayout/"+id;
    }
</script>
</html>