<body class="page-list">

    <div id="main">
        <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="/index.html">首页</a>
            <#--<#if parentCategory?? && parentCategory?has_content>
                <span class="divide">&gt;</span>
                <span>${(parentCategory.categoryName)!}</span>
            </#if>
            <#if category?? && category?has_content>
                <span class="divide">&gt;</span>
                <span>${(category.categoryName)!}</span>
            </#if>-->
        </div>

        <div class="selectCondition">
            <dl>
                <dt>一级分类：</dt>
                <dd>
                    <div class="smallList" id="selectCategory1List"></div>
                </dd>
            </dl>

            <dl id="selectCategory2Dl" style="display: none;">
                <dt>二级分类：</dt>
                <dd>
                    <div class="smallList" id="selectCategory2List"></div>
                </dd>
            </dl>

            <dl>
                <dt>价格：</dt>
                <dd>
                    <div class="smallList" id="selectPriceRangeList">
                        <a href="javascript:void(0);" data-priceRange="-1" onclick="selectPriceRange('-1');">全部</a>
                        <a href="javascript:void(0);" data-priceRange="1" onclick="selectPriceRange('1');">100元以下</a>
                        <a href="javascript:void(0);" data-priceRange="2" onclick="selectPriceRange('2');">100-200元</a>
                        <a href="javascript:void(0);" data-priceRange="3" onclick="selectPriceRange('3');">200-500元</a>
                        <a href="javascript:void(0);" data-priceRange="4" onclick="selectPriceRange('4');">500元以上</a>
                    </div>
                </dd>
            </dl>

            <dl>
                <dt>品牌：</dt>
                <dd>
                    <div class="smallList" id="selectBrandList"></div>
                </dd>
            </dl>
        </div>

        <input type="hidden" id="categoryIdL1" name="categoryIdL1" value="${categoryIdL1?default("0")}">
        <input type="hidden" id="categoryIdL2" name="categoryIdL2" value="${categoryIdL2?default("-1")}">
        <input type="hidden" id="priceRangeId" name="priceRangeId" value="${priceRangeId?default("-1")}">
        <input type="hidden" id="brandId" name="brandId" value="${brandId?default("-1")}">
        <input type="hidden" id="searchKey" name="searchKey" value="${searchKey?default("")}">
        <input type="hidden" id="pageIndex" name="pageIndex" value="1">
        <input type="hidden" id="sort" name="sort" value="${sort?default('time_l desc')}">

        <#macro renderShowOder titleText orderByCode currSort>
            <#if currSort?contains(orderByCode)>
                <#if currSort?contains("desc")>
                    <a class="sort-on" data-orderCode="${orderByCode}" href="javascript:changeSort('${orderByCode}')"><i class="sort-desc"></i>${titleText}</a>
                <#else>
                    <a class="sort-on" data-orderCode="${orderByCode}" href="javascript:changeSort('${orderByCode}')"><i class="sort-asc"></i>${titleText}</a>
                </#if>
            <#else>
                <a data-orderCode="${orderByCode}" href="javascript:changeSort('${orderByCode}')"><i class="sort-desc"></i>${titleText}</a>
            </#if>
        </#macro>

        <div class="product">
            <div class="pr-control">
                <div class="pr-filters">
                    <div class="filter-sort">
                        <span>排序：</span>
                        <#assign currSort = sort?default('time_l desc')/>
                        <@renderShowOder "时间" "time_l" currSort/>
                        <@renderShowOder "销量" "productSalesCnt_i" currSort/>
                        <@renderShowOder "价格" "price_p" currSort/>
                    </div>

                    <div class="pr-control-page"></div>
                </div>
            </div>

            <div class="pr-list">
                <ul>
                    <div id="productListDiv"></div>
                    <p id="productEmptyTip" style="display:none;text-align: center;font-size:12px;"><b>没有搜索到相关的商品哟~</b></p>
                </ul>
            </div>

            <div class="pr-pager">
                <span class="total">共<span id="totalSize"></span>件商品</span>
                <div class="pager" id="pager"></div>
            </div>

        </div>
    </div>

    <script>
    $(function(){
    	findPreSaleProductIds();
    })
        function selectLevel1Category(categoryId){
            $('#categoryIdL1').val(categoryId);
            $('#categoryIdL2').val("-1");

            submitSearchForm();
        }
        function selectLevel2Category(categoryId){
            $('#categoryIdL2').val(categoryId);
            submitSearchForm();
        }

        function selectPriceRange(priceRangeId){
            $('#priceRangeId').val(priceRangeId);
            submitSearchForm();
        }

        function selectProductBrand(brandId){
            $('#brandId').val(brandId);
            submitSearchForm();
        }

        function goPage(page){
            submitSearchForm(page);
        }

        function changeSort(orderByCode){
            $('.filter-sort').children().removeClass('sort-on');
            var currentSortObj = $('.filter-sort').find("a[data-orderCode="+orderByCode+"]");
            currentSortObj.addClass('sort-on');

            var iObjClass = currentSortObj.find("i").attr('class');
            var iArr = iObjClass.split("-");

            if(iArr[1] == "desc"){
                currentSortObj.find("i").removeClass();
                currentSortObj.find("i").addClass('sort-asc');
                $('#sort').val(orderByCode+" asc");
            }else if(iArr[1] == "asc"){
                currentSortObj.find("i").removeClass();
                currentSortObj.find("i").addClass('sort-desc');
                $('#sort').val(orderByCode+" desc");
            }

            submitSearchForm();
        }

        function submitSearchForm(pageIndex) {
            loadProductList(pageIndex);
        }

        function loadProductList(pageIndex){
            var categoryId = '0';
            var sort = $("#sort").val();

            var categoryIdL1 = $("#categoryIdL1").val();
            var categoryIdL2 = $("#categoryIdL2").val();
            if(categoryIdL1 != undefined){
                $('#selectCategory1List').children().removeClass('selected');
                $('#selectCategory1List').find("a[data-categoryId="+categoryIdL1+"]").addClass('selected');
            }
            if(categoryIdL2 != undefined){
                $('#selectCategory2List').children().removeClass('selected');
                $('#selectCategory2List').find("a[data-categoryId="+categoryIdL2+"]").addClass('selected');
            }

            var priceRangeId = $('#priceRangeId').val();
            $('#selectPriceRangeList').children().removeClass('selected');
            $('#selectPriceRangeList').find("a[data-priceRange="+priceRangeId+"]").addClass('selected');

            var brandId = $('#brandId').val();
            if(brandId != undefined){
                $('#selectBrandList').children().removeClass('selected');
                $('#selectBrandList').find("a[data-brandId="+brandId+"]").addClass('selected');
            }

            if(categoryIdL1 && categoryIdL1 != "-1"){
                categoryId = categoryIdL1;
            }else if(categoryIdL1 == 0){
                categoryId = categoryIdL1;
            }

            if(categoryIdL2 && categoryIdL2 != "-1"){
                categoryId = categoryIdL2;
            }

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
                priceRangeId: priceRangeId,
                brandId: brandId,
                sort: sort,
                categoryIdL1: categoryIdL1
            };

            $.get("/products/jsonData/" + categoryId + ".html", paramData, function (data) {
                if (data && data.result == "success") {
                    selectCategory2Dl(data, categoryIdL2);
                    renderProductList(data);
                    renderPagerBottom(data.pageDTO);
                    renderPagerTop(data.pageDTO);
                } else {
                    layer.msg(data.message || '加载商品数据失败!');
                }
            }, "json");
        }

        function selectCategory2Dl(data, categoryIdL2){
            var childCategoryList = data.childCategoryList;

            $('#selectCategory2List').empty();
            if(childCategoryList != undefined){
                $('#selectCategory2List').empty();
                $('#selectCategory2List').append('<a href="javascript:void(0);" data-categoryId="-1" onclick="selectLevel2Category(-1);">全部</a>');
                $.each(childCategoryList, function(i,val){
                    console.log(val)
                    var content = '<a href="javascript:void(0);" data-categoryId="'+val.categoryId+'" onclick="selectLevel2Category('+val.categoryId+');">'+val.categoryName+'</a>';
                    $('#selectCategory2List').append(content);
                });

                if(categoryIdL2 != undefined){
                    $('#selectCategory2List').children().removeClass('selected');
                    $('#selectCategory2List').find("a[data-categoryId="+categoryIdL2+"]").addClass('selected');
                }

                $('#selectCategory2Dl').show();
            }else{
                $('#selectCategory2Dl').hide();
            }
        }

        function renderProductList(data){
        	
            var pageDTO = data.pageDTO;
            var productList = pageDTO.content;

            $('#totalSize').html(pageDTO.totalSize);

            $('#productListDiv').empty();

            if(productList && productList.length > 0){
                $('#productEmptyTip').hide();

                $.each(productList, function(i,val){
                    var content = '<li>';
                    content = content + '<div class="show_tips">';
                    content = content + '<div class="pic">';
                    content = content + '<a href="/product/'+val.productId+'"><img src="'+val.picUrl+'"></a>';
                    if(preSaleProductIds.length>0){
                    	for(var i=0; i<preSaleProductIds.length; i++){
                    		var id= preSaleProductIds[i];
                    		if(val.productId ==id){
                    			content = content + '<i class="info">预售商品暂无法购买</i>';
                    		}
                    	}
                    }
                    content = content + '</div>';
                    content = content + '<div class="dl-name">';
                    content = content + '<a href="/product/'+val.productId+'">'+val.productName+'</a>';
                    content = content + '</div>';
                    content = content + '<div class="dl-price">';
                    content = content + '<span class="price-real">￥'+val.defaultPrice+'</span>';
                    content = content + '<span class="dl-sail">销量：'+val.productSaleCnt+'件</span>';
                    content = content + '</div>';
                    content = content + '</div>';
                    content = content + '</li>';

                    $('#productListDiv').append(content);
                });
            }else{
                $('#productEmptyTip').show();
            }
        }

        function renderPagerTop(pageDTO){
            $('.pr-control-page').empty();
            if(pageDTO != undefined){
                var prevHref = "";
                var nextHref = "";
                var content = "";

                var page = pageDTO.page;
                var totalPage = pageDTO.totalPage;
                var hasPreviousPage = pageDTO.hasPreviousPage;
                var hasNextPage = pageDTO.hasNextPage;
                if(hasPreviousPage){
                    prevHref = 'javascript:goPage('+(page-1)+');';
                }else{
                    prevHref = 'javascript:void(0);';
                }

                if(hasNextPage){
                    nextHref = 'javascript:goPage('+(page+1)+');';
                }else{
                    nextHref = 'javascript:void('+page+');';
                }

                content = content + '<a class="page-prev';
                if(!hasPreviousPage){
                    content = content + ' off"';
                }else{
                    content = content + '"';
                }

                content = content + 'href="'+prevHref+'" title="上一页"><i></i></a>';
                content = content + '<span><b>'+page+'</b> / '+totalPage+'</span>';

                content = content + '<a class="page-next';
                if(!hasNextPage){
                    content = content + ' off"';
                }else{
                    content = content + '"';
                }

                content = content + 'title="下一页" href="'+nextHref+'"><i></i></a>';

                $('.pr-control-page').append(content);
            }
        }

        function renderPagerBottom(pageDTO){
            $('#pager').empty();

            if(pageDTO != undefined){
                var steps = 3;
                var page = pageDTO.page;
                var totalPages = pageDTO.totalPage;

                var startRangeIndex = page - steps;
                if(startRangeIndex < 1){
                    startRangeIndex = 1;
                }

                var endRangeIndex = page + steps;
                if(endRangeIndex >= totalPages){
                    endRangeIndex = totalPages;
                }

                if(page > 1){
                    $('#pager').append('<a href="javascript:goPage('+(page-1)+');">&lt;上一页</a>');
                }

                if(startRangeIndex > 1){
                    $('#pager').append('<a href="javascript:goPage(1);">1</a><a>...</a>');
                }

                for(var i=startRangeIndex;i<=endRangeIndex;i++){
                    if(i == page){
                        $('#pager').append('<a class="cur">'+page+'</a>');
                    }else if(i != 0){
                        $('#pager').append('<a href="javascript:goPage('+i+');">'+i+'</a>');
                    }
                }

                if(endRangeIndex < totalPages){
                    $('#pager').append('<a>...</a><a href="javascript:goPage('+totalPages+');">'+totalPages+'</a>');
                }

                if(page < totalPages){
                    $('#pager').append('<a href="javascript:goPage('+(page+1)+');">下一页&gt;</a>');
                }
            }
        }

        $(function(){
            initPageData();
            loadProductList();

            $('.m-itemslist .item').hover(function(){
                $(this).addClass('item-hover');
            },function(){
                $(this).removeClass('item-hover');
            });

            $('.treeicon').on('click', function(){
                var liObj = $(this).parent();
                if(liObj.hasClass('tree-close')){
                    liObj.removeClass();
                    liObj.addClass('tree-open');

                    liObj.children(".subtree").show();
                }else{
                    liObj.removeClass();
                    liObj.addClass('tree-close');

                    liObj.children(".subtree").hide();
                }
            });

            autoFitImage('.m-itemslist .pic img','.pic');
        });

        function initPageData(){
            initPageProductBrand();
            initPageTopCategory();
        }

        function initPageProductBrand(){
            $('#selectBrandList').append('<a href="javascript:void(0);" class="selected" data-brandId="-1" onclick="selectProductBrand(-1);">全部</a>');
            $.get("/brand/list/jsonData.html", {}, function (data) {
                if (data && data.productBrandList) {
                    $.each(data.productBrandList, function(i,val){
                        var content = '<a href="javascript:void(0);" data-brandId="'+val.brandId+'" onclick="selectProductBrand('+val.brandId+');">'+val.brandName+'</a>';
                        $('#selectBrandList').append(content);
                    });
                } else {
                    console.log(data.message || '加载数据失败!');
                }
            }, "json");
        }

        function initPageTopCategory(){
            $('#selectCategory1List').append('<a href="javascript:void(0);" data-categoryId="0" onclick="selectLevel1Category(0);">全部</a>');
            $.get("/products/topCategory/jsonData.html", {}, function (data) {
                if (data && data.categoryList) {
                    $.each(data.categoryList, function(i,val){
                        var content = '<a href="javascript:void(0);" data-categoryId="'+val.categoryId+'" onclick="selectLevel1Category('+val.categoryId+');">'+val.categoryName+'</a>';
                        $('#selectCategory1List').append(content);
                    });

                    var categoryIdL1 = $("#categoryIdL1").val();
                    if(categoryIdL1 != undefined){
                        $('#selectCategory1List').children().removeClass('selected');
                        $('#selectCategory1List').find("a[data-categoryId="+categoryIdL1+"]").addClass('selected');
                    }
                } else {
                    console.log(data.message || '加载数据失败!');
                }
            }, "json");
        }

        function autoFitImage(selector,wrapper,callback){
            var imgs = $(selector),count = 0;
            imgs.on("load",function(){
                var $img = $(this),$pic = $img.closest(wrapper);
                $img.css({width:'auto',height:'auto'});
                var w = $img.width(),h = $img.height();
                var ow = $pic.width(),
                        oh = $pic.height();
                if(ow/oh > w/h){
                    $img.css({
                        width:"auto",
                        height:oh,
                        marginLeft:(ow-w*oh/h)/2 +"px"
                    });
                }else{
                    $img.css({
                        width:ow,
                        height:"auto",
                        marginTop:(oh-h*ow/w)/2 +"px"
                    });
                }
                count ++;
                if(count >= imgs.length && callback){
                    callback();
                }
            }).each(function(){
                var $img = $(this);
                if(this.complete) $img.trigger("load");
            });
        }
        
        var preSaleProductIds = [];
        function findPreSaleProductIds(){
        	$.ajax({
	    		url  : '/products/preSaleProductIds',
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