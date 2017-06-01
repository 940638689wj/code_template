<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script src="${staticPath}/admin/js/echarts.js"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
        <div class="row">
            <div class="control-group">
                <div class="controls control-row-auto ml0">
                    <label class="control-label control-label-auto mr30">退款总额：
                        <span class="red" id="totalAmt">￥0.00</span>
                    </label>
                    <label class="control-label control-label-auto mr30">退款总积分额：
                        <span class="red" id="totalScore">0</span>
                    </label>
                </div>
            </div>
        </div>
    </div>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="recyclebin"><a href="${ctx}/admin/sa/order/toOrderRecycle">订单回收站</a></div>
            <div class="search-bar">
                <input type="text" placeholder="订单号" class="control-text" id="short_cut_like_phone"/>
                <button type="button" onclick="searchOrders()"><i class="icon-search"></i></button>
            </div>

            <div class="search-content">
                <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form">
                    <div class="row">
                        <div class="control-group span10" style="  margin-bottom: 10px;">
                            <label class="control-label">下单时间：</label>
                            <div class="controls bui-form-group " data-rules="{dateRange : true}">
                                <input name="beginTime" id="beginTime" data-tip="{text : '起始日期'}"
                                       class="input-small calendar control-text" type="text"><label>&nbsp;-&nbsp;</label>
                                <input name="endTime" id="endTime" class="input-small calendar control-text" type="text">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">来自终端：</label>
                            <div class="controls">
                                <select name="originPlatformCd" id="originPlatformCd">
                                    <option value="">全部</option>
                                    <option value="1">手机端</option>
                                    <option value="0">PC端</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">
                                <select id="keyWordType" name="keyWordType" style="width:100px;">
                                    <option value="1">订单号</option>
                                    <option value="2">收货人</option>
                                    <option value="3">收货人电话</option>
                                    <option value="4">会员</option>
                                </select>
                                </label>
                        <div class="controls">
                            <input type="text" name="keyWords" class="control-text" id="keyWords">
                        </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="form-actions offset3">
                            <button type="submit" id="btnSearch" class="button button-primary">搜索
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">


</script>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '退款单', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '订单号', dataIndex: 'orderNumber', width: 160},
            {title: '退款完成时间', dataIndex: 'completeTime', width: 160, renderer: BUI.Grid.Format.datetimeRenderer},
            {title: '操作人', dataIndex: 'adminUserName', width: 120},
            {
                title: '退款金额', dataIndex: 'amount', width: 160, renderer: function (value, rowObj) {
                if(value){
                    return "￥"+value;
                }else{
                    return value;
                }
            }
            },
            {title: '包含积分', dataIndex: 'consume', width: 200, renderer: function (value, rowObj) {
                return value;
            }},
            {title: '支付方式', dataIndex: 'orderPayWay', width: 200},
            {title: '会员账号', dataIndex: 'loginName', width: 160}
        ];

        var store = Search.createStore('${ctx}/admin/sa/refundStatistics/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small', handler: generateAllReport}
                ]
            },
            plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select',
            btnId: "btnSearch"
        });
        var grid = search.get('grid');
        grid.on('aftershow', function (ev) {
            getTotal();
        });
    });

    /**
     * 右上角搜索框
     */
    $(function(){
        //点击 右上角搜索框
        var mask;
        $('.title-bar-side .search-bar input').on('focus',function(){
            var $this = $(this);
            var searchCon = $this.closest('.title-bar-side').find('.search-content');
            $this.addClass("focused");
            if(!mask)
                mask = $('<div></div>').css({
                    'position':'absolute',
                    'left':0,
                    'top':0,
                    'width':'100%',
                    'height':'100%'
                }).appendTo(document.body);
            searchCon.show(400);
            mask.on('click',function(){
                $this.removeClass("focused");
                mask.remove();
                mask = null;
                searchCon.hide(400);
            });
        });

        $("#short_promotionName").on('keyup',function(event){
            $("#promotionName").val($("#short_promotionName").val());
            if(event.keyCode ==13){
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#short_promotionName").on('click',function(){
            $("#promotionName").val($("#short_promotionName").val());
        });
        $("#promotionName").on('keyup',function(event){
            $("#short_promotionName").val($("#promotionName").val());
            if(event.keyCode ==13){
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#promotionName").on('click',function(){
            $("#short_promotionName").val($("#promotionName").val());
        });
    });

    /**
     * 获取总数
     */
    function getTotal() {
        var beginTime = $("#beginTime").val();
        var endTime = $("#endTime").val();
        var originPlatformCd = $("#originPlatformCd").val();
        var keyWordType = $("#keyWordType").val();
        var keyWords = $("#keyWords").val();
        $.ajax({
            url: '${ctx}/admin/sa/refundStatistics/getTotal',
            dataType: 'json',
            method: 'get',
            data: {
                beginTime: beginTime,
                endTime: endTime,
                originPlatformCd: originPlatformCd,
                keyWordType:keyWordType,
                keyWords:keyWords
            },
            success: function (data) {
                $("#totalAmt").html('￥' + (data.amount).toFixed(2));
                $("#totalScore").html(data.consume);
            }
        })
    }

    /**
     * 导出
     */
    function generateAllReport() {
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/sa/refundStatistics/exportRefundStatistics?"+ params;
        BUI.Message.Alert("导出成功!");
    }

    /**
     *  点击右上角搜索图标，触发搜索事件
     */
    function searchOrders() {
        $('#btnSearch').click();
    }

</script>
</body>
</html>  