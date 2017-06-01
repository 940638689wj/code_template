<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script>
        var Overlay = top.BUI.Overlay,
                Grid = BUI.Grid,
                Data = BUI.Data;
        var Store = Data.Store,
                columns = [
                    {title: '编号', dataIndex: 'couponCodeId', width: 85},
                    {title: '优惠码', dataIndex: 'couponCode', width: 125},
                    {
                        title: '状态', dataIndex: 'couponStatusCd', width: 60, renderer: function (val, rowObj) {
                        if (val != null && val == 0) {
                            return "禁用";
                        } else {
                            return "启用";
                        }
                    }
                    },
                    {title: '获取时间', dataIndex: 'takeTime', width: 135, renderer: BUI.Grid.Format.datetimeRenderer},
                    {title: '使用时间', dataIndex: 'usedTime', width: 135, renderer: BUI.Grid.Format.datetimeRenderer},
                    {title: '所属人', dataIndex: 'phone', width: 185},
                    {title: '使用订单', dataIndex: 'orderNumber', width: 168},
                    {title: '创建时间', dataIndex: 'createTime', width: 135, renderer: BUI.Grid.Format.datetimeRenderer}

                ];
        var store = new Store({
                    url: '${ctx}/admin/sa/promotion/coupons/couponCode/grid_json',
                    autoLoad: false, //自动加载数据
                    pageSize: 5
                }),
                grid = new Grid.Grid({
                    columns: columns,
                    store: store,
                    loadMask: true, //加载数据时显示屏蔽层
                    emptyDataTpl: '<div class="centered"><h2>优惠券尚未创建!</h2></div>',
                    // 底部工具栏
                    bbar: {
                        // pagingBar:表明包含分页栏
                        pagingBar: true
                    }
                });

        var dialog = new Overlay.Dialog({
            title: '优惠劵明细',
            width: 1100,
            height: 300,
            children: [grid],
            childContainer: '.bui-stdmod-body',
            success: function () {
                this.close();
            }
        });

        function viewOfferCode(promotionId) {
            var params = { //配置初始请求的参数
                start: 0,
                sort: 'id desc',
                "promotionId": promotionId
            };
            store.load(params);
            dialog.show();
        }


        function disableAndStartCode(promotionId, statusCd) {
            BUI.Message.Confirm('确认要更改么？', function () {
                window.location.href = "/admin/sa/promotion/coupons/updateCouponStatus?promotionId=" + promotionId + "&statusCd=" + statusCd;
            }, 'question');
        }
    </script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" onclick="couponList();" aria-disabled="false"
                    aria-pressed="false">
                    <span class="bui-tab-item-text">优惠券列表</span>
                </li>
                <li class="bui-tab-item" aria-disabled="false" onclick="couponUsedDetailList();" aria-pressed="false">
                    <span class="bui-tab-item-text">优惠券使用明细</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" placeholder="优惠券名称" class="control-text" id="short_promotionName"/>
                <button onclick="searchResult()"><i class="icon-search"></i></button>
            </div>

            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input name="statusCd" value="1" type="hidden"/>
                    <input name="isEnableTime" value="1" type="hidden"/>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">优惠券编号：</label>
                            <div class="controls">
                                <input type="text" id="promotionId" name="promotionId"
                                       class="input-normal control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">优惠券名称：</label>
                            <div class="controls">
                                <input type="text" id="promotionName" name="promotionName"
                                       class="input-normal control-text">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span12">
                            <label class="control-label">起始时间：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input name="ge_startDate" class="control-text input-small calendar" type="text"><label>
                                &nbsp;-&nbsp;</label>
                                <input name="le_startDate" class="control-text input-small calendar" type="text">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span12">
                            <label class="control-label">结束时间：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input name="ge_endDate" class="control-text input-small calendar" type="text"><label>
                                &nbsp;-&nbsp;</label>
                                <input name="le_endDate" class="control-text input-small calendar" type="text">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var search = null;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'link-tabs',
        autoRender: true,
        children: [
            {text: '有效', value: '1', href: 'javascript:void(0)'},
            {text: '过期', value: '2', href: 'javascript:void(0)'},
            {text: '禁用', value: '3', href: 'javascript:void(0)'}
        ],
        itemTpl: '<a href="{href}">{text}</a>'
    });
    //默认选择lab的第一个选项
    tab.setSelected(tab.getItemAt(0));
    //点击lab中对应项的操作
    tab.on('selectedchange', function (ev) {
        var item = ev.item;
        if (item.get('value') == "1") {
            $("input[name='statusCd']").val('1');
            $("input[name='isEnableTime']").val('1');
        } else if (item.get('value') == "2") {
            $("input[name='statusCd']").val('1');
            $("input[name='isEnableTime']").val('2');
        } else if (item.get('value') == "3") {
            $("input[name='statusCd']").val('0');
            $("input[name='isEnableTime']").val('');
        }
        //重新加载数据
        search.load({pageIndex: 1});
    });

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: '操作', dataIndex: '', width: 140, renderer: function (value, rowObj) {
                var editStr = "";
                editStr = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/promotion/coupons/editCoupon?promotionId=' + rowObj.promotionId
                });
                var viewCodeStr = "<a href=\"javascript:viewOfferCode(\'" + rowObj.promotionId + "')\">优惠券明细</a>&nbsp;&nbsp;&nbsp;";
