<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>账户余额</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/userRechargeDetail"></a>
	        <h1 class="mui-title">账户余额</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="mui-content">
            <div class="balance-top">
                <h3>账户余额:</h3>
                <p>￥${userBalance?default(0)}<span>元</span></p>
            </div>
            <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
                <div class="mui-scroll">
                    <div class="recordList">
                        <h3 class="title">收支明细</h3>
                        <ul>
                        </ul>
                    </div>
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
        var balanceTop = $(".balance-top").height() || 0;
        $(".mui-scroll-wrapper").css("top",muiBar+balanceTop);
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

    var pageNo = 0;
    var pageSize = 10;
    function pullupRefresh() {
    	pageNo++;
    	$.ajax({
    		url:"${ctx}/m/account/userBalanceDetail/findListByLimit",
    		data:{
	    		pageNo:pageNo,
	    		pageSize:pageSize
    		},
    		dataType:"json",
    		success:function(data){
    			if(data.result=="true"){
    				var list = data.userBalanceDetailList;
	    			var table = document.body.querySelector('.recordList ul');
			        var cells = document.body.querySelectorAll('.list');
			        for (var i = 0 ; i < list.length ; i++) {
			            var li = document.createElement('li');
			            li.className = 'list';
			            if(list[i].balanceIncome) {
				            li.innerHTML += '<div class="r">+'+list[i].balanceIncome+'</div>';
			            } else if (list[i].balanceExpend) {
                            li.innerHTML += '<div class="r">-'+list[i].balanceExpend+'</div>';
                        }
                        li.innerHTML += '<div class="l">'+list[i].remark+'</div>';
                        li.innerHTML += '<p>'+format(list[i].createTime, 'yyyy-MM-dd HH:mm:ss')+'</p>';
			                            
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