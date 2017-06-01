<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
	<#assign staticPath = ctx + "/static">
    <link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/config.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/common/page.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

    <script type="text/javascript" src="${staticPath}/admin/js/weixin/emotion.js"></script>

    <meta charset="utf-8">
    <title></title>

	<style>
		td{
			border-left: 1px solid #ededed;
		}
	</style>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/wechat/keywordList">关键词列表</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">关键词回复内容</li>
    </ul>

    <ul class="toolbar">
            <li>
                <a class="button button-small button-primary" href="${ctx}/admin/sa/wechat/keywordReplyForm?eventConditionId=${(eventCondition.id)!}">新增回复</a>
            </li>
    </ul>

    <table id="tab1" cellspacing="0" class="table table-bordered" style="width: 1024px">
        <tr>
            <th>规则名称</th>
            <th>关键词</th>
            <th>回复内容</th>
            <th>类型</th>
            <th>操作</th>
        </tr>
        <#if messages??>
            <#list messages as msg>
                <tr>
                    <td width="10%">${(eventCondition.name)!}</td>
                    <td width="20%">${(eventCondition.keyword)!}</td>
                    <td width="40%">
                        <#if msg.msgType == "text">
                            ${(msg.content)!}
                        <#elseif msg.msgType == "news">
                            <#assign artList = articleMap[(msg.id)?string]/>
                            
							<#assign tempArt=artList?first/>
							<#if tempArt?has_content>
                                ${(tempArt.articleTitle)!}
							</#if>
							
                        </#if>
                    </td>
                    <td width="10%">
                        <#if msg.msgType == "text">
                            文本
                        <#elseif msg.msgType == "news">
                            图文
                        <#elseif msg.msgType == "image">
                            图片
                        <#elseif msg.msgType == "voice">
                            语音
                        <#elseif msg.msgType == "video">
                            视频
                        <#elseif msg.msgType == "link">
                            链接
                        </#if>
                    </td>
                    <td width="20%">
                        <#--<a href="#" onclick="openEditDialog('${(msg.id)}');">修改</a>&nbsp;&nbsp;-->
                        <a href="${ctx}/admin/sa/wechat/keywordReplyForm?eventConditionId=${(eventCondition.id)!}&initMsgId=${(msg.id)}">修改</a>&nbsp;&nbsp;
                        <a href="#" onclick="deleteReplyContent('${(eventCondition.id)!}','${(msg.id)!}');">删除</a>

                    </td>
                </tr>
            </#list>
        </#if>
    </table>
</div>

<script type="text/javascript">
	$(function(){
        $("#tab1 tr:gt(0)").each(function () {
            var msgType=$(this).find("td:eq(3)").text();
			if(msgType && msgType!="null")
			{
				if($.trim(msgType)=="文本")
				{
					$td=$(this).find("td:eq(2)");
					$td.html(Emotion.replaceEmoji($.trim($td.text())));
				}
			}
        });
	});

	//删除
    function deleteReplyContent(eventConditionId,initMsgId){
        BUI.Message.Confirm('确认要删除这条记录吗？',function(){
            $.ajax({
                url: "${ctx}/admin/sa/wechat/keywordReplyDelete?eventConditionId="+eventConditionId+"&initMsgId="+initMsgId,
                type:"get",
                dataType: "text",
                success: function(data){
                    if(data=="success"){
                        app.showSuccess("删除成功!");
                        app.page.open({
                            href:'${ctx}/admin/sa/wechat/keywordReplyList?id='+eventConditionId
                        });
                    }else{
                        app.showError("删除失败！");
                    }
                }
            });
        },'question');
	}

</script>
</body>
</html>