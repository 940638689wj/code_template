<#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
    <script type="text/javascript" src="http://api.map.baidu.com/api?v=1.5&ak=QQrTioIKwTyMP2CihUoKbEbU"></script>

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
                    {text:'基本信息',value:'1', loader: {url: '${ctx}/admin/network/userStore/toUpdateStoreForm?storeId=${(store.storeId)!}'}},
                    {text:'门店介绍',value:'2', loader: {url: '${ctx}/admin/network/userStore/toStoreIndroduceForm?storeId=${(store.storeId)!}'}},
                    {text:'门店评价',value:'3', loader: {url: '${ctx}/admin/network/userStore/toStoreAccess?storeId=${(store.storeId)!}'}}
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
            <div></div>
            <div></div>
            <div></div>
            <div></div>
            <div></div>
        </div>
    </div>
</body>
</html>
