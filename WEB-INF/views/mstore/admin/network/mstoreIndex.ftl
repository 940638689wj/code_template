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
                    {text:'基本信息',value:'1', loader: {url: '${ctx}/admin/network/mstore/toMstoreForm?userId=${(mstoreDTO.userId)!?html}'}},
                    {text:'佣金明细',value:'2', loader: {url: '${ctx}/admin/network/mstore/toMstoreCommissionDetails?userId=${(mstoreDTO.userId)!?html}'}},
                    {text:'分销明细',value:'3', loader: {url: '${ctx}/admin/network/mstore/toChildrenRebate?userId=${(mstoreDTO.userId)!?html}'}},
                    {text:'首单奖励明细',value:'4', loader: {url: '${ctx}/admin/network/mstore/toFirstReward?userId=${(mstoreDTO.userId)!?html}'}},
             	    {text:'会员发展明细',value:'5', loader: {url: '${ctx}/admin/network/mstore/toMembersDetail?userId=${(mstoreDTO.userId)!?html}'}}
                ]
            });
            tab.setSelected(tab.getItemAt(0));
        });
        
        
    </script>
</head>
<body>
    <div>
        <div id="tab"></div>
        <div id="panel">
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
</body>
</html>
