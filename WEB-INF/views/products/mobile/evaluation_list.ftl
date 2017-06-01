<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile">
<#assign mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")>
<!doctype html>
<html lang="en">
<head>
	<title>用户评价</title>
	<script type="text/javascript" src="${staticResourcePath}/js/dateFormate1.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        <h1 class="mui-title">用户评价</h1>
        <a class="mui-icon"></a>
    </header>
    <input type="hidden" id="productId" value=${productId}/>
    <div class="mui-content">
        <div class="returnbox">
            <div class="return">
                <ul class="comment procomment" id="reviewAccount">
                <!--
                    <li><div class="fl" ><span class="review-starbig review-starbig-4"><b></b></span><i id="scoreValue">4.7</i></div><div class="fr"><a href="consulting.html" class="orange">咨询</a></div></li>
                    <li id="reviewTotal">4944人评价</li>
                 -->
                </ul>
                <ul class="return-type">
                    <li class="selected" id="allReview" onclick="selectType(this)">全部</li>
                    <li id="goodReview" onclick="selectType(this,1)">好评</li>
                    <li id="review" onclick="selectType(this,2)">中评</li>
                    <li id="badReview" onclick="selectType(this,3)">差评</li>
                </ul>
            </div>
        </div>
        <div class="financiallistWrap">
            <div class="review-list">
                <div class="reviewitem">
                    <ul>
                        <!-- <li>
                            <div class="clearbox">
                                <div class="hd" style="background-image: url(images/userhead.jpg);"></div>
                                <div class="bd">
                                    <h3>m***y</h3>
                                    <p><em class="fl">2016-10-10 15:35</em><em class="fr"><span class="review-star review-star-4"><b></b></span></em></p>
                                </div>
                            </div>
                            <div class="comments-text">下次搞活动还来买，送的红酒包装都那么精美，超赞性价比比较高，希望下次继续合作。</div>
                            <div class="comments-img">
                                <div class="imgItems"><img src="images/goodspic.jpg"></div>
                                <div class="imgItems"><img src="images/goodspic.jpg"></div>
                                <div class="imgItems"><img src="images/goodspic.jpg"></div>
                            </div>
                            <div class="answer">商家回复：感谢亲对洋河1号的支持和认可！祝您生活愉快！</div>
                        </li> -->
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${staticResourcePath}/js/dropload.js"></script>
<script>
    $(function(){
    	getAccountInfo();
        $("#allReview").click();
    });
    
    function selectType(e,type){
    	$(".return-type li").each(function(){
			$(this).removeClass("selected");
		});
		$(".reviewitem ul").empty(); 
		$(".dropload-down").remove();
		if(e!=null){
			$(e).addClass("selected");
		} 
		getReviewlist(type);
    }
    
    function getReviewlist(type){
    	// 页数
        var page = 0;
        // 每页展示5个
        var size = 5;
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
                    url: '${ctx}/m/product/productReviewList?pageNo='+page+'&limit='+size+'&type='+type+'&productId=${productId}',
                    dataType: 'json',
                    success: function(data){
                        var arrLen = data.rows.length;
                        if(arrLen > 0){
                            for(var i=0; i<arrLen; i++){
                                var reviewTime=Format(ConvertJSONDateToJSDateObject(data.rows[i].reviewTime),"yyyy-MM-dd HH:mm:ss");
                                result +='<li>'+
                                        '<div class="clearbox">'+
                                        	'<div class="hd" style="background-image: url(${staticResourcePath}/images/userhead.jpg);"></div>'+
                                            '<div class="bd">'+
                                            '<h3>'+data.rows[i].reviewerName+'</h3>'+
                                            '<p><em class="fl">'+reviewTime+'</em><em class="fr"><span class="review-star review-star-'+data.rows[i].productMatchScore+'"><b></b></span></em></p>'+
                                            '</div>'+
                                        '</div>'+
                                        '<div class="comments-text">'+data.rows[i].reviewContent+'</div>'+
                                        '<div class="comments-img">';
                                            //for(var t=0; t<data.lists[i].items.length; t++) {
                                                //result +='<div class="imgItems"><img src="'+data.rows[i].items[t].img+'"></div>';
                                            //}
                                result +='</div>';
                                result +='</div>';
                                if(data.rows[i].replyContent){
                                    result +='<div class="answer">商家回复：'+data.rows[i].replyContent+'</div>';
                                }else {
                                    result +='<div class="answer" style="display: none"></div>';
                                }
                                result +='</li>';
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
    }
    
    function getAccountInfo(){
    	$.ajax({
                type: 'GET',
                url: '${ctx}/m/product/reviewAccountInfo?productId=${productId}',
                dataType: 'json',
                success: function(data){
                	if(data!=null){
                		var scoreValue = Math.round(data.matchScoreAvg);
                		var htmlStr='<li><div class="fl" ><span class="review-starbig review-starbig-'+scoreValue+'"><b></b>'
                					+'</span><i>'+data.matchScoreAvg+'</i></div><div class="fr">'
                					+'<a href="consulting.html?productId=${productId!}" class="orange">咨询</a></div></li>'
                    				+'<li>'+data.reviewTotal+'人评价</li>';
                		$("#reviewAccount").append(htmlStr);
                	}
                }
          });
    }
    
    //转换JSON数据中的时间为标准时间
	function ConvertJSONDateToJSDateObject(JSONDateString) {
	    var date = new Date(parseInt(JSONDateString));
	    return date;
	}
    
</script>
</body>
</html>