<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的积分</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body class="page-login">
<div :controller="app" class="ms-controller">
<#include "include/header.ftl"/>
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>我的钱包<span><em>_</em>我的积分</span></h3></div>
            <p class="title">当前剩余积分：<span class="price-real">${totalScore!0}</span></p>
            <div class="payment">
                <div class="tabbox">
                    <ul class="tabbar">
                        <li class="selected"><a href="javascript:void(0);"><span>积分卡充值</span></a></li>
                    </ul>
                    <div class="tabcon">
                        <ul class="payform">
                            <li class="payform-item">
                                <div class="payform-hd">请输入充值卡号：</div>
                                <div class="payform-bd">
                                    <input type="text" id="cardNum" class="textfield">
                                </div>
                            </li>
                            <li class="payform-item">
                                <div class="payform-hd"> 请输入充值卡密码：</div>
                                <div class="payform-bd">
                                    <input type="password" id="cardPwd" class="textfield">
                                </div>
                            </li>
                        </ul>
                        <a class="v-btn" href="javascript:cardSubmit()">去充值</a>
                    </div>
                </div>
            </div>
            <div class="corder-tab">
                <ul>
                    <li :for="($index,typeName) in @typeNameList" :class="[@type == ($index+1) && 'current']">
                        <a href="javascript:void(0)" :click="@type = ($index+1)">
                            {{typeName}}
                        </a>
                    </li>
                <#--
                <li class="current"><a href="#">积分兑换</a></li>
                <li><a href="#">积分明细</a></li>
                -->
                </ul>
            </div>
            <table class="orderdatatb" :visible="@type == 1">
                <thead>
                <tr>
                    <th>兑换日期</th>
                    <th>订单号</th>
                    <th>兑换商品</th>
                    <th>数量</th>
                    <th>使用积分</th>
                    <th>使用现金</th>
                    <th>支付状态</th>
                </tr>
                </thead>
                <tbody>
                <tr :for="orderItem in @scoreList">
                    <td>{{orderItem.createTime |date("yyyy-MM-dd HH:mm:ss")}}</td>
                    <td>{{orderItem.orderNumber}}</td>
                    <td>{{orderItem.productName}}</td>
                    <td>{{orderItem.quantity}}</td>
                    <td>{{orderItem.payScoreAmt}}</td>
                    <td>{{orderItem.payCashAmt}}</td>
                    <td ms-visible="orderItem.orderPayStatus==2">已支付</td>
                    <td ms-visible="orderItem.orderPayStatus==1">未支付</td>
                </tr>
                </tbody>
            </table>
            <div class="viewprd" :visible="@type==1"><a href="${ctx}/products/point/list.html">查看全部积分兑换商品&gt;&gt;</a></div>
            <table class="orderdatatb" :visible="@type==2">
                <thead>
                <tr>
                    <th>积分日期</th>
                <#--<th>来源</th> -->
                    <th>类型</th>
                    <th>消费金额</th>
                    <th>本次获得积分</th>
                    <th>积分支出</th>
                </tr>
                </thead>
                <tbody>
                <tr :for="score in @scoreList">
                    <td>{{score.createTime | date("yyyy-MM-dd HH:mm:ss")}}</td>
                <#-- <td>微信</td>  -->
                    <td>{{score.codeCnName}}</td>
                    <td>{{score.consumeBalance?score.consumeBalance:0}}</td>
                    <td class="text-green" ms-text="score.scoreIncome?'+'+score.scoreIncome:''"></td>
                    <td class="text-red" ms-text="score.scoreExpend?'-'+score.scoreExpend:''"></td>
                </tr>
                </tbody>
            </table>
            <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        </div>
    </div>
</div>
<#include "include/pager.ftl"/>
<script>
    $(function(){
        $("#menu_sorceDetail").addClass("current");

    })

    var vm = avalon.define({
        $id: 'app',
        type: 1,
        pageNo: 1,
        pageCount:0,
        pageSize: 5,
        typeNameList:['积分兑换','积分明细'],
        scoreList :[],
        loadList: function(pageNo){
            if(pageNo) {
                vm.pageNo = pageNo;
            }
            $.get("${ctx}/account/userScoreDetail/findListByLimit",{
                pageNo: vm.pageNo,
                pageSize: vm.pageSize,
                type: vm.type
            },function(data){
                if(vm.type == 1){
                    vm.scoreList = data.orderItemList;
                }else if(vm.type == 2){
                    vm.scoreList = data.userScoreDetailList;
                }

            })
        },
        getPageCount: function(){
            $.get("${ctx}/account/userScoreDetail/getPageCount",{type:vm.type},function(data){
                vm.pageCount = data.pageCount;
            })
        }
    })

    vm.$watch('onReady',function(){
        vm.getPageCount();
        vm.loadList();
    })

    vm.$watch('type',function(){

        vm.scoreList = [];
        vm.getPageCount();
        vm.loadList();
    })
    function cardSubmit(){
        var cardNum = $("#cardNum").val();
        var cardPwd = $("#cardPwd").val();
        if(cardNum == null || cardNum == ''){
            layer.msg("请输入充值卡号!");
            return false;
        }
        if(cardPwd == null || cardPwd == ''){
            layer.msg("请输入充值卡密码");
            return false;
        }
        layer.confirm('确认充值？',function(){
            $.post("${ctx}/account/userRechargeDetail/entityRecharge",{
                'cardTypeCd' : 2,
                'cardNum' : cardNum,
                'cardPwd' : cardPwd
            },function(data){
                if(data && data.result == 'true'){
                    layer.msg("充值成功！");
                    window.location.href="${ctx}/account/userScoreDetail";
                }else{
                    layer.msg(data.message);
                }
            },'json')

        })
    }
</script>
</body>
</html>