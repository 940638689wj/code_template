<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
    <style>
    #urlForm.form-horizontal .controls{line-height:20px;}
    </style>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div class="userinfo-box">
            <div class="pic">
            	<img src="<#if (userInfoDTO.headPortraitUrl)??>${(userInfoDTO.headPortraitUrl)!?html}<#else>${staticPath}/admin/images/userhead.jpg</#if>"  width="100" height="100">
            </div>
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
    <div class="content-top">
    	<div class="content-top">
            <form id="distForm" class="form-horizontal search-form mb0" method="get">
            	<input type="hidden" name="userId" value="${userInfoDTO.userId}"/>
                <div class="row">
                    <div class="control-group control-row-auto">
                        <div class="controls bui-form-group ml0" data-rules="{dateRange : true} ">
                            <input type="text" id="startDate" name="startDate" class="control-text input-small calendar">
                            <span class="mr5">至</span>
                            <input type="text" id="endDate" name="endDate" class="control-text input-small calendar">
                        </div>
                        <button id="btnSearch1" type="submit" class="button button-primary ml">搜索</button>
                        <input type="button" value="导出" class="button ml" onclick="exportDist()"/>
                    </div>
                </div>
            </form>
        </div>
        <div class="content-body">
            <div id="grid5"></div>
        </div>
    </div>
</div>
</body>

<script type="text/javascript">
	BUI.use('common/page');
    var grid=null;
	
	BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'ID',dataIndex:'distributionDetailId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='scoreDetailId' value='" + value + "'>";
        	}},
            {title:'时间',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
            	if(null!=value){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
            }},
            {title:'返利金额',dataIndex:'rebateAmt',width:100, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;};
            }},
            {title:'订单号',dataIndex:'orderNumber',width:180, renderer : function(value, rowObj){
                return value;
            }}
        ];
        var store = Search.createStore('/admin/sa/user/grid_json5',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格和拖拉列的大小
            width:'100%',
            height: getContentHeight(),
        });
        
        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg,
                    formId:"distForm",
                    gridId : "grid5",
                    btnId:"btnSearch1"
                    //
                });
        grid=search.get('grid');
        grid.render();

    });
    
	function exportDist(){
    	var formSerialize = $("#distForm").serialize();
		location.href ="${ctx}/admin/sa/userExcel/exportDist?t=1&"+formSerialize;
    	BUI.Message.Alert("导出成功");
    }
</script>
</body>
</html>