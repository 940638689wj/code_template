<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
    <!--<meta charset="UTF-8">-->
    <title>评价</title>
    <!--<meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>-->
</head>
<body>
    <div id="page">
        <#if showTitle?? && showTitle>
	        <header class="mui-bar mui-bar-nav">
	            <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
		            <h1 class="mui-title">评价</h1>
	            <a class="mui-icon"></a>
	        </header>
        </#if>

        <div class="mui-content">
            <div class="returnbox">
                <div class="return">
                    <ul class="comment procomment" >
                    <#if sumInfo??>
                        <li><div class="fl"><span class="review-starbig review-starbig-${(sumInfo.productMatchScoreAvg)!}"><b></b></span><i>${(sumInfo.productMatchScoreAvg)!}</i></div><div class="fr">${(sumInfo.mainReviewCnt)!}人评价</div></li>
                    </#if>
                    </ul>
                    <ul class="return-type">
                        <a href="${ctx}/m/product/reviewList?productId=${(productId)!}&type=0"><li <#if type=='0'>class="selected"</#if> >全部</li></a>
                        <a href="${ctx}/m/product/reviewList?productId=${(productId)!}&type=1"><li <#if type=='1'>class="selected"</#if> > 好评</li></a>
                        <a href="${ctx}/m/product/reviewList?productId=${(productId)!}&type=2"><li <#if type=='2'>class="selected"</#if> >中评</li></a>
                        <a href="${ctx}/m/product/reviewList?productId=${(productId)!}&type=3"><li <#if type=='3'>class="selected"</#if> >差评</li></a>
                    </ul>
                </div>
            </div>
            <div class="commentWrap">
                <div class="mui-scroll">
                    <div class="review-list">
                    <div class="reviewitem">
                    	<#if productReviewDTOList??>
                        <ul class="comment-table-items" >
                        	<#list productReviewDTOList as pro>
                           <li>
                                <div class="clearbox">
                                    <div class="hd" style="background-image: url('${(pro.headPortraitUrl)!}');"></div>
                                    <div class="bd">
                                        <h3>${(pro.reviewerName)!}</h3>
                                        <p><em class="fl">${(pro.reviewTime)?string('yyyy-MM-dd HH:mm:ss')}</em><em class="fr"><span class="review-star review-star-${((pro.productMatchScore)!'0')*2}"><b></b></span></em></p>
                                    </div>
                                </div>
                                <div class="comments-text">${(pro.reviewContent)!}</div>
                                <#if pro.pics??>
                                <div class="comments-img">
                                	<#list pro.pics?split(",") as pic>
                                    <div class="imgItems"><img src="${(pic)!}"></div>
                                    
                                  	</#list>
                                </div>
                                </#if>
                                <#if (pro.replyContent)?has_content>
                                <div class="answer">【客服】回复:${pro.replyContent!?html}</div>
                                </#if>
                                <#if (pro.productReviewDTO)?has_content>
                                	<#assign productReviewDTO = pro.productReviewDTO>
                                	<div class="additional">追加评价</div>
                                	<div class="comments-text">${productReviewDTO.reviewContent}</div>
                                	<#if (productReviewDTO.pics)?has_content>
	                                	<div class="comments-img">
		                                	<#list productReviewDTO.pics?split(",") as pics>
		                                    	<div class="imgItems"><img src="${(pics)!}"></div>
		                                  	</#list>
		                                </div>
	                                </#if>
	                                <#if (productReviewDTO.replyContent)?has_content>
                                		<div class="answer">-----</div>
                                	</#if>
                                </#if>
                            </li>
                            </#list>
                          
                        </#if>
                    </div>
                </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript" src="${staticResourcePath}js/mui/mui.pullToRefresh.js"></script>
<script type="text/javascript" src="${staticResourcePath}js/mui/mui.pullToRefresh.material.js"></script>
<script>
    $(function(){
    	getContentHeight();
        //document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
    })
    
    $(window).resize(function(){
        getContentHeight();
    })

    function getContentHeight(){
        var muiBar = $(".mui-bar").height() || 0,
            returnbox =  $(".returnbox").height() || 0;
        $(".commentWrap").css("top",muiBar+returnbox);
    }
    
    
    mui.init();
    var i=1;
    
    (function($) {
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
        //阻尼系数
        $('.commentWrap').scroll({
            bounce: true,
            indicators: true, //是否显示滚动条
            deceleration:0.0009
        });
        $.ready(function() {
            //循环初始化所有下拉刷新，上拉加载。
            $.each(document.querySelectorAll('.commentWrap .mui-scroll'), function(index, pullRefreshEl) {
                $(pullRefreshEl).pullToRefresh({
                    up: {
                        callback: function() {
                            var self = this;
                            setTimeout(function() {
                                var ul = self.element.querySelector('.comment-table-items');
                                createFragment(ul,i, 10);
                                self.endPullUpToRefresh();
                            }, 1000);
                        }
                    }
                });
            });
            var createFragment = function(ul,index, size) {
            	i++;
                var length = ul.querySelectorAll('li').length;
                var fragment = document.createDocumentFragment();
                var li;
                $.post('${ctx}/m/product/getReviewList',{productId:${(productId)!},type:${type},size:10,index:index},function(data){
                	$.each(data,function(i,pro){
                		var name=pro.reviewerName!=null?pro.reviewerName:' ';
                		var str='';
                	 	li = document.createElement('li');
                    	str+='<div class="clearbox">'+
                    	'<div class="hd" style="background-image: url("'+pro.headPortraitUrl+'");"></div>'+
                    	'<div class="bd">'+
                    		'<h3>'+name+'</h3>'+
                    		'<p><em class="fl">'+format(pro.reviewTime, 'yyyy-MM-dd HH:mm:ss')+'</em><em class="fr"><span class="review-star review-star-'+pro.productMatchScore*2+'"><b></b></span></em></p>'+
                    		'</div>' +
                            '</div>' +
                            '<div class="comments-text">'+pro.reviewContent+'</div>' ;
                    	if(pro.pics!=null){
                    	str+='<div class="comments-img">';
                    	var pics=pro.pics;
                    		$.each(pics.split(","),function(i,item){
                    		str+='<div class="imgItems">';
                    		str+='<img src="'+item+'"/>';
                    		str+='</div>';
                    		});
                    	str+='</div>';
                    	}
                    	
                    	str+='<div class="answer">【客服】回复:'+pro.replyContent+'</div>'
						li.innerHTML=str;
						fragment.appendChild(li);
						ul.appendChild(fragment);
                	});
                });
            };
        });
    })(mui);
</script>
</body>
</html>