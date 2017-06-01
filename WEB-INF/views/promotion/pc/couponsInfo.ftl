<#assign ctx = request.contextPath>
<style>
    .ms-controller {
        visibility: hidden
    }
</style>
<div class="coupon-wrap ms-controller" :controller="app">
    <div class="text-bg"></div>
    <div class="coupon">
        <div class="hd">
            <p>{{promotion.promotionName}}</p>
            <span>{{promotionTypeName}}</span>
            <p ms-if="discountDesc.length > 1">{{promotionTypeDesc}}</p>
        </div>
        <div class="bd">
            <ul>
                <li><p>使用条件：</p>
                    <span>
                            1.{{promotionConditionDesc}}
                            <em>2.<i :html="discountDesc.join('<br>&nbsp;&nbsp;&nbsp;')"></i></em>
                        </span>
                </li>
                <li><p>有效期至：</p><span class="text-red">{{promotion.enableEndTime | date("yyyy-MM-dd HH:mm:ss")}}</span>
                </li>
            </ul>
            <a class="btn-green" href="javascript:void(0);" id="useCoupon" ms-click="@useGetCoupon">立即领取</a>
        </div>
    </div>
</div>
<script>
    var vm = avalon.define({
        $id: 'app',
        // ---数据---
        encryptCode: '${encryptCode!}',
        isLogin: 0,
        discountValue: '',
        discountDesc: [],
        promotion: {},//优惠券信息
        promotionConditionDesc: '',//使用条件
        flag: true,
        $computed: {
            promotionTypeName: function () {//优惠券类型名称
                if (vm.promotion.promotionTypeCd == 54) {
                    return "满减券";
                } else if (vm.promotion.promotionTypeCd == 55) {
                    return "满折券";
                }
            },
            promotionTypeDesc: function () {
                if (vm.promotion.promotionTypeCd == 54) {
                    return "阶梯满减";
                } else if (vm.promotion.promotionTypeCd == 55) {
                    return "阶梯折扣";
                }
            }
        },
        // ---方法---
        useGetCoupon: function () {
            if (!vm.isLogin) {
                vm.flag = false;
                var btnArray = ['确认', '关闭'];
                layer.confirm('您还未登录，请先登录！', function () {
                    window.location.href = "${ctx}/login?successUrl=${ctx}/coupon/" + vm.encryptCode + ".html";
                });
                return false;
            }
            if (!this.flag) {
                return;
            } else {
                this.flag = false;
            }
            $.post('/coupon/getCoupon', {
                promotionId: vm.promotion.promotionId
            }, function (data) {
                if (data && data.message) {
                    layer.msg(data.message);
                }
                this.flag = true;
            })
        }
    });

    vm.$watch('onReady', function () {
        // 获取优惠券信息
        $.get('/coupon/useGetCouponMap', {
            encryptCode: vm.encryptCode
        }, function (data) {
            if (!data.isLogin) {
                layer.confirm('您还未登录，请先登录！', function () {
                    window.location.href = "${ctx}/login?successUrl=${ctx}/coupon/" + vm.encryptCode + ".html";
                });
                return false;
            }
            vm.isLogin = data.isLogin;
            vm.discountValue = data.discountValue;
            vm.discountDesc = data.discountDesc;
            vm.promotion = data.promotion;
            vm.promotionConditionDesc = data.promotionConditionDesc;
        })
    });

</script>
