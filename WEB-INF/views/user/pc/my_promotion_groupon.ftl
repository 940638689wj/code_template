<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的团购券</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body class="page-login">
<#include "include/header.ftl"/>
<div :controller="app" class="ms-controller">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>我的钱包<span><em>_</em>我的团购券</span></h3></div>
            <div class="center-list">
                <table class="orderdatatb orderdatatb2">
                    <thead>
                    <tr>
                        <td class="td-status" width="20%">团购券名称</td>
                        <td class="td-status" width="10%">团购券ID</td>
                        <td class="td-status" width="20%">生效时间</td>
                        <td class="td-status" width="20%">过期时间</td>
                        <td class="td-status" width="5%">状态</td>
                        <td class="td-status" width="20%">领取时间</td>
                        <#--<td class="useStatus" width="5%">使用状态</td> -->
                        <#--<td class="td-operate">使用条件</td> -->
                    </tr>
                    </thead>
                </table>

                <div class="datawrap">
                    <table class="orderdatatb">
                        <tbody :for="groupon in @promotionGrouponList">
                        <tr>
                            <td class="td-status" width="20%">{{groupon.promotionName}}</td>
                            <td class="td-status" width="10%">{{groupon.couponCodeId}}</td>
                            <td class="td-status" width="20%">{{groupon.allowUseStartTime | date("yyyy-MM-dd")}}</td>
                            <td class="td-status" width="20%">{{groupon.allowUseEndTime | date("yyyy-MM-dd")}}</td>
                            <td class="td-status" width="5%">{{groupon.statusName}}</td>
                            <td class="td-status" width="20%">{{groupon.takeTime | date("yyyy-MM-dd")}}</td>

                        </tr>
                        </tbody>
                    </table>
                </div>
            </div>
           <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        </div>
    </div>
</div>
<#include "include/pager.ftl"/>
<script>
    $(function(){
         $("#menu_groupCoupon").addClass("current");

    })
    var vm = avalon.define({
        $id : 'app',
        pageNo: 1,
        pageSize: 5,
        pageCount: 0,
        promotionGrouponList:[],
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
            $.get('${ctx}/account/group/findListByLimit',{
                pageNo : vm.pageNo,
                pageSize : vm.pageSize

            },function(data){
                vm. promotionGrouponList = data.promotionGrouponList;
            })
        },
        getPageCount: function(){
            $.get('${ctx}/account/group/getPageCount',{},function(data){
                vm.pageCount = data.pageCount;
            })
        }
    })
    vm.$watch('onReady',function(){
        vm.getPageCount();
        vm.loadList();
    })
</script>
</body>
</html>