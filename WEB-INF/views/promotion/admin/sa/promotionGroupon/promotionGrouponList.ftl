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
                    <input type="text" placeholder="团购名称" class="control-text" id="short_promotionName"/>
                    <button onclick="searchResult()"><i class="icon-search"></i></button>
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal search-form">
                        <input name="statusCd" id="statusCd" value="${statusCd!}" type="hidden"/>
                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">团购名称：</label>
                                <div class="controls">
                                    <input type="text" id="promotionName" name="promotionName"
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
            {text: '可用团购', value: '1'},
            {text: '过期团购', value: '-1'},
            {text: '禁用团购', value: '0'}
        ]
    });

    var height = getContentHeight();

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '编号', dataIndex: 'promotionId', width: 100},
            {title: '团购名称', dataIndex: 'promotionName', width: 100},
            {title: '虚拟销售量', dataIndex: 'grouponInitSaleNum', width: 100},
            {title: '团购最大量', dataIndex: 'grouponMaxSaleNum', width: 80},
            {title: '每人限购量', dataIndex: 'grouponPersonQuotaNum', width: 80},
            {title: '开始日期', dataIndex: 'enableStartTime', width: 150, renderer: BUI.Grid.Format.dateRenderer},
            {title: '结束日期', dataIndex: 'enableEndTime', width: 150, renderer: BUI.Grid.Format.dateRenderer},
            {title: '状态', dataIndex: 'statusName', width: 80},
            {
                title: '访问地址', dataIndex: '', width: 150, renderer: function (value, rowObj) {
                return '/groupon/' + rowObj.promotionId;
            }
            },
            {title: '审核状态', dataIndex: 'auditStatusName', width: 100},
            {
                title: '操作', dataIndex: '', width: 150, renderer: function (value, rowObj) {
                var editStr = "";
                //可用和禁用团购允许编辑
                if ($('#statusCd').val() == 1 || $('#statusCd').val() == 0) {
                    editStr += '&nbsp;&nbsp;<a href=\'javascript:editGroup(\"' + rowObj.promotionId + '\")\'>编辑</a>';
                    if (rowObj.statusCd == 0) {
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.promotionId + '\",1)\'>启用</a>';
                    } else if (rowObj.statusCd == 1) {
                        editStr += '&nbsp;&nbsp;<a href=\'javascript:changeStatus(\"' + rowObj.promotionId + '\",0)\'>禁用</a>';
                    }
                }else if($('#statusCd').val() == -1){
                	editStr += '&nbsp;&nbsp;<a href=\'javascript:editGroup(\"' + rowObj.promotionId + '\")\'>查看</a>';
                }
                return editStr;
            }
            }
        ];
        var store = Search.createStore('promotionGroupon/grid_json');
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns
            , tbar: {
                items: [
                    {text: '添加', btnCls: 'button button-small button-primary', handler: addFunction}
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
            $('#statusCd').val(ev.item.get("value"));
            search.load();
        });

        var statusCd = '${statusCd!}';
        if (statusCd == '1') {
            tab.setSelected(tab.getItemAt(0));
        } else if (statusCd == '-1') {
            tab.setSelected(tab.getItemAt(1));
        } else if (statusCd == '0') {
            tab.setSelected(tab.getItemAt(2));
        }

    });

    function addFunction() {
        window.location.href = "${ctx}/admin/sa/promotionGroupon/toSave";
    }

    function editGroup(id) {
        window.location.href = "${ctx}/admin/sa/promotionGroupon/toSave?promotionId=" + id + "&statusCd=" + $('#statusCd').val();
    }

    function changeStatus(promotionId, statusCd) {
        $.ajax({
            type: "POST",
            url: "${ctx}/admin/sa/promotionGroupon/updateStatus",
            data: {
                promotionId : promotionId,
                statusCd : statusCd
            },
            dataType: "json",
            success: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    if(statusCd==1) {
                        app.showSuccess("启用成功");
                    } else if(statusCd==0) {
                        app.showSuccess("禁用成功");
                    }
                    search.load();
                }
            }
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

    //搜索框内容同团购名字,同步显示
    $("#short_promotionName").on('keyup', function (event) {
        $("#promotionName").val($("#short_promotionName").val());
    });

    //团购名字同搜索框内容,同步显示
    $("#promotionName").on('keyup', function (event) {
        $("#short_promotionName").val($("#promotionName").val());
    });

    //键盘触发搜索
    $("#short_promotionName").on('keyup', function (event) {
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