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
        <div id="tab1">

        </div>
    </div>

    <div class="content-top">
        <form id="searchForm" class="form-horizontal search-form">
        	 <input type="hidden" id="reviewStatus" name="reviewStatus" value="">
            <div class="content-top">
                <input id="loginName" name="loginName" class="control-text" placeholder="用户名">
                <select name="reviewStatusCd" style="display: none;" id="reviewStatusCd">
                    <option value=''>请选择评价状态</option>
                    <option value=1>审核通过</option>
                    <option value=3>审核拒绝</option>
                </select>
                &nbsp;&nbsp;
                <button id="btnSearch" type="button" class="button button-primary">搜索</button>
            </div>
        </form>
    </div>

    <div class="content-body">
    	 <ul class="toolbar" id="toolbar">
            <li><button class="button button-small" onclick="passAll()">批量通过</button></li>
            <li><button class="button button-small" onclick="refuseAll()">批量拒绝</button></li>
        </ul>
        <div id="grid"></div>
    </div>

</div>

<script type="text/javascript">
    var grid;
    var search;
    var Tab = BUI.Tab;
     var tab1 = new Tab.Tab({
        render : '#tab1',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'未审核',value:'0'},
            {text:'已审核',value:'1'}
        ]
    });
    tab1.setSelected(tab1.getItemAt('0'));
    tab1.on('selectedchange',function (ev) {
        var item = ev.item;
        var reviewStatus=item.get('value');
        if(reviewStatus == "0"){
            tab1.setSelected(tab1.getItemAt(0));
             $('#reviewStatusCd').hide();
               $('#toolbar').show();
        }else if(reviewStatus == "1"){
            tab1.setSelected(tab1.getItemAt(1));
             $('#reviewStatusCd').show();
               $('#toolbar').hide();
        }
        $('#reviewStatus').val(reviewStatus);
        search.load();
    });
    
	var doReviewDialog;
	 var Overlay = BUI.Overlay
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'操作',dataIndex:'reviewId',width:100, renderer : function(value,rowObj){
                var editStr = Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/user/review/edit?id='+value
                });
                return editStr;
            }},
            {title:'编号',dataIndex:'reviewId',width:40, renderer : function(value, rowObj){
                return value;
            }},
            {title:'产品编号',dataIndex:'productId',width:100, renderer : function(value, rowObj){
                return value;
            }},
            {title:'商品名称',dataIndex:'productName',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'会员名称',dataIndex:'loginName',width:100, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'评价内容',dataIndex:'reviewContent',width:200, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'评价等级',dataIndex:'productMatchScore',width:200, renderer : function(value, rowObj){
                return showReviewScore(value);
            }},
            {title:'评价状态',dataIndex:'reviewStatusCd',width:100, renderer : function(value, rowObj){
                if(value == 1){
                    return "审核通过";
                }else if(value == 2){
                    return "待审核";
                }else if(value == 3){
                    return "审核拒绝";
                }
                return "";
            }},
            {title:'评价提交时间',dataIndex:'reviewTime',width:140, renderer : function(value, rowObj){
                if(null!=value){
                    return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
                }
            }}
        ];

        var store = Search.createStore('${ctx}/admin/sa/user/review/grid_json',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            plugins : [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
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
    
    var curWwwPath=window.document.location.href;
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName)+1;
    var path = curWwwPath.substring(0,pos) + "/static";
    function showReviewScore(value){
        var imgUrl1 = path + "/images/t1-19-19.png";
        var imgUrl2 = path + "/images/t2-19-19.png";
        var html = '<span class="ks-simplestar">';
        for(var i=1; i<6; i++){
            if(i > value){
                html += '<img src="' + imgUrl1 + '">';
            }else{
                html += '<img src="' + imgUrl2 + '">';
            }
        }
        html += '</span>';
        return html;
    }
    
    
    function passAll(){
	     var selectedReview = grid.getSelection();
        if(selectedReview.length <= 0){
            BUI.Message.Alert("请选择需要审核的评价!");
            return false;
        }
        var selectedReviewIds = [];
        var flag = '0';
        for(var i = 0; i < selectedReview.length ; i++){
        		if(selectedReview[i].reviewStatusCd != 2){
        			flag = '1';
        			break;
        		}	
        		selectedReviewIds.push(selectedReview[i].reviewId);
        }
        if(flag == 1){
        	BUI.Message.Alert("记录已审核，请重选!");
            return false;
        }
	    BUI.Message.Confirm('确定要批量通过评价吗?',function(){
	        $.ajax({
	            url : '${ctx}/admin/sa/user/passAll',
	            dataType : 'json',
	            type: 'POST',
	            data : {reviewIds : selectedReviewIds},
	            success : function(data){
	            	 if(data.result == "true"){
                        app.showSuccess("批量通过成功！");
                        search.load();
                    }else{
                        BUI.Message.Alert(data.message);
                    }
	            }
	        });
	    },'question');
	}
	
	
	function refuseAll(){
	     var selectedReview = grid.getSelection();
        if(selectedReview.length <= 0){
            BUI.Message.Alert("请选择需要审核的评价!");
            return false;
        }
        var selectedReviewIds = [];
        var flag = '0';
        for(var i = 0; i < selectedReview.length ; i++){
        		if(selectedReview[i].reviewStatusCd != 2){
        			flag = '1';
        			break;
        		}	
        		selectedReviewIds.push(selectedReview[i].reviewId);
        }
        if(flag == 1){
        	BUI.Message.Alert("记录已审核，请重选!");
            return false;
        }
	    BUI.Message.Confirm('确定要批量拒绝评价吗?',function(){
	        $.ajax({
	            url : '${ctx}/admin/sa/user/refuseAll/',
	            dataType : 'json',
	            type: 'POST',
	            data : {reviewIds : selectedReviewIds},
	            success : function(data){
	            	 if(data.result == "true"){
                        app.showSuccess("批量拒绝成功！");
                        search.load();
                    }else{
                        BUI.Message.Alert(data.message);
                    }
	            }
	        });
	    },'question');
	}
</script>
</body>
</html>