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
                <div class="search-bar">
                    <input type="text" placeholder="订单号" class="control-text" id="short_pickupCouponName"/>
                    <button onclick="searchResult()"><i class="icon-search"></i></button>
                </div>
                <div class="search-content">
                    <form id="searchForm" class="form-horizontal search-form">
                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">
                                    <select class="input-small" id="selectConditionType"
                                            name="selectConditionType">
                                        <option value="orderNumber">订单号</option>
                                        <option value="nickName">会员名称</option>
                                        <option value="invoiceReceiveName">个人姓名</option>
                                        <option value="invoiceReceiveTel">收票人手机号</option>
                                        <option value="companyName">单位名称</option>
                                        <option value="orderExpressNum">配送单号</option>
                                    </select>&nbsp;&nbsp;
                                </label>
                                <div class="controls">
                                    <input type="text" id="selectCondition" name="selectCondition"
                                           class="input-normal control-text">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span8">
                                <label class="control-label">发票状态：</label>
                                <div class="controls">
                                    <label class="radio" for=""><input type="radio" name="invoiceBillingStatus" value=""
                                                                       checked="checked">全部</label>&nbsp;&nbsp;&nbsp;
                                    <label class="radio" for=""><input type="radio" name="invoiceBillingStatus"
                                                                       value="0">未开票</label>&nbsp;&nbsp;&nbsp;
                                    <label class="radio" for=""><input type="radio" name="invoiceBillingStatus"
                                                                       value="1">已开票</label>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span12">
                                <label class="control-label">下单时间：</label>
                                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                    <input name="createStart" id="createStart"
                                           class="control-text input-small calendar" type="text"><label>
                                    &nbsp;至&nbsp;</label>
                                    <input name="createEnd" id="createEnd"
                                           class="control-text input-small calendar" type="text">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span12">
                                <label class="control-label">开票时间：</label>
                                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                    <input name="invoiceBillingStart" id="invoiceBillingStart"
                                           class="control-text input-small calendar" type="text"><label>
                                    &nbsp;至&nbsp;</label>
                                    <input name="invoiceBillingEnd" id="invoiceBillingEnd"
                                           class="control-text input-small calendar" type="text">
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="control-group span12">
                                <label class="control-label">配送时间：</label>
                                <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                    <input name="sendStart" id="sendStart" class="control-text input-small calendar"
                                           type="text"><label>&nbsp;至&nbsp;</label>
                                    <input name="sendEnd" id="sendEnd" class="control-text input-small calendar"
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
        </div>
        <div class="content-body">
            <div id="grid">
            </div>

        <#--开票的弹窗-->
            <div id="billingDialog" class="well" style="display: none;">
                <form id="J_Form" class="form-horizontal">
                    <input type="hidden" id="orderIdList" name="orderIdList" value=""/>
                    <div class="form-content">
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label"><s>*</s>发票类型：</label>
                                <div class="controls control-row-auto" id="invoiceTypeCd">
                                    <input name="invoiceTypeCd" type="radio" value="1" checked="checked"/>普通发票&nbsp;&nbsp;
                                    <input name="invoiceTypeCd" type="radio" value="2"/>增值税发票
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label"><s>*</s>发票抬头：</label>
                                <div class="controls control-row-auto" id="invoiceForCd">
                                    <span id="invoiceForCd1"><input name="invoiceForCd" type="radio" value="1"
                                                                    checked="checked"/>个人&nbsp;&nbsp;</span>
                                    <input name="invoiceForCd" type="radio" value="2"/>单位
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="control-group">
                                <label class="control-label"><s>*</s><span
                                        id="companyNameText">个人姓名</span>：</label>
                                <div class="controls">
                                    <input name="companyName" id="companyName" type="text"
                                           class="input-normal control-text"/>
                                </div>
                            </div>
                        </div>
                        <span id="moreField" style="display: none">
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>纳税人识别码：</label>
                                    <div class="controls">
                                        <input name="companyTaxpayerIdentifyCode" id="companyTaxpayerIdentifyCode"
                                               type="text" class="input-normal control-text"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>注册地址：</label>
                                    <div class="controls">
                                        <input name="companyRegisterAddr" id="companyRegisterAddr" type="text"
                                               class="input-normal control-text"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>注册电话：</label>
                                    <div class="controls">
                                        <input name="companyRegisterTel" id="companyRegisterTel" type="text"
                                               class="input-normal control-text"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>银行账户：</label>
                                    <div class="controls">
                                        <input name="companyBankAccount" id="companyBankAccount" type="text"
                                               class="input-normal control-text"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>开户行：</label>
                                    <div class="controls">
                                        <input name="companyOpeningBankName" id="companyOpeningBankName" type="text"
                                               class="input-normal control-text"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>发票抬头：</label>
                                    <div class="controls">
                                        <input name="invoiceTitle" id="invoiceTitle" type="text"
                                               class="input-normal control-text"/>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="control-group">
                                    <label class="control-label"><s>*</s>发票配送地址：</label>
                                    <div class="controls">
                                        <select class="input-small" id="invoiceProvinceId"
                                                name="invoiceProvinceId"></select>
                                        <select class="input-small" id="invoiceCityId" name="invoiceCityId">
                                            <option>选择城市</option>
                                        </select>
                                        <select class="input-small" id="invoiceCountyId" name="invoiceCountyId">
                                            <option>选择县/区</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </span>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>
