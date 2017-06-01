<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>我的订单</title>
    <script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/otherOrder/index"></a>
        <h1 class="mui-title">我的众筹记录</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li class="selected"><a href="javaScript:void(0)" id='allBtn'>全部</a></li>
                <li><a href="javaScript:void(0)" id='ingBtn'>众筹中</a></li>
                <li><a href="javaScript:void(0)" id='edBtn'>已揭晓</a></li>
            </ul>
        </div>
        <div class="financiallistWrap">
            <div class="prd-list">
                <ul>
                </ul>
             </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        getDate();
        
        $("#allBtn").click(function(){
        	statusCd = -1;
        	init(this);
        });
        
        $("#ingBtn").click(function(){
        	statusCd = 0;
			init(this);
        });
        
        $("#edBtn").click(function(){
        	statusCd = 1;
        	init(this);
        });
        
    });
    
    function init(e){
    	$(e).parent().parent().children().each(function(){
    		$(this).removeClass('selected');
    	});
    	$(e).parent().addClass('selected');
    	$(".dropload-down").remove();
    	page = 0;
    	$('.prd-list ul').empty();
    	getDate();
    }
    
	// 页数
    var page = 0;
    // 每页展示5个
    var size = 5;
    var statusCd = -1;
    //获取数据
    function getDate(){
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
		            url: 'jsonListDate?page='+page+'&size='+size+'&statusCd='+statusCd,
		            dataType: 'json',
		            success: function(data){
		                var arrLen = data.length;
		                if(arrLen > 0){
		                    for(var i=0; i<data.length; i++){
		                    	var item = data[i];
		                        result += '<li><a href="detail?promotionId='+item.promotionId+'">';
	                            if(item.crowdFundStatusCd == 1){
	                            	var name = item.winnerLoginName;
	                            	var winnerName = name.substring(0,3)+'***'+name.substring(name.length-4);
	                                result +='<div class="pic"><img src="'+item.picUrl+'"><b>已揭晓</b></div>'+
	                                        '<div class="r">'+
	                                        '<p class="name">'+item.promotionName+'</p>'+
	                                        '<p class="announced">获得者:<i>'+winnerName+'</i></p>'+
	                                        '<p class="announced">揭晓时间:'+new Date(item.calcTime).format('yyyy-MM-dd hh:mm:ss')+'</p>'+
	                                        '</div>';
	                            }else {
                                    result +='<div class="pic"><img src="'+item.picUrl+'"></div>'+
	                                        '<div class="r">'+
	                                        '<p class="name">'+item.promotionName+'</p>'+
	                                        '<p class="progressbar"><span style="width:'+eval(100*(item.currentPeopleNum/item.requireNum))+'%;"></span></p>'+
	                                         '<p>众筹尚未完成，还需<i class="numberof">'+eval(item.requireNum-item.currentPeopleNum)+'</i>人次</p>'+
	                                        '</div>';
	                            }
		                        result += '</a></li>';
		                    }
		                }else{
		                    me.lock();
		                    me.noData();
		                }
		                setTimeout(function(){
		                    $('.prd-list ul').append(result);
		                    me.resetload();
		                },1000);
		            },
		            error: function(xhr, type){
		                me.resetload();
		            }
		        });
            }
        });	
	}
</script>
</body>
</html>