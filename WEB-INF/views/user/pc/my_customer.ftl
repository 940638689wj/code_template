<#assign ctx = request.contextPath>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的客户 - 厦航商城</title>
    <script src="${ctx}/static/js/laydate-v1.1/laydate/laydate.js"></script>
</head>
<body>
	<div :controller="app" class="ms-controller">
	<#include "include/header.ftl"/>
	    <div class="center-layout">
	    	<#include "include/menu.ftl"/>
	        <div class="center-content">
	            <div class="content-titel"><h3>我的钱包<span><em>_</em>我的客户</span></h3></div>
	            <p class="title">我的业绩：<span class="price-real">{{@userProductPoint}}</span></p>
	            <div class="customer">
	                <div class="pfm-left">
	                    <p class="pfm-tit"><i></i>我的客户<span>({{@myCustomer}})</span></p>
	                    <div class="pfm-list">
	                        <div class="acitem ac-toggled">
	                            <div class="actit" :click="@customerIndex = -2">
	                                <div class="con"><a href="javascript:void(0);"><span class="num">({{@lower1UserListLength}})</span><i></i>V1会员</a></div>
	                                <div class="ac-toggle-btn"></div>
	                            </div>
	                            <div class="accon">
	                            	<ul class="prd-catlist" :visible="@v1MemberToggle">
	                                    <li :class="{selected:@customerIndex == '11'}" ms-on-click="@loadList(1,1);">
		                                    <i :css="{backgroundImage: @v1UrlHead}">
		                                    </i>
		                                    {{@userPhone}}
	                                    </li>
	                                </ul>
	                                <div class="iconinfo" :visible="@v1Toggle">
	                                    <div class="ico ico-info"></div>
	                                    <strong>很遗憾，您还没有<br>打造属于您的关系网！</strong>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="acitem ac-toggled">
	                            <div class="actit" :click="@customerIndex = -2">
	                                <div class="con"><a href="javascript:void(0);"><span class="num">({{@lower2UserListLength}})</span><i></i>V2会员</a></div>
	                                <div class="ac-toggle-btn"></div>
	                            </div>
	                            <div class="accon">
	                                <ul class="prd-catlist" :visible="@v2MemberToggle">
	                                    <li :class="{selected:@customerIndex == '2'+$index}" :for="($index,lower2User) in @lower2UserList" :click="@loadList(2,$index);">
		                                    <i :css="{backgroundImage: 'url(${ctx}/static/images/icon_member.png)'}" >
		                                    </i>
		                                    {{lower2User.phone}}
	                                    </li>
	                                </ul>
	                                <div class="iconinfo" :visible="@v2Toggle">
	                                    <div class="ico ico-info"></div>
	                                    <strong>很遗憾，您还没有<br>打造属于您的关系网！</strong>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="acitem ac-toggled">
	                            <div class="actit" :click="@customerIndex = -2">
	                                <div class="con"><a href="javascript:void(0);"><span class="num">({{@lower3UserListLength}})</span><i></i>V3会员</a></div>
	                                <div class="ac-toggle-btn"></div>
	                            </div>
	                            <div class="accon">
	                                <ul class="prd-catlist" :visible="@v3MemberToggle">
	                                    <li :class="{selected:@customerIndex == '3'+$index}" :for="lower3User in @lower3UserList" :click="@loadList(3,$index);">
	                                    	<i :css="{backgroundImage: 'url(${ctx}/static/images/icon_member.png)'}"></i>
	                                    	{{lower3User.phone}}
	                                    </li>
	                                </ul>
	                                <div class="iconinfo" :visible="@v3Toggle">
	                                    <div class="ico ico-info"></div>
	                                    <strong>很遗憾，您还没有<br>打造属于您的关系网！</strong>
	                                </div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
	                <div class="pfm-right">
	                    <div class="pfm-right" :visible="@customerShowOrHide">
	                        <div class="pfm-right-tit">
	                            <div class="junior-member">
	                            	<i :css="{backgroundImage: @customerHeadUrl}">
	                            	</i>
									{{customerPhone}}
	                            </div>
	                            <div class="flr">
	                                <input type="text" class="textfield input-date" placeholder="起始日期" onclick="laydate()" ms-duplex="@startTime">
	                                <label>&nbsp;至&nbsp;</label>
	                                <input type="text" class="textfield input-date" placeholder="结束日期" onclick="laydate()" ms-duplex="@endTime">
	                                <a href="#" class="v-button" :click="@loadList(-1,-1)">查询</a>
	                            </div>
	                        </div>
	                        <table class="orderdatatb">
	                            <thead>
	                            <tr>
	                                <th>日期</th>
	                                <th>消费金额</th>
	                                <th>业绩</th>
	                                <!-- <th>状态</th> -->
	                            </tr>
	                            </thead>
	                            <tbody>
	                            <tr :for="customerPerformance in @customerPerformanceList">
	                                <td>{{customerPerformance.createTime | date("yyyy-MM-dd HH:mm:ss")}}</td>
	                                <td>消费¥{{customerPerformance.orderTotalAmt}}</td>
	                                <td>{{customerPerformance.rebateProductPoint}}</td>
	                                <!-- <td><a href="javascript:void(0);" class="v-btn">未结算</a></td> -->
	                                <!-- <td><a href="javascript:void(0);" class="v-button">已结算</a></td> -->
	                            </tr>
	                            </tbody>
	                        </table>
	                        
	                        <wbr :widget="{is:'ms-pager'}"/>
	                        
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
    </div>

