<#assign ctx = request.contextPath>
<#assign  mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")/>
<!DOCTYPE HTML>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
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
                	<input type="hidden" id="receivedCd" name="receivedCd" value="1">
                    <input name="sort" value="createdTime desc" type="hidden"/>
                </form>
            </div>
        </div>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var search;
    var grid;
    var Overlay = BUI.Overlay;
    var setStoreTypeDialog;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'顾客',value:'0'},
            {text:'门店',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    
	tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	        	$("#receivedCd").val(1);
	        }
	        if(item.get('value')=="1"){
	        	$("#receivedCd").val(2);
	        }
	        search.load({start:0});
	    });

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'Id',dataIndex:'id',width:50, visible:false},
            {title:'标题',dataIndex:'title',width:200},
            {title:'流量次数',dataIndex:'viewTimes',width:150},
            {title:'是否重要',dataIndex:'isImportant',width:150,renderer : function(value, rowObj){
            	var isImportantName ="";
            	if(value==1){
            		isImportantName = "是";
            	}else{
            		isImportantName = "否";
            	}
            	return isImportantName;
            }},
            {title:'创建日期',dataIndex:'createTime',width:150, renderer: BUI.Grid.Format.datetimeRenderer},
            {title:'链接',dataIndex:'noticeUrl',width:300,
            	renderer : function(value,rowObj){
            		 var str =   "<a href='${mobileUrl!}/notice/"+rowObj.id+".html" +"' target='_blank'>${mobileUrl!}/notice/"+rowObj.id+".html"+"</a>";
            		return str;
            	}
            },
            {title:'操作',dataIndex:'',width:150,renderer : function(value,rowObj){
                var editStr="";
                    editStr += Search.createLink({
                        text: '编辑',
                        href: '${ctx}/admin/sa/decorate/systemNotice/turnToEditor?id='+rowObj.id
                    });
                    editStr+= '<span class="grid-command btn-del">删除</span>';
                return editStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/decorate/systemNotice/querySystemNotice',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新建',btnCls : 'button button-small button-primary',
                    	handler:function(){
                    		location.href='${ctx}/admin/sa/decorate/systemNotice/turnToEditor';
                    	}
                    }
                ]
            }

        });

        search = new Search({
        	gridId : 'grid',
            store : store,
            gridCfg : gridCfg,
            formId : 'searchForm'
        });
        grid = search.get('grid');

		<#--
        function addFunction(){
            app.page.open({
                id:'#',
                href:'adminUserDefined/page/edit'
            });
        }
        -->

        grid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                delItem(record.id);
            }
        });

        function delItem(id){
            BUI.Message.Confirm('确认要删除该记录么？',function(){
                $.ajax({
                    url : '${ctx}/admin/sa/decorate/systemNotice/deleteSystemNotice',
                    dataType : 'json',
                    type: 'POST',
                    data : {id : id},
                    success : function(data){
                        if(data.result == "success"){ //删除成功
                            search.load();
                            BUI.Message.Alert('删除成功！');
                        }else{ //删除失败
                            BUI.Message.Alert('删除失败！');
                        }
                    }
                });
            },'question');
        }
    });
</script>

</body>
</html> 