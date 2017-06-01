<#assign ctx = request.contextPath>
<#assign definedControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].DEFINED_HTML.type>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>

    <script type="text/javascript">
        $(function(){
            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("自定义模块保存成功！");
                        var controlId = data['data']["id"];
                        var controlName = data['data']["name"];
                        var controlType = data['data']["type"];
                    <#if isNew?? && isNew>
                        window.parent.parent.fillControlContent(controlId, controlName, controlType);
                        window.parent.location.href = window.parent.parent.toChildIFrameRefresh();
                    <#else>
                        window.parent.fillControlContent(controlId, controlName, controlType);
                        window.location.reload();
                    </#if>
                    } else {
                        this.get('submitMask').hide();
                    }
                }
            });

            form.on('beforesubmit', function(){
                return collectData(); //收集数据，以JSON字符串的形式传输
            });

            form.render();
        });

        function collectData(){
            var selectStatus = $("div[name='statusCd']").find("input[type='radio']:checked");
            if(!selectStatus || !selectStatus.length){
                BUI.Message.Alert("请选择控件状态!");
                return false;
            }
            $("input[name='statusCd']").val(selectStatus.val());

            $("input[name='content']").val(window.msg_editor.getContent());

            return true;
        }
    </script>
</head>
<body>
<#--<#if !isNew?? || !isNew>
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">控件模块</span></li>
        </ul>
    </div>
</#if>-->
<form id="J_Form" class="form-horizontal" action="edit" method="post">
    <input type="hidden" name="id" value="${(control.id)!}"/>
    <input type="hidden" name="type" value="${type?default(definedControlType)}"/>

    <div id="edit-div" class="form-content">
        <div class="control-group">
            <label class="control-label"><s>*</s>名称：</label>
            <div class="controls">
                <input value="${(control.name)!?html}" name="name" data-rules="{required:true}" class="input-normal control-text">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><s>*</s>是否显示名称：</label>
        <#assign nameStatus = "1">
        <#if (control.showName)??>
            <#assign nameStatus = (control.showName)?string("1","0")>
        </#if>
            <div class="controls">
                <label class="radio" for="showNameRadio"><input  <#if nameStatus == "1">checked="checked"</#if> id="showNameRadio" type="radio" value="1" name="showName">显示</label>&nbsp;&nbsp;&nbsp;
                <label class="radio" for="hideNameRadio"><input  <#if nameStatus == "0">checked="checked"</#if> id="hideNameRadio" type="radio" value="0" name="showName">隐藏</label>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><s>*</s>排序：</label>
            <div class="controls">
                <input value="${(control.sort)?default('0')}" name="sort" data-rules="{required:true,min:0,number:true}" class="input-normal control-text">
            </div>
        </div>
        <div class="control-group">
            <label class="control-label"><s>*</s>是否启用：</label>
        <#assign status = (control.statusCd)?default(1)>
            <input type="hidden" name="statusCd" value="${(control.statusCd)!?default(1)}">
            <div class="controls" name="statusCd">
                <label class="radio" for="usedRadio"><input <#if status == 1>checked="checked"</#if> id="usedRadio" type="radio" value="1">启用</label>&nbsp;&nbsp;&nbsp;
                <label class="radio" for="disabledRadio"><input <#if status == 0>checked="checked"</#if> id="disabledRadio" type="radio" value="0">禁用</label>
            </div>
        </div>
        <input type="hidden" name="content" value="">
        <div class="control-group">
            <label class="control-label"><s>*</s>内容：</label>
            <div class="controls control-row-auto">
                <script type="text/plain" id="editor">${(control.contentJson)!}</script>
            </div>
        </div>
    </div>
    <div class="form-actions actions-bar">
        <div class="span13 offset3 ">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </div>
</form>

<script type="text/javascript">

    var getIframeById = function (idIframe) {
        var iframe;
        if (document.all) {//IE
            iframe = window.document.frames[idIframe]
        } else {//Firefox
            iframe = window.document.getElementById(idIframe)
        }
        if (iframe) {
            return iframe;
        }
        return null;
    }
    var getIframeDoc = function (idIframe) {
        var doc;
        var iframe = getIframeById(idIframe);
        if (iframe) {
            if (document.all) {//IE
                doc = iframe.document;
            } else {//Firefox
                doc = iframe.contentDocument;
            }
            return doc;
        }
        return  null;
    }

    $(function(){
        window.msg_editor = new UE.ui.Editor({initialFrameWidth: 900, initialFrameHeight: 500,allowDivTransToP:false});
        window.msg_editor.render("editor");

        var styleUrl = '${ctx}/static/css/style.css';
        var templateUrl = '${ctx}/static/template/01/css/tmpl.css';
        var templateThemeUrl = '${ctx}/static/template/01/themes/${templateTheme!}/css/theme.css';

        window.msg_editor.ready(function(){
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:styleUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:templateUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
            UE.utils.loadFile(getIframeDoc('ueditor_0'),{
                href:templateThemeUrl,
                tag:"link",
                rel:"stylesheet",
                type:"text/css"
            });
        });
    });
</script>
</body>
</html>