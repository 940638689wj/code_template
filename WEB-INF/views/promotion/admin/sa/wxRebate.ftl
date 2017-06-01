<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
	<#--<form id="J_Form" class="form-horizontal" method="post" action="${ctx}/admin/sa/userPromotion/saveWxRebate" style="padding-left: 35px;">-->
		<div class="form-horizontal" style="padding-left: 15px;">
		<div>
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">下级微店返利</span></li>
        </ul>
    	</div>
    	<div class="round-title bui-clear">
        <h2>下级微店返利金额</h2>
        <div class="pull-left offset1 auxiliary-text">
           <span style="color:#999;font-size:12px;">需单独设置某款商品的返利</span> <a href="${ctx}/admin/sa/productManage/list">请点击></a>
        </div>
    </div>
    <div>
        <div style="width: 760px;">
            <label>
                <input type="radio" name="currentWxShopRebatePull" value="wx_shop_default_rebate_pull" <#if currentWxShopRebatePull?? && currentWxShopRebatePull=="wx_shop_default_rebate_pull">checked="checked"</#if>/>&nbsp;&nbsp;
                <input class="input-small control-text" type="text" name="wxShopRebate" id="wxShopRebate" value="<#if wxShopRebate?? && wxShopRebate?has_content>${wxShopRebate?string("0.##")}</#if>"/> 元
                </label>
            &nbsp;&nbsp;&nbsp;&nbsp;
                <label>
                <input type="radio" name="currentWxShopRebatePull" value="wx_shop_default_rebate_pull_percent" <#if currentWxShopRebatePull?? && currentWxShopRebatePull=="wx_shop_default_rebate_pull_percent">checked="checked"</#if>/>&nbsp;&nbsp;
                商品金额 &nbsp;*&nbsp;
                <input class="input-small control-text" type="text" name="wxShopRebatePercent" id="wxShopRebatePercent" value="<#if wxShopRebatePercent?? && wxShopRebatePercent?has_content>${((wxShopRebatePercent)*100)?string("0.##")}</#if>"/> %
            </label>
        </div><br/>
        <div style="padding-left: 24px; width: 760px;">
            <label>
               </label>
        </div>
    </div>
        
         <div>
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected"><span class="bui-tab-item-text">微店奖励/佣金</span></li>
            <span style="color:#999;font-size:12px;">需单独设置某款商品的返利</span> <a href="${ctx}/admin/sa/productManage/list" style="font-size:12px;">请点击></a>
        </ul>
    	</div>
    	<ul>
    	<li>
    	首单奖励：<input class="input-small control-text" type="text" name="wxShopOrderRewardsFirst" id="wxShopOrderRewardsFirst" value="<#if wxShopOrderRewardsFirst?has_content && wxShopOrderRewardsFirst??>${wxShopOrderRewardsFirst?string("0.##")}</#if>"/> 元 &nbsp;&nbsp;或
    	&nbsp;&nbsp;<input class="input-small control-text" type="text" name="wxShopOrderRewardsFirstPercent" id="wxShopOrderRewardsFirstPercent" value="<#if wxShopOrderRewardsFirstPercent?has_content && wxShopOrderRewardsFirstPercent??>${((wxShopOrderRewardsFirstPercent)*100)?string("0.##")}</#if>"/>%
        </li>	
        <li style="padding-top:30px;">	微店返利比例：<input class="input-small control-text" type="text" name="wxShopRebateRatio" id="wxShopRebateRatio" value="<#if wxShopRebateRatio?has_content && wxShopRebateRatio??>${((wxShopRebateRatio)*100)?string("0.##")}</#if>"/> % </li>
        <li style="padding-top:30px;">
        <form id="searchForm" class="form-horizontal search-form">
        <input name="officeOrgFullName" id="officeId" value="" type="hidden"/>
        <input name="branchCompanyOrgFullName" id="branchId" value="" type="hidden"/>
        <input name="largeAreaOrgFullName" id="largeAreaId" value="" type="hidden"/>
        	<input type="button" value="新增区域设置" onclick="javascript:window.location.href='${ctx}/admin/sa/userPromotion/add' "/>
        	<select style="width:100px" id="selectLargeArea">
        			<option value="">选择大区</option>
        	<#if largeAreaList?? && largeAreaList?has_content>
        		<#list largeAreaList as largeArea>
        			<option value="${largeArea.orgId}" id="lar_${largeArea.orgId}">${largeArea.orgFullName}</option>
        		</#list>
        	</#if>
        	</select>
        	<select style="width:100px" id="selectBranch">
        		<option value="">选择分公司</option>
        	</select> 
        	<select style="width:100px" id="selectOffice">
        		<option value="">选择办事处</option>
        	</select> 
        	<input type="submit" value="查询" id="btnSearch" style="width:60px"/>  
        	</form> 
        </li>
         </ul>
            <div class="title-bar">
        		<div id="tab"></div>
    		</div>
    		<div id="grid"></div>
        <div class="actions-bar"></div> 
         <div class="form-content">
	         <div class="row">
	            <div class="span13 offset2 ">
	                <#--<button type="submit" class="button button-primary">保存</button>-->
	                <input type="button" class="button button-primary" onclick="saveRebatePull()" value="保存" />
	                <#--<button type="reset" class="button">重置</button>-->
	            </div>
	        </div>
       </div>
       </div>
