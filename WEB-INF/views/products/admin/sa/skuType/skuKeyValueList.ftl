<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <ul class="breadcrumb">
            <li><a href="list">普通规格</a> <span class="divider">&gt;&gt;</span></li>
            <li class="active">${(skuType.skuTypeDesc)!?html}</li>
        </ul>
    </div>

    <div class="content-top"></div>

    <div class="content-body">
        <form id="searchForm" class="form-horizontal span24">
            <input name="skuTypeId" value="${(skuType.skuTypeId)!}" type="hidden">
        </form>

        <div id="grid"></div>
    </div>
</div>
<div id="content" class="hide">
    <form id="J_Form" class="form-horizontal" action="#">
        <input type="hidden" name="skuKey" id="skuKey" value="">
        <input type="hidden" name="skuTypeId" id="skuTypeId" value="${(skuType.skuTypeId)!}">
        <div class="row">
            <div class="control-group">
                <label class="control-label" style="width: 60px;"><s>*</s>规格</label>
                <div class="controls">
                    <input name="skuValue" id="skuValue" type="text" data-rules="{required:true}" class="input-normal control-text">
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group">
                <label class="control-label" style="width: 60px;"><s>*</s>排序值</label>
                <div class="controls">
                    <input name="displayId" id="displayId" type="text" data-rules="{required:true,min:0,number:true}" class="input-normal control-text">
                </div>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript">
    var  search;
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'规格项ID',dataIndex:'skuType.skuTypeId',width:80, visible : false},
            {title:'编号',dataIndex:'skuKey',width:80},
            {title:'名称',dataIndex:'skuValue',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'排序值',dataIndex:'displayId',width:80},
            {title:'操作',dataIndex:'',width:160,renderer : function(value,rowObj){
                var editStr ="";
                    editStr+= '<a href=\'javascript:addFunction(\"' + rowObj.skuValue + '\",\"' + rowObj.displayId + '\",\"' + rowObj.skuKey + '\")\'>编辑  </a>';
                    editStr+= '<a href=\'javascript:deleteSkuKeyValue(' + rowObj.skuKey + ')\'>删除</a>&nbsp;';
                return editStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/skuType/grid_json2',{pageSize:999});
        var gridCfg = Search.createGridCfg(columns,{
            width: '100%',
            height: getContentHeight(),
                tbar : {
                    items : [
                        {text : '新建',btnCls : 'button button-small button-primary',handler:addFunction}
                    ]
                }
        });

        search = new Search({
			store : store,
			gridCfg : gridCfg
		}),
		grid = search.get('grid');
    });

    //新增、修改-弹出框口
    var dialog;
    var Overlay = BUI.Overlay
    dialog = new Overlay.Dialog({
        title:'',
        width:300,
        //配置DOM容器的编号
        contentId:'content',
        triggerCls : 'btn-edit', //触发显示Dialog的样式
        success:function () {

			var skuValue=$('#skuValue').val();
			var displayId=$('#displayId').val();
			if($.trim(skuValue)==''){
                alert('规格不能为空!');
                return ;
			}
			if($.trim(displayId)==''){
                alert('排序值不能为空!');
                return ;
			}

            if(!$.isNumeric($('#displayId').val()))
			{
				alert('排序值不是有效数字!');
				return ;
			}

            $.ajax({
                url : '${ctx}/admin/sa/skuType/skuKeyValue/update',
                dataType : 'json',
                data : {'skuTypeId':$('#skuTypeId').val(),
                		'skuKey':$('#skuKey').val(),
						'skuValue':skuValue,
						'displayId':displayId},
                success : function(data){
                    if(data.result == "success"){ //编辑、新建成功
                        dialog.close(); //隐藏弹出框
                        window.location.href="${ctx}/admin/sa/skuType/skuKeyValueList?skuTypeId="+${(skuType.skuTypeId)!};
                    }else{ //编辑失败失败
                        var msg = data.message;
                        BUI.Message.Alert('错误原因:' + msg);
                    }
                }
            });
        }
    });

    function addFunction(skuValue,displayId,skuKey){
		if(skuValue!=undefined && skuValue!='' &&
				displayId!=undefined && displayId!='' &&
				skuKey!=undefined && skuKey!='')
		{
			$('#skuValue').val(skuValue);
			$('#displayId').val(displayId);
			$('#skuKey').val(skuKey);
		}else{
            $('#skuValue').val('');
            $('#displayId').val('');
		}

        dialog.show();
    }
    function deleteSkuKeyValue(id){
        if(!id){
            return;
        }
        BUI.Message.Confirm('确定要删除此规格值吗?',function(){
            $.ajax({
                url : '${ctx}/admin/sa/skuType/deleteSkuKeyValue/'+id,
                dataType : 'json',
                type: 'POST',
                success : function(data){
                    if(data.result == "success"){
                        app.showSuccess("删除成功！");
                        search.load();
                    }else{
                        app.showError(data.message);
                    }
                }
            });
        },'question');
    }
</script>


</body>
</html>