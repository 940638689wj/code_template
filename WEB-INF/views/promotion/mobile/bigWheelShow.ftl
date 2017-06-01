<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/yrmobile.css">
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/awardRotate.js"></script>
    <title>幸运大转盘</title>
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

        .scard-btn-prize, .scard-btn-share {
            position: absolute;
            top: 55px;
            -webkit-background-size: cover;
            background-size: cover;
            text-indent: -9999px;
            z-index: 20;
        }

        .scard-btn-prize {
            left: 5px;
            width: 93px;
            height: 25px;
            background-image: url(/static/mobile/game/scratch_card/img/btn-prize.png);
        }

        .scard-btn-share {
            right: 5px;
            width: 88px;
            height: 25px;
            background-image: url(/static/mobile/game/scratch_card/img/btn-share.png);
        }

        .scratch-card-rule{ width: 280px;margin:20px auto;}
        .scard-rule-title{ line-height: 18px; color: #fff; font-size: 12px; margin-bottom: 8px;}
        .scard-rule-title span{ padding: 0 10px; display: inline-block; background: #aa1700; -webkit-border-radius: 9px; -moz-border-radius: 9px; border-radius: 9px;}
        .scard-rule-container{ line-height: 20px; color: #fff; font-size: 12px; height:120px; overflow: auto;}
    </style>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">幸运大转盘</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <div class="bwwraper">
            <a class="scard-btn-prize" href="/m/account/award/showAward?awardTypeCd=1">我的奖品</a>
            <a class="scard-btn-share wx_btn_share" @click="shareToFri" href="javascript:void(0)">分享游戏</a>
            <div>
                <div class="toptip mb0" v-if="totalScore">
                    <div>你当前积分:<span id="user_point" v-text="totalScore"></span>,每次需<span
                            v-text="awards.usePoint"></span>积分,
                        你还可以玩<span id="user_time" v-text="playTime"></span>次。
                    </div>
                </div>
                <div class="bwhead" v-html="awards.topHtml"></div>
            </div>

            <div class="bwbox">
                <div class="bwwrap" :style="{backgroundImage: 'url(' + bodyPicUrl + ')'}">
                    <div class="wheelbg">
                        <div class="bigwheel" id="rotate"
                             :style="{backgroundImage: 'url(' + bigwheelPicUrl + ')'}"></div>
                        <div class="bigwheel-pointer" id="bigwheel-pointer" @click="pointerClick"
                             :style="{backgroundImage: 'url(' + pointer + ')'}"></div>
                    </div>
                    <div class="bwawardwrap">
                        <h3>中奖名单</h3>
                        <div class="bwaward">
                            <p v-for="recentResult in recentResultList">
                                <span class="awuser" v-if="recentResult.userName">{{recentResult.userName}}</span>
                                <span class="awprize"
                                      v-if="recentResult.awardsItemName">{{recentResult.awardsItemName}}</span>
                            </p>
                        </div>
                    </div>
                    <div class="scratch-card-rule" v-html="awards.bottomHtml!=null?awards.bottomHtml:''">

                    </div>
                </div>
            </div>

            <div class="bwpop" id="pop_div" v-show="popDivShow" style="display: none">
                <div class="bwtit"><a class="bwclose" @click="popTpoClose" href="javascript:void(0)">关闭</a></div>
                <div class="bwcon" id="pop_tip_div">

                </div>
                <div class="bwbtnbar">
                    <button data-role="none" style="height: 30px" id="pop_ok_btn" @click="pop_ok_btn"></button>
                    &nbsp;&nbsp;
                    <button data-role="none" style="height: 30px;cursor: pointer" v-show="goMyShow" @click="popGoMy">
                        我的奖品
                    </button>
                </div>
            </div>

            <div class="bwpop" id="not_point_div" v-show="notPointDiv" style="display: none;">
                <div class="bwtit"><a class="bwclose" href="javascript:void(0)" @click="closeNotPointDiv">关闭</a></div>
                <div class="bwcon">
                    <div style="text-align: center; font-size: 14px; font-weight: bold; margin-bottom: 10px;">
                        哦No！您当前积分不足！
                    </div>
                    <div style="clear: both;"></div>
                </div>
                <div class="bwbtnbar">
                    <button @click="toShop" data-role="none" style="height: 30px;cursor: pointer">
                        购物赚积分
                    </button>
                </div>
            </div>
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
            notPoint: false,// 用户积分是否够玩标识
            totalScore: 0,// 当前用户总积分
            userId: 0,// 用户id
            cId: 0,// 分享者userId
            count: 0,// 当天已经玩的次数
            playTime: 0,// 当前可玩次数
            awards: {},// 游戏信息
            notPointDiv: false,// 无积分时弹窗提示标识
            goMyShow: false,// 弹出框我的奖品是否显示标识
            popDivShow: false,// 弹出框是否显示标识
            flag: true,// 防止多次提交
            bRotate: false,// 转盘能否正常转动标识
            pop_ok_callback: function () {
            },// 回调函数
            recentResultList: {},//中奖名单
            temporaryList: {},// 临时使用变量
            dialogShow: false,// 分享奖品遮罩和弹出框是否显示标识
            shareUrl: ""// 分享地址
        },
        computed: {
            // 游戏背景图
            bodyPicUrl: function () {
                if (this.awards.centerBgPicUrl) {
                    return this.awards.centerBgPicUrl;
                }
                return "/static/images/bigwheel/mobilebigwheel-bg.jpg"
            },
            // 转盘图片
            bigwheelPicUrl: function () {
                if (this.awards.awardsPicUrl) {
                    return this.awards.awardsPicUrl;
                }
                return "/static/images/bigwheel/mobilebigwheel.png";
            },
            // 指针图片
            pointer:function () {
                if (this.awards.awardsPointPicUrl) {
                    return this.awards.awardsPointPicUrl;
                }
                return "/static/images/bigwheel/mobilebigwheel-pointer.png";
            }
        },
        methods: {
            // 关闭弹窗
            closeNotPointDiv: function () {
                this.notPointDiv = false;
            },
            // 跳转至商城
            toShop: function () {
                window.location.href = '/m';
            },
            // 转盘指针点击事件
            pointerClick: function () {
                if (!this.userId) {
                    this.show_tip('请先登陆', '确定', function () {
                        window.location.href = "/m/login.html?successUrl=/m/turn/" + this.awards.id + ".html?cId=" + this.cId;
                    }, true);
                    return false;
                }
                if (this.count && (this.count >= this.awards.oneDayTimes)) {
                    this.show_tip('您今天的抽奖次数已满，感谢参与');
                    return false;
                }
                this.count++;
                if (this.notPoint) {
                    $('#rotate').stopRotate();//停止转动
                    this.show_not_point();
                    return false;
                }
                if (!this.flag) {
                    return false;
                }
                this.flag = false;

                this.$http.post('/m/turn/play', {id: this.awards.id, cId: this.cId}, {
                    emulateJSON: true,
                    before: function () {
                        $('#rotate').rotate({
                            angle: 0,
                            animateTo: 1800000,
                            duration: 300000
                        });
                    }
                }).then(
                        function (res) {
                            //成功
                            this.getUserPlayNum();
                            if (res.data.result == 'WARN') {
                                this.bigwheel(1, '谢谢参与!', '');
                            } else if (res.data.result == 'nosession') {
                                this.show_tip('请先登陆', '确定', function () {
                                    window.location.href = "${ctx}/m/login.html?successUrl=${ctx}/m/turn/" + this.awards.id + ".html?cId=" + this.cId;
                                });
                                this.flag = true;
                            } else if (res.data.result == "winning") {
                                this.bigwheel(res.data.rotate, '', res);
                                this.temporaryList = res.data.recentResultList;
                                setTimeout(function () {
                                    app.recentResultList = app.temporaryList;
                                }, 8000);
                            } else {
                                if ((res.data.tip + "").indexOf('积分不够') != -1) {
                                    $('#rotate').stopRotate();
                                    this.show_not_point();
                                    this.flag = true;
                                } else {
                                    this.bigwheel(1, res.data.tip, '');
                                }
                            }
                        }, function (res) {
                            // 处理失败的结果
                            this.flag = true;
                            this.bigwheel(1, "谢谢参与!", '');
                        }
                );
            },
            // 显示对应提示
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

                if (hidemy) {
//                            $("#pop_go_my").hide();
                    this.goMyShow = false;
                } else {
//                            $("#pop_go_my").show();
                    this.goMyShow = true;
                }

                $("#pop_div").css("top", $("#bigwheel-pointer").offset().top);
//                        $("#pop_div").show();
                this.popDivShow = true;
            },
            // 显示无积分时提示
            show_not_point: function () {
                $("#not_point_div").css("top", $("#bigwheel-pointer").offset().top);
                this.notPointDiv = true;
            },
            // 实时更新用户数据
            getUserPlayNum: function () {
                this.$http.post('/m/turn/getUserPalyAgain', {id: this.awards.id}, {emulateJSON: true}).then(
                        function (res) {
                            // 处理成功的结果
                            if (res && res.body.result) {
                                this.totalScore = res.body.totalScore;
                                this.awards.usePoint = res.body.usePoint;
                                this.playTime = res.body.playTime;
                            }
                        }, function (res) {
                            // 处理失败的结果
                            this.flag = true;
                        }
                );
            },
            // 转盘转动
            bigwheel: function (item, txt, res) {
                if (!this.bRotate) {
                    var angles = 330 - 30 * (item - 1);
                    this.bRotate = !this.bRotate;
                    $('#rotate').stopRotate();
                    $('#rotate').rotate({
                        angle: 0,
                        animateTo: angles + 1800,
                        duration: 8000,
                        callback: function () {
                            app.bRotate = !app.bRotate;
                            app.flag = true;
                            if (txt != '') {
                                app.show_tip(txt);
                                return false;
                            }
                            if (res.data.autoHandle) {
                                app.show_tip(res.data.tip);
                                return false;
                            }
                            if ("1" != res.data.haveAddress) {
                                app.show_tip(res.data.tip, '登记地址', function () {
                                    location.href = "/m/account/award/record?id=" + res.data.recordId;
                                }, true);
                                return false;
                            }
                        }
                    })
                }
            },
            //其他方法
            popTpoClose: function () {
                this.popDivShow = false;
            },
            // 跳转我的奖品页
            popGoMy: function () {
                window.location.href = "/m/account/award/showAward?awardTypeCd=1";
            },
            // 弹出框按钮绑定回调函数
            pop_ok_btn: function () {
                this.pop_ok_callback();
            },
            // 分享游戏
            shareToFri: function () {
                if (!this.userId) {
                    this.show_tip('请先登陆', '确定', function () {
                        window.location.href = "/m/login.html?successUrl=/m/turn/" + this.awards.id + ".html";
                    }, true);
                    return false;
                }
                var protocol = window.location.protocol;
                var host = window.location.host;
                var pathname = window.location.pathname;
                this.shareUrl = protocol + "//" + host + pathname + "?cId=" + this.userId;
                this.dialogShow = true;
            },
            // 关闭分享地址弹出框
            closeDialog: function () {
                this.dialogShow = false;
            }
        },
        created: function () {
            this.$http.get('/m/turn/showInfo', {
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
//                                this.count = res.body.count;
                        this.recentResultList = res.body.recentResultList;
                        this.awards = res.body.awards;
                        this.playTime = res.body.playTime;
                    }
            );
        }
    });
</script>
</div>
</body>
</html>