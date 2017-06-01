<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
    	<div id="tab"></div>
    </div>

    <div class="content-body">
        <div id="grid"></div>
    </div>
    
    <div id="categoryType" style="display: none">
        <form class="form-horizontal" >
            <div  class="form-content" >
            	<input type="hidden" id="categoryTypeId"  name="categoryTypeId" value=""/>
                <div class="control-group">
                    <label class="control-label"><s>*</s>系列类型名称：</label>
                    <div class="controls">
                        <input value="" name="categoryTypeName" data-rules="{required:true,regexp:/^([\u4e00-\u9fa5]|[A-Za-z]|[0-9]){1,14}$/}" data-messages="{regexp:'请输入正确的名称！'}" id="categoryTypeName" class="input-normal control-text">
                    </div>
                </div>
                <div class="control-group">
                	<label class="control-label"><s>*</s>启用状态：</label>
                    <div class="controls">
                        <label class="radio">
                            <input type="radio" name="categoryStatusCd" value="1" id="active"/>启用
                        </label>
                        &nbsp;&nbsp;
                        <label class="radio">
                            <input type="radio" name="categoryStatusCd" value="0" id="notActive"/>禁用
                        </label>
                    </div>
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
            {text:'系列类型',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'系列类型名称',dataIndex:'categoryTypeName',width:100, renderer:function(value, rowObj){
                var str = "";
                str = '<a href=\'javascript:editCategoryType(\"'+rowObj.categoryTypeId+'\",\"'+rowObj.categoryStatusCd+'\",\"'+rowObj.categoryTypeName+'\")\'>'+value+'</a>';	
                return str;
            }},
            {title:'系列类型状态',dataIndex:'categoryStatusCd',width:150, renderer:function(value, rowObj){
            	var statusName = "";
            	if(value==1){
            		statusName = "启用";
            	}else{
            		statusName = "禁用";
            	}
                return statusName;
            }},
            {title:'创建时间',dataIndex:'createTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer}
        ];
        var store = Search.createStore('${ctx}/admin/sa/category/type/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新建系列类型',btnCls : 'button button-small button-primary',handler:addCategoryType}
                ]
            }
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
    
    var Overlay = BUI.Overlay;
	dialog = new Overlay.Dialog({
	    title:'',
	    width:450,
	    height:280,
	    //配置DOM容器的编号
	    contentId:'categoryType',
	    success:function () {
	        var dialogObj = this;
	        var cdLen = $("input[name='categoryStatusCd']:checked");
	        if($('#categoryTypeName').val()== ""){
	            BUI.Message.Alert("请输入系列类型名称!");
	            return false;
	        }
			
			if(cdLen.length < 1){
				BUI.Message.Alert("请选择系列类型状态!");
	            return false;
			}
			
	        $.ajax({
	            url : '${ctx}/admin/sa/category/type/save',
	            dataType : 'json',
	            type: 'POST',
	            data : {categoryTypeName : $('#categoryTypeName').val(), categoryStatusCd : $("input[name='categoryStatusCd']:checked").val(), categoryTypeId : $("#categoryTypeId").val()},
	            success : function(data){
	                if(data){
	                	BUI.Message.Alert('该类型名称已存在！');
	                	return false;
	                }else if(data==0){
	                	dialogObj.close();
	                    BUI.Message.Alert('保存成功！');
	                    search.load();
	                }else{
	                    BUI.Message.Alert('保存失败！');
	                    return false;
	                }
	            }
	        });
    	}
	});
	
	// 新增系列类型
    function addCategoryType(){
    	$("#categoryTypeId").val("");
		$("#categoryTypeName").val("");
		var cdLen = $("input[name='categoryStatusCd']");
		for(var i = 0; i < cdLen.length; i++){
			$(cdLen[i]).attr("checked",false);
		}
		dialog.set('title','新建系列类型');
		
        dialog.show();
    }
    
	// 编辑系列类型
    function editCategoryType(categoryTypeId, categoryStatusCd, categoryTypeName){
		$("#categoryTypeId").val(categoryTypeId);
		$("#categoryTypeName").val(categoryTypeName);
		if(categoryStatusCd=="1"){
	        $('#active').attr("checked","checked");
	        $('#notActive').attr("checked",false);
	    }else{
	        $('#active').attr("checked",false);
	        $('#notActive').attr("checked","checked");
	    }
	    dialog.set('title','编辑系列类型');
	    
	    dialog.show();
    }
</script>
</body>
</html>