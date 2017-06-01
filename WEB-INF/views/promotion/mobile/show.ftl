<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/yrmobile.css">
    <script type="text/javascript" src="${ctx}/static/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/awardRotate.js"></script>
    <title>${(awards.title)?default("幸运大转盘")}</title>
    <style>
        /*bigwheel*/
        .bwbox .bwwrap{ background-image: url("${(awards.centerBgPicUrl)!}");}
        .bigwheel{background-image: url("${(awards.awardsPicUrl)!}");}
        .bigwheel-pointer{background-image: url("${(awards.awardsPointPicUrl)!}");}
    </style>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">大转盘</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <div class="bwwraper">
        <#if totalScore?has_content>
            <#assign haveTime = 0/>
            <#if awards.usePoint?has_content && awards.usePoint gt 0 && totalScore?has_content>
                <#assign haveTime = (totalScore/awards.usePoint)?int/>
            </#if>
            <div class="toptip mb0">
                <div>你当前积分:<span id="user_point">${totalScore?default(0)}</span>,每次需${awards.usePoint?default(0)}积分,你还可以玩<span id="user_time">${haveTime}</span>次。
                </div>
            </div>
            <div class="bwhead">
            ${awards.pcTopHtml?default("")}
            </div>
        </#if>

            <div class="bwbox">
                <div class="bwwrap">
                    <div class="wheelbg">
                        <div class="bigwheel" id="rotate"></div>
                        <div class="bigwheel-pointer" id="bigwheel-pointer"></div>
                    </div>
                    <div class="bwawardwrap">
                        <h3>中奖名单</h3>
                        <div class="bwaward" id="recent_result">
                        </div>
                    </div>
                    <div class="bigrules">${awards.pcBottomHtml!}</div>
                </div>
            </div>

            <div class="bwpop" id="pop_div" style="display: none">
                <div class="bwtit"><a class="bwclose" id="pop_top_close" href="javascript:void(0)">关闭</a></div>
                <div class="bwcon" id="pop_tip_div">

                </div>
                <div class="bwbtnbar">
                    <button data-role="none" style="height: 30px" id="pop_ok_btn"></button>
                    &nbsp;&nbsp;<button data-role="none" style="height: 30px;cursor: pointer" id="pop_go_my">我的奖品</button>
                </div>
            </div>

            <div class="bwpop" id="not_point_div" style="display: none">
                <div class="bwtit"><a class="bwclose" href="javascript:$('#not_point_div').hide();">关闭</a></div>
                <div class="bwcon">
                    <div style="text-align: center; font-size: 14px; font-weight: bold; margin-bottom: 10px;">哦No！您当前积分不足！</div>
                    <div style="clear: both;"></div>
                </div>
                <div class="bwbtnbar">
                    <button onclick="window.location.href='/m'" data-role="none" style="height: 30px;cursor: pointer">购物赚积分</button>
                </div>
            </div>

        </div>
    </div>

