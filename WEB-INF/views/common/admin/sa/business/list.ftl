<#assign ctx = request.contextPath>
    <#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <div class="content-top">
        <div id="tab1"></div>
        <div class="title-bar-side">
            <div class="search-bar">
            </div>
            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input name="sort" value="id asc" type="hidden"/>
                    <input name="limit" value="1000" type="hidden"/>

                    <#if flag?has_content>
                        <#if flag=="1">
                            <input name="in_type" value="config_alipay_pc,config_alipay_mobile,config_tenpay_pc,config_tenpay_mobile,config_ipayment_pc,config_unionpay_mobile,config_allinpay_pc,config_allinpay_mobile" type="hidden"/>
                        <#elseif flag=="2">
                            <input name="in_type" value="newGuoduService" type="hidden"/>
                        <#elseif flag=="3">
                            <input name="in_type" value="config_alipay_login_pc,config_alipay_login_mobile,config_weibo_login_pc,config_weibo_login_mobile,config_tenpay_login_pc,config_tenpay_login_mobile" type="hidden"/>
                        <#else>
                            <input name="in_type" value="config_erp_st,config_erp_bs,config_erp_regent,config_erp_hxy,config_erp_yyc,config_weixin,config_system_email,config_order,config_erp_olb,royaSMSService,siooService,newGuoduService,xuanwuService" type="hidden"/>
                        </#if>
                    </#if>

                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'业务列表',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search'],function (Search) {
        var columns = [
            {title:'业务编号',dataIndex:'businessConfigTypeId',width:80},
            {title:'业务名称',dataIndex:'businessConfigTypeName',width:300, renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title:'业务状态',dataIndex:'isActive',width:300, renderer:app.grid.format.renderActive},
            {title:'操作',dataIndex:'', width:100, renderer : function(value,rowObj){
                var editStr="";
                editStr= Search.createLink({
                    text: '编辑',
                    href: '${ctx}/admin/sa/common/businessconfig/edit?flag=${flag!}&configTypeId='+rowObj.businessConfigTypeId
                });
                return editStr;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/common/businessconfig/typeList/grid_json',{pageSize:100});
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            bbar:{
                pagingBar:false
            }
        });

        var  search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
        grid.render();
    });
</script>

</body>
</html>