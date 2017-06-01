<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile">
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<!doctype html>
<html lang="en">
<head>
	<title>成交记录</title>
	<script type="text/javascript" src="${staticResourcePath}/js/dateFormate1.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        <h1 class="mui-title">所有参与记录</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="financiallistWrap">
            <div class="in-recordlist">
                <ul>
                    <!--<li>
                        <div class="t"><img src="images/userhead.jpg" alt=""></div>
                        <div class="c">
                            <div class="usr">lyh79***@163.com</div>
                            <div class="count">购买了 <em>1</em> 人次</div>
                            <div class="time">2015-03-16 11:22:01.661</div>
                        </div>
                    </li>-->
                </ul>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${staticResourcePath}/js/dropload.js"></script>

<script>
    $(function(){
        // 页数
        var page = 0;
        // 每页展示5个
        var size = 10;
        // dropload
        $('.financiallistWrap').dropload({
            scrollArea : window,
            domDown : {
                domClass   : 'dropload-down',
                domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
                domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData  : '<div class="dropload-noData">没有更多数据了</div>'
            },
            loadDownFn : function(me){
                page++;
                // 拼接HTML
                var result = '';
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/product/productDealRecord?pageNo='+page+'&limit='+size+'&productId=${productId!}',
                    dataType: 'json',
                    success: function(data){
                    console.log(data);
                        var arrLen = data.rows.length;
                        if(arrLen > 0){
                            for(var i=0; i<arrLen; i++){
                            	var createTime=Format(ConvertJSONDateToJSDateObject(data.rows[i].createTime),"yyyy-MM-dd HH:mm:ss");
                                result += '<li><div class="t">';
                                if(data.rows[i].headPortraitUrl!=null && data.rows[i].headPortraitUrl!="undefined"){
                                	 result +=' <img src="${ctx}'+data.rows[i].headPortraitUrl+'" alt=""></div>';
                                }else{
                                	result +='<img src="images/userhead.jpg" alt=""></div>';
                                }
                                result +='<div class="c">'+
                                    '<div class="usr">'+data.rows[i].userName+'</div>'+
                                    '<div class="count">购买了 <em>'+data.rows[i].quantity+'</em> 人次</div>'+
                                    '<div class="time">'+createTime+'</div>'+
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
    
    //转换JSON数据中的时间为标准时间
	function ConvertJSONDateToJSDateObject(JSONDateString) {
	    var date = new Date(parseInt(JSONDateString));
	    return date;
	}
    
</script>
</body>
</html>