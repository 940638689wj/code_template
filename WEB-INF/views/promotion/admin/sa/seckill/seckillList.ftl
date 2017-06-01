<#assign ctx = request.contextPath>
<#assign isStatusCd = (statusCd?? && "Y" == statusCd) />
<#assign  mobileUrl = Static["cn.yr.chile.common.helper.SiteConfigHelper"].getMobileUrl()?default("")/>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
	<div class="title-bar">
        <div id="tab">
        </div>
    </div>
	<form id="searchForm" class="form-horizontal search-form">
		<input type="hidden" name="statusCd" value="${statusCd?default('1')}"/>
		<input type="hidden" name="isEnableTime" value="1"/>
	</form>
    <div class="content-body">
        <div id="grid"></div>
    </div>
</div>

<script type="text/javascript">
    var basicFormDialog = null;
    var search = null;

    var Overlay = BUI.Overlay
    
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render: '#tab',
        elCls: 'link-tabs',
        autoRender: true,
        children: [
            {text: '有效', value: '1', href: 'javascript:void(0)'},
            {text: '过期', value: '2', href: 'javascript:void(0)'},
            {text: '禁用', value: '3', href: 'javascript:void(0)'}
        ],
        itemTpl: '<a href="{href}">{text}</a>'
    });
    
    //默认选择lab的第一个选项
    tab.setSelected(tab.getItemAt(0));
    
    //点击lab中对应项的操作
    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="1"){
            $("input[name='statusCd']").val('1');
            $("input[name='isEnableTime']").val('1');
        }else if(item.get('value')=="2"){
        	$("input[name='statusCd']").val('');
            $("input[name='isEnableTime']").val('2');
        }else if(item.get('value')=="3"){
            $("input[name='statusCd']").val('0');
            $("input[name='isEnableTime']").val('3');
        }
        //重新加载数据
        search.load({pageIndex:1});
    });

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'编号',dataIndex:'promotionId',width:150, renderer : function(value, rowObj){
                var str = "";
                str = "<a href='${ctx}/admin/sa/promotion/seckill/form?promotionId="+value+"'>"+value+"</a>";
                return str;
            }},
            {title:'促销名称',dataIndex:'promotionName',width:200},
            {title:'促销描述',dataIndex:'promotionDesc',width:300,renderer : function(value, rowObj){
                var str = "";
                str = "<span title="+ value.replace(/\s+/g,"") +">"+value+"</span>";
                return str;
            }},
            {title:'起始时间',dataIndex:'enableStartTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'结束时间',dataIndex:'enableEndTime',width:150,renderer:BUI.Grid.Format.datetimeRenderer},
            {title:'状态',dataIndex:'statusCd',width:100,renderer : function(value, rowObj){
            	var str = "";
            	if(value == 1) {
            		return str="启用";
            	} else {
            		return str="禁用";
            	}
            }},
            {title:'操作',dataIndex:'promotionId',width:150,renderer : function(value, rowObj){
            	var str =   "<a href='${ctx}/admin/sa/promotion/seckill/form?promotionId="+value+"'>编辑</a>";
            	return str;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/promotion/seckill/grid_json');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                    {text : '新建秒杀活动',btnCls : 'button button-small button-primary',handler:addNew},
                    {
                        xclass:'bar-item-text',
                        text:'<div class="tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-volume-up"></i></span><div class="tips-content">秒杀页面地址 <a href="${mobileUrl!}/products/secondkill.html" target="_blank">${mobileUrl!}/products/secondkill.html</a></div></div>'
                    }
                ]
            }
        });

        search = new Search({
            store : store,
            formId : "searchForm",
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
        
    });

    function addNew(){
        window.location.href = "${ctx}/admin/sa/promotion/seckill/form";
    }
</script>
</body>
</html>