<#include "${ctx}/user/pc/include/pager.ftl"/>
<script>
    $(function(){
    	$("#menu_customer").addClass("current");
        $(".actit").on("click",function() {
        	
            var obj = $(this).closest(".acitem");
            if(obj.hasClass("ac-toggled")){
                $(".acitem").addClass("ac-toggled");
                obj.removeClass("ac-toggled");
            }else{
                obj.addClass("ac-toggled");
            }
        });
    });
    
    var vm = avalon.define({
    	$id : 'app',
    	myCustomer : '0',
    	userPhone : '',
    	userId : -1,
    	startTime : '',
    	endTime : '',
    	v1UrlHead : 'url(${ctx}/static/images/icon_member.png)',
    	lower1UserListLength : '1',
    	lower2UserListLength : '0',
    	lower2UserList: [],
    	lower3UserListLength : '0',
    	lower3UserList: [],
    	userProductPoint : '0',
    	v1MemberToggle:false,
    	v1Toggle : false,
    	v2MemberToggle:false,
    	v2Toggle : false,
    	v3MemberToggle:false,
    	v3Toggle : false,
    	customerHeadUrl :'url(${ctx}/static/images/icon_member.png)',
    	customerPhone:'',
    	userSelected:'',
    	userLiSelected:false,
    	customerIndex: -2,
    	pageSize: 6,
    	pageNo: 1,
    	pageCount:0,
    	customerPerformanceList : [],
    	customerShowOrHide : false,
    	getCustomer : function(){
    		$.get('${ctx}/account/myCustomer/myCustomerList',{},
    		function(data){
    			//console.log(data);
    			vm.userId = data.user.userId;
    			vm.lower2UserList = data.lower2UserList;
    			vm.lower2UserListLength = data.lower2UserList.length;
    			vm.lower3UserList = data.lower3UserList;
    			vm.lower3UserListLength = data.lower3UserList.length;
    			vm.userProductPoint = data.userConsumeCalc.userProductPoint;
    			vm.myCustomer = data.lower2UserList.length + data.lower3UserList.length;
    			vm.userPhone = data.user.phone;
    			if(data.user.headPortraitUrl){
	    			vm.v1UrlHead = 'url(${ctx}' + data.user.headPortraitUrl + ')';
    			}
    			if(data.user.phone){
    				vm.v1MemberToggle = true;
    			}else{
    				vm.v1Toggle = true;
    			}
    			if(data.lower2UserList.length > 0){
    				vm.v2MemberToggle = true;
    			}else{
    				vm.v2Toggle = true;
    			}
    			if(data.lower3UserList.length > 0){
    				vm.v3MemberToggle = true;
    			}else{
    				vm.v3Toggle = true;
    			}
    			vm.customerHeadUrl = 'url(${ctx}' + data.user.headPortraitUrl + ')';
    			vm.customerPhone = data.user.phone;
    		})
    	},
    	loadList:function(customer,index){
    		//样式处理
    		if(customer == "1"){
    			vm.userLiSelected = true;
    			vm.customerHeadUrl = vm.v1UrlHead;
    			vm.customerPhone = vm.userPhone;
    			vm.userId = -1;
    			//点击客户不加时间条件查询
    			vm.startTime = '';
    			vm.endTime = '';
    		}else if(customer == "2"){
    			vm.customerPhone = vm.lower2UserList[index].phone;
    			vm.userId = vm.lower2UserList[index].userId;
    			if(vm.lower2UserList[index].headPortraitUrl){
	    			vm.customerHeadUrl = vm.lower2UserList[index].headPortraitUrl
    			}else{
    				vm.customerHeadUrl = 'url(${ctx}/static/images/icon_member.png)'
    			}
    			//点击客户不加时间条件查询
    			vm.startTime = '';
    			vm.endTime = '';
			}else if(customer == "3"){
				vm.customerPhone = vm.lower3UserList[index].phone;
				vm.userId = vm.lower3UserList[index].userId;
				if(vm.lower3UserList[index].headPortraitUrl){
	    			vm.customerHeadUrl = vm.lower3UserList[index].headPortraitUrl
    			}else{
    				vm.customerHeadUrl = 'url(${ctx}/static/images/icon_member.png)'
    			}
    			//点击客户不加时间条件查询
    			vm.startTime = '';
    			vm.endTime = '';
			}
			//加载数据
			$.get('${ctx}/account/myCustomer/getMyCustomerPerformance',{userId:vm.userId, pageNo:vm.pageNo, limit:vm.pageSize, startTime:vm.startTime, endTime:vm.endTime},function(data){
				//console.log(data);
				if(data.customerPerformanceList.length > 0){
					vm.customerShowOrHide = true;
				}else{
					vm.customerShowOrHide = false;
					layer.msg("无记录数据");
				}
				vm.customerPerformanceList = data.customerPerformanceList;
				vm.pageCount = data.pageCount;
			});
			//查询进来不修改左边客户置灰样式
    		if(index >= 0){
	    		vm.customerIndex = customer + '' + index;
    		}
    	}
    });
    
    vm.$watch('onReady',function(){
    	vm.getCustomer();
    	vm.loadList(1,1);
    });
    
</script>
</body>
</html>