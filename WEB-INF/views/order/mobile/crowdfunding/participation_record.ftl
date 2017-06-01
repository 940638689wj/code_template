<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<html>
<head>
    <script type="text/javascript" src="${staticPath}js/dropload.js"></script>
	<style>
		[v-cloak] {
			display: none;
		}
	</style>
</head>
<body>
	<div id="page">
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href='javaScript:history.back(-1)'></a>
	        <h1 class="mui-title">所有参与记录</h1>
	        <a class="mui-icon"></a>
	    </header>
	    <div class="mui-content">
	        <div class="financiallistWrap">
	            <div class="in-recordlist">
	                <ul>
	                    <#--
	                    <li>
	                        <div class="t"><img src="images/userhead.jpg" alt=""></div>
	                        <div class="c">
	                            <div class="usr">lyh79***@163.com</div>
	                            <div class="count">购买了 <em>1</em> 人次</div>
	                            <div class="time">2015-03-16 11:22:01.661</div>
	                        </div>
	                    </li>
	                    -->
	                </ul>
	            </div>
	        </div>
	    </div>
	</div>
<script>
var promotionId = ${promotionId!};
$(function(){
        // 页数
        var page = -1;
        // 每页展示5个
        var size = 10;
        // dropload
        $('.financiallistWrap').dropload({
            scrollArea : window,
            domDown : {
                domClass   : 'dropload-down',
                domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
                domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData  : '<div class="dropload-noData">暂无数据</div>'
            },
            loadDownFn : function(me){
                page++;
                // 拼接HTML
                var result = '';
                $.ajax({
                    type: 'GET',
                    url: '/crowdfunding/jsonOrderRecode?page='+page+'&size='+size+'&promotionId='+promotionId,
                    dataType: 'json',
                    success: function(data){
                        var arrLen = data.length;
                        if(arrLen > 0){
                            for(var i=0; i<data.length; i++){
                            	var name = data[i].name;
                                result += '<li>'+
                                        '<div class="t"><img src="'+data[i].img+'" alt=""></div>'+
                                        '<div class="c">'+
                                        '<div class="usr">'+name.substring(0,3)+'****'+name.substring(name.length-4)+'</div>'+
                                        '<div class="count">购买了 <em>'+data[i].num+'</em> 个众筹码</div>'+
                                        '<div class="time">'+new Date(data[i].time).format('yyyy-MM-dd hh:mm:ss')+'</div>'+
                                        '</div>'+
                                        '</li>';
                            }
                        }else{
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function(){
                            $('.in-recordlist ul').append(result);
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                        me.resetload();
                    }
                });
            }
        });
    });
</script>
</body>
</html>