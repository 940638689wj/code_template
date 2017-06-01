<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<meta charset="UTF-8">
<title>佣金收益</title>
<!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<meta name="format-detection" content="telephone=no" />-->
</head>
<body>
	<div id="page">
		<#if showTitle?? && showTitle>
			<header class="mui-bar mui-bar-nav">
				<a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
				<h1 class="mui-title">佣金收益</h1>
				<a class="mui-icon"></a>
			</header>
        </#if>

		<div class="mui-content">
			<div class="balance-top" style="background-color: #7597DE">
				<div class="fl">
					<h2>
						佣金收益<span>(元)</span>
					</h2>
					<p>${sumCommission!0.00}</p>
				</div>
				<div class="fr" style="width: 80px;">
					<img alt="" src="${staticResourcePath}/images/earnings03.png">
				</div>
			</div>
			<div class="borderbox balance-list">
				<div id="pullrefresh" class="mui-content mui-scroll-wrapper">
					<div class="mui-scroll">
						<div class="borderbox balance-list">
							<ul></ul>
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
            loadCommission(pageNo)
        })
        
        $(window).resize(function(){
            getContentHeight();
        })

        function getContentHeight(){
            var muiBar = $(".mui-bar").height() || 0;
            var muiContent = $(".mui-content").height() || 0;
            $(".mui-scroll-wrapper").css("top",muiBar+muiContent);
        }
		
		function loadCommission(pageNo){
	
	        var data = {};
	        //data.sort = "time_l desc";
	        data.pageNo = pageNo;
	        $.get('${ctx}/m/account/mstoreUser/commissionPage', data, function(resultData){
	            if(resultData){
	                renderUlData(resultData);
	            }
	
	        }, 'json');
	    }
	    
	    function renderUlData(resultData) {
	        for (var i = 0; i < resultData.length; i++) {
		        var commissionAmt = resultData[i].commissionAmt;
		        var customerName = resultData[i].customerName;
		        var orderNumber = resultData[i].orderNumber;
		        var createTime =resultData[i].createTime;
		        createTime=getLocalTime(createTime);
		        
		        li = '<li>';
				li += '<div>';
				li += '<div class="r">';
				if(commissionAmt && commissionAmt < 0){
					li += commissionAmt;
				}else{
					li += '+'+commissionAmt;
				}
				li += '</div>';
				li += '<div class="l">' + customerName + '</div>';
				li += '</div>';
				li += '<div>';
				li += '<div class="r default">订单号:' + orderNumber + '</div>';
				li += '<div class="l default">' + createTime + '</div>';
				li += '</div>';
				li +='</li>';
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
                loadCommission(pageNo);
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
// 			var hh = now.getHours();         //时
// 			var ii = now.getMinutes();       //分
// 			var ss = now.getSeconds();       //秒
			var clock = yy + "-";
			if(mm < 10) clock += "0";
			clock += mm + "-";
			if(dd < 10) clock += "0";
			clock += dd + " ";
// 			if(hh < 10) clock += "0";
// 			clock += hh + ":";
// 			if (ii < 10) clock += '0'; 
// 			clock += ii + ":";
// 			if (ss < 10) clock += '0'; 
// 			clock += ss;
			return clock;     
    	}
	</script>
</body>
</html>