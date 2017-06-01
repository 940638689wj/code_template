<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <style>
        #urlForm5.form-horizontal .controls{line-height:20px;}
    </style>
</head>
<body>
<div class="container">
    <div class="content-top">
        <div class="content-top">
            <form id="urlForm5" class="form-horizontal search-form mb0" method="get">
                <input type="hidden" name="userId" value="${userInfoDTO.userId}"/>
            </form>
        </div>
        <div class="content-body">
            <div id="grid5"></div>
        </div>
    </div>
</div>

<script type="text/javascript">
    BUI.use('common/page');
    var grid5=null;

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'用户名',dataIndex:'loginName',width:150, renderer : function(value, rowObj){
                return value;
            }},
            /*{title:'姓名',dataIndex:'userName',width:150, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;}
            }},*/
            {title:'昵称',dataIndex:'userName',width:150, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;}
            }},
            {title:'类型',dataIndex:'type',width:100, renderer : function(value, rowObj){
                if(value == "balance"){
                    return "余额";
                }else if(value == "score"){
                    return "积分";
                }
            }},
            {title:'收入',dataIndex:'inCome',width:100, renderer : function(value, rowObj){
                if(null!=value && value){return value;}
            }},
            {title:'消费',dataIndex:'expenditure',width:100, renderer : function(value, rowObj){
                if(null!=value){return value;}
            }},
            {title:'备注',dataIndex:'remark',width:250, renderer : function(value, rowObj){
                return value;
            }},
            {title:'操作时间',dataIndex:'createTime',width:150, renderer : function(value, rowObj){
                if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
            }}
        ];
        var store = Search.createStore('/admin/sa/user/toViewPaymentsDetailGridJson',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
        });

        var  search5 = new Search({
            store : store,
            gridCfg : gridCfg,
            formId:"urlForm5",
            gridId:"grid5",
            btnId:"btnSearch5"
        });
        grid5 = search5.get('grid5');
        //grid5.render();
    });
</script>
</body>
</html>