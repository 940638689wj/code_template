<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/><!DOCTYPE HTML>
<html>
<head>
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
    <ul class="breadcrumb">
        <li><a href="/admin/sa/wechat/userList">微信用户管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">用户详细信息</li>
    </ul>
    <form id="J_Form" class="form-horizontal" action="menuForm" method="post">
        <div id="menuForm" class="form-content">
            <div class="row">
                <div class="control-group">
                    <label class="control-label">openId：</label>
                    <div class="controls">
                        ${(wxUser.openId)!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">昵称：</label>
                    <div class="controls">
                        ${(wxUser.nickName)!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">所在分组：</label>
                    <div class="controls">
                        ${(wxUser.groupName)!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">性别：</label>
                    <div class="controls">
                        <#if wxUser.sexCd == 0>
                            未知
                        <#elseif wxUser.sexCd == 1>
                            男
                        <#else>
                            女
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">关注时间：</label>
                    <div class="controls">
                    <#if (wxUser.subscribeTime)??>
                        ${subscribeTime!}
                        </#if>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">创建时间：</label>
                    <div class="controls">
                        <#if (wxUser.createTime)??>
                            ${(wxUser.createTime)?string('yyyy-MM-dd HH:mm:ss')}
                        </#if>
                    </div>
                </div>
            </div>

			<#--
            <div class="row">
                <div class="control-group">
                    <label class="control-label">所在城市：</label>
                    <div class="controls">
                        ${(wxUser.city)!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">所在省份：</label>
                    <div class="controls">
                        ${(wxUser.province)!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">所在国家：</label>
                    <div class="controls">
                        ${(wxUser.country)!}
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group">
                    <label class="control-label">头像：</label>
                    <div class="controls">
                        ${(wxUser.headimgurl)!}
                    </div>
                </div>
            </div>
            -->
    </div>
    <div class="actions-bar">
        <a href="/admin/sa/wechat/userList" class="button" >返回</a>
    </div>
    </form>
</div>

</body>
</html>