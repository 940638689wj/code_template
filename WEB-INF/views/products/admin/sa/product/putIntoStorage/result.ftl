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
            window.open('${ctx}/admin/sa/productManage/list?productStatusCd=1','_self');
        }
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
            <li class="current-prev"><i class="icon-ok"></i>导入商品入库单</li>
            <li class="current-prev"><i class="icon-ok"></i>预览确认</li>
            <li class="last current"><i class="num">3</i>入库结果</li>
        </ol>
    </div>
    <div class="row actions-bar">
        <div class="form-actions offset7">
            <span style="color: #ff0000;margin-right: 40px;"><b style="font-size: 20px;">导入成功!</b></span><button type="reset" class="button button-primary" onclick="javascript:goBack();">返回商品列表</button>
        </div>
    </div>
    <hr>
    <#if failureList?has_content>
        <b style="font-size: 20px;color: #808080">未导入商品列表</b>
        <br>
        <br>
        <table cellspacing="" class="table table-bordered">
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
            </tbody>
        </table>
    </#if>

</div>
</body>
</html>