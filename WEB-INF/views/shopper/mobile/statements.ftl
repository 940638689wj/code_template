<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>对账单</title>
    <script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
      <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.picker.min.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/global.css" />
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mobile.css" />
</head>
<body>
	<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/shopper/shopperIndex"></a>
	        <h1 class="mui-title">对账单</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="welcometop mycenterbar personalaccount">
             <div class="hd" <#if (shopper.photoUrl)?has_content>style="background-image: url(${shopper.photoUrl!});"<#else>style="background-image: url(/static/mobile/images/logo.png);"</#if>><a href="${ctx}/m/shopper/personalData">个人资料</a></div>
            <div class="bd">
                <div class="info">亲爱的${shopper.shopperName}，您好！<br>本月合计配送费：<i class="green">¥${sumCommission!0.00}</i></div>
            </div>
        </div>
         <div class="searchdate">
            <div class="bd"><button class="mui-btn mui-btn-block mui-btn-primary">搜索</button></div>
            <div class="hd">
                <p><input type="text" name="beginTime" id="beginTime" data-options='{"type":"date"}'  class="btn" placeholder="年/月/日"></p>
                <span>至</span>
                <p><input type="text" name="endTime" id="endTime" data-options='{"type":"date"}'  class="btn" placeholder="年/月/日"></p>
            </div>
        </div>
        <div class="borderbox recordList">
            <h3 class="title">对账单明细</h3>
            <ul>
            </ul>
        </div>
    </div>
</div>

<script>
 
      $(function(){
        $('.mui-btn').click(function(){
		  //搜索：当两节点都不为空时，结束时间要大于开始时间
          if($('#beginTime').val() != "" && $('#endTime').val() != "" && $('#endTime').val() > $('#beginTime').val()){
          	$('li').remove();
            loadCommission(pageNo);
          }else if($('#beginTime').val() == "" || $('#endTime').val() == ""){
          	$('li').remove();
            loadCommission(pageNo);
          }else{
          	mui.toast('查询的结束日期不能小于等于起始日期！');
          }
         });
      });
 
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
	        $.get('${ctx}${ctx}/m/shopper/commissionPage?beginTime='+ $('#beginTime').val()+'&endTime='+$('#endTime').val(), data, function(resultData){
	            if(resultData){
	                renderUlData(resultData);
	            }
	        }, 'json');
	    }
	    
	    function renderUlData(resultData) {
	        for (var i = 0; i < resultData.rows.length; i++) {
		        var commissionAmt = resultData.rows[i].orderExpressAmt;
		        var orderNumber = resultData.rows[i].orderNumber;
		        var createTime = '';
		        if ((resultData.rows[i].orderCompleteTime && typeof(resultData.rows[i].orderCompleteTime) != "undefined")) { 
		       			 createTime=getLocalTime(resultData.rows[i].orderCompleteTime);
        	    }  
		      
		        li = '<li>';
				li += '<div class="r">¥';
				li += commissionAmt;
				li += '</div>';
				li += '<div class="l">订单号：' + orderNumber + '</div>';
				li += '<p>完成时间：' + createTime + '</p>';
				li +='</li>';
				$('.recordList ul').append(li);
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
	<script>
    (function($) {
        $.init();
        //var result = $('#result')[0];
        var btns = $('.btn');
        btns.each(function(i, btn) {
            btn.addEventListener('tap', function() {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                var obj = this;
                var picker = new $.DtPicker(options);
                picker.show(function(rs) {
                    obj.value = rs.text;
                    picker.dispose();
                });
            }, false);
        });
    })(mui);
</script>
</body>
</html>