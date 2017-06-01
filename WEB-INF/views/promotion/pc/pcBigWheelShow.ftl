<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <script src="${ctx}/static/js/ZeroClipboard.min.js"></script>
</head>
<body>
<style>
    .ms-controller {
        visibility: hidden
    }
</style>
<div class="bwwraper ms-controller" :controller="app">
    <div class="bwhead" :css="{backgroundImage: 'url('+bigWheelHeadPicUrl+')'}"></div>
    <div class="bwbox" :css="{backgroundImage: 'url('+bigWheelBgPicUrl+')'}">
        <div class="bwwrap clearfix">
            <div class="bigwheelbox">
                <div class="bigwheel" :css="{backgroundImage: 'url('+bigWheelPicUrl+')'}"></div>
                <div id="bigwheel-pointer" class="bigwheel-pointer" :click="pointClick"
                     :css="{backgroundImage: 'url('+pointerPicUrl+')'}"></div>
            </div>
            <div class="bwaward">
                <div class="winning">
                    <h3 class="win-title">中奖名单</h3>
                    <div class="win-list">
                        <ul>
                            <li :for="recentResult in recentResultList"><p>{{recentResult.userName}}</p>
                                <span>抽中
                                    <em class="red">{{recentResult.awardsItemName}}</em>
                                </span>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="infobar">
                    <dl>
                        <dt><span><a href="/account/userPromotion/toAward">我的奖品</a></span>
                        <p>尊敬的{{userName}}，您当前积分：{{totalScore}}</p>
                        </dt>
                        <dd>每次需要{{awards.usePoint}}积分，您还可以玩{{playTime}}次。</dd>
                    </dl>
                </div>
            <#--<div class="shareButton" :click="shareFriUrl">分享给好友送积分</div>-->
                <input type="hidden" value="" id="fe_text"/>
                <div class="shareButton" id="copy-button" data-clipboard-target="fe_text">分享给好友送积分</div>
            </div>
        </div>
        <div class="bwdesc" :html="awards.pcBottomHtml!=null?awards.pcBottomHtml:''">
            <#--<h3 class="title">活动规则</h3>-->
            <#--<div class="desc">-->
                <#--<p>1. 活动时间：{{awards.startTime| date("yyyy-MM-dd HH:mm:ss")}}至{{awards.endTime| date("yyyy-MM-dd-->
                    <#--HH:mm:ss")}}；</p>-->
                <#--<p>2. 活动期间每个账号每天有{{awards.oneDayTimes}}次抽奖机会，同一账号、手机号均视为同一用户；</p>-->
                <#--<p>3. 获得实物奖品的，请于中奖7日内提交个人信息，逾期视为自动放弃。</p>-->
                <#--<p>4. 分享游戏给好友，若好友为第一次游戏，则可获得{{awards.recommendPoint}}积分。</p>-->
                <#--<p>5. 在法律允许范围内，本商城有权对活动规则进行解释。</p>-->
            <#--</div>-->
        </div>
    </div>
