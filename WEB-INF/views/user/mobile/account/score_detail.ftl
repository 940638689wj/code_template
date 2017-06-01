<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>我的积分</title>
    <script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
    <script type="text/javascript" src="${staticPath}/js/vue.min.js"></script>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">我的积分</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <div class="balance-top">
            <h3>当前剩余积分</h3>
            <p>${(totalScore)!0}<span>分</span></p>
            <div class="btnbar">
                <a class="ui-btn" href="${ctx}/m/products/point/list">积分商城</a>
                <a class="ui-btn" href="${ctx}/m/account/userScoreDetail/toExchangeRecord">兑换记录</a>
            </div>
        </div>
        <div class="searchdate">
            <div class="bd">
                <button class="mui-btn mui-btn-block mui-btn-primary" onclick="searchDate()">搜索</button>
            </div>
            <div class="hd">
                <p><input type="text" id="startDate" data-options='{"type":"date"}' class="btn" placeholder="年/月/日"></p>
                <span>至</span>
                <p><input type="text" id="endDate" data-options='{"type":"date"}' class="btn" placeholder="年/月/日"></p>
            </div>
        </div>
        <div class="financiallistWrap">
            <div class="recordList">
                <h3 class="title">积分明细</h3>
                <ul id="tt">
                    <li v-for="score in scoreList">
                        <div class="r" v-if="score.scoreIncome">{{score.scoreIncome}}</div>
                        <div class="r colorgreen" v-if="score.scoreExpend">{{score.scoreExpend}}</div>
                        <div class="l">{{score.remark}}</div>
                        <p>{{score.createTime | time}}</p>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
<link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.picker.min.css"/>
<script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
<script>

    var app = new Vue({
        el: '#page',
        data: {
            scoreList: []
        }
    });

    Vue.filter('time', function (value) {//value为13位的时间戳
        function add0(m) {
            return m < 10 ? '0' + m : m
        }
        var time = new Date(parseInt(value));
        var y = time.getFullYear();
        var m = time.getMonth() + 1;
        var d = time.getDate();
        var h = time.getHours();
        var mi = time.getMinutes();
        var s = time.getSeconds();
        return y + '-' + add0(m) + '-' + add0(d)+ ' ' + add0(h)+ ':' + add0(mi)+ ':' + add0(s);
    });

    (function ($) {
        $.init();
        //var result = $('#result')[0];3
        var btns = $('.btn');
        btns.each(function (i, btn) {
            btn.addEventListener('tap', function () {
                var optionsJson = this.getAttribute('data-options') || '{}';
                var options = JSON.parse(optionsJson);
                var id = this.getAttribute('id');
                var obj = this;
                var picker = new $.DtPicker(options);
                picker.show(function (rs) {
                    obj.value = rs.text;
                    picker.dispose();
                });
            }, false);
        });
    })(mui);


    $(function () {
        pageLimit();
    });
    //搜索
    function searchDate() {
        pageNo = 0;
        $('li').remove();
        $('.dropload-down').remove();
        pageLimit();
    }

    //分页
    function pageLimit() {
        var pageNo = 0;
        // 每页展示5个
        var pageSize = 5;

        var searchStartTime = "";
        var searchEndTime = "";
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
                searchStartTime = document.getElementById("startDate").value;
                searchEndTime = document.getElementById("endDate").value;
                // 拼接HTML
                var result = '';
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/account/userScoreDetail/findListByLimit',
                    dataType: 'json',
                    data: {
                        'pageNo': pageNo,
                        'pageSize': pageSize,
                        'searchStartTime': searchStartTime,
                        'searchEndTime': searchEndTime

                    },
                    success: function (data) {

                        if (data.result == "true") {
                            app.scoreList = app.scoreList.concat(data.userScoreDetailList);
//                        var arrLen = lists.length;
//                        if(arrLen > 0){
//                            for(var i=0; i<lists.length; i++){
//                                result += '<li>';
//                                if (lists[i].scoreIncome) {
//                                    result += '<div class="r">'+lists[i].scoreIncome+'</div>';
//                                }else{
//                                    result +='<div class="r colorgreen">'+lists[i].scoreExpend+'</div>';
//                                }
//                                result +='<div class="l">'+lists[i].remark+'</div>';
//                                result +='<p>'+format(lists[i].createTime,'yyyy-MM-dd HH:mm:ss')+'</p>';
//                                result +='</li>';
//                            }
//                          }
                        } else {
                            me.lock();
                            me.noData();
                        }
                        setTimeout(function () {
                            $('.recordList ul').append(result);
                            me.resetload();
                        }, 1000);
                    },
                    error: function (xhr, type) {
                        //   me.resetload();
                    }
                });
            }
        });
    }

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
    }
</script>
</body>
</html>