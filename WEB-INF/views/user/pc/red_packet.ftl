<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>红包</title>
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
	        <div class="content-titel"><h3>我的钱包<span><em>_</em>我的红包</span></h3></div>
	        <div class="corder-tab">
	            <ul>
	                <li :for="($index,typeName) in @typeNameList" :class="[@type == ($index+1) && 'current']">
	                    <a href="javascript:void(0)" :click="@type = $index+1">
	                        {{typeName}}
	                    </a>
	                </li>
	            </ul>
	        </div>
	        <div class="my-couponlist">
	            <ul>
	                <li :class="[@tt]" :for="promotion in @promotionCodeList" >
	                    <div class="t"><p>{{promotion.couponCodeValue}}<i>元</i></p><span ms-html="promotion.discountDesc?promotion.discountDesc:''" ></span>
	                    </div>
	                    <div class="b"><h3>红包ID：{{promotion.couponCodeId}}</h3><p>有效期至</p><p>{{promotion.enableEndTime | date("yyyy-MM-dd hh:mm:ss")}}</p></div>
	                    <a class="btn" :visible="@type==1" :attr="{href : '${ctx}/products/0.html'}">立即使用</a>
	                    <i :visible="@type==2" class="ico-use"></i>
	                    <i :visible="@type==3" class="ico-overdue"></i>
	                </li>
	            </ul>
	        </div>
	        <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
	    </div>
	</div>
</div>
<#include "include/pager.ftl"/>

<script>
    $(function(){
    	 $("#menu_redPacket").addClass("current");
    })

   var vm = avalon.define({
        $id: 'app',
        type: 1,  //1 未使用 2 已使用 3 已过期
        pageNo : 1,
        pageSize: 4,
        tt : '',
        typeNameList: ['未使用','已使用','已过期'],
        count: {type1:0,type2:0,type3:0},
        promotionCodeList:[],
        $computed:{
            pageCount: function(){
                return this.count["type"+this.type]
            }
        },
       loadList: function (pageNo) {
           if(pageNo != null) {
               this.pageNo = pageNo;
           }
            $.get('${ctx}/account/userPromotion/findListByLimit',{
                pageNo:vm.pageNo,
                pageSize:vm.pageSize,
                type: vm.type,
                promotionType:1
            },function(data){
                vm.promotionCodeList = data.promotionDTOList;
            })
        }
   });
   vm.$watch('onReady',function(){
    $.get("${ctx}/account/userPromotion/getAllCount",{promotionType:1},function(data){
        vm.count = data;
    });
    vm.loadList();
   })
   vm.$watch('type',function(){
        vm.promotionCodeList = [];
        vm.pageNo = 1;
        if(vm.type == 2){
        vm.tt = 'use';
        }else if(vm.type == 3){
        vm.tt = 'overdue';
        }else{
        vm.tt = '';
        }
        vm.loadList();
   })
</script>
</body>
</html>