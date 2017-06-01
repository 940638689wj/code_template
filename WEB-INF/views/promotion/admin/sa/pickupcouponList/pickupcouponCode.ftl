<#assign ctx = request.contextPath>
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html">
<head>
<#include "${ctx}/includes/sa/header.ftl"/>
</head>
<body>
<div class="container">
    <ul class="breadcrumb">
        <li><a href="${ctx}/admin/sa/pickupcouponList?statusCd=${statusCd!1}">提货券列表</a><span
                class="divider">&gt;&gt;</span></li>
        <li class="active">提货券详情</li>
    </ul>
    <div class="title-bar">
        <div class="title-bar">
            <div id="tab"></div>
        </div>
        <div class="content-top">
            <form id="searchForm" class="form-horizontal search-form">
                <input name="statusCd" id="statusCd" value="${statusCd!}" type="hidden"/>
                <input name="pickupCouponListId" id="pickupCouponListId" value="${pickupCouponListId!}" type="hidden"/>
                <div class="content-top">
                    <input id="numOrPhone" name="numOrPhone" class="control-text" placeholder=" 提货券号码/手机号">
                    &nbsp;&nbsp;
                    <button id="btnSearch" type="submit" class="button button-primary">搜索</button>
                    &nbsp;&nbsp;
                    <button id="exportPickPcoutonCode" type="button" class="button button-primary">导出</button>
                    &nbsp;&nbsp;
                    <button id="choiceUser" type="button" class="button button-primary">选择会员</button>
                    <span style="color: grey">可点击手机号一栏手动输入</span>
                </div>
            </form>
        </div>
        <div class="content-body">
            <div class="title-bar-side">
                <div class="search-content">
                </div>
            </div>
            <div id="grid"></div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var search;
    var grid;
    var height = getContentHeight();
    var higherUserLevelDialog;

    BUI.use(['common/search', 'common/page'], function (Search) {
        var columns = [
            {title: '编号', dataIndex: 'pickupCouponCodeId', width: 100},
            {title: '二维码', dataIndex: '', width: 150,renderer:function(value,rowObj){
                var content = 'num:'+rowObj.pickupCouponCodeNum+'_password:'+rowObj.pickupCouponPassword;
                return '<img class="qrCodeSmallImg" src="${ctx}/qrCode/generate?content='+content+'" style="width:30px;height: 30px;cursor: pointer;" />';
            }},
            {title: '提货券号码', dataIndex: 'pickupCouponCodeNum', width: 150},
            {title: '随机密码', dataIndex: 'pickupCouponPassword', width: 120},
            {title: '手机号', dataIndex: 'phone', width: 100,editor : {xtype : 'text',validator : validatePhone},renderer:function(value,rowObj) {
                var ph = rowObj.phone;
                var uph = rowObj.numOrPhone;
                if(ph !=undefined &&  ph !=null){
                    return ph;
                }else if(uph !=undefined && uph !=null){
                    return uph;
                }else {
                    return "";
                }
            }},
//            {title: '姓名', dataIndex: 'nickName', width: 100},
            {
                title: '有效使用时间', dataIndex: '', width: 200, renderer: function (value, rowObj) {
                var cardNum = "";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseStartTime);
                cardNum += " 至 ";
                cardNum += BUI.Grid.Format.dateRenderer(rowObj.allowUseEndTime);
                return cardNum;
            }
            },
            {title: '使用状态', dataIndex: 'usedStatusName', width: 80},
            {
                title: '发送状态', dataIndex: '', width: 80, renderer: function (value, rowObj) {
                if (rowObj.isSmsSendStatus == 1) {
                    return '未发送';
                } else if (rowObj.isSmsSendStatus == 2) {
                    return '已发送';
                }
            }
            },
            {
                title: '操作', dataIndex: '', width: 150, renderer: function (value, rowObj) {
                if (rowObj.isSmsSendStatus == 1 && rowObj.phone) {
                    return '<a href="javascript:void(0)" onclick="smsSend(' + rowObj.pickupCouponCodeId + ')">发送</a>';
                }
                return '';
            }
            }
        ];
        var editing = new BUI.Grid.Plugins.CellEditing({
            triggerSelected : false //触发编辑的时候不选中行
        });
        var store = Search.createStore('/admin/sa/pickupcouponCode/grid_json', {pageSize: 15});
        var gridCfg = Search.createGridCfg(columns, {
            plugins: [editing,BUI.Grid.Plugins.ColumnResize],
            stripeRows: false,
            width: '100%',
            height: height,
            render: '#grid',
            columns: columns
            , tbar: {
                items: [
//                    {text: '批量删除', btnCls: 'button button-small button-primary', handler: batchDeleteFunction},
//                    {text: '新增提货券', btnCls: 'button button-small button-primary', handler: addFunction},
//                    {text: '导出', btnCls: 'button button-small button-primary', handler: exportFunction}
                ]
            }
        });

        search = new Search({
            store: store,
            gridCfg: gridCfg
        });
        grid = search.get("grid");

        grid.render();

        //监听表格修改操作，更新手机号
        store.on('update', function (e) {
            var pId = $("#pickupCouponListId").val();
            var statusCd = $("#statusCd").val();
            $.post('${ctx}/admin/sa/pickupcouponCode/updatePhone',{
                pickupCouponCodeId : e.record.pickupCouponCodeId,pickupCouponListId:pId,
                phone : e.value
            },function (data) {
                if(data.result=="error"){
                    <#--window.location.href="${ctx}/admin/sa/pickupcouponCode?pickupCouponId="+e+"&statusCd="+statusCd;-->
                    search.load();
                }
                if(app.ajaxHelper.handleAjaxMsg(data)){

                }
            },'json');
        });

    });

    /**
     * 更改启用状态
     *
     * @param pickupCouponId    提货券id
     * @param statusCd  更改后状态
     */
    function validatePhone(value,obj){
        if(obj.isSmsSendStatus == 2) {
            return '已发送短信则无法修改';
        }
        if(!(/^1(3|4|5|7|8)\d{9}$/.test(value))){
            return '手机号格式不正确';
        }
        var selectedCustomer = grid.__attrVals.items;//grid.getSelection();
        for (var i = 0; i < selectedCustomer.length; i++) {
            if(value ==selectedCustomer[i].phone){
                return '手机号码已经被使用！';
            }
        }
    }

    function exportFunction() {

    }

    /**
     * 更改启用状态
     *
     * @param pickupCouponId    提货券id
     * @param statusCd  更改后状态
     */
    function changeStatus(pickupCouponId, statusCd) {
        $.ajax({
            type: "POST",
            url: "${ctx}/admin/sa/pickupcouponList/changeStatus",
            data: {
                pickupCouponId: pickupCouponId,
                statusCd: statusCd
            },
            dataType: "json",
            success: function (data) {
                if (app.ajaxHelper.handleAjaxMsg(data)) {
                    search.load();
                }
            }
        });
    }

    /**
     * 发送短信
     */
    function smsSend(pickupCouponCodeId) {
        $.post('${ctx}/admin/sa/pickupcouponCode/smsSend',{
            pickupCouponCodeId : pickupCouponCodeId
        },function (data) {
            if(app.ajaxHelper.handleAjaxMsg(data)){
                app.showSuccess('发送成功');
                search.load();
            }
        },'json');
    }

    $(function () {
        $("#numOrPhone").on('keyup',function(){
            if(event.keyCode ==13){
                $('#btnSearch').click();
            }
        });

        var x = 5;
        var y = 5;
        $(".qrCodeSmallImg").live('mouseover', function (ev) {
            var tooltip = "<div id='tooltip' style='position:absolute;background:#333;padding:2px;display:none;color:#fff;'><img src='" + $(this).attr("src") + "'><\/div>"; //创建 div 元素
            $("body").append(tooltip);	//把它追加到文档中
            $("#tooltip").css({
                "top": (ev.pageY + y) + "px",
                "left": (ev.pageX + x) + "px"
            }).show("fast");	  //设置x坐标和y坐标，并且显示
        }).live('mouseout', function () {
            $("#tooltip").remove();	 //移除
        }).live('mouseover', function (e) {
            $("#tooltip").css({
                "top": (e.pageY + y) + "px",
                "left": (e.pageX + x) + "px"
            });
        });

    });

    //导出
    $("#exportPickPcoutonCode").on('click',function (){
        var pickListId = $("#pickupCouponListId").val();
        var statusCd = $("#statusCd").val();
        window.location.href="${ctx}/admin/sa/pickupcouponCode/exportPickPcoutonCode?pickupCouponListId="+pickListId+"&statusCd="+statusCd;
    });

    //选择会员
    $("#choiceUser").on('click',function (){
        var params = { //配置初始请求的参数
            choiceType: 'radio'
        };
        var selectedCustomer = grid.__attrVals.items;//grid.getSelection();
        var flag = 0;
        for (var i = 0; i < selectedCustomer.length; i++) {
            if(selectedCustomer[i].phone !=null && selectedCustomer[i].phone !="" ) {
                flag++;
            }
        }
        if(flag ==selectedCustomer.length){
            BUI.Message.Alert("当前没有尚未分配的券！");return;
        } else {
            higherUserLevelDialog.get('loader').load(params);
            higherUserLevelDialog.show();
        }
    });
    /*设置选择会员*/
    var Overlay = BUI.Overlay;
    higherUserLevelDialog = new Overlay.Dialog({
        title: '会员列表',
        width: 780,
        height: 500,
        loader: {
            url: '${ctx}/admin/sa/pickupcouponCode/choiceUserList',
            autoLoad: false, //不自动加载
            lazyLoad: false //不延迟加载
        },
        buttons: [{
            text: '选 择',
            elCls: 'button button-primary',
            handler: function () {
                var selectedHigherCustomer = getSelectedRecords();
                if (selectedHigherCustomer.length <= 0) {
                    BUI.Message.Alert("请选择会员!");
                    return false;
                }
                this.close();
                customerChoiceEvent(selectedHigherCustomer);
            }
        }, {
            text: '取消选择',
            elCls: 'button button-primary',
            handler: function () {
                this.close();
            }
        }],
        mask: true
    });

    function customerChoiceEvent(selectedHigherCustomer) {
        //获取到未分配的券
        var selectedCustomer = grid.__attrVals.items;//grid.getSelection();
        var selectedCustomerIds = [];
        var noSelectedCustomerIds = [];
        var phones ="";
        for (var i = 0; i < selectedCustomer.length; i++) {
            if(selectedCustomer[i].phone ==null || selectedCustomer[i].phone =="" ) {
                selectedCustomerIds.push(selectedCustomer[i].pickupCouponCodeId);
            }else{
                noSelectedCustomerIds.push(selectedCustomer[i]); //将有手机号码的存储起来
            }
        }
        var postData = {pickupCouponCodeIds: selectedCustomerIds};
        var pId = $("#pickupCouponListId").val();
        postData.pickupCouponListId = pId;
        //选择的会员
        if (selectedHigherCustomer.length > 0) {
            var selectedHigherCustomerIds = [];
            for(var i = 0; i < selectedHigherCustomer.length; i++) {
                var j=0;
                for(;j<noSelectedCustomerIds.length;j++){
                    if(selectedHigherCustomer[i].phone==noSelectedCustomerIds[j].phone){
                        phones += selectedHigherCustomer[i].phone+" ";
                        break;
                    }
                }
                if(j==noSelectedCustomerIds.length) {
                    selectedHigherCustomerIds.push(selectedHigherCustomer[i].userId);
                }
            }
            var messageStr ="是否继续分配提货券";
            if(phones !=""){
                messageStr = ",其中"+phones+"已分配券，是否继续分配其它会员?";
            }
            postData.userIds = selectedHigherCustomerIds;
            if(selectedHigherCustomer.length > selectedCustomerIds.length){
                BUI.Message.Confirm('当前选择会员数大于未分配的提货券'+messageStr, function (){
                    candleEvent(postData);
                },'question');
            }else if(selectedHigherCustomer.length < selectedCustomerIds.length){
                BUI.Message.Confirm('当前选择会员数小于未分配的提货券'+messageStr, function (){
                    candleEvent(postData);
                },'question');
            }else if(selectedHigherCustomer.length == selectedCustomerIds.length){
                if(phones !=""){
                    BUI.Message.Alert(phones+"已分配券!");
                }
                candleEvent(postData);
            }
        }
    }

    function candleEvent(postData){
        console.log(postData);
        $.ajax({
            url: '${ctx}/admin/sa/pickupcouponCode/candleEvent',
            dataType: 'json',
            type: 'POST',
            data: postData,
            success: function (data) {
                console.log(data);
                if (data.result == "success") {
                    BUI.Message.Alert("分配券成功!");
                    search.load();
                } else {
                    var errorMsg = data.message;
                    if (errorMsg && errorMsg != "") {
                        BUI.Message.Alert(errorMsg);
                    } else {
                        BUI.Message.Alert("分配券失败!");
                    }
                }
            }
        });
    }
</script>
</body>
</html>