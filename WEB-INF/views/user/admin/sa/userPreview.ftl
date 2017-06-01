<!DOCTYPE html>
<#assign ctx = request.contextPath>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        function goToUploadFile(){
        	if(${type!}=="1"){
        		window.open('${ctx}/admin/sa/user/userList?type=${type!}','_self');
        	}else{
        		window.open('${ctx}/admin/sa/user/disabledList?type=${type!}','_self');
        	}
            
        }

        $(function(){
            $("#confirmBtn").click(function(){
                var hasFailureCount =false ;
                <#if failureList?has_content>
                    hasFailureCount=true ;
                </#if>
                if(hasFailureCount){
                    BUI.Message.Confirm("存在异常数据，是否导入？<br>&nbsp;&nbsp;(只导入无异常数据)",function(){
                        $("#confirmForm").submit();
                    })
                }else{
                    $("#confirmForm").submit();
                }
            });
        })
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
            <li class="current" id="next"><i class="num">2</i>浏览会员信息</li>
            <li  id="last"><i class="num">3</i>导入信息反馈</li>
        </ol>
    </div>
    <form id="confirmForm" class="form-horizontal" method="post" action="${ctx}/admin/sa/userExcel/preview?type=${type!}">
        <table cellspacing="0" class="table table-bordered">
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
                <#if failureList?has_content>
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
                </#if>
                <#if skuList?has_content>
                    <#list skuList as one>
                    <tr>
                        <td>${(one.phone)!}</td>
                        <td>${(one.password)!}</td>
                        <td>${(one.userName)!}</td>
                        <td style="color: #ff0000">${(one.sex)!}</td>
                        <td style="color: #ff0000">${(one.labelNames)!}</td>
                        <td style="color: #ff0000">${(one.result)!}</td>
                    </tr>
                    </#list>
                </#if>
            </tbody>
        </table>
        <div class="row actions-bar">
            <div class="form-actions offset7">
                <button type="button" id="confirmBtn" class="button button-primary">下一步</button>
                <button type="reset" class="button" onclick="javascript:goToUploadFile();">返回</button>
            </div>
        </div>
    </form>
</div>
</body>
</html>