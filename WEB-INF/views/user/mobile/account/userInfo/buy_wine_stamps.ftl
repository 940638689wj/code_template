<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>我的购酒券</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/css/module.css" />
    <script type="text/javascript" src="${staticPath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticPath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticPath}/js/yrmobile.js"></script>
    <script type="text/javascript" src="${staticPath}/js/jquery.unveil.js"></script>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
	            <h1 class="mui-title">我的购酒券</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="balance-top" style="background-image:url(${staticPath}/images/balance_top_bg.png);">
                <h3>余额<span>(元)</span></h3>
                <p>${(userConsumeCalc.userBalance?string.currency)!'￥0.00'}</p>
            </div>
            <div class="tabbar">
                <ul>
                    <li <#if type=='0'>class="selected" </#if> ><a href="${ctx}/m/account/list?type=0">全部</a></li>
                    <li <#if type=='1'>class="selected" </#if> ><a href="${ctx}/m/account/list?type=1">收入</a></li>
                    <li <#if type=='2'>class="selected" </#if> ><a href="${ctx}/m/account/list?type=2">支出</a></li>
                </ul>
            </div>
            
            <div class="content-body">
            	<input type="hidden" id= "type" name="type" value="${type!}" />
            </div>
            
            <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            	<div class="mui-scroll">
            		<div class="borderbox balance-list">
		                <ul>
		                </ul>
            		</div>
        		</div>
    		</div>
        </div>
         <#include "${ctx}/includes/mobile/globalmenu.ftl"/>
    </div>

<script>
 		var pageNo = 1;
 		var type = $('#type').val() ? $('#type').val() : 0;
 		
 		$(function(){
            getContentHeight();
            loadWineStamps(pageNo,type)
        })
        
        $(window).resize(function(){
            getContentHeight();
        })

        function getContentHeight(){
            var muiBar = $(".mui-bar").height() || 0;
            var muiContent = $(".mui-content").height() || 0;
            $(".mui-scroll-wrapper").css("top",muiBar+muiContent);
        }
		
		function loadWineStamps(pageNo,type){
	
	        var data = {};
	        data.sort = "time_l desc";	
	        data.pageNo = pageNo;
	        data.type = type;
	        $.get('${ctx}/m/account/wineStamps', data, function(resultData){
	            if(resultData){
	                renderUlData(resultData);
	            }
	
	        }, 'json');
	    }
	    
	    function renderUlData(resultData) {
			
	        for (var i = 0; i < resultData.length; i++) {
		        var balanceId = resultData[i].balanceId;
		        var balanceIncome = resultData[i].balanceIncome;
		        var balanceExpend = resultData[i].balanceExpend;
		        var remark = resultData[i].remark;
		        var orderNumber = resultData[i].orderNumber;
		        var userId = resultData[i].userId;
		        var adminUserId = resultData[i].adminUserId;
		        var adminUserName = resultData[i].adminUserName;
		        var createTime =resultData[i].createTime;
		        createTime=getLocalTime(createTime);
		        li = '<li>';
				if(type==0){
					if(balanceIncome){
						li +='<div class="r">+'+balanceIncome+'</div>';
					}
					if(balanceExpend){
						li +='<div class="r">-'+balanceExpend+'</div>';
					}
					li +='<div class="l">'+remark+'</div>';
				
					li +='<p>'+createTime +'</p>';
					li +='</li>';
				}
				if(type==1){
					li +='<div class="r">+'+balanceIncome+'</div>';
					
					li +='<div class="l">'+remark+'</div>';
				
					li +='<p>'+createTime +'</p>';
					li +='</li>';
				}
				if(type==2){
					li +='<div class="r">-'+balanceExpend+'</div>';
					li +='<div class="l">'+remark+'</div>';
				
					li +='<p>'+createTime +'</p>';
					li +='</li>';
				}
				
				
				
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
                loadWineStamps(pageNo,type)
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