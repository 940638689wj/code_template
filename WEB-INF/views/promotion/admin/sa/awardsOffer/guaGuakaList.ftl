<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
   <#include "${ctx}/includes/sa/header.ftl"/>
    <title>${gameName!}</title>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <div id="tab1"></div>
    </div>
    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input type="hidden" name="orderBy" value="id desc">
                    <input type="hidden" name="Award_Type_Cd" value="2">
                    <input name="type" value="${type!?default("type")}" type="text"/>
                </form>
            </div>
        </div>
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var store;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
    render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'可用幸运刮刮卡',value:'0'},
            {text:'过期幸运刮刮卡',value:'1'},
            {text:'禁用幸运刮刮卡',value:'2'}
        ]
    });
    <#if type??>
        <#if type=="type">
        	tab.setSelected(tab.getItemAt(0));
        <#elseif type=="expired">
        	tab.setSelected(tab.getItemAt(1));
        <#else>
        	tab.setSelected(tab.getItemAt(2));
        </#if>
    <#else>
    tab.setSelected(tab.getItemAt(0));
    </#if>
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="0"){
            window.location.href = "${ctx}/admin/sa/promotion/guaGuaka/list";
        }else if(item.get('value')=="1"){
            window.location.href = "${ctx}/admin/sa/promotion/guaGuaka/list?type=expired";
        }else{
            window.location.href = "${ctx}/admin/sa/promotion/guaGuaka/list?type=disable";
        }
    });
    
    BUI.use(['common/search', 'bui/tab'],function (Search, Tab) {
        var columns = [
            {title: '编号', dataIndex: 'id', width:80},
            {title: '名称', dataIndex: 'title', width:250, renderer: app.grid.format.encodeHTML},
            {title: '游戏地址', dataIndex:'id', width:150, renderer: function(value,rowObj){
            	 var link='<a href="/m/game/' + rowObj.id + '.html" target="_blank">/m/game/' + rowObj.id + '.html</a>';
                return link;
            }},
            {title: '开始时间',dataIndex:'startTime',width:150, renderer:BUI.Grid.Format.datetimeRenderer},
            {title: '结束时间',dataIndex:'endTime',width:150, renderer:BUI.Grid.Format.datetimeRenderer},
            {title: '状态',dataIndex:'status',width:100, renderer: function(value){
                return value == 1 ? "启用" : "禁用";
            }},
            {title: '操作', dataIndex: 'id', width:200, renderer: function(value,rowObj) {
                var str = "";
                str += '<a href="javascript:editFunction(' + rowObj.id + ');">编辑</a>';
<@securityAuthorize ifAnyGranted="delete">
                str += '&nbsp;&nbsp;<a href="javascript:del(' + rowObj.id + ');">删除</a>';
</@securityAuthorize>
                return str;
            }}
        ];
        store = Search.createStore('/admin/sa/promotion/guaGuaka/grid_json', { pageSize: 15 });
        var gridCfg = Search.createGridCfg(columns, {
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新建',btnCls : 'button button-small button-primary',handler:function(){
                        location.href='/admin/sa/promotion/guaGuaka/edit';
                    }}
                ]
            }

        });
        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });

    function editFunction(rowObjId){
        location.href = '/admin/sa/promotion/guaGuaka/edit?awardId=' + rowObjId;
    }

    function editPicture(rowObjId){
        location.href = 'editPicture?awardId=' + rowObjId;
    }
    <#--删除操作-->
    function del(id) {
    	BUI.Message.Confirm('确认删除这条游戏？',function(){
            $.post('${ctx}/admin/sa/promotion/guaGuaka/del',{'awardsId':id},function(data) {
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