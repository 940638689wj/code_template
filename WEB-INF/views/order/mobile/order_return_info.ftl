<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>退换货订单</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account"></a>
        <h1 class="mui-title">退换货订单</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <div class="skutabbar">
            <ul>
                <li <#if type==1>class="selected"</#if>><a href="${ctx}/m/account/orderReturnInfo?type=1">未完成</a></li>
                <li <#if type==2>class="selected"</#if>><a href="${ctx}/m/account/orderReturnInfo?type=2">已完成</a></li>
            </ul>
        </div>
        <div id="pullrefresh" class="mui-content mui-scroll-wrapper">
            <div class="mui-scroll">
                <div class="orderList">
                    <ul>
                    </ul>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    $(function () {
        getContentHeight();
        pullupRefresh();
        mui('.mui-content').on('tap', 'a', function () {
            document.location.href = this.href;
        });
    });

    $(window).resize(function () {
        getContentHeight();
    })

    function getContentHeight() {
        var muiBar = $(".mui-bar").height() || 0;
        var skutabbar = $(".skutabbar").height() || 0;
        $(".mui-scroll-wrapper").css("top", muiBar + skutabbar);
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
    var pageSize = 5;
    var type = ${type};
    function pullupRefresh() {
        pageNo++;
        $.ajax({
            url: "${ctx}/m/account/orderReturnInfo/findListByLimit",
            data: {
                pageNo: pageNo,
                pageSize: pageSize,
                type: type
            },
            dataType: "json",
            success: function (data) {
                if (data.result == "true") {
                    var list = data.resultList;
                    var table = document.body.querySelector('.orderList ul');
                    var cells = document.body.querySelectorAll('.list');
                    for (var i = 0; i < list.length; i++) {
                        var orderItemList = list[i].orderItemList;
                        var li = document.createElement('li');
                        li.className = 'list';
                        var quantitySum = 0;//该订单商品总数
                        var itemInfo = '';

                        //遍历该订单下的商品
                        for (var j = 0; j < orderItemList.length; j++) {
                            quantitySum += orderItemList[j].quantity;
                            //超过三个商品省略
                            if (j < 3) {
                                var productName = orderItemList[j].productName;
                                //商品名长度超过15省略
                                if (productName.length > 15) {
                                    productName = productName.substring(0, 15) + "...";
                                }
                                itemInfo += '<p><span>' + productName + '</span>'
                                        + '<em>x' + orderItemList[j].quantity + '</em></p>';
                            }
                        }
                        if (orderItemList.length > 3) {
                            itemInfo += '<p><span>...</span></p>';
                        }
                        li.innerHTML = '<div class="hd"><p class="time">' + format(list[i].orderHeaderDTO.createTime, 'yyyy-MM-dd HH:mm:ss') + '</p>'
                                //+ '<p class="state">'+list[i].orderHeaderDTO.headerStatusName+'</p>'
                                + '</div>'
                                + '<div class="bd">'
                                + '<a href="${ctx}/m/account/orderReturnInfo/orderReturnDetail?orderId='
                                + list[i].orderHeaderDTO.orderId
                                + '&type='
                                + type
                                + '">'
                                + itemInfo
                                + '<p><span></span><em>共' + quantitySum + '件商品，金额￥<strong>' + list[i].totalReturn + '</strong></em></p>'
                                + '</a>'
                                + '</div>'
                                + '<div class="bt"></div>';
                        table.appendChild(li);
                        mui('#pullrefresh').pullRefresh().endPullupToRefresh(false);
                    }
                } else if (data.result == "false") {
                    mui('#pullrefresh').pullRefresh().endPullupToRefresh(true);
                }
            }
        });

    }
    if (mui.os.plus) {
        mui.plusReady(function () {
            setTimeout(function () {
                mui('#pullrefresh').pullRefresh().pullupLoading();
            }, 1000);

        });
    }

    //取消订单
    function cancelOrder(orderId) {
        var btnArray = ['否', '是'];
        mui.confirm('', '确认取消该订单？', btnArray, function (e) {
            if (e.index == 1) {
                $.post("${ctx}/m/account/orderHeader/cancelOrderHeader", {
                    orderId: orderId
                }, function (data) {
                    if (data && data.result == "success") {
                        window.location.href = "${ctx}/m/account/orderHeader?type=${type}"
                    } else {
                        mui.toast("取消失败，请稍后重试！");
                    }
                }, "json");
            }
        })
    }

    var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                hideSpecAS();
            }).appendTo(document.body),
            specAS = $("#methodpayment");

    //支付订单号
    var orderNumber = "";

    //打开支付窗口
    function showSpecAS(num) {
        orderNumber = num;
        specASMask.show().animate({opacity: 1}, {
            duration: 80,
            complete: function () {
                specAS.css({
                    top: "100%",
                    opacity: 0,
                    display: "block"
                }).animate({
                    opacity: 1,
                    translateY: "-" + specAS.height() + "px"
                }, {
                    duration: 200,
                    easing: "ease-in-out"
                });
            }
        });
    }

    //关闭支付窗口
    function hideSpecAS(callback) {
        specAS.animate({
            opacity: 0,
            translateY: 0
        }, {
            duration: 200,
            easing: "ease-in-out",
            complete: function () {
                specAS.hide();
                specASMask.animate({opacity: 0}, {
                    duration: 80,
                    complete: function () {
                        specASMask.hide();
                        if (typeof callback == "function") callback.call();
                    }
                });
            }
        });
    }

    function submitOrder(payWay) {
        location.href = "${ctx}/m/account/order/goToOrderPayment?orderNumber=" + orderNumber + "&payWay=" + payWay;
    }

    specAS.find(".close").on("click", function () {
        hideSpecAS();
    });
    $(".btn-buy").on("click", function () {
        hideSpecAS();
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
    }
</script>
</body>
</html>