<#assign ctx = request.contextPath>
<#assign  mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")/>
<#assign  pcUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getPcUrl()?default("")/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <div id="tab1"></div>
        <div class="title-bar-side">
            <div class="search-bar">
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input name="orderBy" value="articleCreateTime desc" type="hidden"/>
                </form>
            </div>
        </div>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'文章列表',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'articleId',dataIndex:'articleId',width:50, visible:false},
            {title:'文章标题',dataIndex:'articleTitle',width:'30%', renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'文章分类',dataIndex:'articleTypeName',width:'8%'},
            {title:'是否发布',dataIndex:'articleIsPublication',width:'5%',renderer: function(value,rowObj){
                        if(value){
                            return "已发布";
                        }else{
                            return "未发布";
                        }
            }},
            {title:'手机端访问地址',dataIndex:'articleId',width:'20%',renderer : function(value,rowObj){
            	 var str =   "<a href='${mobileUrl!}/article/"+value+".html" +"' target='_blank'>${mobileUrl!}/article/"+value+".html"+"</a>";
                        return str;
             }},
             {title:'PC端访问地址',dataIndex:'articleId',width:'20%',renderer : function(value,rowObj){
            	 var str =   "<a href='${pcUrl!}/article/"+value+".html" +"' target='_blank'>${pcUrl!}/article/"+value+".html"+"</a>";
                        return str;
             }},
             {title:'创建日期',dataIndex:'articleCreateTime',width:'10%', renderer: BUI.Grid.Format.datetimeRenderer},
            {title:'操作',dataIndex:'articleId',width:'8%',renderer : function(value,rowObj){
                        var editStr="";
                            editStr+= Search.createLink({
                                text: '编辑',
                                href: '/admin/sa/decorate/article/edit?articleId='+rowObj.articleId
                            });
<@securityAuthorize ifAnyGranted="delete">
                            editStr=editStr+'<a href="#" onclick="conformCancel(\''+value+'\')" >删除</a>&nbsp;';
</@securityAuthorize>
                        return editStr;
                    }}
        ];
        var store = Search.createStore('/admin/sa/decorate/article/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    	{text : '新建',btnCls : 'button button-small button-primary',handler:addFunction}
                  
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
               id:'articleAdd',
               href:'/admin/sa/decorate/article/add'
            });
        }
		conformCancel=function(value){
            BUI.Message.Confirm('确认要删除该条目吗？',function(){
                $.ajax({
                    url: "/admin/sa/decorate/article/"+value+"?status=Cancel",
                    type:"get",
                    dataType: "text",
                    success: function(data){
                        if(data=="success"){
                            search.load();
                        }else{

                            alert("删除失败");
                        }
                    }
                });
            },'question');
        }
    });
</script>

</body>
</html> 