<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
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
            <div class="recyclebin"><a href="${ctx}/admin/sa/user/disabledList">冻结用户</a></div>
            <div class="search-bar">
                <input type="text" placeholder="手机号" class="control-text" id="short_cut_like_phone"/>
                <button type="button" onclick="searchCustomer()"><i class="icon-search"></i></button>
            </div>

            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input type="hidden" name="statusCd" value="${statusCd?default(1)}">

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
                    <#--<div class="row">-->
                        <#--<div class="control-group span8">-->
                            <#--<label class="control-label">姓名：</label>-->
                            <#--<div class="controls">-->
                                <#--<input type="text" class="control-text" name="userName" id="userName">-->
                            <#--</div>-->
                        <#--</div>-->
                    <#--</div>-->

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
    var userLevelDialog;
    var higherUserLevelDialog;

    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '会员列表', value: '1'}
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
//            {
//                title: '姓名', dataIndex: 'userName', width: 100, renderer: function (value, rowObj) {
//                return app.grid.format.encodeHTML(value);
//            }
//            },
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
                } else if (rowObj.statusCd == 1) {
                    content = "<a href='javascript:void(0)' onclick='updateUserStatus0(" + value + ")'>冻结</a>";
                }
            <@securityAuthorize ifAnyGranted="delete">
                content = content + "&nbsp;&nbsp;<a href='javascript:void(0)' onclick='deleteUser(" + value + ")'>删除</a>";
            </@securityAuthorize>
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
<@securityAuthorize ifAnyGranted="delete">
                    {btnCls: 'button button-small', text: '批量删除', handler: deleteUserBatch},
