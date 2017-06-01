<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html>
<head>
    <title>我的提货券</title>
    <script type="text/javascript" src="${staticResourcePath}js/dropload.js"></script>
</head>
<div id="page">
	<#if showTitle?? && showTitle>
	    <header class="mui-bar mui-bar-nav">
	        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/myWallet"></a>
	        <h1 class="mui-title">我的提货券</h1>
	        <a class="mui-icon"></a>
	    </header>
	</#if> 
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li <#if usedStatusCd == 1>class="selected"</#if> ><a href="${ctx}/m/pickup/showDelivery?usedStatusCd=1">未使用</a></li>
                <li <#if usedStatusCd == 2>class="selected"</#if> ><a href="${ctx}/m/pickup/showDelivery?usedStatusCd=2">已使用</a></li>
            </ul>
        </div>
        <div class="financiallistWrap">
            <div class="delivery">
                <ul>
                </ul>
            </div>
        </div>
    </div>
</div>
<script src="${staticResourcePath}js/mui/mui.zoom.js"></script>
<script src="${staticResourcePath}js/mui/mui.previewimage.js"></script>
<script>
mui('body').on('tap','a',function(){document.location.href=this.href;});

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
                    url: '${ctx}/m/pickup/pickupCouponJson?pageNo='+pageNo+'&pageSize='+pageSize,
                    dataType: 'json',
                    data : {
                    	'pageNo':pageNo,
                    	'pageSize':pageSize,
                    	'usedStatusCd' : ${usedStatusCd}
                    },
                    success: function(data){
                    	if(data.result == "true"){
	                        var arrLen = data.pickupCouponDTOList.length;
	                        if(arrLen > 0){
	                            for(var i=0; i<data.pickupCouponDTOList.length; i++){
	                            var content = 'num:'+data.pickupCouponDTOList[i].pickupCouponCodeNum+'_password:'+data.pickupCouponDTOList[i].pickupCouponPassword;
	                                if (data.pickupCouponDTOList[i].usedStatusCd==2 ||(data.pickupCouponDTOList[i].usedStatusCd==1 && data.pickupCouponDTOList[i].isPast == 2)) {
	                                    result += '<li class="used">';
	                                }else{
	                                    result +='<li>';
	                                }
	                                result +='<div class="hd">' +
	                                        '<div class="l"><div class="wrap"><img src="${ctx}/static/mobile/images/delivery_codeimg.png" data-preview-src="${ctx}/qrCode/generate?content='+content+'" data-preview-group="'+(i+1)+'" /></div></div>'+
	                                        '<div class="r"><h3>'+data.pickupCouponDTOList[i].pickupCouponName+'</h3><p>限'+data.pickupCouponDTOList[i].userPhone+'使用</p><p>有效期至'+format(data.pickupCouponDTOList[i].allowUseEndTime,'yyyy-MM-dd HH:mm:ss')+'</p></div>'+
	                                        '</div>';
	                                if (data.pickupCouponDTOList[i].usedStatusCd==2) {
	                                    result +='<div class="bd"><div class="wrap"><a href="javascript:void(0);">已兑换</a></div></div>';
	                                }else if(data.pickupCouponDTOList[i].usedStatusCd==1 && data.pickupCouponDTOList[i].isPast == 1 ){
	                                    result +='<div class="bd"><div class="wrap"><a href="${ctx}/m/pickup/selectPackage?pickupCouponCodeId='+data.pickupCouponDTOList[i].pickupCouponCodeId+'">去兑换</a></div></div>';
	                                }else if(data.pickupCouponDTOList[i].usedStatusCd==1 && data.pickupCouponDTOList[i].isPast == 2){
	                                	result +='<div class="bd"><div class="wrap"><a href="javascript:void(0);">已过期</a></div></div>';
	                                }
	                                result +='</li>';
	                            }
                            }
                        }else{
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function(){
                            $('.delivery ul').append(result);
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
     mui.previewImage();
  
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
		//
</script>

</body>
</html>