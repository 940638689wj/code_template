<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
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
                    {text:'基本信息',value:'1', loader: {url: '${ctx}/admin/sa/mstore/toMstoreForm?userId=${(mstoreDTO.userId)!?html}'}},
                    {text:'佣金明细',value:'2', loader: {url: '${ctx}/admin/sa/mstore/toMstoreCommissionDetails?userId=${(mstoreDTO.userId)!?html}'}},
                    {text:'下级返利明细',value:'3', loader: {url: '${ctx}/admin/sa/mstore/toChildrenRebate?userId=${(mstoreDTO.userId)!?html}'}},
                    {text:'首单奖励明细',value:'4', loader: {url: '${ctx}/admin/sa/mstore/toFirstReward?userId=${(mstoreDTO.userId)!?html}'}}
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
        </div>
    </div>
</body>
</html>
