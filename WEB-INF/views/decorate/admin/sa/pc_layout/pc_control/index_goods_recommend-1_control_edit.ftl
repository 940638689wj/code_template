<#assign ctx = request.contextPath>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<#assign productControlSkuOffer = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SKU_OFFER_TYPE.type>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>
    <script type="text/javascript" src="${ctx}/static/admin/js/validator.js"></script>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <title></title>
    <script type="text/javascript">
        function assetChange(fileName, targetFileId){
            if(fileName == null || fileName.trim().length <= 0){
                BUI.Message.Alert("请选择文件!");
                return false;
            }

            var suffixIndex = fileName.lastIndexOf('.');
            if(suffixIndex <= 0){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            var suffix = fileName.substr(suffixIndex + 1);

            if(suffix.trim().length <= 0 ||
                    ("jpg" != suffix.trim().toLowerCase() && "png" != suffix.trim().toLowerCase())){
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            var uploader = $("#" + targetFileId);
            $.ajaxFileUpload({
                url:'${ctx}/common/staticAsset/upload/decorateControl',
                secureuri: false,
                fileElementId: targetFileId,
                dataType: "json",
                method : 'post',
                success: function (data, statusCd) {
                    loadImage(data.assetUrl, targetFileId);
                },
                error: function (data, statusCd, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function loadImage(assertUrl,targetFileId) {
            if(targetFileId == "titleImg"){
                $("#imgPath_"+targetFileId).val(assertUrl);
                var width = $("#imgArea_"+targetFileId).width();
                var imgDom = "<img style='width: "+width+"px;' src='"+assertUrl+"'/>";
                $("#imgArea_"+targetFileId).html(imgDom);
            } else {
                var targetFileDom = $("#"+ targetFileId);
                var targetFileType = $(targetFileDom).attr("data-file-type");
                var width = $(targetFileDom).parents(".productContent").find(("." + targetFileType)).width();
                var imgDom = "<img style='width: "+width+"px;' src='"+assertUrl+"'/>";
                $(targetFileDom).parents(".productContent").find(("." + targetFileType)).html(imgDom);
            }
        }

        function deletePic(targetContent, targetHref){
            var deletePicType = $(targetHref).attr("data-file-type");
            $(targetContent).find("." + deletePicType).html("<b>产品图</b>");
        }
    </script>
</head>
<body>
<form class="form-horizontal" id="controlContainerForm" method="POST" action="edit">
    <input type="hidden" name="id" value="${(control.id)!}"/>
    <input type="hidden" name="type" value="${type?default(productControlType)}">
    <input type="hidden" name="showType" value="${(showType)?default(productControlSkuOffer)}">
    <input type="hidden" name="cascadeProduct" value="0">

    <!-- 标题信息 -->
    <div class="control-group">
        <label class="control-label"><s>*</s>控件标题：</label>
        <div class="controls"><input class="control-text input-large" type="text" value="${(control.name)!?html}" name="name" data-rules="{required:true}"/></div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>是否显示标题：</label>
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
        <label class="control-label"><s>*</s>控件排序：</label>
        <div class="controls">
            <input value="${(control.sort)?default('0')}" name="sort" data-rules="{required:true,min:0,number:true}" class="input-normal control-text">
        </div>
    </div>
    <div class="control-group">
        <label class="control-label"><s>*</s>是否启用：</label>
    <#assign status = (control.statusCd)?default(1)>
        <input type="hidden" name="statusCd" value="${(control.statusCd)!?default(1)}">
        <div class="controls" name="statusCd">
            <label class="radio" for="usedRadio"><input <#if status == 1>checked="checked"</#if> id="usedRadio" type="radio" value="1" name="statusRadio">启用</label>&nbsp;&nbsp;&nbsp;
            <label class="radio" for="disabledRadio"><input <#if status == 0>checked="checked"</#if> id="disabledRadio" type="radio" value="0" name="statusRadio">禁用</label>
        </div>
    </div>
    <!-- 标题信息 END -->

    <hr>
    <div class="btn-add" style="padding-left: 50px;"><a href="javascript:void(0);" id="addHref">+亲，新增一张产品图</a></div>
    <div class="productModel" style="display: none;padding-left:50px;">
        <input type="hidden" data-param-obj-name="basicProducts" data-param-attr-name="id" value="">

        <input type="hidden" data-param-obj-name="basicProducts" data-param-attr-name="productImg" value="">

        <div class="clearfix">
            <h3 class="pull-left">第<span name="productCountSpan"></span>张</h3>
            <a name="productDelHref" class="pull-left offset1" href="javascript:void(0)">删除</a>
        </div>
        <div class="control-group">
            <div class="control-label control-label-auto">
                <input type="text" data-param-obj-name="basicProducts" data-param-attr-name="index" style="width: 105px;" class="control-text input-small" placeholder="排序值"/>
            </div>
            <div class="controls">
                <input type="text" data-param-obj-name="basicProducts" data-param-attr-name="productName" class="control-text input-large" placeholder="产品名称"/>
            </div>
        </div>
        <div class="control-group">
            <div class="control-label control-label-auto">
                <input type="text" data-param-obj-name="basicProducts" data-param-attr-name="defaultPrice" style="width: 105px;" class="control-text input-small" placeholder="产品价格"/>
            </div>
            <div class="controls">
                <input type="text" data-param-obj-name="basicProducts" data-param-attr-name="productInfo" class="control-text input-large" placeholder="产品信息描述"/>
            </div>
        </div>
        <div class="control-group">
            <div class="control-label control-label-auto">
                <div class="file-btn">
                    <button style="width: 120px;" class="button">上传产品图</button>
                    <input type="file" class="inp-file" name="picUrl" data-file-type="mainImg"/>
                </div>
            </div>
            <div class="controls control-row1">
                <input type="text" data-param-obj-name="basicProducts" data-param-attr-name="productLink" data-id="mainImgLinkUrl" class="control-text input-large" placeholder="产品链接地址"/>
            </div>
            <div class="bui-clear"></div>
            <p class="auxiliary-text">建议图片大小：790x400 像素</p>
        </div>
        <div class="zx-banner" style="width: 650px;">
            <div class="zx-banner-main mainImg">
                <b>产品图</b>
            </div>
        </div>
        <hr>
    </div>
    <div class="actions-bar" style="padding-left: 45px;">
        <div class="form-action">
            <button class="button button-large button-primary">保存</button>
        </div>
    </div>
</form>
<script type="text/javascript">

    BUI.use('common/page');

    $(function(){

        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#controlContainerForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
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
            }
        });
        form.on('beforesubmit', function(){
            return collectData(); //收集数据，以JSON字符串的形式传输
        });
        form.render();

        $(".btn-add").bind('click', function(){
            addProductContainer();
        })

        initProductContent();
    });

    function collectData(){
        var selectStatus = $("div[name='statusCd']").find("input[type='radio']:checked");
        if(!selectStatus || !selectStatus.length){
            BUI.Message.Alert("请选择控件状态!");
            return false;
        }
        $("input[name='statusCd']").val(selectStatus.val());

        var validResult = true;
        var validErrorInfo = "";
        var productContentObjs = $(".productContent");
        var productContentCount = productContentObjs.length;
        for(var i = 0; i < productContentCount; i++){
            var productContentSeq = $(productContentObjs[i]).find("input[data-param-attr-name='index']").val();
            productContentSeq = YrValidator.replaceAllSpace(productContentSeq);
            if(!YrValidator.isNotNegativeInteger(productContentSeq)){
                validResult = false;
                validErrorInfo = "产品排序值格式错误!";
                break;
            }

            var defaultPrice = $(productContentObjs[i]).find("input[data-param-attr-name='defaultPrice']").val();
            defaultPrice = YrValidator.replaceAllSpace(defaultPrice);
            if(!YrValidator.isPositiveFloatingPointNumber(defaultPrice)){
                validResult = false;
                validErrorInfo = "产品价格值格式错误!";
                break;
            }

            var mainImg = $(productContentObjs[i]).find(".mainImg").find("img").attr("src");
            $(productContentObjs[i]).find("input[data-param-attr-name='productImg']").val(mainImg);
        }

        if(!validResult){
            BUI.Message.Alert(validErrorInfo);
            return false;
        }

        return true;
    }

    //初始化
    function initProductContent(){
    <#if type = productControlType && (controlDTO.basicProducts)?has_content>
        <#list controlDTO.basicProducts as product>
            var productContainer = addProductContainer();
            productContainer.find("input[data-param-attr-name='index']").val('${(product.index)!}');
            productContainer.find("input[data-param-attr-name='productName']").val('${(product.productName)!}');
            productContainer.find("input[data-param-attr-name='productLink']").val('${(product.productLink)!}');
            productContainer.find("input[data-param-attr-name='defaultPrice']").val('${(product.defaultPrice)!?string(",##0.00")}');
            productContainer.find("input[data-param-attr-name='productInfo']").val('${(product.productInfo)!?html}');
            <#if (product.productImg)?has_content>
                loadImage("${(product.picUrl)!}", productContainer.find("input[data-file-type='mainImg']").attr("id"));
            </#if>
        </#list>
    </#if>
    }

    function addProductContainer(){
        var productContent = $(".productModel").clone();
        productContent.removeClass("productModel");
        productContent.addClass("productContent");
        var currentProductContentIndex = (getCurrentProductContentCount() + 1);
        productContent.attr("data-edit-index", currentProductContentIndex);
        productContent.find("span[name='productCountSpan']").html("【" + currentProductContentIndex + "】");

        productContent.find("input[data-param-obj-name]").each(function(){
            var objName = $(this).attr("data-param-obj-name");
            var attrName = $(this).attr("data-param-attr-name");
            $(this).attr("name", (objName + "[" + (currentProductContentIndex - 1) + "]." + attrName));
        });

        productContent.find("a[name='productDelHref']").bind('click', function(){
            deleteProductContent(productContent);
        });
        productContent.find("input[name='file']").each(function(){
            var fileType = $(this).attr("data-file-type");
            $(this).attr("id", (fileType + "_" + currentProductContentIndex));
        });
        productContent.find("input[name='file']").live('change', function(){
            assetChange($(this).val(), $(this).attr("id"));
        });
        productContent.insertBefore($("#addHref").parent());
        productContent.show();
        resetAddBtnTip();
        return productContent;
    }

    function getCurrentProductContentCount(){
        return $(".productContent").length;
    }

    function deleteProductContent(obj){
        var deleteProductContentIndex = $(obj).attr("data-edit-index");
        $(obj).remove();
        $(".productContent").each(function(){
            var index = $(this).attr("data-edit-index");
            if(parseInt(index) > parseInt(deleteProductContentIndex)){
                var newIndex = (parseInt(index) - 1);
                $(this).attr("data-edit-index", newIndex);
                $(this).find("span[name='productCountSpan']").html("【" + newIndex + "】");

                $(this).find("input[data-param-obj-name]").each(function(){
                    var objName = $(this).attr("data-param-obj-name");
                    var attrName = $(this).attr("data-param-attr-name");
                    $(this).attr("name", (objName + "[" + (newIndex - 1) + "]." + attrName));
                });

                $(this).find("input[type='file']").each(function(){
                    var fileType = $(this).attr("data-file-type");
                    $(this).attr("id", (fileType + "_" + newIndex));
                });
            }
        });
        resetAddBtnTip();
    }

    function resetAddBtnTip(){
        var tip = "+亲，再来一张产品图";
        if(getCurrentProductContentCount() == 0){
            tip = "+亲，新增一张产品图"
        }
        $("#addHref").html(tip);
    }
</script>
</body>
</html>