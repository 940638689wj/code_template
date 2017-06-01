<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>用户咨询</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}/css/global.css" />
    <link rel="stylesheet" type="text/css" href="${staticResourcePath}/css/mobile.css" />
    <script type="text/javascript" src="${staticResourcePath}/js/zepto.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/mui.min.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/mobile.js"></script>
    <script type="text/javascript" src="${staticResourcePath}/js/jquery.unveil.js"></script>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/product/${(productId)!}"></a>
	        <h1 class="mui-title">用户咨询</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <div class="consulting">
                    <ul>
                        <li class="list">
                           
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        getContentHeight();
        pullupRefresh();
    })
    $(window).resize(function(){
        getContentHeight();
    })

    function getContentHeight(){
        var muiBar = $(".mui-bar").height() || 0;
        $(".mui-scroll-wrapper").css("top",muiBar);
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
      //格式化日期
    var format = function(time, format){
	    var t = new Date(time);
	    var tf = function(i){return (i < 10 ? '0' : '') + i};
	    return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function(a){
	        switch(a){
	            case 'yyyy':
	                return tf(t.getFullYear());
	                break;
	            case 'MM':
	                return tf(t.getMonth() + 1);
	                break;
	            case 'mm':
	                return tf(t.getMinutes());
	                break;
	            case 'dd':
	                return tf(t.getDate());
	                break;
	            case 'HH':
	                return tf(t.getHours());
	                break;
	            case 'ss':
	                return tf(t.getSeconds());
	                break;
	        }
	    })}
 	var pageNo = 0;
    var pageSize = 10;
    var productId = '${(productId)!}';
    
    function pullupRefresh() {
    	pageNo++;
    	$.ajax({
    		url:"${ctx}/m/product/findListByLimitForConsulting",
    		data:{
    			productID:productId,
	    		pageNo:pageNo,
	    		pageSize:pageSize
    		},
    		dataType:"json",
    		success:function(data){
    			if(data.result=="true"){
    				var list = data.userConsultInfoList;
	    			var table = document.body.querySelector('.consulting ul');
			        var cells = document.body.querySelectorAll('.list');
			        for (var i = 0 ; i < list.length ; i++) {
			            var li = document.createElement('li');
			            li.className = 'list';
			            li.innerHTML = 
			            		'<div class="name">'+list[i].userName+'</div>' +
                                '<div class="time">'+format(list[i].createTime, 'yyyy-MM-dd HH:mm:ss')+'</div>' +
                                '<dl class="ask">' +
                                    '<dt><em>Q</em></dt>' +
                                    '<dd>'+list[i].content+'</dd>' +
                                '</dl>' +
                                '<dl class="answer">' +
                                    '<dt><em>A</em></dt>' +
                                    '<dd>'+list[i].replyContent+'</dd>' +
                                '</dl>';
			                            
			            table.appendChild(li);
			            mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
			        }
    			} else if(data.result=="false") {
    				mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
    			}
    		}
    	});
        /*setTimeout(function() {
            mui('#pullrefresh').pullRefresh().endPullupToRefresh((++count > 2)); //参数为true代表没有更多数据了。
            var table = document.body.querySelector('.consulting ul');
            var cells = document.body.querySelectorAll('.list');
            for (var i = cells.length, len = i + 10; i < len; i++) {
                var li = document.createElement('li');
                li.className = 'list';
                li.innerHTML = '<div class="name">用户名</div>' +
                                '<div class="time">2014-6-26  14:23:40</div>' +
                                '<dl class="ask">' +
                                    '<dt><em>Q</em></dt>' +
                                    '<dd>这个支持全身水洗么？</dd>' +
                                '</dl>' +
                                '<dl class="answer">' +
                                    '<dt><em>A</em></dt>' +
                                    '<dd>您好！这款产品为水洗设计，建议您可将产品在水龙头下冲洗，不要将整机放入水中清洁。祝您购物愉快！</dd>' +
                                '</dl>';
                table.appendChild(li);
            }
        }, 1000);*/
    }
    if (mui.os.plus) {
        mui.plusReady(function() {
            setTimeout(function() {
                mui('#pullrefresh').pullRefresh().pullupLoading();
            }, 1000);

        });
    }
</script>
</body>
</html>