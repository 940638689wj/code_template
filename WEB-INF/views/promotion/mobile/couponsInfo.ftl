<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
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
        <a class="mui-icon mui-icon-left-nav" href="javascript:void()" @click="gotoIndex"></a>
        <h1 class="mui-title">优惠券领取</h1>
        <a class="mui-icon" href="${ctx}/m"></a>
    </header>
    <div class="mui-content">
        <div class="couponsinfo">
            <dl>
                <dt>
                <p>{{promotion.promotionName}}</p>
                <span><em>{{promotionTypeName}}</em></span>
                <p v-if="discountDesc.length > 1">{{promotionTypeDesc}}</p>
                </dt>
                <dd>
                    <ul>
                        <li><p>使用条件：</p>
                            <span>
                                1.{{promotionConditionDesc}}
                                <em>2.<i v-html="discountDesc.join('<br>&nbsp;&nbsp;&nbsp;')"></i></em>
                            </span>
                        </li>
                        <li><p>有效期至：</p><span class="orange">{{promotion.enableEndTime|time}}</span></li>
                    </ul>
                </dd>
            </dl>
        </div>
        <div class="btnbar">
            <a class="mui-btn mui-btn-block mui-btn-primary" id="useCoupon" @click="useGetCoupon">领取优惠券</a>
        </div>
    </div>
</div>
<script>
    var app = new Vue({
        el: '#page',
        data: {
            encryptCode: '${encryptCode!}',
            isLogin: 0,
            discountValue: '',
            discountDesc: [],//面额list
            promotion: {},//优惠券信息
            promotionConditionDesc: '',//使用条件
            flag: true
        },
        computed:{
            promotionTypeName:function () {//优惠券类型名称
                if(this.promotion.promotionTypeCd==54){
                    return "满减券";
                }else if(this.promotion.promotionTypeCd==55){
                    return "满折券";
                }
            },
            promotionTypeDesc:function () {
                if(this.promotion.promotionTypeCd==54){
                    return "阶梯满减";
                }else if(this.promotion.promotionTypeCd==55){
                    return "阶梯折扣";
                }
            }
        },
        methods: {
            useGetCoupon: function () {
                if (!this.isLogin) {
                    this.flag = false;
                    var btnArray = ['确认', '关闭'];
                    mui.confirm('', '您还未登录，请先登录！', btnArray, function (e) {
                        if (e.index == 0) {
                            window.location.href = "${ctx}/m/login?successUrl=${ctx}/m/coupon/" + app.encryptCode + ".html";
                        }
                    })
                }
                if (!this.flag) {
                    return;
                } else {
                    this.flag = false;
                }
                this.$http.post('/m/coupon/getCoupon',
                        {promotionId: this.promotion.promotionId},
                        {emulateJSON: true}
                ).then(
                        function (res) {
                            if (res.data && res.data.message) {
                                mui.toast(res.data.message);
                            }
                            this.flag = true;
                        }, function (XMLHttpResponse) {
                            console.log(XMLHttpResponse.message);
                        }
                );

            },
            gotoIndex: function () {
                window.location.href = "${ctx}/m/index.html";
            }
        },
        created: function () {
            this.$http.get('/m/coupon/useGetCouponMap', {
                params: {encryptCode: this.encryptCode},
                emulateJSON: true
            }).then(
                    function (res) {
                        if (!res.data.isLogin) {
                            var btnArray = ['确认', '关闭'];
                            mui.confirm('', '您还未登录，请先登录！', btnArray, function (e) {
                                if (e.index == 0) {
                                    window.location.href = "${ctx}/m/login?successUrl=${ctx}/m/coupon/" + app.encryptCode + ".html";
                                }
                            });
                            return false;
                        }
                        this.isLogin = res.data.isLogin;
                        this.discountValue = res.data.discountValue;
                        this.discountDesc = res.data.discountDesc;
                        this.promotion = res.data.promotion;
                        this.promotionConditionDesc = res.data.promotionConditionDesc;
                    }
            )
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
</body>
</html>