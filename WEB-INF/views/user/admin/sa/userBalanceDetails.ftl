<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="content-top">
        <form id="Balance_Form" class="form-horizontal" action="${ctx}/admin/sa/user/rechargeBalance" method="post">
        	<input type="hidden" name="userId" value="${(userInfoDTO.userId)!}"/>
            <div class="form-content mb0">
                <div class="row">
                    <label class="control-label control-label-long">当前余额：</label>
                    <div class="controls">￥<span id="curr_balance">${(userInfoDTO.userBalance)!0}</span></div>
                </div>
                <div class="row">
                    <label class="control-label control-label-long"><s>*</s>充值金额：</label>
                    <div class="controls">
                        <input name="balanceIncome" class="control-text"  data-rules="{required:true,number:true,regexp:/^[-+]?\d+(\.([0-9]|\d[0-9]))?$/}" data-messages="{regexp:'只能保留两位有效数字！'}">
                        （单位：元）此处可输入负值，负值表示减余额
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
        <div id="grid1"></div>
    </div>
</div>
</body>

<script type="text/javascript">
	$(function(){
		loadGrid2();
	});
	
    function loadGrid2(){
    	$("#grid1").empty();
    	BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	        	{title:'ID',dataIndex:'balanceId',width:40, visible:false, renderer : function(value, rowObj){
	                return "<input type='hidden' name='balanceId' value='" + value + "'>";
	        	}},
	            {title:'收入',dataIndex:'balanceIncome',width:150, renderer : function(value, rowObj){
	                if(null!=value){return value.toFixed(2);}else{return 0;};
	            }},
	            {title:'支出',dataIndex:'balanceExpend',width:150, renderer : function(value, rowObj){
	                if(null!=value){return value.toFixed(2);}else{return 0;};
	            }},
	            {title:'备注',dataIndex:'remark',width:300, renderer : function(value, rowObj){
	            	 return app.grid.format.encodeHTML(value);
	            }},
	            {title:'变更类型',dataIndex:'codeCnName',width:200, renderer : function(value, rowObj){
	            	 return app.grid.format.encodeHTML(value);
	            }},
	            {title:'变更日期',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
	                return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
	            }},
                {title:'操作人',dataIndex:'adminUserName',width:150, renderer : function(value, rowObj){
                    if(value){
						return value;
					}
					return "";
                }}/*,
	            {title:'订单号',dataIndex:'orderNumber',width:150, renderer : function(value, rowObj){
	                return value;
	            }}*/
	        ];
	        var store = Search.createStore('/admin/sa/user/grid_json1?userId='+${(userInfoDTO.userId)!?html},{pageSize:10});
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
	                    gridId:'grid1'
	                    //
	                });
	        var grid = search.get('grid');
	
	    });
    }
    
    var Form = BUI.Form
	var form = new Form.Form({
	    srcNode: '#Balance_Form',
	    submitType: 'ajax',
	    callback: function (data) {
	        if (data == 1) {
	            var curr_balance=$("#curr_balance").html();
	            var income_balance=$("input[name='balanceIncome']").val();
	            $("#curr_balance").html(Number(curr_balance)+Number(income_balance));
	        	$("input[name='balanceIncome']").val('');
	        	$("input[name='remark']").val('');
	            app.showSuccess("保存成功！");
	            loadGrid2();
	            //window.location.href="${ctx}/admin/sa/user/toUserDetailIndex";
	        }else if(data == 2){
                BUI.Message.Alert("已提交审核!");
			}else if(data == 3){
                BUI.Message.Alert("已有充值记录在审核，请审核确认后才能再次充值!");
			}else if(data == 0){
                BUI.Message.Alert("充值失败!");
			}
	    }
	}).render();  
</script>
</body>
</html>  