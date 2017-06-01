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
        <div id="tab">
        </div>
    </div>

    <div class="content-top">
        <div id="tab1"></div>
    </div>

    <form id="searchForm" class="form-horizontal search-form">
        <div class="row">
            <input type="text" class="control-text" name="promotionName" placeholder="红包名称">
        <#--
        <span class="bui-form-group" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                <input type="text" class="calendar control-text" name="ge_startDate" placeholder="日期">
                <span>至</span>
                <input type="text" class="calendar control-text" name="le_endDate" placeholder="日期">
        </span>
        <select name="statusCd" id="statusCd" class="input-normal">
            <option value="">所有状态</option>
            <option value="1">启用</option>
            <option value="0">禁用</option>
        </select>
        -->
            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
            <button onclick="addFunction()" class="button button-primary">新增红包</button>
        </div>
    </form>
    <div id="grid"></div>
</div>
</body>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '红包列表', value: '0'},
            {text: '红包使用明细', value: '1'}
        ]
    });
    tab.setSelected(tab.getItemAt(${status?default(0)}));
    tab.on('selectedchange', function (ev) {
        var item = ev.item;
        if (item.get('value') == "0") {
            window.location.href = "/admin/sa/promotion/redPacket/list";
        } else if (item.get('value') == "1") {
            window.location.href = "/admin/sa/promotion/redPacket/useDetailList";
        }
    });

    var storeData;
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '编号', dataIndex: 'promotionId', width: 80},
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
            {title: '数量', dataIndex: 'couponTotalNum', width: 80},
            {
                title: '类型', dataIndex: 'generateRedPacketCnt', width: 80, renderer: function (val, rowObj) {
                if (val != null && val != 0) {
                    return "群红包";
                } else {
                    return "普通红包";
                }
            }
            },
            {title: '被领取数', dataIndex: 'doleCount', width: 70},
            {title: '已使用数', dataIndex: 'useCount', width: 70},
            {title: '起始时间', dataIndex: 'enableStartTime', width: 140, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '结束时间', dataIndex: 'enableEndTime', width: 140, renderer: BUI.Grid.Format.datetimeRenderer},
            {
                title: '手机端领取地址', dataIndex: '', width: 355, renderer: function (val, rowObj) {
                return "<a href=\"javascript:window.open(\'/m/redPacket/" + rowObj.encryptCode + "')\">/m/redPacket/" + rowObj.encryptCode + ".html</a>";
            }
            },
            {
                title: 'PC端领取地址', dataIndex: '', width: 355, renderer: function (val, rowObj) {
                return "<a href=\"javascript:window.open(\'/redPacket/" + rowObj.encryptCode + "')\">/redPacket/" + rowObj.encryptCode + ".html</a>";
            }
            },
            {
                title: '状态', dataIndex: 'statusCd', width: 50, renderer: function (val, rowObj) {
                if (val != null && val == 0) {
                    return "禁用";
                } else {
                    return "启用";
                }
            }
            },
            {
                title: '操作', dataIndex: '', width: 210, renderer: function (value, rowObj) {
                var str = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/promotion/redPacket/edit?promotionId=' + rowObj.promotionId + '&type=${type!}'
                });
                str += '<a href="javascript:viewOfferCode(' + rowObj.promotionId + ');">关联红包券</a>&nbsp;';
                /*
                 if(rowObj.statusCd != null && rowObj.statusCd == 0){
                	viewCodeStr += "<a href=\"javascript:changeStatus(\'" + rowObj.promotionId + "','"+rowObj.statusCd +"')\">启用</a>";
                } else {
                    viewCodeStr += "<a href=\"javascript:changeStatus(\'" + rowObj.promotionId + "','"+rowObj.statusCd +"')\">禁用</a>";
                }
                */
                str += '<a href="javascript:exportExcel(' + rowObj.promotionId + ');">导出红包券</a>&nbsp;';
<@securityAuthorize ifAnyGranted="delete">
                str += '&nbsp;<a href="javascript:del(' + rowObj.promotionId + ');">删除</a>';
</@securityAuthorize>
                return str;
            }
            }
        ];
        storeData = Search.createStore('/admin/sa/promotion/redPacket/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            width: '100%',
            height: getContentHeight(),
        });

        var search = new Search({
            store: storeData,
            gridCfg: gridCfg
        });
        var grid = search.get('grid');
    });
    function addFunction() {
        app.page.open({
            href: '${ctx}/admin/sa/promotion/redPacket/edit'
        });
    }

    function changeStatus(id) {
        BUI.Message.Confirm('确认要更改么？', function () {
            $.ajax({
                url: "${ctx}/admin/sa/promotion/redPacket/changeStatus",
                type: "post",
                dataType: "json",
                data: {"promotionId": id},
            });
            location.reload();
        }, 'question');
    }

    <#--删除操作-->
    function del(id) {
        BUI.Message.Confirm('确认删除这条活动？', function () {
            $.post('${ctx}/admin/sa/promotion/del', {'promotionId': id}, function (data) {
                if (data && data.result) {
                    app.showSuccess('删除成功！');
                    storeData.load();
                }
            }, 'json');
        }, 'question');
    }

    <#--导出操作-->
    function exportExcel(id) {
        window.open("${ctx}/admin/sa/promotion/redPacket/exportExcel?promotionId=" + id + "&promotionTypeCd=56");
    }
</script>

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
                    if (val != null && val == 1) {
                        return "未使用";
                    } else {
                        return "已使用";
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
                url: '${ctx}/admin/sa/promotion/redPacket/redPacketCode/grid_json',
                autoLoad: false, //自动加载数据
                pageSize: 5
            }),
            grid = new Grid.Grid({
                columns: columns,
                store: store,
                loadMask: true, //加载数据时显示屏蔽层
                emptyDataTpl: '<div class="centered"><h2>红包尚未创建!</h2></div>',
                // 底部工具栏
                bbar: {
                    // pagingBar:表明包含分页栏
                    pagingBar: true
                }
            });

    var dialog = new Overlay.Dialog({
        title: '红包列表',
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
            "promotionId": promotionId,
            "promotionTypeCd": 56
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


</html>