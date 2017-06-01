<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>幸运刮刮卡</title>
    <script type="text/javascript" src="${ctx}/static/mobile/game/scratch_card/jquery.eraser.js"></script>
    <style>
        .gamemask {
            position: fixed;
            z-index: 200;
            background: rgba(0, 0, 0, 0.6);
            left: 0;
            top: 0;
            bottom: 0;
            right: 0;
        }

        .ui-dialog {
            width: 12rem;
            padding: 20px;
            position: absolute;
            top: 50%;
            left: 50%;
            z-index: 300;
            background: #FFFFFF;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            -webkit-transform: translate3d(-50%, -50%, 0);
            transform: translate3d(-50%, -50%, 0);
        }

        .ui-dialog h3 {
            font-size: 14px;
            text-align: center;
            color: #3c3c3c;
            padding: 10px;
            font-weight: bold;
        }

        .ui-dialog p {
            padding: 10px 0;
        }

        .ui-dialog input {
            width: 100%;
        }

        .ui-dialog .ui-btn {
            display: block;
            text-align: center;
            font-size: 16px;
            line-height: 35px;
            height: 35px;
            border: 1px solid #e60000;
            color: #e60000;
            background: #fff;
            -webkit-border-radius: 5px;
            border-radius: 5px;
            margin-top: 20px;
        }

        .J_Scratch_wrap {
            width: 250px;
            height: 137px;
            position: relative;
            margin: 75% auto 0;
        }

        .scratch-card-body {
            position: relative;
            margin: 0 auto;
            height: 520px;
            padding-top: 1px;
            background-repeat: no-repeat;
            background-position: top center;
            -webkit-background-size: 100% auto;
            background-size: 100% auto;
        }

        .scard-btn-prize, .scard-btn-share {
            position: absolute;
            top: 12px;
            -webkit-background-size: cover;
            background-size: cover;
            text-indent: -9999px;
        }

        .scard-btn-prize {
            left: 11px;
            width: 93px;
            height: 25px;
            background-image: url("/static/mobile/game/scratch_card/img/btn-prize.png");
        }

        .scard-btn-share {
            right: 11px;
            width: 88px;
            height: 25px;
            background-image: url("/static/mobile/game/scratch_card/img/btn-share.png");
        }

        .scratch-card-box {
            position: absolute;
            z-index: 2;
            left: 0;;
            top: 0;
            width: 250px;
            height: 137px;
            overflow: hidden;
            -webkit-transform: translateZ(0);
            border: 4px solid #ffd02c;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
        }

        .scard-cover {
            position: absolute;
            z-index: 99;
            width: 100%;
            height: 100%;
        }

        .scard-content {
            position: absolute;
            z-index: 98;
            width: 100%;
            height: 100%;
            text-align: center;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            background: #fff no-repeat center;
            -webkit-background-size: contain;
            background-size: contain;
        }

        .scratch-card-result {
            position: absolute;
            z-index: 1;
            top: 0;
            left: 0;
            width: 250px;
            height: 137px;
            background: #fff;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            text-align: center;
            border: 4px solid #ffd02c;
        }

        .result-box {
            position: absolute;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
        }

        .result-box h3 {
            font-size: 19px;
            color: #eb393e;
            line-height: 52px;
        }

        .result-box p {
            font-size: 15px;
            color: #acacac;
            line-height: 18px;
            margin-left: 25px;
            margin-right: 25px;
        }

        .result-btn {
            position: absolute;
            top: 97px;
            width: 100%;
        }

        .result-btn a {
            display: inline-block;
            padding: 0 20px;
            line-height: 25px;
            color: #fff;
            font-size: 12px;
            -webkit-border-radius: 12px;
            -moz-border-radius: 12px;
            border-radius: 12px;
            background: #ff9802;
        }

        .result-win .result-btn a {
            background: #eb393e;
        }

        .result-chance-over p {
            margin-top: 28px;
            line-height: 24px;
        }

        .scratch-card-rule {
            width: 280px;
            margin: 20px auto;
        }

        .scard-rule-title {
            line-height: 18px;
            color: #fff;
            font-size: 12px;
            margin-bottom: 8px;
        }

        .scard-rule-title span {
            padding: 0 10px;
            display: inline-block;
            background: #aa1700;
            -webkit-border-radius: 9px;
            -moz-border-radius: 9px;
            border-radius: 9px;
        }

        .scard-rule-container {
            line-height: 20px;
            color: #fff;
            font-size: 12px;
            height: 120px;
            overflow: auto;
        }

        .fade-enter-active, .fade-leave-active {
            transition: opacity .5s;
        }

        .fade-enter, .fade-leave-active {
            opacity: 1s;
        }

    </style>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">幸运刮刮卡</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="scratch-card-body"
             :style="{backgroundImage: 'url(' + bodyPicUrl + ')',minHeight:calMinHeight+'px'}">

            <div class="J_Scratch_wrap">
                <div id="J_Scratch_box" class="scratch-card-box" v-show="boxShow">
                    <img class="scard-cover" id="J_Scratch_cover" :src="coverPicUrl" alt=""/>
                    <div class="scard-content" id="J_Scratch_content"
                         :style="{backgroundImage:'url(' + contentPicUrl + ')'}"></div>
                </div>
                <div id="J_Scratch_result" class="scratch-card-result">
                <#--<transition name="fade">-->
                    <div class="result-box result-none" v-show="showType == 0">
                        <h3>谢谢惠顾</h3>
                        <p v-text="resultTxt"></p>
                        <div class="result-btn"><a @click="restartGame" href="javascript:void(0)">再刮一张</a></div>
                    </div>
                    <div class="result-box result-chance-over" v-show="showType == -1">
                        <p>亲，你今天的刮奖次数已用完，请明天再来吧！</p>
                        <div class="result-btn wx_btn_share"><a @click="shareToFri" href="javascript:void(0)">分享游戏</a>
                        </div>
                    </div>
                    <div class="result-box result-win" v-show="showType == 1">
                        <h3>恭喜中奖</h3>
                        <p v-text="winTip"></p>
                        <div class="result-btn"><a class="wx_btn_share" @click="restartGame" href="javascript:void(0)">再刮一张</a>
                        <#--<div class="result-btn"><a class="wx_btn_share" @click="shareToFri" href="javascript:void(0)">分享给好友领取奖品</a>-->
                        </div>
                    </div>
                    <div class="result-box result-noPoint" v-show="showType == 400">
                        <h3>积分不足!</h3>
                        <p id="windTip">更多积分等你抢购，购买商品获取等额积分。</p>
                        <div class="result-btn"></div>
                    </div>
                    <div class="result-box result-noLogin" v-show="showType == 404">
                        <h3>还未登录</h3>
                        <p><a href="javascript:void(0)" @click="loginMall">请先登录</a></p>
                    </div>
                    <div class="result-box result-noCusume" v-show="showType == 500">
                        <h3>Sorry~</h3>
                        <p>亲，您的消费额还没达到抽奖要求，更多商品等你<a href="javascript:void(0)">选购！</a></p>
                    </div>
                    <div class="result-box result-limit" v-show="showType == 303">
                        <h3>超出中奖次数</h3>
                        <p>亲，不能太贪心哦~留一点奖品给小伙伴们~</p>
                    </div>
                    <div class="result-box result-end" v-show="showType == 666">
                        <h3>Sorry~</h3>
                        <p id="windTip">活动已经结束</p>
                    </div>
                <#--</transition>-->
                </div>
            </div>
            <div class="scratch-card-rule">
                <div class="scard-rule-title"><span>活动规则</span></div>
                <div class="scard-rule-container">
                    1、活动时间:<br>
                    <p>{{awards.startTime|time}}-{{awards.endTime|time}}</p>
                    <p>
                        2. 活动期间每个账号每天最多有{{awards.oneDayTimes}}次抽奖机会，同一账号、手机号均视为同一用户，每次游戏需使用{{awards.usePoint}}积分<br>
                    </p>
                    <p>
                        3. 获得实物奖品的，请于中奖7日内提交个人信息，逾期视为自动放弃。
                    </p>
                    <p>
                        4. 分享游戏给好友，若好友为第一次游戏，则可获得{{awards.recommendPoint}}积分。
                    </p>
                    <p>
                        5. 在法律允许范围内，本商城有权对活动规则进行解释。
                    </p>
                </div>
            </div>
            <a class="scard-btn-prize" href="/m/account/award/showAward?awardTypeCd=2">我的奖品</a>
            <a class="scard-btn-share wx_btn_share" @click="shareToFri" href="javascript:void(0)">分享游戏</a>
        </div>
    </div>
    <div class="gamemask" v-show="dialogShow"></div>
    <div class="ui-dialog" v-show="dialogShow" style="display: none;">
        <h3>幸运刮刮卡游戏分享</h3>
        <p>请复制地址</p>
        <input type="text" v-model="shareUrl">
        <a class="ui-btn" href="javascript:void(0);" @click="closeDialog">关闭</a>
    </div>
