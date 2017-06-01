<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name='HandheldFriendly' content='True'>
    <meta name='MobileOptimized' content='320'>
    <meta name='format-detection' content='telephone=no'>
    <meta name='viewport' content='width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no'>
    <meta http-equiv='cleartype' content='on'>
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <title>博饼</title>
    <meta name="description" content="">
    <meta name="keywords" content="">
    <link href="${ctx}/static/mobile/game/bobing/css/main.css" rel="stylesheet">
    <script src="${ctx}/static/mobile/game/bobing/js/jquery-2.1.4.min.js"></script>
    <script src="${ctx}/static/mobile/game/bobing/js/iscroll.js"></script>
    <script src="${ctx}/static/mobile/game/bobing/js/load.js"></script>
</head>
<body>
<div id="page">
    <div class="div divbg load">
        <div class="loadwrap">
            <div class="s1"><img src="/static/mobile/game/bobing/images/logo.png" class="w100"></div>
            <div class="loading">
                <div id="kk"></div>
                <div id="kkbg"></div>
                <div id="loadnum"></div>
            </div>
        </div>
    </div>

    <div class="div main divbg imgbg" :data-src="bodyPicUrl">
        <a class="scard-btn-prize" @tap="myAwardsShow" href="javascript:void(0)">我的奖品</a>
        <a class="scard-btn-share wx_btn_share" @tap="shareToFri" href="javascript:void(0)">分享游戏</a>
        <div class="bowl-wrap">
            <div class="bowl">
                <img class="wan" id="wan" :data-src="coverPicUrl" alt="">
                <em class="dice dice1" style="top:65%;left:29%;">
                    <img data-src="/static/mobile/game/bobing/images/d1.png" alt=""></em>
                <em class="dice dice2" style="top:62%;left:58%;">
                    <img data-src="/static/mobile/game/bobing/images/d2.png" alt=""></em>
                <em class="dice dice3" style="top:71%;left:45%;">
                    <img data-src="/static/mobile/game/bobing/images/d3.png" alt=""></em>
                <em class="dice dice4" style="top:58%;left:44%;">
                    <img data-src="/static/mobile/game/bobing/images/d6.png" alt=""></em>
                <em class="dice dice5" style="top:73%;left:57%;">
                    <img data-src="/static/mobile/game/bobing/images/d5.png" alt=""></em>
                <em class="dice dice6" style="top:74%;left:35%;">
                    <img data-src="/static/mobile/game/bobing/images/d6.png" alt=""></em>
            </div>
        </div>

        <div class="bwpop" id="pop_div" v-show="popDivShow" style="display: none">
            <div class="bwtit"><a class="bwclose" @tap="popTpoClose" href="javascript:void(0)">关闭</a></div>
            <div class="bwcon" id="pop_tip_div">
            </div>
            <div class="bwbtnbar">
                <button data-role="none" style="height: 30px" id="pop_ok_btn" @tap="pop_ok_btn"></button>
                &nbsp;&nbsp;
                <button data-role="none" style="height: 30px;cursor: pointer" v-show="goMyShow" @tap="popGoMy">我的奖品
                </button>
            </div>
        </div>

        <div class="bwpop" id="not_point_div" v-show="notPointDiv" style="display: none;">
            <div class="bwtit"><a class="bwclose" href="javascript:void(0)" @tap="closeNotPointDiv">关闭</a></div>
            <div class="bwcon">
                <div style="text-align: center; font-size: 14px; font-weight: bold; margin-bottom: 10px;">
                    哦No！您当前积分不足！
                </div>
                <div style="clear: both;"></div>
            </div>
            <div class="bwbtnbar">
                <button @tap="toShop" data-role="none" style="height: 30px;cursor: pointer">
                    购物赚积分
                </button>
            </div>
        </div>

    </div>

    <div style="display:none">
        <audio id="yao" src="/static/mobile/game/bobing/images/yao.mp3"></audio>
    </div>
    <div class="gamemask" v-show="dialogShow" style="display: none;"></div>
    <div class="ui-dialog" v-show="dialogShow" style="display: none;">
        <h3>幸运刮刮卡游戏分享</h3>
        <p>请复制地址</p>
        <input type="text" v-model="shareUrl">
        <a class="ui-btn" href="javascript:void(0);" @tap="closeDialog">关闭</a>
    </div>
