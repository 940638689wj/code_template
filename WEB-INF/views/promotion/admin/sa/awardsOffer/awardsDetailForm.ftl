<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="list">转盘</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active"><#if isNew == true>新加转盘<#else>编辑转盘</#if></li>
    </ul>
<#if isNew == true>
    <div class="orderstatus clearfix">
        <div class="steps">
            <ul>
                <li class="step-first">
                    <div class="stepind">1</div>
                    <div class="stepname">1.设置转盘规则</div>
                </li>
                <li class="step-last step-active">
                    <div class="stepind">2</div>
                    <div class="stepname">2.设置转盘页面</div>
                </li>
            </ul>
        </div>
    </div>
<#else>
    <div id="tab">
        <ul class="bui-tab-panel bui-tab nav-tabs bui-tab-panel-hover bui-tab-hover" aria-disabled="false"
            style="width: 800px;" aria-pressed="false">
            <li onclick="javascript:goToFirstTab();" class="bui-tab-panel-item bui-tab-item" aria-disabled="false"
                aria-pressed="false"><span class="bui-tab-item-text">设置转盘规则</span></li>
            <li onclick="javascript:void(0);"
                class="bui-tab-panel-item bui-tab-item bui-tab-panel-item-selected bui-tab-item-selected bui-tab-panel-item-hover bui-tab-item-hover"
                aria-disabled="false" aria-pressed="false"><span class="bui-tab-item-text">设置转盘页面</span></li>
        </ul>
    </div>
