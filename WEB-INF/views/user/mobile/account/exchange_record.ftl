<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>兑换记录</title>  
    <script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userScoreDetail"></a>
	        <h1 class="mui-title">兑换记录</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="financiallistWrap">
            <div class="order_list exchange-list">
                <ul>
                </ul>
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.picker.min.css" />
<script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
<script>
    $(function(){
        // 页数
        var pageNo = 0;
        // 每页展示5个
        var pageSize = 5;
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
                    url: '${ctx}/m/account/userScoreDetail/findRecordListByLimit?pageNo='+pageNo+'&pageSize='+pageSize,
                    dataType: 'json',
                    success: function(data){
                    	if(data.result == "true"){
	                        var arrLen = data.orderItemList.length;
	                        if(arrLen > 0){
	                            for(var i=0; i<data.orderItemList.length; i++){
	                            result +='<li>'+
	                                    '<div class="hd"><span class="l">'+format(data.orderItemList[i].createTime,'yyyy-MM-dd HH:mm:ss')+'</span></div>';
	                            result += '<div class="items">' +
	                                            '<div class="pic"><img src="'+data.orderItemList[i].productPicUrl+'"></div>' +
	                                            '<h3>'+data.orderItemList[i].productName+'</h3>' +
	                                            '<p class="price"><em>'+data.orderItemList[i].payScoreAmt+'积分</em></p>' +
	                                            '<p class="spec">数量：'+data.orderItemList[i].quantity+'</p>' +
	                                        '</div></li>';
	                            }
	                        }
                        }else{
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function(){
                            $('.order_list ul').append(result);
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                       // me.resetload();
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