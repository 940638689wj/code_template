<#assign ctx = request.contextPath>
<div class="container">
    <div class="row">
        <form id="searchForm_select" name="searchForm_select" class="form-horizontal search-form">
            <div class="row">
                <div class="control-group span8">
                    <label class="control-label">会员名称：</label>
                    <div class="controls">
                        <input type="text" class="input-normal control-text"  name="loginName">
                    </div>
                </div>

                <div class="control-group span8">
                    <label class="control-label">会员级别：</label>
                    <div class="controls">
                        <select name="userLevelId">
                            <option value="-1">请选择</option>
                            <#if userLevelList ?? && userLevelList?has_content>
                                <#list userLevelList as us>
                                    <option value="${(us.userLevelId)!}">${(us.userLevelName)!}</option>
                                </#list>
                            </#if>
                        </select>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="control-group">
                    <label class="control-label">会员标签：</label>
                    <div class="controls">
                        <select name="userLabelId">
                            <option value="-1">请选择</option>
                        <#if userLabelList ?? && userLabelList?has_content>
                            <#list userLabelList as ub>
                                <option value="${(ub.id)!}">${(ub.name)!}</option>
                            </#list>
                        </#if>
                        </select>
                        &nbsp;&nbsp;<button id="customer_search" type="submit" class="button button-primary">搜索</button>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <div id="customerGrid"></div>
</div>
<script type="text/javascript">
    var customerGrid;
    BUI.use(['common/search','common/page'],function (Search) {
        var customerColumns = [
            {title : '用户标签',dataIndex :'userLabels',width:"150px"},
            {title : '登录名',dataIndex :'loginName',width:"150px", renderer : function(value, rowObj){
                return app.grid.format.encodeHTML(value);
            }},
            {title : '用户编号',dataIndex :'userId',width:"150px", visible:false},
//            {title : '用户名',dataIndex :'userName',width:"150px", renderer : function(value, rowObj){
//                return app.grid.format.encodeHTML(value);
//            }},
            {title : '昵称',dataIndex : 'nickName',width:"150px"},
            {title : '手机',dataIndex : 'phone',width:"100px"},
            {title: '积分', dataIndex: 'totalScore', width: 70, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
            }},
            {title: '推广状态', dataIndex: 'mstoreStatusCd', width: 70, renderer: function (value, rowObj) {
                if (value == 0) {
                    return "否";
                } else if (value == 1) {
                    return "是";
                }
                return "否";
            }},
            {title : '会员等级',dataIndex : 'userLevelName',width:"100px"},
            {title : '来源',dataIndex : 'registerPlatformText',width:"100px",renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }},
            {title : '注册日期',dataIndex : 'registerTime',width:"135px",renderer: function (value, rowObj) {
                if (value != null) { return BUI.Date.format(value, "yyyy-mm-dd HH:MM:ss");}
              }
            }
        ];
        var customerStore = Search.createStore('${ctx}/admin/sa/pickupcouponCode/user_grid_json',{
            pageSize:100
        }),
        customerGridCfg = Search.createGridCfg(customerColumns,{
            plugins : [BUI.Grid.Plugins.CheckSelection,BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
            multiSelect: true
        });

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