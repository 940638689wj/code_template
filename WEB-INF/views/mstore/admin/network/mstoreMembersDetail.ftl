<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="userinfo-box">
            <div class="pic"><img src="${(userInfoDTO.headPortraitUrl)!}"  width="100" height="100"></div>
            <div class="code"><img src="${ctx}/admin/sa/user/getQrImg?userId=${userInfoDTO.userId}"  width="100" height="100"></div>
            <div class="title">${(userInfoDTO.userName)!}<span>${(userInfoDTO.userLevelName)!}</span></div>
            <ul>
                <li>姓名：${(userInfoDTO.userName)!?html}</li>
                <li>注册时间：${((userInfoDTO.registerTime)?string("yyyy.MM.dd"))!}</li>
                <li>会员发展数：${(userInfoDTO.developUserCnt)!0}</li>
                <li>手机号：${(userInfoDTO.phone)!?html}</li>
                <li>会员等级：${(userInfoDTO.userLevelName)!?html}</li>
                <li>会员发展返利总额：${(userInfoDTO.developUserRebateAmt)!0}</li>
                <li>会员卡号：${(userInfoDTO.phone)!?html}</li>
                <li>会员类型：${(userInfoDTO.userTypeName)!?html}</li>
                <li>会员发展积分：${(userInfoDTO.developUserScore)!0}</li>
            </ul>
        </div>
    </div>

    <div id="content">
        <div id="left" class="side-menu">
            <ul id="zTree" class="ztree"></ul>
        <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript"  src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
        <script type="text/javascript"  src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
            <script type="text/javascript">
                var key, lastValue = "", nodeList = [];
                var treeObj;
                var allNodes;
                var setting = {
                    data: {
                        simpleData: {
                            enable: true
                        }
                    },
                    callback:{
                    	onClick: showDevelopUserList
                    }
                };
                var zNodes =[
                    {
                        id:0
                        ,name:"全部"
                        ,url:""
                    }

                    ,{
                        id:1
                        ,name:"1级会员"
                        ,url:""
                    }
                    ,{
                        id:2
                        ,name:"2级会员"
                        ,url:""
                    }
                    ,{
                        id:3
                        ,name:"3级会员"
                        ,url:""
                    }
                    ,{
                        id:4
                        ,name:"4级会员"
                        ,url:""
                        ,open:true
                    }

                ];
                $(document).ready(function(){
                    treeObj=$.fn.zTree.init($("#zTree"), setting, zNodes);
                });
                function showDevelopUserList(event, treeId, treeNode){
                	var levelId=treeNode.id;//分销会员等级
                	var startDate=$("#startDate").val();
                	var endDate=$("#endDate").val();
                	//查询分销会员
                	searchDevelopUserList(levelId,startDate,endDate);
                }
            </script>
        </div>
        <div id="right" class="main-content">
            <div class="content-top">
            	<form id="jFoem" class="form-horizontal search-form mb0"  method="get">
                	<input type="hidden" name="userId" value="${userInfoDTO.userId}"/>
                    <div class="row">
                        <div class="control-group control-row-auto">
                            <div class="controls bui-form-group" data-rules="{dateRange : true}">
                                <input type="text" id="startDate" name="startDate" class="control-text input-small calendar">
                                <span class="mr5">至</span>
                                <input type="text" id="endDate" name="endDate" class="control-text input-small calendar">
                            </div>
                            <input type="button" value="搜索" class="button button-primary ml" onclick="search()">
                            <input type="button" value="导出" class="button ml" onclick="exportUser()"/>
                        </div>
                    </div>
               </form>
            </div>
            <div class="content-body">
                <div id="grid4"></div>
            </div>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
    
    BUI.use('common/page');
    var grid=null;
    
    $(function(){
        resetHeight();
        search();
    })
    function resetHeight(){
        var h = $(window).height() - ($('.title-bar').outerHeight() || 0) - ($('.bui-grid-bbar').outerHeight() || 0);
        $('.side-menu').height(h - 2);
    }
    $(window).on('resize',resetHeight);

    function searchDevelopUserList(levelId,startDate,endDate){
    	$("#grid4").empty();
    	var userId=${(userInfoDTO.userId)};
    	BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	        	{title:'ID',dataIndex:'developUserId',width:40, visible:false, renderer : function(value, rowObj){
	                return "<input type='hidden' name='developUserId' value='" + value + "'>";
	        	}},
	            {title:'用户姓名',dataIndex:'userName',width:100, renderer : function(value, rowObj){
	                return app.grid.format.encodeHTML(value);
	            }},
	            {title:'手机号',dataIndex:'phone',width:100, renderer : function(value, rowObj){
	                return app.grid.format.encodeHTML(value);
	            }},
	            {title:'会员类型',dataIndex:'userTypeName',width:80, renderer : function(value, rowObj){
	                return app.grid.format.encodeHTML(value);
	            }},
	            {title:'会员等级',dataIndex:'userLevelName',width:100, renderer : function(value, rowObj){
	                return app.grid.format.encodeHTML(value);
	            }},
	            {title:'发展时间',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
	                return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");
	            }},
	            {title:'是否是微店主',dataIndex:'mstoreStatusCd',width:100, renderer : function(value, rowObj){
	                if(value==3){
	                	return '是';
	                }else{
		                return '否';
	                }
	            }},
	            {title:'返利金额',dataIndex:'rebateAmt',width:80, renderer : function(value, rowObj){
	                 if(null!=value){return value;}else{return 0;};
	            }},
	            {title:'获得积分',dataIndex:'score',width:80, renderer : function(value, rowObj){
	                 if(null!=value){return value;}else{return 0;};
	            }}
	        ];
	        var store = Search.createStore('${ctx}/admin/network/mstore/grid_json7?userId='+${(userInfoDTO.userId)}+'&levelId='+levelId ,{pageSize:10});
	        var gridCfg = Search.createGridCfg(columns,{
	        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格和拖拉列的大小
	            width:'100%',
	            height: getContentHeight(),
	        });
	        
	        var  search = new Search({
	                    store : store,
	                    gridCfg : gridCfg,
	                    gridId : "grid4",
	                    formId:"jFoem"
	                });
	        grid = search.get('grid');
        	grid.render();

    	});
    }
    
    function exportUser(){
    	var treeObj = $.fn.zTree.getZTreeObj("zTree");
		var nodes = treeObj.getSelectedNodes();
    	var levelId= nodes[0]!=null?nodes[0].id:0;//分销会员等级
    	var startDate=$("#startDate").val();
    	var endDate=$("#endDate").val();
		location.href ='${ctx}/admin/network/mstoreExcel/exportFzUsers?userId='+${(userInfoDTO.userId)}+'&levelId='+levelId+'&startDate='+startDate+'&endDate='+endDate;
    	BUI.Message.Alert("导出成功");
    }
    
    function search(){
	    var treeObj = $.fn.zTree.getZTreeObj("zTree");
		var nodes = treeObj.getSelectedNodes();
    	var levelId= nodes[0]!=null?nodes[0].id:0;//分销会员等级
    	var startDate=$("#startDate").val();
    	var endDate=$("#endDate").val();
    	//查询分销会员
    	searchDevelopUserList(levelId,startDate,endDate);
    }
</script>
</body>
</html>  