<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/dateFormate.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
        	 <input name="storeId" value="${storeId!}" type="hidden" id="storeId"/>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls control-row-auto ml0 ">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>

                        <div class="pull-left">
                        	 <input type="hidden" id="storeBillType" name="storeBillType" class="control-text"
                                   placeholder="门店对账类型" value="${storeBillType!}"/>
                        	<input type="text" id="orderNumber" name="orderNumber" class="control-text" placeholder="订单号">
                        	   <select class="input-small bui-form-field-select bui-form-field" name="isChecked"
                                    id="isChecked"
                                    aria-disabled="false" aria-pressed="false">
	                                <option value="0" selected="selected">
	                                    		未结账
	                                </option>
	                                <option value="1">
	                                   	 已结账
	                                </option>
                            	</select>
                            <button id="user_search" name="user_search" type="button" class="button button-primary ml">
                                	搜索
                            </button>
                        </div>
                        <div class="steps steps-small pull-left">
                            <ul>
                                <li class="step-first" id="thisWeek">
                                    <b class="stepline"></b>
                                    <div class="stepind">本周</div>
                                </li>
                                <li id="lastWeek">
                                    <b class="stepline"></b>
                                    <div class="stepind">上周</div>
                                </li>
                                <li id="thisMonth">
                                    <b class="stepline"></b>
                                    <div class="stepind">本月</div>
                                </li>
                                <li class="step-last" id="lastMonth">
                                    <b class="stepline"></b>
                                    <div class="stepind">上月</div>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="pull-left">
                    <label id="expressAmtTotal"
                           class="control-label control-label-auto mr30"><#if storeBillType??&&storeBillType=='0'>
                        商品总金额：<#else >配送费总金额：</#if><span
                            class="red"><#if productTotal??> ￥${productTotal!'0'}<#else>
                            ￥0
                       </#if></span></label>
                    <label id="commissionTotal" class="control-label control-label-auto mr30">佣金总金额：<span
                            class="red"><#if commissionTotal??>
                        ￥${commissionTotal!'0'}<#else>
                            ￥0</#if></span></label>
                    <label id="realAmtTotal" class="control-label control-label-auto mr30">门店所得总金额：<span
                            class="red"><#if realAmtTotal??>￥${realAmtTotal!'0'}<#else>
                            ￥0</#if></span></label>
                </div>
            </div>
            <div class="row">
                <div class="pull-left">
                     <button id="export" type="button" class="button button-primary ml">导出对账单</button>
                </div>
            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script type="text/javascript">
    //导出
    $("#export").click(function () {
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/store/exportStoreBill?" + params;
        BUI.Message.Alert("导出成功");
    });