</div>
<script>
    var app = new Vue({
        el: '#page',
        data: {
            awards: {},// 活动信息
            userId: 0,// 用户id
            cId: 0,// 分享者userId
            count: 0,// 用户当天玩该游戏次数
            totalConsumeAmt: 0,// 用户总消费额
            showType: 0,// 提示框标识
            resultTxt: "",// 没中奖提示
            isSendMsg: 0,// 能否进行游戏标识
            winTip: "",// 中奖提示
            boxShow: true,//
            dialogShow: false,// 分享奖品遮罩和弹出框是否显示标识
            shareUrl: ""// 分享地址
        },
        computed: {
            // 游戏背景图
            bodyPicUrl: function () {
                if (this.awards.centerBgPicUrl) {
                    return this.awards.centerBgPicUrl;
                }
                return "/static/mobile/game/scratch_card/img/bg.png"
            },
            // 刮刮卡覆盖图
            coverPicUrl: function () {
                if (this.awards.awardsPicUrl) {
                    return this.awards.awardsPicUrl;
                }
                if (window.devicePixelRatio >= 3) {
                    return "/static/mobile/game/scratch_card/img/cover-big.png";
                }
                return "/static/mobile/game/scratch_card/img/cover.png";
            },
            // 提示前图片计算
            contentPicUrl: function () {
                if (this.showType == 1) {
                    return this.resultImg['win'];
                }
                return this.resultImg['none'][Math.floor(this.resultImg['none'].length * Math.random())];
            },
            // 提示前图片
            resultImg: function () {
                return {
                    win: "/static/mobile/game/scratch_card/img/emotion-win.png",
                    none: [
                        '/static/mobile/game/scratch_card/img/emotion-1.png',
                        '/static/mobile/game/scratch_card/img/emotion-2.png',
                        '/static/mobile/game/scratch_card/img/emotion-3.png',
                        '/static/mobile/game/scratch_card/img/emotion-4.png'
                    ]
                }
            },
            // 计算高度
            calMinHeight: function () {
                var winHeight = document.documentElement.getBoundingClientRect().height;
                var muiBarH = $(".mui-bar").height() || 0;
                return winHeight - muiBarH;
            }
        },
        methods: {
            // 开始游戏
            startGame: function () {
                var obj = this;
                $('#J_Scratch_cover').eraser({
                    completeRatio: .7,
                    completeFunction: function () {
                        obj.boxShow = false;
                    },
                    progressFunction: function (radio) {
                        if (!obj.isSendMsg) {
                            if (!obj.userId) {
                                obj.boxShow = false;
                                obj.showType = 404;
                                return;
                            }
                            if (obj.awards.consumeAmt > obj.totalConsumeAmt) {
                                obj.boxShow = false;
                                obj.showType = 500;
                                return;
                            }
                            var oneDayTimes = obj.awards.oneDayTimes ? obj.awards.oneDayTimes : 10000, count = obj.count;
                            if (count >= oneDayTimes) {
                                obj.boxShow = false;
                                obj.showType = -1;
                                return;
                            }

                            obj.getResult(obj.awards.id);
                            obj.isSendMsg = 1;
                        }
                    }
                });
            },
            // 重玩游戏
            restartGame: function () {
                this.showType = 0;
                this.boxShow = true;
                this.isSendMsg = 0;
                this.startGame();
                $('#J_Scratch_cover').eraser('reset');
            },
            // 获取游戏结果
            getResult: function (awardsId) {
                this.$http.post('/m/game/play',
                        {id: awardsId, cId: this.cId},
                        {emulateJSON: true}
                ).then(
                        function (res) {
                            if (res && res.data) {
                                if (res.data.result == "winning") {
                                    this.winTip = res.data.tip;
                                    this.showType = 1;
                                } else if (res.data.result == "nosession") {
                                    this.showType = 404;
                                } else {
                                    this.resultTxt = res.data.tip;
                                    if (res.data.tip && res.data.tip.indexOf("积分不够") > -1) this.showType = 400;
                                    if (res.data.tip && res.data.tip.indexOf("超过中奖次数") > -1) this.showType = 303;
                                    if (res.data.tip && res.data.tip.indexOf("活动已经结束") > -1) this.showType = 666;
                                }
                            }
                        }
                );
            },
            // 登录链接
            loginMall: function () {
                window.location.href = '/m/login.html?successUrl=/m/game/' + this.awards.id + '.html';
            },
            // 分享给好友
            shareToFri: function () {
                if (!this.userId) {
                    this.boxShow = false;
                    this.showType = 404;
                    return false;
                }
                var protocol = window.location.protocol;
                var host = window.location.host;
                var pathname = window.location.pathname;
                this.shareUrl = protocol + "//" + host + pathname + "?cId=" + this.userId;
                console.log(this.shareUrl);
                this.dialogShow = true;
            },
            // 关闭分享好友弹出框
            closeDialog: function () {
                this.dialogShow = false;
            }
        },
        created: function () {
            this.$http.get('/m/game/showGameInfo', {
                params: {
                    id: ${id!},
                    cId:${cId!"0"}
                },
                emulateJSON: true
            }).then(
                    function (res) {//处理成功的结果
                        this.awards = res.data.awards;
                        this.userId = res.data.userId;
                        this.cId = res.data.cId;
                        this.count = res.data.count;
                        this.totalConsumeAmt = res.data.totalConsumeAmt;
                        this.startGame();
                    }
            );
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