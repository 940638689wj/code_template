<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的提货券</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <style>
        .ms-controller {
            visibility: hidden
        }
        img{
            cursor: pointer;
            transition: all 0.6s;
        }
        img:hover{
            transform: scale(3);
        }
    </style>
</head>
<body class="page-login">
<#include "include/header.ftl"/>
<div :controller="app" class="ms-controller">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>我的钱包<span><em>_</em>我的提货券</span></h3></div>
            <div class="center-list">
                <table class="orderdatatb orderdatatb2">
                    <thead>
                    <tr>
                        <td class="td-w200">二维码</td>
                         <td class="td-w200">提货券码</td>
                        <td class="td-w200">有效期</td>
                        <td class="td-status">使用状态</td>
                        <td class="td-operate">操作</td>
                    </tr>
                    </thead>
                </table>

                <div class="datawrap">
                    <table class="orderdatatb">
                        <tbody :for="pickupCoupon in @pickupCouponList">
                        <input type="hidden" id="pickupId" value="pickCoupon.pickupCouponCodeId" />
                        <tr>
                            <td class="td-w200"><img class="qrCodeSmallImg" ms-attr="{src :'${ctx}/qrCode/generate?content='+ pickupCoupon.content }"  style="width:30px;height: 30px;cursor: pointer;" /></td>
                            <td class="td-product">{{pickupCoupon.pickupCouponName}}</td>
                            <td class="td-w200">{{pickupCoupon.pickupCouponCodeNum}}</td>
                            <td class="td-w200">{{pickupCoupon.allowUseStartTime | date("yyyy-MM-dd HH:mm:ss")}}至{{pickupCoupon.allowUseEndTime | date("yyyy-MM-dd HH:mm:ss")}}</td>
                            <td class="td-status" ms-visible="pickupCoupon.usedStatusCd == 1 && pickupCoupon.isPast==1">未使用</td>
                            <td class="td-status" ms-visible="pickupCoupon.usedStatusCd == 1 && pickupCoupon.isPast==2">已过期</td>
                            <td class="td-status" ms-visible="pickupCoupon.usedStatusCd == 2">已使用</td>
                            <td class="td-operate" ms-visible="pickupCoupon.usedStatusCd == 1 && pickupCoupon.isPast==1"><a href="${ctx}/pickup/index.html" class="v-btn">去使用</a></td>
                            <td class="td-operate" ms-visible="pickupCoupon.usedStatusCd == 1 && pickupCoupon.isPast==2"></td>
                            <td class="td-operate" ms-visible="pickupCoupon.usedStatusCd == 2"></td>
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
         $("#menu_pickupCoupon").addClass("current");

//        var x = 5;
//        var y = 5;
//        $(".qrCodeSmallImg").live('mouseover', function (ev) {
//            var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='" + $(this).attr("src") + "'><\/div>"; //创建 div 元素
//            $("body").append(tooltip);	//把它追加到文档中
//            $("#tooltip").css({
//                "top": (ev.pageY + y) + "px",
//                "left": (ev.pageX + x) + "px"
//            }).show("fast");	  //设置x坐标和y坐标，并且显示
//        }).live('mouseout', function () {
//            $("#tooltip").remove();	 //移除
//        }).live('mouseover', function (e) {
//            $("#tooltip").css({
//                "top": (e.pageY + y) + "px",
//                "left": (e.pageX + x) + "px"
//            });
//        });
    })
    var vm = avalon.define({
        $id : 'app',
        pageNo: 1,
        pageSize: 5,
        pageCount: 0,
        pickupCouponList:[],
//        $computed: {
//            path : function(){
//               var pickupCouponCodeId =  $('#pickupId').val();
//                $.get("")
//            }
//        },
        loadList: function (pageNo) {
            if(pageNo != null) {
                this.pageNo = pageNo;
            }
            $.get('${ctx}/account/pickup/findListByLimit',{
                pageNo : vm.pageNo,
                pageSize : vm.pageSize

            },function(data){
                vm.pickupCouponList = data.pickupCouponDTOList;
            })
        },
        getPageCount: function(){
            $.get('${ctx}/account/pickup/getPageCount',{},function(data){
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