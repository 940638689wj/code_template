<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">

<#assign errorMsg_ = ""/>

<#if errorMsg?? && errorMsg?has_content>
    <#assign errorMsg_ = errorMsg/>
</#if>

<div id="page">
    <div class="toolbar">
        <a href="javascript:history.back()">返回</a>
        <h2>访问出错</h2>
    </div>
    <div class="container">
        <div class="iconinfo info-500">
            <i class="ico ico-globe"></i>
            <#if errorMsg_?has_content>
                <h1>${errorMsg_}</h1>
            <#else>
                <h1>抱歉！系统繁忙,<br>暂时无法处理您的请求......</h1>
                <p>
                    <span>可能因为：</span>
                    <em><i></i>网络信号弱</em>
                    <em><i></i>网络暂时出现问题</em>
                </p>
            </#if>
            <div class="btnbar">
                <a href="${ctx}/m" class="button">返回首页</a>
            </div>
        </div>

    </div>
</div>