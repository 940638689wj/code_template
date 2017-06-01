<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html>
<head>
    <title>门店管理后台</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
     <link href="${staticPath}/admin/css/dpl.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/bui.css" rel="stylesheet" type="text/css"/>
    <link href="${staticPath}/admin/css/main.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/theme-01.css"/>
    <script type="text/javascript" src="${staticPath}/admin/js/jquery-1.8.1.min.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/bui.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/admin.js"></script>
</head>
<body>

<div class="header">
    <div class="header-left">
        <div class="dl-title">
            <div class="dl-logo"><img src="/static/admin/images/logo.png" alt="商城后台"/></div>
        </div>
    </div>
    <div class="header-right">
        <a class="exit" href="${ctx}/admin/store/logout">退出</a>
        <div class="user">您好:${(store.userName)!}</div>
    </div>
    
    <div class="dl-msg">
        <div class="dl-msg-wrp" id="dl-msg">
        </div>
    </div>
    
</div>
<div class="content">
	<div class="dl-main-nav">
        <ul id="J_Nav" class="nav-list ks-clear">
         
             <li class="nav-item">
                    <div class="nav-item-inner">订单管理</div>
             </li>
                <li class="nav-item">
                    <div class="nav-item-inner">门店管理</div>
                </li>
            
            <li class="nav-item">
                    <div class="nav-item-inner">系统设置</div>
            </li>
            
           
        </ul>
    </div>
    <ul id="J_NavContent" class="dl-tab-content">

    </ul>
</div>

<script type="text/javascript" src="${staticPath}/admin/js/config.js"></script>
<script>
    BUI.use('common/main', function () {
        var config = [
            {
                id:'home',
                homePage: 'index',
                menu: [
                    {
                        text: '订单管理',
                        items: [
                            {id: 'index', text: '订单列表', href: '${ctx}/admin/store/order/storeOrderList?storeId=${(store.storeId)!}'},
                        ]
                    }
                ]
            }
        ];
        
         config.push(updateModulesHomePage({
	        id: 'store',
	        menu: [
	                {
	                    text: '门店管理',
	                    items: [
	                            {id: 'store:information ', text: '门店资料', href: '${ctx}/admin/store/index?storeId=${(store.storeId)!}'},
	                              <#if (store.storeTypeCd)?? && store.storeTypeCd==1>
				                    <#else>
				                    {id: 'store:historicalDistributionList ', text: '历史配送单', href: '${ctx}/admin/store/historicalDistribution/list?storeId=${(store.storeId)!}'},
				                   </#if>
                    			
                    			{id: 'store:statement', text: '对账单', href: '${ctx}/admin/store/statement/list?storeId=${(store.storeId)!}&storeBillType=0'}
	                    ]
	                }
	        ]
    	}));
    	
    	 config.push(updateModulesHomePage({
	        id: 'setting',
	        menu: [
	                {
	                    text: '系统设置',
	                    items: [
	                      
	                            {id: 'setting:modifyPassword', text: '修改密码', href: '${ctx}/admin/store/changePassword?storeId=${(store.storeId)!}'}
	                    ]
	                },
	           
	        ]
    	}));
    	
        new PageUtil.MainPage({
            modulesConfig: config
        });
    });
    
    function updateModulesHomePage(moduleObj){
    if(moduleObj.menu && moduleObj.menu.length){
        for(var i = 0; i < moduleObj.menu.length; i++){
            if(moduleObj.menu[i].items && moduleObj.menu[i].items.length){
                var suitItem = false;
                for(var j = 0; j < moduleObj.menu[i].items.length; j++){
                    if(moduleObj.menu[i].items[j].id){
                        moduleObj.homePage = moduleObj.menu[i].items[j].id;
                        suitItem = true;
                        break;
                    }
                }
                if(suitItem){
                    break;
                }
            }
        }
    }
    return moduleObj;
}
    
    
    function showMessage(message, clazz){
    var html = $('<span class="dl-msg-item '+clazz+'">'+message+'</span>');
    html.appendTo($("#dl-msg"));
    setTimeout(function() {
        html.remove()
    }, 1200);
}

function showSuccess(message){
    showMessage(message,'dl-msg-success');
}

function showError(message){
    showMessage(message,'dl-msg-error');
}
</script>
</body>
</html>
