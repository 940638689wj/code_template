<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html>
<head>
    <title>我的奖品</title>
</head>
<body>
    <div id="page">
        <div class="toolbar">
            <a href="javascript:history.back()">返回</a>
            <h2>奖品详情</h2>
        </div>
        <div class="container">
            <div class="containerwrap">
                <h4>${awardsResult.awardsItemName?default("")} </h4>
                <hr/>
                <h5>配送信息</h5>
                <ul class="tbviewlist list-noborder">
                <#assign province=areaMap[awardsResult.provinceId?default("")]!""/>
                <#assign city=areaMap[awardsResult.cityId?default("")]!""/>
                <#assign county=areaMap[awardsResult.countyId?default("")]!""/>
                    <li>
                        <div class="hd">姓名：</div>
                        <div class="bd">${(user.userName)!}</div>
                    </li>
                    <li>
                        <div class="hd">地址：</div>
                        <div class="bd"><#if province?has_content>${(province.areaName)!}&nbsp;</#if>
                            <#if city?has_content>${(city.areaName)!}&nbsp;</#if>
                            <#if county?has_content>${(county.areaName)!}</#if>
                        ${(addrCombo)?default("")?html}
                        </div>
                    </li>
                    <li>
                        <div class="hd">电话：</div>
                        <div class="bd"><#if user.phone??>${user.phone!}</#if></div>
                    </li>
                    <li>
                        <div class="hd">状态：</div>
                        <div class="bd"><#if !awardsResult.status>末处理<#else>已处理</#if></div>
                    </li>
                    <div class="mainbtnbar">
                        <a href="${ctx}/m/turn/record.html?id=${awardsResult.id!}" class="button">修改</a>
                    </div>
                </ul>
                <hr/>
            </div>
        </div>
    </div>
</body>
</html>
