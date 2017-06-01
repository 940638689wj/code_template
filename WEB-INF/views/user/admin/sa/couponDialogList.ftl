<#assign ctx = request.contextPath>
<div class="container">

    <div class="content-top">
        <div class="row">
            <form id="searchForm" class="form-horizontal search-form">
            	<input type="hidden" name="in_id" value="${in_id!}"/>
                <div class="row">
                    <div class="control-group span6">
                        <label class="control-label" style="width: 60px;">用户名：</label>
                        <div class="controls">
                            <input class="input-normal control-text bui-form-field" name="loginName">
                        </div>
                    </div>
                    <div class="control-group span6">
                        <label class="control-label" style="width: 60px;">会员级别：</label>
                        <div class="controls">
                            <select name="userLevelId">
                                <option value="">--全部--</option>
                            <#list userLevelList as userLevel>
                                <option value="${userLevel.userLevelId!}">${userLevel.userLevelName!?html}</option>
                            </#list>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group span6">
                        <label class="control-label" style="width: 60px;">选择标签：</label>
                        <div class="controls">
                            <select name="brandId" id="brandId">
                                <option value="">--请选择--</option>
                            <#if userLabelList?? && userLabelList?has_content>
                                <#list userLabelList as userLabel>
                                    <#if userLabel?has_content>
                                        <option value="${userLabel.id}">${userLabel.name}</option>
                                    </#if>
                                </#list>
                            </#if>
                            </select>
                        </div>
                    </div>
                    <div class="span2">
                        <button  type="button" id="btnSearch" class="button button-primary">搜索</button>
                    </div>
                </div>
            </form>
        </div>
    </div>


    <div class="search-grid-container">
        <div id="grid2"></div>
    </div>

</div>
<script type="text/javascript">
    BUI.use(['common/search', 'common/page'], function (Search) {
        var grid;
        var columns = [
            {
                title: 'ID', dataIndex: 'userId', width: 40, visible: false, renderer: function (value, rowObj) {
                return "<input type='hidden' name='userId' value='" + value + "'>";
            }
            },
            {
                title: '会员标签', dataIndex: 'userLabels', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return app.grid.format.encodeHTML(value);
                } else {
                    return '';
                }
            }
            },
            {
                title: '会员编号', dataIndex: 'userId', width: 100, renderer: function (value, rowObj) {
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>' + value + '</a>';
                return editStr;
            }
            },
            {
                title: '用户名', dataIndex: 'loginName', width: 100, renderer: function (value, rowObj) {
                var editStr = '&nbsp;<a href=\'javascript:getUser(\"' + rowObj.userId + '\")\'>' + app.grid.format.encodeHTML(value) + '</a>';
                return editStr;
            }
            },
//            {
//                title: '姓名', dataIndex: 'userName', width: 100, renderer: function (value, rowObj) {
//                return app.grid.format.encodeHTML(value);
//            }
//            },
            {
                title: '昵称', dataIndex: 'nickName', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '手机', dataIndex: 'phone', width: 100, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '注册平台', dataIndex: 'registerPlatformText', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '消费总额', dataIndex: 'totalConsumeAmt', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
            }
            },
            {
                title: '账户余额', dataIndex: 'userBalance', width: 100, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
            }
            },
            {
                title: '积分', dataIndex: 'totalScore', width: 70, renderer: function (value, rowObj) {
                if (null != value) {
                    return value;
                } else {
                    return 0;
                }
                ;
            }
            },
            {
                title: '推广状态', dataIndex: 'mstoreStatusCd', width: 70, renderer: function (value, rowObj) {
                if (value == 0) {
                    return "否";
                } else if (value == 1) {
                    return "是";
                }
                return "否";
            }
            },
            {
                title: '会员等级', dataIndex: 'userLevelName', width: 70, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '上级会员', dataIndex: 'parentPhone', width: 100, renderer: function (value, rowObj) {
                return app.grid.format.encodeHTML(value);
            }
            },
            {
                title: '状态', dataIndex: 'statusText', width: 60, renderer: function (value, rowObj) {
                return value;
            }
            },
            {
                title: '注册时间', dataIndex: 'registerTime', width: 140, renderer: function (value, rowObj) {
                if (value != null) {
                    return BUI.Date.format(value, "yyyy-mm-dd HH:MM:ss");
                }
            }
            }
        ];
        var store = Search.createStore('/admin/sa/user/productDialog/grid_json', {pageSize: 5});
        <#if in_id??>
	        var gridCfg = Search.createGridCfg(columns);
        <#else>
	        var gridCfg = Search.createGridCfg(columns, {
	            plugins: [BUI.Grid.Plugins.CheckSelection, BUI.Grid.Plugins.ColumnResize],// 插件形式引入多选表格
	            width: '100%',
	            height: 260,
	            plugins: [BUI.Grid.Plugins.CheckSelection]
	        });
        </#if>

        search = new Search({
            gridId: "grid2",
            store: store,
            gridCfg: gridCfg
            //
        });
        grid = search.get('grid');
        top.getSelected = window.getSelected = function () {
            var selected = grid.getSelection();
            return selected;
        };
    });

    function getUser(userId) {
        window.location.href = "${ctx}/admin/sa/user/toUserDetailIndex/" + userId;
    }

</script>