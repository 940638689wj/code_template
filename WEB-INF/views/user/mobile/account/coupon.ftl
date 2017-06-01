<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>优惠券</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
	        <h1 class="mui-title">优惠券</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li <#if type==1>class="selected"</#if>><a href="${ctx}/m/account/userPromotion/toCoupon?type=1">未使用</a></li>
                <li <#if type==2>class="selected"</#if>><a href="${ctx}/m/account/userPromotion/toCoupon?type=2">已使用</a></li>
                <li <#if type==3>class="selected"</#if>><a href="${ctx}/m/account/userPromotion/toCoupon?type=3">已过期</a></li>
            </ul>
        </div>

        <div class="iconinfo" style="display: none">
            <i class="ico ico-info"></i>
            <strong>没有优惠券</strong>
        </div>

        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <div class="coupons">
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
    })
    $(window).resize(function(){
        getContentHeight();
    })

    function getContentHeight(){
        var muiBar = $(".mui-bar").height() || 0;
        var balanceTop = $(".mui-bar").height() || 0;
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
    var type = ${type};
    function pullupRefresh() {
        pageNo++;
        $.ajax({
            url: "${ctx}/m/account/userPromotion/findListByLimit",
            data: {
                pageNo: pageNo,
                pageSize: pageSize,
                type: type,
                promotionType : 2  //1：红包 2：优惠券
            },
            dataType: "json",
            success: function (data) {
                if(data.result=="true"){
                    var list = data.promotionDTOList;
                    var table = document.body.querySelector('.coupons ul');
                    var cells = document.body.querySelectorAll('.list');
                    for (var i = 0 ; i < list.length ; i++) {
                        var clsName = '';
                        var enableEndTime = format(list[i].enableEndTime, 'yyyy-MM-dd HH:mm:ss');
                        if(type==3) {
                            clsName = 'coupons03';
                        } else {
                            clsName = 'coupons01';
                            enableEndTime = '<em>' + enableEndTime + '</em>';
                        }
                        var li = document.createElement('li');
                        li.className = 'list';
                        li.innerHTML = ' <li class="'
                                        + clsName
                                        +'">'
                                        + '<a href="javascript:void(0)">'
                                        + '<div class="hd">'
                                        + '<p>'
                                        + list[i].discountDesc
                                        + '</p>'
                                        + '</div>'
                                        + '<div class="bd">'
                                        + '<h3>'
                                        + list[i].promotionName
                                        + '</h3>'
                                        + '<p>'
                                        + list[i].promotionDesc
                                        + '</p>'
                                        + '<span>有效期至：'
                                        + enableEndTime
                                        + '</span>'
                                        + '</div>'
                                        + '</a>'
                                        + '</li>';
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