</#if>
    <div style="padding-bottom: 5px;">
        <ul class="bui-tab link-tabs bui-tab-hover" aria-disabled="false" aria-pressed="false">
            <li id="pcDetailHref" class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                <a href="javascript:switchToPcTab();">电脑端</a>
            </li>
            <li id="mobileDetailHref" class="bui-tab-item bui-tab-item-hover" aria-disabled="false"
                aria-pressed="false">
                <a href="javascript:switchToMobileTab();">手机端</a>
            </li>
        </ul>
    </div>
    <form id="J_Form" class="form-horizontal" action="editDetail" method="post">
        <input type="hidden" name="id" value="${(awards.id)!}"/>
        <input type="hidden" name="centerBgPicUrl" value="${(awards.centerBgPicUrl)!}">
        <input type="hidden" name="awardsPicUrl" value="${(awards.awardsPicUrl)!}">
        <input type="hidden" name="awardsPointPicUrl" value="${(awards.awardsPointPicUrl)!}">
        <input type="hidden" name="pcCenterBgPicUrl" value="${(awards.pcCenterBgPicUrl)!}">
        <input type="hidden" name="pcAwardsPicUrl" value="${(awards.pcAwardsPicUrl)!}">
        <input type="hidden" name="pcAwardsPointPicUrl" value="${(awards.pcAwardsPointPicUrl)!}">
        <div class="well">
            <div class="row" id="pcCenterBgUploaderContainer">
                <div class="control-group">
                    <label class="control-label" style="width: 150px;">转盘背景图(1920x780)：</label>
                    <div class="controls control-row-auto">
                        <div class="file-btn">
                            <button class="button button-small">上传</button>
                            <input type="file" id="bgAwardsFileObj" name="file" style="width: 170px" class="inp-file"
                                   onchange="javascript:doUploadVoice('1', this.value);">
                        </div>
                        <a href="downImages?type=pcBackground">示例图片下载</a>
                    </div>
                <#assign defaultHide = "hide">
                <#assign assetUrl = "">
                <#if (awards.pcCenterBgPicUrl)?has_content>
                    <#assign defaultHide = "">
                    <#assign assetUrl = awards.pcCenterBgPicUrl>
                </#if>
                    <div class="controls control-row-auto ${defaultHide}">
                        <a id="pcCenterBgPicUrl" href="${assetUrl}" title="点击预览">
                            <img src="${assetUrl}" style="width: 170px"></a>
                    </div>
                </div>
            </div>
            <div class="row" id="pcAwardsPicUploaderContainer">
                <div class="control-group">
                    <label class="control-label" style="width: 150px;">转盘格子图(500x500)：</label>
                    <div class="controls control-row-auto">
                        <div class="file-btn">
                            <button class="button button-small">上传</button>
                            <input type="file" id="awardsFileObj" name="file" style="width: 170px" class="inp-file"
                                   onchange="javascript:doUploadVoice('2', this.value);">
                        </div>
                        <a href="downImages?type=pcWheel">示例图片下载</a>
                    </div>
                <#assign defaultHide = "hide">
                <#assign assetUrl = "">
                <#if (awards.pcAwardsPicUrl)?has_content>
                    <#assign defaultHide = "">
                    <#assign assetUrl = awards.pcAwardsPicUrl>
                </#if>
                    <div class="controls control-row-auto ${defaultHide}">
                        <a id="pcAwardsPicUrl" href="${assetUrl}" title="点击预览">
                            <img src="${assetUrl}" style="width: 170px"></a>
                    </div>
                </div>
            </div>
            <div class="row" id="pcAwardsPointPicUploaderContainer">
                <div class="control-group">
                    <label class="control-label" style="width: 150px;">转盘指针图(190x210)：</label>
                    <div class="controls control-row-auto">
                        <div class="file-btn">
                            <button class="button button-small">上传</button>
                            <input type="file" id="pointAwardsFileObj" name="file" style="width: 170px" class="inp-file"
                                   onchange="javascript:doUploadVoice('3', this.value);">
                        </div>
                        <a href="downImages?type=pcPointer">示例图片下载</a>
                    </div>
                <#assign defaultHide = "hide">
                <#assign assetUrl = "">
                <#if (awards.pcAwardsPointPicUrl)?has_content>
                    <#assign defaultHide = "">
                    <#assign assetUrl = awards.pcAwardsPointPicUrl>
                </#if>
                    <div class="controls control-row-auto ${defaultHide}">
                        <a id="pcAwardsPointPicUrl" href="${assetUrl}" title="点击预览">
                            <img src="${assetUrl}" style="width: 170px"></a>
                    </div>
                </div>
            </div>
            <div class="row hide" id="mobileCenterBgUploaderContainer">
                <div class="control-group">
                    <label class="control-label" style="width: 150px;">转盘背景图(640x1500)：</label>
                    <div class="controls control-row-auto">
                        <div class="file-btn">
                            <button class="button button-small">上传</button>
                            <input type="file" id="mBgAwardsFileObj" name="file" style="width: 170px" class="inp-file"
                                   onchange="javascript:doUploadVoice('4', this.value);">
                        </div>
                        <a href="downImages?type=mobileBackground">示例图片下载</a>
                    </div>
                <#assign defaultHide = "hide">
                <#assign assetUrl = "">
                <#if (awards.centerBgPicUrl)?has_content>
                    <#assign defaultHide = "">
                    <#assign assetUrl =  awards.centerBgPicUrl>
                </#if>
                    <div class="controls control-row-auto ${defaultHide}">
                        <a id="centerBgPicUrl" href="${assetUrl}" title="点击预览">
                            <img src="${assetUrl}" style="width: 170px"></a>
                    </div>
                </div>
            </div>
            <div class="row hide" id="mobileAwardsPicUploaderContainer">
                <div class="control-group">
                    <label class="control-label" style="width: 150px;">转盘格子图(560x560)：</label>
                    <div class="controls control-row-auto">
                        <div class="file-btn">
                            <button class="button button-small">上传</button>
                            <input type="file" id="mAwardsFileObj" name="file" style="width: 170px" class="inp-file"
                                   onchange="javascript:doUploadVoice('5', this.value);">
                        </div>
                        <a href="downImages?type=mobileWheel">示例图片下载</a>
                    </div>
                <#assign defaultHide = "hide">
                <#assign assetUrl = "">
                <#if (awards.awardsPicUrl)?has_content>
                    <#assign defaultHide = "">
                    <#assign assetUrl =awards.awardsPicUrl>
                </#if>
                    <div class="controls control-row-auto ${defaultHide}">
                        <a id="awardsPicUrl" href="${assetUrl}" title="点击预览">
                            <img src="${assetUrl}" style="width: 170px"></a>
                    </div>
                </div>
            </div>
            <div class="row hide" id="mobileAwardsPointPicUploaderContainer">
                <div class="control-group">
                    <label class="control-label" style="width: 150px;">转盘指针图(248x280)：</label>
                    <div class="controls control-row-auto">
                        <div class="file-btn">
                            <button class="button button-small">上传</button>
                            <input type="file" id="mPointAwardsFileObj" name="file" style="width: 170px"
                                   class="inp-file"
                                   onchange="javascript:doUploadVoice('6', this.value);">
                        </div>
                        <a href="downImages?type=mobilePointer">示例图片下载</a>
                    </div>
                <#assign defaultHide = "hide">
                <#assign assetUrl = "">
                <#if (awards.awardsPointPicUrl)?has_content>
                    <#assign defaultHide = "">
                    <#assign assetUrl = awards.awardsPointPicUrl>
                </#if>
                    <div class="controls control-row-auto ${defaultHide}">
                        <a id="awardsPointPicUrl" href="${assetUrl}" title="点击预览">
                            <img src="${assetUrl}" style="width: 170px"></a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row" id="pcPageTopHtmlContainer">
            <div class="control-group">
                <label class="control-label">头部自定义(电脑端)：</label>
                <div class="controls control-row-auto">
                    <script type="text/plain" id="pcTopEditor" name="pcTopHtml">
                        <#if isNew>
                            <p style="text-align: center;">
                                <img src="/static/images/bigwheel/bigwheel-head.jpg" />
                            </p>
                        </#if>
                        ${(awards.pcTopHtml)!}

                    </script>
                </div>
            </div>
        </div>
        <div class="row" id="pcPageBottomHtmlContainer">
            <div class="control-group">
                <label class="control-label">底部自定义(电脑端)：</label>
                <div class="controls control-row-auto">
                    <script type="text/plain" id="pcBottomEditor" name="pcBottomHtml">
                        <#if isNew>
                            <h3 class="title">活动规则</h3>
                            <div class="desc">
                                <p>1. 活动时间：2017-01-01至 2017-12-31</p>
                                <p>2. 活动期间每个账号每天有99999次抽奖机会，同一账号、手机号均视为同一用户；</p>
                                <p>3. 获得实物奖品的，请于中奖7日内提交个人信息，逾期视为自动放弃。</p>
                                <p>4. 分享游戏给好友，若好友为第一次游戏，则可获得999999积分。</p>
                                <p>5. 在法律允许范围内，本商城有权对活动规则进行解释。</p>
                            </div>
                        </#if>
                        ${(awards.pcBottomHtml)!}
                    </script>
                </div>
            </div>
        </div>

        <div class="row hide" id="mobilePageTopHtmlContainer">
            <div class="control-group">
                <label class="control-label">头部自定义(手机端)：</label>
                <div class="controls control-row-auto">
                    <script type="text/plain" id="mobileTopEditor" name="topHtml">
                        <#if isNew>
                            <p style="text-align: center;">
                                <img src="/static/images/bigwheel/mobilebigwheel-head.jpg" />
                            </p>
                        </#if>
                        ${(awards.topHtml)!}
                    </script>
                </div>
            </div>
        </div>
        <div class="row hide" id="mobilePageBottomHtmlContainer">
            <div class="control-group">
                <label class="control-label">底部自定义(手机端)：</label>
                <div class="controls control-row-auto">
                    <script type="text/plain" id="mobileBottomEditor" name="bottomHtml">
                        <#if isNew>
                            <div class="scard-rule-title">
                                <span>活动规则</span>
                            </div>
                            <div class="scard-rule-container">
                                <p>1. 活动时间：2017-01-01至 2017-12-31</p>
                                <p>2. 活动期间每个账号每天有99999次抽奖机会，同一账号、手机号均视为同一用户；</p>
                                <p>3. 获得实物奖品的，请于中奖7日内提交个人信息，逾期视为自动放弃。</p>
                                <p>4. 分享游戏给好友，若好友为第一次游戏，则可获得999999积分。</p>
                                <p>5. 在法律允许范围内，本商城有权对活动规则进行解释。</p>
                            </div>
                        </#if>
                        ${(awards.bottomHtml)!}
                    </script>
                </div>
            </div>
        </div>
        <div class="actions-bar">
            <button type="submit" class="button button-primary">保存</button>
            <button type="reset" class="button">重置</button>
        </div>
    </form>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" src="${ctx}/static/admin/js/ueditor/ueditor.all.js"></script>
    <script src="${ctx}/static/admin/js/ajaxfileupload.js" type="text/javascript"></script>
    <script type="text/javascript">

        var awardsId = '${(awards.id)!"null"}';
        var uploadPath = "${ctx}/common/staticAsset/upload/awards/";
        window.pc_top_msg_editor = new UE.ui.Editor({
            initialFrameWidth: 1000,
            initialFrameHeight: 300,
            elementPathEnabled: false,
            wordCount: false,
            imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=awardsDetail&id=" + awardsId + "&platform=admin",
            imagePath: ""
        });
        window.pc_top_msg_editor.render("pcTopEditor");

        window.pc_bottom_msg_editor = new UE.ui.Editor({
            initialFrameWidth: 1000,
            initialFrameHeight: 300,
            elementPathEnabled: false,
            wordCount: false,
            imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=awardsDetail&id=" + awardsId + "&platform=admin",
            imagePath: ""
        });
        window.pc_bottom_msg_editor.render("pcBottomEditor");

        window.pc_top_msg_editor = new UE.ui.Editor({
            initialFrameWidth: 1000,
            initialFrameHeight: 300,
            elementPathEnabled: false,
            wordCount: false,
            imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=awardsDetail&id=" + awardsId + "&platform=admin",
            imagePath: ""
        });
        window.pc_top_msg_editor.render("mobileTopEditor");

        window.pc_bottom_msg_editor = new UE.ui.Editor({
            initialFrameWidth: 1000,
            initialFrameHeight: 300,
            elementPathEnabled: false,
            wordCount: false,
            imageUrl: window.UEDITOR_HOME_URL + "jsp/imageUp.jsp?entity=awardsDetail&id=" + awardsId + "&platform=admin",
            imagePath: ""
        });
        window.pc_bottom_msg_editor.render("mobileBottomEditor");


        var Form = BUI.Form;
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (data.result == "success") {
                    app.showSuccess("信息保存成功！");
                    app.page.open({
                        href: '/admin/sa/promotion/awardsOffer/list'
                    })
                }
            }
        }).render();

        /**
         * 上传图片
         *
         * @returns {boolean}
         */
        var uploadTarget;
        function uploadVoiceFile(target) {
            uploadTarget = target;
            $("#awardsFileObj").click();
        }

        function doUploadVoice(target, fileName) {
            if (fileName == null || jQuery.trim(fileName).length <= 0) {
                //BUI.Message.Alert("请选择文件!");
                return false;
            }

            if (!validImgFileFormat(fileName)) {
                BUI.Message.Alert("文件格式错误!");
                return false;
            }

            var fileElementId;

            if (target == "1") {
                uploadTarget = "pcCenterBgPicUrl";
                fileElementId = "bgAwardsFileObj";
            } else if (target == "2") {
                uploadTarget = "pcAwardsPicUrl";
                fileElementId = "awardsFileObj";
            } else if (target == "3") {
                uploadTarget = "pcAwardsPointPicUrl";
                fileElementId = "pointAwardsFileObj";
            } else if (target == "4") {
                uploadTarget = "centerBgPicUrl";
                fileElementId = "mBgAwardsFileObj";
            } else if (target == "5") {
                uploadTarget = "awardsPicUrl";
                fileElementId = "mAwardsFileObj";
            } else if (target == "6") {
                uploadTarget = "awardsPointPicUrl";
                fileElementId = "mPointAwardsFileObj";
            }

            if (!uploadTarget || !fileElementId) {
                BUI.Message.Alert("上传失败!");
                return false;
            }

            $.ajaxFileUpload({
                url: uploadPath,
                secureuri: false,
                fileElementId: fileElementId,
                dataType: "json",
                method: 'post',
                success: function (data, status) {

                    awardsPicUploadSuccessHandler(data);
                },
                error: function (data, status, e) {
                    BUI.Message.Alert("上传失败" + e);
                }
            });
            return false;
        }

        function awardsPicUploadSuccessHandler(data) {
            var assetUrl = data.displayUrl;
            var thumbUrl = assetUrl;
            var assetId = data.assetId;
            $("input[name='" + uploadTarget + "']").val(assetUrl);
            $("a[id='" + uploadTarget + "']").attr("href", thumbUrl);
            $("a[id='" + uploadTarget + "']").find("img").attr("src", thumbUrl);
            $("a[id='" + uploadTarget + "']").parent().show();
        }

        function validImgFileFormat(fileName, fileSuffix) {
            var validOk = false;
            var suffixIndex = fileName.lastIndexOf('.');
            if (suffixIndex <= 0) {
                return validOk;
            }

            var suffix = fileName.substr(suffixIndex + 1).toLowerCase();
            if (suffix.trim().length <= 0) {
                return validOk;
            }

            if (!fileSuffix) {
                fileSuffix = ['jpg', 'gif', 'png', 'jpeg', 'bmp'];
            }

            for (var temp = 0; temp < fileSuffix.length; temp++) {
                var formatSuffix = fileSuffix[temp];
                if (formatSuffix == suffix) {
                    validOk = true;
                    break;
                }
            }
            return validOk;
        }

        function goToFirstTab() {
            window.location.href = "${ctx}/admin/sa/promotion/awardsOffer/edit?awardId=" + awardsId;
        }

        function switchToMobileTab() {
            $("#pcDetailHref").removeClass("bui-tab-item-selected");
            $("#pcDetailHref").removeClass("bui-tab-item-hover");
            $("#mobileDetailHref").addClass("bui-tab-item-selected");
            $("#mobileDetailHref").addClass("bui-tab-item-hover");
            $("#pcCenterBgUploaderContainer").hide();
            $("#pcAwardsPicUploaderContainer").hide();
            $("#pcAwardsPointPicUploaderContainer").hide();
            $("#mobileCenterBgUploaderContainer").show();
            $("#mobileAwardsPicUploaderContainer").show();
            $("#mobileAwardsPointPicUploaderContainer").show();
            $("#pcPageTopHtmlContainer").hide();
            $("#pcPageBottomHtmlContainer").hide();
            $("#mobilePageTopHtmlContainer").show();
            $("#mobilePageBottomHtmlContainer").show();
        }

        function switchToPcTab() {
            $("#mobileDetailHref").removeClass("bui-tab-item-selected");
            $("#mobileDetailHref").removeClass("bui-tab-item-hover");
            $("#pcDetailHref").addClass("bui-tab-item-selected");
            $("#pcDetailHref").addClass("bui-tab-item-hover");
            $("#mobileCenterBgUploaderContainer").hide();
            $("#mobileAwardsPicUploaderContainer").hide();
            $("#mobileAwardsPointPicUploaderContainer").hide();
            $("#pcCenterBgUploaderContainer").show();
            $("#pcAwardsPicUploaderContainer").show();
            $("#pcAwardsPointPicUploaderContainer").show();
            $("#mobilePageTopHtmlContainer").hide();
            $("#mobilePageBottomHtmlContainer").hide();
            $("#pcPageTopHtmlContainer").show();
            $("#pcPageBottomHtmlContainer").show();
        }
    </script>
</div>
</body>
</html>