</div>
<script src="${ctx}/static/js/jQueryRotate3.js"></script>
<script src="${ctx}/static/js/jquery.nicescroll.js"></script>
<script>

    (function () {
        var lastTime = 0;
        var vendors = ['ms', 'moz', 'webkit', 'o'];
        for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
            window.requestAnimationFrame = window[vendors[x] + 'RequestAnimationFrame'];
            window.cancelRequestAnimationFrame = window[vendors[x] +
            'CancelRequestAnimationFrame'];
        }

        if (!window.requestAnimationFrame)
            window.requestAnimationFrame = function (callback, element) {
                var currTime = new Date().getTime();
                var timeToCall = Math.max(0, 16 - (currTime - lastTime));
                var id = window.setTimeout(function () {
                            callback(currTime + timeToCall);
                        },
                        timeToCall);
                lastTime = currTime + timeToCall;
                return id;
            };

        if (!window.cancelAnimationFrame)
            window.cancelAnimationFrame = function (id) {
                clearTimeout(id);
            };
    }());

    var BigWheel = {
        _speed: 0,
        _cur_angle: 0,
        _wheel: null,
        config: {
            acc: 0.1,
            dec: 0.05,
            maxSpeed: 10,
            prizeAngles: [
                [{min: 346, max: 14}],
                [{min: 316, max: 344}],
                [{min: 286, max: 314}],
                [{min: 256, max: 284}],
                [{min: 226, max: 254}],
                [{min: 196, max: 224}],
                [{min: 166, max: 194}],
                [{min: 136, max: 164}],
                [{min: 106, max: 134}],
                [{min: 76, max: 104}],
                [{min: 46, max: 74}],
                [{min: 16, max: 44}]
            ]
        },
        init: function (selector, config) {
            this._wheel = $(selector);
            $.extend(this.config, config);
        },
        _rotate: function (diffangle) {
            var ang = (this._cur_angle + diffangle + 360) % 360;
            if (ang) {
                this._cur_angle = ang;
                this._wheel.rotate(ang);
            }
        },
        _accelerate: function () {
            if (BigWheel._stop) {
                return;
            }
            if (!BigWheel._willStop) {
                if (BigWheel._speed < BigWheel.config.maxSpeed && BigWheel._speed + BigWheel.config.acc < BigWheel.config.maxSpeed) {
                    BigWheel._speed += BigWheel.config.acc;
                } else {
                    BigWheel._speed = BigWheel.config.maxSpeed;
                }
            }
            BigWheel._rotate(BigWheel._speed);
            BigWheel._acctimer = requestAnimationFrame(BigWheel._accelerate);
        },
        _decelerate: function () {
            if (BigWheel._speed <= 0) {
                BigWheel._willStop = false;
                BigWheel._stop = false;
                BigWheel._endCallback && BigWheel._endCallback.call();
                return;
            }
            if (BigWheel._speed > 0 && BigWheel._speed - BigWheel.config.dec > 0) {
                BigWheel._speed -= BigWheel.config.dec;
            } else {
                BigWheel._speed = 0;
            }
            BigWheel._rotate(BigWheel._speed);
            BigWheel._dectimer = requestAnimationFrame(BigWheel._decelerate);
        },
        _checkAngle: function () {
            var angle = BigWheel._targetAngle;
            var diffangle = (BigWheel._cur_angle + BigWheel._speed) % 360 - angle;
            if (diffangle >= 0) {
                BigWheel._stop = true;
                BigWheel._rotate(BigWheel._speed - diffangle);
                BigWheel._dectimer = requestAnimationFrame(BigWheel._decelerate);
            } else {
                BigWheel._checktimer = requestAnimationFrame(BigWheel._checkAngle);
            }
        },
        startRotate: function () {
            if (this._speed > 0) {
                return;
            }
            if (this._speed == 0) {
                this._acctimer = requestAnimationFrame(this._accelerate);
            }
        },
        endRotate: function (prize, callback) {
            var count = Math.ceil(this._speed / this.config.dec), buffer_angle = 0, ang, angles, prizeAngles = this.config.prizeAngles;
            for (var i = 0, spd = this._speed; i < count; i++) {
                spd -= this.config.dec;
                buffer_angle += spd;
            }
            this._willStop = true;
            this._endCallback = callback;
            console.log(prize);
            angles = prizeAngles[parseInt(prize)] || prizeAngles[0];
            angles = angles[Math.floor(Math.random() * angles.length)];
            ang = ((angles.max - angles.min + 360) % 360 / 2 + angles.min - buffer_angle + 360) % 360;
            this._targetAngle = ang;
            this._checktimer = requestAnimationFrame(BigWheel._checkAngle);
        }
    };
    var vm = avalon.define({
        $id: 'app',
        // --------数据---------
        totalScore: 0,//当前用户总积分
        userId: 0,
        playTime: 0,//当前可玩次数
        awards: {},
        flag: true,//防止多次提交
        recentResultList: {},//中奖名单
        temporaryList: {},//临时使用变量
        shareUrl: "",
        userName: "",
        gameId: ${id!},
        cId:${cId!"-1"},
        $computed: {
            bigWheelHeadPicUrl: function () {
                if (this.awards.pcTopHtml) {
                    return this.awards.pcTopHtml;
                }
                return "/static/images/bigwheel/bigwheel-head.jpg"
            },
            bigWheelBgPicUrl: function () {
                if (this.awards.pcCenterBgPicUrl) {
                    return this.awards.pcCenterBgPicUrl;
                }
                return "/static/images/bigwheel/bigwheel-bg.jpg";
            },
            bigWheelPicUrl: function () {
                if (this.awards.pcAwardsPicUrl) {
                    return this.awards.pcAwardsPicUrl;
                }
                return "/static/images/bigwheel/bigwheel.png";
            },
            pointerPicUrl: function () {
                if (this.awards.pcAwardsPointPicUrl) {
                    return this.awards.pcAwardsPointPicUrl;
                }
                return "/static/images/bigwheel/bigwheel-pointer.png";
            }
        },
        // -----------方法-----------
        // 玩游戏
        pointClick: function () {
            BigWheel.init(".bigwheel");
            BigWheel.startRotate();
            setTimeout(vm.playPost, 4000);
        },
        playPost: function () {
            $.post('/account/turn/play', {
                id: vm.gameId,
                cId: vm.cId
            }, function (data) {
                if (data.result == 'WARN') {
                    BigWheel.endRotate(1, function () {
                    });
                    layer.msg("谢谢参与!");
                    return false;
                } else if (data.result == 'noSession') {
                    BigWheel.endRotate(1, function () {
                        layer.confirm('请先登陆', '确定', function () {
                            location.href = "${ctx}/login.html?successUrl=/account/turn/" + vm.gameId + ".html?cId=" + vm.cId;
                        });
                    }, true);
                    return false;
                }
                else if (data.result == "winning") {
                    vm.temporaryList = data.recentResultList;
                    setTimeout(function () {
                        vm.recentResultList = vm.temporaryList;
                        vm.getUserPlayNum();
                    }, 5000);
                    BigWheel.endRotate(data.rotate, function () {
//                        refreshUserPoint();
                        if (data.autoHandle) {
                            layer.msg(data.tip);
                            return false;
                        }
                        if ("1" == data.haveAddress) {
                            layer.msg(data.tip);
                        } else {
                            layer.confirm('恭喜你获得' + data.tip + '，请登记中奖收货地址', {
                                btn: ['登记地址', '关闭'] //按钮
                            }, function () {
                                //TODO
                                location.href = "/account/userPromotion/toAward";
                            }, function () {

                            });
                        }
                    });
                } else {
                    setTimeout(function () {
                        vm.getUserPlayNum();
                    }, 5000);
                    BigWheel.endRotate(data.rotate, function () {
                        if ((data.tip + "").indexOf('积分不够') != -1) {
                            layer.confirm('oh!No!您当前积分不足!', {
                                btn: ['购物赚积分'] //按钮
                            }, function () {
                                location.href = "/products/0.html";
                            });
                        } else {
                            layer.msg(data.tip);
                            return false;
                        }
                    });
                }
            });
        },
        //实时更新用户数据
        getUserPlayNum: function () {
            $.post('/account/turn/getUserPlayAgain', {
                id: this.gameId
            }, function (data) {
                if (data && data.result) {
                    vm.totalScore = data.totalScore;
                    vm.awards.usePoint = data.usePoint;
                    vm.playTime = data.playTime;
                }
            });
        }
    });

    vm.$watch('onReady', function () {
        $.get('/account/turn/showInfo', {
            id: vm.gameId,
            cId: vm.cId
        }, function (data) {
            vm.totalScore = data.totalScore;
            vm.userId = data.userId;
            vm.cId = data.cId;
            vm.recentResultList = data.recentResultList;
            vm.awards = data.awards;
            vm.playTime = data.playTime;
            vm.userName = data.userName;

            if (!vm.userId) {
                layer.confirm('请先登陆', '确定', function () {
                    location.href = "${ctx}/login.html?successUrl=/account/turn/" + vm.gameId + ".html?cId=" + vm.cId;
                });
                return false;
            }
            var protocol = window.location.protocol;
            var host = window.location.host;
            var pathname = window.location.pathname;
            vm.shareUrl = protocol + "//" + host + pathname + "?cId=" + vm.userId;
            $("#fe_text").val(vm.shareUrl);
            var clip = new ZeroClipboard(document.getElementById("copy-button"), {
                moviePath: "/static/js/ZeroClipboard.swf"
            });
            clip.on("load", function (client) {
                client.on("complete", function (client, args) {
                    layer.msg("已复制,将复制链接地址分享与他人即可!");
                });
            });
            $('.win-list').niceScroll({
                cursorcolor: "#ccc",
                mousescrollstep: 40,
                oneaxismousemode: "auto"
            });
        });

    })

</script>
</div>
</body>
</html>