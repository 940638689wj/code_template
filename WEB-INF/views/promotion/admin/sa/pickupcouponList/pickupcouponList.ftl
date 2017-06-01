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
        <div class="content-body">
            <div class="title-bar-side">
                <div class="search-bar">
                    <input type="text" placeholder="提货券名称" class="control-text" id="short_pickupCouponName"/>
                    <button onclick="searchResult()"><i class="icon-search"></i></button>
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal search-form">
                        <input name="statusCd" id="statusCd" value="${statusCd!}" type="hidden"/>
                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">提货券名称：</label>
                                <div class="controls">
                                    <input type="text" id="pickupCouponName" name="pickupCouponName"
                                           class="input-normal control-text">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span12">
                                <label class="control-label">有效使用起始日期：</label>
                                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                    <input name="allowUseStartForStart" id="allowUseStartForStart"
                                           class="control-text input-small calendar" type="text"><label>
                                    &nbsp;至&nbsp;</label>
                                    <input name="allowUseStartForEnd" id="allowUseStartForEnd"
                                           class="control-text input-small calendar" type="text">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span12">
                                <label class="control-label">有效使用结束日期：</label>
                                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                    <input name="allowUseEndForStart" class="control-text input-small calendar"
                                           type="text"><label>&nbsp;至&nbsp;</label>
                                    <input name="allowUseEndForEnd" class="control-text input-small calendar"
                                           type="text">
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
            {text: '可用提货券', value: '1'},
            {text: '过期提货券', value: '-1'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '编号', dataIndex: 'pickupCouponId', width: 100},
            {
                title: '提货券名称', dataIndex: 'pickupCouponName', width: 150, renderer: function (value, rowObj) {
                return '<a href="${ctx}/admin/sa/pickupcouponCode?pickupCouponId=' + rowObj.pickupCouponId + '&statusCd=' + $('#statusCd').val() + '">' + value + '</a>';
            }
            },
            {title: '描述', dataIndex: 'pickupCouponDesc', width: 200},
            {title: '提货门店', dataIndex: 'storeName', width: 150},
            {title: '卡号段', dataIndex: 'cardPrefix', width: 100},
            {
                title: '有效使用时间', dataIndex: '', width: 200, renderer: function (value, rowObj) {
                var cardNum = "";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseStartTime);
                cardNum += " 至 ";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseEndTime);
                return cardNum;
            }
            },
            {title: '发放数量', dataIndex: 'pickupCnt', width: 80},
            {title: '金额', dataIndex: 'pickupAmt', width: 100},
            {title: '审核状态', dataIndex: 'auditStatusName', width: 80},
            {title: '状态', dataIndex: 'statusName', width: 80},
            {
                title: '操作', dataIndex: '', width: 150, renderer: function (value, rowObj) {
                var editStr = "";
                //未审核的提购券能编辑和删除  statuscd:1启用0禁用
                if ($('#statusCd').val() == 1) {
                    if (rowObj.auditStatusCd != 1) { //未审核、s审核不通过
                        //启用禁用按钮
                        if (rowObj.statusCd == 0) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",1)\'>启用</a>';
                        } else if (rowObj.statusCd == 1) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",0)\'>禁用</a>';
                        }
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:delPickup(\"' + rowObj.pickupCouponId + '\")\'>删除</a>';
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:editPickup(\"' + rowObj.pickupCouponId + '\")\'>编辑</a>';

                    } else if (rowObj.auditStatusCd == 1) {
                        //启用禁用按钮
                        if (rowObj.statusCd == 0) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",1)\'>启用</a>';
                        } else if (rowObj.statusCd == 1) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",0)\'>禁用</a>';
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:sendAllMsg(\"' + rowObj.pickupCouponId + '\")\'>发送</a>';
                        };
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:editPickup(\"' + rowObj.pickupCouponId + '\")\'>编辑</a>';
                    }
                }else{
                    if (rowObj.auditStatusCd != 1) { //未审核、s审核不通过
                        //启用禁用按钮
                        if (rowObj.statusCd == 0) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",1)\'>启用</a>';
                        } else if (rowObj.statusCd == 1) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",0)\'>禁用</a>';
                        }
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:delPickup(\"' + rowObj.pickupCouponId + '\")\'>删除</a>';
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:editPickup(\"' + rowObj.pickupCouponId + '\")\'>编辑</a>';
                        //启用禁用按钮
                    }else if (rowObj.auditStatusCd == 1) {
                        //启用禁用按钮
                        if (rowObj.statusCd == 0) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",1)\'>启用</a>';
                        } else if (rowObj.statusCd == 1) {
                            editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.pickupCouponId + '\",0)\'>禁用</a>';
                        }
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:sendAllMsg(\"' + rowObj.pickupCouponId + '\")\'>发送</a>';
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:editPickup(\"' + rowObj.pickupCouponId + '\")\'>编辑</a>';
                    }
                }
                return editStr;
            }
            }
        ];
        var store = Search.createStore('/admin/sa/pickupcouponList/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns
            , tbar: {
                items: [
//                    {text: '批量删除', btnCls: 'button button-small button-primary', handler: batchDeleteFunction},
                    {text: '新增提货券', btnCls: 'button button-small button-primary', handler: addFunction}
//                    {text: '导出', btnCls: 'button button-small button-primary', handler: exportFunction}
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get("grid");

        grid.render();

        //进入页面设置标签
        var statusCd = '${statusCd!}';
        if (statusCd == '1') {
            tab.setSelected(tab.getItemAt(0));
        } else if (statusCd == '-1') {
            tab.setSelected(tab.getItemAt(1));
        }

        //切换标签
        tab.on('selectedchange', function (ev) {
            $('#statusCd').val(ev.item.get("value"));
            search.load();
        });

    });

    function addFunction() {
        window.location.href = '${ctx}/admin/sa/pickupcouponList/toSave?statusCd=1';
    }
    
    function editPickup(pickupCouponId) {
        window.location.href = '${ctx}/admin/sa/pickupcouponList/toSave?statusCd=1&pickupCouponId='+pickupCouponId;
    }

    /**
     * 删除提货券
     */
    function delPickup(pickupCouponId) {
        BUI.Message.Confirm('确认删除？', function () {
            $.post('${ctx}/admin/sa/pickupcouponList/delete', {
                pickupCouponId: pickupCouponId
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess('删除成功');
                    search.load();
                }
            }, 'json');
        });
    }

    function exportFunction() {

    }

    /**
     * 更改启用状态
     *
     * @param pickupCouponId    提货券id
     * @param statusCd  更改后状态
     */
    function changeStatus(pickupCouponId, statusCd) {
        $.ajax({
            type: "POST",
            url: "${ctx}/admin/sa/pickupcouponList/changeStatus",
            data: {
                pickupCouponId: pickupCouponId,
                statusCd: statusCd
            },
            dataType: "json",
            success: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    if (statusCd == 1) {
                        app.showSuccess("启用成功");
                    } else if (statusCd == 2) {
                        app.showSuccess("禁用成功");
                    }
                    search.load();
                }
            }
        });
    }

    /**
     * 发送短信
     */
    function sendAllMsg(pickupCouponId) {
        BUI.Message.Confirm('确认发送？', function () {
            $.post('${ctx}/admin/sa/pickupcouponList/sendAllMsg', {
                "pickupCouponId": pickupCouponId
            }, function (data) {
                console.log(data);
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess('发送成功');
                    search.load();
                }
            }, 'json');
        });
    }

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

    //搜索框内容同提货券名字,同步显示
    $("#short_pickupCouponName").on('keyup', function (event) {
        $("#pickupCouponName").val($("#short_pickupCouponName").val());
    });

    //提货券名字同搜索框内容,同步显示
    $("#pickupCouponName").on('keyup', function (event) {
        $("#short_pickupCouponName").val($("#pickupCouponName").val());
    });

    //键盘触发搜索
    $("#short_pickupCouponName").on('keyup', function (event) {
        if (event.keyCode == 13) {
            $('#btnSearch').click();
        }
    });

    //鼠标点击搜索小图标,触发搜索
    function searchResult() {
        $("#btnSearch").click();
    }

</script>
</body>
</html>