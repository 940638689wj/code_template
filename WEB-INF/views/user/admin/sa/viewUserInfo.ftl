<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="content-body">
    <form class="form-horizontal" method="post">
        <table cellspacing="0" class="table table-info">
            <tbody>
            <tr>
                <th>用户名：</th>
                <td>${(userInfoDTO.loginName)!}</td>
            </tr>
            <tr>
                <th>用户标签：</th>
                <td><#if labelList?? && labelList?has_content>
                		<#list labelList as label>
                			<div class="spec-item"><span>${label.name}</span><a href="javascript:deleteLabel(${(label.id)!},${(userInfoDTO.userId)!})">×</a></div>
                		</#list>
 	               	</#if>&nbsp;&nbsp;<a href='javascript:labelSelect(${(userInfoDTO.userId)!});'>+增加标签</a></td>
            </tr>				
            <!-- <tr>
                <th>姓名：</th>
                <td>${(userInfoDTO.userName)!}</td>
            </tr> -->
            <tr>
                <th>昵称：</th>
                <td>${(userInfoDTO.nickName)!}</td>
            </tr>
            <tr>
                <th>创建日期：</th>
                <td><#if (userInfoDTO.registerTime)??>${(userInfoDTO.registerTime)?string('yyyy-MM-dd HH:mm')}</#if></td>
            </tr>
            <tr>
                <th>最后登录日期：</th>
                <td><#if (userInfoDTO.lastLoginTime)??>${(userInfoDTO.lastLoginTime)?string('yyyy-MM-dd HH:mm')}</#if></td>
            </tr>
            <tr>
                <th>最后登录IP：</th>
                <td>${(userInfoDTO.lastLoginIp)!}</td>
            </tr>
            <tr>
                <th>消费金额：</th>
                <td>${(userInfoDTO.totalConsumeAmt)?default(0)}</td>
            </tr>
            <tr>
                <th>积分：</th>
                <td>${(userInfoDTO.totalScore)?default(0)}</td>
            </tr>

            <tr>
                <th>注册平台：</th>
                <td>
                    ${DICT('REGISTER_PLATFORM_CD','${(userInfoDTO.registerPlatformCd)!}')}
                </td>
            </tr>

            <tr>
                <th>推广会员：</th>
                <td>
                    <#if (userInfoDTO.mstoreStatusCd)?? && userInfoDTO.mstoreStatusCd?has_content && userInfoDTO.mstoreStatusCd == 1>
                        是
                    <#else>
                        否
                    </#if>
                </td>
            </tr>

            <tr>
                <th>会员卡号：</th>
                <td>
                    ${(userInfoDTO.phone)!}
                </td>
            </tr>
            </tbody>
        </table>
    </form>
    </div>
</div>

<div id="labelSelect" class="hide">
	<form class="form-horizontal">
		<div class="row">
			<div class="controls">
                    <select name="label" id="label">
                        <option value="">选择会员标签</option>
			            <#if labelAllList?? && labelAllList?has_content>
			                <#list labelAllList as item>
			                    <option value="${(item.id)!}">${(item.name)!}</option>
			                </#list>
			            </#if>
                    </select>
                </div>
		</div>
	</form>
</div>

</body>

</html>  