<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/page.css" rel="stylesheet" type="text/css"/>
</head>
<body>

<div class="container">
    <div class="modheader">
        <div class="mod-welcome">
            <div class="usrpic"><img src="${ctx}/static/images/userhead.jpg" alt=""/></div>
            <div class="welcomeinfo">
                <div class="greeting"><em>${adminRealName!}</em>，您好！</div>
                <div class="logininfo">
                    <p>上次登录IP：<em>${lastLoginIp!}</em></p>
                    <p>上次登录时间：<em>${((lastLoginTime)?string("yyyy-MM-dd HH:mm:ss"))!}</em></p>
                </div>
            </div>
        </div>
        <div class="mod-user">
            <div class="mod-user-toggle">
                <ul>
                    <li>今日新增会员<p>${todayUserNum!}</p></li>
                    <li>昨日新增会员<p>${yesterUserNum!}</p></li>
                    <li>会员总数<p>${allUserNum!}</p></li>
                </ul>
            </div>
            <div class="progressbar">
                <span style="width:50%"></span>
                <p style="width:20%"></p>
            </div>
        </div>

    </div>


    <div class="incontainer">
        <table cellspacing="0" class="table table-info indextable-info">
            <caption>待办事项</caption>
            <tbody>
            <tr>
                <th>订单</th>
                <td>
                <@securityAuthorize ifAnyGranted="order:manage:all">
                    <a href="${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=1&type=1">未付款&nbsp; ${unpayCount!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="order:manage:all">
                    <a href="${ctx}/admin/sa/orderManage/toAllOrder?orderTypeCd=1&type=2">待发货 &nbsp;${unsetCount!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="order:service:return">
                    <a href="${ctx}/admin/sa/order/orderReturnList">退款退货 &nbsp;${returnCount!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="order:manager:preSale">
                    <a href="${ctx}/admin/sa/orderTypes/toPreSaleOrders">预售 &nbsp;${preSaleCount!}</a>
                </@securityAuthorize>
                </td>

                <th>商品</th>
                <td>
                <@securityAuthorize ifAnyGranted="product:manage:product_manage">
                    <a href="${ctx}/admin/sa/productManage/list?productStatusCd=2">已下架&nbsp; ${noAlreadyProductNum!}
                    </a>
                </@securityAuthorize>
                </td>
            <#--<td>-->
            <#--<@securityAuthorize ifAnyGranted="product:manage:product_manage">-->
            <#--<a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">总店在上架 &nbsp;${alreadyProductNum!}-->
            <#--</a>-->
            <#--</@securityAuthorize>-->
            <#--</td>-->
                <td>
                <@securityAuthorize ifAnyGranted="product:manage:product_manage">
                    <a href="${ctx}/admin/sa/productManage/list?productStatusCd=1">商品总数 &nbsp;${allProductNum!}
                    </a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="product:manage:inventory_warning">
                    <a href="${ctx}/admin/sa/productManage/warningProductList?productStatusCd=1">库存预警 &nbsp;${stockNum!}
                    </a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="audit:product">
                    <a href="${ctx}/admin/sa/productAudit/priceAuditList">待审核商品 &nbsp;${preAuditProduct!}
                    </a>
                </@securityAuthorize>
                </td>
            </tr>
            <tr>
                <th>审核内容</th>
                <td>
                <@securityAuthorize ifAnyGranted="audit:order:priceChange">
                    <a href="${ctx}/admin/sa/orderPriceAudit/list">订单审核&nbsp; ${orderPriceAuditNum!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="audit:order:orderReturn">
                    <a href="${ctx}/admin/sa/returnAudit/list">退换货审核&nbsp; ${orderReturnAuditNum!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="audit:userRecharge:price">
                    <a href="${ctx}/admin/sa/userPriceAudit/list">会员金额审核&nbsp; ${userPriceAuditNum!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="audit:userRecharge:point">
                    <a href="${ctx}/admin/sa/userScoreAudit/list">会员积分审核&nbsp; ${userScoreAuditNum!}</a>
                </@securityAuthorize>
                </td>

                <th>评价咨询</th>
                <td>
                <@securityAuthorize ifAnyGranted="user:manageRecord:consult">
                    <a href="${ctx}/admin/sa/user/consult">咨询&nbsp; ${consultInfoCount!}</a>
                </@securityAuthorize>
                </td>
                <td>
                <@securityAuthorize ifAnyGranted="user:manageRecord:review">
                    <a href="${ctx}/admin/sa/user/review">评价&nbsp;${reviewPassCount!}</a>
                </@securityAuthorize>
                </td>
                <td></td>
                <td></td>
            </tr>
            </tbody>
        </table>
        <div class="mod">
            <h3 class="modtit"><span>待付款订单</span></h3>
            <div id="grid_unpay"></div>
        </div>
        <div class="mod">
            <h3 class="modtit"><span>未审核订单</span></h3>
            <div id="grid_uncheck"></div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
<script type="text/javascript" src="${staticPath}/admin/js/config.js"></script>
<script type="text/javascript">
    var search;
    var grid;
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '订单来源', dataIndex: 'originPlatformName', width: 70},
            {
                title: '订单号', dataIndex: 'orderNumber', width: 140, renderer: function (value, rowObj) {
                var str = "";
                str = "<a href='javascript:toOrderInfo(\"" + rowObj.orderId + "\");'>" + value + "</a>";
                return str;
            }
            },
            {title: '收货人', dataIndex: 'receiveName', width: 100},
            {title: '手机号', dataIndex: 'receiveTel', width: 100},
            {title: '收货地址', dataIndex: 'receiveAddrCombo', width: 160},
            {title: '会员', dataIndex: 'loginName', width: 120},
            {title: '数量', dataIndex: 'quantitys', width: 80},
            {title: '金额', dataIndex: 'orderTotalAmt', width: 80},
            {title: '实付金额', dataIndex: 'actualAmt', width: 80},
            {title: '配送方式', dataIndex: 'expressName', width: 80},
            {title: '下单时间', dataIndex: 'createTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '备注', dataIndex: 'remark', width: 120}
        ];
        var store = Search.createStore('${ctx}/admin/sa/grid_json?orderStatusCd=1', {pageSize: 10});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize]
        });

        var search = new Search({
            gridId: "grid_unpay",
            formId: "searchForm_unpay",
            store: store,
            gridCfg: gridCfg
        });
        var grid = search.get('grid');
        grid.render();

    });

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '订单来源', dataIndex: 'originPlatformName', width: 70},
            {
                title: '订单号', dataIndex: 'orderNumber', width: 140, renderer: function (value, rowObj) {
                var str = "";
                str = "<a href='javascript:toOrderInfo(\"" + rowObj.orderId + "\");'>" + value + "</a>";
                return str;
            }
            },
            {title: '收货人', dataIndex: 'receiveName', width: 100},
            {title: '手机号', dataIndex: 'receiveTel', width: 100},
            {title: '收货地址', dataIndex: 'receiveAddrCombo', width: 160},
            {title: '会员', dataIndex: 'loginName', width: 120},
            {title: '数量', dataIndex: 'quantitys', width: 80},
            {title: '金额', dataIndex: 'orderTotalAmt', width: 80},
            {title: '实付金额', dataIndex: 'actualAmt', width: 80},
            {title: '配送方式', dataIndex: 'expressName', width: 80},
            {title: '下单时间', dataIndex: 'createTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '备注', dataIndex: 'remark', width: 120}
        ];
        var store = Search.createStore('${ctx}/admin/sa/grid_json?auditStatusCd=0', {pageSize: 10});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize]
        });

        var search = new Search({
            gridId: "grid_uncheck",
            formId: "searchForm_uncheck",
            store: store,
            gridCfg: gridCfg
        });
        var grid = search.get('grid');

    });

    //点击编号跳转至编辑页面
    <@securityAuthorize ifAnyGranted="order:manage:all">
    function toOrderInfo(obj) {
        window.open("${ctx}/admin/sa/orderManage/toAllOrderDetail?orderId=" + obj);
    }
    </@securityAuthorize>
</script>

</body>
</html>  