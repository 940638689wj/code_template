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
     <div id="bindConcent" class="hide">
		   	<form id="J_Form" class="form-horizontal" action="" method="post">
             <input type="hidden" id="expressId"/>
            <div class="control-group">
              <label class="control-label">快递公司：</label>
               <div class="controls">
               <select id="valueId">
                            <#if expressValues?has_content>
                            <#list expressValues as e>
                            <option value="${e.valueId!}">${e.valueLabel!}</option>
                            </#list>
                            </#if>
                  </select>
              </div>
            </div>
                <div class="control-group">
                    <label class="control-label">默认布局：</label>
                    <div class="controls">
                        <select id="printId">
                        <#if systemTypes?has_content>
                            <#list systemTypes as s>
                                <option value="${s.printId!}">${s.printName!}</option>
                            </#list>
                        </#if>
                        </select>
                    </div>
                </div>
                <div class="control-group">
                    <label class="control-label">模板名称：</label>
                    <div class="controls">
                       <input type="text" name="printName" data-rules="{required : true}" class="input-normal control-text">
                    </div>
                </div>

            	</form>
		   </div>
    
    
    <div class="title-bar">
        <div id="tab">
        </div>
		
		<div class="content-body">
			<div id="grid"></div>
		</div>
		
	</div>
<script type="text/javascript">	
      var dialog;
	  BUI.use(['bui/overlay','bui/form'],function(Overlay,Form){
    
      var form = new Form.Form({
        srcNode : '#J_Form'
      }).render()
      
           dialog = new Overlay.Dialog({
            title:'新建模板',
            width:450,
            height:300,
            //配置DOM容器的编号
            contentId:'bindConcent',
            success:function () {
            var printName = $("input[name='printName']").val();
                if(printName == ''){
                 BUI.Message.Alert("请输入名称！");
                    return false;
                }
                window.location.href='${ctx}/admin/sa/order/express/toAddOrEditExpressBill?printName='+printName
                +'&valueId=' + $('#valueId').val()
                +'&printId=' + $('#printId').val()
                ;
                
             },
            });
          });
     
    
      
</script>     
<script type="text/javascript">
var Tab = BUI.Tab;
var grid;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
        	{text:'快递模板',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
  	 BUI.use('common/search',function (Search) {
		 columns = [
		                {title : '模板名称',dataIndex : 'printName',width:"200px"},
		 		        {title : '快递公司',dataIndex : 'valueLabel',width:"100px"},
		 		        {title : '类型',dataIndex : '',width:"150px" ,renderer : function(value,rowObj){
                            return "默认";
                        }},
                        {title : '大小',dataIndex : 'sourceSize',width:"150px" },

		 		        {title:'操作',dataIndex:'',width:300,renderer : function(value,rowObj){
                        var editStr =""
                            editStr = Search.createLink({
                                text: '编辑',
                                href: '${ctx}/admin/sa/order/express/toAddOrEditExpressBill?id='+rowObj.printId
                            });
                       
                        var result =  ""
                        result += editStr;
                        if(rowObj.formateType != "default"){
<@securityAuthorize ifAnyGranted="delete">
                        result +=  '&nbsp;&nbsp;<a href=\'javascript:deleteValue('+rowObj.printId+');\'>删除</a>';
</@securityAuthorize>
                        }
                        return result;
                    }},
		 		    ],
		        
		      store = Search.createStore('${ctx}/admin/sa/order/express/getExpressBillPage',{
		       
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
		        plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.AutoFit] // 插件形式引入多选表格
		      });
		
		    var  search = new Search({
		        store : store,
		        gridCfg : gridCfg
		      }),
		      grid = search.get('grid');
		
		    function addFunction(){
		     // window.location.href='${ctx}/admin/sa/order/express/toEditExpressInfo';
                dialog.show();
		    }

		    
		  });
  
		 function setTemplate(id){
		       $("#expressId").val(id);
               dialog.show();
              }    
       
         function deleteValue(id){
          BUI.Message.Confirm('确认要删除吗！',function(){
              $.ajax({
              url:"${ctx}/admin/sa/order/express/delete",
              type:"post",
              datatype:"json",
              data:{"printId":id},
              success:function(data){
                if(data){
                 BUI.Message.Alert("操作成功!",function(){
                 location.reload();
                });
                }
              
              }
              
              });
          
          
          
          });
         
         }
       
       
       
       
       
         function cancleTemplate(id){
           BUI.Message.Confirm('确认要取消关联吗！',function(){
              $.ajax({
              url:"${ctx}/admin/sa/order/express/enBindTemplate",
              type:"post",
              datatype:"json",
              data:{"expressId":id},
              success:function(data){
                if(data){
                 BUI.Message.Alert("操作成功!",function(){
                 location.reload();
                });
                }else{
                 BUI.Message.Alert("无需取消!",function(){
                 location.reload();
                 });
                }
              
              }
              
              });
             
              
              });
             }  
              
</script>
</body>
</html>  