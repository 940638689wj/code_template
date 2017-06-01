<#assign ctx = request.contextPath>
<#list userNameMap?keys as key>
<p><span class="awuser">${key}</span><span class="awprize">${userNameMap["${key}"]}</span></p>
</#list>

