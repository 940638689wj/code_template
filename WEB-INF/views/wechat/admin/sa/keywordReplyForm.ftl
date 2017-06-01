<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">

	<#assign staticPath = ctx + "/static">
    <link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>

    <link rel="stylesheet" href="${staticPath}/admin/css/emotion.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/weixin/emotion.js"></script>

	<style>
        .txtArea {
            width: 350px;
        }
	</style>

</head>
<body class="container">
	<ul class="breadcrumb">
		<li><a href="${ctx}/admin/sa/wechat/keywordList">关键词列表</a> <span class="divider">&gt;&gt;</span></li>
		<li><a href="${ctx}/admin/sa/wechat/keywordReplyList?id=${(eventCondition.id)!}">关键词回复内容列表</a> <span class="divider">&gt;&gt;</span></li>
		<li class="active"><#if curInitMsg?has_content && curInitMsg.id?has_content>编辑回复内容<#else>添加回复内容</#if></li>
	</ul>

    <form id="keywordReplyForm" class="form-horizontal" action="${ctx}/admin/sa/wechat/keywordReplyForm" method="post">
        <input type="hidden" name="eventConditionId" value="${(eventCondition.id)!}">
        <input type="hidden" name="curInitMsgId" value="${(curInitMsg.id)!}">

        <div id="edit-div" class="form-content">
			<div class="row">
				<div class="control-group">
					<label class="control-label">关键词：</label>
					<div class="controls">
						${(eventCondition.keyword)!?html}
					</div>
				</div>
			</div>
			<div class="row">
				<div class="control-group">
					<label class="control-label">回复类型：</label>
					<div class="controls">
                        <select class="span6" name="msgType" id="msgType">
                            <option value="text" <#if (curInitMsg.msgType)?? && (curInitMsg.msgType) == "text">selected</#if>>文本</option>
                            <option value="news" <#if (curInitMsg.msgType)?? && (curInitMsg.msgType) == "news">selected</#if>>图文</option>
                        </select>
					</div>
				</div>
			</div>
			<div class="row" id="msg_text" <#if (curInitMsg.msgType)?? && (curInitMsg.msgType) == "news">style="display: none"</#if>>
				<div class="control-group">
					<label class="control-label">文本内容：</label>
                    <div class="controls control-row-auto">
                        <div class="txtArea">
							<div class="functionBar">
								<div class="opt">
									<a class="icon18C iconEmotion block" href="javascript:;">表情</a>
								</div>
								<div class="tip"></div>
								<div class="emotions">
									<table cellspacing="0" cellpadding="0">
									<tbody>
								<tr>
									<td><div class="eItem" style="background-position: 0px 0;"
											 data-title="微笑"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/0.gif"></div></td>
									<td><div class="eItem" style="background-position: -24px 0;"
											 data-title="撇嘴"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/1.gif"></div></td>
									<td><div class="eItem" style="background-position: -48px 0;"
											 data-title="色"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/2.gif"></div></td>
									<td><div class="eItem" style="background-position: -72px 0;"
											 data-title="发呆"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/3.gif"></div></td>
									<td><div class="eItem" style="background-position: -96px 0;"
											 data-title="得意"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/4.gif"></div></td>
									<td><div class="eItem" style="background-position: -120px 0;"
											 data-title="流泪"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/5.gif"></div></td>
									<td><div class="eItem" style="background-position: -144px 0;"
											 data-title="害羞"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/6.gif"></div></td>
									<td><div class="eItem" style="background-position: -168px 0;"
											 data-title="闭嘴"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/7.gif"></div></td>
									<td><div class="eItem" style="background-position: -192px 0;"
											 data-title="睡"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/8.gif"></div></td>
									<td><div class="eItem" style="background-position: -216px 0;"
											 data-title="大哭"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/9.gif"></div></td>
									<td><div class="eItem" style="background-position: -240px 0;"
											 data-title="尴尬"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/10.gif"></div></td>
									<td><div class="eItem" style="background-position: -264px 0;"
											 data-title="发怒"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/11.gif"></div></td>
									<td><div class="eItem" style="background-position: -288px 0;"
											 data-title="调皮"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/12.gif"></div></td>
									<td><div class="eItem" style="background-position: -312px 0;"
											 data-title="呲牙"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/13.gif"></div></td>
									<td><div class="eItem" style="background-position: -336px 0;"
											 data-title="惊讶"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/14.gif"></div></td>
								</tr>
								<tr>
									<td><div class="eItem" style="background-position: -360px 0;"
											 data-title="难过"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/15.gif"></div></td>
									<td><div class="eItem" style="background-position: -384px 0;"
											 data-title="酷"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/16.gif"></div></td>
									<td><div class="eItem" style="background-position: -408px 0;"
											 data-title="冷汗"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/17.gif"></div></td>
									<td><div class="eItem" style="background-position: -432px 0;"
											 data-title="抓狂"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/18.gif"></div></td>
									<td><div class="eItem" style="background-position: -456px 0;"
											 data-title="吐"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/19.gif"></div></td>
									<td><div class="eItem" style="background-position: -480px 0;"
											 data-title="偷笑"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/20.gif"></div></td>
									<td><div class="eItem" style="background-position: -504px 0;"
											 data-title="可爱"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/21.gif"></div></td>
									<td><div class="eItem" style="background-position: -528px 0;"
											 data-title="白眼"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/22.gif"></div></td>
									<td><div class="eItem" style="background-position: -552px 0;"
											 data-title="傲慢"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/23.gif"></div></td>
									<td><div class="eItem" style="background-position: -576px 0;"
											 data-title="饥饿"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/24.gif"></div></td>
									<td><div class="eItem" style="background-position: -600px 0;"
											 data-title="困"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/25.gif"></div></td>
									<td><div class="eItem" style="background-position: -624px 0;"
											 data-title="惊恐"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/26.gif"></div></td>
									<td><div class="eItem" style="background-position: -648px 0;"
											 data-title="流汗"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/27.gif"></div></td>
									<td><div class="eItem" style="background-position: -672px 0;"
											 data-title="憨笑"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/28.gif"></div></td>
									<td><div class="eItem" style="background-position: -696px 0;"
											 data-title="大兵"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/29.gif"></div></td>
								</tr>
								<tr>
									<td><div class="eItem" style="background-position: -720px 0;"
											 data-title="奋斗"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/30.gif"></div></td>
									<td><div class="eItem" style="background-position: -744px 0;"
											 data-title="咒骂"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/31.gif"></div></td>
									<td><div class="eItem" style="background-position: -768px 0;"
											 data-title="疑问"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/32.gif"></div></td>
									<td><div class="eItem" style="background-position: -792px 0;"
											 data-title="嘘"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/33.gif"></div></td>
									<td><div class="eItem" style="background-position: -816px 0;"
											 data-title="晕"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/34.gif"></div></td>
									<td><div class="eItem" style="background-position: -840px 0;"
											 data-title="折磨"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/35.gif"></div></td>
									<td><div class="eItem" style="background-position: -864px 0;"
											 data-title="衰"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/36.gif"></div></td>
									<td><div class="eItem" style="background-position: -888px 0;"
											 data-title="骷髅"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/37.gif"></div></td>
									<td><div class="eItem" style="background-position: -912px 0;"
											 data-title="敲打"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/38.gif"></div></td>
									<td><div class="eItem" style="background-position: -936px 0;"
											 data-title="再见"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/39.gif"></div></td>
									<td><div class="eItem" style="background-position: -960px 0;"
											 data-title="擦汗"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/40.gif"></div></td>
									<td><div class="eItem" style="background-position: -984px 0;"
											 data-title="抠鼻"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/41.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1008px 0;" data-title="鼓掌"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/42.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1032px 0;" data-title="糗大了"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/43.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1056px 0;" data-title="坏笑"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/44.gif"></div></td>
								</tr>
								<tr>
									<td><div class="eItem"
											 style="background-position: -1080px 0;" data-title="左哼哼"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/45.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1104px 0;" data-title="右哼哼"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/46.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1128px 0;" data-title="哈欠"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/47.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1152px 0;" data-title="鄙视"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/48.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1176px 0;" data-title="委屈"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/49.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1200px 0;" data-title="快哭了"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/50.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1224px 0;" data-title="阴险"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/51.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1248px 0;" data-title="亲亲"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/52.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1272px 0;" data-title="吓"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/53.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1296px 0;" data-title="可怜"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/54.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1320px 0;" data-title="菜刀"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/55.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1344px 0;" data-title="西瓜"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/56.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1368px 0;" data-title="啤酒"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/57.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1392px 0;" data-title="篮球"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/58.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1416px 0;" data-title="乒乓"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/59.gif"></div></td>
								</tr>
								<tr>
									<td><div class="eItem"
											 style="background-position: -1440px 0;" data-title="咖啡"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/60.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1464px 0;" data-title="饭"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/61.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1488px 0;" data-title="猪头"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/62.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1512px 0;" data-title="玫瑰"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/63.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1536px 0;" data-title="凋谢"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/64.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1560px 0;" data-title="示爱"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/65.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1584px 0;" data-title="爱心"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/66.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1608px 0;" data-title="心碎"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/67.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1632px 0;" data-title="蛋糕"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/68.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1656px 0;" data-title="闪电"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/69.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1680px 0;" data-title="炸弹"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/70.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1704px 0;" data-title="刀"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/71.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1728px 0;" data-title="足球"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/72.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1752px 0;" data-title="瓢虫"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/73.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1776px 0;" data-title="便便"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/74.gif"></div></td>
								</tr>
								<tr>
									<td><div class="eItem"
											 style="background-position: -1800px 0;" data-title="月亮"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/75.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1824px 0;" data-title="太阳"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/76.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1848px 0;" data-title="礼物"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/77.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1872px 0;" data-title="拥抱"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/78.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1896px 0;" data-title="强"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/79.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1920px 0;" data-title="弱"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/80.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1944px 0;" data-title="握手"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/81.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1968px 0;" data-title="胜利"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/82.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -1992px 0;" data-title="抱拳"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/83.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2016px 0;" data-title="勾引"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/84.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2040px 0;" data-title="拳头"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/85.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2064px 0;" data-title="差劲"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/86.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2088px 0;" data-title="爱你"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/87.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2112px 0;" data-title="NO"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/88.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2136px 0;" data-title="OK"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/89.gif"></div></td>
								</tr>
								<tr>
									<td><div class="eItem"
											 style="background-position: -2160px 0;" data-title="爱情"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/90.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2184px 0;" data-title="飞吻"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/91.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2208px 0;" data-title="跳跳"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/92.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2232px 0;" data-title="发抖"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/93.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2256px 0;" data-title="怄火"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/94.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2280px 0;" data-title="转圈"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/95.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2304px 0;" data-title="磕头"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/96.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2328px 0;" data-title="回头"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/97.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2352px 0;" data-title="跳绳"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/98.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2376px 0;" data-title="挥手"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/99.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2400px 0;" data-title="激动"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/100.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2424px 0;" data-title="街舞"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/101.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2448px 0;" data-title="献吻"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/102.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2472px 0;" data-title="左太极"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/103.gif"></div></td>
									<td><div class="eItem"
											 style="background-position: -2496px 0;" data-title="右太极"
											 data-gifurl="${staticPath}/admin/images/wx_emotion/104.gif"></div></td>
								</tr>
								</tbody>
								</table>
									<div class="emotionsGif"></div>
								</div>
								<div class="clr"></div>
							</div>

							<div class="editArea">
								<textarea id="content" name="content" style="display: none;">${(curInitMsg.content)!}</textarea>
								<div contenteditable="true" style="overflow-y: auto; overflow-x: hidden;"></div>
							</div>
                        </div>

                        <script type="text/javascript">
                            var $textarea = $(".editArea textarea");
                            var $contentDiv = $(".editArea div");
                            $(".functionBar .iconEmotion").click(function(){
                                //Emotion.saveRange();
                                $(".emotions").show();
                            });
                            $(".emotions").hover(function(){

                            },function(){
                                $(".emotions").fadeOut();
                            });
                            $(".emotions .eItem").mouseenter(function(){
                                $(".emotionsGif").html('<img src="'+$(this).attr("data-gifurl")+'">');
                            }).click(function(){
                                        Emotion.insertHTML('<img src="' + $(this).attr("data-gifurl") + '"' + 'alt="mo-' + $(this).attr("data-title") + '"' + "/>");
                                        $(".emotions").fadeOut();
                                        $textarea.trigger("contentValueChange");
                                    });
                            $contentDiv.bind("keyup",function(){
                                $textarea.trigger("contentValueChange");
                                Emotion.saveRange();
                            }).bind("keydown",function(e){
                                        switch (e.keyCode) {
                                            case 8:
                                                var t = Emotion.getSelection();
                                                t.type && t.type.toLowerCase() === "control" && (e.preventDefault(), t.clear());
                                                break;
                                            case 13:
                                                e.preventDefault(),
                                                        Emotion.insertHTML("<br/>");
                                                Emotion.saveRange();
                                        }
                                    }).bind("mouseup",function(e){
                                        Emotion.saveRange();
                                        if ($.browser.msie && />$/.test($contentDiv.html())) {
                                            var n = Emotion.getSelection();
                                            n.extend && (n.extend(cursorNode, cursorNode.length), n.collapseToEnd()),
                                                    Emotion.saveRange();
                                            Emotion.insertHTML(" ");
                                        }
                                    });
                            $textarea.bind("contentValueChange",function(){
                                $(this).val(Emotion.replaceInput($contentDiv.html()));
                            });
                            $contentDiv.html(Emotion.replaceEmoji($contentDiv.html()));
                        </script>
					</div>
				</div>
			</div>
			<div class="row" id="msg_news" <#if (curInitMsg.msgType)?? && (curInitMsg.msgType) == "news"><#else>style="display: none"</#if>>
				<div class="control-group">
					<label class="control-label">图文资源：</label>
                    <div class="controls">
                        <select class="span6" name="newsId" id="newsId">
							<#list initMsgList as initMsg>
							<#if articleMap[(initMsg.id)?string]??>
								<#assign artList = articleMap[(initMsg.id)?string]/>
							
								<#assign tempArt=artList?first/>
								<#if tempArt?has_content>
                                    <option value="${initMsg.id}" <#if (curInitMsg)?? && (curInitMsg.id == initMsg.id)>selected</#if>>${(tempArt.articleTitle)!}</option>
								</#if>
								</#if>
							</#list>
                        </select>
                        &nbsp;&nbsp;<a href="${ctx}/admin/sa/wechat/showMedia" class="button">管理图文素材</a>
					</div>
				</div>
			</div>
        </div>
        <div class="actions-bar">
            <div class="form-actions">
				<div class="offset3 ">
					<button type="submit" class="button button-primary">保存</button>
					<button type="reset" class="button" id="reset">重置</button>
				</div>
			</div>
        </div>
    </form>

    <script language="javascript" type="text/javascript">
        $(function(){
            //初始化数据
            $contentDiv.html(Emotion.replaceEmoji($textarea.val()));

            //回复类型切换界面
            $("#keywordReplyForm").delegate("#msgType", "change", function() {
                var selectedVal = $("#msgType").val();
                if(selectedVal == "news")
                {
                    $("#msg_news").show();
                    $("#msg_text").hide();
                }else if(selectedVal == "text"){
                    $("#msg_text").show();
                    $("#msg_news").hide();
                }
            });
        });
        
        $('button[type="reset"]').click(function(){
	    	$contentDiv.html(Emotion.replaceEmoji($textarea.html()));
	    });
    </script>
</body>
</html>