<#--</form>-->
	

<script type="text/javascript">
	var basicFormDialog = null;
    var search = null;
    var Overlay = BUI.Overlay
    BUI.use(['common/search','common/page'],function (Search) {
        var columns = [
        	{title:'操作',dataIndex:'orgId',width:70, renderer : function(value, rowObj){
                var editStr="";
                //editStr += '&nbsp;<a href=\'javascript:editRole(\"' + value + '\",\"' + rowObj.largeAreaOrgFullName + '\",\"' + rowObj.branchCompanyOrgFullName + '\",\"' + rowObj.officeOrgFullName + '\",\"' + rowObj.startDate + '\",\"' + rowObj.endDate + '\",\"' + rowObj.rebatePercent + '\")\'>编辑</a>&nbsp;';
                editStr += '&nbsp;<a href=\'${ctx}/admin/sa/userPromotion/add?orgId='+value+'\'>编辑</a>';
                editStr += '&nbsp;<a href=\'javascript:delRole(\"' + value + '\")\'>删除</a>';
                return editStr;
            }},
            {title:'大区',dataIndex:'largeAreaOrgFullName',width:150},
            {title:'分公司',dataIndex:'branchCompanyOrgFullName',width:100},
            {title:'办事处',dataIndex:'officeOrgFullName',width:200},
            {title:'开始时间',dataIndex:'startDate',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title:'结束时间',dataIndex:'endDate',width:150,renderer:BUI.Grid.Format.dateRenderer},
            {title:'佣金比例(%)',dataIndex:'rebatePercent',width:150, renderer : function(value, rowObj){
                return value*100;
            }}
        ];
        var store = Search.createStore('${ctx}/admin/sa/userPromotion/orgRebate/grid_json');
        var gridCfg = Search.createGridCfg(columns,{
        	plugins : [BUI.Grid.Plugins.ColumnResize],
            width:'100%',
            height: getContentHeight(),
            tbar : {
                items : [
                ]
            }
        });
        search = new Search({
            store : store,
            gridCfg : gridCfg
        });
        var grid = search.get('grid');
    });
    
    <#--(function($) {
        $(function() {
        	 var Form = BUI.Form;
            var form = new Form.Form({
                srcNode: '#J_Form',
                submitType: 'ajax',
                callback: function (data) {
                    if (app.ajaxHelper.handleAjaxMsg(data)) {
                        app.showSuccess("保存成功！")
                        window.location.href="${ctx}/admin/sa/userPromotion/wxRebate";
                    }
                }
            });
            form.render();
            
            top.configSubmit = function() {
                form.submit();
            };
            top.configReset = function() {
                $("#J_Form").find(":input").not(":button,:submit,:reset,:hidden").val("").removeAttr("checked").removeAttr("selected");
               };  
           });
    } (jQuery));-->
    $(function(){
     //分利选择
       if($("input[name='currentWxShopRebatePull']:checked").val() =="wx_shop_default_rebate_pull"){
         $("#wxShopRebatePercent").val("");
		 $("#wxShopRebatePercent").attr('disabled',true);
		 $("#wxShopRebate").attr('disabled',false);
		nextPrice();
       }else{
         $("#wxShopRebate").val("");
         $("#wxShopRebate").attr('disabled',true);
    	 $("#wxShopRebatePercent").attr('disabled',false);
    	 nextPrice();
       }
    
    
        $("#selectLargeArea").on('change', function(){
            var selectLargeArea = $(this).val();
            $("#largeAreaId").val($('#lar_'+selectLargeArea).html());
            if(selectLargeArea && selectLargeArea != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/org/findChildOrgList',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectLargeArea},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectBranch", "选择分公司");
                            cleanSelectContent("selectOffice", "选择办事处");
							
                            $.each(data.rows, function(i, row){
                                $("#selectBranch").append("<option value='"+row.orgId+"' id='branch_"+row.orgId+"' >"+row.orgFullName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectBranch", "选择分公司");
                            cleanSelectContent("selectOffice", "选择办事处");
                        }
                    }
                });
            }else{
                $('#selectBranch').empty();
                cleanSelectContent("selectBranch", "选择分公司");
                cleanSelectContent("selectOffice", "选择办事处");
            }
        });
        
        $("#selectBranch").on('change', function(){
            var selectBranch = $(this).val();
            $("#branchId").val($('#branch_'+selectBranch).html());
            if(selectBranch && selectBranch != ""){
                $.ajax({
                    url : '${ctx}/admin/sa/org/findChildOrgList',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectBranch},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectOffice", "选择办事处");

                            $.each(data.rows, function(i, row){
                                $("#selectOffice").append("<option value='"+row.orgId+"' id='office_"+row.orgId+"'>"+row.orgFullName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectOffice", "选择办事处");
                        }
                    }
                });
            }else{
                $('#selectOffice').empty();
                cleanSelectContent("selectOffice", "选择办事处");
            }
        });
        
        function cleanSelectContent(selectId, remark){
        	$('#'+selectId+'').empty();
        	$('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    	}
    });
	$("#selectOffice").on('change', function(){
		var officeId =  $(this).val();
		$("#officeId").val($('#office_'+officeId).html());
	});
    
    
    function saveRebatePull(){
        
        var rebatePullValue ;
        var currentWxShopRebatePull = "";
        $("input[name='currentWxShopRebatePull']:checked").each(function() {
            currentWxShopRebatePull = $(this).val();
            return false;
        });
		rebatePullValue=$("#wxShopOrderRewardsFirstPercent").val();
            if(!validData(rebatePullValue,'首单奖励百分比')){
                return false;
            }
        var wxShopOrderRewardsFirst=$("#wxShopOrderRewardsFirst").val();
        var wxShopOrderRewardsFirstPercent=$("#wxShopOrderRewardsFirstPercent").val();
        
        if(wxShopOrderRewardsFirst!=null&&wxShopOrderRewardsFirst!=""&&wxShopOrderRewardsFirstPercent!=null&&wxShopOrderRewardsFirstPercent!=""){
           BUI.Message.Alert("首单返利和百分比只能填写其中一个");
           return false;
          }
        rebatePullValue=$("#wxShopRebateRatio").val();
        if(!validData(rebatePullValue,'微店返利比例')){
        	return false;
        }
		
        if(currentWxShopRebatePull == "wx_shop_default_rebate_pull")
        {
            rebatePullValue=$("#wxShopRebate").val();
            if(!validData(rebatePullValue,'下级微店返利值')){
                return false;
            }
        }else if(currentWxShopRebatePull == "wx_shop_default_rebate_pull_percent")
        {
            rebatePullValue=$("#wxShopRebatePercent").val();
            if(!validData(rebatePullValue,'下级微店返利值百分比')){
                return false;
            }
        }
        var wxShopOrderRewardsFirst = $("#wxShopOrderRewardsFirst").val();
        var wxShopOrderRewardsFirstPercent = $("#wxShopOrderRewardsFirstPercent").val();
        var wxShopRebateRatio = $("#wxShopRebateRatio").val();
        app.ajax("${ctx}/admin/sa/userPromotion/save/wxRebate",{
            currentWxShopRebatePull:currentWxShopRebatePull,
            rebatePullValue:rebatePullValue,wxShopOrderRewardsFirst:wxShopOrderRewardsFirst,
            wxShopOrderRewardsFirstPercent:wxShopOrderRewardsFirstPercent,
            wxShopRebateRatio:wxShopRebateRatio},function(data){
            if(app.ajaxHelper.handleAjaxMsg(data)){
                app.showSuccess("保存成功!");
            }
        })
    }

    function validData(rebateRatioVal,msg){
        //rebateRatioVal = YrValidator.replaceAllSpace(rebateRatioVal);
        if(rebateRatioVal != "" && !jQuery.isNumeric(rebateRatioVal)){
            BUI.Message.Alert(msg+"必须为正数值型!");
            return false;
        }
        return true;
    }
    
	function delRole(value){
        BUI.Message.Confirm('确认要删除该条目吗？',function(){
            $.ajax({
                url: "${ctx}/admin/sa/userPromotion/deleteOrgRebate",
                type:"post",
                dataType: "json",
                data:{orgId:value},
                success: function(data){
                    if(data.result=="success"){
                        app.showSuccess("删除成功！");
                        $('#btnSearch').click();
                    }else{
                        app.showError("无法删除!");
                    }
                }
            });
        },'question');
     }  
 function nextPrice(){ 
       $("input[type='radio'][name='currentWxShopRebatePull']").change(function(){
        if($(this).val()=="wx_shop_default_rebate_pull"){
			  $("#wxShopRebatePercent").val("");
			  $("#wxShopRebatePercent").attr('disabled',true);
			  $("#wxShopRebate").attr('disabled',false);
         }else{
			 $("#wxShopRebate").val("");
			 $("#wxShopRebate").attr('disabled',true);
			 $("#wxShopRebatePercent").attr('disabled',false);
         }
     })
    
    }

 
</script>
 </body>
 </html>