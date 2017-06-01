<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>${(productBrand.brandName)!}</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m"></a>
        <h1 class="mui-title">${(productBrand.brandName)!}</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="shelves-search">
        <div class="category-search">
            <input type="text" id="searchKey" placeholder="搜索您想要的商品">
            <button type="button" onclick="searchByKeyword();">搜索</button>
        </div>
    </div>
    <div class="mui-content">
        <div id="slider" class="mui-slider mui-fullscreen">
            <div class="mui-rightpro prolist">
                <div class="mui-scroll-wrapper">
                    <div class="mui-scroll">
                        <div class="prouctsList prouctsListclass">
                            <div class="pimg" id="categoryBannerImg" style="display: none;">
                                <img id="bannerImg" src="${ctx}/static/mobile/images/blank.gif">
                            </div>

                            <ul class="mui-table-items" id="productList">
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${ctx}/static/mobile/js/mui/mui.pullToRefresh.js"></script>
<script type="text/javascript" src="${ctx}/static/mobile/js/mui/mui.pullToRefresh.material.js"></script>
<script>
    var currentId = "";
    var currentPage = "";
    var productList = $('#productList');
    $(function(){
        document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);//touchmove上移触发事件
        loadProductList('${id!}', 1, false);
    })

    function searchByKeyword(){//搜索
        loadProductList(currentId, 1, false);
    }

    function loadProductList(id, page, isAppend){
        currentId = id;
        currentPage = page;

        var data = {};
        data.sort = "time_l desc";
        data.page = page;
        data.q = $("#searchKey").val();
        $.get('${ctx}/m/brand/products/'+id, data, function(resultData){
            if(!isAppend){
                productList.html('');
            }

            if(resultData && resultData.rows && resultData.rows != null){
                renderUlData(resultData.rows);
            }

            if(resultData.bannerImg){//头部图片
                $('#categoryBannerImg').show();
                $('#bannerImg').attr('src', '${ctx}'+resultData.bannerImg);
            }else{
                $('#categoryBannerImg').hide();
            }
        }, 'json');
    }

    function renderUlData(rows) {
        var fragment = document.createDocumentFragment();
        var li;
        var row;
        for (var i = 0; i < rows.length; i++) {
            row = rows[i];
            li = document.createElement('li');
            li.innerHTML = '<a href="${ctx}/m/product/'+row["productId"]+'"><div class="pic"><img class="lazyload" src="${ctx}/static/mobile/images/blank.gif" data-src="${ctx}'+row["picUrl"]+'"/></div>' +
                    '<div class="intro"><div class="name">'+row["productName"]+'</div>' +
                    '<div class="price">¥'+row["defaultPrice"]+'</div></div></a>';
            fragment.appendChild(li);
        }

        //console.log(productList)
        productList.append(fragment);
        imgLazyLoad();
    }

    mui.init();

    (function($) {
        //阻尼系数
        $('.mui-scroll-wrapper').scroll({
            bounce: true,
            indicators: true, //是否显示滚动条
            deceleration:0.0009
        });
        $.ready(function() {
            //循环初始化所有下拉刷新，上拉加载。
            $.each(document.querySelectorAll('.mui-rightpro .mui-scroll'), function(index, pullRefreshEl) {
                $(pullRefreshEl).pullToRefresh({
                    up: {
                        callback: function() {
                            var self = this;
                            setTimeout(function() {
                                loadProductList(currentId, currentPage+1, true);
                                self.endPullUpToRefresh();
                                imgLazyLoad();
                            }, 1000);
                        }
                    }
                });
            });
        });
    })(mui);

    function imgLazyLoad(){
        $("img.lazyload").css({
            width : "100%",
            height : "100%"
        }).unveil(0, function () {
            var img = $(this);
            img.one("load", function () {
                img.css({
                    height : "auto",
                    width : "auto"
                });
            });
        });
    }
</script>
</body>
</html>