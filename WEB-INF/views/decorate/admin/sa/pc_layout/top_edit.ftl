<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<#assign suspendNavJsonType = Static["cn.yr.chile.common.constant.BizConstants"].SYSTEM_DATA_STRUCTURE_JSON>
<#assign suspendNavHtmlType = Static["cn.yr.chile.common.constant.BizConstants"].SYSTEM_DATA_STRUCTURE_HTML>
<#assign suspendNavCategoryTypeCategory = Static["cn.yr.chile.common.constant.BizConstants"].SUSPEND_NAV_SUB_CATEGORY_TYPE_CATEGORY>
<#assign suspendNavCategoryTypeBrand = Static["cn.yr.chile.common.constant.BizConstants"].SUSPEND_NAV_SUB_CATEGORY_TYPE_BRAND>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <link href="${ctx}/static/admin/css/decoration.css" rel="stylesheet" type="text/css"/>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
    <title></title>
</head>
<body>
<div class="container">
    <div id="tab">
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">商城头部</span></li>
        </ul>
    </div>

    <iframe name="topIframe" id="J_Iframe" src="${ctx}/admin/sa/pc/decorate/topEdit/iFrame" frameborder="0"
            style="width: 1200px;height: 250px;"></iframe>


    <div class="form-horizontal zx-form siteNavContentModel" style="display: none;">
        <input type="hidden" name="suspendNavLeftPicUrl" value="">
        <input type="hidden" name="suspendNavLeftLinkUrl" value="">
        <input type="hidden" name="suspendNavLeftNewWin" value="">
        <div class="control-group">
            <label class="control-label">菜单名称：</label>
            <div class="controls">
                <input class="input-normal" type="text" name="siteNavName"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">菜单排序：</label>
            <div class="controls">
                <input class="input-normal" type="text" name="siteNavOrder"/>
            </div>
        </div>
        <div class="control-group">
            <label class="control-label">菜单链接地址：</label>
            <div class="controls">
                <input class="input-large" type="text" name="siteNavUrl"/> &nbsp;&nbsp;
            </div>
        </div>
    </div>
    <form id="topContainerForm" class="form-horizontal" action="${ctx}/admin/sa/pc/decorate/topEdit/save" method="POST">
        <input type="hidden" name="topAd" value="">
        <input type="hidden" name="logoExtra" value="">
        <input type="hidden" name="headerSearchRight" value="">
        <input type="hidden" name="nav" value="">
        <input type="hidden" name="topToolsContent" value="">
        <input type="hidden" name="topLinksContent" value="">
        <input type="hidden" name="hotSearchContent" value="">
        <input type="hidden" name="topType" value="${topType?default('')}">
        <div class="actions-bar">
            <div class="form-actions">
                <button type="submit" class="button button-primary">保存</button>
            </div>
        </div>

    </form>


    <div id="topToolsContent" style="display: none;">
        <div id="topToolsTabContent">
            <ul class="bui-tab link-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected baiDuEditorHref" aria-disabled="false"
                    aria-pressed="false">
                    <a href="javascript:void(0);" onclick="javascript:switchToBasicTab('topToolsTabContent');">富文本</a>
                </li>
                <li class="bui-tab-item bui-tab-item-hover txtAreaEditorHref" aria-disabled="false"
                    aria-pressed="false">
                    <a href="javascript:void(0);"
                       onclick="javascript:switchToAdvancedTab('topToolsTabContent');">纯文本</a>
                </li>
            </ul>
        </div>
        <input type="hidden" id="topToolsContentType" name="contentType" value="1">
        <div class="form-content">
            <div name="baiDuEditor" class="row">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <script type="text/plain" id="topToolsEditor" name="content">${topLeftHtml!}</script>
                    </div>
                </div>
            </div>
            <div name="txtAreaEditor" class="row hide">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <textarea id="topToolsAdvancedContent" name="advancedContent"
                                  style="height: 350px;width: 700px;">${topLeftHtml!}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="hotSearchContent" style="display: none;">
        <div id="hotSearchTabContent">
            <ul class="bui-tab link-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected baiDuEditorHref" aria-disabled="false"
                    aria-pressed="false">
                    <a href="javascript:void(0);" onclick="javascript:switchToBasicTab('hotSearchTabContent');">富文本</a>
                </li>
                <li class="bui-tab-item bui-tab-item-hover txtAreaEditorHref" aria-disabled="false"
                    aria-pressed="false">
                    <a href="javascript:void(0);"
                       onclick="javascript:switchToAdvancedTab('hotSearchTabContent');">纯文本</a>
                </li>
            </ul>
        </div>
        <input type="hidden" id="hotSearchContentType" name="contentType" value="1">
        <div class="form-content">
            <div name="baiDuEditor" class="row">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <script type="text/plain" id="hotSearchEditor" name="content">${hotSearchHtml!}</script>
                    </div>
                </div>
            </div>
            <div name="txtAreaEditor" class="row hide">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <textarea id="hotSearchAdvancedContent" name="advancedContent"
                                  style="height: 350px;width: 700px;">${hotSearchHtml!}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="topLinksContent" style="display: none;">
        <div id="topLinksTabContent">
            <ul class="bui-tab link-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected baiDuEditorHref" aria-disabled="false"
                    aria-pressed="false">
                    <a href="javascript:void(0);" onclick="javascript:switchToBasicTab('topLinksTabContent');">富文本</a>
                </li>
                <li class="bui-tab-item bui-tab-item-hover txtAreaEditorHref" aria-disabled="false"
                    aria-pressed="false">
                    <a href="javascript:void(0);"
                       onclick="javascript:switchToAdvancedTab('topLinksTabContent');">纯文本</a>
                </li>
            </ul>
        </div>
        <input type="hidden" id="topLinksContentType" name="contentType" value="1">
        <div class="form-content">
            <div name="baiDuEditor" class="row">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <script type="text/plain" id="topLinksEditor" name="content">${topRightHtml!}</script>
                    </div>
                </div>
            </div>
            <div name="txtAreaEditor" class="row hide">
                <div class="control-group">
                    <div class="controls control-row-auto">
                        <textarea id="topLinksAdvancedContent" name="advancedContent"
                                  style="height: 350px;width: 700px;">${topRightHtml!}</textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        BUI.use('common/page');

        var topToolsEditor;
        var topLinksEditor;
        var hotSearchEditor;

        var Overlay = BUI.Overlay;
        topAdDialog = new Overlay.Dialog({
            title: '编辑顶部广告栏',
            width: 800,
            height: 330,
            //配置DOM容器的编号
            contentId: 'topAdContent',
            success: function () {
                var topAdPicUrl = $("#imageView_topAdPic").attr("src");
                $("#J_Iframe")[0].contentWindow.fillTopAdElement(topAdPicUrl);
                this.hide();
            }
        });
        topToolsDialog = new Overlay.Dialog({
            title: '编辑顶部工具栏',
            width: 760,
            height: 400,
            //配置DOM容器的编号
            contentId: 'topToolsContent',
            success: function () {
                var topToolsContent;
                var topToolsContentType = $("#topToolsContentType").val();
                if (topToolsContentType == "2") {
                    topToolsContent = $("#topToolsAdvancedContent").val();
                } else {
                    topToolsContent = topToolsEditor.getContent();
                }
                $("#J_Iframe")[0].contentWindow.fillTopToolsElement(topToolsContent);
                this.hide();
            }
        });
        hotSearchDialog = new Overlay.Dialog({
            title: '编辑搜索关键字',
            width: 760,
            height: 400,
            //配置DOM容器的编号
            contentId: 'hotSearchContent',
            success: function () {
                var hotSearchContent;
                var hotSearchContentType = $("#hotSearchContentType").val();
                if (hotSearchContentType == "2") {
                    hotSearchContent = $("#hotSearchAdvancedContent").val();
                } else {
                    hotSearchContent = hotSearchEditor.getContent();
                }
                $("#J_Iframe")[0].contentWindow.fillHotSearchElement(hotSearchContent);
                this.hide();
            }
        });
        topLinksDialog = new Overlay.Dialog({
            title: '编辑顶部链接栏',
            width: 760,
            height: 400,
            //配置DOM容器的编号
            contentId: 'topLinksContent',
            success: function () {
                var topLinksContent;
                var topLinksContentType = $("#topLinksContentType").val();
                if (topLinksContentType == "2") {
                    topLinksContent = $("#topLinksAdvancedContent").val();
                } else {
                    topLinksContent = topLinksEditor.getContent();
                }
                $("#J_Iframe")[0].contentWindow.fillTopLinksElement(topLinksContent);
                this.hide();
            }
        });


        $(function () {

            var Form = BUI.Form;
            var form = new Form.Form({
                srcNode: '#topContainerForm',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("商城头部保存成功!");
                    }
                }
            });
            form.on('beforesubmit', function () {
                return collectData(); //收集数据，以JSON字符串的形式传输
            });
            form.render();

            var initWidth = 700;
            topToolsEditor = new UE.ui.Editor({
                initialFrameWidth: initWidth,
                initialFrameHeight: 350,
                allowDivTransToP: false
            });
            topToolsEditor.render("topToolsEditor");
            topLinksEditor = new UE.ui.Editor({
                initialFrameWidth: initWidth,
                initialFrameHeight: 350,
                allowDivTransToP: false
            });
            topLinksEditor.render("topLinksEditor");
            hotSearchEditor = new UE.ui.Editor({
                initialFrameWidth: initWidth,
                initialFrameHeight: 350,
                allowDivTransToP: false
            });
            hotSearchEditor.render("hotSearchEditor");

            var iframeLoadSuccess;
            var navLoadSuccess;
            var m = setInterval(function () {
                try {
                    if (!iframeLoadSuccess) {
                        initIframeElement();
                        iframeLoadSuccess = true;
                    }
                } catch (ex) {
                    console.log(ex);
                    iframeLoadSuccess = false;
                }
                try {
                    if (!navLoadSuccess) {
                        initNavElement();
                        navLoadSuccess = true;
                    }
                } catch (e) {
                    console.log(e);
                    navLoadSuccess = false;
                }
                if (iframeLoadSuccess && navLoadSuccess) {
                    clearInterval(m);
                }
            }, 100);
        });

        function addSuspendCategory(obj) {
            var targetSuspendCategory = $(obj).prev("div");
            var suspendNavCategoryContent = targetSuspendCategory.clone();
            suspendNavCategoryContent.addClass("suspendNavCategory");
            suspendNavCategoryContent.insertBefore(targetSuspendCategory);
            suspendNavCategoryContent.show();
            return suspendNavCategoryContent;
        }

        function addSuspendNavLowerCategory(obj) {
            $(obj).next('.layer').show();
        }

        function deleteSuspendNavCategory(obj) {
            $(obj).parent().parent().remove();
        }

        function deleteSuspendNavLowerCategory(obj) {
            $(obj).parent().parent().remove();
        }

        function changeLowerCategoryType(obj) {
            var selectedType = $(obj).val();
            if ("${suspendNavCategoryTypeCategory}" == selectedType) {
                $(obj).parent().find("select[name='productBrand']").hide();
                $(obj).parent().find("select[name='productCategory']").show();
            } else if ("${suspendNavCategoryTypeBrand}" == selectedType) {
                $(obj).parent().find("select[name='productCategory']").hide();
                $(obj).parent().find("select[name='productBrand']").show();
            }
        }

        function saveSuspendNavLowerCategory(obj) {
            var lowerCategoryType = $(obj).parent().find("select[name='lowerCategoryType']").val();
            var lowerCategoryId = "-1";
            var lowerCategoryText = "";
            if ("CATEGORY" == lowerCategoryType) {
                var temp = $(obj).parent().find("select[name='productCategory']");
                lowerCategoryId = temp.val();
                lowerCategoryText = temp.find("option:selected").text();
            } else if ("BRAND" == lowerCategoryType) {
                var temp1 = $(obj).parent().find("select[name='productBrand']");
                lowerCategoryId = temp1.val();
                lowerCategoryText = temp1.find("option:selected").text();
            }
            if (lowerCategoryId == "-1") {
                BUI.Message.Alert("请选择添加的类别!");
                return false;
            }
            var targetModel = $(obj).parents("li").prev(".lowerCategoryModel");
            var lowerCategoryContent = targetModel.clone();
            lowerCategoryContent.removeClass("lowerCategoryModel");
            lowerCategoryContent.addClass("lowerCategory");
            lowerCategoryContent.attr("data-lower-category-type", lowerCategoryType);
            lowerCategoryContent.attr("data-lower-category-id", lowerCategoryId);
            lowerCategoryContent.find(".spec-item").children("span").html(lowerCategoryText);
            lowerCategoryContent.insertBefore(targetModel);
            resetLowerCategoryLayer($(obj).parent());
            $(obj).parent().hide();
            lowerCategoryContent.show();
        }

        function resetLowerCategoryLayer(target) {
            $(target).children("input").val("");
        }


        function editElement(obj) {
            var $$this = $(obj);
            var editType = $$this.attr("data-edit-type");
            if ("topAd" == editType) {
                topAdDialog.show();
            } else if ("logoExtra" == editType) {
                logoExtraDialog.show();
            } else if ("headerSearchRight" == editType) {
                headerSearchRightDialog.show();
            } else if ("siteNav" == editType) {
                var editIndex = $$this.attr("data-edit-index");
                showSiteNavContent(editIndex);
            } else if ("topTools" == editType) {
                topToolsDialog.show();
            } else if ("topLinks" == editType) {
                topLinksDialog.show();
            } else if ("hotSearch" == editType) {
                hotSearchDialog.show();
            }
        }

        function deleteElement(obj) {
            var $$$this = $(obj);
            var editType = $$$this.attr("data-edit-type");
            if ("topAd" == editType) {
                $("#imageView_topAdPic").attr("src", "");
                $("#topAdLinkUrl").val("");
                $("#topAdNewWin").removeAttr("checked");
                var iframeTopAdView = $("#J_Iframe").contents().find("#topad");
                iframeTopAdView.children("div").addClass("zx-placeholder");
                iframeTopAdView.find("label").show();
                iframeTopAdView.find("img").removeAttr("width");
                iframeTopAdView.find("img").attr("src", "");
            } else if ("logoExtra" == editType) {
                $("#imageView_logoExtraPic").attr("src", "");
                $("#logoExtraLinkUrl").val("");
                $("#logoExtraNewWin").removeAttr("checked");
                var iframeTopAdView = $("#J_Iframe").contents().find("#logoExtra");
                iframeTopAdView.addClass("zx-placeholder");
                iframeTopAdView.find("label").show();
                iframeTopAdView.find("img").removeAttr("width");
                iframeTopAdView.find("img").attr("src", "");
            } else if ("headerSearchRight" == editType) {
                $("#imageView_headerSearchRightPic").attr("src", "");
                $("#headerSearchRightLinkUrl").val("");
                $("#headerSearchRightNewWin").removeAttr("checked");
                var iframeTopAdView = $("#J_Iframe").contents().find("#headerSearchRight");
                iframeTopAdView.addClass("zx-placeholder");
                iframeTopAdView.find("label").show();
                iframeTopAdView.find("img").removeAttr("width");
                iframeTopAdView.find("img").attr("src", "");
            } else if ("siteNav" == editType) {
                var editIndex = $$$this.attr("data-edit-index");
                deleteSiteNavContent(editIndex);
            }
        }

        function deleteElement(obj) {
            var $$$this = $(obj);
            var editType = $$$this.attr("data-edit-type");
            if ("topAd" == editType) {
                $("#imageView_topAdPic").attr("src", "");
                $("#topAdLinkUrl").val("");
                $("#topAdNewWin").removeAttr("checked");
                var iframeTopAdView = $("#J_Iframe").contents().find("#topad");
                iframeTopAdView.children("div").addClass("zx-placeholder");
                iframeTopAdView.find("label").show();
                iframeTopAdView.find("img").removeAttr("width");
                iframeTopAdView.find("img").attr("src", "");
            } else if ("logoExtra" == editType) {
                $("#imageView_logoExtraPic").attr("src", "");
                $("#logoExtraLinkUrl").val("");
                $("#logoExtraNewWin").removeAttr("checked");
                var iframeTopAdView = $("#J_Iframe").contents().find("#logoExtra");
                iframeTopAdView.addClass("zx-placeholder");
                iframeTopAdView.find("label").show();
                iframeTopAdView.find("img").removeAttr("width");
                iframeTopAdView.find("img").attr("src", "");
            } else if ("headerSearchRight" == editType) {
                $("#imageView_headerSearchRightPic").attr("src", "");
                $("#headerSearchRightLinkUrl").val("");
                $("#headerSearchRightNewWin").removeAttr("checked");
                var iframeTopAdView = $("#J_Iframe").contents().find("#headerSearchRight");
                iframeTopAdView.addClass("zx-placeholder");
                iframeTopAdView.find("label").show();
                iframeTopAdView.find("img").removeAttr("width");
                iframeTopAdView.find("img").attr("src", "");
            } else if ("siteNav" == editType) {
                var editIndex = $$$this.attr("data-edit-index");
                deleteSiteNavContent(editIndex);
            }
        }

        function showSiteNavContent(navIndex) {
            var siteNavContent = $("#siteNavContent_" + navIndex);
            if (!siteNavContent || !siteNavContent.length) {
                siteNavContent = $(".siteNavContentModel").clone();
                siteNavContent.removeClass("siteNavContentModel");
                siteNavContent.addClass("siteNavContent");
                siteNavContent.attr("data-edit-index", navIndex);
                siteNavContent.attr("id", ("siteNavContent_" + navIndex));
                siteNavContent.find("input[name='siteNavName']").val("菜单" + navIndex);
                siteNavContent.find("input[name='siteNavName']").bind("change", function () {
                    changeSiteNavName(this);
                });
                siteNavContent.find("input[name='siteNavName']").bind("blur", function () {
                    changeSiteNavName(this);
                });
                siteNavContent.insertBefore($(".siteNavContentModel"));
            }
            $(".siteNavContent").hide();
            siteNavContent.show();
        }

        function deleteSiteNavContent(navIndex) {
            var siteNavContent = $("#siteNavContent_" + navIndex);
            if (siteNavContent) {
                siteNavContent.remove();
                $(".siteNavContent").each(function () {
                    var contentIndex = $(this).attr("data-edit-index");
                    if (parseInt(contentIndex) >= parseInt(navIndex)) {
                        var newContentIndex = (parseInt(contentIndex) - 1);
                        $(this).attr("data-edit-index", newContentIndex);
                        $(this).attr("id", ("siteNavContent_" + newContentIndex));
                    }
                });
            }
        }

        function toggleSuspendNav(obj) {
            $(obj).parent().next(".zx-submenu").toggle();
        }

        function showSuspendNavLeftImage(obj, imageUrl) {
            $(obj).find("img[name='suspendNavLeftImage']").attr("src", imageUrl);
            $(obj).find(".zx-placeholder").hide();
            $(obj).find("img[name='suspendNavLeftImage']").show();
        }

        function fillSuspendNavLeftImageParam(obj, leftPicUrl, leftLinkUrl, leftNewWin) {
            $(obj).find("input[name='suspendNavLeftPicUrl']").val(leftPicUrl);
            $(obj).find("input[name='suspendNavLeftLinkUrl']").val(leftLinkUrl);
            $(obj).find("input[name='suspendNavLeftNewWin']").val(leftNewWin);
        }

        function uploadSuspendNavLeftImage(obj) {
            suspendLeftImageDialog.set("success", function () {
                var suspendNavLeftPicUrl = $("#imageView_suspendNavLeftPic").attr("src");
                showSuspendNavLeftImage($(obj).parent(), suspendNavLeftPicUrl);
                fillSuspendNavLeftImageParam($(obj).parents(".siteNavContent"), suspendNavLeftPicUrl, $("#suspendNavLeftLinkUrl").val(), $("#suspendNavLeftNewWin").attr("checked") == "checked" ? "1" : "0")
                this.hide();

            });
            $("#imageView_suspendNavLeftPic").attr("src", $(obj).parents(".siteNavContent").find("input[name='suspendNavLeftPicUrl']").val());
            $("#suspendNavLeftLinkUrl").val($(obj).parents(".siteNavContent").find("input[name='suspendNavLeftLinkUrl']").val());
            if ($(obj).parents(".siteNavContent").find("input[name='suspendNavLeftNewWin']").val() == "1") {
                $("#suspendNavLeftNewWin").attr("checked", "true");
            } else {
                $("#suspendNavLeftNewWin").removeAttr("checked");
            }
            suspendLeftImageDialog.show();
        }

        function deleteSuspendNavLeftImage(obj) {
            $(obj).parents(".siteNavContent").find("input[name='suspendNavLeftPicUrl']").val("");
            $(obj).parent().find("img[name='suspendNavLeftImage']").hide();
            $(obj).parent().find("img[name='suspendNavLeftImage']").attr("src", "");
            $(obj).parent().find(".zx-placeholder").show();
            $(obj).parents(".siteNavContent").find("input[name='suspendNavLeftLinkUrl']").val("");
            $(obj).parents(".siteNavContent").find("input[name='suspendNavLeftNewWin']").val("0");
        }

        function collectData() {
            //fill topTools param
            var topToolsContent;
            var topToolsContentType = $("#topToolsContentType").val();
            if (topToolsContentType == "2") {
                topToolsContent = $("#topToolsAdvancedContent").val();
            } else {
                topToolsContent = topToolsEditor.getContent();
            }
            $("input[name='topToolsContent']").val(topToolsContent);

            //fill topLinks param
            var topLinksContent;
            var topLinksContentType = $("#topLinksContentType").val();
            if (topLinksContentType == "2") {
                topLinksContent = $("#topLinksAdvancedContent").val();
            } else {
                topLinksContent = topLinksEditor.getContent();
            }
            $("input[name='topLinksContent']").val(topLinksContent);

            var hotSearchContent;
            var hotSearchContentType = $("#hotSearchContentType").val();
            if (hotSearchContentType == "2") {
                hotSearchContent = $("#hotSearchAdvancedContent").val();
            } else {
                hotSearchContent = hotSearchEditor.getContent();
            }
            $("input[name='hotSearchContent']").val(hotSearchContent);

            //build topAd Json Str
            var topAdObj = {};
            var topAdPicUrl = $("#imageView_topAdPic").attr("src");
            topAdObj["picUrl"] = topAdPicUrl;
            var topAdLinkUrl = $("#topAdLinkUrl").val();
            topAdObj["linkUrl"] = topAdLinkUrl;
            var topAdNewWin = $("#topAdNewWin").is(":checked");
            topAdObj["openNewWin"] = topAdNewWin;

            //build logoExtra Json Str
            var logoExtraObj = {};
            var logoExtraPicUrl = $("#imageView_logoExtraPic").attr("src");
            logoExtraObj["picUrl"] = logoExtraPicUrl;
            var logoExtraLinkUrl = $("#logoExtraLinkUrl").val();
            logoExtraObj["linkUrl"] = logoExtraLinkUrl;
            var logoExtraNewWin = $("#logoExtraNewWin").is(":checked");
            logoExtraObj["openNewWin"] = logoExtraNewWin;

            //build headerSearchRight Json Str
            var headerSearchRightObj = {};
            var headerSearchRightPicUrl = $("#imageView_headerSearchRightPic").attr("src");
            headerSearchRightObj["picUrl"] = headerSearchRightPicUrl;
            var headerSearchRightLinkUrl = $("#headerSearchRightLinkUrl").val();
            headerSearchRightObj["linkUrl"] = headerSearchRightLinkUrl;
            var headerSearchRightNewWin = $("#headerSearchRightNewWin").is(":checked");
            headerSearchRightObj["openNewWin"] = headerSearchRightNewWin;

            var navArray = [];
            var navNameEmptyContentIndex = null;
            $(".siteNavContent").each(function () {
                var _self = this;
                var oneNavObj = {};
                var siteNavName = $(_self).find("input[name='siteNavName']").val();
                if (siteNavName && siteNavName != "") {
                    oneNavObj["name"] = siteNavName;
                    var navActive = $(_self).find("input[name='active']").is(":checked");
                    oneNavObj["active"] = navActive;
                    var siteNavOrder = $(_self).find("input[name='siteNavOrder']").val();
                    if (siteNavOrder != "") {
                        oneNavObj["order"] = siteNavOrder;
                    }
                    var siteNavUrl = $(_self).find("input[name='siteNavUrl']").val();
                    oneNavObj["linkUrl"] = siteNavUrl;
                    var siteNavNewWin = $(_self).find("input[name='opennew']").is(":checked");
                    oneNavObj["openNewWin"] = siteNavNewWin;
                    var siteNavSuspendNav = $(_self).find("input[name='opensec']").is(":checked");
                    oneNavObj["openSuspendNav"] = siteNavSuspendNav;
                    if (siteNavSuspendNav) {
                        var suspendNavObj = {};
                        var suspendNavType = "${suspendNavJsonType}"; //TODO:暂时没有提供HTML功能
                        if ('${suspendNavJsonType}' == suspendNavType) {
                            var suspendNavCategoryArray = [];
                            suspendNavObj["suspendNavType"] = suspendNavType;
                            var leftPicUrl = $(_self).find("input[name='suspendNavLeftPicUrl']").val();
                            suspendNavObj["leftPicUrl"] = leftPicUrl;
                            var leftLinkUrl = $(_self).find("input[name='suspendNavLeftLinkUrl']").val();
                            suspendNavObj["leftLinkUrl"] = leftLinkUrl;
                            var leftNewWin = $(_self).find("input[name='suspendNavLeftNewWin']").val() == "1" ? true : false;
                            suspendNavObj["leftOpenNewWin"] = leftNewWin;
                            var counter = 0;
                            $(_self).find(".suspendNavCategory").each(function () {
                                var _child = this;
                                var suspendNavCategoryObj = {};
                                var categoryName = $(_child).find("input[name='cName']").val();
                                if (categoryName && categoryName != "") {
                                    counter = counter + 1;
                                    suspendNavCategoryObj["categoryName"] = categoryName;
                                    suspendNavCategoryObj["order"] = counter;
                                    var lowerCategoryArray = [];
                                    $(_child).find(".lowerCategory").each(function () {
                                        var lowerCategoryObj = {};
                                        var lowerCategoryType = $(this).attr("data-lower-category-type");
                                        if (lowerCategoryType) {
                                            lowerCategoryObj["scType"] = lowerCategoryType;
                                        }
                                        var lowerCategoryId = $(this).attr("data-lower-category-id");
                                        if (lowerCategoryId) {
                                            lowerCategoryObj["scId"] = lowerCategoryId;
                                        }
                                        lowerCategoryArray.push(lowerCategoryObj);
                                    });
                                    suspendNavCategoryObj["subCategories"] = lowerCategoryArray;
                                }
                                suspendNavCategoryArray.push(suspendNavCategoryObj);
                            });
                            suspendNavObj["categories"] = suspendNavCategoryArray;
                        } else {
                            //TODO:若为HTML，则设置HTML结构
                            var suspendNavHtml = '<p><a href="#">我的帐号</a></p><p><a href="#">购物车</a></p><p><a href="#">网站公告</a></p><p><a href="#">帮助</a></p>';
                            suspendNavObj["suspendNavType"] = '${suspendNavHtmlType}';
                            suspendNavObj["suspendNavHtml"] = suspendNavHtml;
                        }
                        oneNavObj["suspendNav"] = suspendNavObj;
                    }
                } else {
                    navNameEmptyContentIndex = $(_self).attr("data-edit-index");
                    return false;
                }
                navArray.push(oneNavObj);
            });

            if (navNameEmptyContentIndex != null) {
                showSiteNavContent(navNameEmptyContentIndex);
                BUI.Message.Alert("菜单名称不能为空!", function () {
                    $("#siteNavContent_" + navNameEmptyContentIndex).find("input[name='siteNavName']").focus();
                });
                return false;
            }

            $("input[name='topAd']").val(JSON.stringify(topAdObj));
            $("input[name='logoExtra']").val(JSON.stringify(logoExtraObj));
            $("input[name='headerSearchRight']").val(JSON.stringify(headerSearchRightObj));

            var siteNavObj = {};
            siteNavObj["navs"] = navArray;
            $("input[name='nav']").val(JSON.stringify(siteNavObj));
            return true;
        }

        function initIframeElement() {
        <#if (topAdCustomTemplate.picUrl)?has_content>
            $("#J_Iframe")[0].contentWindow.fillTopAdElement('${(topAdCustomTemplate.picUrl)}');
        </#if>
        <#if (logoExtraCustomTemplate.picUrl)?has_content>
            $("#J_Iframe")[0].contentWindow.fillLogoExtraElement('${(logoExtraCustomTemplate.picUrl)}');
        </#if>
        <#if (headerSearchRightCustomTemplate.picUrl)?has_content>
            $("#J_Iframe")[0].contentWindow.fillHeaderSearchRightElement('${(headerSearchRightCustomTemplate.picUrl)}');
        </#if>
            var topLeftHtml = topToolsEditor.getContent();
            $("#J_Iframe")[0].contentWindow.fillTopToolsElement(topLeftHtml);
            var topRightHtml = topLinksEditor.getContent();
            $("#J_Iframe")[0].contentWindow.fillTopLinksElement(topRightHtml);
            var hotSearchHtml = hotSearchEditor.getContent();
            $("#J_Iframe")[0].contentWindow.fillHotSearchElement(hotSearchHtml);
        }

        function initNavElement() {
        <#if navCustomTemplate?has_content && (navCustomTemplate.navs)?has_content>
            <#assign navs = navCustomTemplate.navs>
            <#list navs as nav>
                $("#J_Iframe")[0].contentWindow.addNewNav();
                $("#J_Iframe")[0].contentWindow.fillNavElement('${nav_index + 1}', '${(nav.name)?default("")}');
                $("#siteNavContent_${nav_index + 1}").hide();
                $("#siteNavContent_${nav_index + 1}").find("input[name='siteNavName']").val('${(nav.name)?default("")}');
                $("#siteNavContent_${nav_index + 1}").find("input[name='siteNavOrder']").val('${(nav.order)?default("")}');
                $("#siteNavContent_${nav_index + 1}").find("input[name='siteNavUrl']").val('${(nav.linkUrl)?default("")}');
                <#if (nav.openNewWin)?? && (nav.openNewWin)>
                    $("#siteNavContent_${nav_index + 1}").find("input[name='opennew']").attr("checked", "checked");
                </#if>
                $("#siteNavContent_${nav_index + 1}").find("input[name='opennew']").val('${(nav.linkUrl)?default("")}');
                <#if (nav.active)?? && nav.active>
                    $("#siteNavContent_${nav_index + 1}").find("input[name='active']").attr("checked", "checked");
                </#if>
                <#if suspendNavJsonType == (nav.suspendNav.suspendNavType)?default("")>
                    showSuspendNavLeftImage($("#siteNavContent_${nav_index + 1}"), '${(nav.suspendNav.leftPicUrl)?default("")}');
                    <#assign leftOpenNewWin = "0">
                    <#if (nav.suspendNav.leftOpenNewWin)?? && (nav.suspendNav.leftOpenNewWin)>
                        <#assign leftOpenNewWin = "1">
                    </#if>
                    fillSuspendNavLeftImageParam($("#siteNavContent_${nav_index + 1}"), '${(nav.suspendNav.leftPicUrl)?default("")}', '${(nav.suspendNav.leftLinkUrl)?default("")}', '${leftOpenNewWin}');
                    <#if (nav.openSuspendNav)?? && nav.openSuspendNav>
                        $("#siteNavContent_${nav_index + 1}").find("input[name='opensec']").attr("checked", "checked");
                        $("#siteNavContent_${nav_index + 1}").find(".zx-submenu").show();
                    </#if>
                    <#assign suspendNavCategories = (nav.suspendNav.categories)?default("")>
                    <#if suspendNavCategories?has_content>
                        <#list suspendNavCategories as suspendNavCategory>
                            var suspendCategory = addSuspendCategory($("#siteNavContent_${nav_index + 1}").find("button[name='addSuspendCategory']"));
                            suspendCategory.find("input[name='cName']").val('${(suspendNavCategory.categoryName)!?html}');
                            <#assign suspendNavSubCategories = (suspendNavCategory.subCategories)?default("")>
                            <#if suspendNavSubCategories?has_content>
                                <#list suspendNavSubCategories as subCategory>
                                    var targetModel = $(suspendCategory).find(".lowerCategoryModel");
                                    var lowerCategoryContent = targetModel.clone();
                                    lowerCategoryContent.removeClass("lowerCategoryModel");
                                    lowerCategoryContent.addClass("lowerCategory");
                                    lowerCategoryContent.attr("data-lower-category-type", '${(subCategory.scType)?default("")}');
                                    lowerCategoryContent.attr("data-lower-category-id", '${(subCategory.scId)?default("")}');
                                    lowerCategoryContent.find(".spec-item").children("span").html('${(subCategory.scText)?default("")}');
                                    lowerCategoryContent.insertBefore(targetModel);
                                    lowerCategoryContent.show();
                                </#list>
                            </#if>
                        </#list>
                    </#if>
                <#else>
                    //TODO:初始化HTML格式的SuspendNav
                </#if>
            </#list>
            $("#J_Iframe")[0].contentWindow.showNavElement();
        </#if>
        }

        function switchToBasicTab(contentId) {
            $("#" + contentId).find(".txtAreaEditorHref").removeClass("bui-tab-item-selected");
            $("#" + contentId).find(".txtAreaEditorHref").removeClass("bui-tab-item-hover");
            $("#" + contentId).find(".baiDuEditorHref").addClass("bui-tab-item-selected");
            $("#" + contentId).find(".baiDuEditorHref").addClass("bui-tab-item-hover");
            $("#" + contentId).parent().find("div[name='txtAreaEditor']").hide();
            $("#" + contentId).parent().find("div[name='baiDuEditor']").show();
            $("#" + contentId).parent().find("input[name='contentType']").val("1");
        }

        function switchToAdvancedTab(contentId) {
            $("#" + contentId).find(".baiDuEditorHref").removeClass("bui-tab-item-selected");
            $("#" + contentId).find(".baiDuEditorHref").removeClass("bui-tab-item-hover");
            $("#" + contentId).find(".txtAreaEditorHref").addClass("bui-tab-item-selected");
            $("#" + contentId).find(".txtAreaEditorHref").addClass("bui-tab-item-hover");
            $("#" + contentId).parent().find("div[name='baiDuEditor']").hide();
            $("#" + contentId).parent().find("div[name='txtAreaEditor']").show();
            $("#" + contentId).parent().find("input[name='contentType']").val("2");
        }

        function changeSiteNavName(obj) {
            var siteNavIndex = $(obj).parents(".siteNavContent").attr("data-edit-index");
            var siteNavName = $(obj).val();
            if ("" == siteNavName) {
                BUI.Message.Alert("菜单名称不能为空!", function () {
                    $(obj).focus();
                });
                return false;
            }
            $("#J_Iframe")[0].contentWindow.fillNavElement(siteNavIndex, siteNavName);
        }
        function setCategoryStatus(obj) {
            var url = "/admin/sa/category/setCategoryStatus",
                    $this = $(obj),
                    status = ($this.text() == "启用");
            $.post(url, {status: status}, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("设置成功！");
                    if (status) {
                        $this.text("禁用");
                    } else {
                        $this.text("启用");
                    }
                }
            });
        }
    </script>
</body>
</html>