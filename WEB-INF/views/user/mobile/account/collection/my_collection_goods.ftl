<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html lang="en">
<head>
	<title>我的收藏</title>   
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/memberCenter"></a>
        <h1 class="mui-title">我的收藏</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <div class="borderbox">
                    <ul class="prd-list">
                        
                    </ul>
                </div>
            </div>
        </div>
        <div class="iconinfo" style="display: none">
            <i class="ico ico-info"></i>
            <strong>亲，您还有收藏记录!</strong>
        </div>
    </div>

</div>
<script>
    $(function(){
        getContentHeight();
        pullupRefresh();
        imglazyload();
        mui('body').on('tap','a',function(){document.location.href=this.href;});
        $(document).on("tap",'.cancelcollection',function(){
            var obj = $(this);
            var i=obj.attr("id");
            
            var btnArray = ['确认', '关闭'];
            mui.confirm('', '是否确认取消？', btnArray, function(e) {
                if (e.index == 0) {
	                	//alert(i);
	                	$.ajax({
		        		url  : '${ctx}/m/product/collect',
		            	async : true,
		            	type : "GET",
		    			dataType : "json",
		    			data : {"productId" : i, "isCollect" : 0},
		    			success : function(result) {
			    				if(result.result == 'success') {
						                obj.closest("li").remove();
		                    			mui.toast('成功取消收藏');
			    				}
			    			},
			    			error:function(XMLHttpResponse ){
			    				console.log("请求未成功");
			    			}
		    			})
                }
            })
        })
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
    var userID = '${(userId)!}';
    var replyContent;
    function pullupRefresh() {
    	pageNo++;
    	$.ajax({
    		url:"${ctx}/m/account/collection/findListByLimitForCollection",
    		data:{
    			userId:userID,
	    		pageNo:pageNo,
	    		pageSize:pageSize
    		},
    		dataType:"json",
    		success:function(data){
    			if(data.result=="true"){
    				var list = data.userCollectDetailList;
	    			var table = document.body.querySelector('.borderbox ul');
			        var cells = document.body.querySelectorAll('.list');
			        for (var i = 0 ; i < list.length ; i++) {
			            var li = document.createElement('li');
			            li.className = 'list';
			            li.innerHTML = 
			            '<div class="pic"><a href="${ctx}/m/product/'+list[i].collectId+
			            '"><img class="lazyload" src="'+list[i].picUrl+
			            '" alt=""/></a>'+
                    	'</div><h3><a href="${ctx}/m/product/'+list[i].collectId+
                    	'">'+list[i].productName+
                    	'</a></h3><p class="price mt18"><span class="price-real">￥<em>'+list[i].defaultPrice+
                    	'</em></span><em class="cancelcollection" id="'+list[i].collectId+
                    	'">取消收藏</em></p>';              
			            table.appendChild(li);
			            mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
			        }
    			} else if(data.result=="false") {
    			    if(pageNo==1) {
                        $(".iconinfo").css("display", "block");
                    }
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
</script>
</body>
</html>