<#assign tempalteId = Static["cn.yr.chile.common.constant.BizConstants"].TEMPLATE_ID>
<#assign tempalteTheme = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getSiteTemplateTheme()?default("")>
<#assign pcTempalte = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getCurrentTemple()?default("01")>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link rel="stylesheet" href="${staticPath}/css/global.css">
    <link rel="stylesheet" href="${staticPath}/css/style.css">
    <link rel="stylesheet" href="${staticPath}/admin/css/decoration.css">
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
</head>
<body>

<div id="header">
    <div class="topbox">
        <div class="top-container">
            <div class="toptools" data-edit-type="topTools" style="min-width: 60px;">
                <#--<p><a href="/">厦航商城首页</a></p>-->
            </div>
            <div class="toplinks" data-edit-type="topLinks" style="min-width: 60px;">
                <#--<p><a href="#">我的帐号</a></p>-->
                <#--<p><a href="#">购物车</a></p>-->
                <#--<p><a href="#">网站公告</a></p>-->
                <#--<p><a href="#">帮助</a></p>-->
            </div>
        </div>
    </div>
    <div class="top-container header-main">
        <div class="header-logo"></div>
        <div class="topshopcart">
            <a href="javascript:void(0);" class="header-cart"><span>我的购物车</span><em>(0)</em></a>
        </div>
        <div class="topsearch">
            <div class="search-panel">
                <input type="text" placeholder="搜索商品">
                <button>搜索</button>
            </div>
            <div class="hotsearch" data-edit-type="hotSearch" id="hotSearch">
                <#--<a href="#">初夏T恤</a>-->
                <#--<a href="#">新款凉鞋</a>-->
                <#--<a href="#">夏季防晒衫</a>-->
                <#--<a href="#">开衫</a>-->
                <#--<a href="#">男T恤</a>-->
            </div>
        </div>
    </div>
    <div id="nav">
        <div class="navWrap">
            <div class="nav-catalog">
                <div class="catalog-wrap">
                    <h2 class="catalog-title">
                        <span>全部商品分类</span>
                    </h2>
                </div>
                <div class="navigation">
                    <ul>
                        <ul>
                            <li><a href="#">首页</a></li>
                            <li class="site-nav-item zx-placeholder excludeOperateElement"
                                data-edit-type="siteNav" name="addNewNavModel">新增</li>
                        </ul>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var zxdiv;
    $(function(){
        zxdiv = $("<div class='zx-mask'><a id='editHref' href='javascript:void(0);' onclick='javascript:editElement(this);'>编辑</a><a class='zx-btn-delete' id='deleteHref' href='javascript:void(0)' onclick='javascript:deleteElement(this);'>&times;</a></div>").hide().appendTo(document.body);
        zxdiv.on("mouseleave",function(){
            zxdiv.find("#editHref").removeAttr("data-edit-type").removeAttr("data-edit-index");
            zxdiv.find("#deleteHref").removeAttr("data-edit-type").removeAttr("data-edit-index");
            zxdiv.hide();
        });
        $(".topad,.toptools,.toplinks,#logoExtra,.hdsearch-right,.site-nav-item,.hotsearch").each(function(){
            var $this = $(this);
            $this.on("mouseenter",function(){
                showZXDivLayer($this);
            });
        });

        $("li[name='addNewNavModel']").bind('click', function(){
            addNewNav();
        });
    });

    function editElement(obj){
        var editType = $(obj).attr("data-edit-type");
        if("siteNav" == editType){
            showNavElement(obj);
        } else {
            window.parent.editElement(obj);
        }
    }

    function deleteElement(obj){
        var editType = $(obj).attr("data-edit-type");
        if("siteNav" == editType){
            var editIndex = $(obj).attr("data-edit-index");
            deleteNavElement(editIndex);
        } else {
            window.parent.deleteElement(obj);
        }
    }

    function showZXDivLayer(obj){
        if($(obj).hasClass("excludeOperateElement")) return;
        var editType = $(obj).attr("data-edit-type");
        var offset = $(obj).offset(),
                w = $(obj).outerWidth() - 4,
                h = $(obj).outerHeight() - 4;
        zxdiv.find("#editHref").attr("data-edit-type", editType);
        zxdiv.find("#deleteHref").attr("data-edit-type", editType);
        if("siteNav" == editType){
            var editIndex = $(obj).attr("data-edit-index");
            zxdiv.find("#editHref").attr("data-edit-index", editIndex);
            zxdiv.find("#deleteHref").attr("data-edit-index", editIndex);
        }
        zxdiv.css({
            lineHeight: h+'px',
            top: offset.top,
            left:offset.left,
            width:w,
            height:h
        }).show();
    }

    function fillTopAdElement(topAdPicUrl){
        var iframeTopAdView = $("#topad");
        iframeTopAdView.children("div").removeClass("zx-placeholder");
        iframeTopAdView.find("label").hide();
        iframeTopAdView.find("img").attr("width","100%");
        iframeTopAdView.find("img").attr("src", topAdPicUrl);
    }

    function fillLogoExtraElement(logoExtraPicUrl){
        var iframeTopAdView = $("#logoExtra");
        iframeTopAdView.removeClass("zx-placeholder");
        iframeTopAdView.find("label").hide();
        iframeTopAdView.find("img").attr("width","150px");
        iframeTopAdView.find("img").attr("src", logoExtraPicUrl);
    }

    function fillHeaderSearchRightElement(headerSearchRightPicUrl){
        var iframeTopAdView = $("#headerSearchRight");
        iframeTopAdView.children("div").removeClass("zx-placeholder");
        iframeTopAdView.find("label").hide();
        iframeTopAdView.find("img").attr("width","108px");
        iframeTopAdView.find("img").attr("src", headerSearchRightPicUrl);
    }

    function fillHotSearchElement(hotSearchHtml){
        var iframeHotSearchView = $("#hotSearch");
        if("" == hotSearchHtml){
            hotSearchHtml = "点击这里编辑关键词链接栏"
        }
        iframeHotSearchView.html(hotSearchHtml);
    }

    function fillTopToolsElement(topToolsHtml){
        if("" == topToolsHtml){
            topToolsHtml = "点击这里编辑顶部工具栏"
        }
        $(".toptools").html(topToolsHtml);
    }

    function fillNavElement(navIndex, navText){
        $(".site-nav-item[data-edit-index="+navIndex+"]").html(navText);
    }

    function fillTopLinksElement(topLinksHtml){
        if("" == topLinksHtml){
            topLinksHtml = "点击这里编辑顶部链接栏"
        }
        $(".toplinks").html(topLinksHtml);
    }

    var currentNavIndex;
    function addNewNav(){
        var navLi = $("li[name='addNewNavModel']").clone();
        var navIndex = (getCurrentNavCount() + 1);
        navLi.removeAttr("name");
        navLi.removeClass("excludeOperateElement");
        navLi.attr("data-edit-index", navIndex);
        navLi.html("新菜单");
        navLi.bind("mouseenter",function(){
            showZXDivLayer(navLi);
        });
        navLi.insertBefore($("li[name='addNewNavModel']"));
        window.parent.showSiteNavContent(navIndex);
    }

    function deleteNavElement(navIndex){
        var targetNav = $("li[data-edit-index='"+navIndex+"']");
        targetNav.remove();
        $("li[data-edit-index]").each(function(){
            var contentIndex = $(this).attr("data-edit-index");
            if(parseInt(contentIndex) >= parseInt(navIndex)){
                var newLiIndex = parseInt(contentIndex) - 1;
                $(this).attr("data-edit-index", newLiIndex);
            }
        });
        window.parent.deleteSiteNavContent(navIndex);
    }

    function getCurrentNavCount(){
        return $(".site-nav-item").not(".excludeOperateElement").length;
    }

    function showNavElement(obj){
        if(obj){
            var editIndex = $(obj).attr("data-edit-index");
            if(editIndex){
                window.parent.showSiteNavContent(editIndex);
            }
        } else {
            var firstNavElement = $(".site-nav-item").not(".excludeOperateElement")[0];
            if(firstNavElement){
                showNavElement(firstNavElement);
            }
        }
    }
</script>
</body>
</html>