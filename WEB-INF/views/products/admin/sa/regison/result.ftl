<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <#include "${ctx!}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/adminProduct.html">区域管理</a> <span class="divider">&gt;&gt;</span></li>
        <li class="active">区域入库</li>
    </ul>
    <div class="flow-steps">
        <ol class="num4">
            <li class="current-prev"><i class="icon-ok"></i>导入区域入库单</li>
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
        <b style="font-size: 20px;color: #808080">未导入区域列表</b>
        <br>
        <br>
        <table cellspacing="" class="table table-bordered">
            <thead>
            <tr>
                <th>县/区</th>
                <th>镇</th>
                <th>村</th>
            </tr>
            </thead>
            <tbody>
                <#list failureList as one>
                <tr>
                    <td>${(one.county)!}</td>
                    <td>${(one.town)!}</td>
                    <td>${(one.village)!}</td>
                </tr>
                </#list>
            </tbody>
        </table>
    </#if>
</div>
</body>
<script type="text/javascript">
	
    function goBack() {
       window.location.href="${ctx}/admin/sa/regisonProductManage/list";
    }
</script>
</html>