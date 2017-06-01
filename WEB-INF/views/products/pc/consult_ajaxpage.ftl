<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<ul>
    <#if (consultDetailList?size > 0)>
        <#list consultDetailList as consultDetail>
            <li class="consultdetail">
                <div class="ask clearfix">
                    <dl>
                        <dt>提问：</dt>
                        <dd>${consultDetail.content?html}</dd>
                    </dl>
                    <span>提问者：
                        ${consultDetail.userName?html}
                    </span>
                </div>
                    <div class="answer clearfix">
                        <dl>
                            <dt>回答：</dt>
                            <dd>${consultDetail.replyContent!?html}</dd>
                        </dl>
                        <span>回答者：【客服】${(consultDetail.replyTime)?string("yyyy-MM-dd")}</span>
                    </div>
            </li>
        </#list>
    <#else>
        <li style="text-align: center; padding-left: 0px;">当前无相关咨询</li>
    </#if>

</ul>