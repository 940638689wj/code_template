<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript">
        $(function(){
            var Tab = BUI.Tab
            var tab = new Tab.TabPanel({
                render : '#tab',
                elCls : 'nav-tabs',
                panelContainer : '#panel',
                selectedEvent : 'click',//默认为click
                autoRender: true,
                children:[
                    {text:'基本信息',value:'0', loader: {url: '${ctx}/admin/sa/user/viewUserInfo?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'个人资料',value:'1', loader: {url: '${ctx}/admin/sa/user/toUpdateUserForm?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'账户余额',value:'2', loader: {url: '${ctx}/admin/sa/user/toUserBalanceDetails?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'积分',value:'3', loader: {url: '${ctx}/admin/sa/user/toUserScoreDetails?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'等级设置',value:'4', loader: {url: '${ctx}/admin/sa/user/toUserSetUserLevel?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'密码修改',value:'5', loader: {url: '${ctx}/admin/sa/user/toChangePassword?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'支付密码修改',value:'6', loader: {url: '${ctx}/admin/sa/user/toChangePaymentPassword?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'收支明细',value:'7', loader: {url: '${ctx}/admin/sa/user/toViewPaymentsDetail?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'返利明细',value:'8', loader: {url: '${ctx}/admin/sa/user/toViewRebateDetail?userId=${(userInfoDTO.userId)!?html}'}},
                    {text:'下级会员',value:'9', loader: {url: '${ctx}/admin/sa/user/toFzUsersDetails?userId=${(userInfoDTO.userId)!?html}'}}
                ]
            });
            tab.setSelected(tab.getItemAt(0));  
        });
//添加标签
function labelSelect(userId){
	BUI.use('bui/overlay',function(Overlay){
		var dialog = new Overlay.Dialog({
			title:'选择标签',
			width:200,
			height:150,
			closeAction : 'destroy',
			contentId :'labelSelect',
			buttons:[
			  {
				text:'确认',
				elCls : 'button button-primary',
				handler : function(){
					var userLabelId =$('#label').val();
					app.ajax('${ctx}/admin/sa/userLabel/saveXref',{
					userId:${userInfoDTO.userId},userLabelId:userLabelId
					},function(data){
						if(app.ajaxHelper.handleAjaxMsg(data)){
			              			app.showSuccess("便签添加成功");
			              			location.href=location.href;
			              		}
					});
					this.close();
				}
			  },{
			  	text:'取消',
			  	elCls:'button',
			  	handler : function(){
			  	
			  		this.close();
			  	}
			  }
			]
		});
		dialog.show();
	});
}        
//删除标签
function deleteLabel(labelId,userId){
	BUI.Message.Confirm("确定移除标签吗",function(){
	$.ajax({
		url : "${ctx}/admin/sa/userLabel/deleteLabelXref",
		dataType : 'json',
		type : 'POST',	
		data : {labelId:labelId,userId:userId},
		success : function(data){
			if(app.ajaxHelper.handleAjaxMsg(data)){
				app.showSuccess("移除成功");
				location.href=location.href;
			}
		}
	});
	},'question')
	
}
    </script>
</head>
<body>
<div class="container">
	<ul class="breadcrumb">
	    <li><a href="${ctx}/admin/sa/user/userList">会员列表</a> <span class="divider">&gt;&gt;</span></li>
	    <li class="active">${(userInfoDTO.loginName)!}</li>
	</ul>

    <div>
        <div id="tab"></div>
        <div id="panel">
        	<div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
 </div> 
</body>
</html>
