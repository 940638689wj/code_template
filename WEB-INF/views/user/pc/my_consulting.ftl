<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的咨询</title>
    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body>
<#include "include/header.ftl"/>
<script type="text/javascript">
    function cancelCollect(id) {
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
</script>
<div :controller="app" class="ms-controller">
    <div class="center-layout">
    <#include "include/menu.ftl"/>
        <div class="center-content">
            <div class="content-titel"><h3>会员中心<span><em>_</em>我的咨询</span></h3></div>
            <table class="orderdatatb orderdatatb2">
                <thead>
                    <tr>
                        <th class="tal">商品</th>
                        <th width="25%"class="tal">咨询内容</th>
                        <th width="25%"class="tal">回复内容</th>
                        <th width="18%">咨询时间</th>
                    </tr>
                </thead>
                <tbody :for="consultInfo in @consultList">
                    <tr>
                        <td class="td-product">
                            <div class="first-column">
                                <div class="img"><a href="#"><img :attr="{src : consultInfo.picUrl}" ></a></div>
                                <div class="info">
                                    <div class="name"><a :attr="{href : '${ctx}/product'+consultInfo.productID}"  target="_blank">{{consultInfo.product}}</a></div>
                                    <div class="prop">
                                    	<span>¥<strong>{{consultInfo.defaultPrice}}</strong></span>
                                    </div>
                                </div>
                            </div>
                        </td>
                        <td class="tal">{{consultInfo.content}}</td>
                        <td class="tal">{{consultInfo.replyContent}}</td>
                        <td>{{consultInfo.createTime | date("yyyy-MM-dd HH:mm:ss")}}</td>
                    </tr>
                </tbody>
            </table>
            <wbr :widget="{ is: 'ms-pager', pageNo: @pageNo, pageSize: @pageSize, pageCount: @pageCount, callback: @loadList}">
   		</div>
	</div>
</div>
<#include "include/pager.ftl"/> 
<script>
    $(function () {
        $("#menu_myConsult").addClass("current");
    });
    var vm = avalon.define({
    	$id: 'app',
    	pageCount: 0,
    	pageSize: 5,
    	pageNo: 1,
    	consultList: [],
    	loadList: function(){
    		$.get('${ctx}/account/myConsult/findListByLimitForConsulting',{
    			pageNo: vm.pageNo,
    			pageSize: vm.pageSize
    		},function(data){
    			vm.consultList = data.userConsultInfoList;
    		})
    	},
    	getPageCount: function(){
    		$.get('${ctx}/account/myConsult/getPageCount',{},function(data){
    			vm.pageCount = data.pageCount;
    		})
    	}
    });
    vm.$watch('onReady',function(){
    	vm.getPageCount();
    	vm.loadList();
    });
</script>
</body>

</html>