<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="content-top">
        <form id="Score_Form" class="form-horizontal" action="${ctx}/admin/sa/user/rechargeScore" method="post">
            <input name="userId" type="hidden" value="${(userInfoDTO.userId)!?html}"/>
            <div class="form-content mb0">
                <div class="row">
                    <label class="control-label control-label-long">当前积分：</label>
                    <div class="controls" id="curr_score">${(userInfoDTO.totalScore)!0}</div>
                </div>
                <div class="row">
                    <label class="control-label control-label-long"><s>*</s>调整积分（增/减）：</label>
                    <div class="controls">
                        <input name="scoreIncome" class="control-text" data-messages="{regexp:'只能输入整数'}" data-rules="{required:true,regexp:/^-?[1-9]\d*$/}" />
                        此处可输入负值，负值表示减少积分
                    </div>
                </div>
                <div class="row">
                    <label class="control-label control-label-long"><s>*</s>备注：</label>
                    <div class="controls">
                        <input name="remark" class="control-text" data-rules="{required:true}">
                    </div>
                </div>
            </div>
            <div class="row">
                <label class="control-label control-label-long">&nbsp;</label>
                <div class="controls">
                    <button id="btn_save" type="submit" class="button button-primary">充值</button>
                </div>
            </div>
        </form>
    </div>
    <div class="content-body">
        <div id="grid2"></div>
    </div>
</div>
</body>

<script type="text/javascript">
    $(function(){
    	loadGrid();
    });
    function loadGrid(){
    	$("#grid2").empty();
    	BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	        	{title:'ID',dataIndex:'scoreDetailId',width:40, visible:false, renderer : function(value, rowObj){
	                return "<input type='hidden' name='scoreDetailId' value='" + value + "'>";
	        	}},
	            {title:'收入',dataIndex:'scoreIncome',width:150, renderer : function(value, rowObj){
	                if(null!=value){return value;}else{return 0;};
	            }},
	            {title:'支出',dataIndex:'scoreExpend',width:150, renderer : function(value, rowObj){
	                if(null!=value){return value;}else{return 0;};
	            }},
	            {title:'备注',dataIndex:'remark',width:300, renderer : function(value, rowObj){
	            	 return app.grid.format.encodeHTML(value);
	            }},
	            {title:'变更日期',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
	            	if(null!=value){
		                return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
	            	}
	            }}/*,
	            {title:'操作人',dataIndex:'adminUserName',width:150, renderer : function(value, rowObj){
					if(value){
                        return value;
					}
	                return "";
	            }},
	            {title:'订单号',dataIndex:'orderNumber',width:150, renderer : function(value, rowObj){
	                return value;
	            }}*/
	        ];
	        var store = Search.createStore('/admin/sa/user/grid_json2?userId='+${(userInfoDTO.userId)!?html},{pageSize:10});
	        var gridCfg = Search.createGridCfg(columns,{
	            width:'100%',
	            height: getContentHeight(),
	            // 顶部工具栏
	            tbar:{
	                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
	                items:[]
	            },
	              itemStatusFields : { //设置数据跟状态的对应关系
				        selected : 'selected',
				        disabled : 'disabled'
	     					 }
	        });
	        
	        var  search = new Search({
	                    store : store,
	                    gridCfg : gridCfg,
	                    gridId:'grid2'
	                    //
	                });
	        var grid = search.get('grid');
	
	    });
    }
    
    var Form = BUI.Form
	var form = new Form.Form({
	    srcNode: '#Score_Form',
	    submitType: 'ajax',
	    callback: function (data) {
	    		if(data==1){
	    			var curr_score=$("#curr_score").html();
		            var income_score=$("input[name='scoreIncome']").val();
		            $("#curr_score").html(Number(curr_score)+Number(income_score));
		       		$("[name='scoreIncome']").val('');
		        	$("[name='remark']").val('');
		            app.showSuccess("保存成功！");
	            	loadGrid();
	    		}else if(data==2){
	    			BUI.Message.Alert("已提交审核");
	    		}else if(data==3){
	    			BUI.Message.Alert("已有积分充值记录，请审核确认后再进行积分充值操作！");
	    		}else if(data==0){
	    			BUI.Message.Alert("积分充值失败");
	    		}	
	    
	        <#--if (app.ajaxHelper.handleAjaxMsg(data)) {
	        	var curr_score=$("#curr_score").html();
	            var income_score=$("input[name='scoreIncome']").val();
	            $("#curr_score").html(Number(curr_score)+Number(income_score));
	       		$("[name='scoreIncome']").val('');
	        	$("[name='remark']").val('');
	            app.showSuccess("保存成功！");
	            loadGrid();
	        }-->
	    }
	}).render();  
</script>
</body>
</html>  