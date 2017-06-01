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
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'自定义页面',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'Id',dataIndex:'id',width:50, visible:false},
            {title:'自定义标题',dataIndex:'title',width:'30%', renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'查看次数',dataIndex:'viewTimes',width:'8%'},
            {title:'手机端访问地址',dataIndex:'accessUrl',width:'20%',
            	renderer : function(value,rowObj){
            		 var str =   "<a href='${mobileUrl!}/view/"+rowObj.id+".html" +"' target='_blank'>${mobileUrl!}/view/"+rowObj.id+".html"+"</a>";
            		return str;
            	}
            },
            {title:'PC端访问地址',dataIndex:'accessUrl',width:'20%',
            	renderer : function(value,rowObj){
            		 var str =   "<a href='${pcUrl!}/view/"+rowObj.id+".html" +"' target='_blank'>${pcUrl!}/view/"+rowObj.id+".html"+"</a>";
            		return str;
            	}
            },
            {title:'创建时间',dataIndex:'createTime',width:'12%', renderer: BUI.Grid.Format.datetimeRenderer},
            {title:'操作',dataIndex:'',width:'11%',renderer : function(value,rowObj){
                var editStr="";
                    editStr += Search.createLink({
                        text: '编辑',
                        href: '${ctx}/admin/sa/decorate/customArea/turnToEditor?id='+rowObj.id
                    });
                    if(rowObj.id>10){
<@securityAuthorize ifAnyGranted="delete">
                    	editStr+= '<span class="grid-command btn-del">删除</span>';
</@securityAuthorize>
                    }
                return editStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/decorate/customArea/queryCustomArea',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新建',btnCls : 'button button-small button-primary',
                    	handler:function(){
                    		location.href='${ctx}/admin/sa/decorate/customArea/turnToEditor';
                    	}
                    }
                ]
            }

        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');

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
                    url : '${ctx}/admin/sa/decorate/customArea/deleteCustomArea',
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