//                if(rowObj.statusCd != null && rowObj.statusCd == 0){
//                	viewCodeStr += "<a href=\"javascript:disableAndStartCode(\'" + rowObj.promotionId + "','"+rowObj.statusCd +"')\">启用</a>";
//                } else {
//                    viewCodeStr += "<a href=\"javascript:disableAndStartCode(\'" + rowObj.promotionId + "','"+rowObj.statusCd +"')\">禁用</a>";
//                }

                return editStr + "&nbsp;&nbsp;&nbsp;" + viewCodeStr;
            }
            },
            {title: '编号', dataIndex: 'promotionId', width: 45},
            {
                title: '名称', dataIndex: 'promotionName', width: 150, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '描述', dataIndex: 'promotionDesc', width: 200, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '推送条件', dataIndex: 'pushTypeCd', width: 150, renderer: function (value, rowObj) {
                var condition = "";
                var money = "";
                money = rowObj.couponPushOrderAmtLimit == null ? 0 : rowObj.couponPushOrderAmtLimit;
                if (value == 1) {
                    condition = "无条件";
                } else if (value == 2) {
                    condition = " 每笔订单完成" + money + "元";
                } else if (value == 3) {
                    condition = "订单支付完成分享用券";
                } else if (value == 4) {
                    condition = "首次注册送券";
                }
                return condition;
            }
            },
            {title: '数量', dataIndex: 'couponTotalNum', width: 60},
            {title: '领取数量', dataIndex: 'doleCount', width: 60},
            {title: '已使用数量', dataIndex: 'useCount', width: 70},
            {
                title: '状态', dataIndex: 'statusCd', width: 50, renderer: function (val, rowObj) {
                if (val != null && val == 0) {
                    return "禁用";
                } else {
                    return "启用";
                }
            }
            },
            {title: '审核状态', dataIndex: 'auditStatus', width: 70},
            {
                title: '手机端领取地址', dataIndex: '', width: 330, renderer: function (value, rowObj) {
                if (rowObj.isPreGenerate) {
                    return "";
                } else {
                    return "<a href=\"javascript:window.open(\'" + app.grid.format.encodeHTML("/m/coupon/" + rowObj.encryptCode + ".html") + "')\">" + app.grid.format.encodeHTML("/m/coupon/" + rowObj.encryptCode + ".html") + "</a>";
                }
            }
            },
            {
                title: 'PC端领取地址', dataIndex: '', width: 330, renderer: function (value, rowObj) {
                if (rowObj.isPreGenerate) {
                    return "";
                } else {
                    return "<a href=\"javascript:window.open(\'" + app.grid.format.encodeHTML("/coupon/" + rowObj.encryptCode + ".html") + "')\">" + app.grid.format.encodeHTML("/coupon/" + rowObj.encryptCode + ".html") + "</a>";
                }
            }
            },
            {title: '使用起始时间', dataIndex: 'enableStartTime', width: 135, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '使用结束时间', dataIndex: 'enableEndTime', width: 135, renderer: BUI.Grid.Format.datetimeRenderer}

        ];
        var store = Search.createStore('/admin/sa/promotion/coupons/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '新增优惠券', btnCls: 'button button-small button-primary', handler: addFunction}
                ]
            },
            plugins: [BUI.Grid.Plugins.ColumnResize],
            width: '100%',
            height: getContentHeight(),
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        var grid = search.get('grid');
    });

    $(function () {
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

        $("#short_promotionName").on('keyup', function (event) {
            $("#promotionName").val($("#short_promotionName").val());
            if (event.keyCode == 13) {
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#short_promotionName").on('click', function () {
            $("#promotionName").val($("#short_promotionName").val());
        });
        $("#promotionName").on('keyup', function (event) {
            $("#short_promotionName").val($("#promotionName").val());
            if (event.keyCode == 13) {
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#promotionName").on('click', function () {
            $("#short_promotionName").val($("#promotionName").val());
        });
    })

    function addFunction() {
        app.page.open({
            href: '${ctx}/admin/sa/promotion/coupons/editCoupon'
        });
    }

    function setOriginPlatformCd(ev, value) {
        $("#all").removeClass("button-primary");
        $("#mobile").removeClass("button-primary");
        $("#PC").removeClass("button-primary");
        $(ev).addClass("button-primary");
    }

    function couponList() {
        window.location.href = "${ctx}/admin/sa/promotion/coupons/list";
    }
    function couponUsedDetailList() {
        window.location.href = "${ctx}/admin/sa/promotion/coupons/useDetailList";
    }
</script>

</body>
</html>