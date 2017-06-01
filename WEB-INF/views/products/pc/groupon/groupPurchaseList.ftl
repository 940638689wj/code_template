<body class="page-list">
<style>
    .ms-controller {
        visibility: hidden
    }
</style>
<script src="/static/js/jquery.countdown.js"></script>

<div ms-controller="app">
    <div id="main">
        <div class="crumb">
            <span class="t">您的位置：</span>
            <a class="c" href="/index.html">首页</a>
            <span class="divide">&gt;</span>
            <span>团购列表</span>
        </div>

        <div class="product">
            <div class="pr-control">
                <div class="pr-filters">
                    <div class="filter-sort">
                        <span>排序：</span>
                        <a class="sort-on" href="#" onclick='jsonByNum()'><i id='byNum' class="sort-desc"></i>销量</a>
                        <a href="#" onclick='jsonByPrice()'><i id='byPrice' class="sort-asc"></i>价格</a>
                    </div>

                    <div class="pr-control-page">
                        <a class="page-prev off" href="javascript:void(0);" title="上一页"><i></i></a>
                        <span><b>{{p}}</b> / ${pageNum!}</span>
                        <a class="page-next" title="下一页" href="javascript:"><i></i></a>
                    </div>
                </div>
            </div>

            <div class="pr-list przc-list">
                <ul id="orderListUl">
                <#--<li ms-for="order in @orderList" :hover="['hov']">-->
                <#--<div class="show_tips">-->
                <#--<div class="pic"><a ms-attr="{href: 'detail/'+@order.promotionId}"><img-->
                <#--ms-attr="{src:@order.picUrl}"></a></div>-->
                <#--<div ms-if='@order.createTime >= @ago3Day' class="dl-tips"><span>NEW</span></div>-->
                <#--<div class="dl-name"><a href="#">{{order.promotionName}}</a></div>-->
                <#--<div class="dl-price">-->
                <#--<span class="price-real">￥{{order.grouponPrice==null?'0.00':order.grouponPrice.toFixed(2)}}</span>-->
                <#--<span class="price-origin">￥{{order.tagPrice==null?'0.00':order.tagPrice.toFixed(2)}}</span>-->
                <#--<span class="dl-sail">销量：{{order.saleNum}}件</span>-->
                <#--</div>-->
                <#--<div class="countdown" ms-attr="{'data-end':order.enableEndTime}"></div>-->
                <#--<div class="add-cart">-->
                <#--<a ms-attr="{href: 'detail/'+@order.promotionId}">立即购买</a>-->
                <#--</div>-->
                <#--</div>-->
                <#--</li>-->
                <#if countGrouponList==0>
                    <p id="productEmptyTip" style="text-align: center;font-size:12px;"><b>没有搜索到相关的商品哟~</b></p>
                </#if>
                </ul>
            </div>

            <div class="pr-pager">
                <span class="total">共${countGrouponList!}件商品</span>
                <div id="page"></div>
            </div>

        </div>
    </div>
