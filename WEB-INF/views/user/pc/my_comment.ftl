<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的评论</title>


    <link rel="stylesheet" href="${ctx}/static/css/fsboxer.css">
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
            <div class="content-titel"><h3>会员中心<span><em>_</em>我的评价</span></h3></div>
            <div class="center-review">
                <div class="review-list">
                    <ul>
                        <li :for="review in @reviewList">
                            <div class="review-user">
                                <div class="userimg"><a href="#"><img :attr="{src: review.picUrl }"></a></div>
                                <div class="username"><a href="#">{{review.productName}}</a></div>
                            </div>
                            <div class="review-content">
                                <span class="review-time">{{review.reviewTime | date("yyyy-MM-dd
                                    HH:mm:ss")}}</span>

                                <span :class="['review-star','review-star-'+review.productMatchScore]"><b></b></span>

                                <div class="content">
                                    <p class="review-exp">
                                        <span class="tit">评价内容：</span><span class="con">{{review.reviewContent}}</span>
                                    </p>
                                </div>
                                <div class="review-img" ms-visible="review.productReviewPicInfos">
                                    <div class="pic" :for="pic in review.productReviewPicInfos" >
                                        <a rel="gallery2" class="boxer" :attr="{href:pic.picUrl}"><img  alt="" :attr="{src:pic.picUrl}"></a>
                                    </div>
                                </div>
                            </div>

                        </li>
                    </ul>
                </div>
            </div>
           <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
        </div>
    </div>
</div>
<#include "include/pager.ftl"/>
<script src="${ctx}/static/js/boxer.min.js"></script>
<script>
    $(function(){
        $("#menu_myEvaluation").addClass("current");


    });
    var vm = avalon.define({
        $id: 'app',
        pageCount :0,
        pageNo: 1,
        pageSize: 5,
        reviewList :[],
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
            $.get('${ctx}/account/comment/findLimitList',{
                pageNo: vm.pageNo,
                pageSize: vm.pageSize,
            },function(data){
                vm.reviewList = data.productReviewList;
                $('.boxer').boxer({
                    labels: {
                        close: "关闭",
                        count: "/",
                        next: "下一个",
                        previous: "上一个"
                    }
                });
            })
        },
		getPageCount: function(){
			$.get('${ctx}/account/comment/getPageCount',{},function(data){
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