<body class="page-list">
<link rel="stylesheet" href="/static/css/fsboxer.css">

<script src="/static/js/boxer.min.js"></script>
<script src="/static/js/jquery.imagezoom.min.js"></script>
<script src="/static/js/jquery.countdown.js"></script>
<script src="/static/js/jquery.qrcode.min.js"></script>
<script src="/static/js/jquery.SuperSlide.2.1.1.js"></script>
<link rel="stylesheet" href="/static/css/jquery.page.css">
<script type="text/javascript" src="/static/js/jquery.page.js"></script>

<input type='hidden' value='${userId!}' id='userId'/>
<input type='hidden' value='${crowdfunding.requireNum-crowdfunding.currentPeopleNum!}' id='realStock'/>
<input type='hidden' value='${crowdfunding.personalJoinLimit?default(999999)}' id='limitNum'/>
<div id="main">
    <div class="crumb">
        <span class="t">您的位置：</span>
        <a class="c" href="/index.html">首页</a>
        <span class="divide">&gt;</span>
        <a class="c" href="/crowdfunding/list">众筹列表</a>
        <span class="divide">&gt;</span>
        <span>${crowdfunding.promotionName!}</span>
    </div>

    <div class="contents clearfix">
        <div class="info_l">
            <dl>
                <dt><a href="JavaScript:"><img src="${picUrls[0]!}" rel="${picUrls[0]!}" class="jqzoom"/></a></dt>
                <dd>
                    <div class="tb-thumb" id="thumblist">
                        <ul>
                        <#list picUrls as picUrl>
                            <li <#if picUrl_index == 0> class="tb-selected"</#if>><a href="javascript:void(0);"><img
                                    src="${picUrl!}" mid="${picUrl!}" big="${picUrl!}"></a></li>
                        </#list>
                        </ul>
                    </div>
                </dd>
            </dl>
            <div class="pr-links">
                <span class="sharewidget"><i class="ico-share"></i>分享<span class="bdsharebuttonbox"
                                                                           data-tag="share_1"><a class="bds_more"
                                                                                                 data-cmd="more"></a></span></span>
                <a class="socialbtn" href="javascript:void(0);">
                <#if isCollect?? && isCollect==1>
                    <i class="icon ico-unlike"></i>取消收藏
                <#else>
                    <i class="icon ico-liked"></i>收藏商品
                </#if>
                </a>
            </div>
        </div>

        <div class="info_r">
            <div class="proName">
                <h2>${crowdfunding.promotionName!}</h2>
                <p>${crowdfunding.promotionDesc!}</p>
            </div>
            <div class="proDetails">
                <dl class="clearfix">
                    <dt>价值：</dt>
                    <dd>¥${crowdfunding.productAmt!?string('##0.00')}</dd>
                </dl>
                <dl class="clearfix">
                    <dt>众筹价格：</dt>
                    <dd>
                        <span class="price-real">¥${crowdfunding.perAmt!?string('##0.00')}</span>
                    </dd>
                </dl>
                <div class="crowd-funding-progress">
                    <div class="progressbar"><span style="width: ${percent?string.number}%;"></span></div>
                    <div class="count count-total">
                        <em>${crowdfunding.requireNum!}</em><span>总需人次</span>
                    </div>
                    <div class="count count-current">
                        <em>${crowdfunding.currentPeopleNum!}</em><span>已参与人次</span>
                    </div>
                    <div class="count count-remain">
                        <em>${crowdfunding.requireNum-crowdfunding.currentPeopleNum}</em><span>剩余人次</span>
                    </div>
                </div>
                <div class="detail-qrcode">
                    <p>手机购买</p>
                    <div class="qrcode">
	                        <span id="qrcode">
	                        <span class="ui-arrow"></span>
                    </div>
                </div>
            </div>
            <div class="proList_box noborder">
                <dl class="meta-item meta-amount">
                    <dt class="metatit">我要参与：</dt>
                    <dd>
                            <span id='countBtn' class="amount-widget">
	                            <input type="number" class="textfield" id="count" value=1 onchange='checkNum()'>
	                            <span class="increase <#if crowdfunding.requireNum-crowdfunding.currentPeopleNum lte 1>increase-disabled</#if>"></span>
	                            <span class="decrease decrease-disabled"></span>
	                        </span>
                        <em>人次</em>
                        <em class="text-orange">（ 购买人次越多获得几率越大哦！）</em>
                    </dd>
                </dl>
            </div>
            <div class="proList-action">
                <div class="btn-buy <#if (crowdfunding.currentPeopleNum >= crowdfunding.requireNum) || crowdfunding.endTime?date lt .now?date >disabled</#if>" id='buyBtn'><a href="#">立即参与众筹</a></div>
            </div>
            <div class="crowdRecord">
                <span>最新众筹记录：</span>
                <div class="hd">
                    <ul>
                        <#if record?? && (record?size > 0)>
                            <#list record as item>
                                <li>${item.userName?substring(0,3)}****${item.userName?substring(item.userName?length-4)} （IP:${item.ip}） 购买了<em>${item.quantity}</em>人次</li>
                            </#list>
                        <#else>
                            <li>暂无购买记录</li>
                        </#if>
                    </ul>
                </div>
            </div>
        </div>

    </div>

    <div class="showAdds">
        <div class="showAddsLeft fll">
            <div class="showLeftCon">
                <h3>热销商品</h3>
                <ul>
                <#if hotProductList?? && hotProductList?has_content>
                    <#list hotProductList as hotProduct>
                        <li><a href="/product/${hotProduct.productId!}">
                            <div class="sPic"><img src="${hotProduct.picUrl!}"></div>
                            <div class="sbox"><p>${hotProduct.productName!}</p><span>¥${hotProduct.defaultPrice!}</span>
                            </div>
                        </a>
                        </li>
                    </#list>
                </#if>
                </ul>
            </div>

            <div class="showLeftCon">
                <h3>最近浏览的商品</h3>
                <ul>
                <#if historyProductList?has_content>
                    <#list historyProductList as historyProduct>
                        <li><a href="/product/${historyProduct.productId!}">
                            <div class="sPic"><img src="${historyProduct.picUrl!}"></div>
                            <div class="sbox"><p>${historyProduct.productName!}</p>
                                <span>¥${historyProduct.defaultPrice!}</span></div>
                        </a>
                        </li>
                    </#list>
                </#if>
                </ul>
            </div>
        </div>

        <div class="showAddsRight flr">
            <div class="detail-tabbox">
                <div class="tabboxlist">
                    <ul>
                        <li class="select"><a href="javascript:void(0);">商品详情</a></li>
                        <li><a href="javascript:void(0);">所有参与记录</a></li>
                    </ul>
                    <a class="tabbox-add tabbox-groupadd btn-buy <#if (crowdfunding.currentPeopleNum >= crowdfunding.requireNum) || crowdfunding.endTime?date lt .now?date >disabled</#if>" href="javascript:void(0);">立即抢购</a>
                </div>
            </div>
            <div class="product-detail">
                <div class="moudle_details">
                    <div class="moudle_top"><span class="sp_cs">商品参数</span></div>
                    <div class="t-info">
                        <table width="100%" border="0" cellpadding="0" cellspacing="0">
                            <tbody>
                            <#if attributeListList?? && attributeListList?has_content>
                            <tr>
                                <#list attributeListList as attribute>
                                    <#if 0<attribute_index  && (attribute_index % 4)==0></tr>
                                    <tr></#if>
                                    <td>
                                        <div class="zxx_con">${(attribute.attrName)!?html}
                                            ：${(attribute.attrValue)!?html}</div>
                                    </td>
                                </#list>
                            </tr>
                            <#else>
                            <div class="moudle_prompt">暂无商品参数</div>
                            </#if>
                            </tbody>
                        </table>
                    </div>
                    <div class="moudle_top"><span class="sp_show">商品展示</span></div>
                <#if productExtend?? && productExtend.productDetailDesc?has_content>
                    <div class="moudle_img">
                    ${(productExtend.productDetailDesc)!}
                    </div>
                <#else>
                    <div class="moudle_prompt">暂无商品详情</div>
                </#if>
                </div>
                <div class="moudle_details" style="display: none;" id="moudle_details">
                    <div class="zc-record">
                        <div class="record-bar"><p>时间</p><span>会员</span><em>参与人次</em></div>
                        <div class="record-list">
                            <ul id="recordList">

                            </ul>
                        </div>
                    </div>
                    <div class="pr-pager">
                        <span class="total">共${recordNum?default(0)}件商品</span>
                        <div id="page"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    var realStock = $('#realStock').val();
    var limitNum = $('#limitNum').val();
    var userId = $('#userId').val();
    var promotionId = ${crowdfunding.promotionId};
    //校验输入的数量
    function checkNum() {
        var count = $("#count").val().trim();
        var reg = /^\d+$/;
        if (!reg.test(count)) {
            layer.msg('请输入正确数量！');
            count = 1;
        }
        changeNum(count);
    }
    function changeNum(count) {
        if (parseInt(count) < 1) {
            count = 1;
        } else if (count > parseInt(realStock) || count > parseInt(limitNum)) {
            layer.msg('数量不能大于限购数');
            count = 1;
        }
        //下限
        if (count < 1) {
            return false;
        } else if (count == 1) {
            $('#countBtn .decrease').addClass('decrease-disabled');
        } else {
            $('#countBtn .decrease').removeClass('decrease-disabled');
        }
        //上限
        if (count > realStock || count > limitNum) {
            return false;
        } else if (count == realStock || count == limitNum) {
            $('#countBtn .increase').addClass('increase-disabled');
        } else {
            $('#countBtn .increase').removeClass('increase-disabled');
        }
        $("#count").val(count);
    }


    $(function () {
        //生成二维码
        var url = window.location.protocol+ "//" + window.location.host + "/m/crowdfunding/detail/${crowdfunding.promotionId!}";
        $('#qrcode').qrcode({width: 100, height: 100, text: url});

        //记录滚动
        $(".crowdRecord").slide({ mainCell:".hd ul",autoPlay:true,effect:"topMarquee",interTime:50,vis:1 });
    })

    $(function () {
        //数量变化按钮
        $('#countBtn .increase').click(function () {
            if($('#countBtn .increase').hasClass('increase-disabled'))return false;
            var count = $("#count").val().trim().replace('.', '');
            changeNum(++count);
        });
        $('#countBtn .decrease').click(function () {
            if( $('#countBtn .decrease').hasClass('decrease-disabled'))return false;
            var count = $("#count").val().trim().replace('.', '');
            changeNum(--count);
        });

        $('.btn-buy').click(function () {
            if($(this).hasClass('disabled'))return false;
            var count = $("#count").val().trim().replace('.', '');
            window.location.href = '/account/crowdfundingOrder/toPay?promotionId=' + promotionId + '&buyNum=' + count;
        });

        $(".jqzoom").imagezoom();
        $("#thumblist").find("li a").hover(function () {
            $(this).parents("li").addClass("tb-selected").siblings().removeClass("tb-selected");
            $(".jqzoom").attr('src', $(this).find("img").attr("mid"));
            $(".jqzoom").attr('rel', $(this).find("img").attr("big"));
        });

        var tabboxList = $(".tabboxlist"),
                tabboxListtop = tabboxList.offset().top;
        $(window).on("scroll", function () {
            var scrolltop = $(this).scrollTop();
            tabboxList.removeAttr("style");
            if (scrolltop > tabboxListtop) {
                tabboxList.addClass("tabboxlist-fix");
                $(".detail-tabbox .tabbox-add").show();
            } else {
                tabboxList.removeClass("tabboxlist-fix");
                $(".detail-tabbox .tabbox-add").hide();
            }
        });

        $('.boxer').boxer({
            labels: {
                close: "关闭",
                count: "/",
                next: "下一个",
                previous: "上一个"
            }
        });

        $(".tabboxlist li").on("click", function () {
            var idx = $(this).index();
            $(".tabboxlist li").removeClass("select");
            $(this).addClass("select");
            $(".moudle_details").hide().eq(isNaN(idx) ? 0 : idx).show();
        })


        $('.detail-qrcode').hover(function () {
            $(this).find('.qrcode').show();
        }, function () {
            $('.qrcode').hide();
        });


        var isCollect = 0;//是否收藏：0：未收藏，1：已收藏
    <#if isCollect?? && isCollect?has_content>
        isCollect = ${isCollect};
    </#if>
        //点击收藏
        $(".socialbtn").on("click", function () {
            var btn = $(this);
            var pid = ${crowdfunding.productId}
            if (isCollect == 1) {
                isCollect = 0;
            } else {
                isCollect = 1;
            }

            if (userId) {
                $.ajax({
                    url: '/m/product/collect',
                    async: true,
                    type: "GET",
                    dataType: "json",
                    data: {"productId": pid, "isCollect": isCollect},
                    success: function (result) {
                        if (result.result == 'success') {
                            if (isCollect == 0) {
                                $(".socialbtn").empty().append('<i class="icon ico-liked"></i>收藏商品');
                            }
                            if (isCollect == 1) {
                                $(".socialbtn").empty().append('<i class="icon ico-unlike"></i>取消收藏');
                            }
                        }
                    }
                })
            } else {
                //询问框
                layer.confirm('您还未登录，请先登录!', {
                            btn: ['确认', '关闭']
                        }, function () {
                            window.location.href = "/login?successUrl=" + encodeURIComponent(window.location.href);
                        }
                );
            }
        });

        $(".dc_c_t li").click(function () {
            var type = $(this).index();
            //alert("ww");
            $(this).parent().find('li').removeClass("on");
            $(this).addClass("on");
            gotoPage(type, 1);

        })
        //页面跳转
        function gotoPage(reviewType, page) {
            $.ajax({
                url: "/product/Review_ajaxpage_List",
                data: {
                    productId:${crowdfunding.masterProductID!},
                    type: reviewType,
                    goToPage: page
                },
                dataType: "text",
                success: function (data) {
                    //alert("ww");
                    $("#review-list").html(data);
                }
            });
        }
    })

