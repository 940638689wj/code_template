<#assign ctx = request.contextPath>
<#assign pcLogo = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcLogo()?default("")>
<#assign topLeft = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getTopLeftHtml(templateType)?default("")>
<#assign topRight = Static["cn.yr.chile.common.helper.SiteTemplateHelper"].getTopRightHtml(templateType)?default("")>
<div id="header">
    <div class="topbox">
        <div class="top-container">
            <div class="toptools">
                ${topLeft!}
            </div>
            <div class="toplinks">
            <#if userLoginDTO?? && userLoginDTO?has_content>
                <p class="topwelcome"><a href="${ctx}/account">${(userLoginDTO.phone)!}</a> 您好！</p>
                <p><a href="javascript:logout();">退出</a></p>
            <#else>
                <p><a href="${ctx}/login">登录</a></p>
                <p><a href="${ctx}/register">注册</a></p>
            </#if>
                ${topRight!}
            </div>
        </div>
    </div>
<#include "cart.ftl"/>
<#include "nav.ftl"/>
</div>

<script>
    $(".toptool-closed").hover( <#--处理顶部鼠标移上去出现层-->
            function () {
                $(this).toggleClass("toptool-closed toptool-opened");
            }
    );
    $(function () {
        $('.header-store').hover(function () {
            $(this).addClass("header-store-hover");
        }, function () {
            $(this).removeClass("header-store-hover");
        });
    })

    function logout() {
        layer.confirm("您确定要退出吗？", function () {
            $.ajax({
                url: '${ctx}/account/logout',
                dataType: 'json',
                type: 'GET',
                success: function (data) {
                    if (data) {
                        location.href = "${ctx}/account";
                    } else {
                        layer.msg('退出失败!');
                    }
                }
            });
        });
    }
</script>