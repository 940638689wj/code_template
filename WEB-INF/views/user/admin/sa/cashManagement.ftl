<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
    <style>
    	.form-horizontal  .control-label{width:90px;}
    </style>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
    </div>

    <div class="content-body">
        <form id="searchForm" class="form-horizontal search-form">
                <div class="content-top">
                    <input id="loginName" name="loginName" class="control-text" placeholder="用户名">
                    <input type="hidden" id="showType" name="showType" value="">

                    &nbsp;&nbsp;
                    <button id="btnSearch" type="button" class="button button-primary">搜索</button>
                </div>
        </form>
    </div>


    <div class="content-body">
        <div id="grid"></div>
    </div>

    <div id="batchReview" class="hide">
        <form class="form-horizontal">
            <div class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">备注：</label>
                        <div class="controls control-row-auto">
                            <textarea name="remarkAgree" id="remarkAgree" class="span6"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="withdrawal" class="hide">
        <form class="form-horizontal">
            <div  class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label span8">提现最小金额：</label>
                        <div class="controls control-row-auto">
                            <input type="text" data-rules="{number:true,min:0} name="accountBalance" id="accountBalance" class="input-normal control-text"" >
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <#--<div id="withdrawalRule" class="hide">
        <form class="form-horizontal">
            <div  class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label">提现规则：</label>
                        <div class="controls control-row-auto">
                            <textarea name="rule" id="rule" class="span6"></textarea>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div> -->
