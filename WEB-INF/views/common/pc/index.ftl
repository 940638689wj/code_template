<#assign indexHtml = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getIndexHtml()?default("")>
<#assign indexCenterSuspended = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getIndexCenterSuspended()?default("")>
<#assign indexAdBannerModule = Static["cn.yr.chile.common.helper.DefinedModuleHelper"].getIndexAdBannerModule(Static["cn.yr.chile.common.constant.DefinedModuleKeys"].INDEX_AD_BANNER.key)?default("")>
<#assign indexSpecAreaModule = Static["cn.yr.chile.common.helper.DefinedModuleHelper"].getIndexSpecAreaModule(Static["cn.yr.chile.common.constant.DefinedModuleKeys"].INDEX_SPEC_AREA.key)?default("")>
<#--<#assign indexShowArticle = Static["cn.yr.chile.common.helper.DefinedModuleHelper"].getIndexShowArticle()?default("")>-->
<#assign decorateControlList = Static["cn.yr.chile.common.helper.DefinedModuleHelper"].getPcIndexDecorateControl()?default("")>
<#assign templateJsonType = Static["cn.yr.chile.common.constant.TemplateCustomType"].DEFINED_JSON.type>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>首页</title>
    <script src="${ctx}/static/js/jquery.switchable.min.js"></script>
</head>
<body class="page-index">
<script type="text/javascript">
    /*
         *左右滚动效果，idbox参数为父级id名
         */
    function tabMove(idbox){
        var idbox = $(idbox);
        var artPLen = idbox.find('.flo-tab-pic li').length,// 按钮个数
                artimgWid = idbox.find('.flo-tab-pic li').width(),// 图片宽度
                artNum = 0;
        nowPos = null;
        var artTimer = setInterval(moveSlide,4000);
        function moveSlide(){
            artNum++;
            if (artNum >= artPLen) {
                artNum = 0;
            };
            autoSlide(artNum);
        }
        function moveSlideLeft(){
            artNum--;
            if (artNum < 0) {
                artNum = artPLen-1;
            };
            autoSlide(artNum);
        }
        //图片自动滚动
        function autoSlide(artNum){
            idbox.find(".flo-tab-pic-show").stop().animate({ // 显示区域
                scrollLeft : artimgWid * artNum
            },500);
        }
        //点击左按钮滚动
        idbox.find('.flo-btn-l').click(function(){
            nowPos = idbox.find(".flo-tab-pic-show").scrollLeft();
            if (nowPos % 100 == 0) {
                clearInterval(artTimer);
                moveSlideLeft();
                artTimer = setInterval(moveSlide,4000);
            };
        })
        //点击右按钮滚动
        idbox.find('.flo-btn-r').click(function(){
            nowPos = idbox.find(".flo-tab-pic-show").scrollLeft();
            if (nowPos % 100 == 0) {
                clearInterval(artTimer);
                moveSlide();
                artTimer = setInterval(moveSlide,4000);
            };
        })
    }
</script>
<div id="page">
<#if indexAdBannerModule?has_content && indexAdBannerModule.definedModuleItems?size gt 0>
    <div id="inslides" style="<#if indexAdBannerModule.booleanValue>height:500px;<#else>height:420px;</#if>">
        <div class="slides-side">
            <#list indexAdBannerModule.definedModuleItems as one>
                <#if one.transientLinks?has_content>
                    <div class="slide-side-item">
                        <ul>
                            <#list one.transientLinks as link>
                                <#if link_index!=0 && link.imgPath?has_content><#--除了第一条外-->
                                    <li><a href="${link.href!}" title="${link.alt!?html}"><img src="${link.imgPath!}"/></a></li>
                                </#if>
                            </#list>
                        </ul>
                    </div>
                </#if>
            </#list>
        </div>
        <div class="switchable-slides">
            <ul>
                <#list indexAdBannerModule.definedModuleItems as one>
                    <#if one.transientLinks?has_content>
                        <#list one.transientLinks as link>
                            <li><div class="item"><a href="${link.href!}" title="${link.alt!?html}"><img src="${link.imgPath!}" alt=""/></a></div></li>
                            <#break/><#-- 只取第一条-->
                        </#list>
                    </#if>
                </#list>
            </ul>
        </div>
        <div class="switchable-nav">
            <a id="inslide_prev" href="javascript:void(0)">&lt;</a>
            <a id="inslide_next" href="javascript:void(0)">&gt;</a>
        </div>
    </div>
</#if>
<#--<#if indexSpecAreaModule?has_content && indexSpecAreaModule.definedModuleItems?size gt 0>
<div id="intabs">
    <div class="switchable-tab-title">
        <ul>
          <#list indexSpecAreaModule.definedModuleItems as one>
            <li><span>${one.name!}</span></li>
          </#list>
        </ul>
    </div>
    <div class="switchable-tab-content">
    <#list indexSpecAreaModule.definedModuleItems as one>
        <div class="switchable-tab-item">
            <div class="switchable-tab-item-wrap">
                <ul>
                    <#if one.transientLinks?has_content>
                        <#list one.transientLinks as link>
                            <li><a href="${link.href!}" title="${link.alt!?html}"><img src="${link.imgPath!}"/></a></li>
                        </#list>
                    </#if>
                </ul>
            </div>
            <div class="switchable-nav-item prev"><i>上页</i></div>
            <div class="switchable-nav-item next"><i>下页</i></div>
        </div>
    </#list>
    </div>
