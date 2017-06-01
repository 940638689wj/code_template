<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title提货券订单</title>
    <style>[v-cloak] {
        display: none
    }</style>
</head>
<body>
<div id="page" v-cloak="">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="${ctx}/m/account/otherOrder/index"></a>
        <h1 class="mui-title">提货券订单</h1>
        <a class="mui-icon"></a>
    </header>
    <div class="mui-content">
        <div class="skutabbar">
            <ul id="orderTab">
                <li v-for="(typeName,index) in typeNameList" v-bind:class="{selected :type == index}">
                    <a href="javascript:void(0)" v-on:click="type = index">
                        {{typeName}}
                    </a>
                </li>
            <#--
           <li class="selected"><a href="#" onclick="changeType(2,this)">待付款</a></li>
           <li><a href="#" onclick="changeType(4,this)">代发货</a></li>
           <li><a href="#" onclick="changeType(5,this)">待评价</a></li>
           <li><a href="#" onclick="changeType(6,this)">已完成</a></li>
           <li><a href="#" onclick="changeType(1,this)">已取消</a></li>
           -->
            </ul>
        </div>

        <div class="financiallistWrap">
            <div class="order_list">
                <ul>
                    <li class="list" v-for="order in orderList">
                        <div class="hd">
                            <span class="r">{{new Date(order.createTime).format('yyyy-MM-dd hh:mm:ss')}}</span>
                            <span class="l">订单号:{{order.orderNumber}}</span>
                        </div>
                        <div class="items" v-for="product in order.orderItemList">
                            <a v-bind:href="'${ctx}/m/account/pickupOrder/detail?orderId='+order.orderId">
                                <div class="pic"><img v-bind:src="product.productPicUrl"></div>
                                <h3>{{product.productName}}</h3>
                                <p class="price">￥<em>{{product.salePrice}}</em></p>
                                <p class="spec">数量:{{product.quantity}}</p>
                            </a>
                        </div>
                        <div class="ft">共{{order.pickNumAmt}}件商品,&nbsp;合计:<span>￥{{order.orderTotalAmt}}</span></div>
                        <div class="cz" v-if="order.orderStatusCd == 1">
                        <#--2 待付款 取消+付款-->
                            <a class="mui-btn mui-btn-danger mui-btn-outlined"
                               href="#" @click="rePay(order.orderId)">付款</a>
                            <a class="mui-btn mui-btn-outlined"
                               href="#" @click="cancelOrder(order.orderId)">取消订单</a>
                            <a class="mui-btn mui-btn-outlined"
                            href="#" @click="paymentDel(order.orderId)">删除订单</a>

                        </div>
                        <div class="cz" v-if="order.orderStatusCd == 3 && order.orderDistrbuteTypeCd == 1">
                            <a class="mui-btn mui-btn-outlined"
                               href="javascript:" @click="confirmOrder(order.orderId)">确认收货</a>
                        </div>
                        <div class="cz" v-if="order.orderStatusCd == 6">

                            <a class="mui-btn mui-btn-outlined"
                               href="#" @click="deleteOrder(order.orderId)">删除订单</a>
                        </div>
                    </li>
                </ul>

                <div class="iconinfo" v-show="orderList.length == 0 && isEmpty">
                    <i class="ico ico-info"></i>
                    <strong>没有订单</strong>
                </div>
            </div>
        </div>
    </div>
    <div id="J_ASSpec" class="actionsheet-spec">
        <!--微信支付-->
        <div class="payment-method" v-show='isBalancePay?false:true'>
            <div class="close"></div>
            <div class="prod-info">
                <div class="title">请选择支付方式</div>
            </div>
            <div class="spec-list">
                <div class="spec-list-wrap">
                    <ul class="tbviewlist paytypes">
                        <li v-for="(value,key) in bussinessConfigTypeList">
                            <a href="javascript:void(0)" onclick="toPay('alipay')"
                               v-if="key == 'config_alipay_mobile'">支付宝支付</a>
                            <a href="javascript:void(0)" onclick="toPay('unionpay')"
                               v-if="key == 'config_unionpay_mobile'">银联支付</a>
                            <a href="javascript:void(0)" onclick="toPay('wechatpay')"
                               v-if="key == 'weixin_pay_config'">微信支付</a>
                            <a href="javascript:void(0)" @click="isBalancePay = true"
                               v-if="key == 'userBalnce'">余额支付</a>
                        </li>

                        <#--
                        <li v-show='isWxBrowser'>
                            <a href="javascript:void(0)" onclick="toPay('wechatpay')">微信支付</a>
                        </li>
                        <li id="balancePay">
                            <a href="javascript:void(0)" @click="isBalancePay = true">余额支付</a>
                        </li>
                        <li v-show='isWxBrowser?false:true'>
                            <a href="javascript:void(0)" onclick="toPay('alipay')">支付宝</a>
                        </li>
                        -->
                    </ul>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button cancelBtn">取消</a>
                    </div>
                </div>
            </div>
        </div>

        <!--余额支付-->
        <div class="ye-payment" v-show='isBalancePay'>
            <div class="prod-info">
                <div class="title">支付订单金额<span class="orange">￥{{balancePayAmt}}</span>元</div>
            </div>
            <div class="paymentwrap">
                <div class="orderinfo">
                    <p v-show="hasPayPwd">当前余额￥{{userBalance}}</p>
                    <P>请{{hasPayPwd?'输入':'设置'}}支付密码</P>
                </div>
                <div class="pwd-box">
                    <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
                    <div class="fake-box" v-show='hasPayPwd'>
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                        <input type="password" readonly="">
                    </div>
                </div>
                <div class="orderinfo" v-show='hasPayPwd?false:true'>
                    <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="javaScript:setPayPwd()" class="textcolor">设置支付密码</a>！</p>
                </div>
            </div>

            <div class="fbbwrap-total nofixed">
                <div class="ftbtnbar">
                    <div class="button-wrap button-wrap-expand">
                        <a href="javascript:void(0)" class="button" onclick="checkPayPwd()">确定</a>
                        <a href="javascript:void(0)" class="button cancel">取消</a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="show-abnormal-bg" id="returnDlg1"></div>
    <div class="mui-abnormal" id="returnDlg2">
        <div class="ordercancel">
            <div class="info">
                <h3>请选择退款原因：</h3>
                <div class="selectbox">
                    <select v-model="applyReasonCd">
                    <#list orderReturnReasonList as orderReturnReason>
                        <li>
                            <option value="${orderReturnReason.codeId}">
                            ${orderReturnReason.codeCnName}
                            </option>
                        </li>
                    </#list>
                    </select>
                </div>
                <h3>退款备注：</h3>
                <textarea v-model="reasonDetailDesc"></textarea>
            </div>
            <div class="refundbtn">
                <a href="javascript:void(0);" @click="subRefund">提交</a>
                <a href="javascript:void(0);" id="change">取消</a>
            </div>
        </div>
    </div>
