<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
        </div>
    </div>

    <div class="content-top">
        <form id="searchForm" class="form-horizontal search-form">
            <div class="row mb10">
                <input type="text" class="control-text" name="like_name" placeholder="预售名称">
                <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                <button onclick="addFunction()" class="button button-primary">新建预售</button>
            </div>
        </form>
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
            {text:'可用预售列表',value:'0'},
            {text:'过期预售列表',value:'1'},
            {text:'禁用预售列表',value:'2'}
        ]
    });
    tab.setSelected(tab.getItemAt(${status?default(0)}));
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="0"){
            window.location.href = "/admin/sa/promotion/reserveSale/list?status=0";
        }else if(item.get('value')=="1"){
            window.location.href = "/admin/sa/promotion/reserveSale/list?status=1";
        }else{
            window.location.href = "/admin/sa/promotion/reserveSale/list?status=2";
        }
    });

	var store;
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'预售编号',dataIndex:'promotionId',width:80},
            {title:'预售名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'预售描述',dataIndex:'promotionDesc',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'付定金起始时间',dataIndex:'enableStartTime',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title:'付定金结束时间',dataIndex:'allowPayRemainderStartTime',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title:'预售状态',dataIndex:'statusCd',width:140,renderer:function(val, rowObj){
                if(val != null && val == 0){
                    return "禁用";
                } else {
                    return "启用";
                }
            }},
            {title:'手机端预售地址',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
            	return "<a href=\"javascript:window.open(\'/m/preSale/detail/" + rowObj.promotionId + "')\">/m/preSale/detail/" + rowObj.promotionId + ".html</a>";
            }},
            {title:'PC端预售地址',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return "<a href=\"javascript:window.open(\'/preSale/detail/" + rowObj.promotionId + "')\">/preSale/detail/" + rowObj.promotionId + ".html</a>";
            }},
            {title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
                var str = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/promotion/reserveSale/edit?promotionId=' + rowObj.promotionId
                });
<@securityAuthorize ifAnyGranted="delete">
                str += '&nbsp;<a href="javascript:del(' + rowObj.promotionId + ');">删除</a>';
</@securityAuthorize>
                return str;
            }}
        ];
        store = Search.createStore('${ctx}/admin/sa/promotion/reserveSale/grid_json?status=${status?default(1)}',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
    function addFunction(){
        app.page.open({
            href:'${ctx}/admin/sa/promotion/reserveSale/edit'
        });
    }
    function del(id) {
    	BUI.Message.Confirm('确认删除这条活动？',function(){
            $.post('${ctx}/admin/sa/promotion/del',{'promotionId':id},function(data) {
            	if(data && data.result) {
            		app.showSuccess('删除成功！');
            		store.load();
            	}
            },'json');
        },'question');
    }
</script>

</body>
</html>