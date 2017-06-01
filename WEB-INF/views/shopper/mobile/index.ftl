<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>个人中心</title> 
</head>
<body>
	<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	    	<a class="mui-icon"></a>
	        <h1 class="mui-title">个人中心</h1>
	        <a class="mui-icon"></a>
	    </header>
	  </#if>
    <div class="mui-content">
        <div class="welcometop mycenterbar personalcenter">
            <div class="hd" <#if (shopper.photoUrl)?has_content>style="background-image: url(${shopper.photoUrl!});"<#else>style="background-image: url(/static/mobile/images/logo.png);"</#if>><a id="personaldata">个人资料</a></div>
            <div class="bd">
                <h3>${shopper.shopperName},你好</h3>
                <p><span class="topup" id="workStatus">
                	  <#if  shopper?? && shopper.workStatusCd?has_content && shopper.workStatusCd !=0>
		           		  <#if  shopper.workStatusCd ==1>
		           			上班中
			           	  <#else>
			           	            繁忙中
		           			</#if>
		           	  <#else>
		           	      休息中
		           </#if>
                
                </span></p>
            </div>
            <a class="fromworkbtn" href="javascript:offDuty()">下班打卡</a>
        </div>
        <div class="tbviewlist categorylist">
            <ul>
                <li>
                    <a class="itemlink" href="${ctx}/m/shopper/toOrderList?type=1">
                        <div class="c"><i class="icon order"></i>我的订单</div>
                    </a>
                </li>
            </ul>
        </div>
        <div class="user-list">
            <ul>
                <li>
                    <a href="${ctx}/m/shopper/toOrderList?type=1">
                        <div class="t">待接单</div>
                        <div class="c">	${(pendingOrdersSize)!}</div>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/shopper/toOrderList?type=2">
                        <div class="t">配送中</div>
                        <div class="c">	${(distributionInSize)!}</div>
                    </a>
                </li>
                <li>
                    <a href="${ctx}/m/shopper/toOrderList?type=3">
                        <div class="t">已完成</div>
                        <div class="c">	${(completeSize)!}</div>
                    </a>
                </li>
            </ul>
        </div>

        <div class="dblist">
            <ul>
             <#if  distributionInLst??>
            		<#list distributionInLst as order>
	                     <#assign orderId = (order.orderId)!?string>        
	                <li><a  href="${ctx}/m/shopper/toOrderDetail?orderId=${(order.orderId)!}">
	                    <p class="cost">配送费：<span class="orange"><em>${order.orderExpressAmt!}</em>元</span></p><P class="time"> 
	                    <#if orderShopperOperationMap?? && orderShopperOperationMap[orderId]??>
			                		<#assign orderShopperOperation=orderShopperOperationMap[orderId]/>
							            <#if orderShopperOperation.dealStatusCd == 11>
							              待接收         
							            <#elseif orderShopperOperation.dealStatusCd == 12>
							                  待拣货    
							            <#elseif orderShopperOperation.dealStatusCd == 13>
							             	待配送             
							            <#elseif orderShopperOperation.dealStatusCd == 14  && order.orderStatusCd != 4  && order.orderStatusCd !=5>
							               		待送达  
							               <#elseif orderShopperOperation.dealStatusCd == 19>
							               		待处理
							            </#if>
			        			</#if>
	                     <#if order.requiredEndTime??  && order.requiredEndTime?has_content>
	                    	${order.requiredEndTime?string('yyyy-MM-dd HH-mm-ss')}
	                    </#if></P>
	                    <dl>
	                        <dt>
	                            <span class="green">取：</span>
			            		 <#if orderStoreMap?? && orderStoreMap[orderId]?? && orderStoreMap[orderId]?has_content>
			                		<#assign storeList=orderStoreMap[orderId]/>
			                		 <#list storeList as store>
				                            	<P>${(store.storeName)!?html}</P>
				                            	<p>${(store.fullAddress)!?html}</p>
				                            	<br/>
                                    </#list>
			        			</#if>
	                        </dt>
	                        <dd>
	                            <span class="orange">送：</span>
	                              <p>收货人姓名：${order.receiveName!}</p>
                            	  <p>收货人电话：${order.receiveTel!}</p>
				                  <p>收货人地址：${order.receiveAddrCombo!}</p>
	                        </dd>
	                    </dl>
	                    </a>
	                </li>
               
                 </#list>
            </#if>
            </ul>
        </div>
    </div>

    <div class="show-abnormal-bg"></div>
    <div class="mui-abnormal">
        <div class="ordercancel">
            <div class="info">
                <p class="gotowork">上班前请先打卡！</p>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" id="submit" onclick="clock();">打卡</a>
                <a href="javascript:void(0);" id="change">取消</a>
            </div>
        </div>
        <div class="goworkwrap">
            <div class="iconinfo">
                <i class="ico ico-success"></i>
                <strong>亲爱的${shopper.shopperName}，您已打卡成功！</strong>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" onclick="confirm();">确定</a>
            </div>
        </div>

    </div>
</div>
<script>
	
	$(function(){
	           <#if  shopper?? && shopper.workStatusCd?has_content && shopper.workStatusCd !=0>
	           			$(".show-abnormal-bg").removeClass("mui-active");
           				$(".mui-abnormal").removeClass("mui-popup-in");
           				$(".fromworkbtn").show();
           				document.ontouchmove = null;
	           	  <#else>
	           	  		$(".fromworkbtn").hide();
	           	  		$(".show-abnormal-bg").addClass("mui-active");
           			 	$(".mui-abnormal").addClass("mui-popup-in");
            			document.ontouchmove = function () {
                		return false;
            		}
	           </#if>
	            $("#personaldata").click(function(){
					window.location.href="${ctx}/m/shopper/shopperIndex";
				})
				
				 $("#change").on("click",function(){
	            $(".show-abnormal-bg").removeClass("mui-active");
	            $(".mui-abnormal").removeClass("mui-popup-in");
	            document.ontouchmove = null;
	        })
   	})
	function clock(){
		$.post("${ctx}/m/shopper/clock", {
            }, function(data){
                if(data && data.result == "true"){
                	$(".ordercancel").hide();
    				$(".goworkwrap").show();
                }else{
                    mui.toast(data.message);
                }
            }, "json");
    }
    
    function confirm(){
	     	location.href=location.href;
    }
    
    function offDuty(){
    	var btnArray = ['取消', '确认'];
    		mui.confirm('', '请确认订单都已处理完成？', btnArray, function(e) {
    			  if (e.index == 0) {
            		} else {
						$.post('${ctx}/m/shopper/offDuty',{},function(data){
				    		if(data){
				    				location.href=location.href;
				    		}
				    	});
				      }
        });
			
	}
</script>
</body>
</html>