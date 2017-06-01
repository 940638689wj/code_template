<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>红包领取</title>
</head>
<body>
<div id="page" class="redpackets">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">红包</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="redpackets-wrap">
            <div class="redpackets-bg">
                <div class="over" v-show="showDivType==1" style="display:none;">
                    您还未领取
                    <a class="redpackets-btn" id="getRedPacket" @click="userGetRedPacket">立即领取</a>
                </div>
                <div class="winning" v-show="showDivType==2" style="display:none;">
                    <h3>恭喜您获得</h3>
                    <span><em>￥</em>{{redPacketValue}}</span>
                    <P>已存入账号：{{phone}}</P>
                    <a class="redpackets-btn" id="useRedPacket" @click="useRedPacket">立即使用</a>
                </div>
                <div class="over" v-show="showDivType==3" style="display:none;">
                    稍晚一步<br>红包已抢完
                    <a class="redpackets-btn" href="${ctx}/m">去首页看看</a>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var vm = new Vue({
        el: '#page',
        data: {
            encryptCode: '${encryptCode!}',
            isLogin: 0,
            redPacketValue: -1,
            phone: -1,
            promotionId: -1,
            showDivType: 1,
            flag: true
        },
        methods: {
            userGetRedPacket: function () {
                if (!this.isLogin) {
                    var btnArray = ['确认', '关闭'];
                    mui.confirm('', '您还未登录，请先登录！', btnArray, function (e) {
                        if (e.index == 0) {
                            window.location.href = "${ctx}/m/login?successUrl=${ctx}/m/redPacket/" + vm.encryptCode + ".html";
                        }
                    })
                }

                if (!this.flag) {
                    return;
                } else {
                    this.flag = false;
                }
                this.$http.post('/m/redPacket/getRedPacket',
                        {promotionId: this.promotionId},
                        {emulateJSON: true}
                ).then(
                        function (res) {
                            if (res.data && res.data.result == "true") {
                                this.showDivType = 2;
                                this.isLogin = res.data.isLogin;
                                this.redPacketValue = res.data.redPacketValue;
                                this.phone = res.data.phone;
                            } else if (res.data && res.data.result == "empty") {
                                this.showDivType = 3;
                            } else {
                                this.showDivType = 1;
                                mui.toast(res.data.message);
                            }
                            this.flag = true;
                        }, function (XMLHttpResponse) {
                            console.log(XMLHttpResponse.message);
                        }
                );

            },
            useRedPacket: function () {
                window.location.href = "/m/category/list.html";
            }
        },
        created: function () {
            this.$http.get('/m/redPacket/useRedPacketMap', {
                params: {encryptCode: this.encryptCode},
                emulateJSON: true
            }).then(
                    function (res) {
                        if (!res.data.isLogin) {
                            var btnArray = ['确认', '关闭'];
                            mui.confirm('', '您还未登录，请先登录！', btnArray, function (e) {
                                if (e.index == 0) {
                                    window.location.href = "${ctx}/m/login?successUrl=${ctx}/m/redPacket/" + vm.encryptCode + ".html";
                                }
                            });
                            return false;
                        }
                        this.isLogin = res.data.isLogin;
                        this.redPacketValue = res.data.redPacketValue;
                        this.phone = res.data.phone;
                        this.promotionId = res.data.promotionId;
                        this.showDivType = res.data.showDivType;
                    }
            )
        }
    })
</script>
</body>
</html>