</div>
<script>
    var app = new Vue({
                el: '#page',
                data: {
                    notPoint: false,
                    totalScore: 0,//当前用户总积分
                    userId: 0,// 用户id
                    cId: 0,// 分享者userId
                    count: 0,// 当天已经玩的次数
                    playTime: 0,// 当前可玩次数
                    awards: {},// 游戏信息
                    notPointDiv: false,// 无积分时弹窗提示
                    flag: false,// 防止多次提交
                    tip: "",// 提示
                    recordId: 0,// 中奖结果ID
                    goMyShow: false,// 我的奖品按钮显示标识
                    popDivShow: false,// 弹出框是否显示标识
                    dialogShow: false,// 分享奖品遮罩和弹出框是否显示标识
                    shareUrl: "",// 分享地址
                    pop_ok_callback: function () {
                    }// 回调函数
                },
                computed: {
                    // 背景图片
                    bodyPicUrl: function () {
                        if (this.awards.centerBgPicUrl) {
                            return this.awards.centerBgPicUrl;
                        }
                        return "/static/mobile/game/bobing/images/1.jpg"
                    },
                    // 骰子背景图
                    coverPicUrl: function () {
                        if (this.awards.awardsPicUrl) {
                            return this.awards.awardsPicUrl;
                        }
                        return "/static/mobile/game/bobing/images/wan.png";
                    }
//                    contentPicUrl: function () {
//                        if (this.showType == 1) {
//                            return this.resultImg['win'];
//                        }
//                        return this.resultImg['none'][Math.floor(this.resultImg['none'].length * Math.random())];
//                    },
                },
                methods: {
                    // 玩游戏
                    processResponse: function () {
                        if (!this.userId) {
                            this.show_tip('请先登陆', '确定', function () {
                                window.location.href = "/m/login.html?successUrl=/m/boCake/" + this.awards.id + ".html";
                            }, true);
                            return false;
                        }
                        if (this.count && (this.count >= this.awards.oneDayTimes)) {
                            this.show_tip('您今天的抽奖次数已满，感谢参与');
                            return false;
                        }
                        this.count++;
                        var dice = $(".dice");
                        for (i = 0; i < dice.length; i++) {
                            dice.eq(i).addClass("active");
                        }
                        $('#yao')[0].play();
                        setTimeout(function () {
                            $(".dice").removeClass("active");
                        }, 1500);
                        this.$http.post('/m/boCake/play',
                                {id: this.awards.id, cId: this.cId},
                                {emulateJSON: true}
                        ).then(
                                function (res) {
                                    //成功
                                    if (res.data.result == 'WARN') {
                                        this.show_tip('谢谢参与!');
                                    } else if (res.data.result == 'nosession') {
                                        this.show_tip('请先登陆', '确定', function () {
                                            window.location.href = "/m/login.html?successUrl=/m/boCake/" + this.awards.id + ".html";
                                        }, true);
                                    } else if (res.data.result == "winning") {//中奖
                                        this.tip = res.data.tip;
                                        this.recordId = res.data.recordId;
                                        this.diceResultShow(dice, res.data.diceResult);//骰子显示
                                        if (res.data.autoHandle) {//中奖项为积分或者优惠券
                                            setTimeout("app.show_tip(app.tip)", 2000);
                                            return false;
                                        }
                                        if ("1" != res.data.haveAddress) {//中奖项为实物,如果么有地址,需登记地址
                                            setTimeout("app.show_tip(app.tip, '登记地址', function () { location.href = '/m/account/award/record?id=' + app.recordId; }, true)", 2000);
                                            return false;
                                        }
                                    } else {
                                        if ((res.data.tip + "").indexOf('积分不够') != -1) {
                                            this.show_not_point();
                                        } else {
                                            this.diceResultShow(dice, res.data.diceResult);
                                            this.tip = res.data.tip;
                                            setTimeout("app.show_tip(app.tip)", 2000);
                                        }
                                    }
                                }, function (res) {
                                    // 处理失败的结果
                                    this.show_tip('谢谢参与!');
                                }
                        );
                    },

                    // 骰子显示
                    diceResultShow: function (dice, diceResult) {
                        for (var i = 0; i < dice.length; i++) {
                            dice.eq(i).find("img").attr("src", "/static/mobile/game/bobing/images/d" + diceResult[i].trim() + ".png");
                        }
                    },

                    //关闭弹窗
                    closeNotPointDiv: function () {
                        this.notPointDiv = false;
                        this.flag = false;
                    },
                    //跳转至商城
                    toShop: function () {
                        window.location.href = '/m';
                    },
                    //显示对应提示
                    show_tip: function (msg, btn_text, callback, hidemy) {
                        $("#pop_tip_div").html(msg);

                        if (btn_text) {
                            $("#pop_ok_btn").text(btn_text);
                        } else {
                            $("#pop_ok_btn").text("确定");
                        }

                        if (callback) {
                            this.pop_ok_callback = callback;
                        } else {
                            this.pop_ok_callback = function () {
//                                $("#pop_div").hide();
                                this.popDivShow = false;
                            };
                        }

                        if (hidemy) {//判断是否隐藏我的奖品按钮
                            this.goMyShow = false;
                        } else {
                            this.goMyShow = true;
                        }

                        this.popDivShow = true;
                    },
                    // 积分不够时显示
                    show_not_point: function () {
                        this.notPointDiv = true;
                    },
                    //其他方法
                    popTpoClose: function () {
//                        $("#pop_div").hide();
                        this.popDivShow = false;
                        this.flag = false;
                    },
                    // 跳转至我的奖品页
                    popGoMy: function () {
                        window.location.href = "/m/account/award/showAward?awardTypeCd=3";
                    },
                    // 弹出框按钮绑定回调函数
                    pop_ok_btn: function () {
                        this.pop_ok_callback();
                        this.flag = false;
                    },
                    //分享游戏
                    shareToFri: function () {
                        if (!this.userId) {
                            this.show_tip('请先登陆', '确定', function () {
                                window.location.href = "/m/login.html?successUrl=/m/boCake/" + this.awards.id + ".html";
                            }, true);
                            return false;
                        }
                        var protocol = window.location.protocol;
                        var host = window.location.host;
                        var pathname = window.location.pathname;
                        this.shareUrl = protocol + "//" + host + pathname + "?cId=" + this.userId;
                        console.log(this.shareUrl);
                        this.dialogShow = true;
                    },
                    closeDialog: function () {
                        this.dialogShow = false;
                    },
                    myAwardsShow: function () {
                        window.location.href = "/m/account/award/showAward?awardTypeCd=3";
                    }
                },
                created: function () {
                    this.$http.get('/m/boCake/showPcInfo', {
                        params: {
                            id: ${id!},
                            cId:${cId!"0"}
                        },
                        emulateJSON: true
                    }).then(
                            function (res) {
                                // 处理成功的结果
                                this.notPoint = res.body.notPoint;
                                this.totalScore = res.body.totalScore;
                                this.userId = res.body.userId;
                                this.cId = res.data.cId;
                                this.count = res.body.count;
                                this.awards = res.body.awards;
                                this.playTime = res.body.playTime;
//                                this.recentResultList = res.body.recentResultList;
                            }
                    );
                }
            })
            ;

</script>
<script src="${ctx}/static/mobile/game/bobing/js/main.js"></script>
</body>
</html>