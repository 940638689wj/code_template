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
            <div class="row mb10">
                <div class="control-group">
                    <div class="controls control-row-auto ml0">
                    
                    <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                        <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                        <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                        <input type="text" id="endTime" name="endTime" class="calendar control-text">
                    </div>
                   
                       
                         <div class="pull-left">
                         	<label class="type">类型：</label>
                        	<select class="input-small bui-form-field-select bui-form-field" name="type" aria-disabled="false" aria-pressed="false">
								<option value="" selected="selected">全部</option>
								<option value="1" >签到</option>
								<option value="10" >会员注册</option>
								<option value="12" >会员完善资料</option>
								<option value="2" >订单消费</option>
								<option value="31" >订单取消</option>
								<option value="5" >管理员后台操作</option>
								<option value="8" >积分卡充值</option>
								<option value="53" >游戏花费</option>
								<option value="54" >游戏获得</option>
                        	</select>
                        </div>
                       		 <div class="pull-left">
                            	<input type="text" id="loginName" name="loginName" class="control-text" placeholder="会员账号">
                            	<button id="user_search" name="user_search" type="button" class="button button-primary ml">搜索 </button>
                            	<button id="export" type="button" class="button button-primary ml">导出</button>
                        </div>
              
                    </div>
                </div>
            </div>
            <div class="row">

            </div>
        </form>
    </div>
    <div class="content-top">
        <div id="grid"></div>
    </div>

</div>
<script>
	$(function(){
		var bTime=getCurrentMonth()[0];
		var eTime=getCurrentMonth()[1];
		$("#beginTime").attr("value",bTime);
		$("#endTime").attr("value",eTime);
	})
</script>

<script type="text/javascript">
    //导出
    $("#export").click(function () {
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/sa/userScoreAndConsume/exportUserScoreAndConsume?" + params;
        BUI.Message.Alert("导出成功");
    });
</script>

<script type="text/javascript">
    var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'nav-tabs',
        autoRender: true,
        children: [
            {text: '会员积分及消费查询', value: '0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
           
            {
                title: '积分日期', dataIndex: 'createTime', width: 200, renderer: function (value, rowObj) {
                //var str = '<a href="${ctx}/admin/sa / user / toUserDetailIndex / ' + rowObj.userId + '">' + value + '</a>';
                //return str;
                var date=new Date(value).Format("yyyy-MM-dd hh:mm:ss");
                return date;
            }
            },
            {
                title: '用户', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {
             	return value;
            }
            },
            {
                title: '渠道', dataIndex: 'codeCnName', width: 100, renderer: function (value, rowObj) {
                if(value==null){
                	value='';
                }
              	return value;
            }
            },
            {
                title: '消费金额', dataIndex: 'consumeBalance', width: 200, renderer: function (value, rowObj) {
                if(value==null){
                	value=0;
                }
                return value;
            }
            },
            {
                title: '本次获得积分', dataIndex: 'scoreIncome', width: 200, renderer: function (value, rowObj) {
                return value;;
            }
            },
             {
                title: '积分支出', dataIndex: 'scoreExpend', width: 200, renderer: function (value, rowObj) {
                return value;
            }
            }
        ];

        var store = Search.createStore('${ctx}/admin/sa/userScoreAndConsume/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns,
                {
                    width: '100%',
                    height: getContentHeight(),
                    // 底部工具栏
                    bbar: {
                        // pagingBar:表明包含分页栏
                        pagingBar: true
                    },
                    plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
                });

        var search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            formId: 'searchForm_select',
            btnId: 'user_search'
        });

        grid = search.get('grid');
        grid.render();
    });

//    // 初始化
//    $(function () {
//        var t = $(".container").find("li");
//        $(t).each(function (i, item) {
//            $(this).click(function () {
//                // 有颜色就删掉
//                $("li").removeClass('step-active');
//                // 改变颜色
//                $(this).addClass("step-active");
//                // 请求处理
//                var bTime;
//                var eTime;
//                if (this.id == "thisWeek") {
//                    bTime = getCurrentWeek()[0];
//                    eTime = getCurrentWeek()[1];
//                } else if (this.id == "lastWeek") {
//                    bTime = getPreviousWeek()[0];
//                    eTime = getPreviousWeek()[1];
//                } else if (this.id == "thisMonth") {
//                    bTime = getCurrentMonth()[0];
//                    eTime = getCurrentMonth()[1];
//                } else if (this.id == "lastMonth"){
//                    bTime = getPreviousMonth()[0];
//                    eTime = getPreviousMonth()[1];
//                }
//
//                $("#beginTime").attr("value", bTime);
//                $("#endTime").attr("value", eTime);
//                //refeshData(bTime,eTime);
//            });
//        });
//    });


</script>
</body>
</html>  