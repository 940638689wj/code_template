<body class="page-list">

<div id="main">
    <div class="crumb">
        <span class="t">您的位置：</span>
        <a class="c" href="/index.html">首页</a>
        <span class="divide">&gt;</span>
        <span>众筹列表</span>
    </div>

    <div class="product">
        <div class="pr-control">
            <div class="pr-filters">
                <div class="filter-sort"></div>
                <div class="pr-control-page">
                    <a class="page-prev off" href="javascript:void(0);" title="上一页"><i></i></a>
                    <span><b id="currentPageNo"></b> / ${pageNum!}</span>
                    <a class="page-next" title="下一页" href="javascript:"><i></i></a>
                </div>
            </div>
        </div>

        <div class="pr-list przc-list">
        <#if countList?? || countList != 0>
            <ul id="productList">

            </ul>
        <#else>
            <p id="productEmptyTip" style="text-align: center;font-size:12px;"><b>没有搜索到相关的商品哟~</b></p>
        </#if>
        </div>

        <div class="pr-pager">
            <span class="total">共${countList!}件商品</span>
            <div id="page"></div>
        </div>

    </div>
</div>
<link rel="stylesheet" href="/static/css/jquery.page.css">
<script type="text/javascript" src="/static/js/jquery.page.js"></script>
<script>
    var size = 8;
    var totalData = ${countList!};
    var pageNum = ${pageNum!};
    var currentPageNo;
    $(function () {
        //分页插件
        $("#page").Page({
            totalPages: pageNum,
            //分页总数
            liNums: 5,
            //分页的数字按钮数(建议取奇数)
            activeClass: 'activP',
            //active 类样式定义
            hasFirstPage: false,
            hasLastPage: false,
            callBack: function (page) {
                if (page == currentPageNo)return false;
                jsonData(page - 1);
            }
        });
        jsonData(0);

        $('.page-prev').click(function () {
            $('#page .prv').click();
        });

        $('.page-next').click(function () {
            $('#page .next').click();
        });

    })

    function toggleHov(e){
        $(e).toggleClass("hov");
    }

    //加载页面数据
    function jsonData(_page) {
        if (_page < 0 || (_page * size) >= totalData) {
            return false;
        }
        if (_page == 0) {
            $('.page-prev').addClass('off');
            $('#page .prv').hide();
        } else {
            $('.page-prev').removeClass('off');
            $('#page .prv').show();
        }
        if (_page == pageNum - 1) {
            $('.page-next').addClass('off');
            $('#page .next').hide();
        } else {
            $('.page-next').removeClass('off');
            $('#page .next').show();
        }

        $('#productList').empty();
        $.get('/m/crowdfunding/list/jsonData', {pageNo: _page + 1, limit: 8}, function (data) {
            if (data.result == 'success') {
                currentPageNo = data.pageDTO.pageNo;
                $('#currentPageNo').html(currentPageNo);
                var result = '';
                var content = data.pageDTO.content;
                if(content != null) {
                    content.forEach(function(value) {
                        result += '<li onmouseover="toggleHov(this)" onmouseout="toggleHov(this)">' +
                                '<div class="show_tips">' +
                                '<div class="pic"><a href="detail/'+value.promotionId+'"><img src="'+value.productPicUrl+'"></a></div>' +
                                '<div class="dl-name"><a href="javascript:">'+value.promotionName+'</a></div>' +
                                '<div class="dl-price">' +
                                '<span class="price-real">￥'+value.crowdFundPerAmt.toFixed(2)+'</span>' +
                                '</div>' +
                                '<div class="crowd-funding-progress">' +
                                '<div class="progressbar"><span style="width: '+eval((1-(value.remainTimes/value.totalNeedTimes))*100)+'%;"></span></div>' +
                                '<div class="count count-total">' +
                                '<em>'+value.totalNeedTimes+'</em><span>总需人次</span>' +
                                '</div>' +
                                '<div class="count count-current">' +
                                '<em>'+eval(value.totalNeedTimes-value.remainTimes)+'</em><span>已参与人次</span>' +
                                '</div>' +
                                '<div class="count count-remain">' +
                                '<em>'+value.remainTimes+'</em><span>剩余人次</span></div></div>' +
                                '<div class="btn-buy"><a href="detail/'+value.promotionId+'">立即参与</a></div></div></li>';
                    });
                    $('#productList').append(result);
                }
            }else {
                layer.msg('网络出错，请稍候再试！');
                location.href = '/index.html';
            }
        });
    }

</script>

</body>