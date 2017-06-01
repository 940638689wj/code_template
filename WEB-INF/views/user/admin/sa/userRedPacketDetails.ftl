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
        <form id="RedPacket_Form" class="form-horizontal" action="${ctx}/admin/sa/user/rechargeRedPacket" method="post">
        	<input type="hidden" name="userId" value="${(userInfoDTO.userId)!?html}"/>
            <div class="form-content mb0">
            	<div class="row">
                    <label class="control-label control-label-long">当前余额：</label>
                    <div class="controls" id="curr_redPacket">${(userInfoDTO.redPacketBalance)!0}</div>
                </div>
                <div class="row">
                    <label class="control-label"><s>*</s>充值金额：</label>
                    <div class="controls">
                        <input name="packetIncome" class="control-text" data-rules="{number:true}">
                        （单位：元）此处可输入负值，负值表示减余额
                    </div>
                </div>
                <div class="row">
                    <label class="control-label"><s>*</s>备注：</label>
                    <div class="controls">
                        <input name="remark" class="control-text" data-rules="{required:true}">
                    </div>
                </div>
            </div>
            <div class="row">
                <label class="control-label">&nbsp;</label>
                <div class="controls">
                    <button id="btn_save" type="submit" class="button button-primary">充值</button>
                </div>
            </div>
        </form>
    </div>
    <div class="content-body">
        <div id="grid3"></div>
    </div>
</div>
</body>

<script type="text/javascript">
	$(function(){
		loadGrid1();
	});
	
    function loadGrid1(){
    	$("#grid3").empty();
    	BUI.use(['common/search','common/page'],function (Search) {
	        var columns = [
	        	{title:'ID',dataIndex:'redPacketDetailId',width:40, visible:false, renderer : function(value, rowObj){
	                return "<input type='hidden' name='redPacketDetailId' value='" + value + "'>";
	        	}},
	            {title:'收入',dataIndex:'packetIncome',width:100, renderer : function(value, rowObj){
	                if(null!=value){return value;}else{return 0;};
	            }},
	            {title:'支出',dataIndex:'packetExpend',width:140, renderer : function(value, rowObj){
	                if(null!=value){return value;}else{return 0;};
	            }},
	            {title:'备注',dataIndex:'remark',width:100, renderer : function(value, rowObj){
	            	 return app.grid.format.encodeHTML(value);
	            }},
	            {title:'变更日期',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
	            	if(null!=value){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
	            }},
	            {title:'订单号',dataIndex:'orderNumber',width:150, renderer : function(value, rowObj){
	                return value;
	            }}
	        ];
	        var store = Search.createStore('/admin/sa/user/grid_json3?userId='+${(userInfoDTO.userId)!?html},{pageSize:10});
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
	                    gridId:'grid3'
	                    //
	                });
	        var grid = search.get('grid');
	
	    });
    }
    
    var Form = BUI.Form
	var form = new Form.Form({
	    srcNode: '#RedPacket_Form',
	    submitType: 'ajax',
	    callback: function (data) {
	        if (app.ajaxHelper.handleAjaxMsg(data)) {
	        	var curr_redPacket=$("#curr_redPacket").html();
	            var packetIncome=$("input[name='packetIncome']").val();
	            $("#curr_redPacket").html(Number(curr_redPacket)+Number(packetIncome));
	            $("[name='packetIncome']").val('');
	        	$("[name='remark']").val('');
	            app.showSuccess("保存成功！");
	            loadGrid1();
	        }
	    }
	}).render();
</script>
</body>
</html>  