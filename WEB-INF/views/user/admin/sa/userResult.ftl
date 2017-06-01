<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#--<#include "../../../../../includes/sa/header.ftl"/>-->
<#include "${ctx!}/includes/sa/header.ftl"/>
    <script>
        function goBack() {
        	if(${type!}=="0"){
        		window.open('${ctx}/admin/sa/user/disabledList','_self');
        	}else{
        		window.open('${ctx}/admin/sa/user/userList','_self');
        	}
            
        }
    </script>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/user/userList">会员管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">导入会员</li>
    </ul>
    <div class="flow-steps">
        <ol class="num4">
            <li class="current" id="first"><i class="num">√</i>导入会员清单文件</li>
            <li class="current" id="next"><i class="num">√</i>浏览会员信息</li>
            <li class="current" id="last"><i class="num">3</i>导入信息反馈</li>
        </ol>
    </div>
    <div class="row actions-bar">
        <div class="form-actions offset7">
            <span style="color: #ff0000;margin-right: 40px;"><b style="font-size: 20px;">导入成功!</b></span><button type="reset" class="button button-primary" onclick="javascript:goBack();">返回用户列表</button>
        </div>
    </div>
    <hr>
    <#if failureList?has_content>
        <b style="font-size: 20px;color: #808080">未导入会员列表</b>
        <br>
        <br>
        <table cellspacing="" class="table table-bordered">
            <thead>
            <tr>
                <th>手机号码</th>
                <th>密码</th>
                <th>用户姓名</th>
                <th>性别</th>
                <th>会员标签</th>
                <th>备注</th>
            </tr>
            </thead>
            <tbody>
                <#list failureList as one>
                <tr>
                    <td>${(one.phone)!}</td>
                    <td>${(one.password)!}</td>
                    <td>${(one.userName)!}</td>
                    <td style="color: #ff0000">${(one.sex)!}</td>
                    <td style="color: #ff0000">${(one.labelNames)!}</td>
                    <td style="color: #ff0000">${(one.result)!}</td>
                </tr>
                </#list>
            </tbody>
        </table>
    </#if>

</div>
</body>
</html>