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
                <input type="text" class="control-text" name="like_name" placeholder="众筹名称">
                <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                <button onclick="addFunction()" class="button button-primary">新建众筹</button>
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
            {text:'众筹列表',value:'0'},
            {text:'过期众筹列表',value:'1'},
            {text:'禁用众筹列表',value:'2'}
        ]
    });
    tab.setSelected(tab.getItemAt(${status?default(0)}));
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="0"){
            window.location.href = "/admin/sa/promotion/crowdFund/list?status=0";
        }else if(item.get('value')=="1"){
            window.location.href = "/admin/sa/promotion/crowdFund/list?status=1";
        }else{
            window.location.href = "/admin/sa/promotion/crowdFund/list?status=2";
        }
    });

	var store;
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'众筹编号',dataIndex:'promotionId',width:80},
            {title:'众筹名称',dataIndex:'promotionName',width:150, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'众筹金额',dataIndex:'crowdFundPerAmt',width:100},
            {title:'众筹最大限制',dataIndex:'personalJoinLimit', width:100},
            {title:'众筹起始时间',dataIndex:'enableStartTime',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title:'众筹结束时间',dataIndex:'enableEndTime',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title:'众筹状态',dataIndex:'statusCd',width:140,renderer:function(val, rowObj){
                if(val != null && val == 0){
                    return "禁用";
                } else {
                    return "启用";
                }
            }},
            {title:'操作',dataIndex:'',width:100,renderer : function(value,rowObj){
                var str = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/promotion/crowdFund/edit?promotionId=' + rowObj.promotionId
                });
<@securityAuthorize ifAnyGranted="delete">
                str += '&nbsp;<a href="javascript:del(' + rowObj.promotionId + ');">删除</a>';
</@securityAuthorize>
                return str;
            }}
        ];
        store = Search.createStore('${ctx}/admin/sa/promotion/crowdFund/grid_json?status=${status?default(1)}',{pageSize:15});
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
            href:'${ctx}/admin/sa/promotion/crowdFund/edit'
        });
    }
    function del(id) {
    	BUI.Message.Confirm('确认删除这条活动？',function(){
            $.post('${ctx}/admin/sa/promotion/crowdFund/del',{'promotionId':id},function(data) {
            	if(data && data.result == 'success') {
            		app.showSuccess('删除成功！');
            		store.load();
            	} else if(data.message){
                    app.showError(data.message);
                }
            },'json');
        },'question');
    }
</script>

</body>
</html>