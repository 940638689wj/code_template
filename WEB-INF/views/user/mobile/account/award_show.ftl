<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>奖品列表</title>
    <script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/myWallet"></a>
        <h1 class="mui-title">我的奖品</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar skutabbar-order">
            <ul>
                <li <#if awardTypeCd == 1> class="selected" </#if>><a
                        href="${ctx}/m/account/award/showAward?awardTypeCd=1">幸运大转盘</a></li>
                <li <#if awardTypeCd == 3> class="selected" </#if>><a
                        href="${ctx}/m/account/award/showAward?awardTypeCd=3">博饼</a></li>
                <li <#if awardTypeCd == 2> class="selected" </#if>><a
                        href="${ctx}/m/account/award/showAward?awardTypeCd=2">幸运刮刮卡</a></li>
            </ul>
        </div>

        <div class="financiallistWrap">
            <div class="prize-lst">
                <ul>
                </ul>
            </div>
        </div>
    </div>
</div>
<script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
<script>
    $(function () {
        var awardTypeCd = ${awardTypeCd!};
        var pageNo = 0;

        var pageSize = 8;
        // dropload
        $('.financiallistWrap').dropload({
            scrollArea: window,
            domDown: {
                domClass: 'dropload-down',
                domRefresh: '<div class="dropload-refresh">↑上拉加载更多</div>',
                domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData: '<div class="dropload-noData">暂无数据</div>'
            },
            loadDownFn: function (me) {
                pageNo++;
                // 拼接HTML
                var result = '';
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/account/award/awardList',
                    dataType: 'json',
                    data: {
                        pageNo: pageNo,
                        pageSize: pageSize,
                        awardTypeCd: awardTypeCd
                    },
                    success: function (data) {
                        if (data.result == 'true') {
                            for (var i = 0; i < data.awardDTOList.length; i++) {
                                result += '<li>' +
//                                        '<div class="pic"><img src="' + data.awardDTOList[i].itemPicUrl + '"></div>' +
                                        '<h3>' + data.awardDTOList[i].name + '</h3>' +
                                        '<div class="num"><span class="fr">' + format(data.awardDTOList[i].createTime, 'yyyy-MM-dd HH:mm:ss') + '</span>数量：1</div>';
                                result += '<div class="source">' +
                                        '<p>来源：' + data.awardDTOList[i].title + '</p>';
                                if (data.awardDTOList[i].statusCd == 0) {
                                    if(data.awardDTOList[i].winningTypeCd ==4){
                                        result += '<em><a href="/m/account/award/record?id=' + data.awardDTOList[i].id + '">待领取</a></em>';
                                    }else{
                                        result += '<em class="disabled">待领取</em>';
                                    }
                                } else if (data.awardDTOList[i].statusCd == 1) {
                                    result += '<em class="disabled">已领取</em>';
                                } else if (data.awardDTOList[i].statusCd == 2) {
                                    result += '<em class="disabled">已失效</em>';
                                }

                                result += '</div></li>';
                            }
                        } else {

                            me.lock();
                            me.noData();
                        }
                        setTimeout(function () {
                            $('.prize-lst ul').append(result);
                            me.resetload();
                        }, 1000);
                    },
                    error: function (xhr, type) {
                        me.resetload();
                    }
                });
            }
        });
    });

    //格式化日期
    var format = function (time, format) {
        var t = new Date(time);
        var tf = function (i) {
            return (i < 10 ? '0' : '') + i
        };
        return format.replace(/yyyy|MM|dd|HH|mm|ss/g, function (a) {
            switch (a) {
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
    };
</script>

</body>
</html>