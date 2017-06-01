<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>我的业绩</title>  
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">我的业绩</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="performancebar">
            <ul>
                <li><a href="javascript:void(0)"><h3>${(userConsumeCalc.userProductPoint)?default("0")}</h3><p>业绩点</p></a></li>
                <li><a href="${ctx}/m/account/performance/toDevelopCustomer"><i></i><p>发展客户</p></a></li>
            </ul>
        </div>
        <p class="pfm-tit"><i></i>我的客户<span></span></p>

        <div class="pfm-list">
            <div class="acitem ac-toggled">
                <div class="actit">
                    <div class="con"><a href="javascript:void(0);"><span class="num">(1)</span><i></i>V1会员</a></div>
                    <div class="ac-toggle-btn"></div>
                </div>
                <div class="accon">
                     <ul class="prd-catlist">
                        <li><a href="${ctx}/m/account/performance/toMyCustomerPerformanceDetails?userId=${(user.userId)!}"><i style="background-image: url(${(user.headPortraitUrl)!(userHead!)});"></i>${(user.phone)!}</a></li>
                    </ul>                  
                </div>
            </div>
            <div class="acitem ac-toggled">
                <div class="actit">
                    <div class="con"><a href="javascript:void(0);"><span class="num">(${lower2UserList?size})</span><i></i>V2会员</a></div>
                    <div class="ac-toggle-btn"></div>
                </div>
                <div class="accon">
                 	<#if lower2UserList?? && lower2UserList?has_content>
                    <ul class="prd-catlist">
                		<#list lower2UserList as user>
                    		<li><a href="${ctx}/m/account/performance/toMyCustomerPerformanceDetails?userId=${user.userId}"><i style="background-image: url(${(user.headPortraitUrl)!(userHead!)});"></i>${(user.phone)!}</a></li>
               			</#list>
                    </ul>
                    <#else>
	                     <div class="iconinfo">
	                        <div class="ico ico-info"></div>
	                        <strong>很遗憾，您还没有<br>打造属于您的关系网！</strong>
	                        <div class="btnbar">
	                            <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m/account/performance/toDevelopCustomer">去发展您的关系网</a>
	                        </div>
	                    </div>                   
                    </#if>
                </div>
            </div>
            <div class="acitem ac-toggled">
                <div class="actit">
                    <div class="con"><a href="javascript:void(0);"><span class="num">(${lower3UserList?size})</span><i></i>V3会员</a></div>
                    <div class="ac-toggle-btn"></div>
                </div>
                <div class="accon">
                 	<#if lower3UserList?? && lower3UserList?has_content>
                    <ul class="prd-catlist">
                		<#list lower3UserList as user>
                    		<li><a href="${ctx}/m/account/performance/toMyCustomerPerformanceDetails?userId=${user.userId}"><i style="background-image: url(${(user.headPortraitUrl)!(userHead!)});"></i>${(user.phone)!}</a></li>
               			</#list>
                    </ul>
                    <#else>
	                     <div class="iconinfo">
	                        <div class="ico ico-info"></div>
	                        <strong>很遗憾，您还没有<br>打造属于您的关系网！</strong>
	                        <div class="btnbar">
	                            <a class="mui-btn mui-btn-primary mui-btn-block" href="${ctx}/m/account/performance/toDevelopCustomer">去发展您的关系网</a>
	                        </div>
	                    </div>                   
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        $(".actit").on("click",function() {
            var obj = $(this).closest(".acitem");
            if(obj.hasClass("ac-toggled")){
                $(".acitem").addClass("ac-toggled");
                obj.removeClass("ac-toggled");
            }else{
                obj.addClass("ac-toggled");
            }
        });
    })
</script>