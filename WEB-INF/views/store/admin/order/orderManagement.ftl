<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div>
        <div class="title-bar">
            <div id="tab">
            </div>
        </div>
        <div id="panel">
            <div></div>
        </div>
    </div>
</div>
  
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
                    {text: '订单列表', value: '0', loader: {url: '${ctx}/admin/store/order/list/tabItem?tabIndex=0&defaultSelectTab=${subDefaultSelectTab!}&orderStatus=-1&storeId=${storeId!}&moduleId=11'}},
                ]
            });
            tab.setSelected(tab.getItemAt(${defaultSelectTab!0}));
          
     });


	
</script>
</body>
</html>