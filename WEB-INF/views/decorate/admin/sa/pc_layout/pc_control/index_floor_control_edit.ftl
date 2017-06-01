<#assign ctx = request.contextPath>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<#assign categoryControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].CATEGORY_RECOMMEND.type>
<#assign subCategoryTypeCategory = Static["cn.yr.chile.common.constant.BizConstants"].SUSPEND_NAV_SUB_CATEGORY_TYPE_CATEGORY>
<#assign subCategoryTypeBrand = Static["cn.yr.chile.common.constant.BizConstants"].SUSPEND_NAV_SUB_CATEGORY_TYPE_BRAND>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>
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
            var targetFileDom = $("#"+ targetFileId);
            var width = $(targetFileDom).parents(".picContent").find(("." + targetFileType)).width();
            var targetFileType = $(targetFileDom).attr("data-file-type");
            var imageDom = "<img style='width: "+width+"' src='"+assertUrl+"' alt=''/>";
            $(targetFileDom).parents(".picContent").find(("." + targetFileType)).html(imageDom);
        }
    </script>
</head>
<body>
    <form class="form-horizontal" id="controlContainerForm" method="POST" action="edit">
        <input type="hidden" name="id" value="${(control.id)!}"/>
        <input type="hidden" name="type" value="${type?default(productControlType)}">
        <input type="hidden" name="showType" value="${(showType)?default('')}">
        <input type="hidden" name="productIds" value="">
        <div class="control-group">
            <label class="control-label"><s>*</s>控件标题：</label>
            <div class="controls"><input class="control-text input-large" type="text" value="${(control.name)!?html}" name="name" data-rules="{required:true}"/></div>
        </div>
        <div class="control-group" style="display: none;">
            <label class="control-label"><s>*</s>是否显示标题：</label>
            <#assign nameStatus = "1">
            <#--<#if (control.showName)??>
                <#assign nameStatus = (control.showName)?string("1","0")>
            </#if>-->
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
        <div class="control-group" name="floorBgContainer">
            <label class="control-label">楼层标题背景图：</label>
            <div class="controls" style="height: auto;">
                <div class="spec-box" style="width: 680px;">
                    <div class="spec-con">
                        <div class="control-group picContent notInclude">
                            <div class="control-label control-label-auto">
                                <div class="file-btn">
                                    <input type="hidden" name="floorBg.picUrl" data-param-file-type="floorBg_url" data-pass-param data-param-obj-name="floorBg" data-param-attr-name="picUrl" value="">
                                    <button style="width: 150px;" class="button">上传楼层背景图</button>
                                    <input type="file" class="inp-file" name="file" id="floorBgFile" data-file-type="floorBg" onchange="javascript:assetChange(this.value,'floorBgFile')"/>
                                </div>
                            </div>
                            <div class="bui-clear"></div>
                            <p class="auxiliary-text">建议图片大小：194*88 像素</p>
                            <div class="zx-banner floorBg" style="width: 194px;margin-top: 10px;">
                                <b style="line-height: 88px;">图片预览</b>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">品牌：</label>
            <div class="controls" style="height: auto;">
                <div class="spec-box" style="width: 680px;">
                    <div> <!--Model-->
                        <div class="spec-con">
                            <ul>
                                <li class="subCategoryModel" style="display: none;">
                                    <input type="hidden" data-pass-param data-param-obj-name="brands" data-param-attr-name="scType" value="">
                                    <input type="hidden" data-pass-param data-param-obj-name="brands" data-param-attr-name="scId" value="">
                                    <div class="spec-item"><span>红色</span><a href="javascript:void(0)" onclick="javascript:deleteSubCategory(this);">×</a></div>
                                </li>
                                <li>
                                    <div class="add-new">
                                        <a class="link" href="javascript:void(0)" onclick="javascript:addSubCategory(this);">+选择品牌</a>
                                        <div class="layer" style="width: 342px; display: none;left:-100px;">
                                            <select data-dom-name="productBrand" style="width:120px;">
                                                <option value="-1">请选择品牌</option>
                                                <#if allProductBrandList?has_content>
                                                    <#assign selectedCategoryId = -1>
                                                    <#list allProductBrandList as productBrand>
                                                        <option value="${productBrand.brandId}">${(productBrand.brandName)!?html}</option>
                                                    </#list>
                                                </#if>
                                            </select>
                                            <a href="javascript:void(0)" name="saveSubCategoryBtn" onclick="javascript:saveSubCategory(this);" class="button button-primary">保存</a>&nbsp;
                                            <a href="javascript:void(0)" onclick="$(this).parent('.layer').hide();" class="button">取消</a>
                                            <b class="arr" style="margin-left: -70px;"><s></s></b>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">标签：</label>
            <div class="controls" style="height: auto;">
                <div class="spec-box" style="width: 680px;">
                    <div style="display: none;"> <!--Model-->
                        <input type="hidden" data-pass-param data-param-obj-name="labels" data-param-attr-name="index" value="">
                        <div class="spec-title">
                            <h3>标签： <input type="text" data-pass-param data-param-obj-name="labels" data-param-attr-name="name"/>
                                <span style="padding-left: 15px;">标签链接： <input type="text" data-pass-param data-param-obj-name="labels" data-param-attr-name="linkUrl"/></span>
                            </h3><a href="javascript:void(0)" onclick="javascript:deleteOther(this);">×</a></div>
                        <hr/>
                    </div>
                    <button name="addCategoryLabelBtn" data-add-type="label" type="button" class="button button-primary">+新增标签</button>
                </div>
            </div>
        </div>
        <div class="control-group" name="leftMainImgContainer">
            <label class="control-label">上传左侧大图：</label>
            <div class="controls" style="height: auto;">
                <div class="spec-box" style="width: 680px;">
                    <div class="spec-con">
                        <div class="control-group picContent notInclude">
                            <div class="control-label control-label-auto">
                                <div class="file-btn">
                                    <input type="hidden" data-param-file-type="leftMainImg_url" name="leftMainImg.picUrl" data-pass-param data-param-obj-name="leftMainImg" data-param-attr-name="picUrl" value="">
                                    <button style="width: 120px;" class="button">上传左侧大图</button>
                                    <input type="file" class="inp-file" name="file" id="leftMainImgFile" data-file-type="leftMainImg" onchange="javascript:assetChange(this.value,'leftMainImgFile')"/>
                                </div>
                            </div>
                            <div class="controls control-row1">
                                <input type="text" name="leftMainImg.linkUrl" data-pass-param data-param-obj-name="leftMainImg" data-param-attr-name="linkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                            </div>
                            <div class="bui-clear"></div>
                            <p class="auxiliary-text">建议图片大小：368*368 像素</p>
                            <div class="zx-banner leftMainImg" style="width: 368px;margin-top: 10px;">
                                <b style="line-height: 368px;">图片预览</b>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">上传商品图片：</label>
            <div class="controls" style="height: auto;">
                <div class="spec-box" style="width: 680px;">
                    <div style="display: none;">
                        <div class="spec-title"><h3 style="height: 20px;"></h3><a href="javascript:void(0)" onclick="javascript:deletePic(this);">×</a></div>
                        <div class="spec-con">
                            <div class="control-group">
                                <div class="control-label control-label-auto">
                                    <div class="file-btn">
                                        <input type="hidden" data-param-file-type="middleImg_url" data-pass-param data-param-obj-name="middleImgs" data-param-attr-name="picUrl" value="">
                                        <button style="width: 120px;" class="button">上传图片</button>
                                        <input type="file" class="inp-file" name="file" data-file-type="middleImg"/>
                                    </div>
                                </div>
                                <div class="controls control-row1">
                                    <input type="text" data-pass-param data-param-obj-name="middleImgs" data-param-attr-name="linkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                                    <input type="text" data-pass-param data-param-obj-name="middleImgs" data-param-attr-name="index" style="width: 105px;" class="control-text input-small" placeholder="排序值"/>
                                </div>
                                <div class="bui-clear"></div>
                                <p class="auxiliary-text">建议图片大小：160*180 像素</p>
                                <div class="zx-banner middleImg" style="width: 160px;margin-top: 10px;">
                                    <b style="line-height: 100px;">图片预览</b>
                                </div>
                            </div>
                        </div>
                        <hr/>
                    </div>
                    <button name="addPicBtn" type="button" class="button button-primary">+新增图片</button>
                </div>
            </div>
        </div>
        <div class="control-group" name="rightMainImgContainer">
            <label class="control-label">上传右侧大图：</label>
            <div class="controls" style="height: auto;">
                <div class="spec-box" style="width: 680px;">
                    <div class="spec-con">
                        <div class="control-group picContent notInclude">
                            <div class="control-label control-label-auto">
                                <div class="file-btn">
                                    <input type="hidden" data-param-file-type="rightMainImg_url" name="rightMainImg.picUrl" data-pass-param data-param-obj-name="rightMainImg" data-param-attr-name="picUrl" value="">
                                    <button style="width: 120px;" class="button">上传右侧大图</button>
                                    <input type="file" class="inp-file" name="file" id="rightMainImgFile" data-file-type="rightMainImg" onchange="javascript:assetChange(this.value,'rightMainImgFile')"/>
                                </div>
                            </div>
                            <div class="controls control-row1">
                                <input type="text" name="rightMainImg.linkUrl" data-pass-param data-param-obj-name="rightMainImg" data-param-attr-name="linkUrl" class="control-text input-large" placeholder="点击图片跳转的地址"/>
                            </div>
                            <div class="bui-clear"></div>
                            <p class="auxiliary-text">建议图片大小：158*368 像素</p>
                            <div class="zx-banner rightMainImg" style="width: 368px;margin-top: 10px;">
                                <b style="line-height: 368px;">图片预览</b>
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

            $("button[name='addCategoryLabelBtn']").on('click', function(){
                addOther($(this));
            });

            $("button[name='addPicBtn']").on('click', function(){
                addPic($(this));
            });

            initDecorateControl();
        });

        function initDecorateControl(){
            loadImage('${(controlDTO.floorBg.picUrl)!}', "floorBgFile");
            <#if (controlDTO.brands)?has_content>
                <#list (controlDTO.brands) as brand>
                    var scType = '${(brand.scType)!?upper_case}';
                    var scId = '${(brand.scId)!}';
                    var scTxt = '${(brand.scText)!?html}';
                    if(scTxt != ""){
                        var targetModel = $(".subCategoryModel");
                        var subCategoryContent = targetModel.clone();
                        subCategoryContent.removeClass("subCategoryModel");
                        subCategoryContent.addClass("subCategory");
                        subCategoryContent.find("input[data-param-attr-name='scType']").val(scType);
                        subCategoryContent.find("input[data-param-attr-name='scId']").val(scId);
                        subCategoryContent.find(".spec-item").children("span").html(scTxt);
                        subCategoryContent.insertBefore(targetModel);
                        subCategoryContent.show();
                    }
                </#list>
            </#if>
            <#if (controlDTO.leftMainImg.linkUrl)?has_content>
                $("input[name='leftMainImg.linkUrl']").val('${(controlDTO.leftMainImg.linkUrl)!}')
            </#if>
            loadImage('${(controlDTO.leftMainImg.picUrl)!}', "leftMainImgFile");
            <#if (controlDTO.rightMainImg.linkUrl)?has_content>
                $("input[name='rightMainImg.linkUrl']").val('${(controlDTO.rightMainImg.linkUrl)!}')
            </#if>
            loadImage('${(controlDTO.rightMainImg.picUrl)!}', "rightMainImgFile");
            <#if (controlDTO.labels)?has_content>
                <#list (controlDTO.labels) as label>
                    var picContent = addOther($("button[name='addCategoryLabelBtn']"));
                    picContent.find("input[data-param-attr-name='index']").val('${(label.index)?default(0)}');
                    picContent.find("input[data-param-attr-name='name']").val('${(label.name)!?html}');
                    picContent.find("input[data-param-attr-name='linkUrl']").val('${(label.linkUrl)!}');
                </#list>
            </#if>
            <#if (controlDTO.middleImgs)?has_content>
                <#list (controlDTO.middleImgs) as middleImg>
                    var picContent = addPic($("button[name='addPicBtn']"));
                    picContent.find("input[data-param-attr-name='index']").val('${(middleImg.index)?default(0)}');
                    picContent.find("input[data-param-attr-name='name']").val('${(middleImg.name)!?html}');
                    picContent.find("input[data-param-attr-name='linkUrl']").val('${(middleImg.linkUrl)!}');
                    var fileId = picContent.find("input[data-file-type='middleImg']").attr("id");
                    loadImage('${(middleImg.picUrl)!}', fileId);
                </#list>
            </#if>
        }

        function collectData(){
            var selectStatus = $("div[name='statusCd']").find("input[type='radio']:checked");
            if(!selectStatus || !selectStatus.length){
                BUI.Message.Alert("请选择控件状态!");
                return false;
            }
            $("input[name='statusCd']").val(selectStatus.val());

            var index = 0;
            $(".subCategory").each(function(){
                var subIndex = 0;
                $(this).find("input[data-pass-param]").each(function(){
                    var name = $(this).attr("data-param-attr-name");
                    var objName = $(this).attr("data-param-obj-name");
                    if(objName){
                        name = objName +"[" + (index) + "]." + name;
                    }
                    $(this).attr("name", name);
                });
                subIndex = subIndex + 1;

               index = index + 1;
            });

            var labelCount = $(".addContent_label").length;
            if(labelCount > 6){
                BUI.Message.Alert("最多支持6个标签设置!");
                return false;
            }
            var index = 0;
            $(".addContent_label").each(function(){
                $(this).find("input[data-param-attr-name='index']").val(index);
                $(this).find("input[data-pass-param]").each(function(){
                    var name = $(this).attr("data-param-attr-name");
                    var objName = $(this).attr("data-param-obj-name");
                    if(objName){
                        name = objName +"[" + (index) + "]." + name;
                    }
                    $(this).attr("name", name);
                });
                index = index + 1;
            });

            var floorBgImgUrl = $(".floorBg").find("img").attr("src");
            if(floorBgImgUrl){
                $("input[data-param-file-type='floorBg_url']").val(floorBgImgUrl);
            }

            var leftMainImgUrl = $(".leftMainImg").find("img").attr("src");

            if(leftMainImgUrl){
                $("input[data-param-file-type='leftMainImg_url']").val(leftMainImgUrl);
            }

            var rightMainImgUrl = $(".rightMainImg").find("img").attr("src");

            if(rightMainImgUrl){
                $("input[data-param-file-type='rightMainImg_url']").val(rightMainImgUrl);
            }


            var picCount = $(".picContent").not(".notInclude").length;
            if(picCount > 6){
                BUI.Message.Alert("中间图片最多支持6张!");
                return false;
            }
            index = 0;
            $(".picContent").not(".notInclude").each(function(){
                var fileType = $(this).find("input[type='file']").attr("data-file-type");
                var fileImgUrl = $(this).find(("." + fileType)).find("img").attr("src");
                if(fileImgUrl){
                    $(this).find("input[data-param-file-type='"+fileType+"_url']").val(fileImgUrl);
                }
                $(this).find("input[data-pass-param]").each(function(){
                    var objName = $(this).attr("data-param-obj-name");
                    var attrName = $(this).attr("data-param-attr-name");
                    var name = attrName;
                    if(objName){
                        name = objName +"[" + (index) + "]." + attrName;
                    }
                    $(this).attr("name", name);
                });
                index = index + 1;
            });
            return true;
        }

        function addPic(obj){
            var targetPic = $(obj).prev("div");
            var picContent = targetPic.clone();
            picContent.addClass("picContent");
            var picTabId = generatePicTabId();
            picContent.attr("data-pic-tab-id", picTabId);
            picContent.find("input[name='file']").each(function(){
                var fileType = $(this).attr("data-file-type");
                $(this).attr("id", (fileType + "_" + picTabId));
            });
            picContent.find("input[name='file']").each(function(){
                var fileId = $(this).attr("id");
               $(this).attr("onchange", "javascript:assetChange($(this).val(),'" + fileId + "')");
            });
            picContent.insertBefore(targetPic);
            picContent.show();
            toggleAddPicBtn();
            return picContent;
        }

        function saveSubCategory(obj){
            var temp1 = $(obj).parent().find("select[data-dom-name='productBrand']");
            var subCategoryId = temp1.val();
            var subCategoryText = temp1.find("option:selected").text();
            if(subCategoryId == "-1"){
                BUI.Message.Alert("请选择品牌!");
                return false;
            }
            var targetModel = $(obj).parents("li").prev(".subCategoryModel");
            var subCategoryContent = targetModel.clone();
            subCategoryContent.removeClass("subCategoryModel");
            subCategoryContent.addClass("subCategory");
            subCategoryContent.find("input[data-param-attr-name='scId']").val(subCategoryId);
            subCategoryContent.find(".spec-item").children("span").html(subCategoryText);
            subCategoryContent.insertBefore(targetModel);
            resetSubCategoryLayer($(obj).parent());
            $(obj).parent().hide();
            subCategoryContent.show();
        }

        function generatePicTabId() {
            var returnTabId = null;
            while(returnTabId == null){
                var tabId = parseInt(Math.random() * (600 - 10) + 10);
                var isRepeat = false;
                $(".picContent").each(function(){
                    var pId = $(this).attr("data-pic-tab-id");
                    if(pId && pId != ""){
                        pId = parseInt(pId);
                        if(tabId == pId){
                            isRepeat = true;
                            return false;
                        }
                    }
                });
                if(!isRepeat){
                    returnTabId = tabId;
                }
            }
            return returnTabId;
        }

        function resetSubCategoryLayer(target){
            $(target).children("input").val("");
        }

        function deleteCategory(obj){
            $(obj).parent().parent().remove();
        }

        function deletePic(obj){
            $(obj).parent().parent().remove();
            toggleAddPicBtn();
        }

        function deleteSubCategory(obj){
            $(obj).parent().parent().remove();
        }

        function addSubCategory(obj){
            $(obj).next('.layer').show();
        }

        function changePicName(obj){

        }

        function addOther(obj){
            var addType = $(obj).attr("data-add-type");
            var targetDom = $(obj).prev("div");
            var targetDomContent = targetDom.clone();
            targetDomContent.addClass("addContent_" + addType);
            var otherContentId = generateUniqueIdForDom(("addContent_" + addType), "data-other-id");
            targetDomContent.attr("data-other-id", otherContentId);
            targetDomContent.attr("data-obj-name", addType);
            targetDomContent.insertBefore(targetDom);
            targetDomContent.show();
            toggleAddLabelBtn();
            return targetDomContent;
        }

        function deleteOther(obj){
            $(obj).parent().parent().remove();
            toggleAddLabelBtn();
        }

        function generateUniqueIdForDom(domClass, idAttr) {
            var returnTabId = null;
            while(returnTabId == null){
                var tabId = parseInt(Math.random() * (600 - 10) + 10);
                var isRepeat = false;
                $("." + domClass).each(function(){
                    var pId = $(this).attr(idAttr);
                    if(pId && pId != ""){
                        pId = parseInt(pId);
                        if(tabId == pId){
                            isRepeat = true;
                            return false;
                        }
                    }
                });
                if(!isRepeat){
                    returnTabId = tabId;
                }
            }
            return returnTabId;
        }

        function toggleAddLabelBtn(){
            var currentLabelCount = $(".addContent_label").length;
            if(currentLabelCount == 6){
                $("button[name='addCategoryLabelBtn']").hide();
            } else {
                $("button[name='addCategoryLabelBtn']").show();
            }
        }

        function toggleAddPicBtn(){
            var currentPicCount = $(".picContent").not(".notInclude").length;
            if(currentPicCount == 6){
                $("button[name='addPicBtn']").hide();
            } else {
                $("button[name='addPicBtn']").show();
            }
        }
    </script>
</body>
</html>