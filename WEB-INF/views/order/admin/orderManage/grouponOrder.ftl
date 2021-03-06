<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <meta charset="utf-8"/>
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
                <div class="recyclebin"><a
                        href="${ctx}/admin/sa/orderManage/toGrouponOrderRecycle?orderTypeCd=${orderTypeCd!}">订单回收站</a></div>
                <div class="search-bar">
                    <input type="text" placeholder="订单号" class="control-text" oninput="syncOrderNumber(this)"/>
                    <button type="button" onclick="searchLoad()"><i class="icon-search"></i></button>
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal search-form">
                        <input name="orderTypeCd" value="${orderTypeCd!}" type="hidden"/>
                        <input name="type" value="${type!0}" type="hidden"/>
                        <input name="adminDeleteStatusCd" value="1" type="hidden"/>
                        <input name="orderNumber" value="" type="hidden"/>

                        <div class="row">
                            <div class="control-group span12" style="  margin-bottom: 10px;">
                                <label class="control-label">下单时间：</label>
                                <div class="controls bui-form-group " data-rules="{dateRange : true}">
                                    <input name="createStart" id="createStart" data-tip="{text : '起始日期'}"
                                           class="input-small calendar control-text" type="text"><label>
                                    &nbsp;-&nbsp;</label>
                                    <input name="createEnd" id="createEnd" class="input-small calendar control-text"
                                           type="text">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">会员：</label>
                                <div class="controls">
                                    <input type="text" name="userName" class="control-text" id="userName">
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
            {text: '未付款(<span class="type1"></span>)', value: '1'},
            {text: '已付款(<span class="type2"></span>)', value: '2'},
            {text: '待评价(<span class="type4"></span>)', value: '4'},
            {text: '已完成(<span class="type5"></span>)', value: '5'},
            {text: '已关闭(<span class="type6"></span>)', value: '6'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
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
                title: '订单号', dataIndex: 'orderNumber', width: "150px", renderer: function (val, obj) {
                return "<a href='${ctx}/admin/sa/orderManage/toGrouponOrderDetail?orderId=" + obj.orderId + "' target='_blank'>" + val + "</a>";
            }
            },
            {
                title: '会员', dataIndex: 'nickName', width: "100px", renderer: function (val, obj) {
                return val ? val : obj.loginName;
            }
            },
            {title: '手机号', dataIndex: 'phone', width: "100px"},
            {title: '团购名称', dataIndex: 'promotionName', width: "150px"},
            {title: '团购价', dataIndex: 'grouponPrice', width: "150px"},
            {
                title: '实付金额', dataIndex: '', width: "80px", renderer: function (val, obj) {
                return (obj.orderTotalAmt - obj.orderDiscountAmt).toFixed(2);
            }
            },
            {title: '订单状态', dataIndex: 'orderStatusName', width: "80px"},
            {title: '下单时间', dataIndex: 'createTime', width: "160px", renderer: BUI.Grid.Format.datetimeRenderer}
        ];
        var store = Search.createStore('findAllOrderPage', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns,
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small button-primary', handler: exportAllOrder},
//                    {text: '打印订单', btnCls: 'button button-small button-primary', handler: printAllOrder}
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get("grid");

        grid.render();

        //切换标签
        tab.on('selectedchange', function (ev) {
            $("input[name=type]").val(ev.item.get("value"));
            search.load();
        });
        tab.setSelected(tab.getItemAt(${type!0}));

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
    $.get("findAllOrderCount", {
        orderTypeCd: $("input[name=orderTypeCd]").val(),
        adminDeleteStatusCd: 1
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
    function exportAllOrder() {
        window.location.href = "${ctx}/admin/sa/orderManage/exportAllOrder?adminDeleteStatusCd=1&orderTypeCd=" + $("input[name=orderTypeCd]").val() + "&type=" + $("input[name=type]").val();
    }

    //    /**
    //     * 打印
    //     */
    //    function printAllOrder() {
    //        console.log(1)
    //    }

</script>
</body>
</html>