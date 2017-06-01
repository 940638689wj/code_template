<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <style>
        .form-horizontal .control-label {
            width: 100px;
        }

        .title-bar-right {
            float: right;
            margin: 10px 260px 0 0;
        }
    </style>
</head>
<body>
<div class="container">

    <div class="content-top">
        <div class="title-bar">
            <div id="tab"></div>
        </div>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="recyclebin"><a href="${ctx}/admin/sa/user/userList">返回激活用户列表</a></div>
            <div class="search-bar">
                <input type="text" placeholder="手机号" class="control-text" id="short_cut_like_phone"/>
                <button type="button" onclick="searchCustomer()"><i class="icon-search"></i></button>
            </div>

            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input type="hidden" name="statusCd" value="${statusCd?default(0)}">

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">用户名：</label>
                            <div class="controls">
                                <input type="text" name="loginName" class="control-text" id="loginName">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">手机号：</label>
                            <div class="controls">
                                <input type="text" name="phone" class="control-text" id="phone">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">会员编号：</label>
                            <div class="controls">
                                <input type="text" class="control-text" name="userId" id="userId">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">姓名：</label>
                            <div class="controls">
                                <input type="text" class="control-text" name="userName" id="userName">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">昵称：</label>
                            <div class="controls">
                                <input type="text" class="control-text" name="nickName" id="nickName">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">来源：</label>
                            <div class="controls">
                                <select name="registerPlatformCd" id="registerPlatformCd">
                                    <option value="">全部</option>
                                    <option value="1">微信</option>
                                    <option value="2">浏览器</option>
                                    <option value="3">白鹭会员</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">会员类型：</label>
                            <div class="controls">
                                <select name="mstoreStatusCd">
                                    <option value="">全部</option>
                                    <option value="1">推广会员</option>
                                    <option value="0">普通会员</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">会员等级：</label>
                            <div class="controls">
                                <select name="userLevelId">
                                    <option value="">全部</option>
                                <#list userLevelList as userLevel>
                                    <option value="${userLevel.userLevelId!}">${userLevel.userLevelName!?html}</option>
                                </#list>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">会员标签：</label>
                            <div class="controls">
                                <select name="userLabelId">
                                    <option value="">全部</option>
                                    <#list userLabelList as userLabel>
                                        <option value="${userLabel.id!}">${userLabel.name!?html}</option>
                                    </#list>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span10" style="  margin-bottom: 10px;">
                            <label class="control-label">注册时间：</label>
                            <div class="controls bui-form-group " data-rules="{dateRange : true}">
                                <input name="startDate" id="startDate" data-tip="{text : '起始日期'}"
                                       class="input-small calendar control-text" type="text"><label>
                                &nbsp;-&nbsp;</label>
                                <input name="endDate" id="endDate" class="input-small calendar control-text"
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

    <div id="userLevelContent" class="well" style="display: none;">
        <input type="hidden" name="userIds" value=""/>
        <label>会员等级：</label>
        <select name="userLevelId" id="userLevelId">
            <option value="-1">请选择会员等级</option>
        <#list userLevelList as userLevel>
            <option value="${userLevel.userLevelId!}">${userLevel.userLevelName!?html}</option>
        </#list>
        </select>
    </div>

    <div id="doPreDeposit" class="well" style="display: none;">
        <form id="preDeposit" class="form-horizontal" method="post">
            <div id="edit-div" class="form-content">
                <input type="hidden" name="doPreCustomerIds" value=""/>

                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>充值金额：</label>
                        <div class="controls">
                            <input id="amount_deposit" name="amount_deposit" class="input-small control-text">
                        </div>
                        <div class="tips tips-small tips-info tips-no-icon pull-left">
                            <div class="tips-content">
                                (单位:元)&nbsp;&nbsp;此处可输入负值,负值表示减账户余额
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>备注：</label>
                        <div class="controls">
                            <input value="" id="remarks_deposit" name="remarks_deposit"
                                   class="input-large control-text">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="doPrePoint" class="well" style="display: none;">
        <form id="preDeposit" class="form-horizontal" method="post">
            <div id="edit-div" class="form-content">
                <input type="hidden" name="doPreCustomerIds" value=""/>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="width:130px;"><s>*</s>调整积分(增/减)：</label>
                        <div class="controls">
                            <input id="amount_point" name="amount_point" class="input-small control-text">
                        </div>
                        <div class="tips tips-small tips-info tips-no-icon pull-left">
                            <div class="tips-content">
                                此处可输入负值,负值表示减少积分
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="width:130px;"><s>*</s>备注：</label>
                        <div class="controls">
                            <input value="" id="remarks_point" name="remarks_point" class="input-large control-text">
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

