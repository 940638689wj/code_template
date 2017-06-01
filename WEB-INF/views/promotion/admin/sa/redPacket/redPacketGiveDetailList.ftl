<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item" onclick="redPacketList();" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">红包列表</span>
                </li>
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" onclick="redPacketGiveOutDetailList();" aria-pressed="false">
                    <span class="bui-tab-item-text">红包发放明细</span>
                </li>
                <li class="bui-tab-item" aria-disabled="false" onclick="redPacketUseDetailList();" aria-pressed="false">
                    <span class="bui-tab-item-text">红包使用明细</span>
                </li>
            </ul>
            
        </div>
    </div>
	<form id="searchForm" class="form-horizontal search-form">
		<div class="row">
            <div class="control-group">
                <div class="bui-form-group controls" data-rules="{dateRange : [true,'截至时间不能超过起始时间']}">
                        <input type="text" class="calendar control-text" name="startTakeTime">
                    <span>至</span>
                        <input type="text" class="calendar control-text" name="endtTakeTime">
                </div>
                <button type="submit" class="button button-primary" id="btnSearch">查询</button>
                <button class="button button-primary" onclick="redPackExport();">导出</button>
            </div>
	        
        </div>
        
	</form>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var basicFormDialog = null;
    var search = null;

    var Overlay = BUI.Overlay

    function redPacketList(){
        window.location.href="${ctx}/admin/sa/promotion/redPacket/list";
    }
    function redPacketGiveOutDetailList() {
    	window.location.href="${ctx}/admin/sa/promotion/redPacket/giveDetail/list";
    }
    function redPacketUseDetailList(){
        window.location.href="${ctx}/admin/sa/promotion/redPacket/useDetail/list";
    }
    function redPackExport() {
    	window.open('${ctx}/admin/sa/promotion/redPacket/giveDetail/export?' + $('#searchForm').serialize());
    }
    
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'红包编号',dataIndex:'promotionId',width:200},
            {title:'红包名称',dataIndex:'promotionName',width:200},
            {title:'领取者手机号',dataIndex:'phone',width:200,renderer : function(value, rowObj){
            	var str = "";
                str = "<a href='${ctx}/admin/sa/user/toUserDetailIndex/"+rowObj.userId+"'>"+value+"</a>";
                return str;
            }},
            {title:'发放时间',dataIndex:'takeTime',width:300,renderer:BUI.Grid.Format.datetimeRenderer}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/redPacket/giveDetail/grid_json');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight()
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
        
    });

    $(function(){
        //点击 右上角搜索框
        var mask;
        $('.title-bar-side .search-bar input').on('focus',function(){
            var $this = $(this);
            $this.addClass("focused");
            if(!mask)
                mask = $('<div></div>').css({
                    'position':'absolute',
                    'left':0,
                    'top':0,
                    'width':'100%',
                    'height':'100%'
                }).appendTo(document.body);
            mask.on('click',function(){
                $this.removeClass("focused");
                mask.remove();
                mask = null;
            });
        });
    })
	
	
</script>
</body>
</html>