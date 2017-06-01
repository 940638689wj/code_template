<#assign ctx = request.contextPath>
<#assign staticResourcePath = ctx + "/static/mobile/">
<!doctype html>
<html lang="en">
<head>
<script type="text/javascript" src="${staticResourcePath}/js/swiper.min.js"></script>
</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">商品详情</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="swiper-container picslider">
            <div class="swiper-wrapper">
                <div class="swiper-slide">
                    <div class="pic"><img data-src="images/goodspic.jpg" class="swiper-lazy"></div>
                    <div class="swiper-lazy-preloader"></div>
                </div>
                <div class="swiper-slide">
                    <div class="pic"><img data-src="images/goodspic.jpg" class="swiper-lazy"></div>
                    <div class="swiper-lazy-preloader"></div>
                </div>
                <div class="swiper-slide">
                    <div class="pic"><img data-src="images/goodspic.jpg" class="swiper-lazy"></div>
                    <div class="swiper-lazy-preloader"></div>
                </div>
            </div>
            <!-- Add Pagination -->
            <div class="swiper-pagination"></div>
        </div>

        <div class="sku-detail-top">
            <div class="sku-intro">
                <h1 class="sku-name">洋河梦之蓝M1 45度500ml*2 洋河1号 蓝色经典 绵柔型白酒</h1>
                <p class="sku-custom-attr">官方直营 购买更放心 顺丰送达 配送有保障</p>
                <p class="sku-sales-num">月销量2369件<span class="inventory">库存:100件</span></p>
            </div>
            <div class="sku-price">
                <div class="price-real">
                    	￥<strong>636.00</strong>
                    <span class="promotetag">新客活动价</span>
                </div>
                <div class="price-real">
                    <span class="price-origin">￥1396.00</span>
                </div>
            </div>
        </div>

        <div class="borderbox">
            <div class="tbviewlist">
                <ul>
                    <li>
                        <a href="javascript:void(0);" class="itemlink" id="J_BtnChooes">
                            <div class="c">请选择<span>类型</span></div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="sku-coupon">
            <div class="coupontitle"><p class="fl">领优惠券<span>(可左右滑动)</span></p><p class="fr">共2张</p></div>
            <div id="coupon-list">
                <div class="swiper-wrapper">
                    <div class="swiper-slide">
                        <div class="couponlist">
                            <div class="hd"><div class="wrap">立即<br>领取</div></div>
                            <div class="bd">
                                <p>￥<span>1396.00</span></p>
                                <em>满30可用</em>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="couponlist">
                            <div class="hd"><div class="wrap">立即<br>领取</div></div>
                            <div class="bd">
                                <p>￥<span>1396.00</span></p>
                                <em>满30可用</em>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="couponlist">
                            <div class="hd"><div class="wrap">立即<br>领取</div></div>
                            <div class="bd">
                                <p>￥<span>1396.00</span></p>
                                <em>满30可用</em>
                            </div>
                        </div>
                    </div>
                    <div class="swiper-slide">
                        <div class="couponlist">
                            <div class="hd"><div class="wrap">立即<br>领取</div></div>
                            <div class="bd">
                                <p>￥<span>1396.00</span></p>
                                <em>满30可用</em>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="skutabbar" id="J_DetailTab">
            <ul>
                <li class="selected"><a href="javascript:void(0);">图片详情</a></li>
                <li><a href="javascript:void(0);">用户咨询</a></li>
                <li><a href="javascript:void(0);">用户评价</a></li>
            </ul>
        </div>
        <div class="sku-detail-content">
            <div id="J_DetailContent" class="tabpag">
                <div class="iconinfo">
                    <div class="ico ico-info"></div>
                    <strong>暂无图片详情</strong>
                </div>
                <ul class="tbviewlist">
                    <li>
                        <div class="hd">品牌：</div>
                        <div class="bd">KLML</div>
                    </li>
                    <li>
                        <div class="hd">货号：</div>
                        <div class="bd">01</div>
                    </li>
                    <li>
                        <div class="hd">上市年份：</div>
                        <div class="bd">2013年夏季</div>
                    </li>
                    <li>
                        <div class="hd">风格：</div>
                        <div class="bd">休闲</div>
                    </li>
                    <li>
                        <div class="hd">流行元素：</div>
                        <div class="bd">浅口 色拼接 松糕跟</div>
                    </li>
                    <li>
                        <div class="hd">颜色分类：</div>
                        <div class="bd">军绿色 天蓝色 巧克力色 桔色 浅灰色 浅绿色 浅黄色 深卡其布色 深灰色 深紫色 深蓝色 白色 粉红色 紫罗兰 紫色 红色 绿色 花色 蓝色 褐色 透明 酒红色 黄色 黑色</div>
                    </li>
                    <li>
                        <div class="hd">尺码：</div>
                        <div class="bd">35 36 37 38 39 40 41 42 43 44 45 46 47</div>
                    </li>
                    <li>
                        <div class="hd">图案：</div>
                        <div class="bd">纯色</div>
                    </li>
                </ul>
                <img data-src="http://img01.taobaocdn.com/imgextra/i1/1708919206/TB2xeA6apXXXXXLXpXXXXXXXXXX_%21%211708919206.jpg" src="/static/mobile/images/loading.gif">
                <img data-src="http://img04.taobaocdn.com/imgextra/i4/1708919206/TB2bwFaaFXXXXbfXXXXXXXXXXXX_%21%211708919206.jpg" src="/static/mobile/images/loading.gif">
                <img data-src="http://img04.taobaocdn.com/imgextra/i4/1708919206/TB2ZnhcaFXXXXXEXXXXXXXXXXXX_%21%211708919206.jpg" src="/static/mobile/images/loading.gif">
            </div>
            <div class="tabpag" style="display: none">
                <div class="iconinfo">
                    <div class="ico ico-info"></div>
                    <strong>暂无用户咨询</strong>
                </div>
                <div class="consulting">
                    <ul>
                        <li>
                            <div class="name">用户名</div>
                            <div class="time">2014-6-26  14:23:40</div>
                            <dl class="ask">
                                <dt><em>Q</em></dt>
                                <dd>这个支持全身水洗么？</dd>
                            </dl>
                            <dl class="answer">
                                <dt><em>A</em></dt>
                                <dd>您好！这款产品为水洗设计，建议您可将产品在水龙头下冲洗，不要将整机放入水中清洁。祝您购物愉快！</dd>
                            </dl>
                        </li>
                        <li>
                            <div class="name">用户名</div>
                            <div class="time">2014-6-26  14:23:40</div>
                            <dl class="ask">
                                <dt><em>Q</em></dt>
                                <dd>这个支持全身水洗么？</dd>
                            </dl>
                            <dl class="answer">
                                <dt><em>A</em></dt>d
                                <dd>您好！这款产品为水洗设计，建议您可将产品在水龙头下冲洗，不要将整机放入水中清洁。祝您购物愉快！</dd>
                            </dl>
                        </li>
                        <li>
                            <div class="name">用户名</div>
                            <div class="time">2014-6-26  14:23:40</div>
                            <dl class="ask">
                                <dt><em>Q</em></dt>
                                <dd>这个支持全身水洗么？</dd>
                            </dl>
                            <dl class="answer">
                                <dt><em>A</em></dt>
                                <dd>您好！这款产品为水洗设计，建议您可将产品在水龙头下冲洗，不要将整机放入水中清洁。祝您购物愉快！</dd>
                            </dl>
                        </li>
                        <li class="more"><a href="consulting_list.html">查看全部咨询</a></li>
                    </ul>
                </div>
            </div>
            <div class="tabpag" style="display: none">
                <div class="iconinfo">
                    <div class="ico ico-info"></div>
                    <strong>暂无用户评价</strong>
                </div>
                <div class="review-list">
                    <div class="review-item">
                        <ul>
                            <li>
                                <div class="bd">
                                    <h3><em class="fl">m***y</em><em class="fr"><span class="review-star review-star-4"><b></b></span></em></h3>
                                    <p>趁活动买来送亲戚的，包装的很好，买的多但是一瓶也没碎，都是正品。</p>
                                </div>
                            </li>
                            <li>
                                <div class="bd">
                                    <h3><em class="fl">m***y</em><em class="fr"><span class="review-star review-star-4"><b></b></span></em></h3>
                                    <p>趁活动买来送亲戚的，包装的很好，买的多但是一瓶也没碎，都是正品。</p>
                                </div>
                            </li>
                            <li class="more"><a href="evaluation_list.html">查看全部评价</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <div class="fbbwrap-total">
            <div class="ftbtnbar" style="display: none;">
                <div class="button-wrap button-wrap-expand button-wrap-disabled">
                    <a href="javascript:void(0)" class="button">商品已售罄</a>
                </div>
            </div>

            <div class="ftbtnbar">
                <div class="button-l">
                    <div class="sku-action">
                        <a class="btn-fav" href="javascript:void(0)">收藏</a>
                    </div>
                    <a href="javascript:void(0);" id="J_ShopCart">
                        <i class="iconfont">&#xe611;</i>
                        <span>购物车</span>
                        <em>10</em>
                    </a>
                    <a href="consulting.html">
                        <i class="iconfont">&#xe61a;</i>
                        <span>咨询</span>
                    </a>
                </div>
                <div class="button-wrap button-wrap-expand">
                    <a id="J_BtnCart" class="button cartdisabled addtocart">加入购物车</a>
                    <a id="J_BtnBuy" class="button disabled">立即购买</a>
                </div>
            </div>
        </div>
    </div>

    <div id="J_ASSpec" class="actionsheet-spec">
        <div class="close"></div>
        <div class="prod-info">
            <div class="pic"><img src="images/goodspic.jpg" alt=""/></div>
            <div class="name">产品名称产品名称产品名称产品产品名称产品名称产品名称产品产品名称产品名称产品名称产品</div>
            <div class="price"><span class="price-real">￥<em>399.00</em></span></div>
        </div>
        <div class="spec-list detail">
            <div class="spec-list-wrap">
                <div class="spec-item">
                    <h3>尺码</h3>
                    <div class="c">
                        <div class="prop-list">
                            <ul>
                                <li>S码</li>
                                <li>M码</li>
                                <li class="disabled">L码</li>
                                <li class="disabled">XL码</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="spec-item">
                    <h3>颜色</h3>
                    <div class="c">
                        <div class="prop-list">
                            <ul>
                                <li>红色</li>
                                <li>黑色</li>
                                <li class="disabled">黄色</li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="spec-item">
                    <h3>数量</h3>
                    <div class="c">
                        <div class="number-widget">
                            <div class="number-minus disabled"></div>
                            <input class="number-text" type="number" value="1">
                            <div class="number-plus"></div>
                        </div>
                        <div class="sku-stock-count">库存<em>99</em>件</div>
                    </div>
                </div>
            </div>
        </div>

        <div class="fbbwrap nofixed">
            <div class="ftbtnbar">
                <div class="button-wrap button-wrap-expand">
                    <a href="javascript:void(0)" class="button btn-buy">确定</a>
                </div>
            </div>
        </div>
    </div>

