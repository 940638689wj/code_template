<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">

<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <script type="text/javascript" src="${staticPath}/admin/js/laydate.js"></script>
    <script type="text/javascript" src="${staticPath}/admin/js/utilDate.js"></script>
    <script src="${staticPath}/admin/js/echarts.js"></script>
</head>
<body>
<#macro showCategoryChild parent level>
    <#if parent?has_content>
    <option value="${(parent.categoryId)!}"><#if level gt 0><#list 0..level*2 as one>&nbsp;</#list></#if>${(parent.categoryName)!?html}</option>
    </#if>
    <#if parent?has_content && parent.childProductCategory?has_content>
        <#list parent.childProductCategory as child>
            <@showCategoryChild child level+1 />
        </#list>
    </#if>
</#macro>
<div class="container">
    <div class="title-bar">
        <div id="tab">

        </div>
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form mb0">
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls ml0">
                        <div class="pull-left bui-form-group" data-rules="{dateRange : true}">
                            <input type="text" id="beginTime" name="beginTime" class="calendar control-text">
                            <span class="mr5">&nbsp;&nbsp;至&nbsp;&nbsp;</span>
                            <input type="text" id="endTime" name="endTime" class="calendar control-text">
                        </div>
                        <input id="keyWords" name="keyWords" class="control-text" type="text" value="" placeholder="商品名称">
                        商品分类：
                        <select id="product_categoryId" name="product_categoryId">
                            <option value="">所有分类</option>
                            <#if productCategoryList?has_content>
                                <#list productCategoryList as parentCategory>
                                    <@showCategoryChild  parentCategory 0/>
                                </#list>
                            </#if>
                        </select>
                        <input type="hidden" name="categoryId" id="categoryId">
                        <input type="hidden" name="orderStatusCd" id="orderStatusCd" value="${orderStatusCd!}">
                        <button id="user_search" name="user_search" type="button" class="button button-primary ml">
                            搜索
                        </button>
                    </div>
                </div>
            </div>
        </form>
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
            {text:'全部',value:'0'},
            {text:'未付款商品',value:'1'},
            {text:'待发货商品',value:'2'},
            {text:'已发货商品',value:'3'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    tab.on('selectedchange',function (ev) {
        var item = ev.item;
        if(item.get('value')=="0"){
            $("#orderStatusCd").val("");
            search.load();//全部
        }
        if(item.get('value')=="1"){
            $("#orderStatusCd").val(1);
            search.load();//未付款商品
        }
        if(item.get('value')=="2"){
            $("#orderStatusCd").val(20);
            search.load();//待发货商品
        }
        if(item.get('value')=="3"){
            $("#orderStatusCd").val(3);
            search.load();//已发货商品
        }
    });
    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {
                title: '图片', dataIndex: 'picUrl', width: 200, renderer: function (value, rowObj) {
                var img_url = "";
                if(value!=null){
                    img_url = '<img src="'+value+'" style="width:30px;height: 30px;"/>';
                }else{
                    img_url = '<img src="" style="width:30px;height: 30px;"/>';
                }
                return img_url;
            }
            },
            {title: '销量排行', dataIndex: 'rankId', width: 80},
            {title: '商品名称', dataIndex: 'productName', width: 200},

            {title: '货号', dataIndex: 'barCode', width: 200},
            {title: '总销量', dataIndex: 'totalQuantity', width: 200}
        ];

        var store = Search.createStore('${ctx}/admin/sa/productAnalysis/grid_json', {pageSize: 10});
        var gridCfg = Search.createGridCfg(columns, {
            tbar: {
                items: [
                    {text: '导出', btnCls: 'button button-small', handler: generateAllReport}
                ]
            },
            plugins: [BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            width: '100%',
            height: getContentHeight()
        });

        search = new Search({
            gridId: 'grid',
            store: store,
            gridCfg: gridCfg,
            btnId: "user_search",
            formId: 'searchForm_select'
        });
        var grid = search.get('grid');
        grid.render();
    });

    // 商分类分组下拉列表事件触发
    $('#product_categoryId').change(function(){
        var categoryId = $("#product_categoryId").find("option:selected").val();
        $("#categoryId").val(categoryId);
    });

    /**
     * 导出
     */
    function generateAllReport() {
        var params = $("#searchForm_select").serialize();
        location.href = "${ctx}/admin/sa/productAnalysis/exportReport?" + params;
        BUI.Message.Alert("导出成功");
    }
</script>
</body>
</html>  