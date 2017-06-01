<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx!}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        function goToUploadFile(){
            window.open('/admin/adminProduct/setPrice','_self');
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
        <li><a href="/admin/adminProduct.html">区域管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">区域入库</li>
    </ul>
    <div class="flow-steps">
        <ol class="num4">
            <li  class="current-prev"><i class="icon-ok"></i>导入区域入库单</li>
            <li  class="current"><i class="num">2</i>预览确认</li>
            <li  class="last"><i class="num">3</i>入库结果</li>
        </ol>
    </div>
    <form id="confirmForm" class="form-horizontal" method="post" action="${ctx}/admin/sa/regisonProductManage/preview">
        <table cellspacing="0" class="table table-bordered">
            <thead>
                <tr>
                    <th>县/区</th>
                    <th>镇</th>
                    <th>村</th>
                </tr>
            </thead>
            <tbody>
                <#--<#if failureList?has_content>
                    <#list failureList as one>
                    <tr>
                        <td>${one.areaName}</td>
                    </tr>
                    </#list>
                </#if> -->
                <#if priceList?has_content>
                    <#list priceList as one>
                    <tr>
                        <td>${(one.county)!}</td>
                        <td>${(one.town)!}</td>
                        <td>${(one.village)!}</td>
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