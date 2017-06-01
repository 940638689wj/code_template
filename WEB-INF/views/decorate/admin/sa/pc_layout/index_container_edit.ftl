<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#assign definedControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].DEFINED_HTML.type>
<#assign productControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].PRODUCT_RECOMMEND.type>
<#assign categoryControlType = Static["cn.yr.chile.common.constant.DecorateControlType"].CATEGORY_RECOMMEND.type>
<#assign productControlNewRecommend = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_NEW_RECOMMEND_TYPE.type>
<#assign productControlScroll = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SCROLL_TYPE.type>
<#assign productControlModule3 = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE3_TYPE.type>
<#assign productControlModule4 = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE4_TYPE.type>
<#assign productControlSkuOffer = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SKU_OFFER_TYPE.type>
<#assign productControlCategoryScroll = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_CATEGORY_SCROLL_TYPE.type>
<#assign productControlModule6 = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE6_TYPE.type>
<#assign productControlTab = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_TAB_TYPE.type>
<#assign floorControl = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_FLOOR_TYPE.type>
<#assign mixed1Control = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MIXED_1_TYPE.type>
<#assign announcementType = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_ANNOUNCEMENT_TYPE.type>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
</head>
<body>
<div class="container">
    <div class="content-top">
        <div id="tab">
            <ul class="bui-tab nav-tabs">
                <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">PC商城首页装修</span></li>
            </ul>
        </div>
    </div>

    <div class="zx-side">
        <div class="wrap">
            <div class="wrapin">

                <div class="zxs-item zxs-item-img selected"><a href="${ctx}/admin/sa/pc/decorate/centerSuspend/edit" target="Iframe">
                    <img src="/static/admin/images/zxthumb-topad.png" alt=""/>
                    <span class="zxs-item-mask"><b><span>首页广告弹窗</span></b></span>
                </a></div>
                <div class="zxs-item"><a href="${ctx}/admin/sa/pc/decorate/topEdit" target="Iframe">
                    <span class="zxs-item-mask"><b><span>商城头部</span></b></span>
                    <span class="zxs-item-img"></span>
                </a></div>
                <div class="zxs-item zxs-item-img"><a href="${ctx}/admin/sa/pc/decorate/indexBannerManger/banner/edit" target="Iframe">
                    <span class="zxs-item-mask"><b><span>全屏轮播</span></b></span>
                    <span class="zxs-item-img"><img src="/static/admin/images/zxthumb-pc-banner.png" alt=""/></span>
                </a></div>
            <#--<div class="zxs-item zxs-item-img"><a href="${ctx}/admin/sa/pc/decorate/indexSpecAreaManger/list" target="Iframe">
                <span class="zxs-item-mask"><b><span>精品区</span></b></span>
                <span class="zxs-item-img"><img src="/static/admin/images/zxthumb-pc-tab.png" alt=""/></span>
            </a></div>-->
                <div class="zxs-item"><a href="${ctx}/admin/sa/pc/decorate/defined/show?key=index_html" target="Iframe">
                    <span class="zxs-item-mask"><b><span>首页自定义</span></b></span>
                    <span class="zxs-item-img"></span>
                </a></div>
                <div class="zxs-item zxs-item-add"><a href="${ctx}/admin/sa/pc/decorate/pc/add" target="Iframe">
                    <span class="zxs-item-mask"><b><span>+新增模块</span></b></span>
                </a></div>

                <div class="zxs-item zxs-item-img controlContentModel" style="display: none;">
                    <a href="javascript:void(0)" target="Iframe">
                        <img src="/static/admin/images/zxthumb-mobile-mod1.png" alt=""/>
                        <span class="zxs-item-mask"><b><span name="controlName">模块一</span></b></span>
                    </a>
                    <!--此处加权限会造成删除无法使用-->
                    <div class="zx-btn-delete">&times;</div>
                </div>
                <div class="zxs-item zxs-item-img"><a href="${ctx}/admin/sa/pc/decorate/defined/show?key=bottom_html" target="Iframe">
                    <span class="zxs-item-mask"><b><span>底部</span></b></span>
                    <span class="zxs-item-img"></span>
                </a></div>
            </div>
        </div>
    </div>

    <div class="zx-main">
        <div class="wrap">
            <iframe class="wrapin" name="Iframe" id="J_Iframe" src="${ctx}/admin/sa/pc/decorate/centerSuspend/edit" frameborder="0"></iframe>
        </div>
    </div>