</script>
<script>
    //加载购买记录
    var isFirst = true;
    var size = 15;
    var totalData = 0;
    var currentPageNo ;
    var recordNum = Math.ceil(${recordNum?default(0)}/size);    //总页数
    $(function () {
        //分页插件
        $("#page").Page({
            totalPages: recordNum,
            //分页总数
            liNums: 5,
            //分页的数字按钮数(建议取奇数)
            activeClass: 'activP',
            //active 类样式定义
            hasFirstPage: false,
            hasLastPage: false,
            callBack: function (page) {
                if (page == currentPageNo)return false;
                jsonData(page - 1);
            }
        });
        jsonData(0);
    });
    function jsonData(_page){
        if (_page < 0 ) {
            return false;
        }
        if (_page == 0) {
            $('.page-prev').addClass('off');
            $('#page .prv').hide();
        } else {
            $('.page-prev').removeClass('off');
            $('#page .prv').show();
        }
        if (_page == recordNum - 1) {
            $('.page-next').addClass('off');
            $('#page .next').hide();
        } else {
            $('.page-next').removeClass('off');
            $('#page .next').show();
        }
        $('#recordList').empty();
        $.get('/crowdfunding/jsonOrderRecode', {page: _page, size: size,promotionId:${crowdfunding.promotionId}}, function (data) {
            var result = '';
            data.forEach(function(value) {
                var name = value.name;
                result += '<li><p>'+new Date(value.time).format('yyyy-MM-dd hh:mm:ss')+'</p><span>'+name.substring(0,3)+'****'+name.substring(name.length-4)+'</span><em>'+value.num+'</em></li>';
            });
            $('#recordList').append(result);
            currentPageNo = _page+1;
        })
    }
</script>
<script>
    with (document)0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion=' + ~(-new Date() / 36e5)];
</script>
</body>