</div>
<script>
    var flag = true;//防止多次提交
    var count = ${count!};  //已玩次数
    var playTime = ${(awards.oneDayTimes)?default(10000)}; //可玩次数
    $(function(){
        //BigWheel.init(".bigwheel");
        $(".bigwheel-pointer").on("click",function(){
        <#if !userId??>
            show_tip('请先登陆','确定',function(){
                window.location.href="${ctx}/m/login.html?successUrl=${ctx}/m/turn/${awards.id}.html";
            },true);
            return;
        </#if>

            if(count&&(count>=playTime)){
                show_tip('您今天的抽奖次数已满，感谢参与');
                return;
            }
            count++;
        <#if notPoint?has_content && notPoint>
            $('#rotate').stopRotate();//停止转动
            show_not_point();
            return;
        </#if>

            if(!flag) { return; }
            flag = false;

            $.ajax({
                url: '/m/turn/play?id=${awards.id}',
                type: 'post',
                data: {},
                cache: false,
                beforeSend:function(){
                    $('#rotate').rotate({
                        angle:0,
                        animateTo:1800000,
                        duration:300000,
                        callback:function (){

                        }
                    })
                },
                complete:function(){
                },
                success: function(res){
                    getUserPalyNum();
                    if(res.data.result=='WARN'){
                        bigwheel(1,'谢谢参与!','');
                        return ;
                    }
                    if(res.data.result=='nosession'){
                        show_tip('请先登陆','确定',function(){
                            window.location.href="${ctx}/m/login.html?successUrl=${ctx}/m/turn/${awards.id}.html";
                        });
                        flag = true;
                        return;
                    }
                    if(res.data.result=="winning"){
                        bigwheel(res.data.rotate,'试试四十四',res);
                    }else{
                        if(res.data.tip.indexOf('积分不够')!=-1){
                            $('#rotate').stopRotate();
                            show_not_point();
                            flag = true;
                        }else{
                            bigwheel(1,'谢谢参与!','');
                        }
                    }
                },
                error: function(){
                    flag = true;
                    //BigWheel.endRotate(1,function(){});
                    bigwheel(1,"谢谢参与!",'');
                }
            });
        });

        var rotateTimeOut = function (){
            $('#rotate').rotate({
                angle:0,
                animateTo:2160,
                duration:8000,
                callback:function (){
                    show_tip('网络超时，请检查您的网络设置！');
                }
            });
        };
        var bRotate = false;

        var rotateFn = function (awards, angles, txt, res){
            bRotate = !bRotate;
            $('#rotate').stopRotate();
            $('#rotate').rotate({
                angle:0,
                animateTo:angles+1800,
                duration:8000,
                callback:function (){
                    bRotate = !bRotate;
                    flag = true;
                    if(txt != '') {
                        show_tip(txt);
                        return;
                    }

                    if(res.data.isCoupon){
                        show_tip(res.data.tip,'领取',function(){
                            location.href=res.data.couponAddress;
                        });
                        return;
                    }
                    if(res.data.autoHandle){
                        show_tip(res.data.tip);
                        return;
                    }
                    if("1"==res.data.haveAddress){
                        show_tip(res.data.tip,'确定');
                        return;
                    }else{
                        show_tip(res.data.tip,'登记地址',function(){
                            location.href="${ctx}/m/turn/record?id="+res.data.recordId;
                        },true);
                        return;
                    }
                }
            })
        };
        function bigwheel(item,tip,res){
            if(bRotate)return;
            //var item = rnd(0,11);
            switch (item) {
                case 1:
                    rotateFn(0, 330, tip, res);
                    break;
                case 2:
                    rotateFn(1, 300, tip, res);
                    break;
                case 3:
                    rotateFn(2, 270, tip, res);
                    break;
                case 4:
                    rotateFn(3, 240, tip, res);
                    break;
                case 5:
                    rotateFn(4, 210, tip, res);
                    break;
                case 6:
                    rotateFn(5, 180, tip, res);
                    break;
                case 7:
                    rotateFn(6, 150, tip, res);
                    break;
                case 8:
                    rotateFn(7, 120, tip, res);
                    break;
                case 9:
                    rotateFn(8, 90, tip, res);
                    break;
                case 10:
                    rotateFn(9, 60, tip, res);
                    break;
                case 11:
                    rotateFn(10, 30, tip, res);
                    break;
                case 12:
                    rotateFn(11, 0, tip, res);
                    break;
            }
        }

    <#--实时更新用户数据-->
        function getUserPalyNum() {
            $.ajax({
                url: '/m/turn/getUserPalyAgain?id=${awards.id}',
                type: 'post',
                data: {},
                cache: false,
                success: function(data){
                    if(data && data.result == 'success') {
                        var div = '<div>你当前积分:<span id="user_point">'+data.data.totalScore+'</span>,每次需'+data.data.usePoint+'积分,你还可以玩<span id="user_time">'+data.data.count+'</span>次。</div>';
                        $('.toptip').html(div);
                    }
                },
                error: function(){
                    flag = true;
                }
            });
        }
    });
    function rnd(n, m){
        return Math.floor(Math.random()*(m-n+1)+n)
    }
</script>
<script>
    var pop_ok_callback;
    function pop_default_close(){
        $("#pop_div").hide();
    }
    function show_not_point(){
        $("#not_point_div").css("top",$("#bigwheel-pointer").offset().top);

        $("#not_point_div").show();
    }
    function show_tip(msg,btn_text,callback,hidemy){
        $("#pop_tip_div").html(msg);

        if(btn_text){
            $("#pop_ok_btn").text(btn_text);
        }else{
            $("#pop_ok_btn").text("确定");
        }

        if(callback){
            pop_ok_callback = callback;
        }else{
            pop_ok_callback = pop_default_close;
        }

        if(hidemy){
            $("#pop_go_my").hide();
        }else{
            $("#pop_go_my").show();
        }

        $("#pop_div").css("top",$("#bigwheel-pointer").offset().top);

        $("#pop_div").show();
    }
    $("#pop_ok_btn").click(function(){
        pop_ok_callback();
    });
    $("#pop_top_close").click(function(){
        $("#pop_div").hide();
    });
    $("#pop_go_my").click(function(){
        window.location.href="${ctx}/m/awards/list.html?userId=${(userId)!}&awardTypeCd=1";
    });
</script>
<script>
    function refreshRecent(){
        $.ajax({
            url: '${ctx}/m/turn/recent_ajaxpage?id=${awards.id}',
            type: 'post',
            data: {},
            cache: false,
            dataType:'html',
            success: function(res){
                $("#recent_result").html(res);
            },
            error: function(){
                //nothing
            }
        });
    }
    setInterval(refreshRecent,10000);

    <#assign pcUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcUrl()?default("")>
    $(function(){
        (function(cache_data){
            // 微信分享会自动读取这边的数据 wxData并渲染，class样式wx_btn_share默认是加在用来触发分享的按钮上
            window.wxData = {
                //img_url : '${pcUrl!}/static/mobile/images/bigwheel.png',
                img_url : '${pcUrl}/static/mobile/images/dzp.png',
                title: "${(awards.title)?default("幸运大转盘")}",
                link: location.href,
                desc: "好运转起来,豪礼赚不完!"
            };
            app.showShareBtnBar(window.wxData);
            app.showShareBubble();
        }(window["cache_data"]));
    });
</script>
</div>
</body>
</html>