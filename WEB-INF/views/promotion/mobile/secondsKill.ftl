<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
    <title></title>
    <style>
        [v-cloak] {
            display: none;
        }
    </style>
</head>
<body>
<div id="page" v-cloak>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">{{promotion.promotionName}}</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="toptip">
        <div>提示：登录之后才享有抢购的优惠价</div>
    </div>
    <div class="mui-content">
        <div class="pt-title">
            <div class="c countdown" data-countdown="flash_sale"
                 :data-end="promotion.enableEndTime|time"
                 :data-start="promotion.enableStartTime|time">
                <span class="t_desc"></span>
                <em class="days_1">0</em><span class="days_2">天</span>
                <em class="hours_1">0</em><span class="hours_2">时</span>
                <em class="minutes_1">0</em><span class="minutes_2">分</span>
                <em class="seconds_1 qgseconds">0.0</em><span class="seconds_2">秒</span>
            </div>
        </div>
        <div class="prd-list-grid">
            <ul>
                <li v-for="productDTO in pageDTO.content">
                    <a :href="'/m/product/' + productDTO.id">
                        <div class="pic">

                            <img class="lazyload" :src="productDTO.img"
                                 :data-src="productDTO.img"/>

                        </div>
                        <div class="intro">
                            <div class="name">
                                {{productDTO.name}}
                                <p class="describe">{{productDTO.productSubTitle}}</p>
                            </div>
                            <div class="price">
                                <div class="price-real">¥<span>{{discountValue}}</span>
                                </div>
                                <span class="price-origin">¥{{productDTO.priceOrigin}}</span>
                            </div>
                        </div>
                    </a>
                </li>
            </ul>
        </div>

        <div class="listft">
            共有商品
            <em>{{pageDTO.count}}</em>个 当前列表
            <em>{{pageSize}}</em>个
        </div>

        <div class="mui-content-padded">
            <ul class="mui-pager">
                <li id="prePageLi"><a @click="prevPage">上一页</a></li>
                <li>{{pageDTO.pageNo}}/{{totalPage}}</li>
                <li id="nextPageLi"><a @click="nextPage">下一页</a></li>
            </ul>
        </div>
    </div>
</div>
<script>
    var vm = new Vue({
        el: '#page',
        data: {
            promotionId: ${(promotionId)!0},
            pageNo: 1,
            promotion: {},
            discountValue: -1,
            pageDTO: {},
            pageSize: 0,
            currentPage: 1
        },
        computed: {
            totalPage: function () {
                if (this.pageSize != 0) {
//                    var result = this.pageDTO.count / this.pageDTO.pageSize;
//                    if (this.pageDTO.count % this.pageDTO.pageSize != 0) {
//                        result = Math.ceil(result);
//                    }
//                    return result;
                    return Math.ceil(this.pageDTO.count / this.pageDTO.pageSize);
                }
                return 0;
            }
        },
        methods: {
            prevPage: function () {
                if (this.currentPage <= 1) {
                    return;
                }
                this.currentPage--;
                this.toPage(this.currentPage);
            },
            nextPage: function () {
                if (this.currentPage > (this.totalPage - 1)) {
                    return;
                }
                this.currentPage++;
                this.toPage(this.currentPage);
            },
            toPage: function (toPageIndex) {
                this.$http.get('/m/secondsKill/getSecondsKillMap', {
                    params: {
                        promotionId: this.promotionId,
                        pageNo: toPageIndex
                    },
                    emulateJSON: true
                }).then(
                        function (res) {
                            this.promotion = res.data.promotion;
                            this.discountValue = res.data.promotionDiscountRule.discountValue;
                            this.pageDTO = res.data.pageDTO;
                            this.pageSize = res.data.pageSize;
                            this.currentPage = res.data.pageDTO.pageNo;
                        }
                )

            }
        },
        created: function () {
            this.$http.get('/m/secondsKill/getSecondsKillMap', {
                params: {
                    promotionId: this.promotionId,
                    pageNo: this.pageNo
                },
                emulateJSON: true
            }).then(
                    function (res) {
                        this.promotion = res.data.promotion;
                        this.discountValue = res.data.promotionDiscountRule.discountValue;
                        this.pageDTO = res.data.pageDTO;
                        this.pageSize = res.data.pageSize;
                        this.currentPage = res.data.pageDTO.pageNo;
                    }
            )
        },
        mounted: function () {
            imglazyload();
        }
    });

    Vue.filter('time', function (value) {//alue为13位的时间戳
        function add0(m) {
            return m < 10 ? '0' + m : m
        }

        var time = new Date(parseInt(value));
        var y = time.getFullYear();
        var m = time.getMonth() + 1;
        var d = time.getDate();
        var h = time.getHours();
        var mi = time.getMinutes();
        var s = time.getSeconds();
        return y + '-' + add0(m) + '-' + add0(d) + ' ' + add0(h) + ':' + add0(mi) + ':' + add0(s);
    });

</script>
<script>
    $(function () {
        var mod = $('.pt-title');
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
                    obj.find(".t_desc").html("距离结束:");
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
//                ms = Math.floor(t%1000);
//                ms = Math.floor(ms/100);
                }
                obj.find('.days_1').text(d);
                obj.find('.hours_1').text(h);
                obj.find('.minutes_1').text(m);
                obj.find('.seconds_1').text(s);
//            obj.find('.seconds_1').text(s+ '.' + ms);
            }

            countdown.each(function () {
                var $this = $(this);
                setInterval(function () {
                    GetRTime($this, $this.attr("data-start"), $this.attr("data-end"))
                }, 1);
            })
        });
    })
</script>
</body>
</html>