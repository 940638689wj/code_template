<#assign ctx = request.contextPath>
<#include "${ctx}/macro/sa/roma_macro.ftl"/>
<!DOCTYPE html>
<html>
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container" style="margin-top:-30px;">
<form id="JForm" action="${ctx}/admin/sa/userPromotion/save/awardBarriers" class="form-horizontal search-form" method="post">
<#-- 折上折 -->
    <div class="title-bar">
        <ul class="breadcrumb">
            <div id="tab2"></div>
        </ul>
    </div>
    <#--<label for="rdo_4">是否允许折上折：</label>
    <input type="radio" name="isAdditionalDiscount"  value="true" <#if isAdditionalDiscount?? && (isAdditionalDiscount)?string="true">checked="checked"</#if> />是
    &nbsp;&nbsp;&nbsp;
    <input type="radio" name="isAdditionalDiscount"  value="false" <#if isAdditionalDiscount?? && (isAdditionalDiscount)?string="false">checked="checked"</#if> />否-->
<#-- 微店返利限制-->
   <#-- <div class="title-bar">
        <ul class="breadcrumb">
            <div id="tab4"></div>
        </ul>
    </div>
    <label for="rdo_4">积分/红包/购酒券/优惠券抵扣额返利最高：</label>
    <input type="text" id="couponRebate" name="couponRebate" data-rules="{required:true}" style="width: 40px;" value="${(couponRebate)!}" />&nbsp;&nbsp;元给予奖励,<span style="margin-left: 10px;color: #808080">如不限制订单金额请放空</span>-->
<#-- 发展奖励门槛 -->
    <div class="title-bar">
        <ul class="breadcrumb">
            <div id="tab1"></div>
        </ul>
    </div>
    <#--<label for="rdo_4">首单金额需达到：</label>
    <input type="text" id="amountLimitationFirstOrder" name="amountLimitationFirstOrder" class="control-text" data-rules="{number:true}" style="width: 50px;" value="${(amountLimitationFirstOrder)!}" />&nbsp;&nbsp;元给予奖励,<span style="margin-left: 10px;color: #808080">如不限制订单金额请放空</span>-->

    <div class="row">
        <div class="control-group">
            <label class="control-label" style="width: 92px;">首单金额需达到</label>
            <div class="controls">
                <input type="text" id="amountLimitationFirstOrder" name="amountLimitationFirstOrder" class="control-text" data-rules="{number:true}" style="width: 50px;" value="${(amountLimitationFirstOrder)!}" />&nbsp;&nbsp;元给予奖励,<span style="margin-left: 10px;color: #808080">如不限制订单金额请放空</span>
            </div>
        </div>
    </div>

    <#--<div class="content-body">
        <div id="setting_grid"></div>
    </div>-->

<#-- 奖励上限设置 -->
    <div class="title-bar">
        <ul class="breadcrumb">
            <div id="tab3"></div>
        </ul>
    </div>

