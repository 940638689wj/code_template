<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>

	<#assign staticPath = ctx + "/static">
    <link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
	<script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

	<link rel="stylesheet" href="${staticPath}/admin/css/emotion.css" type="text/css"/>
	<script type="text/javascript" src="${staticPath}/admin/js/weixin/emotion.js"></script>
</head>

<body>
<div class="container">

<#if msg?? && msg?has_content>
<div style="text-align: center;margin-top: 50px">
    <h1>${msg!}</h1>
</div>
<#else>

<form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/wechat/menuForm" method="post">
<input type="hidden" name="id" value="${(menu.menuId)!}"/>
<input type="hidden" name="parentId" value="${(parent.menuId)!}"/>
<input type="hidden" name="level" id="level" value="${level!}"/>
<input type="hidden" name="lev1Modify" value="${lev1Modify!}"/>

<div id="menuForm" class="form-content">
<#--判断是否新增-->
	<#if isAdd?? && isAdd>
    <div class="row">
        <div class="control-group">
            <label class="control-label"><s>*</s>菜单名称：</label>
            <div class="controls">
                <input value="${(menu.menuName)!}" name="name" id="name" type="text"
                       class="input-normal control-text">
            </div>
            <div class="tips tips-small tips-info tips-no-icon pull-left">
                <div class="tips-content">
					<#if level =="1">
                        一级菜单最多可输入4个汉字或8个字母
					<#else>
                        二级菜单最多可输入8个汉字或16个字母
					</#if>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="control-group">
            <label class="control-label"><s>*</s>排序：</label>
            <div class="controls">
                <input value="<#if (menu.menuSort)??>${menu.menuSort}<#else>0</#if>" name="sort" onblur="onbl(this)" id="sort" type="text"
                       class="input-normal control-text">
            </div>
            <div class="tips tips-small tips-info tips-no-icon pull-left">
                <div class="tips-content">
                    菜单将按排序值从小到大罗列
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="control-group">
            <label class="control-label"><s>*</s>类型：</label>
            <div class="controls">
                <select class="span4" name="type" id="type">
                    <option value="text" <#if (menu.menuType)?? && (menu.menuType) == "text">selected</#if>>文本</option>
                    <option value="news" <#if (menu.menuType)?? && (menu.menuType) == "news">selected</#if>>图文</option>
                    <option value="link" <#if (menu.menuType)?? && (menu.menuType) == "link">selected</#if>>外链</option>
                    <#--<option value="appmall" <#if (menu.menuType)?? && (menu.menuType) == "appmall">selected</#if>>应用商城</option>-->
                </select>
            </div>
        </div>
    </div>
    <div class="row" id="msg_text">
        <div class="control-group">
            <label class="control-label"><s>*</s>文本内容：</label>
            <div class="controls control-row-auto">
                <#--<textarea name="textContent" style="margin: 0px; width: 300px; height: 100px;" id="textContent"><#if (menu.menuType)?? && (menu.menuType) == "text">${(menu.menuData)!}</#if></textarea>-->
				<div class="txtArea" style="width: 400px">
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
							<textarea id="textContent" name="textContent" style="display: none;"><#if (menu.menuType)?? && (menu.menuType) == "text">${(menu.menuData)!}</#if></textarea>
							<div contenteditable="true" style="overflow-y: auto; overflow-x: hidden;"></div>
						</div>
            	</div>
        	</div>
    	</div>
	</div>
    <div class="row" id="msg_news" style="display: none">
        <div class="control-group">
            <label class="control-label"><s>*</s>图文资源：</label>
            <div class="controls control-row-auto">
                <select class="span4" name="newsId" id="newsId">
					<#list initMsgList as initMsg>
							<#if articleMap[(initMsg.id)?string]??>
								<#assign artList = articleMap[(initMsg.id)?string]/>
							
								<#assign tempArt=artList?first/>
								<#if tempArt?has_content>
                                    <option value="${initMsg.id}" <#if menu?? ><#if (menu.menuData== "${initMsg.id}")>selected</#if></#if>>${(tempArt.articleTitle)!}</option>
								</#if>
								</#if>
							</#list>
                </select>
                &nbsp;&nbsp;<a href="#" class="button" onclick="manageNews();">管理图文素材</a>
            </div>
        </div>
    </div>
    <div class="row" id="msg_link" style="display: none">
        <div class="control-group">
            <label class="control-label"><s>*</s>页面URL：</label>
            <div class="controls control-row-auto">
                <input value="<#if (menu.menuType)?? && (menu.menuType) == "link">${(menu.menuData)!}</#if>" name="link" id="link" type="text"
                       class="input-large control-text">
            </div>
            <div class="tips tips-small tips-info tips-no-icon pull-left">
                <div class="tips-content">(必填,必须是以http://开头的URL格式)</div>
            </div>
        </div>
    </div>
    <div class="row" id="msg_appmall" style="display: none">
        <div class="control-group">
            <label class="control-label"><s>*</s>选择应用：</label>
            <div class="controls control-row-auto">
				<#if appMalls??>
					<#assign radioValue=(menu.menuData)?default('')/>
					<#assign count=1/>
					<#list appMalls as item>
						<#if (item_index+1)%5 == 0>
                            </br>
                            <label class="radio">
                                <input type="radio" <#if count==1>checked="checked"</#if>  name="appMallId" value="${item.id}" <#if radioValue == item.id?string>checked="checked" </#if>/>${(item.name)!}
                                &nbsp;&nbsp;&nbsp;
                            </label>
						<#else>
                            <label class="radio">
                                <input type="radio" <#if count==1>checked="checked"</#if>  name="appMallId" value="${item.id}" <#if radioValue == item.id?string>checked="checked" </#if>/>${(item.name)!}
                                &nbsp;&nbsp;&nbsp;
                            </label>
						</#if>
						<#assign count=count+1/>
					</#list>
				</#if>
            </div>
        </div>
    </div>
	<#else>
	<#--修改-->
    <div class="row">
        <div class="control-group">
            <label class="control-label"><s>*</s>菜单名称：</label>
            <div class="controls">
                <input value="${(menu.menuName)!}" name="name" id="name" type="text"
                       class="input-normal control-text">
            </div>
            <div class="tips tips-small tips-info tips-no-icon pull-left">
                <div class="tips-content">
					<#if level =="1">
                        一级菜单可输入4个汉字或8个字母
					<#else>
                        二级菜单可输入8个汉字或16个字母
					</#if>
                </div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="control-group">
            <label class="control-label"><s>*</s>排序：</label>
            <div class="controls">
                <input value="<#if (menu.menuSort)??>${menu.menuSort}<#else>0</#if>" name="sort" onblur="onbl(this)" id="sort" type="text"
                       class="input-normal control-text">
            </div>
            <div class="tips tips-small tips-info tips-no-icon pull-left">
                <div class="tips-content">
                    菜单将按排序值从小到大罗列
                </div>
            </div>
        </div>
    </div>
    <div class="row" <#if level =="1" && lev1Modify?? && lev1Modify=="false">style="display: none" </#if>>
        <div class="control-group">
            <label class="control-label"><s>*</s>类型：</label>
            <div class="controls">
                <select class="span4" name="type" id="type">
                    <option value="text" <#if (menu.menuType)?? && (menu.menuType) == "text">selected</#if>>文本</option>
                    <option value="news" <#if (menu.menuType)?? && (menu.menuType) == "news">selected</#if>>图文</option>
                    <option value="link" <#if (menu.menuType)?? && (menu.menuType) == "link">selected</#if>>外链</option>
                    <#--<option value="appmall" <#if (menu.menuType)?? && (menu.menuType) == "appmall">selected</#if>>应用商城</option>-->
                </select>
            </div>
        </div>
    </div>
    <div class="row" id="msg_text" <#if level =="1" && lev1Modify?? && lev1Modify=="false">style="display: none" </#if> <#if (menu.menuType)?? && ((menu.menuType) == "news" || (menu.menuType) == "link" || (menu.menuType) == "appmall")>style="display: none"</#if>>
        <div class="control-group">
            <label class="control-label"><s>*</s>文本内容：</label>
            <div class="controls control-row-auto">
                <#--<textarea name="textContent" style="margin: 0px; width: 300px; height: 100px;" id="textContent"><#if (menu.menuType)?? && (menu.menuType) == "text">${(menu.menuData)!}</#if></textarea>-->
                <div class="txtArea" style="width: 400px">
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
						<textarea id="textContent" name="textContent" style="display: none;"><#if (menu.menuType)?? && (menu.menuType) == "text">${(menu.menuData)!}</#if></textarea>
						<div contenteditable="true" style="overflow-y: auto; overflow-x: hidden;"></div>
					</div>
                </div>
            </div>
        </div>
    </div>
    <div class="row" id="msg_news" <#if level =="1" && lev1Modify?? && lev1Modify=="false">style="display: none" </#if> <#if (menu.menuType)?? && (menu.menuType) == "news"><#else>style="display: none"</#if>>
        <div class="control-group">
            <label class="control-label"><s>*</s>图文资源：</label>
            <div class="controls control-row-auto">
                <select class="span4" name="newsId" id="newsId">
					<#list initMsgList as initMsg>
							<#if articleMap[(initMsg.id)?string]??>
								<#assign artList = articleMap[(initMsg.id)?string]/>
								<#assign tempArt=artList?first/>
								<#if tempArt?has_content>
                                    <option value="${initMsg.id}"<#if menu?? ><#if (menu.menuData== "${initMsg.id}")>selected</#if></#if>>${(tempArt.articleTitle)!}</option>
								</#if>
								</#if>
							</#list>
                </select>
                &nbsp;&nbsp;<a href="#" class="button" onclick="manageNews();">管理图文素材</a>
            </div>
        </div>
    </div>
    <div class="row" id="msg_link" <#if level =="1" && lev1Modify?? && lev1Modify=="false">style="display: none" </#if> <#if (menu.menuType)?? && (menu.menuType) == "link"><#else>style="display: none"</#if>>
        <div class="control-group">
            <label class="control-label"><s>*</s>页面URL：</label>
            <div class="controls control-row-auto">
                <input value="<#if (menu.menuType)?? && (menu.menuType) == "link">${(menu.menuData)!}</#if>" name="link" id="link" type="text"
                       class="input-large control-text">
            </div>
            <div class="tips tips-small tips-info tips-no-icon pull-left">
                <div class="tips-content">(必填,必须是以http://开头的URL格式)</div>
            </div>
        </div>
    </div>
    <div class="row" id="msg_appmall" <#if level =="1" && lev1Modify?? && lev1Modify=="false">style="display: none" </#if> <#if (menu.menuType)?? && (menu.menuType) == "appmall"><#else>style="display: none"</#if>>
        <div class="control-group">
            <label class="control-label"><s>*</s>选择应用：</label>
            <div class="controls control-row-auto">
				<#if appMalls??>
					<#assign radioValue=(menu.menuData)?default('')/>
					<#list appMalls as item>
						<#if (item_index+1)%5 == 0>
                            </br>
                            <label class="radio">
                                <input type="radio"  name="appMallId" value="${item.id}" <#if radioValue == item.id?string>checked="checked" </#if>/>${(item.name)!}
                                &nbsp;&nbsp;&nbsp;
                            </label>
						<#else>
                            <label class="radio">
                                <input type="radio"  name="appMallId" value="${item.id}" <#if radioValue == item.id?string>checked="checked" </#if>/>${(item.name)!}
                                &nbsp;&nbsp;&nbsp;
                            </label>
						</#if>
					</#list>
				</#if>
            </div>
        </div>
    </div>
	</#if>

</div>

<div class="actions-bar">
    <div class="form-actions">
        <a id="submitbtn" class="button button-primary">保存</a>
    </div>
</div>
</form>
</#if>

</div>

<script type="text/javascript">

    $(function(){
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
            var str1=$contentDiv.html();
            var str2=Emotion.replaceInput(str1);
            $(this).val(str2);
        });

        //$contentDiv.html(Emotion.replaceEmoji($contentDiv.html()));

        //初始化数据
		<#if (menu.menuType)?? && (menu.menuType) == "text">
			$("div#msg_text").show();
			$contentDiv.html(Emotion.replaceEmoji($textarea.val()));
		</#if>
    });

    $(function(){
        $("#J_Form").delegate("#type", "change", function() {
            var selectedVal = $("#type").val();
            if(selectedVal == "text")
            {
                $("#msg_news").hide();
                $("#msg_link").hide();
                $("#msg_appmall").hide();
                $("#msg_text").show();
            }else if(selectedVal == "news"){
                $("#msg_news").show();
                $("#msg_link").hide();
                $("#msg_appmall").hide();
                $("#msg_text").hide();
            }else if(selectedVal == "link"){
                $("#msg_news").hide();
                $("#msg_link").show();
                $("#msg_appmall").hide();
                $("#msg_text").hide();
            }else if(selectedVal == "appmall"){
                $("#msg_news").hide();
                $("#msg_link").hide();
                $("#msg_appmall").show();
                $("#msg_text").hide();
            }
        });

        //保存按钮
        $("#submitbtn").click(function() {

            var level=$('#level').val();
            var name=$('#name').val();
            var type=$('#type').val();

            //判断菜单名称
            if(name=='')
            {
                //alert('菜单名称不能为空');
                //app.showError("菜单名称不能为空！");
                BUI.Message.Alert("菜单名称不能为空！");
                return false;
            }

            //一级菜单可输入4个汉字或8个字母
            if(level=='1')
            {
                if(strlen(name)>8)
                {
                    //app.showError("一级菜单只能输入4个汉字或8个字母！");
                    BUI.Message.Alert("一级菜单只能输入4个汉字或8个字母！");
                    return false;
                }
            }else if(level=='2')
            {//二级菜单可输入8个汉字或16个字母
                if(strlen(name)>16)
                {
                    //app.showError("二级菜单只能输入8个汉字或16个字母！");
                    BUI.Message.Alert("二级菜单只能输入8个汉字或16个字母！");
                    return false;
                }
            }

            //判断选择的类型的内容
            if(type == "text")
            {
                if($.trim($("#textContent").val())==''){
                    //app.showError("文本内容不能为空！");
                    BUI.Message.Alert("文本内容不能为空！");
                    return false;
                }
            }else if(type == "news"){

            }else if(type == "link"){
                //页面URL
                var str= $('#link').val();
                str = str.match(/http:\/\/.+/);
                if (str == null){
                    //app.showError("输入的URL无效！");
                    BUI.Message.Alert("输入的URL无效！");
                    return false;
                }
            }else if(type == "appmall"){
                //var appMall=$("input[name='appMallId']");
                var appMall=$('input:radio[name="appMallId"]:checked').val();
                if(appMall==null){
                    //app.showError("请选择一个应用！");
                    BUI.Message.Alert("请选择一个应用！");
                    return false;
                }
            }

            var submitData = {};
            submitData.id="${(menu.menuId)!}";
            submitData.parentId="${(parent.menuId)!}";

            submitData.name=name;
            submitData.sort=$('#sort').val();

            submitData.type=type;
            submitData.textContent=$('#textContent').val();
            submitData.newsId=$('#newsId').val();
            submitData.link=$('#link').val();
            submitData.appMallId=$("input[name='appMallId']:checked").val();

            submitData.level="${level!}";
            submitData.lev1Modify="${lev1Modify!}";

            $("#submitbtn").attr("disabled", true);
            $.post('${ctx}/admin/sa/wechat/menuForm',submitData,function(data) {
                $("#submitbtn").removeAttr("disabled");
                if (data.result == "true") {
                    app.showSuccess("操作成功!");
                    app.page.open({
                        href:'${ctx}/admin/sa/wechat/menuList'
                    });
                } else {
                    app.showError(data.message || "操作失败");
                }
            },"json");
            return false;
        });
    });

    //计算字符串长度(可同时字母和汉字，字母占一个字符，汉字占2个字符)
    function strlen(str){
        var len = 0;
        for (var i=0; i<str.length; i++) {
            var c = str.charCodeAt(i);
            //单字节加1
            if ((c >= 0x0001 && c <= 0x007e) || (0xff60<=c && c<=0xff9f)) {
                len++;
            }
            else {
                len+=2;
            }
        }
        return len;
    }

    //管理图文素材
    function manageNews(){
        parent.location.href="${ctx}/admin/sa/wechat/showMedia";
    }
    //正则校验排序
    function onbl(e){
      var td = $(e).val();
      var reg =/^\+?[0-9]\d*$/;
       if(!reg.test(td)){
	          BUI.Message.Alert("输入值不合法,只能正整数!");
	          $(e).val("");  
	          return ;
	        }
    }
</script>
</body>
</html>