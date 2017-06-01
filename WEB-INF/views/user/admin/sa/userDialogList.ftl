<#assign ctx = request.contextPath>
<div class="container">
    <div class="row">
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form">
            <#if mstoreStatusCd??>
                <input name="mstoreStatusCd" value="${mstoreStatusCd!}" type="hidden"/>
            </#if>

            <div class="row">
                <div class="control-group span6">
                    <label class="control-label" style="width: 60px;">用户名：</label>
                    <div class="controls">
                        <input type="text" class="input-normal control-text bui-form-field"  name="userName">
                    </div>
                </div>

                <div class="control-group span6">
                    <label class="control-label" style="width: 60px;">手机：</label>
                    <div class="controls">
                        <input type="text"  class="input-normal control-text"name="phone">
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group span6">
                    <label class="control-label" style="width: 60px;">来源：</label>
                    <div class="controls">
                        <select name="registerPlatformCd">
                            <option  value="">全部</option>
                            <option value="1">微信</option>
                            <option value="2">浏览器</option>
                            <option value="3">白鹭卡</option>
                        </select>
                    </div>                    
                </div>
                <div class="span">
                    <button id="customer_search" type="submit" class="button button-primary">搜索</button>
                </div>
            </div>
        </form>
    </div>

    <#if mstoreStatusCd?? && mstoreStatusCd?has_content>
        <div class="tips tips-small tips-notice"><span class="x-icon x-icon-small x-icon-warning"><i class="icon icon-white icon-volume-up"></i></span><div class="tips-content">只有推广会员才能成为其他会员的上级，列表数据已过滤非推广会员</div></div>
    </#if>

    <div id="customerGrid"></div>
</div>
<script type="text/javascript">
    var customerGrid;
    BUI.use(['common/search','common/page'],function (Search) {
        var customerColumns = [
            {title : 'userId',dataIndex :'userId',width:"150px", visible:false},
            {title : '手机',dataIndex : 'phone',width:"100px"},
            {title : '用户名',dataIndex :'userName',width:"150px", renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title : '昵称',dataIndex : 'nickName',width:"150px"},
            {title : '会员等级',dataIndex : 'userLevelName',width:"100px"},
            {title : '上级会员',dataIndex : 'parentPhone',width:"150px"},
            {title : '创建日期',dataIndex : 'registerTime',width:"135px",renderer:BUI.Grid.Format.datetimeRenderer}
        ];
        var customerStore = Search.createStore('${ctx}/admin/sa/user/grid_json',{
            pageSize:5
        });
        var isMultiChoice = ${isMultiChoice?default(true)?string("true","false")};
        var customerGridCfg;
        if(isMultiChoice){
            customerGridCfg = Search.createGridCfg(customerColumns,{
                plugins : [BUI.Grid.Plugins.CheckSelection],// 插件形式引入多选表格
                multiSelect: true
            });
        } else {
            customerGridCfg = Search.createGridCfg(customerColumns,{
                plugins : [BUI.Grid.Plugins.RadioSelection]// 插件形式引入单选表格
            });
        }

        var  customerSearch = new Search({
            store : customerStore,
            gridCfg : customerGridCfg,
            gridId: 'customerGrid',
            formId:'searchForm_select',
            btnId:"customer_search"
        });

        customerGrid = customerSearch.get('grid');
    });

    function getSelectedRecords(){
        var selections = customerGrid.getSelection();
        return selections;
    }

    function cancelChoice(){
        customerGrid.clearSelection();
    }
</script>