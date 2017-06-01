<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
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
            <div class="title-bar-side">
                <div class="recyclebin"><a href="${ctx}/admin/sa/orderManage/toPreSaleOrderRecycle?orderDistrbuteTypeCd=${orderDistrbuteTypeCd!}">订单回收站</a></div>
                <div class="search-bar">
                    <input type="text" placeholder="订单号" class="control-text" oninput="syncOrderNumber(this)"/>
                    <button type="button" onclick="searchLoad()"><i class="icon-search"></i></button>
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal search-form">
                        <input name="type" value="0" type="hidden"/>
                        <input name="orderNumber" value="" type="hidden"/>
                        <input name="orderDistrbuteTypeCd" value="${orderDistrbuteTypeCd!}" type="hidden"/>
                        <input name="adminDeleteStatusCd" value="1" type="hidden"/>

                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">订单来源：</label>
                                <div class="controls">
                                    <input type="radio" name="originPlatformCd" value="" checked="checked">全部
                                    <input type="radio" name="originPlatformCd" value="0">pc端
                                    <input type="radio" name="originPlatformCd" value="1">手机端
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">会员手机：</label>
                                <div class="controls">
                                    <input type="text" name="phone" class="control-text" id="phone">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="form-actions offset3">
                                <button type="button" class="button button-primary" onclick="searchLoad()">
                                    搜索
                                </button>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
        <div class="content-body">
            <div id="grid"></div>
        </div>

    </div>
</div>

<script type="text/javascript">
    var search;
    var grid;
    var tab = new BUI.Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '全部(<span class="type0"></span>)', value: '0'},
            {text: '未付定金(<span class="type1"></span>)', value: '1'},
            {text: '未付尾款(<span class="type2"></span>)', value: '2'},
            {text: '待发货(<span class="type3"></span>)', value: '3'},
            {text: '已发货(<span class="type4"></span>)', value: '4'},
            {text: '已完成(<span class="type5"></span>)', value: '5'},
            {text: '已关闭(<span class="type6"></span>)', value: '6'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
//            {title: '操作', dataIndex: '', width: "50px"},
            {
                title: '操作', dataIndex: '', width: "50px", renderer: function (val, obj) {
                var str = "";
                if (obj.orderStatusCd == 6) {
                <@securityAuthorize ifAnyGranted="delete">
                    str += "<span class='grid-command' onclick='delOrder(" + obj.orderId + ")'>删除</span>";
                </@securityAuthorize>
                }
                return str;
            }
            },
            {
                title: '订单号', dataIndex: 'orderNumber', width: "180px", renderer: function (val, obj) {
                return "<a href='${ctx}/admin/sa/orderManage/toPreSaleOrderDetail?orderId=" + obj.orderId + "' target='_blank'>" + val + "</a>";
            }
            },
            {title: '订单来源', dataIndex: 'originPlatformName', width: "100px"},
            {title: '会员手机', dataIndex: 'phone', width: "100px"},
            {title: '数量', dataIndex: 'quantity', width: 40},
            {title: '定金', dataIndex: 'price', width: "70px"},
            {title: '付定金时间', dataIndex: 'depositPayTime', width: "140px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '定金支付类型', dataIndex: 'depositOrderPayModelName', width: "90px"},
            {title: '尾款', dataIndex: 'restPrice', width: "70px"},
            {title: '付尾款时间', dataIndex: 'restPayTime', width: "140px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '订单状态', dataIndex: 'orderStatusName', width: "80px"}
        ];
        var store = Search.createStore('findPreSaleOrderPage', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns,
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small button-primary', handler: exportPreSale}
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get("grid");

        grid.render();

        // 切换标签
        tab.on('selectedchange', function (ev) {
            $("input[name=type]").val(ev.item.get("value"));
            search.load();
        });
        tab.setSelected(tab.getItemAt(0));

    });

    //点击 右上角搜索框
    var mask;
    $('.title-bar-side .search-bar input').on('focus', function () {
        var $this = $(this);
        var searchCon = $this.closest('.title-bar-side').find('.search-content');
        $this.addClass("focused");
        if (!mask)
            mask = $('<div></div>').css({
                'position': 'absolute',
                'left': 0,
                'top': 0,
                'width': '100%',
                'height': '100%'
            }).appendTo(document.body);
        searchCon.show(400);
        mask.on('click', function () {
            $this.removeClass("focused");
            mask.remove();
            mask = null;
            searchCon.hide(400);
        });
    });

    /**
     * 将订单号查询条件同步至搜索框
     *
     * @param obj
     */
    function syncOrderNumber(obj) {
        $("input[name=orderNumber]").val($(obj).val());
    }

    function searchLoad() {
        search.load();
    }

    // 获取所有类型数量
    $.get("findPreSaleOrderCount", {
        adminDeleteStatusCd: 1,
        orderDistrbuteTypeCd: $("input[name=orderDistrbuteTypeCd]").val()
    }, function (data) {
        for (var i = 0; i <= 6; i++) {
            $(".type" + i).html(data['type' + i]);
        }
    });

    /**
     * 删除订单
     */
    function delOrder(orderId) {
        BUI.Message.Confirm("确认删除订单", function () {
            $.post("delOrder", {orderId: orderId}, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("删除成功");
                    search.load();
                }
            })
        });
    }

    /**
     * 导出
     */
    function exportPreSale() {
        window.location.href = "${ctx}/admin/sa/orderManage/exportPreSaleOrder?type=" + $("input[name=type]").val();
    }

</script>
</body>
</html>