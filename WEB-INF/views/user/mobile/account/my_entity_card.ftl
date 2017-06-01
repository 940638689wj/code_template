<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
	<title>充值卡</title>  
</head>
<body>
<div id="page">
	<#if showTitle?? && showTitle>
		<header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
	        <h1 class="mui-title">我的充值卡</h1>
	        <a class="mui-icon"></a>
	    </header>
    </#if>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li <#if cardTypeCd==1>class="selected"</#if>><a href="${ctx}/m/account/entityCard/toEntityCard?cardTypeCd=1">现金卡</a></li>
                <li <#if cardTypeCd==2>class="selected"</#if>><a href="${ctx}/m/account/entityCard/toEntityCard?cardTypeCd=2">积分卡</a></li>
            </ul>
        </div>

        <div class="iconinfo" style="display: none">
            <i class="ico ico-info"></i>
            <strong>没有充值卡</strong>
        </div>

        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <div class="cards">
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
    var cardTypeCd  = ${cardTypeCd!};
    
    var url = "${imageUrl!}";

    function pullupRefresh() {
        pageNo++;
        $.ajax({
            url: "${ctx}/m/account/entityCard/toEntityCard/findListByLimit",
            data: {
                pageNo: pageNo,
                pageSize: pageSize,
            
              	cardTypeCd : cardTypeCd   //1:现金卡  2积分卡
            },
            dataType: "json",
            success: function (data) {
                if(data.result=="true"){
                    var list = data.entityCardDTOList;
                    var table = document.body.querySelector('.cards ul');
                    var cells = document.body.querySelectorAll('.list');
                    for (var i = 0 ; i < list.length ; i++) {
                        var clsName = '';
                        var endDate = format(list[i].endDate, 'yyyy/MM/dd');
  						var value = '';
  						
  						if(cardTypeCd == 1){
  							value = '¥'+list[i].value
  						}else{
  							value = list[i].value+'积分'
  						}
  						
                        var li = document.createElement('li');
                        li.className = 'list';
                        li.innerHTML = '<li class="'
                        				+ clsName+
                        				'">'
                        				+'<div class="rechargecard card-credit">'
                        				+'<div class="card-box">'
                        				+'<div class="front" style="background-image:url('
                        				+url+');">'
                        				+'<div class="card-value">面值<em>'
                        				+ value + '</em></div>'
                        				+'<div class="card-period">有效期:<em>'
                        				+endDate+ '</em></div>'
                        				+'<div class="card-num">卡号:<em>'
                        				+list[i].cardNum+'</em></div>'
                        				+'<div class="card-psw">'
                        				+list[i].password+'</div>'
                        				+'</div>'
                        				+'</div>'
                        				+'</div>'
 
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