<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>

    <div class="content-body">
        <div class="title-bar-side">
            <div class="search-bar">
                <input type="text" placeholder="用户名" class="control-text" id="short_loginName"/><button onclick="searchCustomer()"></button>
            </div>

            <div class="search-content">
                <form id="searchForm" class="form-horizontal search-form">
                    <input name="sort" value="operateStamp desc" type="hidden"/>
                    <div class="row">
                        <div class="control-group span8">
                            <label class="control-label">用户名：</label>
                            <div class="controls">
                                <input type="text" id="loginName"  name="loginName" class="input-normal control-text">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-actions offset3">
                            <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>

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
            {text:'日志管理',value:'0'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
                    {title:'用户',dataIndex:'adminUserName',width:150, renderer : function(value, rowObj){
                        return app.grid.format.encodeHTML(value);
                    }},
                    {title:'操作描述',dataIndex:'operateDescription',width:300, renderer : function(value, rowObj){
                        return app.grid.format.encodeHTML(value);
                    }},
                    {title:'IP',dataIndex:'operateIpAddr',width:100},
                    {title:'操作日期',dataIndex:'operateTime',width:200,renderer:BUI.Grid.Format.datetimeRenderer}
                ];
        var store = Search.createStore('grid_json');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight()
                });

        var  search = new Search({
                    store : store,
                    gridCfg : gridCfg
                });
        var grid = search.get('grid');

    });

    $(function(){
        //点击 右上角搜索框
        var mask;
        $('.title-bar-side .search-bar input').on('focus',function(){
            var $this = $(this);
            $this.addClass("focused");
            if(!mask)
                mask = $('<div></div>').css({
                    'position':'absolute',
                    'left':0,
                    'top':0,
                    'width':'100%',
                    'height':'100%'
                }).appendTo(document.body);
            mask.on('click',function(){
                $this.removeClass("focused");
                mask.remove();
                mask = null;
            });
        });

        $("#short_loginName").on('keyup',function(){
            $("#loginName").val($("#short_loginName").val());
            if(event.keyCode ==13)
            {
                $('#btnSearch').click();
            }
        });
        //鼠标直接制
        $("#short_loginName").on('click',function(){
            $("#loginName").val($("#short_loginName").val());
        });
    })

    function searchCustomer(){
        $('#btnSearch').click();
    }
</script>
 </body>
 </html>