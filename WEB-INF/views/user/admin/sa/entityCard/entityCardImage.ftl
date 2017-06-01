<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../../includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ajaxfileupload.js"></script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/entityCard?cardTypeCd=${cardTypeCd!}"><#if cardTypeCd == 1>
            现金卡<#elseif cardTypeCd == 2>积分卡</#if></a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">设置<#if cardTypeCd == 1>现金卡<#elseif cardTypeCd == 2>积分卡</#if>背景图</li>
    </ul>

    <form id="J_Form" class="form-horizontal" method="post" action="${ctx}/admin/sa/entityCard/setImage?cardTypeCd=${cardTypeCd!}">
        <div class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label"><#if cardTypeCd == 1>现金卡<#elseif cardTypeCd == 2>积分卡</#if>正面图：</label>
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
                    <label class="control-label"><#if cardTypeCd == 1>现金卡<#elseif cardTypeCd == 2>积分卡</#if>背面图：</label>
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
                    window.location.href = "${ctx}/admin/sa/entityCard?cardTypeCd="+${cardTypeCd!}
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