</div>
</#if>-->
    <script>
        $(function(){
            var sideitems = $("#inslides .slide-side-item");
            sideitems.eq(0).show();
            $('#inslides .switchable-slides').switchable({
                triggers: '&bull;',
                putTriggers: 'insertAfter',
                effect: 'fade',
                easing: 'ease-in-out',
                loop: true,
                autoplay:true,
                panels:'li',
                prev: '#inslide_prev',
                next: '#inslide_next',
                onSwitch: function(event, currentIndex) {
                    sideitems.hide().eq(currentIndex).fadeIn();
                }
            });

            $('#intabs').switchable({
                triggers: $("#intabs .switchable-tab-title li"),
                effect: 'none',
                easing: 'ease-in-out',
                panels:'.switchable-tab-item',
                onSwitch: function(event, currentIndex) {}
            });
            $('#intabs .switchable-tab-item').each(function(){
                var item = $(this);
                item.switchable({
                    triggers: false,
                    panels: 'li',
                    easing: 'ease-in-out',
                    effect: 'scrollLeft',
                    steps: 3,
                    visible: 3,
                    end2end: false,
                    autoplay: true,
                    prev: item.find('.prev'),
                    next: item.find('.next')
                });
            });
        });
    </script>
${indexHtml!}

<#-- 商品推荐控件 -->
    <div class="layout">
    <#if decorateControlList?? && decorateControlList?has_content>
        <#assign floorNum = 0>
        <#list decorateControlList as dto>
            <#if (dto.type)?has_content && dto.type == "DEFINED_HTML">
            ${dto.content!}
            <#elseif (dto.type)?has_content && (dto.type == "PRODUCT_RECOMMEND" || dto.type == "CATEGORY_RECOMMEND")>
                <#if (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MIXED_1_TYPE.type>
                    <div class="J_Module" data-module-name="mixed-1">
                        <div class="module md-mixed-1" style="${(dto.styles)!}">
                            <div class="mod-title">
                                <div class="tit">
                                    <#if (dto.titleImg)?has_content>
                                        <a href="${(dto.titleLink)!}">
                                            <span class="img"><img src="${(dto.titleImg)!}" alt=""/></span>
                                        </a>
                                    </#if>
                                    <span class="txt">${(dto.name)!?html}</span>
                                </div>
                                <#if (dto.others)?? && dto.others?has_content>
                                    <div class="extra">热门搜索：｜<#list dto.others as other><a href="${other.linkUrl!}">${other.name!?html}</a><#if other_has_next>｜</#if></#list></div>
                                </#if>
                            </div>
                            <div class="mod-body">
                                <#if (dto.adImg)?has_content>
                                    <div class="mod-banner">
                                        <a href="${dto.adLink!}">
                                            <img src="${dto.adImg!}" alt=""/>
                                        </a>
                                    </div>
                                </#if>
                                <div class="mod-list">
                                    <ul>
                                        <#if (dto.productDTOs)?? && (dto.productDTOs)?has_content>
                                            <#list dto.productDTOs as productDTO>
                                                <li>
                                                    <a href="<#if (productDTO.productLink)?has_content>${productDTO.productLink}<#elseif (productDTO.product)?has_content>${ctx}/product/${productDTO.product.productId}.html</#if>">
                                                        <div class="pic">
                                                            <#if (productDTO.productImg)?has_content>
                                                                <img src="${(productDTO.productImg)}">
                                                            <#elseif (productDTO.product)?has_content>
                                                                <@productImage productDTO.product "list"/>
                                                            </#if>
                                                        </div>
                                                        <div class="goodsname">
                                                            <#if (productDTO.productName)?has_content>${(productDTO.productName)?html}<#elseif (productDTO.product)?has_content>${(productDTO.product.productName)!?html}</#if>
                                                        </div>
                                                        <div class="goodsprice">
                                                            <span class="price-real"><#if (productDTO.productPrice)?has_content>¥<em>${productDTO.productPrice?string(",##0.00")}</em><#elseif (productDTO.product)?has_content><em><@productOnePrice productDTO.product></@productOnePrice></em></#if></span>
                                                            <span class="price-origin"><em></em></span>
                                                        </div>
                                                    </a>
                                                </li>
                                                <#if productDTO_index == 3>
                                                    <#break>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>

                                <div class="mod-ranklist">
                                    <div class="tit">热销排行榜</div>
                                    <ul>
                                        <#if (dto.hotProducts)?? && (dto.hotProducts)?has_content>
                                            <#list dto.hotProducts as hotProductDTO>
                                                <li <#if hotProductDTO_index == 0>class="selected"</#if>>
                                                    <a href="<#if (hotProductDTO.productLink)?has_content>${hotProductDTO.productLink}<#elseif (hotProductDTO.product)?has_content>${ctx}/product/${hotProductDTO.product.productId}.html</#if>">
                                                        <s class="num">${hotProductDTO_index+1}</s>
                                                        <div class="pic">
                                                            <#if (hotProductDTO.productImg)?has_content>
                                                                <img src="${(hotProductDTO.productImg)}">
                                                            <#elseif (hotProductDTO.product)?has_content>
                                                                <@productImage hotProductDTO.product "list"/>
                                                            </#if>
                                                        </div>
                                                        <div class="goodsname">
                                                            <#if (hotProductDTO.productName)?has_content>${(hotProductDTO.productName)?html}<#elseif (hotProductDTO.product)?has_content>${(hotProductDTO.product.productName)!?html}</#if>
                                                        </div>
                                                        <div class="goodsprice">
                                                            <span class="price-real"><#if (hotProductDTO.productPrice)?has_content>¥<em>${hotProductDTO.productPrice?string(",##0.00")}</em><#elseif (hotProductDTO.product)?has_content><em><@productOnePrice hotProductDTO.product></@productOnePrice></em></#if></span>
                                                        </div>
                                                    </a>
                                                </li>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                <#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_FLOOR_TYPE.type>
                    <div class="goods-floor clearfix" id="flo${floorNum+1}">
                        <div class="goods-flo-l">
                            <h2 class="flo-bg1" <#if (dto.floorDecorateControlDTO.floorBg.picUrl)?has_content>style="background:url(${(dto.floorDecorateControlDTO.floorBg.picUrl)!}) no-repeat" </#if>><span>${floorNum+1}F</span>${(dto.name)!?html}</h2>
                            <div class="flo-l-m" onselectstart="return false">
                                <span class="flo-btn-l"></span>
                                <div class="flo-tab-pic-show clearfix">
                                    <ul class="flo-tab-pic">
                                        <#if (dto.floorDecorateControlDTO.brands)?has_content>
                                            <#assign brandNum = 0>
                                            <#list dto.floorDecorateControlDTO.brands as brand>
                                                <#if brandNum = 0>
                                                <li>
                                                </#if>
                                                <a href="/products/0.html?listStyle=&brand=${(brand.scId)!}" title=""><span><#if (brand.scImg)?has_content><img src="${(brand.scImg)!}" alt=""><#else>${(brand.scText)!?html}</#if></span></a>
                                                <#assign brandNum = brandNum + 1>
                                                <#if brandNum = 3>
                                                </li>
                                                    <#assign brandNum = 0>
                                                </#if>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                                <span class="flo-btn-r"></span>
                            </div>
                            <div class="flo-l-b">
                                <#if (dto.floorDecorateControlDTO.labels)?has_content>
                                    <#list dto.floorDecorateControlDTO.labels as label>
                                        <a href="${(label.linkUrl)!}" title="">${(label.name)!?html}</a>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                        <div class="goods-flo-r">
                            <div class="flo-r-l">
                                <#if (dto.floorDecorateControlDTO.leftMainImg.picUrl)?has_content>
                                    <a href="${(dto.floorDecorateControlDTO.leftMainImg.linkUrl)!}" title=""><img src="${(dto.floorDecorateControlDTO.leftMainImg.picUrl)!}" alt=""></a>
                                </#if>
                            </div>
                            <div class="flo-r-r">
                                <#if (dto.floorDecorateControlDTO.rightMainImg.picUrl)?has_content>
                                    <a href="${(dto.floorDecorateControlDTO.rightMainImg.linkUrl)!}" title=""><img src="${(dto.floorDecorateControlDTO.rightMainImg.picUrl)!}" alt=""></a>
                                </#if>
                            </div>
                            <ul class="flo-r-m">
                                <#if (dto.floorDecorateControlDTO.middleImgs)?has_content>
                                    <#list dto.floorDecorateControlDTO.middleImgs as middleImg>
                                        <li><a href="${(middleImg.linkUrl)!}" title=""><img src="${(middleImg.picUrl)!}" alt=""></a></li>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                    </div>
                    <script type="text/javascript">
                        tabMove("#flo${floorNum+1}");
                    </script>
                    <#assign floorNum = floorNum + 1>
                <#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_NEW_RECOMMEND_TYPE.type>
                    <div id="j_module_${dto_index}" class="module module-1">
                        <div class="module-wrapper">
                            <div class="mod-title">
                                <#if !(dto.showTitleImg)?? || ((dto.showTitleImg)?? && (dto.showTitleImg))>
                                    <#if (dto.titleImg)?has_content>
                                        <a href="${(dto.titleLink)!}">
                                            <img src="${(dto.titleImg)!}" alt=""/>
                                        </a>
                                    <#elseif (!(dto.showName)?? || (dto.showName))>
                                        <span>${(dto.name)!?html}</span>
                                    </#if>
                                <#elseif (!(dto.showName)?? || (dto.showName))>
                                    <span>${(dto.name)!?html}</span>
                                </#if>
                            </div>
                            <div class="mod-list">
                                <ul>
                                    <#if (dto.productList)?? && dto.productList?has_content>
                                        <#list dto.productList as product>
                                            <li>
                                                <div class="pic">
                                                    <a href="${ctx}/product/${product.productId!}.html" target="_blank">
                                                    <#--<@productImage product "browse"/>-->
                                                        <img src='${product.picUrl!}' title='${(product.productName)?default("")?html}'/>
                                                    </a>
                                                </div>
                                                <div class="goodsname">
                                                    <a href="${ctx}/product/${product.productId!}.html" target="_blank">
                                                    ${(product.productName)!?html}
                                                    </a>
                                                </div>
                                            <#--<div class="info">${(productDTO.productInfo)!}</div>-->
                                                <div class="goodsprice"><span>¥<em>${product.defaultPrice!}</em></span></div>
                                            </li>
                                        </#list>
                                    </#if>
                                </ul>
                            </div>
                        </div>
                    </div>
                <#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_ANNOUNCEMENT_TYPE.type>
                    <#assign announcementDecorateControlDTO = dto.announcementDecorateControlDTO>
                    <div class="J_Module_Announcement">
                        <div class="module md-auxiliary-announcement type-${(announcementDecorateControlDTO.iconType)?default("1")}" data-direction="${(announcementDecorateControlDTO.direction)?default("left")}">
                            <div class="m-box" style="border-color: ${(announcementDecorateControlDTO.borderColor)!}; background: ${(announcementDecorateControlDTO.bgColor)!};">
                                <div class="m-icon" style="color:${(announcementDecorateControlDTO.iconColor)!};"></div>
                                <div class="m-text">
                                    <span style="color:${(announcementDecorateControlDTO.font.color)!}; font-size:${(announcementDecorateControlDTO.font.fontSize)!}; font-weight: ${(announcementDecorateControlDTO.font.fontWeight)!};">${(announcementDecorateControlDTO.content)!}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        var mod = $('.J_Module_Announcement');
                        mod.each(function() {
                            var module = $(this).find(".module");
                            var step = 1,
                                    marqueeItem = module.find(".m-text span"),
                                    marqueeWrap = $("<div style='position:relative;'>").appendTo(module.find(".m-text")),
                                    direction = module.attr("data-direction"),
                                    minWidth = marqueeItem.parent().width(),
                                    itemWidth = marqueeItem.width(),
                                    initPos = 0,
                                    pos = 0;

                            if(itemWidth < minWidth) itemWidth = minWidth;
                            marqueeItem.css("min-width",minWidth);
                            marqueeWrap.append(marqueeItem).append(marqueeItem.clone());
                            if(direction == "right"){
                                initPos = minWidth - itemWidth*2;
                                marqueeWrap.css("left",+initPos+"px");
                            }
                            function move(){
                                if(direction == "right"){
                                    pos += step;
                                    if(pos >= minWidth - itemWidth ) pos = initPos;
                                }else{
                                    pos -= step;
                                    if(pos <= -itemWidth ) pos = initPos;
                                }
                                marqueeWrap.css("left",+pos+"px");
                                //requestAnimationFrame(move);
                            }
                            var modMove;
                            setTimeout(function(){
                                modMove=setInterval(move,20);
                            },2000);
                            mod.on({
                                "mouseover": function(){
                                    clearInterval(modMove)
                                },
                                "mouseout": function(){
                                    modMove=setInterval(move,20)
                                }
                            })
                        });
                    </script>
                <#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_CATEGORY_SCROLL_TYPE.type && (dto.categoryDcProductRecommendDTO)?has_content>
                    <#assign categoryProductRecommendDto = dto.categoryDcProductRecommendDTO>
                    <div id="j_module_${dto_index}" class="module module-5">
                        <div class="module-wrapper">
                            <div class="mod-cat">
                                <div class="mod-cat-wrap">
                                    <#if (categoryProductRecommendDto.categories)?has_content>
                                        <#list (categoryProductRecommendDto.categories) as category>
                                            <dl>
                                                <dt><a href="${(category.categoryLink)!}">${(category.categoryName)!?html}</a></dt>
                                                <dd>
                                                    <ul>
                                                        <#if (category.subCategories)?has_content>
                                                            <#list (category.subCategories) as subCategory>
                                                                <#assign subCategoryUrl = "/products/${subCategory.scId}.html">
                                                                <#if subCategory.scType == Static["cn.yr.chile.common.constant.BizConstants"].SUSPEND_NAV_SUB_CATEGORY_TYPE_BRAND>
                                                                    <#assign subCategoryUrl = "/products/0.html?brand=${subCategory.scId}">
                                                                </#if>
                                                                <li><a href="${subCategoryUrl}">${(subCategory.scText)!?html}</a></li>
                                                            </#list>
                                                        </#if>
                                                    </ul>
                                                </dd>
                                            </dl>
                                        </#list>
                                    </#if>
                                </div>
                            </div>
                            <div class="mod-banner">
                                <div class="mod-list">
                                    <ul>
                                        <#if (categoryProductRecommendDto.ctds)?has_content>
                                            <#list (categoryProductRecommendDto.ctds) as ctd>
                                                <li><a href="${(ctd.linkUrl)!}"><img src="${(ctd.picUrl)!}" alt=""/></a></li>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                                <table class="switchable-triggers">
                                    <tr>
                                        <#if (categoryProductRecommendDto.ctds)?has_content>
                                            <#list (categoryProductRecommendDto.ctds) as ctd>
                                                <td><a href="${(ctd.linkUrl)!}">${(ctd.name)!?html}</a></td>
                                            </#list>
                                        </#if>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                    <script>
                        $(function(){
                            var mod = $('#j_module_${dto_index} .mod-banner');
                            mod.switchable({
                                triggers: mod.find('.switchable-triggers a'),
                                effect: 'scrollLeft',
                                loop: true,
                                autoplay:true,
                                panels:'li'
                            });
                        });
                    </script>
                <#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SCROLL_TYPE.type>
                    <div id="j_module_${dto_index}" class="module module-2">
                        <div class="module-wrapper" <#if (dto.titleImg)?has_content>style="background-image: url('${dto.titleImg}');"</#if>>
                            <div class="mod-list">
                                <#if (dto.productList)?? && dto.productList?has_content>
                                    <div class="mod-list-wrap">
                                        <#list dto.productList as product>
                                            <div class="mod-item">
                                                <div class="pic">
                                                    <a href="${ctx}/product/${product.productId!}.html">
                                                    <#--<@productImage product "browse"/>-->
                                                        <img src="${(product.picUrl)!}" title="${(product.productName)?default("")?html}"/>
                                                    </a>
                                                </div>
                                                <div class="info">
                                                    <div class="goodsprice"><span>¥<em>${product.defaultPrice!}</em></span></div>
                                                    <div class="goodsname">
                                                        <a href="${ctx}/product/${product.productId!}.html" target="_blank">
                                                        ${(product.productName)!?html}
                                                        </a>
                                                    </div>
                                                </div>
                                            </div>
                                        </#list>

                                    </div>
                                    <div class="mod-nav mod-nav-prev"></div>
                                    <div class="mod-nav mod-nav-next"></div>
                                </#if>
                            </div>
                        </div>
                    </div>
                    <script>
                        $(function(){
                            var mod2 = $("#j_module_${dto_index}");
                            var itemcount = 5;
                            var list;
                            <#if (dto.productList)?has_content && (dto.productList)?size < 4>
                                <#if (dto.productList)?size % 2 == 0>
                                    itemcount = ${(dto.productList)?size + 1};
                                <#else>
                                    itemcount = ${(dto.productList)?size};
                                </#if>
                            </#if>
                            var shrink_percent = 0.9;
                            var wrap = mod2.find(".mod-list-wrap");
                            var origin_list = list = wrap.children();

                            if(origin_list.length){
                                mod2.find('.mod-nav-prev').on('click',function(){
                                    go(-1);
                                });
                                mod2.find('.mod-nav-next').on('click',function(){
                                    go(1);
                                });

                                var box_w = wrap.width(),box_h = wrap.height();
                                var coords = [];
                                var curIndex = 0;
                                for(var i = 0; i < itemcount+2; i++){
                                    var dir = i < itemcount/2 ? -1 : (i == Math.ceil(itemcount/2) ? 0 : 1);
                                    var offset = Math.abs(Math.floor(i - itemcount/2));
                                    var h = box_h * Math.pow(shrink_percent,offset);
                                    var t = (box_h - h)/2;
                                    var wgrid = box_w/(itemcount+1);
                                    var l = wgrid * i + wgrid*dir*Math.pow(shrink_percent,offset*10) - h/2;
                                    coords.push({
                                        width : h,
                                        height : h,
                                        top : t,
                                        left : l,
                                        zIndex : itemcount+3 - offset
                                    });
                                }

                                while(list.length < itemcount+2){
                                    var tmp = origin_list.clone();
                                    wrap.append(tmp);
                                    list = wrap.children();
                                }
                                list.hide();
                                loop(0,function(i,start,end){
                                    var item = this;
                                    var pos = coords[i+Math.ceil(itemcount/2)];
                                    item.css({
                                        width : pos.width,
                                        height : pos.height,
                                        top : pos.top,
                                        left : pos.left,
                                        zIndex : pos.zIndex
                                    });
                                    (i != start && i != end-1) ? item.show() : '';
                                    i == 0 ? item.addClass('current') : '';
                                });

                                function go(target){
                                    list.eq(curIndex).removeClass('current');
                                    var index = getIndex(curIndex+target);
                                    loop(index,function(i,start,end){
                                        var item = this;
                                        var pos = coords[i+Math.ceil(itemcount/2)];
                                        var isStart = (target > 0 && i == start) || (target < 0 && i == end-1);
                                        var isEnd = (target > 0 && i == end-2) || (target < 0 && i == start+1);

                                        isEnd && item.css({opacity:0,display:'block'});
                                        item.animate({
                                            width : pos.width,
                                            height : pos.height,
                                            top : pos.top,
                                            left : pos.left,
                                            zIndex : pos.zIndex,
                                            opacity : (isStart ? 0 : 1)
                                        },{
                                            duration : 200,
                                            complete : function(){
                                                isStart && item.hide();
                                                i == 0 && item.addClass('current');
                                                curIndex = index;
                                            }
                                        });
                                    });
                                }
                                function loop(index,callback){
                                    var start = Math.ceil(-itemcount/2)-1,end = Math.ceil(itemcount/2)+1;
                                    for(var i = start; i < end; i++){
                                        var item = list.eq(getIndex(i+index));
                                        callback.call(item,i,start,end);
                                    }
                                }
                                function getIndex(i){
                                    return i < list.length ? (i >= 0 ? i : list.length + i) : i%list.length;
                                }
                            }
                        });
                    </script>
                <#elseif (dto.showType)?has_content
                && (dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE3_TYPE.type
                || dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE4_TYPE.type)>
                    <div id="j_module_${dto_index}" class="module <#if dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE4_TYPE.type> module-9<#else> module-3</#if>">
                        <div class="module-wrapper">
                            <div class="mod-title">
                                <#if !(dto.showTitleImg)?? || ((dto.showTitleImg)?? && (dto.showTitleImg))>
                                    <#if (dto.titleImg)?has_content>
                                        <a href="${(dto.titleLink)!}">
                                            <img src="${(dto.titleImg)!}" alt=""/>
                                        </a>
                                    <#elseif (!(dto.showName)?? || (dto.showName))>
                                        <span>${(dto.name)!?html}</span>
                                    </#if>
                                <#elseif (!(dto.showName)?? || (dto.showName))>
                                    <span>${(dto.name)!?html}</span>
                                </#if>
                            </div>
                            <div class="mod-con">
                                <div class="mod-banner">
                                    <a href="${dto.adLink!}">
                                        <img src="${dto.adImg!}" alt=""/>
                                    </a>
                                </div>
                                <div class="mod-list">
                                    <ul>
                                        <#if (dto.productList)?? && dto.productList?has_content>
                                            <#list dto.productList as product>
                                                <li>
                                                    <div class="picwrap">
                                                        <div class="pic">
                                                            <a href="${ctx}/product/${product.productId}.html" target="_blank">
                                                            <#--<@productImage product "browse"/>-->
                                                                <img src='${product.picUrl!}' title='${(product.productName)?default("")?html}'/>
                                                            </a>
                                                        </div>
                                                        <div class="piclayer"><a href="${ctx}/product/${product.productId}.html">加入购物车</a></div>
                                                    </div>
                                                    <div class="info">
                                                        <div class="goodsname">
                                                            <a href="${ctx}/product/${product.productId}.html" target="_blank">
                                                            ${(product.productName)!?html}
                                                            </a>
                                                        </div>
                                                        <#if (dto.autoGrabProductInfo)?? && (dto.autoGrabProductInfo)>
                                                            <div class="goodsdesc">${(product.defaultSku.shortDescripition)!?html}</div>
                                                        </#if>
                                                        <div class="goodsprice"><span>¥<em>${product.defaultPrice!}</em></span></div>
                                                    </div>
                                                </li>
                                            </#list>
                                        </#if>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script>
                        $(function(){
                            var mod3 = $("#j_module_${dto_index}");
                            mod3.find('.picwrap').each(function(){
                                var wrap = $(this),
                                        layer = wrap.find('.piclayer'),
                                        h = layer.height();
                                wrap.hover(function(){
                                    layer.stop().animate({'bottom':0},100);
                                },function(){
                                    layer.stop().animate({'bottom':-h},100);
                                });
                            })
                        });
                    </script>
                <#--<#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_SKU_OFFER_TYPE.type>
                    <div id="j_module_${dto_index}" class="module module-4">
                        <div class="module-wrapper">
                            <div class="mod-list">
                                <ul>
                                    <#if (dto.basicProductDTOs)?? && dto.basicProductDTOs?has_content>
                                        <#list dto.basicProductDTOs as temp>
                                            <li class="mod-item">
                                                <div class="pic">
                                                    <a href="<#if (temp.productLink)?has_content>${(temp.productLink)!}<#elseif (temp.product)?has_content>${ctx}/product/${temp.product.productId}.html</#if>">
                                                        <#if (temp.productImg)?has_content>
                                                            <img src="${(temp.productImg)!}">
                                                        <#elseif (temp.product)?has_content>
                                                            <@productImage temp.product/>
                                                        </#if>
                                                    </a>
                                                </div>
                                                <div class="info">
                                                    <div class="goodsname">
                                                        <a href="<#if (temp.productLink)?has_content>${(temp.productLink)!}<#elseif (temp.product)?has_content>${ctx}/product/${temp.product.productId}.html</#if>">
                                                            <#if (temp.productName)?has_content>
                                                                ${(temp.productName)?html}
                                                            <#elseif (temp.product)?has_content>
                                                                ${(temp.product.productName)!?html}
                                                            </#if>
                                                        </a>
                                                    </div>
                                                    <div class="intro">${(temp.productInfo)!}</div>
                                                    <div class="goodsprice">
                                                        <#if (temp.productPrice)?has_content>
                                                            <div class="price-real"><span>¥<em>${temp.productPrice?string(",##0.00")}</em></span></div>
                                                        <#elseif (temp.product)?has_content>
                                                            <#if temp.product.defaultSku.salePrice?has_content && temp.product.defaultSku.salePrice.amount != temp.product.defaultSku.retailPrice.amount>
                                                                <div class="price-real"><span>¥<em>${temp.product.defaultSku.salePrice.amount?string(",##0.00")}</em></span></div>
                                                                <div class="price-origin"><span>原价:¥<em>${temp.product.defaultSku.retailPrice.amount?string(",##0.00")}</em></span></div>
                                                            <#else>
                                                                <div class="price-real"><span>¥<em>${temp.product.defaultSku.retailPrice.amount?string(",##0.00")}</em></span></div>
                                                            </#if>
                                                        </#if>
                                                    </div>
                                                    <div class="toolbar">
                                                        <ul>
                                                            <li><a class="tool-btn-cart" href="<#if (temp.productLink)?has_content>${(temp.productLink)!}<#elseif (temp.product)?has_content>${ctx}/product/${temp.product.productId}.html</#if>">去购买</a></li>
                                                        </ul>
                                                    </div>
                                                </div>
                                            </li>
                                        </#list>
                                    </#if>
                                </ul>
                            </div>
                        </div>
                    </div>-->
                    <script type="text/javascript">
                        $(function(){
                            $('#j_module_${dto_index} .mod-list').switchable({
                                triggers: '&bull;',
                                putTriggers: 'insertAfter',
                                effect: 'fade',
                                easing: 'ease-in-out',
                                loop: true,
                                autoplay:true,
                                panels:'.mod-item'
                            });
                        });
                    </script>
                <#--<#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_MODULE6_TYPE.type>
                <div id="j_module_${dto_index}" class="module module-6">
                    <div class="module-wrapper">
                        <#if !(dto.showTitleImg)?? || ((dto.showTitleImg)?? && (dto.showTitleImg))>
                            <#if (dto.titleImg)?has_content>
                                <div class="mod-banner">
                                    <a href="${(dto.titleLink)!}" target="_blank">
                                        <img src="${(dto.titleImg)!}" alt=""/>
                                    </a>
                                </div>
                            <#elseif (!(dto.showName)?? || (dto.showName))>
                                <span>${(dto.name)!?html}</span>
                            </#if>
                        <#elseif (!(dto.showName)?? || (dto.showName))>
                            <div class="mod-title"><span>${(dto.name)!?html}</span></div>
                        </#if>
                        <div class="mod-list">
                            <ul>
                                <#if (dto.productList)?? && dto.productList?has_content>
                                    <#list dto.productList as product>
                                        <li>
                                            <a href="${ctx}/product/${product.productId}.html">
                                                <div class="pic">
                                                    <img src='${product.picUrl!}' title='${(product.productName)?default("")?html}'/>
                                                </div>
                                                <div class="info">
                                                    <div class="goodsname">
                                                    ${(product.productName)!?html}
                                                    </div>
                                                    <div class="goodsprice">
                                                        <#if product.salePrice?has_content && product.salePrice.amount != product.retailPrice.amount>
                                                            <div class="price-real"><span>¥<em>${product.salePrice.amount?string(",##0.00")}</em></span></div>
                                                            <div class="price-origin"><span>原价:¥<em>${product.retailPrice.amount?string(",##0.00")}</em></span></div>
                                                        <#else>
                                                            <div class="price-real"><span>¥<em>${product.retailPrice.amount!?string(",##0.00")}</em></span></div>
                                                        </#if>
                                                    </div>
                                                </div>
                                            </a>
                                        </li>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                    </div>
                </div>-->
                <#elseif (dto.showType)?has_content && dto.showType == Static["cn.yr.chile.common.constant.DecorateControlShowType"].PC_PRODUCT_TAB_TYPE.type>
                    <div id="j_module_${dto_index}" class="module module-7">
                        <div class="module-wrapper">
                            <div class="mod-tab">
                                <ul>
                                    <#if (dto.tabs)?has_content>
                                        <#list dto.tabs as tab>
                                            <li><a href="${(tab.link)!}">* ${(tab.name)!?html}</a></li>
                                        </#list>
                                    </#if>
                                </ul>
                            </div>
                            <div class="mod-tabcon">
                                <#if (dto.tabs)?has_content>
                                    <#list dto.tabs as tab>
                                        <div class="mod-tab-item">
                                            <div class="mod-banner">
                                                <div class="mod-banner1"><a href="${(tab.mainImg.linkUrl)!}"><img src="${(tab.mainImg.picUrl)!}" alt=""/></a></div>
                                                <div class="mod-banner2"><a href="${(tab.leftBottomImg.linkUrl)!}"><img src="${(tab.leftBottomImg.picUrl)!}" alt=""/></a></div>
                                                <div class="mod-banner3"><a href="${(tab.rightBottomImg.linkUrl)!}"><img src="${(tab.rightBottomImg.picUrl)!}" alt=""/></a></div>
                                            </div>
                                            <div class="mod-list">
                                                <ul>
                                                    <#if (tab.productList)?has_content>
                                                        <#list tab.productList as product>
                                                            <li>
                                                                <a href="${ctx}/product/${product.productId}.html">
                                                                    <div class="pic"><img src="${product.picUrl!}"/></div>
                                                                    <div class="info">
                                                                        <div class="goodsname">${(product.productName)!?html}</div>
                                                                        <div class="goodsprice"><span>¥<em>${product.defaultPrice!}</span></div>
                                                                    </div>
                                                                </a>
                                                            </li>
                                                        </#list>
                                                    </#if>
                                                </ul>
                                            </div>
                                        </div>
                                    </#list>
                                </#if>
                            </div>
                        </div>
                    </div>
                    <script>
                        $(function(){
                            var mod = $('#j_module_${dto_index}');
                            mod.switchable({
                                triggers: mod.find('.mod-tab a'),
                                panels:'.mod-tab-item',
                                effect:'fade'
                            });
                        });
                    </script>
                <#else>
                    <div id="j_module_${dto_index}" class="module module-3">
                        <div class="module-wrapper">
                            <div class="mod-title">
                                <a href="${dto.titleLink!}">
                                    <img src="${dto.titleImg!}" alt=""/>
                                </a>
                            </div>
                            <div class="mod-banner">
                                <a href="${dto.adLink!}">
                                    <img src="${dto.adImg!}" alt=""/>
                                </a>
                            </div>
                            <div class="mod-list">
                                <ul>
                                    <#if (dto.productList)?? && dto.productList?has_content>
                                        <#list dto.productList as product>
                                            <li>
                                                <div class="picwrap">
                                                    <div class="pic">
                                                        <a href="${ctx}/product/${product.productId}.html" target="_blank">
                                                        <#--<@productImage product "browse"/>-->
                                                            <img src='${product.picUrl!}' title='${(product.productName)?default("")?html}'/>
                                                        </a>
                                                    </div>
                                                    <div class="piclayer">
                                                        <a href="${ctx}/product/${product.productId}.html" target="_blank">立即购买</a>
                                                    </div>
                                                </div>
                                                <div class="info">
                                                    <div class="goodsname">
                                                        <a href="${ctx}/product/${product.productId}.html" target="_blank">
                                                        ${(product.productName)!?html}
                                                        </a>
                                                    </div>
                                                    <div class="goodsprice">
                                                        <span>¥<em>${product.defaultPrice!}</em></span>
                                                    </div>
                                                </div>
                                            </li>
                                        </#list>
                                    </#if>
                                </ul>
                            </div>
                        </div>
                    </div>
                </#if>
            </#if>
        </#list>

        <script>
            $(function(){
                var mod3 = $(".module-3");
                mod3.find('.picwrap').each(function(){
                    var wrap = $(this),
                            layer = wrap.find('.piclayer'),
                            h = layer.height();
                    wrap.hover(function(){
                        layer.stop().animate({'bottom':0},100);
                    },function(){
                        layer.stop().animate({'bottom':-h},100);
                    });
                });
            });
        </script>
    </#if>
    </div>