<#include "${ctx}/user/pc/include/addrSelect.ftl"/>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var search;
    var grid;
    var billingDialog;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '发票列表', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: "发票类型", dataIndex: "invoiceTypeName", width: 100},
            {title: "订单号", dataIndex: "orderNumber", width: 150, renderer: function (val,obj) {
                return "<a href='${ctx}/admin/sa/orderManage/toAllOrderDetail?orderId=" + obj.orderId + "' target='_blank'>" + val + "</a>";
            }},
            {title: "下单时间", dataIndex: "createTime", width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: "开票时间", dataIndex: "invoiceBillingTime", width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: "配送时间", dataIndex: "sendTime", width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: "配送单号", dataIndex: "orderExpressNum", width: 100},
            {title: "发票金额", dataIndex: "orderPayAmt", width: 100},
            {
                title: "发票状态", dataIndex: "", width: 100, renderer: function (value, rowObj) {
                return rowObj.invoiceBillingTime ? '已开票' : '未开票'
            }
            },
            {
                title: "个人姓名", dataIndex: "", width: 100, width: 100, renderer: function (value, rowObj) {
                return rowObj.invoiceForCd == 1 ? rowObj.companyName : "";
            }
            },
            {
                title: "单位名称", dataIndex: "", width: 100, renderer: function (value, rowObj) {
                return rowObj.invoiceForCd == 2 ? rowObj.companyName : "";
            }
            },
            {
                title: '操作', dataIndex: '', width: 100, renderer: function (value, rowObj) {
                var editStr = "";
                if (!rowObj.invoiceBillingTime) {
                    editStr += '&nbsp;<a href=\'javascript:rowBilling(\"' + rowObj.orderId + '\")\'>开票</a>';
                }
<@securityAuthorize ifAnyGranted="delete">
                editStr += '&nbsp;<a href=\'javascript:del(\"' + rowObj.orderId + '\")\'>删除</a>';
</@securityAuthorize>
                return editStr;
            }
            }
        ];
        var store = Search.createStore('invoicePageJson', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [BUI.Grid.Plugins.ColumnResize, BUI.Grid.Plugins.CheckSelection],
            stripeRows: false,
            width: '100%',
            height: getContentHeight(),
            render: '#grid',
            columns: columns
            , tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small button-primary', handler: exp},
                    {text: '开票', btnCls: 'button button-small button-primary billing', handler: billing},
<@securityAuthorize ifAnyGranted="delete">
                    {text: '批量删除', btnCls: 'button button-small', handler: batchDel}
</@securityAuthorize>
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get('grid');

        grid.render();

    });

    billingDialog = new BUI.Overlay.Dialog({
        title: '开票',
        width: 500,
//        height: 700,
        contentId: 'billingDialog',
        success: function () {
            var param = {};
            param.orderIdList = $("#orderIdList").val();
            var invoiceTypeCd = $("input[name='invoiceTypeCd']:checked").val();
            param.invoiceTypeCd = invoiceTypeCd;
            param.invoiceForCd = $("input[name='invoiceForCd']:checked").val();
            var companyName = $("#companyName").val();
            if (!companyName) {
                app.showError($("#companyNameText").html() + "不能为空");
                return;
            }
            param.companyName = companyName;
            if (invoiceTypeCd == 2) {
                var companyTaxpayerIdentifyCode = $("#companyTaxpayerIdentifyCode").val();
                var companyRegisterAddr = $("#companyRegisterAddr").val();
                var companyRegisterTel = $("#companyRegisterTel").val();
                var companyBankAccount = $("#companyBankAccount").val();
                var companyOpeningBankName = $("#companyOpeningBankName").val();
                var invoiceTitle = $("#invoiceTitle").val();
                var invoiceProvinceId = $("#invoiceProvinceId").val();
                var invoiceCityId = $("#invoiceCityId").val();
                var invoiceCountyId = $("#invoiceCountyId").val();

                if (!companyTaxpayerIdentifyCode) {
                    app.showError("纳税人识别码不能为空");
                    return;
                }
                if (!companyRegisterAddr) {
                    app.showError("注册地址不能为空");
                    return;
                }
                if (!companyRegisterTel) {
                    app.showError("注册电话不能为空");
                    return;
                }
                if (!companyBankAccount) {
                    app.showError("银行账户不能为空");
                    return;
                }
                if (!companyOpeningBankName) {
                    app.showError("开户行不能为空");
                    return;
                }
                if (!invoiceTitle) {
                    app.showError("发票抬头不能为空");
                    return;
                }
                if (!invoiceProvinceId) {
                    app.showError("发票配送地址省份不能为空");
                    return;
                }
                if (!invoiceCityId) {
                    app.showError("发票配送地址城市不能为空");
                    return;
                }
                if (!invoiceCountyId) {
                    app.showError("发票配送地址县/区不能为空");
                    return;
                }

                param.companyTaxpayerIdentifyCode = $("#companyTaxpayerIdentifyCode").val();
                param.companyRegisterAddr = $("#companyRegisterAddr ").val();
                param.companyRegisterTel = $("#companyRegisterTel").val();
                param.companyBankAccount = $("#companyBankAccount").val();
                param.companyOpeningBankName = $("#companyOpeningBankName").val();
                param.invoiceTitle = $("#invoiceTitle").val();
                param.invoiceProvinceId = $("#invoiceProvinceId").val();
                param.invoiceCityId = $("#invoiceCityId").val();
                param.invoiceCountyId = $("#invoiceCountyId").val();
            }
            $.post('${ctx}/admin/sa/orderManage/invoiceBilling', param, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess('开票成功');
                    search.load();
                    $("#J_Form input[type='text'],#invoiceReceiveAddr").val("");
                    $("input[name='invoiceTypeCd']:first").attr("checked", true);
                    $("#invoiceForCd1").show();
                    $("#moreField").hide();
                    $("input[name='invoiceForCd']:first").attr("checked", true);
                    $("input[name='invoiceForCd']:first").trigger("change");
                    $("#invoiceProvinceId option:first").attr("selected", true);
                    $("#invoiceProvinceId option:first").trigger("change");
                    billingDialog.hide();
                }
            }, 'json');
        }
    });

    $(function () {
        //修改发票类型
        $("input[name='invoiceTypeCd']").change(function () {
            if ($(this).val() == '2') {
                $("#invoiceForCd1").hide();
                $("input[name='invoiceForCd']:last").click();
                $("#moreField").show();
                billingDialog.hide();
                billingDialog.show();
            } else if ($(this).val() == '1') {
                $("#invoiceForCd1").show();
                $("#moreField").hide();
                billingDialog.hide();
                billingDialog.show();
            }
        });
        $("input[name='invoiceForCd']").change(function () {
            if ($(this).val() == "1") {
                $("#companyNameText").html("个人姓名");
            } else if ($(this).val() == "2") {
                $("#companyNameText").html("单位名称");
            }
        });

        addChangeEven("invoiceProvinceId", ["invoiceCountyId"], ["选择县/区"], "invoiceCityId", "选择城市");
        addChangeEven("invoiceCityId", [], [], "invoiceCountyId", "选择县/区");
        findChildByParentId("invoiceProvinceId", 0, "选择省");

    });

    /**
     * 选中开票
     */
    function billing() {
        var invoiceList = grid.getSelection();
        if (invoiceList.length != 1) {
            BUI.Message.Alert('请选择一张发票');
            return;
        }
        var orderIdList = [];
        for (var i = 0; i < invoiceList.length; i++) {
            if (invoiceList[i].invoiceBillingTime) {
                app.showError("该发票已开票");
                return;
            }
            orderIdList.push(invoiceList[i].orderId);
        }
        $("#orderIdList").val(orderIdList);
        billingDialog.show();

    }

    /**
     * 单个开票
     */
    function rowBilling(orderId) {
        $("#orderIdList").val(orderId);
        billingDialog.show();
    }

    /**
     * 删除
     */
    function del(orderId) {
        BUI.Message.Confirm("确认删除？", function () {
            $.post("${ctx}/admin/sa/orderManage/delInvoice", {
                orderIdList: orderId
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("删除成功");
                    search.load();
                }
            })
        });
    }

    /**
     * 批量删除
     */
    function batchDel() {
        var selections = grid.getSelection();
        if (selections.length == 0) {
            app.showError("请选择发票");
            return false;
        }
        BUI.Message.Confirm("确认删除？", function () {
            var orderIdList = [];
            $.each(selections, function (index, value) {
                orderIdList.push(value.orderId);
            });
            $.post("${ctx}/admin/sa/orderManage/delInvoice", {
                orderIdList: orderIdList.join(",")
            }, function (data) {
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
    function exp() {
        window.location.href = "${ctx}/admin/sa/orderManage/exportInvoice";
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
        $("#selectCondition").val($("#short_pickupCouponName").val());
    });

    //提货券名字同搜索框内容,同步显示
    $("#selectCondition").on('keyup', function (event) {
        $("#short_pickupCouponName").val($("#selectCondition").val());
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