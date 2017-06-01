<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <title>积分商城</title>
</head>

<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">积分商城</h1>
        <a class="mui-icon"></a>
    </header>

    <input type="hidden" id="categoryId" name="categoryId" value="0">
    <input type="hidden" id="pageIndex" name="pageIndex" value="1">
    <input type="hidden" id="sort" name="sort" value="${sort?default('time_l desc')}">

    <div class="mui-content">
        <div class="prd-list-grid">
            <ul id="productListUl"></ul>
        </div>

        <div class="listft">
            共有商品<em id="totalSize"></em>个 当前列表<em id="currentPageSize"></em>个
        </div>

        <div class="mui-content-padded">
            <ul class="mui-pager">
                <li id="prePageLi">
                    <a href="javascript:prevPage();">上一页</a>
                </li>
                <li>
                    <span id="currentPage" style="border: none;border-radius: 0px;background-color: #f6f6f6;"></span>/<span id="totalPage" style="border: none;border-radius: 0px;background-color: #f6f6f6;">></span>
                </li>
                <li id="nextPageLi">
                    <a href="javascript:nextPage();">下一页</a>
                </li>
            </ul>
        </div>

        <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>

</div>

<script>
    var currentPage = 0;
    var totalPage = 0;
    $(function(){
    	findPreSaleProductIds();
        imglazyload();

        loadProductList();

        if (currentPage <= 1) {
            $('#prePageLi').addClass('mui-disabled');
        }
        if (currentPage > (totalPage-1)) {
            $('#nextPageLi').addClass('mui-disabled');
        }

        resetHeight();
        var screensideMove = 0;
        $(".screenBtnWrap").on("click", function(e){
            if(screensideMove==0){
                $("#page").append("<div class='screenbackdrop'></div>");
                $(".screenside").show().addClass("screenside-in");
                $(".screenside").removeClass("screenside-out");
                $(document).bind("touchmove",function(e){
                    e.preventDefault();
                });
                screensideMove=1;
                $(".screenbackdrop").on("click", function(e){
                    $(".screenside").removeClass("screenside-in");
                    $(".screenside").addClass("screenside-out");
                    $(document).unbind("touchmove");
                    setTimeout("$('.screenside').hide();$('.screenbackdrop').remove();",400);
                    screensideMove=0;
                })
            }
        })
    })

    function resetHeight(){
        var windowHeight = $(window).height();
        $(".screenside").height(windowHeight);
    }
    $(window).on('resize',resetHeight);

    function loadProductList(pageIndex){
        var sort = $("#sort").val();

        var categoryId = $("#categoryId").val();

        var page = $("#pageIndex").val();
        if(pageIndex){
            page = pageIndex;
        }
        var searchKey = $("#searchKey").val();
        if(!searchKey){
            searchKey = "";
        }

        var paramData = {
            q: searchKey,
            page: page,
            sort: sort,
            containPoint:1
        };

        $.ajax({
            url  : "/m/products/jsonData/" + categoryId + ".html",
            type : "GET",
            dataType : "json",
            data : paramData,
            success : function(data) {
                if(data && data.result == "success") {
                    renderProductList(data);
                    renderPagerBottom(data.pageDTO);
                }else{
                    mui.toast(data.message || '加载商品数据失败!');
                }
            },
            error:function(XMLHttpResponse ){
                mui.toast(XMLHttpResponse.message);
            }
        });
    }

    function renderProductList(data){
        var pageDTO = data.pageDTO;
        var productList = pageDTO.content;

        $('#totalSize').html(pageDTO.totalSize);
        $('#productListUl').empty();

        if(productList && productList.length > 0){
            $('#currentPageSize').html(productList.length);

            $.each(productList, function(i,val){
                var content = '<li>';
                content = content + '<a href="/m/product/'+val.productId+'">';
                content = content + '<div class="pic">';
                content = content + '<img class="lazyload" src="'+val.picUrl+'" data-src="'+val.picUrl+'" alt=""/>';
                if(preSaleProductIds.length>0){
                	for(var i=0; i<preSaleProductIds.length; i++){
                		var id= preSaleProductIds[i];
                		if(val.productId ==id){
                			content = content + '<i class="info">预售商品暂无法购买</i></div>';
                		}
                	}
                }
                content = content + '</div>';

                content = content + '<div class="intro">';
                content = content + '<div class="name">'+val.productName+'</div>';
                content = content + '<div class="price">';
                content = content + '<div class="price-real">¥<em>'+val.defaultPrice+'</em></div>';
                content = content + '</div>';
                content = content + '</div>';
                content = content + '</a>';
                content = content + '</li>';

                $('#productListUl').append(content);
            });
        }else{
            $('#currentPageSize').html(0);
        }
    }

    function renderPagerBottom(pageDTO){
        if(pageDTO != undefined){
            totalPage = pageDTO.totalPage;
            currentPage = pageDTO.page;

            $('#totalPage').html(totalPage);
            $('#currentPage').html(currentPage);

            if (currentPage <= 1) {
                $('#prePageLi').addClass('mui-disabled');
            }else{
                $('#prePageLi').removeClass('mui-disabled');
            }

            if (currentPage > (totalPage-1)) {
                $('#nextPageLi').addClass('mui-disabled');
            }else{
                $('#nextPageLi').removeClass('mui-disabled');
            }
        }else{
            totalPage = 0;
            currentPage = 0;

            $('#totalPage').html(totalPage);
            $('#currentPage').html(currentPage);

            $('#prePageLi').addClass('mui-disabled');
        }
    }

    function changeSort(orderByCode){
        var currentSortObj = $('#filter-sort').find("a[data-orderCode="+orderByCode+"]");
        if(currentSortObj.hasClass('sort-asc')){
            $('#filter-sort').children().removeClass('sort-asc');
            $('#filter-sort').children().removeClass('sort-desc');

            currentSortObj.addClass('sort-desc');
            $('#sort').val(orderByCode+" desc");
        }else if(currentSortObj.hasClass('sort-desc')){
            $('#filter-sort').children().removeClass('sort-asc');
            $('#filter-sort').children().removeClass('sort-desc');

            currentSortObj.addClass('sort-asc');
            $('#sort').val(orderByCode+" asc");
        }else {
            $('#filter-sort').children().removeClass('sort-asc');
            $('#filter-sort').children().removeClass('sort-desc');

            currentSortObj.addClass('sort-desc');
            $('#sort').val(orderByCode+" desc");
        }

        searchByKeyword();
    }

    function searchByKeyword(pageIndex) {
        loadProductList(pageIndex);
    }

    function prevPage() {
        if (currentPage <= 1) {
            return;
        }
        currentPage--;
        toPage(currentPage);
    }
    function nextPage() {
        if (currentPage > (totalPage-1)) {
            return;
        }
        currentPage++;
        toPage(currentPage);
    }
    function toPage(toPageIndex) {
        $('#pageIndex').val(toPageIndex);
        searchByKeyword();
    }
    var preSaleProductIds = [];
    function findPreSaleProductIds(){
    	$.ajax({
    		url  : '/m/products/preSaleProductIds',
        	type : "GET",
			dataType : "json",
			success : function(data) {
				if(data!=null){
					preSaleProductIds = data;
				}
			}
		});		
    }
</script>
</body>
</html>