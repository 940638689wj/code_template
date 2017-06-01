<#assign ctx = request.contextPath>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>众筹商品</title>
    <script type="text/javascript" src="${ctx}/static/mobile/js/dropload.js"></script>
</head>
<body>

<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" onclick="history.go(-1)"></a>
        <h1 class="mui-title">所有众筹商品</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li <#if isTaked==0>class="selected"</#if>><a href="/m/crowdfunding/list?isTaked=0">众筹中</a></li>
                <li <#if isTaked==1>class="selected"</#if>><a href="/m/crowdfunding/list?isTaked=1">已揭晓</a></li>
            </ul>
        </div>
        <div class="financiallistWrap">
            <div class="prd-list">
                <ul id="productListUl">
                    <#--<li>
                        <a href="goods_detail.html">
                            <div class="pic">
                                <img src="images/goodspic.jpg">
                            </div>
                            <div class="r">
                                <p class="name">商品标题商品标题商品标题…</p>
                                <div class="price">
                                    <div class="price-real">¥<em>6.90</em></div>
                                </div>
                                <div class="funding-progress">
                                    <div class="progressbar"><span style="width: 68%;"></span></div>
                                    <div class="count count-total">
                                        <em>9888</em><span>总需人次</span>
                                    </div>
                                    <div class="count count-current">
                                        <em>4944</em><span>已参与</span>
                                    </div>
                                    <div class="count count-remain">
                                        <em>4944</em><span>剩余</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </li>-->
                </ul>
            </div>
        </div>
    </div>
</div>
<script>
    // 页数
    var pageNo = 0;
    // 每页展示10个
    var limit = 5;
    var isTaked = ${isTaked};

    $(function(){
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
                    url: '/m/crowdfunding/list/jsonData.html',
                    data: {pageNo: pageNo, limit: limit, isTaked: isTaked},
                    dataType: 'json',
                    success: function(data){
                        //$('#productListUl').empty();
                        var pageDTO = data.pageDTO;
                        var productList = pageDTO.content;
                        if(productList && productList.length > 0){
                            result = renderListData(productList);
                        }else{
                            me.lock();
                            me.noData();
                        }

                        setTimeout(function(){
                            $('.prd-list ul').append(result);
                            me.resetload();
                        },1000);
                    },
                    error: function(xhr, type){
                        me.resetload();
                    }
                });
            }
        });
    });

    function renderListData(productList){
        var appendContent = "";

        $.each(productList, function(i,val){
            appendContent = appendContent + '<li>';
            appendContent = appendContent + '<a href="/m/crowdfunding/detail/'+val.promotionId+'.html">';
            appendContent = appendContent + '<div class="pic">';
            appendContent = appendContent + '<img src="'+val.productPicUrl+'">';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '<div class="r">';
            appendContent = appendContent + '<p class="name">'+val.productName+'</p>';
            appendContent = appendContent + '<div class="price">';
            appendContent = appendContent + '<div class="price-real">¥<em>'+val.crowdFundProductAmt+'</em></div>';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '<div class="funding-progress">';
            appendContent = appendContent + '<div class="progressbar"><span style="width: '+eval(val.speedProgress*100)+'%;">'+val.speedProgress+'%</span></div>';
            appendContent = appendContent + '<div class="count count-total">';
            appendContent = appendContent + '<em>'+val.totalNeedTimes+'</em><span>总需人次</span>';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '<div class="count count-current">';
            appendContent = appendContent + '<em>'+val.hasJoinTimes+'</em><span>已参与</span>';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '<div class="count count-remain">';
            appendContent = appendContent + '<em>'+val.remainTimes+'</em><span>剩余</span>';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '</div>';
            appendContent = appendContent + '</a>';
            appendContent = appendContent + '</li>';
        });

        //$('#productListUl').append(appendContent);
        return appendContent;
    }
</script>
</body>
</html>