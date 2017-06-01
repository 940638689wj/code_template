<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<#assign  adminRealName = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getAdminRealName()?default("")/>
<#assign  siteName = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getSiteName()?default("")/>

<#include "${ctx}/macro/sa/roma_macro.ftl"/>

<!DOCTYPE HTML>
<html>
<head>
    <title><#if siteName?? && siteName?has_content>${siteName!}-</#if>管理后台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/theme-01.css"/>

    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>

    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

</head>
<body>
<div class="header">
    <div class="header-left">
        <div class="dl-title">
            <div class="dl-logo"><a href="${ctx}/admin/sa"><img
                    src="<#if backgroundSystem?has_content>${backgroundSystem!}<#else>/static/admin/images/logo.png</#if>"
                    alt="总店后台"/></a></div>
        </div>
    </div>
    <div class="header-right">
        <a class="exit" href="${ctx}/admin/sa/logout.htm">退出</a>
        <div class="user" style="width:160px">欢迎您:${adminRealName!}</div>
    </div>

    <div class="dl-msg">
        <div class="dl-msg-wrp" id="dl-msg">
        </div>
    </div>

</div>
<script>
    var logUser = $('#logUser'),
            logHideList = $('#logHideList');
    logUser.add(logHideList).hover(function () {
        var offset = logUser.position();
        logHideList.css({
            top: offset.top + logUser.outerHeight(),
            left: offset.left - logHideList.outerWidth() + logUser.outerWidth()
        }).show();
    }, function (e) {
        logHideList.hide();
    });
</script>
<div class="content">
    <div class="dl-main-nav">
        <ul id="J_Nav" class="nav-list ks-clear">
            <li class="nav-item dl-selected" style="display:none">
                <div class="nav-item-inner">首页</div>
            </li>

        <@securityAuthorize "product">
            <li class="nav-item">
                <div class="nav-item-inner">商品</div>
            </li>
        </@securityAuthorize>
        <@securityAuthorize "order">
            <li class="nav-item">
                <div class="nav-item-inner">订单</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "user">
            <li class="nav-item">
                <div class="nav-item-inner">会员</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "promotion">
            <li class="nav-item">
                <div class="nav-item-inner">活动</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "saleBill">
            <li class="nav-item">
                <div class="nav-item-inner">票券管理</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "store">
            <li class="nav-item">
                <div class="nav-item-inner">门店</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "decorate">
            <li class="nav-item">
                <div class="nav-item-inner">装修</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "wechat">
            <li class="nav-item">
                <div class="nav-item-inner">微信</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "rule">
            <li class="nav-item">
                <div class="nav-item-inner">规则</div>
            </li>
        </@securityAuthorize>
        <@securityAuthorize "statement">
            <li class="nav-item">
                <div class="nav-item-inner">对账单</div>
            </li>
        </@securityAuthorize>
        <@securityAuthorize "analysis">
            <li class="nav-item">
                <div class="nav-item-inner">运营分析</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "audit">
            <li class="nav-item">
                <div class="nav-item-inner">审核</div>
            </li>
        </@securityAuthorize>

        <@securityAuthorize "setting">
            <li class="nav-item">
                <div class="nav-item-inner">设置</div>
            </li>
        </@securityAuthorize>

        </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-content">

    </ul>

