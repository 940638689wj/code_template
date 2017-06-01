<#assign ctx = request.contextPath>


<div id="page">
    <div class="layout">
        <div class="pageinfo">
            <div class="infotitle">
                <s class="ico ico-error"></s>充值失败！
            </div>
            <div class="infocontent">
                ${paymentError!}
            </div>
            <div class="infobtnbar">
                <a href="${ctx}/account" class="btn">
                    <span>返回个人中心</span>
                </a>
            </div>
        </div>
    </div>
</div>