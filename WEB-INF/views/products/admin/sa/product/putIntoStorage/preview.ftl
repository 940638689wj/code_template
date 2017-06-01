<!DOCTYPE html>
<#assign ctx = request.contextPath>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript">
        function goToUploadFile(){
            window.open('${ctx}/admin/sa/putIntoStock','_self');
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
        <li><a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">商品管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">商品入库</li>
    </ul>
    <div class="flow-steps">
        <ol class="num4">
            <li  class="current-prev"><i class="icon-ok"></i>导入商品入库单</li>
            <li  class="current"><i class="num">2</i>预览确认</li>
            <li  class="last"><i class="num">3</i>入库结果</li>
        </ol>
    </div>
    <form id="confirmForm" class="form-horizontal" method="post" action="${ctx}/admin/sa/putIntoStock/preview">
        <table cellspacing="0" class="table table-bordered">
            <thead>
                <tr>
                    <th>商品名称</th>
                    <th>商品外部编号</th>
                    <th>现库存</th>
                    <th>入库数量</th>
                    <th>入库后总量</th>
                    <th>备注</th>
                </tr>
            </thead>
            <tbody>
                <#if failureList?has_content>
                    <#list failureList as one>
                    <tr>
                        <td>${(one.productName)!}</td>
                        <td>${(one.skuOuterId)!}</td>
                        <td>${(one.preQuantity)!}</td>
                        <td style="color: #ff0000">${(one.quantity)!}</td>
                        <td style="color: #ff0000">${(one.nowQuantity)!}</td>
                        <td style="color: #ff0000">${(one.result)!}</td>
                    </tr>
                    </#list>
                </#if>
                <#if skuList?has_content>
                    <#list skuList as one>
                    <tr>
                        <td>${(one.productName)!}</td>
                        <td>${(one.skuOuterId)!}</td>
                        <td>${(one.preQuantity)!}</td>
                        <td style="color: #ff0000">${(one.quantity)!}</td>
                        <td style="color: #ff0000">${(one.nowQuantity)!}</td>
                        <td style="color: #27800b">${(one.result)!}</td>
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