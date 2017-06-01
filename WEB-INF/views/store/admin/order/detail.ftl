 <#assign ctx = request.contextPath>
<!DOCTYPE html>
<html>
<head>
 <#include "${ctx}/includes/sa/header.ftl"/>
    <meta charset="utf-8">
    <title>订单详情</title>

    <script type="text/javascript">
        $(function () {
            var Tab = BUI.Tab

            var tab = new Tab.TabPanel({
                render: '#tab',
                elCls: 'nav-tabs',
                panelContainer: '#panel',
                selectedEvent: 'click',//默认为click
                autoRender: true,
                children: [
                    {text: '订单详情', value: '0'}
                ]
            });
            tab.setSelected(tab.getItemAt(0));


        })


    </script>
</head>
<body>
<div class="content">
        <div class="container">
        		<div class="content-top">
     				<div id="tab"></div>
   				 </div>
            <div id="panel">
                <div><#include "orderInfo.ftl"/></div>
            </div>
        </div>
</div>
</body>
</html>