</div>
<link rel="stylesheet" href="/static/css/jquery.page.css">
<script type="text/javascript" src="/static/js/jquery.page.js"></script>
<script type="text/javascript">
    var em = avalon.define({
        $id: "app",
//        orderList: [],
        p: 1,
        ago3Day: new Date(Date.parse(new Date().toString()) - 86400000 * 3)
    })

    var size = 8;
    var totalData = ${countGrouponList!};
    var pageNum = ${pageNum!};
    var orderBySaleNum = -1;
    var orderByPrice;
    $(function () {
        //分页插件
        $("#page").Page({
            totalPages: ${pageNum!},
            //分页总数
            liNums: 5,
            //分页的数字按钮数(建议取奇数)
            activeClass: 'activP',
            //active 类样式定义
            hasFirstPage: false,
            hasLastPage: false,
            callBack: function (page) {
                jsonData(page - 1);
            }
        });
        $('.page-prev').click(function () {
            $('#page .prv').click();
        });
        $('.page-next').click(function () {
            $('#page .next').click();
        });

        jsonData(0);

    })

    function toggleHov(e) {
        e = window.event;
        $(e.target).addClass("cart-hover");
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
        em.p = _page + 1;
        var url = "/groupPurchase/list/jsonData?";
        if (orderBySaleNum != null) url += "orderBySaleNum=" + orderBySaleNum;
        if (orderByPrice != null) url += "orderByPrice=" + orderByPrice;

        $.get(url + '&page=' + _page + '&size=' + size, function (data) {
            $("#orderListUl").empty();
            var result = '';
            for (var i = 0, length = data.data.length; i < length; i++) {
                var order = data.data[i];

                var tarPrice = order.tagPrice == null ? '0.00' : order.tagPrice.toFixed(2);
                var grouponPrice = order.grouponPrice == null ? '0.00' : order.grouponPrice.toFixed(2);
                result += '<li onmouseout="toggleHov(event)" onmouseover="toggleHov(event)"><div class="show_tips"><div class="pic"><a href="detail/' + order.promotionId + '"><img src="' + order.picUrl + '"></a></div>' +
                        '<div class="dl-name"><a href="#">' + order.promotionName + '</a></div>' +
                        '<div class="dl-price"><span class="price-real">￥' + grouponPrice + '</span>' +
                        '<span class="price-origin">￥' + tarPrice +
                        '</span><span class="dl-sail">销量：' + order.saleNum + '件</span>' +
                        '</div>' +
                        '<div class="countdown" data-countdown="flash_sale" data-end="' + order.enableEndTime + '" data-start="2017-05-15 10:00:00">' +
                        '距离结束:' +
                        '<em class="days_1"></em><i class="days_2">天</i>' +
                        '<em class="hours_1"></em><i class="hours_2">时</i>' +
                        '<em class="minutes_1"></em><i class="minutes_2">分</i>' +
                        '<em class="seconds_1"></em><i class="seconds_2">秒</i>' +
                        '</div></div></li>';
            }
            $("#orderListUl").append(result);
            //重新渲染倒计时
            initTimer();
            location.href = '#';
        });
    }

    function toggleHov(e) {
        console.log(e);
        $(e.target).closest("li").toggleClass('hov');
    }

    //按销量排序
    function jsonByNum() {
        $("#byPrice").parent().removeClass('sort-on');
        $("#byNum").parent().addClass('sort-on');
        if (orderBySaleNum == null) orderBySaleNum = 1;
        orderBySaleNum = orderBySaleNum * -1;
        if (orderBySaleNum < 0) {
            $("#byNum").removeClass("sort-asc").addClass("sort-desc");
        } else {
            $("#byNum").removeClass("sort-desc").addClass("sort-asc");
        }
        orderByPrice = null;
        $('#page .pagingUl li:first-child').click();
    }

    //按价格排序
    function jsonByPrice() {
        $("#byPrice").parent().addClass('sort-on');
        $("#byNum").parent().removeClass('sort-on');
        if (orderByPrice == null) orderByPrice = 1;
        orderByPrice = orderByPrice * -1;
        orderBySaleNum = null;
        if (orderByPrice < 0) {
            $("#byPrice").removeClass("sort-asc").addClass("sort-desc");
        } else {
            $("#byPrice").removeClass("sort-desc").addClass("sort-asc");
        }
        $('#page .pagingUl li:first-child').click();
    }

    //手动渲染倒计时插件
    var util = window.app;
    function initTimer() {
        $("[data-countdown]").each(function () {
            var $this = $(this);
            var endTime = util.formatDateTimeStrToDate($this.attr("data-end"));
            var nowDate = util.formatDateTimeStrToDate($this.attr("data-start"));
            var isMs = $this.attr("data-ms");
            var scrollCountDown = function () {
                var nowDate = nowDate;
                var ts = countdown(nowDate, endTime, null, 6, 1);
                showTimeLeft(ts);
            }

            function showTimeLeft(ts) {
                if (ts.value <= 0) {
                    arriveBuyTime();
                } else {
                    if (ts.days == 0) {
                        $this.find(".days_1,.days_2").hide();
                    } else {
                        $this.find(".days_1").text(ts.days);
                        //$this.find(".days_2").show();
                    }
                    if (ts.hours == 0) {
                        if (ts.days == 0) {
                            $this.find(".hours_1,.hours_2").hide();
                        } else {
                            $this.find(".hours_1").text("00");
                        }
                    } else {
                        var hours = ts.hours;
                        hours = parseInt(hours);
                        hours = (hours < 10) ? '0' + hours : hours;
                        $this.find(".hours_1").text(hours);
                        //$this.find(".hours_2").show();
                    }
                    if (ts.minutes == 0) {
                        if (ts.hours == 0) {
                            $this.find(".minutes_1,.minutes_2").hide();
                        } else {
                            $this.find(".minutes_1").text("00");
                        }

                    } else {
                        var minutes = ts.minutes;
                        minutes = parseInt(minutes);
                        minutes = (minutes < 10) ? '0' + minutes : minutes;
                        $this.find(".minutes_1").text(minutes);
                        //$this.find(".minutes_2").show();
                    }
                    if (ts.seconds == 0) {
                        //$this.find(".seconds_1,.seconds_2").hide();
                    } else {
                        var seconds = ts.seconds;
                        if (seconds && !isMs) {
                            seconds = parseInt(seconds);
                            seconds = (seconds < 10) ? '0' + seconds : seconds;
                        }
                        $this.find(".seconds_1").text(seconds);
                        //$this.find(".seconds_2").show();
                    }
                }
            }

            var intervalId = setInterval(scrollCountDown, 1000);

            function arriveBuyTime() {
                if (intervalId) {
                    clearInterval(intervalId);
                }
                //window.location.reload();
            }
        });
    }
</script>
</body>