</div>
<script type="text/javascript">
	var grid;
    var search;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'全部提现',value:'0'},
            {text:'银行提现',value:'1'},
            {text:'电子账户提现',value:'2'}
        ]
    });
    tab.setSelected(tab.getItemAt(${tabIndex!'0'}));
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        var showType=item.get('value');
        if(showType == "0"){
            tab.setSelected(tab.getItemAt(0));
        }else if(showType == "1"){
            tab.setSelected(tab.getItemAt(1));
        }else if(showType == "2"){
            tab.setSelected(tab.getItemAt(2));
        }

        $('#showType').val(showType);
        search.load();
        //window.location.href = "${ctx}/admin/sa/mstore/toCashManage?applyStatusCd="+applyStatusCd;
    });

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'操作',dataIndex:'',width:100,visible:${tabIndex!'0'}==2?false:true,renderer : function(value,rowObj){
	            var editStr = '&nbsp;<a href=\'javascript:audit("'+rowObj.withdrawalDetailId+'");\'>审核</a>';
	            return editStr;
	        }},
	        {title:'ID',dataIndex:'withdrawalDetailId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='withdrawalDetailId' value='" + value + "'>";
        	}},
        	{title:'手机号',dataIndex:'phone',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
        	}},
         	{title:'姓名',dataIndex:'userName',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'提现金额',dataIndex:'withdrawalAmt',width:200, renderer : function(value, rowObj){
                return (value!=null && ""!=null)?value:0;
            }},
            {title:'银行类型',dataIndex:'bankTypeName',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'申请时间',dataIndex:'applyTime',width:140, renderer : function(value, rowObj){
            	if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
            {title:'开户行名称',dataIndex:'openingBankName',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'开户名',dataIndex:'openingAccountName',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'账号',dataIndex:'openingAccountNo',width:100, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'收款人身份证账号',dataIndex:'identityId',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'处理人',dataIndex:'adminUserName',width:80, renderer : function(value, rowObj){
	        	return app.grid.format.encodeHTML(value);
            }},
            {title:'处理时间',dataIndex:'dealTime',width:140, renderer : function(value, rowObj){
            	if(null!=value){
                	return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }},
            {title:'备注',dataIndex:'remark',width:70, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/mstore/grid_json7?applyStatusCd=${(applyStatusCd)!'1'}',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight(),
            // 顶部工具栏
            tbar:{
                // items:工具栏的项， 可以是按钮(bar-item-button)、 文本(bar-item-text)、 默认(bar-item)、 分隔符(bar-item-separator)以及自定义项
                items:[
                    /*{btnCls : 'button button-small',text:'导出',handler:exportCash},
                    {btnCls : 'button button-small',text:'批量转账',handler:exportCash},
                    {btnCls : 'button button-small',text:'批量拒绝转账',handler:exportCash},
                    /!*{btnCls : 'button button-small',text:'批量审核',visible:${tabIndex!'0'}==2?false:true,handler:function(){audit(null);}},*!/
                    {btnCls : 'button button-small',text:'设置提现金额',visible:${tabIndex!'0'}==0?true:false,handler:setAmt}*/
                ]
            },
			width: '100%',
            height: getContentHeight()
        });
        
        search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();
    });

    /*var mask;
    $('.title-bar-side .search-bar input').on('focus',function(){
        var $this = $(this);
        var searchCon = $this.closest('.title-bar-side').find('.search-content');
        $this.addClass("focused");
        if(!mask)
            mask = $('<div></div>').css({
                'position':'absolute',
                'left':0,
                'top':0,
                'width':'100%',
                'height':'100%'
            }).appendTo(document.body);
        searchCon.show(400);
        mask.on('click',function(){
            $this.removeClass("focused");
            mask.remove();
            mask = null;
            searchCon.hide(400);
        });
    });*/

    function audit(detailId){
        var detailIds='';
    	if(null!=detailId && ''!=detailId){
    		detailIds= detailId;
    	}else{
    		var selectedContent = grid.getSelection();
            if(selectedContent.length < 2){
                BUI.Message.Alert("选择的申请条数不能低于2条!");
                return false;
            }
            
        	var selectedContentIds = [];
            for(var i = 0; i < selectedContent.length ; i++){
                selectedContentIds.push(selectedContent[i].withdrawalDetailId);
            }
        	detailIds= selectedContentIds.join(",");
    	}
    	
    	var tabIndex=${tabIndex!'0'};
    	if(tabIndex==0){
            BUI.use('bui/overlay',function(Overlay){
          	var dialog = new Overlay.Dialog({
            title:'审核',
            width:500,
            closeAction : 'destroy', //每次关闭dialog释放
            //配置DOM容器的编号
            contentId:'batchReview',
            mask:true,
            buttons:[
                {
                    text:'同意',
                    elCls : 'button button-primary',
                    handler : function(){
                        var remarkAgree=$("#remarkAgree").val();
			              app.ajax('${ctx}/admin/sa/mstore/updateWithdrawal',{
			              remark:remarkAgree,detailIds:detailIds,f:'s'
			              },function(data){
			              		 if (app.ajaxHelper.handleAjaxMsg(data)) {
			              			app.showSuccess("审核成功");
			              			location.href=location.href;
			              		}
			              });
			              $("#remarkAgree").val("");
			              this.close();
                    }
                },{
                    text:'拒绝',
                    elCls : 'button',
                    handler : function(){
                        var remarkAgree=$("#remarkAgree").val();
			              app.ajax('${ctx}/admin/sa/mstore/updateWithdrawal',{
			              remark:remarkAgree,detailIds:detailIds,f:'r'
			              },function(data){
			              		if (app.ajaxHelper.handleAjaxMsg(data)) {
			              			app.showSuccess("已拒绝提现申请！");
			              			location.href=location.href;
			              		}
			              });
			              $("#remarkAgree").val("");
			              this.close();
                    }
                },{
                    text:'取消',
                    elCls : 'button',
                    handler : function(){
                    	$("#remarkAgree").val("");
                        this.close();
                    }
                }
            ]
          });
        dialog.show();
        });
        }else if(tabIndex==1){
        	if(confirm("确定转账成功了吗？")){
              app.ajax('${ctx}/admin/sa/mstore/updateWithdrawal',{
              remark:"",detailIds:detailIds,f:'v'
              },function(data){
              		if (app.ajaxHelper.handleAjaxMsg(data)) {
              			app.showSuccess("转账成功！");
              			location.href=location.href;
              		}
              });
        	}
        }
    }
    
    function setAmt(){
    	$.ajax({
		 type: "POST",
	     url: "${ctx}/admin/sa/mstore/getAmt",
	     dataType: "json",
	     success: function(data){
	     	$("#accountBalance").val(data);
	     }
		});
		
    	var dialogwithdrawal=null;
    	BUI.use('bui/overlay',function(Overlay){
        	dialogwithdrawal = new Overlay.Dialog({
	            title:'设置提现金额',
	            width:400,
	            closeAction : 'destroy', //每次关闭dialog释放
	            contentId : 'withdrawal',
	            mask:true,
	            buttons:[
	                {
	                    text:'确定',
	                    elCls : 'button button-primary',
	                    handler : function(){
	                    	var accountBalance=$("#accountBalance").val();
	                    	if(isNaN(accountBalance)){
	                    		BUI.Message.Alert('请输入数字类型','warning');
	                    		return;
	                    	}
	                    	app.ajax('${ctx}/admin/sa/mstore/setWithdrawalAmt',{accountBalance:accountBalance},
	                    		function(data){
				              		if(app.ajaxHelper.handleAjaxMsg(data)){
				              			app.showSuccess("设置成功");
				              		}
				            	}
				            );
	                        this.close();
	                    }
	                },{
	                    text:'取消',
	                    elCls : 'button',
	                    handler : function(){
	                        this.close();
	                    }
	                }
	            ]	            
	        });
        });
        dialogwithdrawal.show();
    }
    
    function exportCash(){
    	var withdrawalDetailIds='';
		var selectedContent = grid.getSelection();
		var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].withdrawalDetailId);
        }
    	withdrawalDetailIds= selectedContentIds.join(",");
    	var params=$("#searchForm").serialize();
		location.href ="${ctx}/admin/sa/mstoreExcel/exportWithdrawal?"+params+"&withdrawalDetailIds="+withdrawalDetailIds;
    	BUI.Message.Alert("导出成功");
    }

function setRule(){
	$.ajax({
	 type: "POST",
     url: "${ctx}/admin/sa/mstore/getRule",
     dataType: "json",
     success: function(data){
     	$("#rule").val(data);
     }
	});
	  
	var dialogwithdrawal=null;
	BUI.use('bui/overlay',function(Overlay){
    	dialogwithdrawal = new Overlay.Dialog({
            title:'设置提现规则',
            width:400,
            closeAction : 'destroy', //每次关闭dialog释放
            contentId : 'withdrawalRule',
            mask:true,
            buttons:[
                {
                    text :'确定',
                    elCls : 'button button-primary',
                    handler : function(){
                      var rule=$("#rule").val();
		              app.ajax('${ctx}/admin/sa/mstore/setWithdrawalRule',{
		              rule:rule
		              },function(data){
		              		 if (app.ajaxHelper.handleAjaxMsg(data)) {
		              			app.showSuccess("设置成功");
		              		}
		              });
		              this.close();
                    }
                },{
                    text :'取消',
                    elCls : 'button',
                    handler : function(){
                        this.close();
                    }
                }
            ]	            
        });
    });
    
    dialogwithdrawal.show();
}

</script>
</body>
</html>  