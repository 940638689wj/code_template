<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html>
<head>
	<title>${gameName!}</title>
	
	<script type="text/javascript" src="${ctx}/static/mobile/game/scratch_card/jquery.eraser.js"></script>
	<script type="text/javascript" src="${ctx}/static/mobile/js/gmu.js"></script>
	<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
     <script type="text/javascript" src="${ctx}/static/mobile/js/wxapi.js?v=1217"></script>
	<script type="text/javascript" src="${ctx}/static/mobile/js/ecmmobile.js"></script>

	
    <style>
        .scratch-card-body{ position: relative; margin: 0 auto ;  height: 520px; padding-top: 1px; background: <#if (awards.centerBgPicUrl)?has_content>url("${ctx}/cmsstatic${(awards.centerBgPicUrl)!}")<#else>url("/static/images/awardsGame.jpg")</#if> no-repeat top #eb393e; padding-top: 1px; -webkit-background-size: 320px; background-size: 320px;}
        .scard-btn-prize,.scard-btn-share{ position: absolute; top: 12px; -webkit-background-size: cover; background-size: cover; text-indent: -9999px;}
        .scard-btn-prize{ left: 11px; width: 93px; height: 25px; background-image: url("/static/mobile/game/scratch_card/img/btn-prize.png");}
        .scard-btn-share{ right: 11px; width: 88px; height: 25px; background-image: url("/static/mobile/game/scratch_card/img/btn-share.png");}
        .scratch-card-box{ position: relative; z-index: 2; width: 250px; height: 137px; margin: 180px auto 0; overflow:visible;-webkit-transform: translateZ(0);}
        .scard-cover{ position: absolute; z-index: 99; width: 100%; height: 100%;}
        .scard-content{ position: absolute; z-index: 98; width: 100%; height: 100%; text-align: center; -webkit-border-radius: 7px; -moz-border-radius: 7px; border-radius: 7px; background: #fff no-repeat center; -webkit-background-size: contain; background-size: contain;}
        .scratch-card-result{ position: absolute; z-index: 1; top: 180px; width: 250px; height: 137px; left: 50%; margin-left: -125px; background: #fff; -webkit-border-radius: 7px; -moz-border-radius: 7px; border-radius: 7px; text-align: center;}
        .result-box{ display: none; position: absolute; left: 0; top: 0; width: 100%; height: 100%;}
        .result-box h3{ font-size: 19px; color: #eb393e; line-height: 52px;}
        .result-box p{ font-size: 15px; color: #acacac; line-height: 18px; margin-left: 25px; margin-right: 25px;}
        .result-btn{ position: absolute; top: 97px; width: 100%;}
        .result-btn a{ display: inline-block; padding: 0 20px; line-height: 25px; color: #fff; font-size: 12px; -webkit-border-radius: 12px; -moz-border-radius: 12px; border-radius: 12px; background: #ff9802;}
        .result-win .result-btn a{ background: #eb393e;}
        .result-chance-over p{ margin-top: 28px; line-height: 24px;}
        .scratch-card-rule{ position: absolute; top: 354px; left: 50%; width: 280px; margin-left: -140px;}
        .scard-rule-title{ line-height: 18px; color: #fff; font-size: 12px; margin-bottom: 8px;}
        .scard-rule-title span{ padding: 0 10px; display: inline-block; background: #aa1700; -webkit-border-radius: 9px; -moz-border-radius: 9px; border-radius: 9px;}
        .scard-rule-container{ line-height: 20px; color: #fff; font-size: 12px; height: 130px; overflow: auto;}
	</style>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
			<a class="mui-icon mui-icon-left-nav"></a>
			<h1 class="mui-title">${gameName!}</h1>
			<a class="mui-icon"></a>
		</header>
	</#if>
	<div class="mui-content">
		<div class="scratch-card-body">
			<div id="J_Scratch_box" class="scratch-card-box">
				<img class="scard-cover" id="J_Scratch_cover" src="<#if (awards.awardsPicUrl)?has_content>${(awards.awardsPicUrl)!}<#else>/static/mobile/game/scratch_card/img/cover.png</#if>" alt=""/>
				<div class="scard-content" id="J_Scratch_content"></div>
			</div>
			<div id="J_Scratch_result" class="scratch-card-result">
				<div class="result-box result-none">
					<h3>谢谢惠顾</h3>
					<p>据说奖品君就在下一张，继续努力！</p>
					<div class="result-btn"><a href="javascript:void(0)">再刮一张</a></div>
				</div>
				<div class="result-box result-chance-over">
					<p>亲，你今天的刮奖次数已用完，请明天再来吧！</p>
					<div class="result-btn wx_btn_share"><a href="javascript:void(0)">分享游戏</a></div>
				</div>
				<div class="result-box result-win">
					<h3>恭喜中奖</h3>
					<p id="windTip"></p>
					<div class="result-btn"><a class="wx_btn_share" href="javascript:void(0)">分享给好友领取奖品</a></div>
				</div>
                <div class="result-box result-noPoint">
                    <h3>积分不足!</h3>
                    <p id="windTip">更多积分等你抢购，购买商品获取等额积分。</p>
                    <div class="result-btn"></div>
                </div>
                <div class="result-box result-noLogin">
                    <h3>还未登录</h3>
                    <p><a href="${ctx}/m/login.html?successUrl=${ctx}/m/game/${awards.id}.html">请先登录</a></p>
                </div>
                <div class="result-box result-noCusume">
                    <h3>Sorry~</h3>
                    <p>亲，您的消费额还没达到抽奖要求，更多商品等你<a href="/m/products/0.html?q=">选购！</a></p>
                </div>
                <div class="result-box result-limit">
                    <h3>超出中奖次数</h3>
                    <p>亲，不能太贪心哦~留一点奖品给小伙伴们~</p>
                </div>
                <div class="result-box result-end">
					<h3>Sorry~</h3>
					<p id="windTip">活动已经结束</p>
				</div>
			</div>

			<div class="scratch-card-rule">
				<div class="scard-rule-title"><span>活动规则</span></div>
				<div class="scard-rule-container">
					1、活动时间<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${(awards.startTime?string("yyyy-MM-dd"))!}- ${(awards.endTime?string("yyyy-MM-dd"))!}</p>
					2、刮开涂层，获得领取奖品资格，将游戏分享给好友，且有${(awards.shareLimit)!}个好友获得与你相同的奖品时，即可领取奖品，需在规定时间内分享给好友才能 领取奖品哦，加油!
				</div>
			</div>
			<a class="scard-btn-prize" href="${ctx}/m/awards/list?type=TURN">我的奖品</a>
			<a class="scard-btn-share wx_btn_share" href="javascript:void(0)">分享游戏</a>
		</div>
	</div>
</div>
<script>
	



	(function(cache_data){
        var url = "${ctx}/m/game/${(awards.id)!}.html";
		window.wxData = {
			img_url : [cache_data._pcUrl, cache_data._mobileLogo].join(""),
			link : url,
			title : "${gameName!}游戏分享",
			desc : "小伙伴们愉快地一起玩耍吧，更多好礼等你来拿！"
		};
	}(window.cache_data));
	$(function () {
		main();
		var cover = $('#J_Scratch_cover'),
				box = $('#J_Scratch_box'),
				content = $('#J_Scratch_content'),
				resultbox = $('#J_Scratch_result'),
				result_chance_over = resultbox.find('.result-chance-over'),
				result_win = resultbox.find('.result-win'),
				result_none = resultbox.find('.result-none'),
				result_login = resultbox.find('.result-noLogin'),
				result_noCusume = resultbox.find('.result-noCusume'),
                result_limit = resultbox.find('.result-limit'),
				result_noPoint = resultbox.find('.result-noPoint'),
				result_end = resultbox.find('.result-end'),
				result = 0;
        if(window.devicePixelRatio >= 3){
            cover.attr("src","${staticResourcePath}game/scratch_card/img/cover-big.png");
        }
		var resultTxt = [
			'据说奖品君就在下一张，继续努力！',
			'还没刮中，感觉再也不会爱了',
			'一直刮人家，好坏～好坏的～',
			'据说，吃包辣条能提高中奖率，你也试试！',
			'要不，换脚趾再来试试！'
		];
		var resultImg = {
			win : '<#if (awards.awardsPointPicUrl)?has_content>${(awards.awardsPointPicUrl)!}<#else>${staticResourcePath}game/scratch_card/img/emotion-win.png</#if>',
			none : [
				'${staticResourcePath}game/scratch_card/img/emotion-1.png',
				'${staticResourcePath}game/scratch_card/img/emotion-2.png',
				'${staticResourcePath}game/scratch_card/img/emotion-3.png',
				'${staticResourcePath}game/scratch_card/img/emotion-4.png'
			]
		};
		function startGame(){
			var result = 0;
			$('#J_Scratch_cover').eraser({
				completeRatio :.7,
				completeFunction : function () {
                    box.hide();
                    showResult(result);
                    this.isSendMsg = undefined;
				},
                progressFunction : function(radio){
					if (!this.isSendMsg) {
					<#if isLogin?has_content && !isLogin>
                        box.hide();
                        showResult(404)
                        return;
					</#if>
                        var consumeCount = ${(loginUser.totalConsumeAmt)?default(0)}, consume= ${(awards.consumeAmt)?default(0)};
                        if (consume > consumeCount) {
                            box.hide();
                            showResult(500)
                            return;
                        }
                        var oneDayTimes = +"${(awards.oneDayTimes)?default(10000)}", count = +"${count!}";
                        if (count >= oneDayTimes) {
                            box.hide();
                            showResult(-1)
                            return;
                        }
                        result = getResult("${(awards.id)!}");
                        setResultImg(result);
                        this.isSendMsg = 1;
					}
				}
			});
		}
		function showResult(type){
			switch(type){
				case 500 :
                    result_noCusume.show().animate({opacity:1});
                    break;
				case 404 :
                    result_login.show().animate({opacity:1});
					break;
				case 400 :
                    result_noPoint.show().animate({opacity:1});
					break;
				case -1 : result_chance_over.show().animate({opacity:1});
					break;
				case 1 : result_win.show().animate({opacity:1});
					break;
				case 303 :
                    result_limit.show().animate({opacity:1});
                    break;
               case 666 :
                   result_end.show().animate({opacity:1});
                   break;
				default :
					result_none.find('p').html(resultTxt[Math.floor(resultTxt.length*Math.random())]);
					result_none.show().animate({opacity:1});
			}
		}
		function restartGame(){
			resultbox.find('.result-box').hide().css('opacity',0);
			box.show();
			$('#J_Scratch_cover').eraser('reset');
		}

		function getResult(awardsId){
			var flag = 0;
			$.ajax({
				url : "/m/game/play",
                type : "POST",
				async : false,
				data : {id : awardsId},
				dataType : "json",
				success : function(data){
					if (data && data.data) {
						if (data.data.result == "winning") {
                            var text = data.data.tip;
							$("#windTip").text(text);
                            flag = 1;
						} else if (data.data.result == "nosession") {
							flag = 404;
						} else {
							if (data.data.tip && data.data.tip.indexOf("积分不够") > -1) flag = 400;
							if (data.data.tip && data.data.tip.indexOf("超过中奖次数") > -1) flag = 303;
							if (data.data.tip && data.data.tip.indexOf("活动已经结束") > -1) flag = 666;
						}
					}
				}
			});
			return flag;
		}

		function setResultImg(result){
			var img;
			if(result && result == 1){
				img = resultImg['win'];
			} else{
				img = resultImg['none'][Math.floor(resultImg['none'].length*Math.random())];
			}
			content.css('background-image','url('+ img +')');
		}

		startGame();

		result_none.find('.result-btn a').on('click', function () {
			restartGame();
		});
		
		app && app.showShareBtnBar(window["wxData"] || "");
        app.showShareBubble();


	});
	
	$(window).resize(function(){
		main();
	})
	
	

	function main(){
		var winHeight = document.documentElement.getBoundingClientRect().height,
			muiBarH = $(".mui-bar").height() || 0;
		$(".scratch-card-body").css("min-height",winHeight-muiBarH);
	}
</script>
</body>
</html>