<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <title>奖励</title>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" class="control-text" placeholder="手机号" id="short_cut_like_orderNumber_">
                <button onclick="search()"><i class="icon-search"></i></button>
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input name="orderBy" value="createTime desc" type="hidden"/>
                    <input type="hidden" id="status" name="eq_status" value="0"/>
                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">手机号：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input type="text" class="control-text" name="like_phone">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">奖项：</label>
                            <div class="controls">
                                <input type="text" class="control-text" name="like_awardsItemName">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">活动名称：</label>
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <select name="eq_awardsId">
                                    <option value="">所有</option>
                                <#if awardsList?has_content>
                                    <#list awardsList as awards>
                                        <option value="${awards.id!}">${awards.title!}</option>
                                    </#list>
                                </#if>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span10">
                            <label class="control-label">中奖时间：</label>
                            <div class="controls">
                                <input type="text" class="calendar control-text" name="ge_createTime" value="">
                                <span>至</span>
                                <input type="text" class="calendar control-text" name="le_createTime" value="">
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
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '未处理', value: '0'},
            {text: '已处理', value: '1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    tab.on('selectedchange', function (ev) {
        var item = ev.item;
        if (item.get('value') == "0") {
            $("#status").val('0');
        } else if (item.get('value') == "1") {
            $("#status").val('1');
            ;
        }
    });

    BUI.Picker.Picker.ATTRS.align.value.points = ['tr', 'tr'];
    BUI.Picker.Picker.ATTRS.align.value.offset = [0, 30];

    BUI.use(['common/search', 'common/page'], function (Search) {
        var editing = new BUI.Grid.Plugins.CellEditing({
            triggerSelected: false //触发编辑的时候不选中行
        });
        var columns = [
            {title: '编号', dataIndex: 'id', width: 60},
            {
                title: '中奖人手机号', dataIndex: 'phone', width: 120, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '中奖人姓名', dataIndex: 'userName', width: 80, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {title: '收货人', dataIndex: 'receiverName', width: 80},
            {title: '联系方式', dataIndex: 'mobile', width: 120},
            {title: '收货地址', dataIndex: 'addrCombo', width: 160},
            {title: '中奖时间', dataIndex: 'createTime', width: 150, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '游戏类型', dataIndex: 'awardTypeName', width: 80},
            {
                title: '奖品', dataIndex: 'awardsItemName', width: 250, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '状态', dataIndex: 'status', width: 100, renderer: function (value, rowObj) {
                if (value) {
                    return "已处理";
                } else {
                    return "未处理"
                }
            }
            },
            {
                title: '操作', dataIndex: '', width: 100, renderer: function (value, rowObj) {
                var editCallback = "javascript:editFunction(" + rowObj.id + ")";
                var editStr = '<a href="' + editCallback + '">编辑</a>';
                return editStr;
            }
            }
        ];
        var store = Search.createStore('grid_json', {pageSize: 20});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small', handler: generateExcel},
                    {text: '批量处理', btnCls: 'button button-small', handler: updateStatus}
                ]
            },
            plugins: [BUI.Grid.Plugins.CheckSelection, BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight(),
            multiSelect: false

        });

        var search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        var grid = search.get('grid');
        tab.on('selectedchange', function (ev) {
            var item = ev.item;
            $("#status").val(item.get('value'));
            search.load();
        });

    <#--批量处理-->
        function updateStatus() {
            var selectedAwardIds = getSelectAwardsArray();
            if (!selectedAwardIds || !selectedAwardIds.length) {
                return BUI.Message.Alert("请选择奖品!");
                return false;
            }
            selectedAwardIds = selectedAwardIds.join(",");
            BUI.Message.Confirm('确定要批量处理这些奖品吗?', function () {
                $.get("${ctx}/admin/sa/promotion/awardsResult/updateStatus", {selectedAwardIds: selectedAwardIds}, function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        BUI.Message.Alert("操作成功！");
                        search.load();
                    }
                });
            }, 'question');
        };
    <#--获取选中的数据-->
        function getSelectAwardsArray() {
            var selectedAward = grid.getSelection();
            if (!selectedAward.length) return null;
            var selectedAwards = [];
            for (var i = 0; i < selectedAward.length; i++) {
                selectedAwards.push(selectedAward[i].id);
            }
            return selectedAwards;
        }
    <#--导出处理-->

        function generateExcel() {
            var selectedAwardIds = getSelectAwardsArray();
            /*if (!selectedAwardIds || !selectedAwardIds.length) {
                return BUI.Message.Alert("请选择要导出的记录!");
                return false;
            }*/
            var url = "${ctx}/admin/sa/promotion/awardsResult/export?eq_status=" + $("#status").val();

            if (selectedAwardIds && selectedAwardIds.length > 0) {
                url += '&ids=' + selectedAwardIds.join(",");
            }
            location.href = url;
            BUI.Message.Alert("导出成功");
        }
    });

    function editFunction(rowObjId) {
        location.href = 'edit?awardResultId=' + rowObjId;
    }

    function search() {
        $('input[name="like_phone"]').val($('#short_cut_like_orderNumber_').val());
        $('#btnSearch').click();
    }

    $(function () {
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

        $("#short_cut_like_orderNumber_").on('keyup', function () {
            $('input[name="like_phone"]').val($('#short_cut_like_orderNumber_').val());
            if (event.keyCode == 13) {
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#short_cut_like_orderNumber_").on('click', function () {
            $('input[name="like_phone"]').val($('#short_cut_like_orderNumber_').val());
        });

        $('input[name="like_phone"]').on('keyup', function () {
            $("#short_cut_like_orderNumber_").val($('input[name="like_phone"]').val());
        });

        $('input[name="like_phone"]').on('click', function () {
            $("#short_cut_like_orderNumber_").val($('input[name="like_phone"]').val());
        });
    })

</script>

</body>
</html>