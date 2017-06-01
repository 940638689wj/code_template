<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#assign productControlNewRecommend = Static['cn.yr.chile.common.constant.DecorateControlShowType'].PC_PRODUCT_NEW_RECOMMEND_TYPE.type>
<#assign productControlScroll = Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SCROLL_TYPE.type>
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
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <title></title>
</head>
<body>
<div class="zx-widgetwrap">
    <div class="prd-colside">
        <div class="wrap">

            <h4>新品推荐</h4>
            <div class="zx-widget-item selected"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlNewRecommend}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod1.png" alt=""/>
            </a></div>

            <h4>舞台轮播展示</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlScroll}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod2.png" alt=""/>
            </a></div>

            <#--<h4>公告</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${announcementType}" target="C_Iframe">
                <img src="/static/admin/images/modules/announcement-1.png" alt=""/>
            </a></div>-->

            <h4>商品展示1</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlModule3}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod3.png" alt=""/>
            </a></div>

            <#-- <h4>SKU特价活动</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlSkuOffer}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod4.png" alt=""/>
            </a></div>-->

            <#--<h4>商品展示2</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlModule6}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod6.png" alt=""/>
            </a></div>-->

            <h4>商品展示2</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlTab}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod7.png" alt=""/>
            </a></div>

            <h4>商品展示3</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlModule4}" target="C_Iframe">
                <img src="/static/admin/images/modules/itemshow-5.png" alt=""/>
            </a></div>
            
            <h4>分类轮播图</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlCategoryScroll}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod5.png" alt=""/>
            </a></div>

            <h4>楼层控件</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${floorControl}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-pc-mod8.png" alt=""/>
            </a></div>

            <#--<h4>综合控件1</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${mixed1Control}" target="C_Iframe">
                <img src="/static/admin/images/mixed-1.png" alt=""/>
            </a></div>-->

            <#--<h4>类别推荐模块</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].CATEGORY_RECOMMEND.type}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-banner.png" alt=""/>
            </a></div>-->

            <h4>自定义模块</h4>
            <div class="zx-widget-item"><a href="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].DEFINED_HTML.type}" target="C_Iframe">
                <img src="/static/admin/images/zxthumb-banner.png" alt=""/>
            </a></div>
        </div>
    </div>
    <div class="prd-colmain">
        <div class="wrap" style="margin-left: 120px;">
            <iframe name="C_Iframe" id="J_C_Iframe" src="${ctx}/admin/sa/pc/decorate/pc/edit.html?type=${Static['cn.yr.chile.common.constant.DecorateControlType'].PRODUCT_RECOMMEND.type}&showType=${productControlNewRecommend}" frameborder="0" style="width: 100%;"></iframe>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(function(){

        $(".zx-widget-item > a").on('click', function(){
            $(".zx-widget-item").removeClass("selected");
            $(this).parent().addClass("selected");
        })

        setInterval(function(){
            try{
                setIframeHeight();
            } catch (ex){
                console.log(ex);
            }
        }, 100)

        var lastHeight;
        function setIframeHeight(){
            var ifr = $("#J_C_Iframe"),
                    ifrcon = ifr[0].contentWindow.document;
            /*var newHeight = ifrcon.documentElement.scrollHeight || ifrcon.body.scrollHeight;
            if(lastHeight && newHeight != lastHeight){
                alert(lastHeight + "|" + newHeight);
            }
            lastHeight = newHeight;*/
            var height = ifrcon.documentElement.scrollHeight || ifrcon.body.scrollHeight;
            if(height < 500){
                height = 500;
            }
            ifr.css({
                //width:ifrcon.documentElement.scrollWidth || ifrcon.body.scrollWidth,
                height:height
            });
        }
    });
</script>
<body>
</html>