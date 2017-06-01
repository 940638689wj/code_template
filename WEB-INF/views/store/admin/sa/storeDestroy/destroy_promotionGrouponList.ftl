<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="title-bar">
            <div id="tab"></div>
        </div>
        <div class="content-top">
            <div id="tab1"></div>
            <div class="title-bar-side">
                <div class="search-bar">
                </div>
                <div class="search-content">
                </div>
            </div>
        </div>
        <div class="title-bar">
            <div class="title-bar">
                <div id="tab"></div>
            </div>
            <div class="content-top">
                <form id="searchForm" class="form-horizontal search-form" onkeydown="if(event.keyCode==13)return false;">
                    <div class="content-top">
                        <input type="hidden" value="${type!}" name="couponStatusCd">
                        <input id="couponCodeOrPhone" name="couponCodeOrPhone" class="control-text"
                               placeholder="券号/手机号">
                        &nbsp;&nbsp;
                        <button id="btnSearch" type="button" class="button button-primary">搜索</button>
                        &nbsp;&nbsp;
                    <#--<button type="button" class="button button-primary">核销</button>-->
                    </div>
                </form>
            </div>
            <div class="content-body">
                <div class="title-bar-side">
                    <div class="search-content">
                    </div>
                </div>
                <div id="grid"></div>
            </div>
        </div>

    </div>
</div>

<script type="text/javascript">
    var Tab = BUI.Tab;
    var search;
    var grid;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '待核销团购券', value: '1'},
            {text: '已核销团购券', value: '2'},
            {text: '待核销提货券', value: '3'},
            {text: '已核销提货券', value: '4'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '排序', dataIndex: 'couponCodeId', width: 80},
            {title: '团购名称', dataIndex: 'promotionName', width: 150},
            {
                title: '有效使用时间', dataIndex: '', width: 200, renderer: function (value, rowObj) {
                var cardNum = "";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseStartTime);
                cardNum += " 至 ";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseEndTime);
                return cardNum;
            }
            },
            {title: '金额', dataIndex: 'couponCodeValue', width: 80},
            {title: '会员 ', dataIndex: 'nickName', width: 100},
            {title: '手机号', dataIndex: 'phone', width: 100},
        <#if type == 1>
            {
                title: '操作', dataIndex: '', width: 100, renderer: function (value, rowObj) {
                return '&nbsp;&nbsp;<a href=\'javascript:destroy(\"' + rowObj.couponCodeId + '\")\'>核销</a>';
            }
            }
        <#elseif type == 2>
            {title: '核销时间', dataIndex: 'usedTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer}
        </#if>
        ];
        var store = Search.createStore('/admin/sa/storeDestroy/promotionGroupon_grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns
            , tbar: {
                items: []
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get("grid");

        grid.render();

        tab.setSelected(tab.getItemAt(${(type!)-1}));
        //切换标签
        tab.on('selectedchange', function (ev) {
            var type = ev.item.get("value");
            if (type == 1 || type == 2) {
                window.location.href = "${ctx}/admin/sa/storeDestroy/toPromotionGrouponList?type=" + type;
            }
            if (type == 3 || type == 4) {
                window.location.href = "${ctx}/admin/sa/storeDestroy/toPickupcouponList?type="+type;
            }
        });

    });

    /**
     * 核销
     *
     * @param couponCodeId    团购id
     */
    function destroy(couponCodeId) {
        BUI.Message.Confirm('是否核销团购券？', function () {
            $.post("${ctx}/admin/sa/storeDestroy/destroyPromotionGroupon", {
                couponCodeId: couponCodeId
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess('核销成功');
                    search.load();
                }
            }, 'json');
        });
    }

</script>
</body>
</html>