<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<html>
<head>
    <title>我的团购券</title>
    <script type="text/javascript" src="${staticResourcePath}js/dropload.js"></script>
    <style>[v-cloak] {
        display: none
    }</style>
</head>
<body>
<div id="page" v-cloak="">
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
                <li v-for="(typeName,index) in typeNameList" v-bind:class="{selected:type == index}">
                    <a href="javascript:void(0)" v-on:click="type = index">{{typeName}}</a>
                </li>
            </ul>
        </div>
        <div class="financiallistWrap">
            <div class="delivery">
                <ul>
                    <li :class="liclass" v-for="groupon in @promotionGrouponList"">
                        <div class="hd">
                            <div class="l"><div class="wrap"><img src="images/delivery_codeimg.png" data-preview-src="images/sis-qrcode.jpg" data-preview-group="1" /></div></div>
                            <div class="r"><h3>满减优惠券</h3><p>限18030076543使用</p><p>有效期至 2017.03.15</p></div>
                        </div>
                        <div class="bd"><div class="wrap"><a href="#">未使用</a></div></div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<script src="${staticResourcePath}js/mui/mui.zoom.js"></script>
<script src="${staticResourcePath}js/mui/mui.previewimage.js"></script>
<script>
    mui('body').on('tap','a',function(){document.location.href=this.href;});
    var vm = new Vue({
        el : '#app',
        data: {
            promotionGrouponList:[],
            typeNameList: ['未使用'，'已使用'],
            type:${type!0},
            isEmpty: false
        },
        computed: {
            liclass: function(){
                if(this.type == 0){
                    return [];
                }else if(this.type == 1){
                    return ["used"]
                }

            }
        }
    },
        methods: {

        },
        watch: {
            type: function(){
                this.promotionGrouponList = [];
                Vue.nextTick(function(){
                    page = 0;
                    $(".dropload-down").remove();
                    jsonData();
                })
            }


        }
    });
    var page = 0;
    var pageSize = 4;
    function jsonData(){
        $('.financiallistWrap').dropload({
            scrollArea : window,
            domDown : {
                domClass   : 'dropload-down',
                domRefresh : '<div class="dropload-refresh">↑上拉加载更多</div>',
                domLoad    : '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData  : '<div class="dropload-noData">暂无数据</div>'
            },
            loadDownFn: function (me) {
                page++;
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/account/group/findListByLimit',
                    data: {
                        pageNo: page,
                        pageSize: pageSize,
                        type: app.type
                    },
                    dataType: 'json',
                    success: function (data) {
                        if(data.result ==true) {
                            app.promotionGrouponList.push.apply(app.promotionGrouponList, data.promotionGrouponList);
                        } else {
                            app.isEmpty = true;
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function () {
                            me.resetload();
                        }, 1000)

                    },
                    error: function (xhr, type) {
                        me.resetload();
                    }
                });
            }
    })

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