<#-- 设置返利的上限 -->
    
        <div class="row">
            <div class="control-group control-row-auto">
                <div class="controls">
                    <div class="pull-left">
                        <span style="width: 390px;">发展会员奖励：每个推广会员每个月发展会员可获得的奖励不超过：</span>
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(bonusUpperlimitDevelopUser)!}" name="bonusUpperlimitDevelopUser" id="bonusUpperlimitDevelopUser">&nbsp;&nbsp;元&nbsp;&nbsp;
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(bonusPointUpperlimitDevelopUser)!}" name="bonusPointUpperlimitDevelopUser" id="bonusPointUpperlimitDevelopUser">&nbsp;&nbsp;积分    
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group control-row-auto">
                <div class="controls">
                    <div class="pull-left">
                        <span style="width: 390px;">发展分销返利：每个推广会员每个月所获得的返利不超过：</span>
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(rebateDevelopDistributors)!}" name="rebateDevelopDistributors" id="rebateDevelopDistributors">&nbsp;&nbsp;元
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group control-row-auto">
                <div class="controls">
                    <div class="pull-left">
                        <span style="width: 390px;">首单奖励：每个推广会员每个月最多获得首单奖励不超过：</span>
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(bonusUpperlimitFirstOrder)!}" name="bonusUpperlimitFirstOrder" id="bonusUpperlimitFirstOrder">&nbsp;&nbsp;元
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group control-row-auto">
                <div class="controls">
                    <div class="pull-left">
                        <span style="width: 390px;">商品佣金：每个推广会员每个月推广自己店铺商品所获得的佣金不超过：</span>
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(productCommission)!}" name="productCommission" id="productCommission">&nbsp;&nbsp;元
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group control-row-auto">
                <div class="controls">
                    <div class="pull-left">
                        <span style="width: 390px;">商品URL返利：每个推广会员每个月推广商品获得返利不超过：</span>
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(shopInShopRebateUpperlimit)!}" name="shopInShopRebateUpperlimit" id="shopInShopRebateUpperlimit">&nbsp;&nbsp;元


                    <#-- 首单需要满足的奖励条件 
                        <input type="text" hidden="hidden" value="" name="FIRST_ORDER_AWARD_CONDITION" id="FIRST_ORDER_AWARD_CONDITION_HIDDEN">-->
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="control-group control-row-auto">
                <div class="controls">
                    <div class="pull-left">
                        <span style="width: 390px;">下级微店主返利：每个推广会员每个月获得下级微店的分销返利不超过：</span>
                        <input style="width: 50px;" data-rules="{required:true}" type="text" class="control-text"
                               value="${(lowerWxShopRebate)!}" name="lowerWxShopRebate" id="lowerWxShopRebate">&nbsp;&nbsp;元
                    </div>
                </div>
            </div>
        </div>
        <#-- 奖励上限设置 -->
    	<div class="title-bar">
	        <ul class="breadcrumb">
	            <div id="tab5"></div>
	        </ul>
        	<label for="rdo_4" class="control-label control-label-auto">用户在：</label>
    		<input type="text" class="calendar control-text" name="pointUpperlimitStartData" id="pointUpperlimitStartData" value="${(pointUpperlimitStartData)!}">
                            到
        	<input type="text" class="calendar control-text" name="pointUpperlimitEndData" id="pointUpperlimitEndData" value="${(pointUpperlimitEndData)!}">
       	 最高可获得
        	<input type="text" class="control-text" name="pointUpperlimit" id="pointUpperlimit" value="${(pointUpperlimit)!}">
 		积分
    	</div>
    	<br/>
    	<br/>
	        <div class="row">
	            <button id="btnSave" class="button button-primary">保 存</button>
	        </div>
    </form>


<#-- 设置返利上限下限 
    <div id="rebateSettingDialog" style="display: none;">
        <form id="settingForm" class="form-horizontal search-form">
            <input type="hidden" name="id" id="id">
            <input type="hidden" name="settingType" id="settingType">
            <input type="hidden" name="settingSort" id="settingSort">

            <!-- 临时解决方案，显示出错 找不到nextSettingName或nextFloor
                
            <input type="hidden" name="nextFloor" id="nextFloor">
            <input type="hidden" name="nextSettingName" id="nextSettingName">

            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls">
                        <div class="pull-left">
                            门槛名称：
                            <input style="width: 200px;" data-rules="{required:true}" type="text" class="control-text"
                                   name="settingName" id="settingName">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls">
                        <div class="pull-left">
                            发展会员：
                            <input style="width: 85px;" type="text" class="control-text" name="floor" id="floor">
                            至
                            <input style="width: 85px;" type="text" class="control-text" name="ceiling" id="ceiling">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls">
                        <div class="pull-left">
                            发展奖励：
                            <input style="width: 200px;" type="text" class="control-text" name="rebate" id="rebate">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="control-group control-row-auto">
                    <div class="controls">
                        <div class="pull-left">
                            首单奖励：
                            <input style="width: 200px;" type="text" class="control-text" name="firstRebate" id="firstRebate">
                        </div>
                    </div>
                </div>
            </div>
            <div class="row" style="color: #ff0000;">
                如果有上级门槛,则只有超出上级门槛部分的数量才以本规则中的奖励计算
            </div>

        </form>
    </div>-->
</div>

