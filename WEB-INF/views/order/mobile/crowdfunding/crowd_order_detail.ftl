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
<div id='app' v-cloak>
    <div id="page">
        <header class="mui-bar mui-bar-nav">
            <a class="mui-icon mui-icon-left-nav" href='/m/account/crowdfundingOrder/list'></a>
            <h1 class="mui-title">我的众筹记录</h1>
            <a class="mui-icon"></a>
        </header>
        <div class="mui-content">
            <div class="toptip" v-show='isWinner && !isTaked'>
                <a class="btn" v-bind:href="awardUrl">领奖</a>
                <p class="info">众筹结果揭晓，恭喜您中奖啦！</p>
            </div>

            <div class="borderbox">
                <div class="prd-list">
                    <a href='/m/crowdfunding/detail/${promotionId!}'>
                        <ul>
                            <li v-show='requireNum == currentPeopleNum?false:true'>
                                <div class="pic"><img v-bind:src="picUrl"></div>
                                <div class="r">
                                    <p class="name">{{promotionName}}</p>
                                    <p class="progressbar"><span v-bind:style="percent"></span></p>
                                    <p>众筹尚未完成，还需<i class="numberof">{{requireNum - currentPeopleNum}}</i>人次</p>
                                </div>
                            </li>
                            <li v-show='requireNum == currentPeopleNum?true:false'>
                                <div class="pic"><img v-bind:src="picUrl"><b v-show='!isWinner || !isTaked'>已揭晓</b><b
                                        v-show='isWinner && isTaked'>已领奖</b></div>
                                <div class="r">
                                    <p class="name">{{promotionName}}</p>
                                    <p class="announced">获得者:<i>{{winnerLoginName}}</i></p>
                                    <p class="announced">揭晓时间:{{calcTime}}</p>
                                </div>
                            </li>
                        </ul>
                    </a>
                </div>
                <div class="chipWrap">
                    <div class="topbar">本期商品您总共购买{{orderList.length}}份订单，拥有<span
                            class="orange">{{countFundCodeNum}}</span>个众筹码
                    </div>
                    <div class="hd">
                        <ul>
                            <li v-for="item in orderList">
                                <span><em style="color:#1d1d1d">{{item.orderNumber}}</em> {{new Date(item.createTime).format('MM-dd hh:mm:ss')}}<em>共{{item.fundCodeNums.length}}个</em></span>
                                <#--<span>订单号：</span>-->
                                <p>
                                    <i v-for="code in item.fundCodeNums">{{code==winCode?code+"（已中奖）":code}}</i>
                                </p>
                            </li>
                        </ul>
                    </div>
                    <div class="bd">显示全部</div>
                </div>
            </div>

            <div v-if="isWinner && isTaked" class="borderbox">
                <div class="title"><span style="color:#1d1d1d">收货信息</span></div>
                <div class="payment-info" v-if="orderDistrbuteType == 1">
                    <#--<ul>-->
                        <#--<li><p>收件人：</p><span>{{receiveName}}</span></li>-->
                        <#--<li><p>电话：</p><span>{{receiveTel}}</span></li>-->
                        <#--<li><p>收货地址：</p><span>{{receiveAddrCombo}}</span></li>-->
                    <#--</ul>-->
                    <p>
                        <span class="fl gray">收件人</span>
                        <span class="fr">{{receiveName}}</span>
                    </p>
                    <p>
                        <span class="fl gray">电话</span>
                        <span class="fr">{{receiveTel}}</span>
                    </p>
                    <p>
                        <span class="fl gray">收货地址</span>
                        <span class="fr">{{receiveAddrCombo}}</span>
                    </p>
                </div>
                <div v-if="orderDistrbuteType == 1" class="payment-info">
                    <p>
                        <span class="fl gray">快递公司</span>
                        <span class="fr" v-if="orderStatusCd == 3">{{expressName}}</span>
                        <span class="fr" v-if="orderStatusCd == 20">尚未发货</span>
                    </p>
                    <p>
                        <span class="fl gray">快递单号</span>
                        <span class="fr">{{expressNum}}</span>
                    </p>
                </div>
                <div v-if="orderDistrbuteType == 1" class="payment-info">
                    <p>
                        <span class="fl gray">物流信息</span>
                        <span class="fr">
                            <a href="javascript:confirmReceive()" class="mui-btn mui-btn-outlined" v-if="orderStatusCd == 3">确认收货</a>
                            <span v-if="orderStatusCd == 5">已收货</span>
                        </span>
                    </p>
                </div>
                <div class="order-info" v-if="orderDistrbuteType == 2">
                    <ul>
                        <li><p>自提门店：</p><span>{{store.storeName}}</span></li>
                        <li><p>自提地址：</p><span>{{store.detailAddress}}-{{store.telephone}}</span></li>
                    </ul>
                </div>
            </div>

            <div class="borderbox">
                <div class="tbviewlist categorylist">
                    <ul>
                        <li>
                            <a class="itemlink" v-bind:href="recodeUrl">
                                <div class="c">众筹计算记录</div>
                            </a>
                        </li>
                        <li>
                            <a class="itemlink" v-bind:href="allRecodeUrl">
                                <div class="c">所有参与记录</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script type='text/javascript'>
    var promotionId = ${promotionId!};
    var app = new Vue({
        el: '#app',
        data: {
            picUrl: '',
            promotionName: '',
            requireNum: 0,
            currentPeopleNum: 0,
            isWinner: false,
            isTaked: true,
            percent: 'width:0%',
            winnerLoginName: '',
            calcTime: '',
            orderList: [],
            countFundCodeNum: 0,
            winCode: '',
            orderDistrbuteType: 0,
            store: {},
            receiveAddrCombo: '',
            receiveName: '',
            receiveTel: '',
            recodeUrl: 'toCodeNumList?promotionId=' + promotionId,
            allRecodeUrl: 'toOrderRecode?promotionId=' + promotionId,
            awardUrl: 'submitOrder?promotionId=' + promotionId,
            orderStatusCd:0,
            expressName:'',
            expressNum:'',
            orderId:0
        },
        methods: {}
    });

    //初始化数据
    $(function () {
        $.ajax({
            url: 'jsonDetailData?promotionId=' + promotionId,
            type: 'get',
            success: function (data) {
//            console.log(data)
                app.orderId = data.orderId;
                app.orderStatusCd = data.orderStatusCd;
                app.expressName = data.expressName;
                app.expressNum = data.expressNum;
                app.picUrl = data.picUrl;
                app.promotionName = data.promotionName;
                app.requireNum = data.requireNum.toFixed(0);
                app.currentPeopleNum = data.currentPeopleNum;
                app.percent = 'width : ' + eval((app.currentPeopleNum / app.requireNum) * 100) + '%'
                var name = data.winnerLoginName;
                app.calcTime = new Date(data.calcTime).format('yyyy-MM-dd hh:mm:ss');
                app.orderList = data.orderList;
                app.countFundCodeNum = data.countFundCodeNum;
                if (data.winCode != null && data.winCode != '') {
                    if (data.winnerUserId == data.userId) app.isWinner = true;
                    app.winnerLoginName = app.isWinner ? name : name.substring(0, 3) + '***' + name.substring(name.length - 4);
                    app.winCode = data.winCode;
                }
                app.isTaked = data.isTaked == 0 ? false : true;
                app.receiveTel = data.receiveTel;
                app.receiveName = data.receiveName;
                app.receiveAddrCombo = data.receiveAddrCombo;
                app.orderDistrbuteType = data.orderDistrbuteType;
                app.store = data.store;
            }
        });
    });

    $(function () {

        //tab栏固顶
        var tabBar = $("#J_DetailTab");
        $(window).on("scroll",
                function () {
                    var tabTop = tabBar.offset().top;
                    if (document.body.scrollTop > tabTop) {
                        tabBar.addClass("fixed");
                    } else {
                        tabBar.removeClass("fixed");
                    }
                });

        var detailContent = $('#J_DetailContent');
        detailContent.find('[width],[height]').css({
            width: 'auto',
            height: 'auto'
        });
        detailContent.find("img").css({
            width: "auto",
            height: "auto",
            margin: "20px auto",
            display: "block"
        }).unveil(0,
                function () {
                    var img = $(this);
                    img.one("load",
                            function () {
                                img.css({
                                    width: "auto",
                                    height: "auto",
                                    margin: "auto"
                                });
                            });
                });

        //图片详情产品参数tab
        $(".skutabbar li").click(function () {
            var idx = $(this).index();
            $(".skutabbar li").removeClass("selected");
            $(this).addClass("selected");
            $(".tabpag").hide().eq(isNaN(idx) ? 0 : idx).show();
        });

        //订单内容显示隐藏
        $(".chipWrap .bd").on("click", function () {
            var _this = $(this),
                    obj = _this.parent().find(".hd");
            if (obj.hasClass("toggled")) {
                obj.removeClass("toggled");
                _this.html('显示全部');
            } else {
                obj.addClass("toggled");
                _this.html('收起全部');
            }
        });
    })

    function confirmReceive(){
        mui.confirm('', '是否确认收货？', ['取消', '确认'], function (e) {
            if (e.index == 1) {
                $.get("${ctx}/account/crowdfundingOrder/receiveConfirm", {orderId: app.orderId}, function (data) {
                    if (data) {
                        if (data.result == 'success') {
                            mui.toast("确认收货成功！");
                            setTimeout(function(){
                                location.reload();
                            },1000);
                        } else {
                            mui.alert(data.message,"操作失败",["确定"]);
                        }
                    } else {
                        mui.alert("网络异常，请稍候再试","操作失败",["确定"]);
                    }
                });
            }
        })
    }

</script>
</body>
</html>