<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>

    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>

	<style>
        .sucai-box{position:relative; border: 0; -webkit-border-radius: 0; -moz-border-radius:0; border-radius: 0; padding:0; background-clip: border-box; overflow: hidden;}
        .sucai-box-selected .sucai-box-mask{display: block;}
        .sucai-box-mask{display: none; position: absolute; top:0; left: 0; width: 100%; height:100%; background-color: rgba(0,0,0,.5);-ms-filter: "progid:DXImageTransform.Microsoft.gradient(startColorstr=#7F000000,endColorstr=#7F000000)"; filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#7F000000,endColorstr=#7F000000); zoom: 1;}
        .sucai-box-mask i{position: absolute; top:0; left: 0; width: 100%; height:100%; background: url("${staticPath}/admin/images/icon_msg_selected.png") no-repeat center;}
	</style>
</head>
<body>

<div class="container">
    <ul class="breadcrumb">
        <li class="active">皮肤选择</li>
    </ul>

    <div class="layout-list theme-list">
        <ul>
            <li class="skinBox <#if template_theme?? && template_theme=='00'>selected</#if>" data-themeid="00">
                <input type="hidden" name="themeId" value="00">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/00.png" alt=""/>
                        <s class="c1"></s>
                        <s class="c2"></s>
                        <b><i></i></b>
                    </div>
                </div>
            </li>

            <li class="skinBox <#if template_theme?? && template_theme=='01'>selected</#if>" data-themeid="01">
                <input type="hidden" name="themeId" value="01">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/01.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>

            <li class="skinBox <#if template_theme?? && template_theme=='02'>selected</#if>" data-themeid="02">
                <input type="hidden" name="themeId" value="02">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/02.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>

            <li class="skinBox <#if template_theme?? && template_theme=='03'>selected</#if>" data-themeid="03">
                <input type="hidden" name="themeId" value="03">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/03.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>

            <li class="skinBox <#if template_theme?? && template_theme=='04'>selected</#if>" data-themeid="04">
                <input type="hidden" name="themeId" value="04">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/04.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>

            <li class="skinBox <#if template_theme?? && template_theme=='06'>selected</#if>" data-themeid="06">
                <input type="hidden" name="themeId" value="06">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/06.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>
            <li class="skinBox <#if template_theme?? && template_theme=='07'>selected</#if>" data-themeid="07">
                <input type="hidden" name="themeId" value="07">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/07.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>
            <li class="skinBox <#if template_theme?? && template_theme=='08'>selected</#if>" data-themeid="08">
                <input type="hidden" name="themeId" value="08">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/08.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>
            <#--<li class="skinBox <#if template_theme?? && template_theme=='09'>selected</#if>" data-themeid="09">
                <input type="hidden" name="themeId" value="09">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/09.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>
            <li class="skinBox <#if template_theme?? && template_theme=='10'>selected</#if>" data-themeid="10">
                <input type="hidden" name="themeId" value="10">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/10.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>
            <li class="skinBox <#if template_theme?? && template_theme=='11'>selected</#if>" data-themeid="11">
                <input type="hidden" name="themeId" value="11">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/11.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>
            <li class="skinBox <#if template_theme?? && template_theme=='12'>selected</#if>" data-themeid="12">
                <input type="hidden" name="themeId" value="12">
                <div class="item">
                    <div class="pic">
                        <img src="${staticPath}/admin/images/themes/12.png" alt=""/>
                        <b><i></i></b>
                    </div>
                </div>
            </li>-->

            <#--<li>
				<div class="sucai-box <#if template_theme?? && template_theme=='00'>sucai-box-selected</#if>">
					<div class="pic">
						<img src="${staticPath}/admin/images/themes/00.png" alt=""/>
					</div>
					<div class="name">橄榄绿</div>
					<div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="00">
                </div>
            </li>
            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='01'>sucai-box-selected</#if>">
					<div class="pic"><img src="${staticPath}/admin/images/themes/01.png" alt=""/></div>
					<div class="name">贵族褐</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="01">
                </div>
            </li>
            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='02'>sucai-box-selected</#if>">
					<div class="pic"><img src="${staticPath}/admin/images/themes/02.png" alt=""/></div>
					<div class="name">撞色蓝</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="02">
                </div>
            </li>
            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='03'>sucai-box-selected</#if>">
					<div class="pic"><img src="${staticPath}/admin/images/themes/03.png" alt=""/></div>
					<div class="name">拼色黑</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="03">
				</div>
            </li>
            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='04'>sucai-box-selected</#if>">
					<div class="pic"><img src="${staticPath}/admin/images/themes/04.png" alt=""/></div>
					<div class="name">复古咖</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="04">
                </div>
            </li>
            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='06'>sucai-box-selected</#if>">
					<div class="pic"><img src="${staticPath}/admin/images/themes/06.png" alt=""/></div>
					<div class="name">清新绿</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="06">
                </div>
            </li>
            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='07'>sucai-box-selected</#if>">
					<div class="pic"><img src="${staticPath}/admin/images/themes/07.png" alt=""/></div>
					<div class="name">炫酷黑</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="07">
				</div>
            </li>


            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='08'>sucai-box-selected</#if>">
                    <div class="pic"><img src="${staticPath}/admin/images/themes/08.png" alt=""/></div>
                    <div class="name">活力蓝</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="08">
                </div>
            </li>


            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='09'>sucai-box-selected</#if>">
                    <div class="pic"><img src="${staticPath}/admin/images/themes/09.png" alt=""/></div>
                    <div class="name">自然褐</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="09">
                </div>
            </li>

            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='10'>sucai-box-selected</#if>">
                    <div class="pic"><img src="${staticPath}/admin/images/themes/10.png" alt=""/></div>
                    <div class="name">红黑配</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="10">
                </div>
            </li>

            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='11'>sucai-box-selected</#if>">
                    <div class="pic"><img src="${staticPath}/admin/images/themes/11.png" alt=""/></div>
                    <div class="name">粉嫩红</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="11">
                </div>
            </li>

            <li>
                <div class="sucai-box <#if template_theme?? && template_theme=='12'>sucai-box-selected</#if>">
                    <div class="pic"><img src="${staticPath}/admin/images/themes/12.png" alt=""/></div>
                    <div class="name">紫红蓝</div>
                    <div class="sucai-box-mask"><i></i></div>
                    <input type="hidden" name="themeId" value="12">
                </div>
            </li>-->
        </ul>
    </div>

    <div style="height: 50px;"></div>
    <#--<@securityAuthorize ifAnyGranted="decorate:template_skin">-->
        <div style="position: fixed; bottom: 0; left: 0; width: 100%;">
            <div class="actions-bar">
                <div class="form-actions" style="text-align: center">
                    <a href="javascript:confirmSelect();" id="submitbtn" class="button button-primary">确认</a>&nbsp;&nbsp;
                </div>
            </div>
        </div>
    <#--</@securityAuthorize>-->

</div>

<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/bui-min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/config-min.js"></script>
<script>
    var beforeSelectIndex=${template_theme?default('-1')};//之前所选择的位置索引
    var beforeSelectId="${template_theme?default('-1')}";//之前所选择的id
    $(function(){

        $('.theme-list').on('click','.skinBox',function(){
            $(".skinBox").removeClass('selected');

            beforeSelectIndex=$(".skinBox").index($(this));
            beforeSelectId=$("input[name='themeId']",this).first().val();
            $(this).toggleClass('selected');
        });
    });

    function confirmSelect(){
        if(beforeSelectIndex != -1)
        {
            var submitData={};
            submitData.template_theme=beforeSelectId;

            $.post('${ctx}/admin/sa/decorate/saveThemeManager',submitData,function(data) {
                $("#submitbtn").removeAttr("disabled");
                if (data.result == "success") {
                    BUI.Message.Alert("保存成功!");
                    return;
                } else {
                    BUI.Message.Alert(data.message || "操作失败");
                }
            },"json");
        }else{
            BUI.Message.Alert("请选择一个皮肤!");
            return false;
        }
    }
</script>
</body>
</html>