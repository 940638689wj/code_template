<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的咨询</title>
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
	        <a class="mui-icon mui-icon-left-nav" ></a>
	        <h1 class="mui-title">我的咨询</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <div class="consulting mblist">
                    <ul>
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
        imglazyload();
        
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
    var userID = '${(userID)!}';
    var replyContent;
    function pullupRefresh() {
    	pageNo++;
    	$.ajax({
    		url:"${ctx}/m/account/findListByLimitForConsulting",
    		data:{
    			userID:userID,
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
			           	if(typeof(list[i].replyContent)== 'undefined'){
			            	replyContent="未回复";
			            
			            }else{
			            	replyContent=list[i].replyContent;			            
			            }
			            li.innerHTML = 
			            		'<div class="advicepro">'+
			            		'<a href="${ctx}/m/product/'+list[i].productID+'">'+
			            		'<div class="pic">'+
			            		' <img class="lazyload" src="'+list[i].picUrl+'"  alt=""/>'+
			            		'</div>'+
			            		'<h3>'+list[i].productName+'</h3>'+
			            		'<p class="price mt18"><span class="price-real">￥<em>'+list[i].defaultPrice+'</em></span></p>'+
			            		'</a>'+
			            		'</div>'+
                                '<dl class="ask">' +
                                    '<dt><em>Q</em></dt>' +
                                    '<dd>'+list[i].content+'</dd>' +
                                '</dl>' +
                                '<dl class="answer">' +
                                    '<dt><em>A</em></dt>' +
                                    '<dd>'+replyContent+'</dd>' +
                                '</dl>'+
                        		'<div class="time">'+format(list[i].createTime, 'yyyy-MM-dd HH:mm:ss')+'</div>';
			                            
			            table.appendChild(li);
			            mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
			        }
    			} else if(data.result=="false") {
    				mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
    			}
    		}
    	});
        
    }
    if (mui.os.plus) {
        mui.plusReady(function() {
            setTimeout(function() {
                mui('#pullrefresh').pullRefresh().pullupLoading();
            }, 1000);

        });
    }
    
    mui('.advicepro').on('tap','a',function(){
        	var obj = $(this).attr("href");
        	//document.location.href= obj;
        	alert(obj);
    	});
    
</script>
</body>
</html>