<script type="text/javascript">
    BUI.use(['common/search', 'common/page'], function (Search) {
        var tab1 = new BUI.Tab.Tab({
            render: '#tab1',
            elCls: 'nav-tabs',
            autoRender: true,
            children: [
                {text: '奖励门槛', value: '0'}
            ]
        });
        tab1.setSelected(tab1.getItemAt(0));
        
        /*var tab2 = new BUI.Tab.Tab({
            render: '#tab2',
            elCls: 'nav-tabs',
            autoRender: true,
            children: [
                {text: '折上折', value: '0'}
            ]
        });
        tab2.setSelected(tab2.getItemAt(0));*/

        var tab3 = new BUI.Tab.Tab({
            render: '#tab3',
            elCls: 'nav-tabs',
            autoRender: true,
            children: [
                {text: '奖励上限设置', value: '0'}
            ]
        });
        tab3.setSelected(tab3.getItemAt(0));
        
        /*var tab4 = new BUI.Tab.Tab({
            render: '#tab4',
            elCls: 'nav-tabs',
            autoRender: true,
            children: [
                {text: '微店返利限制', value: '0'}
            ]
        });
        tab4.setSelected(tab4.getItemAt(0));*/
        
        var tab5 = new BUI.Tab.Tab({
            render: '#tab5',
            elCls: 'nav-tabs',
            autoRender: true,
            children: [
                {text: '获取积分上限设置', value: '0'}
            ]
        });
        tab5.setSelected(tab5.getItemAt(0));
		<#--
        /**
         * 新增门槛设置
         *
         * @param grid
         */
        function openRebateSetting(grid, checkData) {
            var rebateSettingDialog = app.createDialog(function () {
                if (!checkForm(grid, checkData)) {
                    return;
                }
                // 提交表单
                var postJson = $("#settingForm").serializeArray();
                submit(postJson, function () {
                    grid.reload();
                    rebateSettingDialog.close();
                })
            }, {title: '门槛编辑页', height: 400, width: 430, contentId: 'rebateSettingDialog', closeAction: 'destroy'});
            rebateSettingDialog.show();
        }
		-->
    	
        /**
         * 提交表单
         *
         * @param params
         * @param successCallback
         */
        function submit(params, successCallback) {
            $.ajax({
                type: 'POST',
                url: '${ctx}/admin/sa/userPromotion/save/awardBarriers',
                data: params,
                dataType: 'json',
                success: function (data) {
                    if (data.error) {
                        alert("服务器出错，请过会再试！");
                    } else {
                        if (typeof(successCallback) == 'function') {
                            successCallback();
                        }
                    }
                },
                error: function (xhr, type) {
                    alert("服务器出错，请过会再试！");
                }
            });
        }
		<#--
        /**
         * 删除返利设置
         *
         * @param params
         * @param successCallback
         */
        function deleteById(params, successCallback) {
            $.ajax({
                type: 'POST',
                url: '${ctx}/admin/rebateSetting/delete',
                data: params,
                dataType: 'json',
                success: function (data) {
                    if (data.error) {
                        alert("服务器出错，请过会再试！");
                    } else {
                        if (typeof(successCallback) == 'function') {
                            successCallback();
                        }
                    }
                },
                error: function (xhr, type) {
                    alert("服务器出错，请过会再试！");
                }
            });
        }-->
		
        /**
         * 校验表单填写
         *
         * @param grid
         */
        function checkForm(grid, checkData) {
            var settingName = $('#settingName').val();
            var floor = $('#floor').val();
            var ceiling = $('#ceiling').val();
            var rebate = $('#rebate').val();
            var firstRebate = $('#firstRebate').val();
            var id = $('#id').val();

            if (settingName == undefined || settingName == '') {
                $('#settingName').focus();
                alert('请填写奖励门槛名称!');
                return false;
            }
            if (floor == undefined || floor == '') {
                $('#floor').focus();
                alert('请填写发展会员数下限!');
                return false;
            }
            if (ceiling == undefined || ceiling == '') {
                $('#ceiling').focus();
                alert('请填写发展会员数上限!');
                return false;
            }
            if (rebate == undefined || rebate == '') {
                $('#rebate').focus();
                alert('请填写发展奖励!');
                return false;
            }
            if (firstRebate == undefined || firstRebate == '') {
                $('#firstRebate').focus();
                alert('请填写首单奖励!');
                return false;
            }
            var reg = /^[0-9]*$/;
            if (!reg.test(ceiling) || !reg.test(floor)) {
                alert("上限及下限值请填写正整数!");
                return false;
            }
            var ceiling_int = parseInt(ceiling);
            var floor_int = parseInt(floor);
            if (ceiling_int <= floor_int) {
                $('#ceiling').focus();
                alert('上限值要大于下限!');
                return false;
            }
            var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
            if (!exp.test(rebate)) {
                alert("返利金额请填写数字!");
                return false;
            }
            if (checkData != null) {
                var lastId = checkData["id"];
                if (id != null && id != '' && id < lastId) {
                    if (ceiling_int != (checkData['floor'] - 1)) {
                        alert("会员发展数的上限要等于[" + checkData["settingName"] + "]的下限减1.");
                        return false;
                    }
                } else {
                    var lastCeiling = parseInt(checkData["ceiling"]);
                    if (floor_int <= lastCeiling) {
                        alert("会员发展数的下限不能小于或等于[" + checkData["settingName"] + "]的上限!");
                        return false;
                    }
                    if (floor_int > (lastCeiling + 1)) {
                        alert("会员发展数的下限不能大于[" + checkData["settingName"] + "]的上限加1.");
                        return false;
                    }

                    // 判断设置的上限
                    var nextFloor = checkData["nextFloor"];
                    if(nextFloor != null) {
                        if (ceiling_int != (nextFloor - 1)) {
                            alert("会员发展数的上限要等于[" + checkData["nextSettingName"] + "]的下限减1.");
                            return false;
                        }
                    }
                }
            }
            return true;
        }

        // 保存设置上限
        $('#btnSave').on('click', function() {
            var bonusUpperlimitDevelopUser = $('#bonusUpperlimitDevelopUser').val();
            var bonusPointUpperlimitDevelopUser = $('#bonusPointUpperlimitDevelopUser').val();
            var rebateDevelopDistributors = $('#rebateDevelopDistributors').val();
            var bonusUpperlimitFirstOrder = $('#bonusUpperlimitFirstOrder').val();
            var productCommission = $('#productCommission').val();
            var shopInShopRebateUpperlimit = $('#shopInShopRebateUpperlimit').val();
            var amountLimitationFirstOrder = $('#amountLimitationFirstOrder').val();
            var lowerWxShopRebate = $('#lowerWxShopRebate').val();
            var couponRebate =$('#couponRebate').val();
            var pointUpperlimit = $('#pointUpperlimit').val();

			var exp = /^([1-9][\d]{0,7}|0)(\.[\d]{1,2})?$/;
            if(bonusUpperlimitDevelopUser != '') {
                if (!exp.test(bonusUpperlimitDevelopUser)) {	
                    BUI.Message.Alert("发展会员金额奖励上限请填写数字!");
                    return false;
                }
            }
            if(bonusPointUpperlimitDevelopUser != '') {
                if (!/^\d*$/.test(bonusPointUpperlimitDevelopUser)) {
                    BUI.Message.Alert("发展会员积分奖励上限请填写正整数!");
                    return false;
                }
            }
            if(rebateDevelopDistributors != '') {
                if (!exp.test(rebateDevelopDistributors)) {
                    BUI.Message.Alert("发展分销返利上限请填写数字!");
                    return false;
                }
            }
            if(bonusUpperlimitFirstOrder != '') {
                if (!exp.test(bonusUpperlimitFirstOrder)) {
                    BUI.Message.Alert("首单奖励上限请填写数字!");
                    return false;
                }
            }
            if(productCommission != '') {
                if (!exp.test(productCommission)) {
                    BUI.Message.Alert("商品佣金上限请填写数字!");
                    return false;
                }
            }
            if(shopInShopRebateUpperlimit != '') {
                if (!exp.test(shopInShopRebateUpperlimit)) {
                    BUI.Message.Alert("商品URL返利上限请填写数字!");
                    return false;
                }
            }
            if(lowerWxShopRebate != '') {
                if (!exp.test(lowerWxShopRebate)) {
                    BUI.Message.Alert("下级微店返利上限请填写数字!");
                    return false;
                }
            }

            var startPointUpperLimit=$("#pointUpperlimitStartData").val();
            var EndPointUpperLimit=$("#pointUpperlimitEndData").val();
            if(startPointUpperLimit!="" ){
                if(EndPointUpperLimit =="" || EndPointUpperLimit==null){
                    BUI.Message.Alert("结束时间不能为空");
                    return false;
                }
            }

            if(EndPointUpperLimit !="" ){
                if(startPointUpperLimit =="" || startPointUpperLimit==null){
                    BUI.Message.Alert("开始时间不能为空");
                    return false;
                }
            }
            if (pointUpperlimit != ""){
                if(startPointUpperLimit=="" || startPointUpperLimit==null){
                    BUI.Message.Alert("开始时间不能为空");
                    return false;
                }
                if(EndPointUpperLimit =="" || EndPointUpperLimit==null){
                    BUI.Message.Alert("结束时间不能为空");
                    return false;
                }
            }
            if(EndPointUpperLimit !="" && startPointUpperLimit !=""){
                var start_=new Date(startPointUpperLimit.replace("-", "/").replace("-", "/"));
                var end_=new Date(EndPointUpperLimit.replace("-", "/").replace("-", "/"));
                var now =new Date();

                if(start_ > end_){
                    BUI.Message.Alert("结束时间不得小于开始时间!");
                    return false;
                }
                if(now > end_){
                    BUI.Message.Alert("结束时间不得小于当前时间!");
                    return false;
                }
                if(pointUpperlimit==""){
                    BUI.Message.Alert("最高可获取积分不能为空!");
                    return false;
                }
                if (!/^\d*$/.test(pointUpperlimit)) {
                    BUI.Message.Alert("最高可获取积分请填写正整数!");
                    return false;
                }
            }
    });
        });
        
        	
    $(function(){
        var Form = BUI.Form
        var form = new Form.Form({
            srcNode: '#JForm',
            submitType: 'ajax',
            callback: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    app.showSuccess("保存成功！")
                }
            }
        }).render();

    });
</script>
</body>
</html>