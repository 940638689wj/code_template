<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的收藏</title>
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
            <div class="content-titel"><h3>会员中心<span><em>_</em>我的收藏</span></h3></div>

            <div class="section section-favourite">
                <ul>
                        <li :for="userCollectDetail in @collectList">
                            <div class="pic">
                                <a :attr="{href : '${ctx}/product/'+userCollectDetail.collectId}">
                                    <img :attr="{src : userCollectDetail.picUrl}" alt="">
                                </a>
                            </div>
                            <p class="name">
                                <a :attr="{href : '${ctx}/product/'+userCollectDetail.collectId}">
                                {{userCollectDetail.productName}}
                                </a>
                            </p>
                            <p class="money"><span>¥<strong>{{userCollectDetail.defaultPrice}}</strong></span>
                                <#--<del>￥49.90</del>-->
                            </p>
                            <p>{{userCollectDetail.collectTime | date("yyyy-MM-dd HH:mm:ss")}}</p>
                            <#--<a class="buy-link" href="#">立即购买</a>-->
                            <div class="del"><a href="javascript:void(0)" :click='@cancelCollect(userCollectDetail.collectId)'>取消收藏</a></div>
                        </li>
                </ul>
            </div>
         	<wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        </div>
    </div>
</div>
</div>
<#include "include/pager.ftl"/>
<script>
    $(function () {
        $("#menu_myFavourite").addClass("current");
    });
    var vm = avalon.define({
    	$id: "app",
    	pageCount: 0,
    	pageNo: 1,
    	pageSize: 4,
    	collectList: [],
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
    		$.get('${ctx}/account/myCollect/findListByLimitForCollection',{
    			pageNo:vm.pageNo,
    			pageSize:vm.pageSize
    			
    		},function(data){
    			vm.collectList = data.userCollectDetailList;
    		})
    	},
    	getPageCount: function(){
    		$.get("${ctx}/account/myCollect/getPageCount",{},function(data){
    			vm.pageCount = data.pageCount;
    		})
    	},
    	cancelCollect: function(id){
	        //询问框
	        layer.confirm('是否确认取消!', {
	                    btn: ['确认', '关闭']
	                }, function () {
	                    $.ajax({
	                        url: '${ctx}/m/product/collect',
	                        async: true,
	                        type: "GET",
	                        dataType: "json",
	                        data: {"productId": id, "isCollect": 0},
	                        success: function (result) {
	                            if (result.result == 'success') {
	                                location.reload();
	                            }
	                        },
	                        error: function (XMLHttpResponse) {
	                            console.log("请求未成功");
	                        }
	                    })
	                }
	        );	
    	}
    });
    vm.$watch('onReady',function(){
    	vm.getPageCount();
    	vm.loadList();
    });
</script>
</body>

</html>