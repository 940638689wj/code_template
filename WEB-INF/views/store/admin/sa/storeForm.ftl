<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html>
<head>
    <#include "${ctx}/includes/sa/header.ftl"/>
    <link rel="stylesheet" href="${staticPath}/admin/css/timepicki.css" type="text/css"/>
    <script src="${ctx}/static/admin/js/timepicki.js" type="text/javascript"></script>
</head>
<body>
<div class="container">
    <div class="title-bar">
        <div id="tab">
            <ul class="breadcrumb" aria-disabled="false" aria-pressed="false">
                <li aria-disabled="false" aria-pressed="false"><a href="${ctx}/admin/sa/userStore/storeManageList">门店列表</a><span
                        class="divider">&gt;&gt;</span></li>
                <#if storeForm??&&storeForm?has_content>
                    <li class="active">编辑门店</li>
                <#else>
                    <li class="active">新增门店</li>
                </#if>
            </ul>
        </div>
        <ul class="bui-tab nav-tabs">
            <li class="bui-tab-item bui-tab-item-selected">
                <span class="bui-tab-item-text">门店信息</span>
            </li>
        </ul>
    </div>


    <div class="content-body">
        <form id="J_Form" class="form-horizontal" action="${ctx}/admin/sa/userStore/<#if storeForm??&&storeForm?has_content>saveStore<#else>addStore</#if>" method="post">
            <input type="hidden" name="storeId" value="${(storeForm.storeId)!}"/>
            <div id="edit_store_detail_div" class="form-content">
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>门店名称：</label>
                        <div class="controls">
                            <input name="storeName" data-rules="{required:true}" class="input-normal control-text"
                                   value="${(storeForm.storeName)!}">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>门店描述：</label>
                        <div class="controls">
                            <input name="storeDescription" data-rules="{required:true}"
                                   class="input-normal control-text" value="${(storeForm.storeDescription)!}">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>联系方式：</label>
                        <div class="controls">
                            <input value="${(storeForm.telephone)!}" name="telephone"
                                   data-rules="{required:true,regexp:/^1[3|4|5|7|8]\d{9}$/}"
                                   data-messages="{regexp:'不是有效的手机'}"
                                   class="input-normal control-text">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>地址：</label>
                        <div class="controls">
                            <input data-rules="{required:true}"  name="detailAddress"
                                   id="detailAddress" class="input-large control-text" value="${(storeForm.detailAddress)!}">
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s>*</s>提货时间：</label>
                        <div class="controls">
                            <input class="input-maxsmall control-text time_element" data-rules="{required:true}"
                                   id="deliveryTimeAmStart" name="deliveryTimeAmStart" value="${(storeForm.deliveryTimeAmStart)!}"/>
                            <span>至&nbsp;&nbsp;</span>
                            <input class="input-maxsmall control-text time_element" data-rules="{required:true}"
                                   id="deliveryTimeAmEnd" name="deliveryTimeAmEnd" value="${(storeForm.deliveryTimeAmEnd)!}"/>
                            <span>AM</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label"><s></s>：</label>
                        <div class="controls">
                            <input class="input-maxsmall control-text time_element" data-rules="{required:true}"
                                   id="deliveryTimePmStart" name="deliveryTimePmStart" value="${(storeForm.deliveryTimePmStart)!}"/>
                            <span>至&nbsp;&nbsp;</span>
                            <input class="input-maxsmall control-text time_element" data-rules="{required:true}"
                                   id="deliveryTimePmEnd"  name="deliveryTimePmEnd" value="${(storeForm.deliveryTimePmEnd)!}"/>
                            <span>PM</span>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="control-group">
                        <label class="control-label" style="color:red"><s>*</s>状态：</label>
                        <div class="controls" data-rules="{required:true}">
                        	<#assign storeStatus = 0>
                        	<#if storeForm??&&storeForm?has_content &&storeForm.statusCd==1>
                        		<#assign storeStatus = 1>
                        	<#else>
                        		<#assign storeStatus = 0>
                        	</#if>
                            <label><input type="radio" name="statusCd" <#if storeStatus==1>checked="checked"</#if> value="1" id="open"/>启用</label>&nbsp;&nbsp;&nbsp;&nbsp;
                            <label><input type="radio" name="statusCd" <#if storeStatus==0>checked="checked"</#if> value="0" id="off"/>禁用</label>
                        </div>
                    </div>
                </div>
            </div>

            <hr/>

            <div class="actions-bar">
                <button type="submit" class="button button-primary">保存</button>
                <button type="reset" class="button" id="resetBtn">重置</button>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
	var status='${(storeForm.statusCd)?default(0)}';

    $(function(){
    	//时间控件
    	$(".time_element").timeDropper({
            meridians: false,
            format: 'HH:mm',
        });
        
        
        
	    $("#resetBtn").click(function(){
	    	$("input[type=radio]").removeAttr("checked");
	    	if(status == "0"){
	    		$("#off").attr("checked",true);
	    	}else if(status == "1"){
	    		$("#open").attr("checked",true);
	  		}
		});	
	
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#J_Form',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！");
                    window.location.href="${ctx}/admin/sa/userStore/storeManageList";
                }
            }
        }).render();

        form.on('beforesubmit', function(){
            //验证提货时间
            var amStart = $("#deliveryTimeAmStart").val();
            var amEnd = $("#deliveryTimeAmEnd").val();
            var pmStart = $("#deliveryTimePmStart").val();
            var pmEnd = $("#deliveryTimePmEnd").val();

            var amStartStrs = amStart.split(":");
            var amEndStrs = amEnd.split(":");
            var pmStartStrs = pmStart.split(":");
            var pmEndStrs = pmEnd.split(":");
            if(amEndStrs[0]>12||amEndStrs[0]==12 && amEndStrs[1]!=0){
                BUI.Message.Alert("上午提货时间不能大于12点!")
                return false;
            }
            if(amStartStrs[0]>amEndStrs[0]||amStartStrs[0]==amEndStrs[0] && amStartStrs[1]>amEndStrs[1]){
                BUI.Message.Alert("提货开始时间不能大于结束时间!")
                return false;
            }
            if(pmStartStrs[0]<12){
                BUI.Message.Alert("下午提货时间不能小于12点!")
                return false;
            }
            if(pmStartStrs[0]>pmEndStrs[0]||pmStartStrs[0]==pmEndStrs[0] && pmStartStrs[1]>pmEndStrs[1]){
                BUI.Message.Alert("提货开始时间不能大于结束时间!")
                return false;
            }
        });
    });

</script>
</body>
</html>