<#if indexShowArticle?has_content>
    <div class="layout">
        <div class="newsblock">
            <#list indexShowArticle as dto>
                <div class="newsbox">
                    <h3 class="title"><span>${(dto.type.articleTypeName)?default("")?html}</span></h3>
                    <div class="newscon">
                        <ul>
                            <#list  dto.topArticle as article>
                                <li>
                                    <a href="${ctx}/article/${article.id}.html">${article.title?default("")?html}
                                        <#if article_index lt 2>
                                            <span class="ico-new"></span>
                                        </#if>
                                    </a>
                                </li>
                            </#list>
                        </ul>
                    </div>
                </div>
            </#list>
        </div>
    </div>
</#if>
</div>
<#-- 首页广告弹窗-->
<#if indexCenterSuspended?has_content && (indexCenterSuspended.itemValue)?has_content>
    <#if (indexCenterSuspended.type)?? && indexCenterSuspended.type == templateJsonType>
        <#assign centerSuspendObjs = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].buildCustomTemplateList((indexCenterSuspended.itemValue)?default(""))>
        <#if centerSuspendObjs?has_content>
        <div id="overlayAd" style="display: none;">
            <div class="mask"></div>
            <div class="overlay-ad">
                <div class="ova-wrap">
                    <ul>
                        <#list centerSuspendObjs as centerSuspend>
                            <li>
                                <a <#if (centerSuspend.openNewWin)?? && (centerSuspend.openNewWin)>target="_blank"</#if> <#if (centerSuspend.linkUrl)?has_content>href="${centerSuspend.linkUrl}"</#if>>
                                    <img src="${(centerSuspend.picUrl)?default('')}" alt="" style="width: 500px;height: 500px;"/>
                                </a>
                            </li>
                            <#break>
                        </#list>
                    </ul>
                </div>
                <div class="close"><a href="javascript:void(0)">&times;</a></div>
            </div>
        </div>
        <#--<script type="text/javascript">
            $('#overlayAd .ova-wrap').switchable({
                /*triggers: '&bull;',*/
                /*putTriggers: 'insertAfter',*/
                triggerType: 'click',
                effect: 'scrollLeft',
                /*easing: 'ease-in-out',*/
                /*loop: true,*/
                autoplay:true,
                panels:'li'
                /*prev: '#inslide_prev',*/
                /*next: '#inslide_next',*/
            });

        </script>-->
        </#if>
    <#--<#else>
        <div id="overlayAd" style="display: none;">
            <div class="mask"></div>
            <div class="overlay-ad">
                <div class="ova-wrap">${indexCenterSuspended.itemValue}</div>
                <div class="close"><a href="javascript:void(0)">&times;</a></div>
            </div>
        </div>-->
    </#if>
