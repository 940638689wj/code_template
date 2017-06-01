<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-text">会员卡图片设置</div>
    </div>

    <div class="tips-wrap tips tips-small tips-notice">
        <span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-volume-up"></i></span>
        <div class="tips-content">若要单独设置某个等级的会员卡，<a href="${ctx}/admin/sa/userLevel/userLevelList">请点击这里&gt;&gt;</a></div>
    </div>

    <form id="J_Form" class="form-horizontal" method="post" action="${ctx}/admin/sa/userCard/save">
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">会员卡正面图：</label>
                    <div class="controls control-row-auto">
                        <div class="cover-area">
                            <div class="file-btn">
                                <button class="button button-primary">上传</button>
                                <input id="file_cardImage" class="inp-file" name="file" type="file"
                                       onchange="javascript:assetChange(this.value,'cardImage');">
                            </div>
                            <button class="button" type="button" onclick="delItem('cardImage');" >删除</button>
                            <p class="upload-tip">图片建议尺寸：600像素 * 370像素</p>

                            <div id="imgshow_cardImage" class="mt5" <#if !(cardImage?has_content)>style="display:none;"</#if>>
                                <input type="hidden" id="cardImageUrl" name="cardImageUrl" value="<#if cardImage?has_content>${cardImage}</#if>" class="input-normal control-text" >
                                <img id="cardImage" class="pull-left" width="100px" height="100px" src="<#if cardImage?has_content>${cardImage}</#if>" >
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">会员卡背面图：</label>
                    <div class="controls control-row-auto">
                        <div class="cover-area">
                            <div class="file-btn">
                                <button class="button button-primary">上传</button>
                                <input id="file_backImage" class="inp-file" name="file" type="file"
                                       onchange="javascript:assetChange(this.value,'backImage');">
                            </div>
                            <button class="button" type="button" onclick="delItem('backImage');" >删除</button>
                            <p class="upload-tip">图片建议尺寸：600像素 * 370像素</p>
                        </div>

                    <#assign a = true>
                    <#if backImage?has_content>
                        <#assign a = false>
                    </#if>
                        <div id="imgshow_backImage" class="mt5" <#if a>style="display:none;"</#if>>
                            <input type="hidden" id="backImageUrl" name="backImageUrl" value="<#if backImage?has_content>${backImage}</#if>" class="input-normal control-text" >
                            <img id="backImage" class="pull-left" width="100px" height="100px" src="<#if backImage?has_content>${backImage}</#if>" >
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row form-actions actions-bar">
            <div class="span13">
                <button type="submit" class="button button-primary" id="save">保存</button>
                <button type="reset" class="button">重置</button>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">

    // BUI框架提交保存
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                }
                setTimeout("remainTime()",1200);
            }
        }).render();

        form.on('beforesubmit', function(){
            $("#save").attr('disabled',true);
        });

    });

    function remainTime(){
        $("#save").attr('disabled',false);
    }

</script>
<#include "${ctx}/includes/sa/uploadImage.ftl"/>

</body>
</html>