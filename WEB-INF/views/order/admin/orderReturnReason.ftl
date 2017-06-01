<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
	<script src="${staticPath}/js/printOrder.js"></script>
</head>
<body>
    <div class="container">
    <div class="title-bar">
        <div id="tab">
        </div>
		
		<div class="content-body">
			<div id="grid"></div>
		</div>
		
		
		<div id="content" class="hide">
			<form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/order/editReturnInfo" method="post">
             <div class="control-group">
              <label class="control-label">排序值：</label>
                <div class="controls">
				  <input type="text" name="displayID" id="displayID" data-rules="{required:true}"/>
             </div>
              </div>
              
              <div class="control-group">
              <label class="control-label">退换货原因：</label>
                <div class="controls">
                 <textarea class="input-large" type="text" name="codeCnName" id="codeCnName" ></textarea>
             </div>
              </div>
			</form>
		</div>
	</div>	
<script type="text/javascript">
var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'退款原因管理',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
  	 BUI.use('common/search',function (Search) {
		 editing = new BUI.Grid.Plugins.DialogEditing({
		        contentId : 'content', //设置隐藏的Dialog内容
		        autoSave : true, //添加数据或者修改数据时，自动保存
		       // triggerCls : 'btn-edit',
		        editor : {
		        	title : '新建列表',
		            width : 580,
		            height :300
		        }
		      }),     
		 columns = [
		                {title : '退货原因',dataIndex : 'codeCnName',width:"200px"},
		 		        {title : '排序值',dataIndex : 'displayID',width:"100px"},
		 		        
		 		        {title : '操作',dataIndex : '',width:"150px" ,renderer : function(value,obj){
		                	  var str = '';
			      	            str +=  '<span class="grid-command btn-edit" title="编辑">编辑</span>';
								<@securityAuthorize ifAnyGranted="delete">
			      	      		str +=  '<span class="grid-command btn-del" title="删除">删除</span>';
								</@securityAuthorize>
			      	            return str ;
			      	          }},
		 		    ],
		        
		      store = Search.createStore('${ctx}/admin/sa/order/reasonInfo',{
		        proxy : {
		          save : { //也可以是一个字符串，那么增删改，都会往那么路径提交数据，同时附加参数saveType
		            updateUrl : '${ctx }/admin/class/edit',
		            delUrl : '${ctx }/admin/class/delete',
		          }/*,
		          method : 'POST'*/
		        },
		        pageSize : 15,
		        autoSync : true //保存数据后，自动更新
		      }),
		      
		      gridCfg = Search.createGridCfg(columns,{
		    	width:'100%',
				height: getContentHeight(),    
		        tbar : {
		          items : [
		            {text : '新建',btnCls : 'button',handler:addFunction},
		          ]
		        },
		        plugins : [editing,BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.AutoFit] // 插件形式引入多选表格
		      });
		
		    var  search = new Search({
		        store : store,
		        gridCfg : gridCfg
		      }),
		      grid = search.get('grid');
		
		    function addFunction(){
		      window.location.href='${ctx}/admin/sa/order/toEditReturnInfo';
		    }
		    
		    function delItems(codeId){
		      if(codeId){
		        BUI.Message.Confirm('确认要删除吗？',function(){
		           $.ajax({
					url : '${ctx}/admin/sa/order/delReturnInfo',
					dataType : 'json',
					type : 'POST',
					data : {codeId : codeId },
					success : function (data){
						if(data){
							BUI.Message.Alert("删除成功");
							window.location.href='${ctx }/admin/sa/order/orderReturnReasonList';
						}
					}
				});
		        },'question');
		      }
		    }
		    
		    grid.on('cellclick',function(ev){
		      var sender = $(ev.domTarget); //点击的Dom
		        var record = ev.record;
		      
		      if(sender.hasClass('btn-del')){
		             var record = ev.record;
			        delItems(record.codeId);
			      }
		      if(sender.hasClass('btn-edit')){//编辑
			        var record = ev.record;
			        editItems(record.codeId);
			      }
		    });
		    function editItems(id){
		        window.location.href='${ctx}/admin/sa/order/toEditReturnInfo?codeId='+id;
	        }
		  });
</script>
</body>
</html>  