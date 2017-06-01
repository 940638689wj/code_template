<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <title>账户余额</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <link rel="stylesheet" href="${ctx}/static/css/fsboxer.css">
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
            <div class="content-titel"><h3>我的钱包<span><em>_</em>账户余额</span></h3></div>
                <p class="title">当前账户余额：￥<span class="price-real">${totalBalance?default(0)}</span></p>
                <div class="tbfilter">
                    <span>
                    <!--<input type="text" class="textfield input-date">&nbsp;<lable>至</lable>&nbsp;<input type="text" class="textfield input-date">&nbsp;<a href="#" class="button">查询</a>-->
                    </span>
                </div>
                <table class="orderdatatb">
                    <thead>
                    <tr>
                        <th width="30%">交易日期</th>
                    <#--<th width="10%">来源</th>-->
                    <#--<th width="14%">交易类型</th>-->
                    <#--<th width="14%">交易金额</th>-->
                        <th width="14%">余额明细</th>
                        <th class="tal">备注</th>
                    </tr>
                    </thead>
                    <tbody :for="userBalance in @userBalanceList">
                    <tr>
                        <td>{{userBalance.createTime | date("yyyy-MM-dd HH:mm:ss")}}</td>
                    <#--<td>微信</td>-->
                    <#--<td>购买商品</td>-->
                    <#--<td>¥599</td>-->
                            <td class="text-green" ms-if="userBalance.balanceIncome !=null">+{{userBalance.balanceIncome}}</td>
                            <td class="text-red" ms-if="userBalance.balanceExpend !=null">-{{userBalance.balanceExpend}}</td>
                      		 <td>{{userBalance.remark}}</td>
                    </tr>
                    </tbody>
                </table>
                <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
            </div>
        </div>
    </div>
</div>
<#include "include/pager.ftl"/>
<script>
    $(function () {
        $("#menu_balanceDetail").addClass("current");
    });
    var vm = avalon.define({
    	$id: 'app',
    	pageCount: 0,
    	pageNo: 1,
    	pageSize: 10,
    	userBalanceList: [],
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
    		$.get('${ctx}/account/userBalanceDetail/findListByLimit',{
    			pageNo:vm.pageNo,
    			pageSize:vm.pageSize
    		},function(data){
    			vm.userBalanceList = data.userBalanceDetailList;
    		})
    	},
    	getPageCount: function(){
    		$.get('${ctx}/account/userBalanceDetail/getPageCount',{},function(data){
    			console.log(data.pageCount)
    			vm.pageCount = data.pageCount;
    		})
    	}
    });
   vm.$watch('onReady', function () {
    	vm.getPageCount();
        vm.loadList();
    });
</script>
</body>
</html>