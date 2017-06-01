<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div id="content">
        <div id="left" class="side-menu">
            <ul id="zTree" class="ztree"></ul>
        <link href="${ctx}/static/admin/js/ztree/3.5.12/css/zTreeStyle/zTreeStyle.min.css" rel="stylesheet" type="text/css"/>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.core-3.5.min.js"></script>
        <script type="text/javascript" src="${ctx}/static/admin/js/ztree/3.5.12/js/jquery.ztree.exhide-3.5.min.js"></script>
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
                        ,name:"1级会员分销"
                        ,url:""
                    }
                    ,{
                        id:2
                        ,name:"2级会员分销"
                        ,url:""
                    }
                    ,{
                        id:3
                        ,name:"3级会员分销"
                        ,url:""
                    }
                    ,{
                        id:4
                        ,name:"4级会员分销"
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
            	<form id="fzUserForm"class="form-horizontal search-form mb0" method="get">
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
    var grid4=null;
    
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
	            {title:'会员名',dataIndex:'phone',width:100},
	            {title:'会员等级',dataIndex:'levelName',width:100},
	            {title:'业绩点',dataIndex:'rebateProductPoint',width:150},
	            {title:'成交数',dataIndex:'totalNum',width:100, renderer : function(value, rowObj){
	                return value;
	            }},
	            {title:'成交总金额',dataIndex:'totalPrice',width:80, renderer : function(value, rowObj){
	                 if(null!=value){return value;}else{return 0;}
	            }}
	        ];
	        var store = Search.createStore('/admin/sa/user/grid_json4?userId=${(userInfoDTO.userId)}&levelId='+levelId,{pageSize:10});
	        var gridCfg = Search.createGridCfg(columns,{
	            width:'100%',
	            height: getContentHeight(),
                bbar:{
                    pagingBar:false
                }
	        });
	        
	        var  search = new Search({
	                    store : store,
	                    gridCfg : gridCfg,
	                    gridId : "grid4",
	                    formId:"fzUserForm"
	                    //
	                });
            grid4 = search.get('grid');
            grid4.render();

    	});
    }
    
    function exportUser(){
    	var treeObj = $.fn.zTree.getZTreeObj("zTree");
		var nodes = treeObj.getSelectedNodes();
    	var levelId= nodes[0]!=null?nodes[0].id:0;//分销会员等级
    	var startDate=$("#startDate").val();
    	var endDate=$("#endDate").val();
		//location.href ='${ctx}/admin/sa/userExcel/exportFzUsers?userId='+${(userInfoDTO.userId)}+'&levelId='+levelId+'&startDate='+startDate+'&endDate='+endDate;
    	location.href = '${ctx}/admin/sa/userExcel/exportFzUsers1?userId='+${(userInfoDTO.userId)}+'&levelId='+levelId+'&startDate='+startDate+'&endDate='+endDate;
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