</@securityAuthorize>
                <#if statusCd?? && statusCd == 1>
                    {btnCls: 'button button-small', text: '设置会员级别', handler: setManyUserLevel},
                    {btnCls: 'button button-small', text: '设置上级会员', handler: setParentUser},
                    {btnCls: 'button button-small', text: '冻结', handler: updateUserStatusBatch0},
                    {btnCls: 'button button-small', text: '设置为推广会员', handler: updateMstoreStatusCdBatch1},
                    {btnCls: 'button button-small', text: '取消推广会员', handler: updateMstoreStatusCdBatch0},
                    {btnCls: 'button button-small', text: '账户充值', handler: updateBalance},
                    {btnCls: 'button button-small', text: '调整积分', handler: updatePoint},
                </#if>
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

    function setManyUserLevel() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要设置等级的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        $("input[name='userIds']").val(selectedCustomerIds.join(","));
        $("#userLevelId").val("-1");

        userLevelDialog.show();
    }

    function setParentUser() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要设置上级会员的账户!");
            return false;
        }

        var params = { //配置初始请求的参数
            choiceType: 'radio'
        };
        higherUserLevelDialog.get('loader').load(params);
        higherUserLevelDialog.show();
    }

    var Overlay = BUI.Overlay;
    userLevelDialog = new Overlay.Dialog({
        title: '设置会员等级',
        width: 350,
        height: 150,
        //配置DOM容器的编号
        contentId: 'userLevelContent',
        success: function () {
            var dialogObj = this;
            var userLevelId = $("#userLevelId").val();
            if (userLevelId == "-1") {
                BUI.Message.Alert("请选择会员等级!");
                return false;
            }

            var customerIds = $("input[name='userIds']").val();
            var selectedCustomerIds = customerIds.split(",");

            if (selectedCustomerIds.length <= 0) {
                BUI.Message.Alert("请选择需要设置等级的账户!");
                return false;
            }

            $.ajax({
                url: '${ctx}/admin/sa/user/userLevel/set',
                dataType: 'json',
                type: 'POST',
                data: {ids: selectedCustomerIds, userLevelId: userLevelId},
                success: function (data) {
                    if (data.result == "success") { //删除成功
                        dialogObj.close();
                        search.load();
                    } else { //删除失败
                        BUI.Message.Alert('设置账户会员等级失败！');
                    }
                }
            });
        }
    });

    /*设置上级会员*/
    higherUserLevelDialog = new Overlay.Dialog({
        title: '会员列表',
        width: 780,
        height: 500,
        loader: {
            url: '${ctx}/admin/sa/user/userDialogList',
            autoLoad: false, //不自动加载
            lazyLoad: false, //不延迟加载
            appendParams: {mstoreStatusCd: '1'}
        },
        buttons: [{
            text: '选 择',
            elCls: 'button button-primary',
            handler: function () {
                var selectedHigherCustomer = getSelectedRecords();
                if (selectedHigherCustomer.length <= 0) {
                    BUI.Message.Alert("请选择上级会员!");
                    return false;
                }

                this.close();
                customerChoiceEvent(selectedHigherCustomer);
            }
        }, {
            text: '取消选择',
            elCls: 'button button-primary',
            handler: function () {
                this.close();
            }
        }],
        mask: true
    });

    function customerChoiceEvent(selectedHigherCustomer) {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要设置上级会员的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        var postData = {userIds: selectedCustomerIds};
        if (selectedHigherCustomer.length > 0) {
            postData.parentUserId = selectedHigherCustomer[0].userId;
        }

        $.ajax({
            url: '${ctx}/admin/sa/user/setParentUserId',
            dataType: 'json',
            type: 'POST',
            data: postData,
            success: function (data) {
                if (data.result == "success") {
                    search.load();
                } else {
                    var errorMsg = data.message;
                    if (errorMsg && errorMsg != "") {
                        BUI.Message.Alert(errorMsg);
                    } else {
                        BUI.Message.Alert("设置上级会员失败!");
                    }
                }
            }
        });
    }

    function searchUser() {
        $("#btnSearch").click();
    }


    function getUser(userId) {
        window.location.href = "${ctx}/admin/sa/user/toUserDetailIndex/" + userId;
    }

    //导入
    function importUser(){
        location.href = "${ctx}/admin/sa/userExcel/import?type=1";
    }

    //导出
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

    function setUserLevel() {

    }

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

    function updateUserStatus0(selectedCustomerId) {
        BUI.Message.Confirm('确认要冻结选中的账户么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateUserStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerId, statusCd: "0"},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("操作成功。");
                        search.load();
                    } else {
                        app.showSuccess("操作失败!");
                    }
                }
            });
        }, 'question');
    }

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

    function updateUserStatusBatch0() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要冻结的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        BUI.Message.Confirm('确认要冻结选中的账户么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateUserStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds, statusCd: "0"},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("账户冻结成功。");
                        search.load();
                    } else {
                        app.showSuccess("账户冻结失败!");
                    }
                }
            });
        }, 'question');
    }

    /*设置为推广会员*/
    function updateMstoreStatusCdBatch1() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要操作的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        BUI.Message.Confirm('确认设置选中的账户为推广会员么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateMstoreStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds, statusCd: "1"},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("操作成功。");
                        search.load();
                    } else {
                        app.showSuccess("操作失败!");
                    }
                }
            });
        }, 'question');
    }

    /*取消 设置为推广会员*/
    function updateMstoreStatusCdBatch0() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要操作的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        BUI.Message.Confirm('确认取消选中的账户为推广会员么？', function () {
            $.ajax({
                url: '${ctx}/admin/sa/user/updateMstoreStatus',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds, statusCd: "0"},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("操作成功。");
                        search.load();
                    } else {
                        app.showSuccess("操作失败!");
                    }
                }
            });
        }, 'question');
    }


    <#-- 帐户充值 -->
    var doPreDepositDialog;
    var Overlay = BUI.Overlay
    doPreDepositDialog = new Overlay.Dialog({
        title: '帐户充值',
        width: 600,
        //配置DOM容器的编号
        contentId: 'doPreDeposit',
        success: function () {
            var dialogObj = this;
			this.hide();
            //校验输入值
            var remarks = $("#remarks_deposit").val();
            var amount = $("#amount_deposit").val();

            var amountPattern = /^-?\d+(\.\d+)?$/;
            if (!amountPattern.test(amount)) {
                alert("充值金额输入不正确");
                return false;
            }

            if (remarks == '' || $.trim(remarks).length < 1) {
                alert("备注不能为空");
                return false;
            }

            var customerIds = $("input[name='doPreCustomerIds']").val();
            var selectedCustomerIds = customerIds.split(",");

            if (selectedCustomerIds.length <= 0) {
                BUI.Message.Alert("请选择需要充值账户!");
                return false;
            }

            $.ajax({
                url: '${ctx}/admin/sa/user/preDeposits',
                dataType: 'json',
                type: 'POST',
                data: {customerIds: selectedCustomerIds, amount: amount, remarks: remarks},
                success: function (data) {
                    if (data.resultStr == 1) {
                        dialogObj.close();
                        app.showSuccess("充值操作成功。");
                        search.load();
                    } else if (data.resultStr == 0) {
                        BUI.Message.Alert(data.message);
                        doPreDepositDialog.close();
                    } else if (data.resultStr == 2) {
                        BUI.Message.Alert("已提交审核");
                        doPreDepositDialog.close();
                    } else if (data.resultStr == 3) {
                        BUI.Message.Alert("已有充值记录在审核，请审核确认后才能再次充值!");
                        doPreDepositDialog.close();
                    } else if (data.resultStr == 4) {
                        BUI.Message.Alert("充值失败!" + data.message);
                        doPreDepositDialog.close();
                    }
                }
            });
        }
    });
    function updateBalance() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要充值账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        $("input[name='doPreCustomerIds']").val(selectedCustomerIds.join(","));
        doPreDepositDialog.show();
    }

    <#-- 积分调整 -->
    var doPrePointDialog;
    var Overlay = BUI.Overlay
    doPrePointDialog = new Overlay.Dialog({
        title: '积分调整',
        width: 580,
        
        //配置DOM容器的编号
        contentId: 'doPrePoint',
        success: function () {
            var dialogObj = this;
			this.hide();
            //校验输入值
            var remarks = $("#remarks_point").val();
            var amount = $("#amount_point").val();

            var amountPattern = /^-?\d+(\.\d+)?$/;
            if (!amountPattern.test(amount)) {
                alert("积分输入不正确");
                return false;
            }

            if (remarks == '' || $.trim(remarks).length < 1) {
                alert("备注不能为空");
                return false;
            }

            var customerIds = $("input[name='doPreCustomerIds']").val();
            var selectedCustomerIds = customerIds.split(",");

            if (selectedCustomerIds.length <= 0) {
                BUI.Message.Alert("请选择需要充值账户!");
                return false;
            }

            $.ajax({
                url: '${ctx}/admin/sa/user/prePoints',
                dataType: 'json',
                type: 'POST',
                data: {customerIds: selectedCustomerIds, amount: amount, remarks: remarks},
                success: function (data) {
                    if (data.result == 1) {
                        app.showSuccess("保存成功！");
                        search.load();
                        doPrePointDialog.close();
                    } else if (data.result == 2) {
                        BUI.Message.Alert("已提交审核!");
                        doPrePointDialog.close();
                    } else if (data.result == 3) {
                        BUI.Message.Alert("已有充值记录在审核，请审核确认后才能再次充值!");
                        doPrePointDialog.close();
                    } else if (data.result == 0) {
                        BUI.Message.Alert("充值失败!");
                        doPrePointDialog.close();
                    }
                }
            });
        }
    });
    function updatePoint() {
        var selectedCustomer = grid.getSelection();
        if (selectedCustomer.length <= 0) {
            BUI.Message.Alert("请选择需要设置积分的账户!");
            return false;
        }

        var selectedCustomerIds = [];
        for (var i = 0; i < selectedCustomer.length; i++) {
            selectedCustomerIds.push(selectedCustomer[i].userId);
        }

        $("input[name='doPreCustomerIds']").val(selectedCustomerIds.join(","));

        doPrePointDialog.show();
    }

    function batchUpdateBalance() {

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