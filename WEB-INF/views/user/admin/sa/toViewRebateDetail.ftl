<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
<#include "../../../includes/sa/header.ftl"/>
    <style>
        #urlForm3.form-horizontal .controls{line-height:20px;}
    </style>
</head>
<body>
<div class="container">
    <div class="content-top">
        <div class="content-top">
            <form id="urlForm3" class="form-horizontal search-form mb0" method="get">
                <input type="hidden" name="userId" value="${userInfoDTO.userId}"/>
            </form>
        </div>
        <div class="content-body">
            <div id="grid3"></div>
        </div>
    </div>
</div>
<script type="text/javascript">
    BUI.use('common/page');
    var grid3=null;

    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
            {title:'会员名称',dataIndex:'sourcePhone',width:150, renderer : function(value, rowObj){
                return value;
            }},
            {title:'会员等级',dataIndex:'userLevelName',width:150, renderer : function(value, rowObj){
                if(null!=value){return value;}else{return 0;}
            }},
            {title:'时间',dataIndex:'createTime',width:100, renderer : function(value, rowObj){
                if(value!=null){return BUI.Date.format(value,"yyyy-mm-dd HH:MM:ss");}
            }},
            {title:'业绩点订单',dataIndex:'orderNumber',width:100},
            {title:'业绩点',dataIndex:'rebateProductPoint',width:100}
        ];
        var store = Search.createStore('/admin/sa/user/toViewRebateDetailGridJson',{pageSize:15});
        var gridCfg = Search.createGridCfg(columns,{
            width:'100%',
            height: getContentHeight(),
        });

        var  search3 = new Search({
            store : store,
            gridCfg : gridCfg,
            formId:"urlForm3",
            gridId:"grid3",
            btnId:"btnSearch2"
        });
        grid3 = search3.get('grid3');
        //grid3.render();
    });
</script>
</body>
</html>