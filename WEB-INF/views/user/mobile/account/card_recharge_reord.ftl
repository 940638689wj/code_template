<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>充值记录</title>
    <script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/myWallet"></a>
        <h1 class="mui-title"><#if cardTypeCd == 1>现金卡充值记录<#else>积分卡充值记录</#if></h1>
        <a class="mui-icon"></a>
    </header>
</#if>

   <div class="mui-content">
        <div class="financiallistWrap">
            <div class="recordList">
                <h3 class="title">充值记录</h3>
                <ul>
                </ul>
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.picker.min.css" />
<script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
<script>
    (function($) {
        $.init();
        //var result = $('#result')[0];
        var btns = $('.btn');
        btns.each(function(i, btn) {
            btn.addEventListener('tap', function() {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                var obj = this;
                var picker = new $.DtPicker(options);
                picker.show(function(rs) {
                    obj.value = rs.text;
                    picker.dispose();
                });
            }, false);
        });
    })(mui);


    $(function(){
        // 页数
        var pageNo = 0;
        // 每页展示5个
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
                    url: '${ctx}/m/account/entityCardRecharge/recordList',
                    dataType: 'json',
                    data : {
                    	'pageNo':pageNo,
                    	'pageSize': pageSize,
                    	'cardTypeCd':${cardTypeCd}
                    },
                    success: function(data){
                   	 if(data.result == "true"){
	                        var arrLen = data.list.length;
	                        if(arrLen > 0){
	                            for(var i=0; i<data.list.length; i++){
	                                result += '<li>';
	                                if (${cardTypeCd} == 1) {
	                                    result += '<div class="r">'+data.list[i].balanceIncome+'</div>';
	                                }else{
	                                    result +='<div class="r colorgreen">'+data.list[i].scoreIncome+'</div>';
	                                }
	                                result +='<div class="l">'+data.list[i].remark+'</div>';
	                                result +='<p>'+format(data.list[i].createTime,'yyyy-MM-dd HH:mm:ss')+'</p>';
	                                result +='</li>';
	                            }
                           }
                        }else{
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function(){
                            $('.recordList ul').append(result);
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                     //   me.resetload();
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