<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head> 
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
					<span class="bui-tab-item-text">关键词列表</span>
				</li>
			</ul>
		</div>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input name="sort" value="createTime desc" type="hidden"/>
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
</div>

<script type="text/javascript">
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'规则名称',dataIndex:'name',width:200},
            {title:'关键词',dataIndex:'keyword',width:400},
            {title:'匹配方式',dataIndex:'matchType',width:100,renderer : function(value,rowObj){
                if('fuzzy'==value)
                    return "模糊匹配";
                return "全匹配";
            }},
            {title:'创建时间',dataIndex:'createTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
                    {title:'回复内容',width:100,renderer : function(value,rowObj){
                        var keywordReplyContent = Search.createLink({
                            text: '查看/添加回复',
                            href: '/admin/sa/wechat/keywordReplyList?id='+rowObj.id
                        });

                        return keywordReplyContent;
                    }},
            {title:'操作',dataIndex:'id',width:100,renderer : function(value,rowObj){
                var editStr;
                editStr= Search.createLink({
                    text: '修改',
                    href: '/admin/sa/wechat/keywordForm?id='+rowObj.id
                });
<@securityAuthorize ifAnyGranted="delete">
                editStr += '<a href="#" onclick="conformCancel(\''+value+'\')" >删除</a>';
</@securityAuthorize>
                return editStr;
            }}
        ];
        //var store = Search.createStore('grid_json');
        var store = Search.createStore('${ctx}/admin/sa/wechat/keyword_grid_json',{pageSize:15});       
        var gridCfg = Search.createGridCfg(columns,{
            width: '100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '添加关键词',btnCls : 'button button-small button-primary',handler:addFunction}
                ]
            }
        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
        function addFunction(){
            app.page.open({
                href:'/admin/sa/wechat/keywordForm'
            });
        }

        conformCancel=function(value){
            BUI.Message.Confirm('确认要删除该条目吗？',function(){
                $.ajax({
                    url: "/admin/sa/wechat/keywordDelete?id="+value,
                    type:"get",
                    dataType: "text",
                    success: function(data){
                        if(data=="success"){
                            app.showSuccess("操作成功!");
                            search.load();
                        }else{
                            app.showError("删除失败！");
                        }
                    }
                });
            },'question');
        }
    });
</script>
<body>
</html>