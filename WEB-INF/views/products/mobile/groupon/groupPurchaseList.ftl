<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<html>
<head>
    <script type="text/javascript" src="${ctx}/static/js/vue.min.js"></script>
    <style>
        [v-cloak] {
            display: none;
        }
    </style>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javaScript:history.go(-1);"></a>
        <h1 class="mui-title">团购商品列表</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="shelves-search">
        <div class="category-search">
            <input type="text" id="promotionName" placeholder="搜索您想要的商品">
            <button onclick="jsonData(0,true)">搜索</button>
        </div>
    </div>
    <div class="filterbar">
        <div class="btngroup">
            <a class="ui-btn sort-desc" href="javaScript:jsonByNum()"><span class="ui-btn-text">销量</span></a>
            <a class="ui-btn sort-asc" href="javaScript:jsonByPrice()"><span class="ui-btn-text">价格</span></a>
        </div>
    </div>
    <div class="mui-content app" v-cloak>
        <div class="prd-list group-list">
            <ul>
            </ul>
        </div>

        <div class="listft">
            共有商品<em>{{totalData}}</em>个 当前列表<em>{{currentSize}}</em>个
        </div>

        <div class="mui-content-padded">
            <ul class="mui-pager">
                <li id='lastPage' class="mui-disabled"><a href="javaScript:jsonData(--page);">上一页</a></li>
                <li>{{currentPage}}/{{totalPage}}</li>
                <li id='nextPage'><a href="javaScript:jsonData(++page);">下一页</a></li>
            </ul>
        </div>
    </div>
</div>
<script>
    $(function () {
        imglazyload();
        jsonData(page);
    });

    // 页数
    var page = 0;
    var size = 4;
    var orderBySaleNum = -1;
    var orderByPrice;
    var totalData;

    var em = new Vue({
        el: ".app",
        data: {
            totalData: 0,
            currentSize: 0,
            currentPage: 0,
            totalPage: 0
        }
    });

    function jsonData(_page, flag) {
        if (_page < 0) {
            page++;
            return false;
        }
        if (flag) totalData = 1;
        if ((_page * size) >= totalData) {
            page--;
            return false;
        }
        if (_page == 0) {
            page = 0;
            $('#lastPage').addClass('mui-disabled');
        } else {
            $('#lastPage').removeClass('mui-disabled');
        }

        $('.group-list ul li').remove();
        var url = "${ctx}/m/groupPurchase/list/jsonData?";
        if (orderBySaleNum != null) url += "orderBySaleNum=" + orderBySaleNum;
        if (orderByPrice != null) url += "orderByPrice=" + orderByPrice;
        var promotionName = $('#promotionName').val().trim();
        if (promotionName != null && promotionName != '') url += "&promotionName=" + promotionName;
        // 拼接HTML
        $.get(url + '&page=' + _page + '&size=' + size, function (data) {
            console.log(data);
            var arrLen = data.data.length;
            em.totalData = data.totalPage;
            em.currentSize = arrLen;
            em.currentPage = page + 1;
            em.totalPage = Math.ceil(data.totalPage / size);
            if (data.totalPage != null) totalData = data.totalPage;
            if (totalData <= (_page + 1) * size) {
                $('#nextPage').addClass('mui-disabled');
            } else {
                $('#nextPage').removeClass('mui-disabled');
            }
            if (arrLen > 0) {
                var result = "";
                for (var i = 0; i < arrLen; i++) {
                    var order = data.data[i];
                    result += "<li><a href='detail/" + order.promotionId + "'><div class='pic'><img class='lazyload' src='" + order.picUrl
                            + "'/></div><div class='r'><div class='name'>" + order.promotionName + "</div><div class='det'>" + order.grouponDesc
                            + "</div><div class='price'><span class='sold'>已售：" + order.saleNum + "</span>" +
                            "<div class='price-real'>¥<em>" + order.grouponPrice + "</em></div></div>" +
                            "<div class='countdown' data-countdown='flash_sale' data-end='" + order.enableEndTime + "' data-start='${.now}'>" +
                            "<span class='t_desc'>距离结束:</span>" +
                            "<em class='days_1'></em><i class='days_2'>天 </i>" +
                            "<em class='hours_1'></em><i class='hours_2'>时 </i>" +
                            "<em class='minutes_1'></em><i class='minutes_2'>分 </i>" +
                            "<em class='seconds_1'></em><i class='seconds_2'>秒</i>" +
                            "</div></div></a></li>";
                }
                $('.group-list ul').append(result);
//				setTimeout(,200);
                initTimer()
            }
        });
    }

    function jsonByNum() {
        if (orderBySaleNum == null) orderBySaleNum = 1;
        orderBySaleNum = orderBySaleNum * -1;
        if (orderBySaleNum < 0) {
            $(".btngroup .ui-btn:first-child").removeClass("sort-asc").addClass("sort-desc");
        } else {
            $(".btngroup .ui-btn:first-child").removeClass("sort-desc").addClass("sort-asc");
        }
        orderByPrice = null;
        jsonData(0, true);
    }

    function jsonByPrice() {
        if (orderByPrice == null) orderByPrice = 1;
        orderByPrice = orderByPrice * -1;
        orderBySaleNum = null;
        if (orderByPrice < 0) {
            $(".btngroup .ui-btn:last-child").removeClass("sort-asc").addClass("sort-desc");
        } else {
            $(".btngroup .ui-btn:last-child").removeClass("sort-desc").addClass("sort-asc");
        }
        jsonData(0, true);
    }

    function initTimer() {
        var mod = $('.prd-list li');
        mod.each(function () {
            var countdown = $(this).find("[data-countdown]");
            var flag = true;
            var util = window.app;

            function GetRTime(obj, sTime, eTime) {
                var StartTime = util.formatDateTimeStrToDate(sTime);
                var EndTime = util.formatDateTimeStrToDate(eTime);
                var NowTime = new Date();
                var t = 0;
                var d = 0;
                var h = 0;
                var m = 0;
                var s = 0;
                var ms = 0;
                var isShoudown = StartTime.getTime() - NowTime.getTime() > 0;
                if (isShoudown > 0) {
                    obj.find(".t_desc").html("距离开始:");
                    t = StartTime.getTime() - NowTime.getTime();
                } else if (isShoudown <= 0 && flag) {
                    obj.find(".t_desc").html("距离结束：");
                    t = EndTime.getTime() - NowTime.getTime();
                    if (t <= 0) {
                        flag = false;
                        obj.html("活动结束");
                    }
                }
                if (t >= 0) {
                    d = Math.floor(t / 1000 / 60 / 60 / 24);
                    h = Math.floor(t / 1000 / 60 / 60 % 24);
                    m = Math.floor(t / 1000 / 60 % 60);
                    s = Math.floor(t / 1000 % 60);
                    /*ms = Math.floor(t%1000);
                    ms = Math.floor(ms/100);*/
                }
                obj.find('.days_1').text(d);
                obj.find('.hours_1').text(h)
                obj.find('.minutes_1').text(m);
                obj.find('.seconds_1').text(s);
                //obj.find('.seconds_1').text(s+ '.' + ms);
            }

            countdown.each(function () {
                var $this = $(this);
                setInterval(function () {
                    GetRTime($this, $this.attr("data-start"), $this.attr("data-end"))
                }, 1);
            })
        });
    }

</script>
</body>
</html>