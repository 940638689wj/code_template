<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <ul class="toolbar">
            <li style="margin-left: 7px;"><label class="checkbox" for="chk_all"><input type="checkbox" id="chk_all"/>全选</label>
            </li>
            <li>
                <button class="button button-primary" onclick="passAll()">批量同意</button>
            </li>
            <li>
                <button class="button" onclick="refuseAll()">批量拒绝</button>
            </li>
        </ul>
        <div class="check-list">
            <ul>
            <#if pageDTO?has_content&&(pageDTO.content)?has_content>
                <#list pageDTO.content as one>
                    <li id="${(one.id)!}">
                        <div class="chk"><label class="checkbox" for=""><input id="" value="${(one.id)!}"
                                                                               type="checkbox"/></label></div>
                        <#--<div class="name">${(one.operator)!}</div>-->
                        <div class="time">${(one.applyTime)!?string("yyyy-MM-dd HH:mm:ss")}</div>
                        <div class="con">
                            商品: ${one.productName!} 的价格，从￥${one.oldPrice!}调至￥${one.newPrice!},
                            <a href="${ctx}/admin/sa/productManage/addOrEdit?productId=${one.orderItemId!}" target="_blank">商品详情</a>
                        </div>

                        <div class="ctrl">
                            <button class="button button-primary" onclick="pass(${(one.id)!})">同意</button>
                            <button class="button" onclick="refuse(${(one.id)!})">拒绝</button>
                        </div>
                    </li>
                </#list>
            </#if>
            </ul>
        </div>
    </div>
</div>
<div class="pagination pagination-right">
    <ul>
    <@pager pageDTO/>
    </ul>
</div>
<#macro pager pageDTO steps=3>
    <#assign page = pageDTO.page>
    <#assign totalPages = pageDTO.totalPage>

    <#assign startRangeIndex = page - steps/>
    <#if startRangeIndex lt 1>
        <#assign startRangeIndex = 1/>
    </#if>
    <#assign endRangeIndex = page + steps/>
    <#if endRangeIndex gte totalPages>
        <#assign endRangeIndex = totalPages/>
    </#if>

    <#if page gt 1>
    <li><a class="prev" href="javascript:goPage(${page -1});"><i></i>上一页</a></li>
    <#else>
    <li class="disabled"><a class="prev disabled"><i></i>上一页</a></li>
    </#if>
    <#list startRangeIndex..endRangeIndex as currPage>
        <#if currPage==page>
        <li class="active"><a href="#"><b class="page-cur">${page}</b></a></li>
        <#elseif currPage!=0>
        <li><a href='javascript:goPage(${currPage});'>${currPage}</a></li>
        </#if>
    </#list>
    <#if endRangeIndex lt totalPages>
        <#if endRangeIndex lt (totalPages-1)><b>...</b></#if><a
            href='javascript:goPage(${totalPages});'>${totalPages}</a>
    </#if>
    <#if page lt totalPages>
    <li><a class="next" href="javascript:goPage(${page+1});">下一页<i></i></a></li>
    <#else>
    <li class="disabled"><a class="next disabled">下一页<i></i></a></li>
    </#if>
</#macro>
<script>
    $(function () {
        $("#pageSubmit").click(function () {
            goPage($("#targetPage").val());
        });
    });

    function goPage(pageNo) {
        window.location.href = "${ctx}/admin/sa/productAudit/priceAuditList?pageNo=" + pageNo;
    }

</script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '商品价格审核', value: '0'},
            {text: '商品上架审核', value: '1'},
            {text: '审核日志', value: '2'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    tab.on('selectedchange', function (ev) {
        var item = ev.item;
        if (item.get('value') == "0") {
            window.location.href = "${ctx}/admin/sa/productAudit/priceAuditList";
        }
        if (item.get('value') == "1") {
            window.location.href = "${ctx}/admin/sa/productAudit/saleAuditList";
        }
        if (item.get('value') == "2") {
            window.location.href = "${ctx}/admin/sa/productAudit/doneList";
        }
    });

//    BUI.use('bui/calendar', function (Calendar) {
//        var datepicker = new Calendar.DatePicker({
//            trigger: '.calendar',
//            //delegateTrigger : true, //如果设置此参数，那么新增加的.calendar元素也会支持日历选择
//            autoRender: true,
//            align: {
//                node: 'trigger',     // 参考元素, falsy 或 window 为可视区域, 'trigger' 为触发元素, 其他为指定元素
//                points: ['tl', 'tl'], // ['tr', 'tl'] 表示 overlay 的 tl 与参考节点的 tr 对齐
//                offset: [0, 30]    // 有效值为 [n, m]
//            }
//        });
//    });

    function pass(auditId) {
        if (!auditId) {
            return;
        }
        BUI.Message.Confirm('确定要同意调价吗?', function () {
            $.ajax({
                url: '${ctx}/admin/sa/productAudit/passPriceChange/' + auditId,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("调价成功!商品金额已更改！");
                        var id = "#" + auditId;
                        $(id).css("display", "none")
                    } else {
                        app.showError("审核失败!");
                    }
                }
            });
        }, 'question');
    }

    function refuse(auditId) {
        if (!auditId) {
            return;
        }
        BUI.Message.Confirm('确定要拒绝此商品审核申请吗?', function () {
            $.ajax({
                url: '${ctx}/admin/sa/productAudit/refuse/' + auditId,
                dataType: 'json',
                type: 'POST',
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("已拒绝了商品审核申请!");
                        var id = "#" + auditId;
                        $(id).css("display", "none")
                    } else {
                        app.showError("审核失败!");
                    }
                }
            });
        }, 'question');
    }

    function passAll() {
        var selectedCustomerIds = [];

        $(".check-list input[type='checkbox']").each(function () {
            if ($(this).attr("checked")) {
                var id = $(this).attr("value");
                selectedCustomerIds.push(id);
            }
        });

        if (selectedCustomerIds.length <= 0) {
            BUI.Message.Alert("请选择商品!");
            return false;
        }
        ;

        BUI.Message.Confirm('确定要批量同意调价吗?', function () {
            $.ajax({
                url: '${ctx}/admin/sa/productAudit/passPriceChangeAll/',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("已同意了调价申请!");
                        window.location.href = "${ctx}";
                    } else {
                        app.showError("审核失败!");
                    }
                }
            });
        }, 'question');
    }

    function refuseAll() {
        var selectedCustomerIds = [];

        $(".check-list input[type='checkbox']").each(function () {
            if ($(this).attr("checked")) {
                var id = $(this).attr("value");
                selectedCustomerIds.push(id);
            }
        });

        if (selectedCustomerIds.length <= 0) {
            BUI.Message.Alert("请选择商品!");
            return false;
        }

        BUI.Message.Confirm('确定要批量拒绝商品审核申请吗?', function () {
            $.ajax({
                url: '${ctx}/admin/sa/productAudit/refuseAll',
                dataType: 'json',
                type: 'POST',
                data: {id: selectedCustomerIds},
                success: function (data) {
                    if (data.result == "success") {
                        app.showSuccess("已拒绝了商品审核申请!");
                        window.location.href = "${ctx}";
                    } else {
                        app.showError("审核失败!");
                    }
                }
            });
        }, 'question');
    }

    $("#chk_all").click(function () {
        if ($("#chk_all").attr("checked")) {
            $(".check-list input[type='checkbox']").each(function () {
                $(this).attr("checked", "checked");
            });
        } else {
            $(".check-list input[type='checkbox']").each(function () {
                $(this).removeAttr("checked");
            });
        }
    });
</script>
</html>