</script>
<script type="text/javascript">
    var grid;
    var search;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
                render: '#tab',
                elCls: 'nav-tabs',
                autoRender: true,
                children: [
                    {text: '商品对账单', value: '0'},
                    <#if (store.storeTypeCd)?? && store.storeTypeCd==1>
                    <#else>
                    	 {text: '送货对账单', value: '1'}
                   </#if>
                   
                ]
            });
   
    tab.setSelected(tab.getItemAt(${storeBillType!'0'}));
    tab.on('selectedchange', function (ev) {
        var item = ev.item;
        var storeBillType = item.get('value');
        window.location.href = "${ctx}/admin/store/statement/list?storeBillType=" + storeBillType + '&storeId=${storeId!}';
    });
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
              {title: '订单号', dataIndex: 'orderNumber', width: '180px', renderer: function (val, obj) {
				          return  "<a href='${ctx}/admin/store/order/"+obj.orderId+"' target='_blank'>"+val+"</a>";
            	         }},
            {title: '收货人', dataIndex: 'receiveName', renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }},
            {title: '手机号', dataIndex: 'receiveTel', width: "100px"},
            {
                title: '商品名称', dataIndex: 'productName', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            },
            
            <#if storeBillType??&&storeBillType=='0'>
            {
                title: '商品金额', dataIndex: 'productTotal', width: 100, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },
        <#else>
            {
                title: '送货金额', dataIndex: 'orderExpressAmt', width: 100, renderer: function (value, rowObj) {
                return value.toFixed(2);
            }
            },

        </#if>
        
        {
                title: '完成时间', dataIndex: 'orderCompleteTime', width: 200, renderer: function (value, rowObj) {
                //return value;
                if(value != null){
                	var date = new Date(value).Format("yyyy-MM-dd hh:mm:ss");
                	return date;
                }
                return "";
              
            }
            },
            {
                title: '账单状态', dataIndex: 'isStoreChecked', width: 100, renderer: function (value, rowObj) {
                var  str = "未结账";
                if (value == "0") {
                    str = "未结账";
                } else if (value == "1") {
                    str = "已结账";
                }
                return str;
            }
            },
              <#if storeBillType??&&storeBillType=='0'>
             {title: '配送方', dataIndex: 'orderDistrbuteTypeCd', width: "150px", renderer: function (val, obj) {
                if (val == 1) {
                    return  "门店";
                }else if (val == 2) {
                    return  "总部";
                }
                return "-";
            }}
        <#else>
            {
                title: '送货方', dataIndex: 'orderDistrbuteTypeCd', width: "150px", renderer: function (val, obj) {
                if (val == 1) {
                    return  "门店";
                }else if (val == 2) {
                    return  "总部";
                }
                return "-";
            	}
            }

        </#if>
            
        ];

        var store = Search.createStore("${ctx}/admin/store/statement/grid_json?storeBillType=${(storeBillType)!'0'}", {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns,
                {
                    width: '100%',
                    height: getContentHeight(),
                    // 底部工具栏
                    bbar: {
                        // pagingBar:表明包含分页栏
                        pagingBar: true
                    },
                    plugins: [BUI.Grid.Plugins.CheckSelection, BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
                });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select',
            //btnId: 'user_search'
        });

        grid = search.get('grid');
        grid.render();

        //更新页面数据
        $("#user_search").click(function () {
            //var params=encodeURI(decodeURIComponent($("#searchForm_select").serialize(),true));
            var params = $("#searchForm_select").serialize();
            var bTime = $("#beginTime").val();
            var eTime = $("#endTime").val();
            if (bTime && eTime) {
                bTime = new Date(bTime);
                eTime = new Date(eTime);
                if (bTime.getTime() > eTime.getTime()) {
                    return;
                }
            }
            search.load();
            getTotalData(params);
        });

        function getTotalData(params) {
            //通过Ajax获取数据
            $.ajax({
                type: "post",
                async: false, //同步执行
                url: "${ctx}/admin/store/getTotalData?" + params,
                data: {},
                dataType: "json", //返回数据形式为json
                success: function (data) {
                    if (data) {
                        if (data.map1.storeBillType=="0"){
                            $("#expressAmtTotal").html("商品总金额：<span class='red'>￥" + data.map1.productTotal + "</span>");
                            $("#commissionTotal").html("佣金总金额：<span class='red'>￥" + data.map1.commissionTotal  + "</span>");
                            $("#realAmtTotal").html("门店所得总金额：<span class='red'>￥" + data.map1.realAmtTotal + "</span>");
                        }else if(data.map1.storeBillType=="1"){
                            $("#expressAmtTotal").html("配送费总金额：<span class='red'>￥" + data.map1.productTotal + "</span>");
                            $("#commissionTotal").html("佣金总金额：<span class='red'>￥" + data.map1.commissionTotal  + "</span>");
                            $("#realAmtTotal").html("门店所得总金额：<span class='red'>￥" + data.map1.realAmtTotal + "</span>");
                        }

                    }
                },
                error: function (errorMsg) {

                }
            });
        }
    });

    // 初始化
    $(function () {
        var t = $(".container").find("li");
        $(t).each(function (i, item) {
            $(this).click(function () {
                // 有颜色就删掉
                $("li").removeClass('step-active');
                // 改变颜色
                $(this).addClass("step-active");
                // 请求处理
                var bTime;
                var eTime;
                if (this.id == "thisWeek") {
                    bTime = getCurrentWeek()[0];
                    eTime = getCurrentWeek()[1];
                } else if (this.id == "lastWeek") {
                    bTime = getPreviousWeek()[0];
                    eTime = getPreviousWeek()[1];
                } else if (this.id == "thisMonth") {
                    bTime = getCurrentMonth()[0];
                    eTime = getCurrentMonth()[1];
                } else if (this.id == "lastMonth") {
                    bTime = getPreviousMonth()[0];
                    eTime = getPreviousMonth()[1];
                }

                $("#beginTime").attr("value", bTime);
                $("#endTime").attr("value", eTime);
                //refeshData(bTime,eTime);
            });
        });
    });

    //批量结账
    function auditAgreed(orderId) {
        var orderIds = '';
        var storeBillType=$("#storeBillType").val();
        if (null != orderId && '' != orderId) {
            orderIds = orderId;
        } else {
            var selectedContent = grid.getSelection();
            if (selectedContent.length <= 0) {
                BUI.Message.Alert("请选择申请!");
                return false;
            }
            //            if(selectedContent.length < 2){
            //                BUI.Message.Alert("选择的申请条数不能低于2条!");
            //                return false;
            //            }
            var selectedContentIds = [];
            for (var i = 0; i < selectedContent.length; i++) {
                selectedContentIds.push(selectedContent[i].orderId+"&"+selectedContent[i].storeId);
            }
            orderIds = selectedContentIds.join(",");
            //console.log(selectedContentIds)
            //alert(orderIds);

        }
        BUI.Message.Confirm("是否确认结账？", function () {
            app.ajax('${ctx}/admin/store/storeBill/checkBill', {
                orderIds: orderIds, code: 'Y', storeBillType:storeBillType
            }, function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("结账成功");
                    location.href = location.href;
                }
            });
        });
    }

    //设置订单来源系统参数切换
    function setOriginPlatformCd(ev, value) {
        $("#all").removeClass("button-primary");
        $("#mobile").removeClass("button-primary");
        $("#PC").removeClass("button-primary");
        $(ev).addClass("button-primary");
        $("#originPlatformCd").val(value);
    }
</script>
</body>
</html>  