<script type="text/javascript">
    var suspendedTimeCookieKey = "roma_suspended_time";
    var suspendedTimeCookie = getCookie(suspendedTimeCookieKey);
    var suspendedTime = '${(indexCenterSuspended.updatedTime)?long}';
    if(suspendedTimeCookie && parseFloat(suspendedTime) <= parseFloat(suspendedTimeCookie)){
        $("#overlayAd").remove();
    } else {
        $("#overlayAd").show();
    }

    $(function(){
        $("#overlayAd .close").on("click",function(){
            addCookie(suspendedTimeCookieKey, suspendedTime, (30 * 24));
            $("#overlayAd").remove();
        });
    });

    function addCookie(objName, objValue, objHours){//添加cookie
        var str = objName + "=" + escape(objValue);
        if(objHours > 0){//为0时不设定过期时间，浏览器关闭时cookie自动消失
            var date = new Date();
            var ms = objHours * 3600 * 1000;
            date.setTime(date.getTime() + ms);
            str += "; expires=" + date.toGMTString();
        }
        document.cookie = str;
    }

    function getCookie(objName){//获取指定名称的cookie的值
        var arrStr = document.cookie.split("; ");
        for(var i = 0;i < arrStr.length;i ++){
            var temp = arrStr[i].split("=");
            if(temp[0] == objName) return unescape(temp[1]);
        }
    }
</script>
</#if>
</body>
</html>