</div>
<script>
    $(function(){
        var swiper = new Swiper('.swiper-container', {
            pagination: '.swiper-pagination',
            paginationType : 'fraction',
            loop : true,
            preloadImages: false,
            lazyLoading : true,
        });

        var mySwiper1 = new Swiper('#coupon-list',{
            freeMode : true,
            slidesPerView : 'auto',
        });

        //tab栏固顶
        var tabBar = $("#J_DetailTab");
        $(window).on("scroll", function () {
            var tabTop = tabBar.offset().top;
            if(document.body.scrollTop > tabTop){
                tabBar.addClass("fixed");
            }else{
                tabBar.removeClass("fixed");
            }
        });

        var detailContent = $('#J_DetailContent');
        detailContent.find('[width],[height]').css({width:'auto',height:'auto'});
        detailContent.find("img").css({
            width : "auto",
            height : "auto",
            margin:"20px auto",
            display:"block"
        }).unveil(0, function () {
            var img = $(this);
            img.one("load", function () {
                img.css({
                    width : "auto",
                    height : "auto",
                    margin:"auto"
                });
            });
        });

        //图片详情产品参数tab
        $(".skutabbar li").click(function () {
            var idx = $(this).index();
            $(".skutabbar li").removeClass("selected");
            $(this).addClass("selected");
            $(".tabpag").hide().eq(isNaN(idx) ? 0 : idx).show();
        });

        //收藏
        $(".btn-fav").on("click", function () {
            var btn = $(this);
            if(!btn.hasClass("selected")){
                btn.html("已收藏");
                mui.toast('添加收藏成功');
            }else{
                btn.html("收藏");
                mui.toast('取消收藏');
            }
            btn.toggleClass("selected").addClass("animating")
                .on("animationend webkitAnimationEnd MSAnimationEnd oAnimationEnd", function () {
                    btn.removeClass("animating");
                });
        });


        //商品规格
        $(".prop-list li").each(function(){
            if(!$(this).hasClass("disabled")){
                $(this).on("click",function(){
                    $(this).addClass("active").siblings().removeClass("active");
                })
            }
        })


        //添加购物车动作
        $("#J_ASSpec .btn-buy").on("click", function () {
            throwInCart($("#J_BtnCart"));
            hideSpecAS();
        });

        function throwInCart(source){
            var start = $(source).offset(),
                    end = $("#J_ShopCart").offset(),
                    winH = $(window).height()-30,
                    sX = start.left + start.width/ 2 - 15,
                    sY = winH + start.height/ 2 - 15,
                    eX = end.left + end.width/ 2 - 15,
                    eY = end.top + end.height/ 2 - 15;
            var throwItem = $('<div class="throwInItem"></div>').css({
                top : sY,
                left : sX,
                "-webkit-transform-origin":((eX - sX)/2+15)+"px 0"
            }).appendTo(document.body);
            throwItem.animate({
                rotate : "-200deg"
            },{
                duration : 800,
                easing : "ease-out",
                complete : function () {
                    throwItem.remove();
                    mui.toast('已添加到购物车',true);
                }
            });
        }


        //选择参加促销活动
        var specASMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
                    hideSpecAS();
                }).appendTo(document.body),
                specAS = $("#J_ASSpec");
        $("#J_BtnCart,#J_BtnBuy,#J_BtnChooes").on("click", function () {
            showSpecAS();
        });
        specAS.find(".close").on("click", function () {
            hideSpecAS();
        });

        function showSpecAS(){
            specASMask.show().animate({opacity:1},{
                duration:80,
                complete: function () {
                    specAS.css({
                        top : "100%",
                        opacity : 0,
                        display : "block"
                    }).animate({
                        opacity : 1,
                        translateY:"-"+specAS.height() +"px"
                    },{
                        duration : 200,
                        easing : "ease-in-out"
                    });
                }
            });
        }

        function hideSpecAS(callback){
            specAS.animate({
                opacity : 0,
                translateY:0
            },{
                duration : 200,
                easing : "ease-in-out",
                complete : function () {
                    specAS.hide();
                    specASMask.animate({opacity:0},{
                        duration : 80,
                        complete: function () {
                            specASMask.hide();
                            if(typeof callback == "function") callback.call();
                        }
                    });
                }
            });
        }

    })
</script>
</body>
</html>