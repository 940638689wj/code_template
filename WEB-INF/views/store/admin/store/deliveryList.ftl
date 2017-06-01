<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
	<#include "${ctx}/includes/sa/header.ftl"/>
    <meta charset="utf-8">
    <title>会员总账单</title>
    <link href='${ctx}/static/admin/js/fullcalendar/fullcalendar.css' rel='stylesheet' />
    <link href='${ctx}/static/admin/js/fullcalendar/fullcalendar.print.css' rel='stylesheet' media='print' />
    <script src='${ctx}/static/admin/js/fullcalendar/moment.min.js'></script>
    <script src='${ctx}/static/admin/js/jquery-1.8.1.min.js'></script>
    <script src='${ctx}/static/admin/js/fullcalendar/fullcalendar.min.js'></script>
    
    <script>
        $(function(){
            window.onload=function(){
                $('#bar-item-button8').hide();
                $('#bar-item-button9').hide();
            }
        });
        function totalBill(){
            $('#userNameDiv').show();
            $('#bar-item-button7').show();
            $('#bar-item-button8').hide();
           <#--  $('#bar-item-button9').hide();-->
           $('#calendar').fullCalendar('destroy');
           <#--  $("#lastCheckDate").hide();-->
        }
        function checkedBill(){
            $("#username").val("");
            $('#userNameDiv').hide();
            $('#bar-item-button7').hide();
            $('#bar-item-button8').show();
           <#-- $('#bar-item-button9').show();
            $("#lastCheckDate").show();-->
            search.load();
        }
        function showCalendar(){
            $.ajax({
                type: "POST",
                dataType: 'json',
                url: "${ctx}/admin/store/delivery/getEventJson",
                success: function (data) {renderCalendar(data);}
            });
        }
        function renderCalendar(events){
            $('#calendar').fullCalendar({
                defaultDate: new Date(),
                monthNames: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                monthNamesShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
                dayNames: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
                dayNamesShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六"],
                today: ["今天"],
                firstDay: 1,
                buttonText: {today: '今天'},
                editable: false,
                eventLimit: true,
                events: events
            });
        }
        $(function(){
            $("#calendar").mouseleave(function(){$('#calendar').fullCalendar('destroy');});
            $("#tab ul").append("<span style='color: #808080;display:none;' id='lastCheckDate'>最近结算日期:${lastCheckDate!}</span>");
            $("#lastCheckDate").mouseover(function(){showCalendar()});
            $("#lastCheckDate").mouseleave(function(){$('#calendar').fullCalendar('destroy');});
        })
    </script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <form id="searchForm" class="form-horizontal search-form mb0">
        <#include "deliverySearchBar.ftl" />
            <div class="row">
                <div class="control-group">
                    <div class="controls control-row-auto" style="padding-bottom:0">
                        <label class="control-label control-label-auto">
                           配送费总金额:<span id="allPullRebate_customer" style="font-size: 18px;color: red">￥0.00</span>
                        </label>
                    </div>
                    <div class="controls control-row-auto" style="padding-bottom:0">
                        <label class="control-label control-label-auto">
                        佣金总金额:<span id="monthRebateSpan" style="font-size: 18px;color: red">￥0.00</span>
                        </label>
                    </div>
                </div>
                 <div class="controls control-row-auto" style="padding-bottom:0">
                        <label class="control-label control-label-auto">
                        	门店所得总金额:<span id="monthRebateSpan" style="font-size: 18px;color: red">￥0.00</span>
                        </label>
                    </div>
                </div>
            </div>
        </form>
    </div>
    <div id='calendar' style="max-width: 950px;margin-left: 0 ;"></div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
	 $.fn.status=function(key){
			var Status={10:'待分配',11:'待送货',3:'待收货',6:'已取消',22:'订单异常'};
			return Status[key];
	}
   var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'商品对账单',value:'0'},
        	{text:'送货对账单',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(1));
    
   tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/store/statement/list?storeId=${(store.storeId)!}";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/store/delivery/list?storeId=${(store.storeId)!}";
	        }
	        
	});
    var search;
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
           
            {title: '订单号', dataIndex: 'orderNumber', width: '180px', renderer: function (val, obj) {
                var str = val;
                str= "<a href='${ctx}/admin/store/order/"+ obj.orderId +"' target='_blank'>"+val+"</a>";
                return str;
            }},
            {title: '收货人', dataIndex: 'receiveName', renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }},
            {title: '手机号', dataIndex: 'receiveTel', width: "100px"},
            {title: '商品名称', dataIndex: 'productNames', width: "450px", renderer: function (value, rowObj) {
                return "<span title='"+rowObj.productNames+"'>"+value+"</span>";
            }},
           
            {title: '下单时间', dataIndex: 'createTime',width:"150px", renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '订单状态', dataIndex: 'orderStatusCd', width: "80px", renderer: function (val, obj) {
                return $.fn.status(val);
            }},
            {title: '送货方', dataIndex: 'distrbuteStoreName', width: "150px", renderer: function (val, obj) {
                if (val != null) {
                    return  val;
                }
                return "-";
            }},
             {title: '送货金额', dataIndex: 'orderExpressAmt', width: "80px", renderer: function (val, obj) {
                if (val != null) {
                    return "￥" + val;
                }
                return "-";
            }}
        ];
        var store = Search.createStore('${ctx}/admin/store/delivery/grid_json',{
            pageSize: 15
        });

        var gridCfg = Search.createGridCfg(columns, {
            width:'100%',
            height:getContentHeight(),
            tbar: {
                items: [
             
                    {text: '结算', btnCls: 'button button-primary', handler: markCheck}  ,
                    {text: '查看已结算时间段', btnCls: 'button', handler: showChecked}
                ]
            }
        });

        search = new Search({
            gridId: "grid",
            formId: "searchForm",
            store: store,
            gridCfg: gridCfg
        });
        var grid =search.get('grid');
        grid.on("aftershow",function(){
            var form = $("#searchForm");
            var postData = form.serialize();
            app.ajax("${ctx}/admin/store/delivery/getTotalInfo", postData, function (data) {
                if(data.totalUrl){
                    $("#allUrlRebate_customer").text("￥" + data.totalUrl.amount);
                }
                if(data.totalPull){
                    $("#allPullRebate_customer").text("￥" + data.totalPull.amount);
                }
                if(data.monthRebate){
                    $("#monthRebateSpan").text("￥" + data.monthRebate.amount);
                }

            })
        });

        function generateAllReport() {
            var form = $("#searchForm");
            var url="${ctx}/admin/store/delivery/excel?" +form.serialize()+"&start=0&limit=10000";
            window.open(url);
        }

        gotoUrlRebate=function(value){
            $("#username").val(value);
            var form = $("#searchForm");
            window.open("${ctx}/admin/bill/customer/rebateUrlBill/list?"+form.serialize());
            $("#username").val("");
        }

        gotoPullRebate=function(value){
            $("#username").val(value);
            var form = $("#searchForm");
            window.open("${ctx}/admin/bill/customer/rebatePullBill/list?"+form.serialize());
            $("#username").val("");
        }

        gotoMonthRebate=function(value){
            $("#username").val(value);
            var form = $("#searchForm");
            window.open("${ctx}/admin/statement/monthRebate/report?"+form.serialize());
            $("#username").val("");
        }

        var skipToBillModule=function(href){
            app.page.open({
                moduleId:'statements',
                href:href,
                reload: true
            })
        }

        function showChecked() {
            showCalendar();
        }
    });

    var enableMark = true ;
    function markCheck() {
        if(enableMark){
            enableMark =false ;
            var form = $("#searchForm");
            var postData = form.serializeArray();
            postData.push({name:"pageIndex", value: "0"});
            postData.push({name:"start", value: "0"});
            postData.push({name:"limit", value: "10000"});
            $.post("${ctx}/admin/store/delivery/markCheck",postData,function(data){
                enableMark =true ;
                if (data.result=="success") {
                    app.showSuccess(data.message);
                    search.reload();
                } else {
                    app.showError(data.message);
                }
            });
        }
    }

</script>
</body>
</html>