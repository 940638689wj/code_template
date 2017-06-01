<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
    <title>会员业绩 - 厦航商城</title>
    <!-- 时间插件和样式 -->
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui.picker.min.css" />
    <script src="${ctx}/static/mobile/js/mui.picker.min.js"></script>
    <!--下拉获取数据插件 -->
    <script type="text/javascript" src="${ctx}/static/mobile/js/dropload.js"></script>
    <!--日期格式化插件 -->
    <script type="text/javascript" src="${ctx}/static/mobile/js/dateFormate1.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/performance"></a>
        <h1 class="mui-title">下级会员业绩</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
    	<!--freeMarker预先存储userId -->
    	<input id="userId" type="hidden" value="${userId!}"></input>
        <div class="junior-member">
	        <i style="background-image: url(<#if getHeadPortraitUrl?? && getHeadPortraitUrl?has_content>${ctx}${getHeadPortraitUrl}<#else>${ctx}/static/images/icon_member.png</#if>);"></i>
	        ${phone}
        </div>
        <div class="searchdate">
            <div class="bd"><button class="mui-btn mui-btn-block mui-btn-primary">搜索</button></div>
            <div class="hd">
                <p>
                	<input id="startTime" type="text" data-options='{"type":"date"}' class="btn" placeholder="年/月/日">
                </p>
                <span>至</span>
                <p>
                	<input id="endTime" type="text" data-options='{"type":"date"}' class="btn" placeholder="年/月/日">
                </p>
            </div>
        </div>
        <div class="financiallistWrap">
            <div class="recordList Pfm-details">
                <h3 class="title">业绩明细</h3>
                <ul>
                	<!--
                    <li>
                        <div class="r">239</div>
                        <div class="l">消费¥2390.00</div>
                        <p><span class="btn disabled">未结算</span>2015-07-15 12:15:07</p>
                    </li>
                    -->
                </ul>
            </div>
        </div>
    </div>
</div>
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
        var page = 0;
        // 每页展示5个
        var size = 10;
        //下拉加载
        var userId = $("#userId").val();
        var startTime = $("#startTime").val();
        var endTime = $("#endTime").val();
        dropDownToLoad(userId, startTime, endTime, page, size);
        $('.mui-btn-primary').on('click',function(){
        	$(".financiallistWrap li").remove();
        	$(".dropload-down").remove();
        	startTime = $("#startTime").val();
        	endTime = $("#endTime").val();
        	dropDownToLoad(userId, startTime, endTime, page, size);
        })
    });
    
    //下拉加载数据
    function dropDownToLoad(userId, startTime, endTime, pageNo, pageSize){
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
	                url: '${ctx}/m/account/performance/getMyCustomerPerformance',
	                data:{userId:userId, startTime:startTime, endTime:endTime, pageNo:pageNo, limit:pageSize},
	                dataType: 'json',
	                success: function(data){
	                	//console.log(data);
	                    var arrLen = data.customerPerformanceList.length;
	                    if(arrLen > 0){
	                        for(var i=0; i<data.customerPerformanceList.length; i++){
	                            result += '<li>'
	                                      + '<div class="r">'+data.customerPerformanceList[i].rebateProductPoint+'</div>'
	                                      + '<div class="l">消费¥'+data.customerPerformanceList[i].orderTotalAmt+'</div>'
	                                      + '<p>'+(data.customerPerformanceList[i].createTime == null ? '' : Format(ConvertJSONDateToJSDateObject(data.customerPerformanceList[i].createTime),"yyyy-MM-dd HH:mm:ss"))+'</p>'
	                                      + '</li>';
                                        <#-- result += '<p><span class="btn disabled">已结算</span>'+data.lists[i].time+'</p>';-->
                                        <#-- result +='<p><span class="btn">未结算</span>'+data.lists[i].time+'</p>'; -->
	                        }
	                    }else{
	                        me.lock();
	                        me.noData();
	                    }
	                    $('.recordList ul').append(result);
	                    me.resetload();
	                },
	                error: function(xhr, type){
	                    me.resetload();
	                }
	            });
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