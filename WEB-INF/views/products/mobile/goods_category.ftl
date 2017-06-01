<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>商品分类</title>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
		            <h1 class="mui-title">商品分类</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>
        <div class="shelves-search">
            <div class="category-search">
                <input type="text" id="searchKey" placeholder="搜索您想要的商品">
                <button type="button" onclick="searchByKeyword()">搜索</button>
            </div>
        </div>
        <div class="mui-content">
            <div id="slider" class="mui-slider mui-fullscreen">
                <div class="mui-scroll-navwrapper">
                    <div class="mui-scroll">
                        <div class="categorynav">
                            <ul>
                                <#if productLabelList?? && productLabelList?has_content>
                                    <#list productLabelList as productLabel>
                                        <li class="categoryLi" data-id="label_${(productLabel.labelId)!}">
                                            <a class="categoryA" href="javascript:void(0);" onclick="liChangeSelect('${(productLabel.labelId)!}','label',1);">${(productLabel.labelName)!}</a>
                                        </li>
                                    </#list>
                                </#if>
                                <#if productCategoryList?? && productCategoryList?has_content>
                                    <#list productCategoryList as productCategory>
                                        <li class="categoryLi" data-id="category_${(productCategory.categoryId)!}">
                                            <a class="categoryA" href="javascript:void(0);" onclick="liChangeSelect('${(productCategory.categoryId)!}','category',1);">${(productCategory.categoryName)!}</a>
                                        </li>
                                    </#list>
                                </#if>
                            </ul>
                        </div>
                    </div>
                </div>

                <div class="mui-rightpro">
                    <div class="mui-scroll-wrapper">
                        <div class="mui-scroll">
                            <div class="prouctsList">
                                <div class="pimg">
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
    var currentProductType = "";
    var currentId = "";
    var currentPage = "";
    var productList = $('#productList');

    $(function(){
        imgLazyLoad();
        document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
        $('.categoryA').eq(0).trigger('click');
    })

    function liChangeSelect(id, productType, page){
        $('.categoryLi').removeClass('selected');
        $('li[data-id="'+productType+"_"+id+'"]').addClass('selected');

        $(".mui-scroll").css("transform","translate3d(0px, 0px, 0px)");

        loadProductList(id, productType, page, false);
    }
	
    //根据关键字搜索商品 
    function searchByKeyword(){
    	var q = $("#searchKey").val();
    	var mstoreId = ${mstoreId!"0"};
    	window.location.href = '${ctx}/m/account/productmanager/searchMstoreProductsByKeyword/'+mstoreId+"?q="+q;
     
    }

    function loadProductList(id, productType, page, isAppend){
        currentId = id;
        currentProductType = productType;
        currentPage = page;

        var data = {};
        data.productType = productType;
        data.mstoreId = ${mstoreId!"0"};
        data.sort = "time_l asc";
        data.page = page;
        
        $.get('${ctx}/m/account/productmanager/'+id, data, function(resultData){
            if(!isAppend){
                productList.html('');
            }

            if(resultData && resultData.rows && resultData.rows != null){
                renderUlData(resultData.rows);
            }

            if(resultData.bannerImg){
                $('#bannerImg').attr('src', '${ctx}'+resultData.bannerImg);
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
    }

    mui.init();

    (function($) {
        //阻尼系数
        $('.mui-scroll-navwrapper,.mui-scroll-wrapper').scroll({
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
                                loadProductList(currentId, currentProductType, currentPage+1, true);
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