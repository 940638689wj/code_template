<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "../../../includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab"></div>
    </div>
    <form id="J_Form" class="form-horizontal" action="save" method="post">
	    <div class="content-body">
	        <div id="grid"></div>
	    </div>
	    <div class="content-foot">
	        <div class="actions-bar">
	            <button type="submit" class="button button-primary">保存</button>
	        </div>
	    </div>
    </form>
</div>
<script type="text/javascript">
    var Tab = BUI.Tab;
    var tab = new Tab.Tab({
        render : '#tab',
        elCls : 'nav-tabs',
        autoRender: true,
        children:[
            {text:'微店等级管理',value:'1'}
        ]
    });
    tab.setSelected(tab.getItemAt(0));
    
    BUI.use(['common/search'],function (Search) {
        var columns = [
        	{title:'ID',dataIndex:'mstoreLevelId',width:40, visible:false, renderer : function(value, rowObj){
                return "<input type='hidden' name='id' value='" + value + "'>";
            }},
            {title:'状态',dataIndex:'statusCd',width:90, renderer : function(value, rowObj){
                var defaultChecked = "";
                if(value != null && value == 1){
                    defaultChecked = "checked='checked'";
                }
                 var canBeModify = "";
                /*
                if(rowObj.rankCd == 1){
                    canBeModify = "disabled";
                }
                */
                return "<input " + canBeModify +" name='statusCd_" + rowObj.mstoreLevelId + "' id='statusCds_" + rowObj.mstoreLevelId + "' type='checkbox' "+ defaultChecked + "><label for='statusCd_" + rowObj.mstoreLevelId + "'>启用</label>";
            }},
            
            {title:'升级',dataIndex:'isAutoupdate',width:120,renderer: function(value, rowObj){
                var defaultChecked1 = "";
                if(value != null && value == 1){
                    defaultChecked1 = "checked='checked'";
                }

                var canBeModify = "";
                /*
                if(rowObj.rankCd == 1){
                    canBeModify = "disabled";
                }
                */

                return "<input " + canBeModify +" name='isAutoupdate_" + rowObj.mstoreLevelId + "' id='isAutoupdate_" + rowObj.mstoreLevelId + "' type='checkbox' "+ defaultChecked1  +"><label for='upgrade_" + rowObj.mstoreLevelId + "'>是否自动升级</label>";
            }},
            {title:'是否默认',dataIndex:'isDefault',width:80, renderer : function(value, rowObj){
                var isDefault = "";
                if(value == 1){
                    isDefault = "默认";
                }else{
                	isDefault = "否";
                }
                return isDefault;
            }},
            {title:'微店等级',dataIndex:'rankCd',width:110, renderer: app.grid.format.randerMstoreLevelRank},
            {title:'微店等级名称',dataIndex:'mstoreLevelName',width:180,renderer: function(value, rowObj){
                return "<input id='levelName_" + rowObj.mstoreLevelId + "'  class='control-text' type='text' name='levelName_" + rowObj.mstoreLevelId + "' style='width: 100px;' value='" + (value == null ? "" : value) + "'>";
            }},
            {title:'会员量',dataIndex:'',width:220,renderer: function(value, rowObj){
            	var mstoreLevelId=rowObj.mstoreLevelId;
            	var min=rowObj.buyUserNumMin;
            	var max=rowObj.buyUserNumMax;
            	return "购买会员：<input type='number' placeholder='>0' style='width:50px;' class='control-text' name='min_"+mstoreLevelId+"' value='"+min+"'/> ~ <input type='number' placeholder='>0' style='width:50px;' class='control-text' name='max_"+mstoreLevelId+"' value='"+max+"'/>个"
            }},
            {title:'销售额',dataIndex:'saleAmt',width:150,renderer: function(value, rowObj){
                return "<input type='number' placeholder='>0' id='saleAmt_" + rowObj.mstoreLevelId + "'  class='control-text' type='text' name='saleAmt_" + rowObj.mstoreLevelId + "' style='width: 100px;' value='" + (value == null ? "" : value) + "'>";
            }},
            {title:'佣金系数',dataIndex:'commissionCoefficient',width:150,renderer: function(value, rowObj){
                return "<input type='number' placeholder='>0且<100' id='commission_" + rowObj.mstoreLevelId + "'  class='control-text' type='text' name='commission_" + rowObj.mstoreLevelId + "' style='width: 100px;' value='" + (value == null ? "" : value) + "'>";
            }}
        ];
        var store = Search.createStore('/admin/sa/mstore/grid_json1');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width: '99.5%',
            height: getContentHeight(),
            // 底部工具栏
            bbar:{
                // pagingBar:表明包含分页栏
                pagingBar:false
            }
        });

        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');


    });
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    app.page.open({
                        href:location.href
                    });
                }
            }
        });

        form.on('beforesubmit', function(){
            return validData();
        });

        form.render();
    });
    
    function validData(){
    	var flag=true;
    	var $maxs=$("input[name^='max_']");
    	$.each($maxs,function(i,item){
    		var max=$(item).val();
    		var min=$($(item).siblings("input[name^='min_']")).val();
    		if(Number(max)<=Number(min)){
		    	app.showError("请正确填写会员量区间");
    			flag=false;
    			return;
    		}
    	});
    	
    	$.each($("input"),function(i,item){
    		var value = $(item).val();
    		if(!isNaN(value) && value<0){
    			app.showError("数值必须大于0");
    			flag=false;
    			return flag;
    		}
    	});
    	
    	return flag;
    }
    
</script>
</body>
</html>  