</div>
<#--<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>-->
<#--<script type="text/javascript" src="${staticPath}/admin/js/bui-min.js"></script>-->
<script type="text/javascript" src="${staticPath}/admin/js/config.js"></script>
<script>
    BUI.use('${staticPath}/admin/js/common/main', function () {
        var config = [
            {
                id: 'home',
                homePage: 'index',
                collapsed: false, //默认左侧菜单展示
                menu: [
                    {
                        text: '常用操作',
                        items: [
                            {id: 'index', text: '欢迎页面', href: '${ctx}/admin/sa/sumaryInfo', closeable: false},
                        <@securityAuthorize ifAnyGranted="product:manage:product_manage">
                            {id: 'index', text: '商品管理', href: '${ctx}/admin/sa/productManage/list?productStatusCd=1'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="order:manage:all">
                            {id: 'index', text: '订单管理', href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=1&type=0'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="user:manage:user_list">
                            {id: 'index', text: '会员管理', href: '${ctx}/admin/sa/user/userList'}
                        </@securityAuthorize>
                        ]
                    }
                ]
            }
        ]

    <#-- 商品 -->
    <@securityAuthorize ifAnyGranted="product">
        config.push(updateModulesHomePage({
            id: 'product',
            menu: [
            <#--<@securityAuthorize ifAnyGranted="product:freight">
                {
                    text: '运费管理',
                    items: [
                        <@securityAuthorize ifAnyGranted="product:freight:formwork">
                            {id: 'product', text: '运费模板', href: '${ctx}/admin/sa/brand/express_list'}
                        </@securityAuthorize>

                    ]
                },
            </@securityAuthorize>-->

                <@securityAuthorize ifAnyGranted="product:manage">
                    {
                        text: '商品管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="product:manage:product_manage">
                                {
                                    id: 'productManage-list',
                                    text: '商品管理',
                                    href: '${ctx}/admin/sa/productManage/list?productStatusCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="product:manage:add">
                                {
                                    id: 'productManage-add',
                                    text: '新增商品',
                                    href: '${ctx}/admin/sa/productManage/addOrEdit'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="product:manage:inventory_warning">
                                {
                                    id: 'productManage-list',
                                    text: '库存预警',
                                    href: '${ctx}/admin/sa/productManage/warningProductList?productStatusCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="product:manage:selling_well_products">
                                {id: 'productManage-list', text: '热销商品', href: '${ctx}/admin/sa/label/list'}
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
            <#--<@securityAuthorize ifAnyGranted="product:specialities">
                {
                    text: '特色菜管理',
                    items: [
                        <@securityAuthorize ifAnyGranted="product:specialities:manege">
                            {id: 'product', text: '菜品管理', href: '${ctx}/admin/sa/dishesManage/list?productStatusCd=1'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="product:specialities:add">
                            {id: 'productManage-list', text: '新增菜品', href: '${ctx}/admin/sa/dishesManage/addOrEdit'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="product:specialities:selling_well_foods">
                            {id: 'productManage-list', text: '热销菜品', href: '${ctx}/admin/sa/label/HotDishesList'}
                        </@securityAuthorize>
                    ]
                },
            </@securityAuthorize>-->
                <@securityAuthorize ifAnyGranted="product:attributes">
                    {
                        text: '商品属性',
                        items: [
                            <@securityAuthorize ifAnyGranted="product:attributes:classification">
                                {id: 'product', text: '商品分类', href: '${ctx}/admin/sa/category/list?productTypeCd=1'},
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="product:attributes:district_management">
                            {id: 'productManage-list', text: '区域管理', href: '${ctx}/admin/sa/regisonProductManage/list'},
                        </@securityAuthorize>-->
                            <@securityAuthorize ifAnyGranted="product:attributes:group">
                                {id: 'productManage-list', text: '商品分组', href: '${ctx}/admin/sa/group/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="product:attributes:brand">
                                {id: 'productManage-list', text: '商品规格', href: '${ctx}/admin/sa/skuType/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="product:attributes:brand">
                                {id: 'productManage-list', text: '商品品牌', href: '${ctx}/admin/sa/brand/list'}
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>
    <@securityAuthorize ifAnyGranted="order">
    <#-- 订单 -->
        config.push(updateModulesHomePage({
            id: 'order',
            menu: [
                <@securityAuthorize ifAnyGranted="order:manage">
                    {
                        text: '订单管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="order:manage:all">
                                {
                                    id: 'order:manage:all',
                                    text: '普通订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=1&type=0&orderDistrbuteTypeCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:manage:all">
                                {
                                    id: 'order:manage:all',
                                    text: '普通自提订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=1&orderDistrbuteTypeCd=2'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:manage:egretOrder">
                                {
                                    id: 'order:manage:egret',
                                    text: '白鹭卡订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=3&orderDistrbuteTypeCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:manage:egretOrder">
                                {
                                    id: 'order:manage:egret',
                                    text: '白鹭卡自提订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=3&orderDistrbuteTypeCd=2'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:manager:preSale">
                                {
                                    id: 'order:manage:preSale',
                                    text: '预售订单',
                                    href: '${ctx}/admin/sa/orderManage/toPreSaleOrder?orderDistrbuteTypeCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:manager:preSale">
                                {
                                    id: 'order:manage:preSale',
                                    text: '预售自提订单',
                                    href: '${ctx}/admin/sa/orderManage/toPreSaleOrder?orderDistrbuteTypeCd=2'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:manager:group">
                                {
                                    id: 'order:manage:crowdFunding',
                                    text: '众筹订单',
                                    href: '${ctx}/admin/sa/orderManage/toCrowdFundOrder?orderDistrbuteTypeCd=1'
                                },
                            </@securityAuthorize>
                            <#--<@securityAuthorize ifAnyGranted="order:manager:group">-->
                                <#--{-->
                                    <#--id: 'order:manage:crowdFunding',-->
                                    <#--text: '众筹自提订单',-->
                                    <#--href: '${ctx}/admin/sa/orderManage/toCrowdFundOrder?orderDistrbuteTypeCd=2'-->
                                <#--},-->
                            <#--</@securityAuthorize>-->
                            <@securityAuthorize ifAnyGranted="order:manage:bill">
                                {
                                    id: 'order:manage:bill',
                                    text: '发票列表',
                                    href: '${ctx}/admin/sa/orderManage/toInvoiceList'
                                },
                            </@securityAuthorize>

                        <#--
                        <@securityAuthorize ifAnyGranted="order:manage:productSales">
                           {id: 'order:manage:productSales', text: '商品销量表', href: '${ctx}/admin/sa/order/productSellInfo'}
                       </@securityAuthorize>
                        -->]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="order:billOrder">
                    {
                        text: '票券订单管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="order:billOrder:bill">
                                {
                                    id: 'order:service:deliveryOrder',
                                    text: '提货券订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=5&orderDistrbuteTypeCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:billOrder:bill">
                                {
                                    id: 'order:service:deliveryOrder',
                                    text: '提货券自提订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=5&orderDistrbuteTypeCd=2'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:billOrder:group">
                                {
                                    id: 'order:service:groupBuying',
                                    text: '团购订单',
                                    href: '${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=6'
                                },
                            </@securityAuthorize>
                        ]
                    },

                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="order:service">
                    {
                        text: '售后服务',
                        items: [
                            <@securityAuthorize ifAnyGranted="order:service:return">
                                {
                                    id: 'order:service:return',
                                    text: '退款订单',
                                    href: '${ctx}/admin/sa/customerService/toOrderReturn'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:service:returnReason">
                                {
                                    id: 'order:service:returnReason',
                                    text: '退款原因设置',
                                    href: '${ctx}/admin/sa/order/orderReturnReasonList'
                                },
                            </@securityAuthorize>
                            {
                                id: 'order:service:returnArea',
                                text: '退款地址设置',
                                href: '${ctx}/admin/sa/order/orderReturnArea'
                            }
                        ]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="order:logistics">
                    {
                        text: '物流管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="order:logistics:set">
                                {
                                    id: 'order:service:express',
                                    text: '设置物流',
                                    href: '${ctx}/admin/sa/order/express/expressList'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="order:logistics:freightTemplate">
                                {
                                    id: 'order:service:returnReason',
                                    text: '运费模板',
                                    href: '${ctx}/admin/sa/brand/express_list'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="order:printManager">
                    {
                        text: '快递打印管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="order:printManager:setTemplate">
                                {
                                    id: 'order:service:expressSetting',
                                    text: '设置快递单模板',
                                    href: '${ctx}/admin/sa/order/express/expressBillList'
                                }
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#-- 会员 -->
    <@securityAuthorize ifAnyGranted="user">
        config.push(updateModulesHomePage({
            id: 'user',
            menu: [
                <@securityAuthorize ifAnyGranted="user:manage">
                    {
                        text: '会员管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="user:manage:user_list">
                                {id: 'user_list', text: '会员列表', href: '${ctx}/admin/sa/user/userList'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="user:manager:user_mark">
                                {id: 'user_label', text: '会员标签', href: '${ctx}/admin/sa/userLabel/userLableList'},
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="user:manager:card">
                            {id: 'user_card_img', text: '会员卡', href: '${ctx}/admin/sa/userCard'},
                        </@securityAuthorize>-->
                            <@securityAuthorize ifAnyGranted="user:manage:user_defined_field">
                                {id: 'user_defined_field', text: '会员自定义信息', href: '${ctx}/admin/sa/userDefinedField'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="user:manage:user_entity_card">
                                {
                                    id: 'user_entity_card',
                                    text: '现金卡/积分卡',
                                    href: '${ctx}/admin/sa/entityCard?cardTypeCd=1'
                                },
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="user:manageRecord">
                    , {
                    text: '记录管理',
                    items: [
                        <@securityAuthorize ifAnyGranted="user:manageRecord:review">
                            {id: 'user_productReview_list', text: '评价记录', href: '${ctx}/admin/sa/user/review'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="user:manageRecord:consult">
                            {id: 'user_consult_list', text: '咨询记录', href: '${ctx}/admin/sa/user/consult'}
                        </@securityAuthorize>]
                }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#-- 活动 -->
    <@securityAuthorize ifAnyGranted="promotion">
        config.push(updateModulesHomePage({
            id: 'promotion',
            menu: [
                <@securityAuthorize ifAnyGranted="promotion:product_manage">
                    {
                        text: '单品促销',
                        items: [
                            <@securityAuthorize ifAnyGranted="promotion:product_manage:discount">
                                {
                                    id: 'promotion:product_manage:discount',
                                    text: '打折',
                                    href: '${ctx}/admin/sa/promotion/productSales/list?type=${(Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_DISCOUNT_TYPE.getType())!}'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:product_manage:reduce">
                                {
                                    id: 'promotion:product_manage:reduce',
                                    text: '降价',
                                    href: '${ctx}/admin/sa/promotion/productSales/list?type=${(Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_REDUCE_TYPE.getType())!}'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:product_manage:spike">
                                {
                                    id: 'promotion:product_manage:spike',
                                    text: '限时抢购',
                                    href: '${ctx}/admin/sa/promotion/productSales/list?type=${(Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ITEM_SPIKE_TYPE.getType())!}'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="promotion:order_manage">
                    {
                        text: '订单促销',
                        items: [
                            <@securityAuthorize ifAnyGranted="promotion:order_manage:freeShipingFull">
                                {
                                    id: 'promotion:order_manage:freeShipingFull',
                                    text: '包邮',
                                    href: '${ctx}/admin/sa/promotion/orderSales/list?type=${(Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_FREE_SHIPPING_TYPE.getType())!}'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:order_manage:reduceFull">
                                {
                                    id: 'promotion:order_manage:reduceFull',
                                    text: '满即减',
                                    href: '${ctx}/admin/sa/promotion/orderSales/list?type=${(Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_REDUCE_TYPE.getType())!}'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:order_manage:discountFull">
                                {
                                    id: 'promotion:order_manage:discountFull',
                                    text: '满额折',
                                    href: '${ctx}/admin/sa/promotion/orderSales/list?type=${(Static["cn.yr.chile.promotion.constant.PromotionType"].DETAIL_ORDER_DISCOUNT_TYPE.getType())!}'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="promotion:coupon_manage">
                    {
                        text: '高级促销',
                        items: [
                            <@securityAuthorize ifAnyGranted="promotion:coupon_manage:crowdFund">
                                {
                                    id: 'promotion:coupon_manage:crowdFund',
                                    text: '众筹',
                                    href: '${ctx}/admin/sa/promotion/crowdFund/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:coupon_manage:presale">
                                {
                                    id: 'promotion:coupon_manage:reserveSale',
                                    text: '商品预售',
                                    href: '${ctx}/admin/sa/promotion/reserveSale/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:coupon_manage:groupsale">
                                {
                                    id: 'promotion:coupon_manage:combination',
                                    text: '搭配套餐',
                                    href: '${ctx}/admin/sa/promotion/combination/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:coupon_manage:red_packet">
                                {
                                    id: 'promotion:coupon_manage:red_packet',
                                    text: '红包',
                                    href: '${ctx}/admin/sa/promotion/redPacket/list'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>

                <@securityAuthorize ifAnyGranted="promotion:game">
                    {
                        text: '互动游戏',
                        items: [
                            <@securityAuthorize ifAnyGranted="promotion:game:dzp">
                                {
                                    id: 'promotion:game:dzp',
                                    text: '大转盘',
                                    href: '${ctx}/admin/sa/promotion/awardsOffer/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:game:ggk">
                                {
                                    id: 'promotion:game:ggk',
                                    text: '幸运刮刮卡',
                                    href: '${ctx}/admin/sa/promotion/guaGuaka/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:game:bb">
                                {
                                    id: 'promotion:game:bb',
                                    text: '博饼',
                                    href: '${ctx}/admin/sa/promotion/boCake/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="promotion:game:rewardSetting">
                                {
                                    id: 'promotion:game:rewardSetting',
                                    text: '奖品处理',
                                    href: '${ctx}/admin/sa/promotion/awardsResult/list'
                                }
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#--票券管理-->
    <@securityAuthorize ifAnyGranted="saleBill">
        config.push(updateModulesHomePage({
            id: 'ticketManagement',
            menu: [
                <@securityAuthorize ifAnyGranted="saleBill:getProductBillManage">
                    {
                        text: '提货券管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="saleBill:getProductBillManage:list">
                                {
                                    id: 'ticketManagement:pickupcoupon_manage:add',
                                    text: '提货券列表',
                                    href: '${ctx}/admin/sa/pickupcouponList?statusCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="saleBill:getProductBillManage:add">
                                {
                                    id: 'ticketManagement:pickupcoupon_manage:add',
                                    text: '新建提货券',
                                    href: '${ctx}/admin/sa/pickupcouponList/toSave?statusCd=1'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="saleBill:groupBuy">
                    {
                        text: '团购管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="saleBill:groupBuy:list">
                                {
                                    id: 'ticketManagement:pickupcoupon_manage:list',
                                    text: '团购列表',
                                    href: '${ctx}/admin/sa/promotionGroupon?statusCd=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="saleBill:groupBuy:add">
                                {
                                    id: 'ticketManagement:pickupcoupon_manage:add',
                                    text: '生成团购',
                                    href: '${ctx}/admin/sa/promotionGroupon/toSave'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="saleBill:promotion">
                    {
                        text: '优惠券管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="saleBill:promotion:list">
                                {
                                    id: 'ticketManagement:pickupcoupon_manage:list',
                                    text: '优惠券列表',
                                    href: '${ctx}/admin/sa/promotion/coupons/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="saleBill:promotion:add">
                                {
                                    id: 'ticketManagement:coupon_manage:add',
                                    text: '新建优惠券',
                                    href: '${ctx}/admin/sa/promotion/coupons/editCoupon'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>]

        }));
    </@securityAuthorize>


    <#--门店-->
    <@securityAuthorize ifAnyGranted="store">
        config.push(updateModulesHomePage({
            id: 'store',
            menu: [
                <@securityAuthorize ifAnyGranted="store:manage">
                    {
                        text: '门店管理',
                        items: [
                            <@securityAuthorize ifAnyGranted="store:manage:store_list">
                                {
                                    id: 'store:manage:store_list',
                                    text: '门店列表',
                                    href: '${ctx}/admin/sa/userStore/storeManageList'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="store:manage:store_destroy">
                                {
                                    id: 'store:manage:store_destroy',
                                    text: '门店核销',
                                    href: '${ctx}/admin/sa/storeDestroy/toPromotionGrouponList?type=1'
                                },
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#--装修-->
    <@securityAuthorize ifAnyGranted="decorate">
        config.push(updateModulesHomePage({
            id: 'decorate',
            menu: [
                <@securityAuthorize ifAnyGranted="decorate:pcManage">
                    {
                        text: '商城总体设置',
                        items: [
                            <@securityAuthorize ifAnyGranted="decorate:pcManage:basic_setting">
                                {
                                    id: 'decorate:basic_setting',
                                    text: '基本设置',
                                    href: '${ctx}/admin/sa/decorate/site/edit'
                                },
                            </@securityAuthorize>
                        <#--  <@securityAuthorize ifAnyGranted="decorate:template_skin">
                                  {id: 'decorate:template_skin', text: '模版/皮肤', href: '${ctx}/admin/sa/decorate/themeManager'}
                             </@securityAuthorize>-->
                            <@securityAuthorize ifAnyGranted="decorate:pcManage:pc_index">
                                {
                                    id: 'decorate:pcManage:pc_index',
                                    text: 'PC首页',
                                    href: '${ctx}/admin/sa/pc/decorate/index'
                                },
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="decorate:pc_nav">
                            {id: 'decorate:pc_nav', text: 'PC首页分类导航', href: '${ctx}/admin/sa/pc/decorate/navEdit'},
                        </@securityAuthorize>-->
                            <@securityAuthorize ifAnyGranted="decorate:pcManage:edit">
                                {
                                    id: 'decorate:pc_edit_detail',
                                    text: '编辑详情页',
                                    href: '${ctx}/admin/sa/pc/decorateRight/detail'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="decorate:pc_style_code">
                                {
                                    id: 'decorate:pc_style_code',
                                    text: 'PC样式代码',
                                    href: '${ctx}/admin/sa/pc/decorate/staticResourcePC?key=static_resource_css_pc'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="decorate:mobile_manage">
                    {
                        text: '手机商城装修',
                        items: [
                            <@securityAuthorize ifAnyGranted="decorate:mobile_manage:mobile_index">
                                {
                                    id: 'decorate:mobile_index',
                                    text: '装修手机首页',
                                    href: '${ctx}/admin/sa/mobile/layoutManage/show'
                                },
                            </@securityAuthorize>

                        <#-- <@securityAuthorize ifAnyGranted="decorate:store_index">
							{id: 'decorate:store_index', text: '微店/门店首页', href: '${ctx}/admin/sa/store/layoutManage/toEditLayout'},
                        </@securityAuthorize> -->

                            <@securityAuthorize ifAnyGranted="decorate:mobile_manage:style_code_mobile">
                                {
                                    id: 'decorate:style_code_mobile',
                                    text: '手机样式代码',
                                    href: '${ctx}/admin/sa/mobile/decorate/staticResourceMobile?key=static_resource_css_mobile'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="decorate:public_setting">
                    {
                        text: '公共页面设置',
                        items: [
                            <@securityAuthorize ifAnyGranted="decorate:public_setting:custom_area">
                                {
                                    id: 'decorate:custom_area',
                                    text: '自定义页面',
                                    href: '${ctx}/admin/sa/decorate/customArea/turnToPage'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="decorate:public_setting:article_manager">
                                {
                                    id: 'decorate:article_manager',
                                    text: '文章管理',
                                    href: '${ctx}/admin/sa/decorate/article'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="decorate:public_setting:article_class">
                                {
                                    id: 'decorate:article_class',
                                    text: '文章分类',
                                    href: '${ctx}/admin/sa/decorate/articleType'
                                },
                            </@securityAuthorize>
                        <#--
                        <@securityAuthorize ifAnyGranted="decorate:web_SEO">
                            {id: 'decorate:web_SEO', text: '网站SEO', href: '${ctx}/admin/sa/decorate/websiteSeo/websiteSeo'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="decorate:system_notice">
                            {id: 'decorate:system_notice', text: '系统通知', href: '${ctx}/admin/sa/decorate/systemNotice/turnToPage'},
                        </@securityAuthorize>
                        -->]
                    }

                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <@securityAuthorize ifAnyGranted="wechat">
        config.push(updateModulesHomePage({
            id: 'wechat',
            menu: [
                <@securityAuthorize ifAnyGranted="wechat:base">
                    {
                        text: '首页',
                        items: [
                            <@securityAuthorize ifAnyGranted="wechat:base:index">
                                {id: 'wechat:base:index', text: '微信首页', href: '${ctx}/admin/sa/wechat/index'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="wechat:base:setting">
                                {id: 'wechat:base:setting', text: '微信配置', href: '${ctx}/admin/sa/wechat/setting'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="wechat:base:menu">
                                {id: 'wechat:base:menu', text: '自定义菜单', href: '${ctx}/admin/sa/wechat/menuList'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="wechat:base:first_subscribe_reply">
                                {
                                    id: 'wechat:base:first_subscribe_reply',
                                    text: '首次关注回复',
                                    href: '${ctx}/admin/sa/wechat/firstSubscribe'
                                },
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="wechat:base:qrcode_reply">
                            {id: 'wechat:base:qrcode_reply', text: '扫码关注回复', href: '${ctx}/admin/sa/wechat/qrSubscribe'},
                        </@securityAuthorize>
						<@securityAuthorize ifAnyGranted="wechat:base:storeqrcode_reply">
                            {id: 'wechat:base:storeqrcode_reply', text: '扫门店二维码回复', href: '${ctx}/admin/sa/wechat/md_qrSubscribe'},
                        </@securityAuthorize>												
                        <@securityAuthorize ifAnyGranted="wechat:base:wx_storeqrcode_reply">
                            {id: 'wechat:base:wx_storeqrcode_reply', text: '扫微店二维码回复', href: '${ctx}/admin/sa/wechat/wd_qrSubscribe'},
                        </@securityAuthorize> -->
                            <@securityAuthorize ifAnyGranted="wechat:base:autoReply_message">
                                {
                                    id: 'wechat:base:autoReply_message',
                                    text: '消息自动回复',
                                    href: '${ctx}/admin/sa/wechat/autoReply'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="wechat:base:keyword_reply">
                                {
                                    id: 'wechat:base:keyword_reply',
                                    text: '关键词回复',
                                    href: '${ctx}/admin/sa/wechat/keywordList'
                                },
                            </@securityAuthorize>]
                    }
                    ,
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="wechat:spread">
                    {
                        text: '推广',
                        items: [
                            <@securityAuthorize ifAnyGranted="wechat:spread:scanCode">
                                {
                                    id: 'wechat:qrcode:media',
                                    text: '扫微信二维码回复',
                                    href: '${ctx}/admin/sa/wechat/qrSubscribe'
                                }
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="wechat:manage">
                    , {
                    text: '管理',
                    items: [
                        <@securityAuthorize ifAnyGranted="wechat:manage:media">
                            {id: 'wechat:manage:media', text: '素材管理', href: '${ctx}/admin/sa/wechat/showMedia'},
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="wechat:manage:wx_user_maneger">
                            {
                                id: 'wechat:manage:wx_user_maneger',
                                text: '微信用户管理',
                                href: '${ctx}/admin/sa/wechat/userList'
                            },
                        </@securityAuthorize>
                        <@securityAuthorize ifAnyGranted="wechat:manage:wx_message_manege">
                            {id: 'wechat:base:wx_message_manege', text: '消息管理', href: '${ctx}/admin/sa/wechat/list'}
                        </@securityAuthorize>]
                }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#--规则-->
    <@securityAuthorize ifAnyGranted="rule">
        config.push(updateModulesHomePage({
            id: 'rule',
            menu: [
                <@securityAuthorize ifAnyGranted="rule:totalRule">
                    {
                        text: '总规则',
                        items: [
                            <@securityAuthorize ifAnyGranted="rule:totalRule:expressions">
                                {
                                    id: 'rule:head:cost_check_equation',
                                    text: '成本核算总公式',
                                    href: '${ctx}/admin/sa/costCalculation/list'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="rule:base">
                    {
                        text: '会员规则',
                        items: [
                            <@securityAuthorize ifAnyGranted="rule:base:rank">
                                {id: 'rule:base:rank', text: '会员等级', href: '${ctx}/admin/sa/userLevel/userLevelList'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="rule:base:integration">
                                {id: 'rule:base:integration', text: '积分规则', href: '${ctx}/admin/sa/pointRule/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="rule:base:salePoint">
                                {
                                    id: 'rule:base:salePoint',
                                    text: '分销业绩点',
                                    href: '${ctx}/admin/sa/distributionRule/developDistributors'
                                },
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <@securityAuthorize ifAnyGranted="statement">
    <#-- 对账单 -->
        config.push(updateModulesHomePage({
            id: 'statement',
            menu: [
                <@securityAuthorize ifAnyGranted="statement:manage">
                    {
                        text: '对账单',
                        items: [
                            <@securityAuthorize ifAnyGranted="statement:manage:user">
                                {
                                    id: 'statement:manage:user',
                                    text: '会员总账单',
                                    href: '${ctx}/admin/sa/userTotalBill/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="statement:manage:client">
                                {
                                    id: 'statement:manage:user',
                                    text: '客户对账单',
                                    href: '${ctx}/admin/sa/customerBill/list?type=0'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="statement:manage:nextClientList">
                                {
                                    id: 'statement:manage:user',
                                    text: '下级客户总账单',
                                    href: '${ctx}/admin/sa/subCustomerTotalBill/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="statement:manage:nexcClientDetail">
                                {
                                    id: 'statement:manage:user',
                                    text: '下级客户账目明细',
                                    href: '${ctx}/admin/sa/subCustomerBillDetail/list'
                                }
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="statement:manage:store">
                        {id: 'statement:manage:store', text: '门店账单', href: '${ctx}/admin/sa/storeBill/list'},
                    </@securityAuthorize>
                    <@securityAuthorize ifAnyGranted="statement:manage:shopper">
                        {id: 'statement:manage:shopper', text: '配送员账单', href: '${ctx}/admin/sa/shopperBill/list'}
                    </@securityAuthorize>-->]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="statement:expense">
                    {
                        text: '会员消费账单',
                        items: [
                            <@securityAuthorize ifAnyGranted="statement:expense:userBalance">
                                {
                                    id: 'statement:expense:userBalance',
                                    text: '会员收支明细',
                                    href: '${ctx}/admin/sa/userBalanceDetail/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="statement:expense:userBalance">
                                {
                                    id: 'statement:expense:userConsume',
                                    text: '会员消费明细',
                                    href: '${ctx}/admin/sa/userConsumeDetail/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="statement:expense:userPoint">
                                {
                                    id: 'statement:expense:userPoint',
                                    text: '会员积分及消费查询',
                                    href: '${ctx}/admin/sa/userScoreAndConsume/list'
                                }
                            </@securityAuthorize>]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#-- 运营分析 -->
    <@securityAuthorize ifAnyGranted="analysis">
        config.push(updateModulesHomePage({
            id: 'analysis',
            menu: [
                <@securityAuthorize ifAnyGranted="analysis:order">
                    {
                        text: '订单分析',
                        items: [
                            <@securityAuthorize ifAnyGranted="analysis:order:dailyOrders">
                                {
                                    id: 'analysis:order:dailyOrders',
                                    text: '每日订单量',
                                    href: '${ctx}/admin/sa/dailyOrders/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:order:userOrders">
                                {
                                    id: 'analysis:order:userOrders',
                                    text: '会员下单量',
                                    href: '${ctx}/admin/sa/userOrders/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:order:sendProductTotal">
                                {
                                    id: 'analysis:order:sendProductTotal',
                                    text: '发货统计',
                                    href: '${ctx}/admin/sa/invoiceStatistics/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:order:returnProductTotal">
                                {
                                    id: 'analysis:order:returnProductTotal',
                                    text: '退货统计',
                                    href: '${ctx}/admin/sa/returnStatistics/list'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="analysis:product">
                    {
                        text: '商品分析',
                        items: [
                            <@securityAuthorize ifAnyGranted="analysis:product:dailySale">
                                {
                                    id: 'analysis:product:dailySale',
                                    text: '每日商品销量',
                                    href: '${ctx}/admin/sa/dailyProducts/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:product:perSale">
                                {
                                    id: 'analysis:product:perSale',
                                    text: '每款商品销量',
                                    href: '${ctx}/admin/sa/perSaleProduct/list'
                                },
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="analysis:product:stock">-->
                        <#--{id: 'analysis:product:stock', text: '库存报表', href: '${ctx}'},-->
                        <#--</@securityAuthorize>-->
                            <@securityAuthorize ifAnyGranted="analysis:product:saleList">
                                {
                                    id: 'analysis:product:saleList',
                                    text: '商品销量表',
                                    href: '${ctx}/admin/sa/productAnalysis/list'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="analysis:sale_income">
                    {
                        text: '收支分析',
                        items: [
                            <@securityAuthorize ifAnyGranted="analysis:sale_income:saleIncome">
                                {
                                    id: 'analysis:sale_income:saleIncome',
                                    text: '收入/支出',
                                    href: '${ctx}/admin/sa/saleIncome/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:sale_income:incomeInfo">
                                {
                                    id: 'analysis:sale_income:incomeInfo',
                                    text: '收款统计',
                                    href: '${ctx}/admin/sa/report/payCount/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:sale_income:returnInfo">
                                {
                                    id: 'analysis:sale_income:returnInfo',
                                    text: '退款统计',
                                    href: '${ctx}/admin/sa/refundStatistics/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:sale_income:account">
                                {
                                    id: 'analysis:sale_income:account',
                                    text: '账户余额收支',
                                    href: '${ctx}/admin/sa/report/userBalanceDetail/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="analysis:sale_income:expressBill">
                                {
                                    id: 'analysis:sale_income:expressBill',
                                    text: '快递费支出',
                                    href: '${ctx}/admin/sa/report/expressFee/list'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

    <#-- 审核 -->
    <@securityAuthorize ifAnyGranted="audit">
        config.push(updateModulesHomePage({
            id: 'audit',
            menu: [
                <@securityAuthorize ifAnyGranted="audit:base">
                    {
                        text: '审核开关',
                        items: [
                            <@securityAuthorize ifAnyGranted="audit:base:switch">
                                {id: 'audit:base:switch', text: '审核开关', href: '${ctx}/admin/sa/auditSetting/list'}
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="audit:bill">
                    {
                        text: '票券审核',
                        items: [
                            <@securityAuthorize ifAnyGranted="audit:bill:promotion">
                                {id: 'audit:ticket:coupon', text: '优惠券审核', href: '${ctx}/admin/sa/couponAudit/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="audit:bill:group">
                                {id: 'audit:ticket:groupon', text: '团购审核', href: '${ctx}/admin/sa/grouponAudit/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="audit:bill:getProduct">
                                {
                                    id: 'audit:ticket:pickupCoupon',
                                    text: '提货券审核',
                                    href: '${ctx}/admin/sa/pickUpCouponAudit/list'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="audit:order">
                    {
                        text: '订单审核',
                        items: [
                            <@securityAuthorize ifAnyGranted="audit:order:priceChange">
                                {
                                    id: 'audit:order:priceChange',
                                    text: '订单审核',
                                    href: '${ctx}/admin/sa/orderPriceAudit/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="audit:order:presale">
                                {
                                    id: 'audit:order:presale',
                                    text: '预售订单审核',
                                    href: '${ctx}/admin/sa/preOrderPriceAudit/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="audit:order:orderReturn">
                                {
                                    id: 'audit:order:orderReturn',
                                    text: '退款审核',
                                    href: '${ctx}/admin/sa/returnAudit/list'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="audit:product">
                    {
                        text: '商品审核',
                        items: [
                            <@securityAuthorize ifAnyGranted="audit:product:price">
                                {
                                    id: 'audit:product:price',
                                    text: '商品价格审核',
                                    href: '${ctx}/admin/sa/productAudit/priceAuditList'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="audit:product:isSale">
                                {
                                    id: 'audit:product:isSale',
                                    text: '商品上架审核',
                                    href: '${ctx}/admin/sa/productAudit/saleAuditList'
                                },
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="audit:userRecharge">
                    {
                        text: '会员审核',
                        items: [
                            <@securityAuthorize ifAnyGranted="audit:userRecharge:price">
                                {
                                    id: 'audit:userRecharge:price',
                                    text: '会员金额审核',
                                    href: '${ctx}/admin/sa/userPriceAudit/list'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="audit:userRecharge:point">
                                {
                                    id: 'audit:userRecharge:point',
                                    text: '会员积分审核',
                                    href: '${ctx}/admin/sa/userScoreAudit/list'
                                },
                            </@securityAuthorize>
                        <#--<@securityAuthorize ifAnyGranted="audit:userRecharge:fenxiao">
                            {id: 'audit:userRecharge:distributor', text: '分销会员审核', href: '${ctx}/'},
                        </@securityAuthorize>-->]
                    }
                </@securityAuthorize>
            <#--<@securityAuthorize ifAnyGranted="audit:account">
                {
                    text: '对账单结算审核',
                    items: [
                        <@securityAuthorize ifAnyGranted="audit:account:billAccount">
                            {id: 'audit:statement:balance', text: '对账单结算审核', href: '${ctx}/'},
                        </@securityAuthorize>]
                }
            </@securityAuthorize>-->]
        }));
    </@securityAuthorize>

    <@securityAuthorize ifAnyGranted="setting">
        config.push(updateModulesHomePage({
            id: 'setting',
            menu: [
                <@securityAuthorize ifAnyGranted="setting:accountManager">
                    {
                        text: '帐号权限',
                        items: [
                            <@securityAuthorize ifAnyGranted="setting:accountManager:role">
                                {id: 'setting:role', text: '岗位管理', href: '${ctx}/admin/sa/role/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="setting:accountManager:account">
                                {id: 'setting:account', text: '帐号管理', href: '${ctx}/admin/sa/adminUser/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="setting:accountManager:api_config">
                                {
                                    id: 'setting:api_config',
                                    text: 'API配置',
                                    href: '${ctx}/admin/sa/common/openApi/set/wechat_mall'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="setting:accountManager:operaterLog">
                                {id: 'setting:operaterLog', text: '操作日志', href: '${ctx}/admin/sa/managerlog/list'},
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="setting:accountManager:modifyPassword">
                                {
                                    id: 'setting:modifyPassword',
                                    text: '修改密码',
                                    href: '${ctx}/admin/sa/adminUser/changePassword'
                                }
                            </@securityAuthorize>]
                    },
                </@securityAuthorize>
                <@securityAuthorize ifAnyGranted="setting:system_config">
                    {
                        text: '系统配置',
                        items: [
                            <@securityAuthorize ifAnyGranted="setting:system_config:pay_config">
                                {
                                    id: 'setting:pay_config',
                                    text: '支付接口设置',
                                    href: '${ctx}/admin/sa/common/businessconfig/typeList?flag=1'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="setting:system_config:api_config">
                                {
                                    id: 'setting:thirdparty_login_config',
                                    text: '第三方登录接口',
                                    href: '${ctx}/admin/sa/common/businessconfig/typeList?flag=3'
                                },
                            </@securityAuthorize>
                            <@securityAuthorize ifAnyGranted="setting:system_config:config">
                                {
                                    id: 'setting:system_config',
                                    text: '系统配置',
                                    href: '${ctx}/admin/sa/common/config/systemconfig'
                                },
                            </@securityAuthorize>

                        <#--<@securityAuthorize ifAnyGranted="setting:sms_config">
                            {id: 'setting:sms_config', text: '短信推送配置', href: '${ctx}/admin/sa/smsPush/pushConfig'},
                        </@securityAuthorize>-->
                        <#--<@securityAuthorize ifAnyGranted="setting:other_config">
                            {id: 'setting:other_config', text: '其它接口设置', href: '${ctx}/admin/sa/common/businessconfig/typeList?flag=2'},
                        </@securityAuthorize>-->]
                    }
                </@securityAuthorize>]
        }));
    </@securityAuthorize>

        new PageUtil.MainPage({
            modulesConfig: config
        });
    });

    function updateModulesHomePage(moduleObj) {
        if (moduleObj.menu && moduleObj.menu.length) {
            for (var i = 0; i < moduleObj.menu.length; i++) {
                if (moduleObj.menu[i].items && moduleObj.menu[i].items.length) {
                    var suitItem = false;
                    for (var j = 0; j < moduleObj.menu[i].items.length; j++) {
                        if (moduleObj.menu[i].items[j].id) {
                            moduleObj.homePage = moduleObj.menu[i].items[j].id;
                            suitItem = true;
                            break;
                        }
                    }
                    if (suitItem) {
                        break;
                    }
                }
            }
        }
        return moduleObj;
    }

    function showMessage(message, clazz) {
        var html = $('<span class="dl-msg-item ' + clazz + '">' + message + '</span>');
        html.appendTo($("#dl-msg"));
        setTimeout(function () {
            html.remove()
        }, 1200);
    }

    function showSuccess(message) {
        showMessage(message, 'dl-msg-success');
    }

    function showError(message) {
        showMessage(message, 'dl-msg-error');
    }

    function changePassword() {
        app.page.open({
            moduleId: 'setting',
            id: 'changePassword-management',
            reload: true
        })
    }

    globalSearchs = {};
    $(function () {
        function getBasePath() {
            var basePath = window.location.protocol + "//" + window.location.host;
            return basePath;
        }

        $("#barcodeImgId").attr("src", "${ctx}/qrCode/generate?w=100&h=100&content=" + getBasePath() + "/m")
        $('.dl-log-ddwrap').hover(function () {
            $('.dl-log-dd').show();
        }, function () {
            $('.dl-log-dd').hide();
        });

        var msg_panel = $('#J_MsgPanel');
        msg_panel.find('.panel-toggle').on('click', function () {
            msg_panel.toggleClass('toggled');
        });
        msg_panel.find('.panel-close').on('click', function () {
            msg_panel.hide().remove();
        });
    })
</script>
</body>
</html>