<#assign ctx = request.contextPath>
<style>
    .ms-controller {
        visibility: hidden
    }
</style>
<div class="group-hb-body ms-controller" :controller="app">
    <div class="redpackets-wrap">
        <div class="redpackets-bg">
            <div class="over" :visible="showDivType==1" style="display:none;">
                您还未领取
                <a class="redpackets-btn" href="javascript:void(0)" ms-click="userGetRedPacket">立即领取</a>
            </div>
            <div class="redpackets-winning" :visible="showDivType==2" style="display:none;">
                <h3>恭喜您获得</h3>
                <span><em>￥</em>{{redPacketValue}}</span>
                <p>已存入账号：{{phone}}</p>
                <a class="redpackets-btn" href="javascript:void(0)" ms-click="useRedPacket">立即使用</a>
            </div>
            <div class="over" :visible="showDivType==3" style="display:none;">
                稍晚一步<br>红包已抢完
                <a class="redpackets-btn" href="${ctx}/">去首页看看</a>
            </div>
        </div>
    </div>
</div>
<script>
    var vm = avalon.define({
        $id: 'app',
        // ---数据---
        encryptCode: '${encryptCode!}',
        isLogin: 0,
        redPacketValue: -1,
        phone: -1,
        promotionId: -1,
        showDivType: 1,
        flag: true,
        // ---方法---
        userGetRedPacket: function () {
            if (!this.isLogin) {
                layer.confirm('您还未登录，请先登录！', function () {
                    window.location.href = "${ctx}/login?successUrl=${ctx}/redPacket/" + vm.encryptCode + ".html";
                });
                return false;
            }

            if (!vm.flag) {
                return;
            } else {
                vm.flag = false;
            }
            $.post('/redPacket/getRedPacket', {
                        promotionId: vm.promotionId
                    }, function (data) {
                        if (data && data.result == "true") {
                            vm.showDivType = 2;
                            vm.isLogin = data.isLogin;
                            vm.redPacketValue = data.redPacketValue;
                            vm.phone = data.phone;
                        } else if (data && data.result == "empty") {
                            vm.showDivType = 3;
                        } else {
                            vm.showDivType = 1;
                            layer.msg(data.message);
                        }
                        vm.flag = true;
                    }
            );
        },
        useRedPacket: function () {
            window.location.href = "${ctx}/products/0.html";
        }
    });

    vm.$watch('onReady', function () {
        // 获取优惠券信息
        $.get('/redPacket/useRedPacketMap', {
            encryptCode: vm.encryptCode
        }, function (data) {
            if (!data.isLogin) {
                layer.confirm('您还未登录，请先登录！', function () {
                    window.location.href = "${ctx}/login?successUrl=${ctx}/redPacket/" + vm.encryptCode + ".html";
                });
                return false;
            }
            vm.isLogin = data.isLogin;
            vm.redPacketValue = data.redPacketValue;
            vm.phone = data.phone;
            vm.promotionId = data.promotionId;
            vm.showDivType = data.showDivType;
        })
    });
</script>