</div>
<script type="text/javascript">
    BUI.use('common/page');

    $(function(){
        $(".zxs-item > a").live("click",function(){
            $(".zxs-item").removeClass("selected");
            $(this).parent().addClass("selected");
            window.scrollTo(0,0);
        });

        $(".zx-btn-delete").live('click', function(){
            var deleteId = $(this).prev("a").attr("data-edit-id");
            var deleteName = $(this).prev("a").attr("data-edit-name");
            BUI.Message.Confirm('确认要删除模块【'+deleteName+'】吗?',function(){
                $.ajax({
                    url: "${ctx}/admin/sa/pc/decorate/delete?id="+deleteId,
                    type:"get",
                    dataType: "json",
                    success: function(data){
                        if(data.result == "true"){
                            app.showSuccess("模块控件删除成功!");
                            window.location.reload();
                        }else{
                            app.alert(data.message || "模块控件删除失败!");
                        }
                    }
                });
            },'question');
        });

        initControlContent();

        var h = getContentHeight();
        $(".zx-side > .wrap,.zx-main > .wrap").height(h);
    });


    function initControlContent(){
    <#if controls?has_content>
        <#list controls as control>
            addControlContent('${(control.id)!}', '${(control.name)!?html}', '${(control.type)!}','${(control.showType)!}');
        </#list>
    </#if>
    }

    function addControlContent(controlId, controlName, controlType, controlShowType){
        var controlContent = $(".controlContentModel").clone();
        controlContent.removeClass("controlContentModel");
        controlContent.attr("data-control-container-id", ("control_container_" + controlId));
        var imgPath = "/static/admin/images/";
        var imgName = "zxthumb-pc-banner.png";
        if(controlType == '${productControlType}'){
            if(controlShowType && controlShowType == '${productControlNewRecommend}'){
                imgName = "zxthumb-pc-mod1.png";
            }
            if(controlShowType && controlShowType == '${productControlScroll}'){
                imgName = "zxthumb-pc-mod2.png";
            }
            if(controlShowType && controlShowType == '${productControlModule3}'){
                imgName = "zxthumb-pc-mod3.png";
            }
            if(controlShowType && controlShowType == '${productControlModule4}'){
                imgName = "modules/itemshow-5.png";
            }
            if(controlShowType && controlShowType == '${productControlSkuOffer}'){
                imgName = "zxthumb-pc-mod4.png";
            }
            if(controlShowType && controlShowType == '${productControlCategoryScroll}'){
                imgName = "zxthumb-pc-mod5.png";
            }
            if(controlShowType && controlShowType == '${productControlModule6}'){
                imgName = "zxthumb-pc-mod6.png";
            }
            if(controlShowType && controlShowType == '${productControlTab}'){
                imgName = "zxthumb-pc-mod7.png";
            }
            if(controlShowType && controlShowType == '${floorControl}'){
                imgName = "zxthumb-pc-mod8.png";
            }
            if(controlShowType && controlShowType == '${mixed1Control}'){
                imgName = "mixed-1.png";
            }
            if(controlShowType && controlShowType == '${announcementType}'){
                imgName = "modules/announcement-1.png";
            }
        }
        if(controlType == '${definedControlType}' || controlType == '${categoryControlType}'){
            controlContent.removeClass("zxs-item-img");
            $("<span class=\"zxs-item-img\"></span>").insertAfter(controlContent.find(".zxs-item-mask"));
            controlContent.find("img").remove();
        } else {
            var imgUrl = imgPath + imgName;
            controlContent.find("img").attr("src", imgUrl);
        }
        controlContent.find("a").attr("href", ("/admin/sa/pc/decorate/pc/edit?id=" + controlId + "&type=" + controlType));
        controlContent.find("a").attr("data-edit-id", controlId);
        controlContent.find("a").attr("data-edit-name", controlName);
        controlContent.find("span[name='controlName']").html(controlName);
        controlContent.insertBefore($(".controlContentModel"));
        controlContent.show();
        return controlContent;
    }

    function fillControlContent(controlId, controlName, controlType, controlShowType){
        if(controlId){
            var targetContainer = $("div[data-control-container-id='control_container_"+controlId+"']");
            if(targetContainer && targetContainer.length){
                targetContainer.find("span[name='controlName']").html(controlName);
            } else {
                var newControlContent = addControlContent(controlId, controlName, controlType, controlShowType);
                newControlContent.find("a").click();
            }
        }
    }

    function toChildIFrameRefresh(){
        var targetHref;
        $(".zxs-item").each(function(){
            if($(this).hasClass("selected")){
                targetHref = $(this).find("a").attr("href");
                return false;
            }
        });

        return targetHref;
    }
</script>
</body>
</html>