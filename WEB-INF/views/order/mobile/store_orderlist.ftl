<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <title>微店订单</title>
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1);"></a>
		            <h1 class="mui-title">微店订单</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="balance-top" style="background-image:url(${staticResourcePath}/images/sis-decoration-top.jpg);">
                <h3>待返利总额<span>(元)</span></h3>
                <p>${backTotal}</p>
            </div>
            
        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            	<div class="mui-scroll">
            		<div class="borderbox balance-list">
            		<div class="store-orderList">
		                <ul>
		                </ul>
		                </div>
            		</div>
        		</div>
    		</div>
    	</div>
            
        </div>

    </div>
<script>
 		var pageNo = 1;
 		
 		$(function(){
            getContentHeight();
            loadStoreOrders(pageNo)
        })
        
        $(window).resize(function(){
            getContentHeight();
        })

        function getContentHeight(){
            var muiBar = $(".mui-bar").height() || 0;
            var muiContent = $(".mui-content").height() || 0;
            $(".mui-scroll-wrapper").css("top",muiBar+muiContent);
        }
		
		function loadStoreOrders(pageNo){
	        var data = {};
	        data.sort = "time_l desc";	
	        data.pageNo = pageNo;
	        $.get('${ctx}/m/account/order/findMstoreOrderList', data, function(resultData){
	            if(resultData){
	                renderUlData(resultData);
	            }
	
	        }, 'json');
	    }
	    
	    function renderUlData(resultData) {
	        for (var i = 0; i < resultData.length; i++) {
		        var productUrl = resultData[i].productUrl;
		        var productCount = resultData[i].productCount;
		        var orderRebateDesc = resultData[i].orderRebateDesc;
		        var orderPayAmt = resultData[i].orderPayAmt;
		        var commissionAmt = resultData[i].commissionAmt;
		        var createTime =resultData[i].createTime;
		        createTime=getLocalTime(createTime);
		        li = '<li>'+
				      '<div class="hd">'+
	                  '<div class="pic">'+
	                  '<img src="'+productUrl+'"><i>'+productCount+'</i></div>'+
		              '<div class="info">'+
	                  '<p>创建时间：'+createTime+'</p>'+
	                  '<span class="complete">'+orderRebateDesc+'</span></div></div>'+
                      '<div class="bd">'+
                      '<div class="clinch">'+
                      '<p>成交金额</p>'+
                      '<span>'+orderPayAmt+'元</span></div>'+
                      '<div class="commission">'+
                      '<p>返佣金额</p>'+
                      '<span>'+commissionAmt+'元</span></div></div>';
				$('.balance-list ul').append(li);
	        }
	    }
		
        mui.init({
            pullRefresh: {
                container: '#pullrefresh',
                up: {
                    contentrefresh: '正在加载...',
                    callback: pullupRefresh
                }
            }
        });

        var count = 0;
        function pullupRefresh() {
            setTimeout(function() {
                mui('#pullrefresh').pullRefresh().endPullupToRefresh((++count > 2)); //参数为true代表没有更多数据了。
                var table = document.body.querySelector('.balance-list ul');
                var cells = document.body.querySelectorAll('.list');
                pageNo=pageNo+1;
                loadStoreOrders(pageNo)
            }, 1000);
        }
        if (mui.os.plus) {
            mui.plusReady(function() {
                setTimeout(function() {
                    mui('#pullrefresh').pullRefresh().pullupLoading();
                }, 1000);

            });
        }
        
        function getLocalTime(createTime) {     
       		//return new Date(createTime).toLocaleString().replace(/\//g, "-").replace(/上午|下午/g, " ");	//12小时制
       		var now = new Date(createTime);    //根据时间戳生成的时间对象
			var yy = now.getFullYear();      //年
			var mm = now.getMonth() + 1;     //月
			var dd = now.getDate();          //日
			var hh = now.getHours();         //时
			var ii = now.getMinutes();       //分
			var ss = now.getSeconds();       //秒
			var clock = yy + "-";
			if(mm < 10) clock += "0";
			clock += mm + "-";
			if(dd < 10) clock += "0";
			clock += dd + " ";
			if(hh < 10) clock += "0";
			clock += hh + ":";
			if (ii < 10) clock += '0'; 
			clock += ii + ":";
			if (ss < 10) clock += '0'; 
			clock += ss;
			return clock;     
    	}  
</script>
</body>
</html>