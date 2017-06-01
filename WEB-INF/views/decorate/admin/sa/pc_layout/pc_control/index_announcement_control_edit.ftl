<#assign ctx = request.contextPath>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/announcement.js"></script>
</head>
<body>
    <form class="form-horizontal" id="controlContainerForm" method="POST" action="edit">
        <input type="hidden" name="id" value="${(control.id)!}"/>
        <input type="hidden" name="type" value="${type?default(productControlType)}">
        <input type="hidden" name="showType" value="${(showType)?default(announcementType)}">
        <input type="hidden" name="name" value="公告">
        <div class="dcm-setting-body">
            <div class="form-horizontal">
                <div class="control-group">
                    <label class="control-label">是否启用:</label>
                    <#assign status = (control.statusCd)?default(1)>
                    <div class="controls control-row-auto">
                        <label class="radio"><input <#if status == 1>checked="checked"</#if> type="radio" value="1" name="statusCd">启用</label>
                        <label class="radio ml"><input <#if status == 0>checked="checked"</#if> type="radio" value="0" name="statusCd">禁用</label>
                    </div>
                </div>
                <hr>
                <div class="control-group">
                    <label class="control-label">公告图标</label>
                    <div class="controls control-row-auto">
                        <div class="comboList">
                            <div class="comboListTitle">公告图标</div>
                            <div class="comboListMenu">
                                <ul>
                                    <li value="0" <#if (dto.iconType)?has_content && dto.iconType == '0'>class="selected"</#if>>无</li>
                                    <li value="1" <#if (dto.iconType)?has_content && dto.iconType == '1'>class="selected"</#if>>图标一</li>
                                    <li value="2" <#if (dto.iconType)?has_content && dto.iconType == '2'>class="selected"</#if>>图标二</li>
                                    <li value="3" <#if (dto.iconType)?has_content && dto.iconType == '3'>class="selected"</#if>>图标三</li>
                                    <li value="4" <#if (dto.iconType)?has_content && dto.iconType == '4'>class="selected"</#if>>图标四</li>
                                    <li value="5" <#if (dto.iconType)?has_content && dto.iconType == '5'>class="selected"</#if>>图标五</li>
                                    <li value="6" <#if (dto.iconType)?has_content && dto.iconType == '6'>class="selected"</#if>>图标六</li>
                                    <li value="7" <#if (dto.iconType)?has_content && dto.iconType == '7'>class="selected"</#if>>图标七</li>
                                    <li value="8" <#if (dto.iconType)?has_content && dto.iconType == '8'>class="selected"</#if>>图标八</li>
                                </ul>
                            </div>
                            <input type="hidden" name="iconType" value="${(dto.iconType)!}">
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">边框颜色</label>
                    <div class="controls control-row-auto">
                        <div class="colorSelect">
                            <div class="color-set-wrap">
                                <input class="control-text color-set-text" type="text" value="<#if (dto.borderColor)?has_content && dto.borderColor?length gt 1>${(dto.borderColor)!?substring(1)}</#if>"/>
                                <label class="color-set-label"><input class="color-set-select" type="color"/><b style="background-color: ${(dto.borderColor)!};"></b><span>选色器</span></label>
                                <ul class="color-set-list">
                                    <li data-color="#8ed901"></li>
                                    <li data-color="#f8a300"></li>
                                    <li data-color="#e2312c"></li>
                                    <li data-color="#737373"></li>
                                    <li data-color="#7b64e3"></li>
                                    <li data-color="#4dc3fd"></li>
                                    <li data-color="#66e9d0"></li>
                                </ul>
                                <input type="hidden" name="borderColor" value="${(dto.borderColor)!}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">背景颜色</label>
                    <div class="controls control-row-auto">
                        <div class="colorSelect">
                            <div class="color-set-wrap">
                                <input class="control-text color-set-text" type="text" value="<#if (dto.bgColor)?has_content && dto.bgColor?length gt 1>${(dto.bgColor)!?substring(1)}</#if>"/>
                                <label class="color-set-label"><input class="color-set-select" type="color"/><b style="background-color: ${(dto.bgColor)!};"></b><span>选色器</span></label>
                                <ul class="color-set-list">
                                    <li data-color="#8ed901"></li>
                                    <li data-color="#f8a300"></li>
                                    <li data-color="#e2312c"></li>
                                    <li data-color="#737373"></li>
                                    <li data-color="#7b64e3"></li>
                                    <li data-color="#4dc3fd"></li>
                                    <li data-color="#66e9d0"></li>
                                </ul>
                                <input type="hidden" name="bgColor" value="${(dto.bgColor)!}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">图标颜色</label>
                    <div class="controls control-row-auto">
                        <div class="colorSelect">
                            <div class="color-set-wrap">
                                <input class="control-text color-set-text" type="text" value="<#if (dto.iconColor)?has_content && dto.iconColor?length gt 1>${(dto.iconColor)!?substring(1)}</#if>"/>
                                <label class="color-set-label"><input class="color-set-select" type="color"/><b style="background-color: ${(dto.iconColor)!};"></b><span>选色器</span></label>
                                <ul class="color-set-list">
                                    <li data-color="#8ed901"></li>
                                    <li data-color="#f8a300"></li>
                                    <li data-color="#e2312c"></li>
                                    <li data-color="#737373"></li>
                                    <li data-color="#7b64e3"></li>
                                    <li data-color="#4dc3fd"></li>
                                    <li data-color="#66e9d0"></li>
                                </ul>
                                <input type="hidden" name="iconColor" value="${(dto.iconColor)!}">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">滚动方向</label>
                <#assign direction = (dto.direction)?default("1")>
                    <div class="controls control-row-auto">
                        <label><input <#if direction == 'left'>checked="checked"</#if> type="radio" name="direction" value="left" checked="checked"> 从右向左</label>
                        <label class="ml"><input type="radio" <#if direction == 'right'>checked="checked"</#if> name="direction" value="right"> 从左向右</label>
                    </div>
                </div>
                <div class="control-group">
			        <label class="control-label"><s>*</s>控件排序：</label>
			        <div class="controls">
			            <input value="${(control.sort)?default('0')}" name="sort" data-rules="{required:true,min:0,number:true}" class="input-normal control-text">
			        </div>
			    </div>
                <div class="control-group">
                    <label class="control-label">文本内容</label>
                    <div class="controls control-row-auto">
                        <textarea placeholder="公告内容" name="content">${(dto.content)!}</textarea>
                        <div class="fontStyler">
                            <div class="font-styler">
                                <div class="fs-item fs-item-size"><a href="javascript:void(0)" title="字体大小"></a></div>
                                <div class="fs-item fs-item-weight"><a href="javascript:void(0)" title="加粗" <#if (dto.font.fontWeight)?has_content && dto.font.fontWeight == "bold">class="active"</#if>></a></div>
                                <div class="fs-item fs-item-color"><a href="javascript:void(0)" title="字体颜色"><label><input class="fs-color-input" type="color" value="${(dto.font.color)!}"/><b style="background-color: ${(dto.font.color)!}"></b></label></a></div>
                                <div class="fs-dropmenu">
                                    <ul><li data-value="12px" <#if (dto.font.fontSize)?has_content && dto.font.fontSize == '12px'>class="selected"</#if>><span class="l fs-s">小号</span><span class="r">12px</span></li>
                                        <li data-value="14px" <#if (dto.font.fontSize)?has_content && dto.font.fontSize == '14px'>class="selected"</#if>><span class="l fs-m">中号</span><span class="r">14px</span></li>
                                        <li data-value="16px" <#if (dto.font.fontSize)?has_content && dto.font.fontSize == '16px'>class="selected"</#if>><span class="l fs-l">大号</span><span class="r">16px</span></li>
                                        <li data-value="18px" <#if (dto.font.fontSize)?has_content && dto.font.fontSize == '18px'>class="selected"</#if>><span class="l fs-xl">超大号</span><span class="r">18px</span></li>
                                        <li data-value="20px" <#if (dto.font.fontSize)?has_content && dto.font.fontSize == '20px'>class="selected"</#if>><span class="l fs-xxl">特大号</span><span class="r">20px</span></li>
                                    </ul>
                                </div>
                                <input type="hidden" name="font.fontSize" value="${(dto.font.fontSize)!}">
                                <input type="hidden" name="font.fontWeight" value="${(dto.font.fontWeight)!}">
                                <input type="hidden" name="font.color" value="${(dto.font.color)!}">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="actions-bar" style="padding-left: 45px;">
            <div class="form-action">
                <button class="button button-large button-primary">保存</button>
            </div>
        </div>
    </form>
    <script type="text/javascript">
        $(function(){
            comboList(".comboList");
            colorSelector(".colorSelect");
            fontStyler(".fontStyler");

            var Form = BUI.Form
            var form = new Form.Form({
                srcNode: '#controlContainerForm',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("控件保存成功!");
                        var controlId = data['data']["id"];
                        var controlName = data['data']["name"];
                        var controlType = data['data']["type"];
                        var controlShowType = data['data']['showType'];
                        <#if isNew?? && isNew>
                            window.parent.parent.fillControlContent(controlId, controlName, controlType, controlShowType);
                            window.parent.location.href = window.parent.parent.toChildIFrameRefresh();
                        <#else>
                            window.parent.fillControlContent(controlId, controlName, controlType, controlShowType);
                            window.location.reload();
                        </#if>
                    }
                }
            });
            form.on('beforesubmit', function(){
                return collectData(); //收集数据，以JSON字符串的形式传输
            });
            form.render();
        });

        function collectData(){

            return true;
        }

    </script>
</body>
</html>