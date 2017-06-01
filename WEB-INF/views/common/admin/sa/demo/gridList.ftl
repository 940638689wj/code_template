<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">

    <div class="title-bar">
        <div id="tab"></div>
    </div>

    <div class="content-top">
        <form id="searchForm" class="form-horizontal span24">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls ml0" style="height: 40px;">
                        <input placeholder="手机号" name="phone" class="input-normal control-text">
                        &nbsp;&nbsp;
                        注册时间：
                        <input type="text" id="startDate" name="startDate" class="calendar control-text" value="">
                        <span class="mr5">至</span>
                        <input type="text" id="endDate" name="endDate" class="calendar control-text" value="">

                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <button id="btnSearch" class="button button-primary">查询</button>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="pull-left">
                    <label class="control-label control-label-auto mr30">总账户余额：<span id="totalBalance" class="red"></span></label>
                    <label class="control-label control-label-auto mr30">总积分：<span id="totalPoint" class="red"></span></label>
                </div>
            </div>
        </form>
    </div>

    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var grid=null;
    var search=null;

    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'会员列表',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'ID',dataIndex:'userId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='userId' value='" + value + "'>";
            }},
            {title:'会员标签',dataIndex:'userLabels',width:100, renderer : function(value, rowObj){
                if(null!=value){
                    return app.grid.format.encodeHTML(value);
                }else{
                    return '';
                }
            }},
            {title:'会员编号',dataIndex:'userId',width:100, renderer : function(value, rowObj){
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>'+value+'</a>';
                return editStr;
            }},
            {title:'用户名',dataIndex:'loginName',width:100, renderer : function(value, rowObj){
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>'+app.grid.format.encodeHTML(value)+'</a>';
                return editStr;
            }},
            {title:'姓名',dataIndex:'userName',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'昵称',dataIndex:'nickName',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'手机',dataIndex:'phone',width:100, renderer : function(value, rowObj){
                return value;
            }},
            {title:'注册平台',dataIndex:'registerPlatformText',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'消费总额',dataIndex:'totalConsumeAmt',width:100, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;}
            }},
            {title:'账户余额',dataIndex:'userBalance',width:100, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;}
            }},
            {title:'积分',dataIndex:'totalScore',width:70, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;};
            }},
            {title:'推广状态',dataIndex:'mstoreStatusCd',width:70, renderer : function(value, rowObj){
                if(value == 0){
                    return "否";
                }else if(value == 1){
                    return "是";
                }
                return "否";
            }},
            {title:'会员等级',dataIndex:'userLevelName',width:70, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'上级会员',dataIndex:'parentPhone',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'状态',dataIndex:'statusText',width:60, renderer : function(value, rowObj){
                return value;
            }},
            {title:'注册时间',dataIndex:'registerTime',width:140, renderer : function(value, rowObj){
                if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
            }},
            {title:'操作',dataIndex:'userId',width:140, renderer : function(value, rowObj){
                var content = "";
                if(rowObj.statusCd == 0){
                    content = "<a href='javascript:void(0)' onclick='updateUserStatus1("+value+")'>启用</a>";
                }else if(rowObj.statusCd == 1){
                    content = "<a href='javascript:void(0)' onclick='updateUserStatus0("+value+")'>冻结</a>";
                }

                content = content + "&nbsp;&nbsp;<a href='javascript:void(0)' onclick='deleteUser("+value+")'>删除</a>";

                return content;
            }}
        ];

        var store = Search.createStore('/admin/sa/user/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            // 插件形式引入多选表格
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar:{
                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                items:[
                ]
            }
            /*,bbar:{
                pagingBar:false
            }*/
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        grid = search.get('grid');
        grid.on("aftershow",function(){
            var form = search.get('form')
            var postData = form.serializeToObject();
            app.ajax("/admin/sa/common/demo/grid/list/sumInfo", postData, function (data) {
                var totalBalance = 0;
                var totalPoint = 0;
                if(data.result == "success"){
                    totalBalance = data.totalBalance;
                    totalPoint = data.totalPoint;
                }

                $("#totalBalance").text(totalBalance);
                $("#totalPoint").text(totalPoint);
            })
        });
    });
</script>
</body>
</html>