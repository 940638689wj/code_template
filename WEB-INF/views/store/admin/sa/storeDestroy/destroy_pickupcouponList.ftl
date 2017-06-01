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
                    <input type="hidden" value="${(type!)-2}" name="usedStatusCd">
                    <div class="content-top">
                        <input id="pickupCouponCodeNumOrPhone" name="pickupCouponCodeNumOrPhone" class="control-text"
                               placeholder="票券号/手机号">
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

    <#--弹窗选择礼包，输入密码-->
        <div id="destoryDialog" class="well" style="display: none;">
            <form id="J_Form" class="form-horizontal" action="1" method="post">
                <input type="hidden" id="pickupCouponCodeId" name="pickupCouponCodeId" value=""/>
                <div id="notSelected" class="form-content">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>选择套餐：</label>
                            <div class="controls control-row-auto" id="packageRadio">
                                <input name="pickupCouponPackageId" type="radio" value=""/>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label"><s>*</s>券密码：</label>
                            <div class="controls">
                                <input name="pickupCouponPassword" id="pickupCouponPassword" type="text"
                                       class="input-normal control-text"/>
                            </div>
                        </div>
                    </div>
                </div>
                <div id="selected" class="form-content">
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="color: white">1</label>
                            <div class="controls">
                                <h4>是否确认提货？</h4>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group">
                            <label class="control-label" style="color: white">2</label>
                            <div class="controls">
                                <img src="" id="selectedImg" style="width:150px;height:150px;"/>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<script type="text/javascript">
    var Tab = BUI.Tab;
    var search;
    var grid;
    var destoryDialog;
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
            {title: '排序', dataIndex: 'pickupCouponCodeId', width: 80},
            {title: '提货券名称', dataIndex: 'pickupCouponName', width: 150},
            {title: '可提货门店', dataIndex: 'storeName', width: 150},
            {
                title: '有效使用时间', dataIndex: '', width: 200, renderer: function (value, rowObj) {
                var cardNum = "";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseStartTime);
                cardNum += " 至 ";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseEndTime);
                return cardNum;
            }
            },
            {title: '金额', dataIndex: 'pickupAmt', width: 100},
            {title: '手机号', dataIndex: 'phone', width: 100},
            {
                title: '下单状态', dataIndex: '', width: 80, renderer: function (value, rowObj) {
                if (rowObj.orderId) {
                    return '已下单';
                }
                return '未下单';
            }
            },
        <#if type == 3>
            {
                title: '操作', dataIndex: '', width: 100, renderer: function (value, rowObj) {
                return '&nbsp;&nbsp;<a href=\'javascript:showDestoryDialog(' + rowObj.pickupCouponCodeId + ')\'>提货</a>';
            }
            }
        <#elseif type == 4>
            {title: '核销时间', dataIndex: 'usedTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer}
        </#if>
        ];
        var store = Search.createStore('/admin/sa/storeDestroy/pickupcoupon_grid_json', {pageSize: 15});
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
                window.location.href = "${ctx}/admin/sa/storeDestroy/toPickupcouponList?type=" + type;
            }
        });

    });

    destoryDialog = new BUI.Overlay.Dialog({
        title: '提货',
        width: 500,
        height: 300,
        //配置DOM容器的编号
        contentId: 'destoryDialog',
        success: function () {
            $.post('${ctx}/admin/sa/storeDestroy/destroyPickupcoupon', {
                pickupCouponCodeId: $('#pickupCouponCodeId').val(),
                pickupCouponPackageId: $('input[name="pickupCouponPackageId"]:checked').val(),
                pickupCouponPassword: $('#pickupCouponPassword').val()
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess('提货完成');
                    search.load();
                    destoryDialog.hide();
                }
            }, 'json');
        }
    });

    /**
     * 弹窗显示礼包详情
     */
    function showDestoryDialog(pickupCouponCodeId) {
        $('#pickupCouponCodeId').val(pickupCouponCodeId);
        $('#packageRadio').html('');
        $('#pickupCouponPassword').val('');

        $.post('${ctx}/admin/sa/storeDestroy/findPackage', {
            "pickupCouponCodeId": pickupCouponCodeId
        }, function (data) {
            if (app.ajaxHelper.handleAjaxMsg(data)) {
                if (data.data.selected) {
                    //已选择过礼包
                    $('#notSelected').hide();
                    $('#selected').show();
                    $('#selectedImg').attr('src', data.data.package.packagePicUrl);
                } else {
                    //未选择过礼包
                    $('#notSelected').show();
                    $('#selected').hide();
                    $.each(data.data.package, function (index, value, array) {
                        var packageStr = '<div style="float:left"><input name="pickupCouponPackageId" type="radio" value="'
                                + value.pickupCouponPackageId
                                + '"/>'
                                + value.packageName.substr(0, 15)
                                + '<br/><img src="'
                                + value.packagePicUrl
                                + '" style="width:100px;height: 100px;"/></div>';
                        $('#packageRadio').append(packageStr);
                    })
                }
                destoryDialog.show();
            }
        }, "json");
    }

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