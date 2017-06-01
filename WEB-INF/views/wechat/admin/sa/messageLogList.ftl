<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
 <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
	<link rel="stylesheet" href="${staticPath}/admin/css/dpl.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/bui.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/main.css" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/page.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>

    <link rel="stylesheet" href="${staticPath}/admin/css/emotion.css" type="text/css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/weixin/emotion.js"></script>
</head>
<body>

<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="bui-tab nav-tabs" aria-disabled="false" aria-pressed="false">
                <li class="bui-tab-item bui-tab-item-selected" aria-disabled="false" aria-pressed="false">
                    <span class="bui-tab-item-text">消息管理</span>
                </li>
            </ul>
        </div>
    </div>

    <div class="content-body">
        <form id="searchForm" class="form-horizontal search-form" style="display: none;">
            <input name="sort" value="messageTime desc" type="hidden"/>
            <input name="eq_msgFlag" value="0" type="hidden"/>
        </form>
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title : '头像',dataIndex :'headImgUrl', width:100,renderer : function(value,rowObj){
                var url=value;
                if(url == null||url=="")
                    url="${staticPath}/admin/images/defaultHeadImg.jpg";
                return '<img src="'+url+'" style="width:70px;height:80px;" />';
            }},  
            {title : '昵称',dataIndex :'nickName',width:100},
            {title : '消息内容',dataIndex :'content',width:'100%',renderer : function(value,rowObj){
            	if(rowObj.msgType && rowObj.msgType == "image"){
                    var picUrl = rowObj.picUrl;
                    var resultString = '<a href="'+picUrl+'" target="_blank"><img src="'+picUrl+'" style="width:70px;height:80px;" /></a>';
                    resultString = resultString + '&nbsp;&nbsp;<a href="'+picUrl+'" target="_blank">图片</a>';

                    return resultString;
                }else{
                    return value;
                }
            	
            	
            
            }},
            {title : '接收消息时间',dataIndex :'messageTime',width:200,renderer:BUI.Grid.Format.datetimeRenderer},
            {title : '操作',dataIndex :'userId',width:200,renderer : function(value,rowObj){
                var historyStr;
                    historyStr= Search.createLink({
                        text: '查看往来消息',
                        href: '/admin/sa/wechat/history?id='+value
                    });
                return historyStr;
            }}
        ];
        //var store = Search.createStore('grid_json');
        var store = Search.createStore('${ctx}/admin/sa/wechat/message_grid_json',{pageSize:15});
        
        var gridCfg = Search.createGridCfg(columns,{
            width: '100%',
            height: getContentHeight()
        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
</script>
<body>
</html>