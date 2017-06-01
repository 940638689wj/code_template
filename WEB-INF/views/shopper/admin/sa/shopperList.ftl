<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>

    <div class="content-top">
	<form id="searchForm" class="form-horizontal search-form">
	    <div class="row">
	    	<div class="search-bar">
                <input name="shopperName" class="control-text" type="text" placeholder="输入配送员姓名"/>
                <input name="phone" class="control-text" type="text" placeholder="输入联系方式"/>
                <select name="workStatusCd">
                	<option value=''>请选择配送员状态</option>
                	<option value=0>休息</option>
                	<option value=1>空闲</option>
                	<option value=2>繁忙</option>
                </select>
                <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
	        </div>
	    </div>
	</form>
    </div>

    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
	var search;
	var grid;
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'配送员列表',value:'0'},
            {text:'新增配送员',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    
    tab.on('selectedchange',function (ev) {
	        var item = ev.item;
	        if(item.get('value')=="0"){
	            window.location.href = "${ctx}/admin/sa/shopper/toShopperList";
	        }
	        if(item.get('value')=="1"){
	            window.location.href = "${ctx}/admin/sa/shopper/toShopperForm";
	        }
    });

	BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'配送员编号',dataIndex:'shopperNum',width:100,renderer : function(value, rowObj){
                var str = "";
                str = "<a href='javascript:editShopper(\""+rowObj.shopperId+"\");'>"+value+"</a>";	
                return str;
        	}},
        	{title:'配送员账号',dataIndex:'userName',width:120, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
         	{title:'配送员姓名',dataIndex:'shopperName',width:120, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
         	{title:'联系方式',dataIndex:'phone',width:200, renderer : function(value, rowObj){
         		return app.grid.format.encodeHTML(value);
            }},
            {title:'创建时间',dataIndex:'createTime',width:180, renderer: BUI.Grid.Format.datetimeRenderer},
            {title:'最后登录时间',dataIndex:'lastLoginTime',width:180, renderer: BUI.Grid.Format.datetimeRenderer},
            {title : '状态',dataIndex : 'workStatusCd',width:60,renderer : function(value, rowObj){
            	if(value=='0'||value==null){
            		value="休息";
            	}else if(value=='1'){
            		value="空闲";
            	}else if(value=='2'){
            		value="繁忙";
            	}
            	return value;
            }},
            {title : '账户',dataIndex : 'statusCd',width:60,renderer : function(value, rowObj){
            	if(value=='1'){
            		value="启用";
            	}else if(value=='0'){
            		value="冻结";
            	}
            	return value;
            }},
            {title:'操作',dataIndex:'shopperId',width:150,renderer : function(value,rowObj){
                var btn_text="";
                var status;
                    if(rowObj.statusCd=='1'){
                    	btn_text='冻结';
                    	status='0';
                    }else if(rowObj.statusCd=='0'){
                    	btn_text='启用';
                    	status='1';
                    }
       			var editStr="";
                editStr += '&nbsp;<a href=\'javascript:editStatusCd(\"' + rowObj.shopperId + '\",'+status+')\'>'+btn_text+'</a>';
                //editStr += '&nbsp;&nbsp;&nbsp;<span class="grid-command btn-del">删除</span>';
                return editStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/shopper/queryShopper',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            // 顶部工具栏
            tbar:{
                items:[
	                {btnCls : 'button button-small',text:'冻结',handler:freezeShopper},
	                //{btnCls : 'button button-small',text:'删除',handler:delSelected},
	                {btnCls : 'button button-small',text:'导出',handler:exportShopper},
	                {	xclass:'bar-item-text',
		                text:'<div class="tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-volume-up"></i></span><div class="tips-content">提示: 当一位配送员一小时内已被指派3笔订单时，则状态显示繁忙，否则为空闲，快递员在快递端点击下班则显示为休息。</div></div>'
	    			}
                ]
            },
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width:'100%',
            height: getContentHeight()
        });
        
        var search = new Search({
            store : store,
            gridCfg : gridCfg,
            formId :'searchForm',
            btnId:"btnSearch"
        });
        grid = search.get('grid');
        grid.render();
        
        grid.on('cellclick',function(ev){
            var sender = $(ev.domTarget); //点击的Dom
            if(sender.hasClass('btn-del')){
                var record = ev.record;
                delShopper(record.shopperId);
            }
        });
		
        function delShopper(shopperId){
            BUI.Message.Confirm('确认要删除该账户？',function(){
                $.ajax({
                    url : '${ctx}/admin/sa/shopper/deleteShopper',
                    dataType : 'json',
                    type: 'POST',
                    data : {shopperIds : shopperId},
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


    //导出
    function exportShopper(){
    	var shopperIds='';
		var selectedContent = grid.getSelection();
		var selectedContentIds = [];
        for(var i = 0; i < selectedContent.length ; i++){
            selectedContentIds.push(selectedContent[i].shopperId);
        }
    	shopperIds= selectedContentIds.join(",");
    	
		location.href ="${ctx}/admin/sa/shopper/exportShopper?shopperIds="+shopperIds;
		BUI.Message.Alert("导出成功");
    }
    
    //点击编号跳转至编辑页面
	function editShopper(obj){
        window.location.href = "${ctx}/admin/sa/shopper/toShopperForm?shopperId="+obj;
    }
    
    //单个账户启用、冻结
    function editStatusCd(shopperId,statusCd){
    	var str;
    	if(statusCd=='0'){
    		str='确认要冻结此账户？';
    	}else if(statusCd=='1'){
    		str='确认要启用此账户？';
    	}
    	BUI.Message.Confirm(str,function(){
			app.ajax('${ctx}/admin/sa/shopper/editStatusCd',
			{shopperId:shopperId,statusCd:statusCd}, function(data){
		   		if(app.ajaxHelper.handleAjaxMsg(data)){
					app.showSuccess("设置成功");
					location.href=location.href;
				}else{
	                app.showSuccess("设置失败");
	                location.href=location.href;
	            }
		    });
	    },'question');
	}
	
	//批量冻结
	function freezeShopper(){
		var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择要冻结的账户!");
            return false;
        }
       
	 	BUI.Message.Confirm('确认要冻结所选账户？',function(){
	        var selectedContentIds = [];
	        for(var i = 0; i < selectedContent.length ; i++){
	            selectedContentIds.push(selectedContent[i].shopperId);
	        }
	        app.ajax("${ctx}/admin/sa/shopper/freezeShopper", 
	        {shopperIds: selectedContentIds.join(","),statusCd:'0'}, function (data) {
	            if(data){
	                app.showSuccess("设置成功！")
	                location.href=location.href;
	            }else{
	                app.showSuccess("设置失败");
	                location.href=location.href;
	            }
        	})

        },'question');
	}
	
	//批量删除
	function delSelected(){
		var selectedContent = grid.getSelection();
        if(selectedContent.length <= 0){
            BUI.Message.Alert("请选择要删除的账户!");
            return false;
        }
       
	 	BUI.Message.Confirm('确认要删除所选账户？',function(){
	        var selectedContentIds = [];
	        for(var i = 0; i < selectedContent.length ; i++){
	            selectedContentIds.push(selectedContent[i].shopperId);
	        }
	        app.ajax("${ctx}/admin/sa/shopper/deleteShopper", 
	        {shopperIds: selectedContentIds.join(",")}, function (data) {
	            if(data){
	                app.showSuccess("删除成功！")
	                location.href=location.href;
	            }else{
	                app.showSuccess("删除失败");
	                location.href=location.href;
	            }
        	})

        },'question');
	}
	
</script>
</body>
</html>  