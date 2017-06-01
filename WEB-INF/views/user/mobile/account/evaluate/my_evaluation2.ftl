<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>我的评价</title>
    <script type="text/javascript" src="${staticPath}js/dropload.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/memberCenter"></a>
        <h1 class="mui-title">我的评价</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar">
        </div>
        <div class="financiallistWrap">
            <div class="review-list">
                <div class="reviewitem evaluation">
                    <ul>
                    
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    $(function(){
        // 页数
        var pageNo = 0;
        // 每页展示10个
        var pageSize = 10;
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
                pageNo++;
                // 拼接HTML
                var result = '';
               
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/account/evaluation/findLimitList?pageNo='+pageNo+'&pageSize='+pageSize,
                    dataType: 'json',
                    success: function(data){
                     if(data.result == 'true'){
                        var arrLen = data.productReviewList.length;
                        if(arrLen > 0){
                            for(var i=0; i<data.productReviewList.length; i++){
                            var picList =data.productReviewList[i].productReviewPicInfos;
                                result +='<li>'+
                                        '<div class="clearbox">'+
                                        '<div class="hd"><img src="'+data.productReviewList[i].picUrl+'"></div>'+
                                        '<div class="bd">'+
                                        '<h3>'+data.productReviewList[i].productName+'</h3>'+
                                        '<div class="source"><p><span class="review-star '+data.productReviewList[i].productMatchScore+'"><b></b></span></p></div>'+
                                        '</div>'+
                                        '</div>'+
                                        '<div class="comments-text">'+data.productReviewList[i].reviewContent+'</div>'+
                                        '<p class="comments-time">'+format(data.productReviewList[i].reviewTime,'yyyy-MM-dd HH:mm:ss')+'</p>'+
                                        '<div class="comments-img">';
                                for(var t=0; t<picList;t++) {
                                    result +='<div class="imgItems"><img src="'+data.productReviewList[i].productReviewPicInfos[t].picUrl+'"></div>';
                                }
                                result +='</div>';
                                            if(data.productReviewList[i].replyContent){
                                                result +='<div class="answer">商家回复：'+data.productReviewList[i].replyContent+'</div>';
                                            }else {
                                                result +='<div class="answer" style="display: none"></div>';
                                            }
                                result +='</li>';
                            }
                            }
                        }else{
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function(){
                            $('.reviewitem ul').append(result);
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
	    })
	}
</script>
</body>
</html>