</div>
<script type="text/javascript">
    var grid = null;
    var search = null;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '冻结会员列表', value: '1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: 'ID', dataIndex: 'userId', width: 40, visible: false, renderer: function (value, rowObj) {
                return "<input type='hidden' name='userId' value='" + value + "'>";
            }
            },
            {
                title: '会员标签', dataIndex: 'userLabels', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return app.grid.format.encodeHTML(value);
                } else {
                    return '';
                }
            }
            },
            {
                title: '会员编号', dataIndex: 'userId', width: 100, renderer: function (value, rowObj) {
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>' + value + '</a>';
                return editStr;
            }
            },
            {
                title: '用户名', dataIndex: 'loginName', width: 100, renderer: function (value, rowObj) {
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>' + app.grid.format.encodeHTML(value) + '</a>';
                return editStr;
            }
            },
            {
                title: '姓名', dataIndex: 'userName', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '昵称', dataIndex: 'nickName', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '手机', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '注册平台', dataIndex: 'registerPlatformText', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '消费总额', dataIndex: 'totalConsumeAmt', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
            }
            },
            {
                title: '账户余额', dataIndex: 'userBalance', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
            }
            },
            {
                title: '积分', dataIndex: 'totalScore', width: 70, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
                ;
            }
            },
            {
                title: '推广状态', dataIndex: 'mstoreStatusCd', width: 70, renderer: function (value, rowObj) {
                if (value == 0) {
                    return "否";
                } else if (value == 1) {
                    return "是";
                }
                return "否";
            }
            },
            {
                title: '会员等级', dataIndex: 'userLevelName', width: 70, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '上级会员', dataIndex: 'parentPhone', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '状态', dataIndex: 'statusText', width: 60, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '注册时间', dataIndex: 'registerTime', width: 140, renderer: function (value, rowObj) {
                if (value != null) {
                    return BUI.Date.format(value, "yyyy-mm-dd HH:MM:ss");
                }
            }
            },
            {
                title: '操作', dataIndex: 'userId', width: 140, renderer: function (value, rowObj) {
                var content = "";
                if (rowObj.statusCd == 0) {
                    content = "<a href='javascript:void(0)' onclick='updateUserStatus1(" + value + ")'>启用</a>";
                }
                content = content + "&nbsp;&nbsp;<a href='javascript:void(0)' onclick='deleteUser(" + value + ")'>删除</a>";

                return content;
            }
            }
        ];
        var store = Search.createStore('/admin/sa/user/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.CheckSelection, BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar: {
                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                items: [
                    {btnCls: 'button button-small', text: '批量删除', handler: deleteUserBatch},
                    {btnCls: 'button button-small', text: '批量激活', handler: updateUserStatusBatch0},
                    {btnCls: 'button button-small', text: '导入', handler: importUser},
                    {btnCls: 'button button-small', text: '导出', handler: exportUser}
                ]
            },
            <!-- plugins : [BUI.Grid.Plugins.CheckSelection],-->
            itemStatusFields: { //设置数据跟状态的对应关系
                selected: 'selected',
                disabled: 'disabled'
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
            //
        });
        grid = search.get('grid');
    });

    function getUser(userId) {
        window.location.href = "${ctx}/admin/sa/user/toUserDetailIndex/" + userId;
    }

	//导入
	function importUser()　{
		window.location.href="${ctx}/admin/sa/userExcel/import?type=0"
	}

    /**
     * 导出
     */
    function exportUser() {
        var userIds = '';
        var selectedContent = grid.getSelection();
        var selectedContentIds = [];
        for (var i = 0; i < selectedContent.length; i++) {
            selectedContentIds.push(selectedContent[i].userId);
        }
        userIds = selectedContentIds.join(",");

        var params = $("#searchForm").serialize();
        location.href = "${ctx}/admin/sa/userExcel/exportUser?" + params + "&userIds=" + userIds;
        BUI.Message.Alert("导出成功");
    }

    /**
     * 启用会员
     *
     * @param selectedCustomerId
     */
    function updateUserStatus1(selectedCustomerId) {
        BUI.Message.Confirm('确认要启用选中账户么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateUserStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerId, statusCd: "1"},
                success: function (data) {
                    if (data.result == "success") { //删除成功
                        app.showSuccess("操作成功。");
                        search.load();
                    } else {
                        app.showSuccess("操作失败!");
                    }
                }
            });
        }, 'question');
    }

    /**
     * 批量启用
     *
     * @returns {boolean}
     */
    function updateUserStatusBatch0() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要启用的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        BUI.Message.Confirm('确认要启用选中的账户么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateUserStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds, statusCd: "1"},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("账户激活成功。");
                        search.load();
                    } else {
                        app.showSuccess("账户激活失败!");
                    }
                }
            });
        }, 'question');
    }

    /**
     * 删除会员
     *
     * @param selectedCustomerId
     */
    function deleteUser(selectedCustomerId) {
        BUI.Message.Confirm('确认要删除选中的账户么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateUserStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerId, statusCd: "2"},
                success: function (data) {
                    if (data.result == "success") { //删除成功
                        app.showSuccess("操作成功。");
                        search.load();
                    } else {
                        app.showSuccess("操作失败!");
                    }
                }
            });
        }, 'question');
    }

    /**
     * 批量删除
     *
     * @returns {boolean}
     */
    function deleteUserBatch() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要删除的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        BUI.Message.Confirm('确认要删除选中的账户么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateUserStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds, statusCd: "2"},
                success: function (data) {
                    if (data.result == "success") { //删除成功
                        app.showSuccess("操作成功。");
                        search.load();
                    } else {
                        app.showSuccess("操作失败!");
                    }
                }
            });
        }, 'question');
    }

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
    });

    $("#short_cut_like_phone").on('keyup', function () {
        $("#phone").val($("#short_cut_like_phone").val());
        if (event.keyCode == 13) {
            $('#btnSearch').click();
        }
    });
    $("#short_cut_like_phone").on('click', function () {
        $("#phone").val($("#short_cut_like_phone").val());
    });

    $("#phone").on('keyup', function () {
        $("#short_cut_like_phone").val($("#phone").val());
    });

    $("#phone").on('click', function () {
        $("#short_cut_like_phone").val($("#phone").val());
    });

    function searchCustomer() {
        $('#btnSearch').click();
    }
</script>
</body>
</html>  