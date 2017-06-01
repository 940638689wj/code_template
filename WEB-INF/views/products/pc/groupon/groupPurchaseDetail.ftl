<body class="page-list">
<link rel="stylesheet" href="/static/css/fsboxer.css">

<script src="/static/js/boxer.min.js"></script>
<script src="/static/js/jquery.imagezoom.min.js"></script>
<script src="/static/js/jquery.countdown.js"></script>
<script src="/static/js/jquery.qrcode.min.js"></script>

<input type='hidden' value='${userId!}' id='userId'/>
<input type='hidden' value='${grouponDetail.realStock!}' id='realStock'/>
<input type='hidden' value='${grouponDetail.grouponPersonQuotaNum!}' id='limitNum'/>
<div id="main">
    <div class="crumb">
        <span class="t">您的位置：</span>
        <a class="c" href="/index.html">首页</a>
        <span class="divide">&gt;</span>
        <a class="c" href="/groupPurchase/list">团购</a>
        <span class="divide">&gt;</span>
        <span>${grouponDetail.promotionName!}</span>
    </div>

    <div class="contents clearfix">
        <div class="info_l">
            <dl>
                <dt><a href="images/pic.jpg"><img src="${picUrls[0]!}" rel="${picUrls[0]!}" class="jqzoom"/></a></dt>
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
                <h2>${grouponDetail.promotionName!}</h2>
                <p>${grouponDetail.grouponDesc!}</p>
            </div>
            <div class="countdownWrap">
                <div class="countdown" data-countdown="flash_sale" data-end="${grouponDetail.enableEndTime!}"
                     data-start="${.now}">
                    限时团购：
                    <em class="days_1"></em><i class="days_2">天</i>
                    <em class="hours_1"></em><i class="hours_2">时</i>
                    <em class="minutes_1"></em><i class="minutes_2">分</i>
                    <em class="seconds_1"></em><i class="seconds_2">秒</i>
                </div>
                <span class="flr">${grouponDetail.saleNum!}人已团购</span>
            </div>
            <div class="proDetails">
                <dl class="clearfix">
                    <dt>原价：</dt>
                    <dd><span class="price-origin">¥${grouponDetail.tagPrice!?string('##0.00#')}</span></dd>
                </dl>
                <dl class="clearfix">
                    <dt>团购价：</dt>
                    <dd>
                        <span class="price-real">¥${grouponDetail.grouponPrice!?string('##0.00#')}</span>
                    </dd>
                </dl>
                <div class="detail-qrcode">
                    <p>手机购买</p>
                    <div class="qrcode">
	                        <span id="qrcode">
	                        <span class="ui-arrow"></span>
                    </div>
                </div>
            </div>
            <dl class="meta-item">
                <dt>商品评价：</dt>
                <dd>好评度${(goodReviewP)?string("#.#")}%<em>（共<i
                        class="red">${(productSumInfo.mainReviewCnt)?default(0)}</i> 条评论）</em></dd>
            </dl>
            <dl class="meta-item">
                <dt>销量：</dt>
                <dd>${grouponDetail.saleNum!}件</dd>
            </dl>
            <div class="proList_box">
                <dl class="meta-item meta-amount">
                <#if grouponDetail.sku?? && grouponDetail.sku?has_content>
                    <#list grouponDetail.sku as item>
                        <dt class="metatit">${item.skuType!}：</dt>
                        <dd>
                            <ul class="clearfix prop-list prop-list-group">
                                <li class="selected"><a href="javascript:void(0)">
                                    <span>${item.skuValue!}</span>
                                </a><i></i></li>
                            </ul>
                        </dd>
                    </#list>
                </#if>
                </dl>
                <dl class="meta-item meta-amount">
                    <dt class="metatit">数量：</dt>
                    <dd>
	                        <span id='countBtn' class="amount-widget">
	                            <input type="number" class="textfield" id="count" value=1 onchange='checkNum()'>
	                            <span class="increase <#if grouponDetail.realStock lte 1 || grouponDetail.grouponPersonQuotaNum lte 1>increase-disabled</#if>"></span>
	                            <span class="decrease decrease-disabled"></span>
	                        </span>
                        <em>件（库存 ${grouponDetail.realStock!} 件）</em>
                    </dd>
                </dl>
            </div>
            <div class="proList-action">
                <div class="btngroup-buy buyBtn <#if (grouponDetail.realStock <= 0) || grouponDetail.enableEndTime?date lt .now?date >disabled</#if>"><a href="#">立即抢购</a></div>
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
                        <li><a href="javascript:void(0);">商品评价</a></li>
                    </ul>
                    <a class="tabbox-add tabbox-groupadd buyBtn <#if (grouponDetail.realStock <= 0) || grouponDetail.enableEndTime?date lt .now?date >disabled</#if>" href="javascript:void(0);">立即抢购</a>
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
                    <div class="dc_score">
                        <span class="score">综合评分</span>
                        <span class="fl">|</span>
                        <span class="review-star review-star-${((productSumInfo.productMatchScoreAvg)?default(5))}"><b></b></span>
                    </div>
                    <ul class="dc_c_t">
                        <li <#if type==0>class="on"</#if>><a
                                href="javascript:void(0);">全部（${(productSumInfo.mainReviewCnt)?default(0)?number}）</a>
                        </li>
                        <li <#if type==1>class="on"</#if>><a href="javascript:void(0);">好评（${goodReview}）</a></li>
                        <li <#if type==2>class="on"</#if>><a href="javascript:void(0);">中评（${mediumReview}）</a></li>
                        <li <#if type==3>class="on"</#if>><a href="javascript:void(0);">差评（${badReview}）</a></li>
                    </ul>
                    <div class="review-list" id="review-list">
                    <#include "../reviewList.ftl"/>
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
    var promotionId = ${grouponDetail.promotionId};
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
            layer.msg('数量不能小于1');
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

    //生成二维码
    $(function () {
        var url = window.location.protocol + window.location.host + "/m/groupPurchase/detail/${grouponDetail.promotionId!}";
        $('#qrcode').qrcode({width: 100, height: 100, text: url});
    })

    $(function () {
        //数量变化按钮
        $('#countBtn .increase').click(function () {
            if ($('#countBtn .increase').hasClass('increase-disabled'))return false;
            var count = $("#count").val().trim().replace('.', '');
            changeNum(++count);
        });
        $('#countBtn .decrease').click(function () {
            if ($('#countBtn .decrease').hasClass('decrease-disabled'))return false;
            var count = $("#count").val().trim().replace('.', '');
            changeNum(--count);
        });

        $('.buyBtn').click(function () {
            if($(this).hasClass('disabled')) return false;
            var count = $("#count").val().trim().replace('.', '');
            window.location.href = '/account/groupPurchaseOrder/toGroupPay?promotionId=' + promotionId + '&buyNum=' + count;
        });

        $(".jqzoom").imagezoom();
        $("#thumblist li a").hover(function () {
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
            var pid = ${grouponDetail.productId}
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
                    productId:${grouponDetail.masterProductID!},
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
    with (document)0[(getElementsByTagName('head')[0] || body).appendChild(createElement('script')).src = 'http://bdimg.share.baidu.com/static/api/js/share.js?cdnversion=' + ~(-new Date() / 36e5)];
</script>
</body>