</div>
</div>
<script type="text/javascript" src="${staticPath}/mobile/js/dropload.js"></script>
<script type="text/javascript" src="${ctx}/static/mobile/js/sha1.js"></script>

<script>
    var app = new Vue({
        el: '#page',
        data: {
            bussinessConfigTypeList: {}, // 所有支付类型
            typeNameList:['全 部','待付款','待发货','待收货','已完成','已取消'],
            orderList: [],
            type: ${type!0},
            isEmpty: false,
            hasPayPwd:false,
            isBalancePay:false,
            balancePayAmt:0,
            userBalance:0,
            currentOrderId:0,
            reasonDetailDesc:'',
            applyReasonCd: 0
        },
        computed: {
            isWxBrowser: function () {
                var ua = navigator.userAgent.toLowerCase();
                return ua.match(/MicroMessenger/i)=="micromessenger"
            }
        },
        watch : {
            type: function(){
                this.orderList = [];
                Vue.nextTick(function () {
                    page = 0;
                    $(".dropload-down").remove();
                    this.isEmpty = false;
                    jsonData();
                })

            }
        },
        methods: {
            rePay: function (orderId) {
                this.currentOrderId = orderId;
                $.get('${ctx}/account/pickupOrder/repayJson', {orderId: orderId}, function (data) {
                    if(new Date(data.allowUseEndTime) < new Date()){
                        mui.alert("该提购券已过期，无法购买！");
                        return false;
                    }
                    app.bussinessConfigTypeList = data.bussinessConfigTypeList;
                   // data.orderPayAmt >data.userBalance ? $('#balancePay').hide() : $('#balancePay').show();
                    app.balancePayAmt = data.orderPayAmt;
                    app.userBalance = data.userBalance;
                    if(data.payPassword != null && data.payPassword != '') app.hasPayPwd = true;
                    paymentshow();
                })
            },
            confirmOrder: function(orderId){
                var btnArray = ['取消','确认'];
                mui.confirm('','是否确定收货？',btnArray,function(e){
                    if(e.index == 0){

                    }else{
                        $.post('${ctx}/account/pickupOrder/confirmOrder',{'orderId':orderId},function(data){
                            if(data.result == 'success'){
                                mui.toast('交易完成');
                                location.reload();
                            }else{
                                mui.toast("操作失败");
                            }
                        });
                    }
                })
            },
            cancelOrder: function (orderId) {
                mui.prompt('', '', '请输入取消原因', ['取消', '确认'], function (e) {
                    if (e.index == 1) {
                        $.get('${ctx}/account/pickupOrder/cancelPickOrder', {orderId: orderId, reason: e.value}, function (data) {
                            if (data.result == 'success') {
                                mui.toast('取消成功！');
                                location.reload();
                            } else {
                                mui.alert(data.message);
                            }
                        });
                    }
                })
            },
            paymentDel: function(orderId){
                mui.confirm("","删除订单不能找回",["取消","确认"],function(e){
                    if(e.index == 1){
                        $.get("${ctx}/account/pickupOrder/paymentDel",{orderId:orderId},function(data){
                            if(data.result == "success"){
                                mui.toast('删除成功!');
                                location.reload();
                            }else{
                                mui.toast(data.message);
                            }
                        })
                    }
                })
            },
            deleteOrder: function (orderId) {
                mui.confirm('','删除订单不能找回',['取消','确认'], function (e) {
                    if (e.index == 1) {
                        $.get('${ctx}/account/pickupOrder/deletePickOrder', {orderId: orderId}, function (data) {
                            if (data.result == 'success') {
                                mui.toast('删除成功！');
                                location.reload();
                            } else {
                                mui.toast(data.message);
                            }
                        });
                    }
                })
            },
            refundOrder: function (orderId,hasUsedNum) {
                if(hasUsedNum > 0){
                    mui.toast('该订单内的优惠券已被使用过，无法退款！');
                }else{
                    this.currentOrderId = orderId;
                    this.reasonDetailDesc = '';
                    this.applyReasonCd = 0;
                    $("#returnDlg1").addClass("mui-active");
                    $("#returnDlg2").addClass("mui-popup-in");
                    document.ontouchmove = function () {
                        return false;
                    }
                }
            },
            toComment:function(orderId){
                var url = '/spa/#/m/account/order/review/'+orderId+'?successUrl='+encodeURIComponent(window.location.href);
                location.href = url;
            },
            subRefund:function () {
                if(this.applyReasonCd == 0){
                    mui.toast('请选择退款原因！');
                    return false;
                }
                closeDlg();
                $.ajax({
                    url:'/m/account/groupPurchaseOrder/dealRefundOrder',
                    data:{orderId:this.currentOrderId,applyReasonCd:this.applyReasonCd,remark:this.reasonDetailDesc},
                    type:'post',
                    dataType:'json',
                    success:function(data){
                        if(data.result == 'success'){
                            mui.toast(data.data);
                            location.reload();
                        }else{
                            mui.toast(data.message);
                        }


                    },
                    error:function(){
                        mui.alert('网络错误，请稍候重试！');
                    }
                });
            }
        }
    });

    //初始化方法
    $(function () {
        jsonData();

        $("#change").on("click", function () {
            closeDlg();
        })
    });

    var closeDlg = function () {
        $(".show-abnormal-bg").removeClass("mui-active");
        $(".mui-abnormal").removeClass("mui-popup-in");
        document.ontouchmove = null;
    }
    <#--
    function changeType(_type, e) {
        $('.dropload-down').remove();
        $('#orderTab li').removeClass('selected');
        $(e).parent().addClass('selected');
        app.type = _type;
        page = 0;
        app.isEmpty = false;
        app.orderList = [];
        Vue.nextTick(function () {
            jsonData();
        })
    }
    -->
    var page = 0;
    var pageSize = 4;

    //获取数据
    function jsonData() {
        // dropload
        $('.financiallistWrap').dropload({
            scrollArea: window,
            domDown: {
                domClass: 'dropload-down',
                domRefresh: '<div class="dropload-refresh">↑上拉加载更多</div>',
                domLoad: '<div class="dropload-load"><span class="loading"></span>加载中...</div>',
                domNoData: ''
            },
            loadDownFn: function (me) {
                page++;
                $.ajax({
                    type: 'GET',
                    url: '${ctx}/m/account/pickupOrder/findListByLimit',
                    data: {
                        pageNo: page,
                        pageSize: pageSize,
                        type: app.type
                    },
                    dataType: 'json',
                    success: function (data) {
                        if(data.result ==true) {
                            app.orderList.push.apply(app.orderList, data.orderList);
                            } else {
                                app.isEmpty = true;
                                me.lock();
                                me.noData();
                            }
                            setTimeout(function () {
                                me.resetload();
                            }, 1000);

                    },
                    error: function (xhr, type) {
                        me.resetload();
                    }
                });
            }
        });
    }


    //跳转到设置支付密码页面
    function setPayPwd(){
        var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl='+encodeURIComponent(window.location.href);
        window.location.href = _url;
    }
    <#----------------------------------------------支付处理---------------------------------------------------->
    //    $(function(){
    var paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {
            }).appendTo(document.body),
            specAS = $("#J_ASSpec");

    specAS.find(".close").on("click", function () {
        paymenthide();
    });

    $(".cancelBtn,.cancel").on("click", function () {
        paymenthide();
    });

    function paymentshow(){
        clearPwd();
        paymentMask.show().animate({opacity:1},{
            duration:80,
            complete: function () {
                specAS.css({
                    top : "100%",
                    opacity : 0,
                    display : "block"
                }).animate({
                    opacity : 1,
                    translateY:"-"+specAS.height() +"px"
                },{
                    duration : 200,
                    easing : "ease-in-out"
                });
            }
        });
        $(document).bind("touchmove",function(e){
            e.preventDefault();
        });
        $('.actionsheet-spec .spec-list')[0].addEventListener('touchmove', function(e) {
            e.stopPropagation();
        }, false);
    }

    function paymenthide(callback){
        app.isBalancePay = false;
        specAS.animate({
            opacity : 0,
            translateY:0
        },{
            duration : 200,
            easing : "ease-in-out",
            complete : function () {
                specAS.hide();
                paymentMask.animate({opacity:0},{
                    duration : 80,
                    complete: function () {
                        paymentMask.hide();
                        if(typeof callback == "function") callback.call();
                    }
                });
            }
        });
        $(document).unbind("touchmove");
    }

    var $input = $(".fake-box input");
    $("#pwd-input").on("input", function() {
        var pwd = $(this).val().trim();
        for (var i = 0, len = pwd.length; i < len; i++) {
            $input.eq("" + i + "").val(pwd[i]);
        }
        $input.each(function() {
            var index = $(this).index();
            if (index >= len) {
                $(this).val("");
            }
        });
        if (len == 6) {
            checkPayPwd();
        }
    });
    //    })

    function checkPayPwd(){
        var pwd = $("#pwd-input").val().trim();
        if(!/^\d{6}$/.test(pwd)){
            mui.toast('支付密码错误！');
            clearPwd();
            return false
        }
        //SHA1加密
        var payPwd = CryptoJS.SHA1(pwd).toString();

        //执行其他操作
        $.post('${ctx}/m/account/groupPurchaseOrder/checkPayPwd',{payPwd:payPwd},function(data){
            if(data.result=='success'){
                toPay('balancePay');
            }else{
                mui.toast('支付密码错误！');
                clearPwd();
            }
        })
    }

    //处理支付
    function toPay(payWay) {
        $.ajax({
            url: '${ctx}/account/pickupOrder/repayOrder',
            type: 'post',
            data: {
                orderId: app.currentOrderId,
                payWay: payWay
            },
            dataType: 'json',
            success: function (data) {
                if (data.result == 'success') {
                    if (payWay == 'balancePay') {
                        mui.toast('支付成功！');
                        location.reload();
                    } else {
                        window.location.href = '${ctx}/m/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
                    }
                } else {
                    mui.alert(data.message);
                }
            },
            error: function () {
                mui.alert('网络出错，请稍后再试！');
            }
        });
    }

    function clearPwd(){
        $("#pwd-input").val('');
        $('#J_ASSpec > div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
    }

</script>
</body>
</html>