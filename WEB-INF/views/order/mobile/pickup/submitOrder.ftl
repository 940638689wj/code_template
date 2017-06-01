<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static/mobile/">

<!doctype html>
<html lang="en">
<head>
    <title>确认订单</title>
</head>

<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav" href="javascript:history.go(-1)"></a>
        <h1 class="mui-title">确认订单</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <div class="exchangetab">
            <ul id="distrbuteTypeUl">
                <li data-val="1" class="selected">
                    <a href="javascript:void(0);" data-val="distrbuteTypeCd1" class="distrbuteTypeA">快递配送</a>
                </li>
                <li data-val="2">
                    <a href="javascript:void(0);" data-val="distrbuteTypeCd2" class="distrbuteTypeA">上门自提</a>
                </li>
            </ul>
        </div>

        <div class="distrbuteTypeCd1">
            <div class="order-address">
                <#if userAddress?? && userAddress?has_content>
                    <#assign addressDetail = userAddress.getAddressFullName()/>
                    <a href="/m/account/userAddress/selectAddressList?fromType=4">
                        <span class="name">${(userAddress.receiverName)!}</span>
                        <span class="phone">${(userAddress.receiverTel)!}</span>
                        <address>${addressDetail!}</address>
                    </a>
                <#else>
                    <a href="/m/account/userAddress/selectAddressList?fromType=4">
                        <address>您的收货信息为空，点此添加收货地址</address>
                    </a>
                </#if>
            </div>
        </div>

        <div class="distrbuteTypeCd2" style="display: none;">
            <div class="tbviewlist categorylist orderviewlist">
                <ul>
                    <li class="itemlink">
                        <div class="c">选择提货门店</div>
                        <div class="s">
                            <select id="pickupStoreId">
                                <option value="">请选择</option>
                            </select>
                        </div>
                    </li>

                    <li>
                        <a id="deliveryTimeBtn" class="itemlink" href="javascript:void(0);">
                            <div class="r" id="selectDeliveryTimeTip"><#--02月14日 06:00-09:00-->请选择</div>
                            <div class="c">选择提货时间</div>
                        </a>
                    </li>
                </ul>
            </div>
        </div>

        <div class="borderbox">
            <h3 class="title">套餐清单</h3>
            <ul class="prd-list">
                <li>
                    <div class="pic">
                        <img src="${(pickupcouponPackage.packagePicUrl)!}">
                    </div>
                    <div class="r">
                        <p class="name">${(pickupcouponPackage.packageName)!}</p>
                        <p class="det">￥${(pickupcouponList.pickupAmt)!}</p>
                    </div>
                </li>
            </ul>
        </div>

        <div class="distrbuteTypeCd1">
            <div class="tbviewlist categorylist orderviewlist">
                <ul>
                    <li class="itemlink">
                        <div class="c">配送方式</div>
                        <div class="s">
                            <select id="expressId">
                                <option value="">请选择</option>
                                <#--<option>顺丰￥20.00</option>-->
                            </select>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="borderbox">
                <div class="tbviewlist categorylist">
                    <ul>
                        <li>
                            <a href="javascript:void(0);">
                                <div class="r">运费<span id="expressPriceTip">0</span></div>
                                <div class="c">合计</div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="borderbox">
                <div class="tbviewlist categorylist">
                    <ul>
                        <li>
                            <a href="javascript:void(0);" id="useUserBalance">
                                <div class="r"><#-- mui-active -->
                                    <div class="mui-switch mui-switch-mini">
                                        <div class="mui-switch-handle"></div>
                                    </div>
                                </div>
                                <div class="c">账户余额<span>￥${userBalance}</span></div>
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <div class="tbviewlist categorylist orderviewlist">
            <ul>
                <li>
                    <div class="hd">订单备注:</div>
                    <div class="bd">
                        <input type="text" id="orderRemark" placeholder="选填，可填写您的备注">
                    </div>
                </li>
            </ul>
        </div>

        <div class="fbbwrap-total">
            <div class="ftbtnbar">
                <div class="content-wrap">
                    <div class="content-wrap-in content-cartwrap-in">
                        <div class="r">
                            <div class="main-info"><i>实付：</i>￥<span id="onlinePayPrice">0</span></div>
                        </div>
                    </div>
                </div>
                <div class="button-wrap">
                    <a class="button" id="doSubmitOrder">确定</a>
                </div>
            </div>
        </div>

        <input type="hidden" id="userBalancePay" value="">
        <input type="hidden" id="checkPayPassword" value="${checkPayPassword?default("false")}">
        <input type="hidden" id="userAddressId" value="${(userAddress.addrId)!}"/>

    </div>
</div>

<div id="J_paymentSpecAS" class="actionsheet-spec">
    <!--第三方支付-->
    <div class="payment-method" style="display: none;">
        <div class="close"></div>
        <div class="prod-info">
            <div class="title">请选择支付方式</div>
        </div>
        <div class="spec-list">
            <div class="spec-list-wrap">
                <ul class="tbviewlist paytypes">
                    <#if onlinePayTypeList?? && onlinePayTypeList?has_content>
                        <#list onlinePayTypeList?keys as key>
                            <#assign payName="" />
                            <#assign payWay="4" />
                            <#if key="config_alipay_mobile">
                                <#assign payName="支付宝支付" />
                                <#assign payWay="2" />
                            <#elseif key="config_unionpay_mobile">
                                <#assign payName="银联支付" />
                                <#assign payWay="4" />
                            <#elseif key="weixin_pay_config">
                                <#assign payName="微信支付" />
                                <#assign payWay="1" />
                            </#if>

                            <li>
                                <a href="javascript:void(0);" onclick="submitOrderByOnline('${payWay}');">${payName!}</a>
                            </li>
                        </#list>
                    </#if>
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

    <!--账户余额支付-->
    <div class="ye-payment" style="display: none;">
        <div class="prod-info">
            <div class="title">余额支付<span class="orange">￥<span class="userBalancePay">0.00</span></span>元</div>
        </div>
        <div class="paymentwrap">
            <div class="orderinfo">
                <P>请<#if hasSetPayPwd>输入<#else>设置</#if>支付密码</P>
            </div>
            <div class="pwd-box" style="<#if !hasSetPayPwd>display:none;</#if>">
                <input type="tel" maxlength="6" class="pwd-input" id="pwd-input">
                <div class="fake-box">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                    <input type="password" readonly="">
                </div>
            </div>
            <div class="orderinfo" style="<#if hasSetPayPwd>display:none;</#if>">
                <p>您还未设置支付密码，为保障账户资金安全，<br>请先<a href="javascript:setPayPwd();" class="textcolor">设置支付密码</a>！</p>
            </div>
        </div>

        <div class="fbbwrap-total nofixed">
            <div class="ftbtnbar">
                <div class="button-wrap button-wrap-expand">
                    <a href="javascript:void(0)" class="button" id="confirmBalancePay">确定</a>
                    <a href="javascript:void(0)" class="button cancel">取消</a>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="deliveryTimeDialogDiv" class="actionsheet-spec">
    <div class="close"></div>
    <div class="prod-info">
        <div class="title">提货时间</div>
    </div>
    <div class="ctimewap">
        <div class="ctimewap-left">
            <div id="ctimewapleftScroll" class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <ul class="ctime-date">
                        <#--
                        <li class="selected">02月13日（周一）</li>
                        <li>02月14日（周一）</li>
                        -->
                    </ul>
                </div>
            </div>
        </div>

        <div class="ctimewap-right">
            <div id="ctimewaprightScroll" class="mui-scroll-wrapper">
                <div class="mui-scroll">
                    <ul class="ctime-time">
                        <li>
                            <label>
                                <input type="radio" name="pickupTime" value="">
                                <div class="c" id="amTime"><#--06:00-09:00--></div>
                            </label>
                        </li>
                        <li>
                            <label>
                                <input type="radio" name="pickupTime" value="">
                                <div class="c" id="pmTime"><#--14:00-19:00--></div>
                            </label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>

    <div class="fbbwrap-total nofixed">
        <div class="ftbtnbar">
            <div class="button-wrap button-wrap-expand">
                <a href="javascript:void(0)" id="confirmDeliveryTime" class="button">确定</a>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var userBalance = ${userBalance?default(0)};
    var cityId = "${(userAddress.receiverCityId)!}";
    var flagSub = true;//防止表单多次提交
    var paymentMask = null;
    var paymentSpecAS = null;
    var paymentPassword = "";

    var dTime = null;
    var storePickupDateTimeMap = {};
    var expressPriceMap = {};
    var submitData = {};


    // 快递配送
    function distrbuteTypeCd1(){
        $('.distrbuteTypeCd1').show();
        $('.distrbuteTypeCd2').hide();
    }

    // 门店自提
    function distrbuteTypeCd2(){
        $('.distrbuteTypeCd1').hide();
        $('.distrbuteTypeCd2').show();
    }

    //模拟表单提交
    function submitForm(action, data){
        var div = $("<div style='display: none'><form id='_help-my-form'></form></div>");
        $("body").append(div);
        var helpForm = $("#_help-my-form");
        helpForm.attr("action",action);
        helpForm.attr("method","post");
        $.each(data, function(key, value){
            var inputObj = $("<input name='"+key+"' value='"+value+"'/>");
            helpForm.append(inputObj);
        });
        helpForm.submit();
    }

    function paymentShow(dialogName){
        $('.ye-payment').hide();
        $('.payment-method').hide();

        $('.'+dialogName).show();

        paymentMask.show().animate({opacity:1},{
            duration:80,
            complete: function () {
                paymentSpecAS.css({
                    top : "100%",
                    opacity : 0,
                    display : "block"
                }).animate({
                    opacity : 1,
                    translateY:"-"+paymentSpecAS.height() +"px"
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

    function paymentHide(callback){
        paymentSpecAS.animate({
            opacity : 0,
            translateY:0
        },{
            duration : 200,
            easing : "ease-in-out",
            complete : function () {
                paymentSpecAS.hide();
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

    // 提交表单(在线支付方式)
    function submitOrderByOnline(payWay){
        submitData.onlinePayWay = payWay;

        var userBalancePay = getUserBalancePay();
        if(userBalancePay > 0){
            submitData.userBalancePay = userBalancePay;
            paymentShow('ye-payment');
        }else{
            submitOrderData();
        }
    }

    // 提交表单数据
    function submitOrderData(){
        var orderRemark = $('#orderRemark').val();
        submitData.orderRemark = orderRemark;

        console.log(submitData)

        if(flagSub) {
            flagSub = false;
            submitForm("/m/account/pickupOrder/save", submitData);
        }
    }

    $(function(){
        initPageData();

        paymentMask = $("<div style='display: none;' class='mask'></div>").on("click", function (e) {}).appendTo(document.body),
                paymentSpecAS = $("#J_paymentSpecAS");

        // 关闭支付 弹窗
        paymentSpecAS.find(".close").on("click", function () {
            paymentHide();
        });
        $(".cancelBtn,.cancel").on("click", function () {
            paymentHide();
        });

        // 密码输入效果
        var $input = $(".fake-box input");
        $("#pwd-input").on("input", function() {
            var pwd = $(this).val().trim();
            for (var i = 0, len = pwd.length; i < len; i++) {
                $input.eq("" + i + "").val(pwd[i]);
            }

            paymentPassword = pwd;

            $input.each(function() {
                var index = $(this).index();
                if (index >= len) {
                    $(this).val("");
                }
            });
            if (len == 6) {
                //执行其他操作
            }
        });

        // 输完支付密码,确认支付
        $('#confirmBalancePay').click(function(){
            <#if !hasSetPayPwd>
                setPayPwd();
                return ;
            </#if>

            if(paymentPassword.length != 6) {
                mui.toast('支付密码为6位数字!');
                return;
            }

            if(!flagSub) {
                console.log('flagSub='+flagSub)
                return;
            }

            flagSub = false;
            $.ajax({
                url  : '${ctx}/m/account/order/testPayPwd',
                async : true,
                type : "GET",
                dataType : "json",
                data : {"payPassword" : paymentPassword},
                success : function(result) {
                    flagSub = true;

                    if(result.result == 'success') {
                        mui.toast('支付成功!');
                        submitOrderData();
                    } else {
                        mui.toast(result.message);
                        clearPwd();
                    }
                },
                error:function(XMLHttpResponse ){
                    flagSub = true;
                    mui.toast("网络繁忙,请稍后再试!");
                }
            });
        });

        $("#doSubmitOrder").click(function(){
            var distrbuteTypeCd = $($('#distrbuteTypeUl').find('li').filter('.selected').get(0)).attr('data-val');
            var totalPrice = getTotalPrice();
            submitData.distrbuteTypeCd = distrbuteTypeCd;
            submitData.totalPrice = totalPrice;

            if(distrbuteTypeCd == "1"){
                // 快递方式

                var userAddressId = $('#userAddressId').val();
                if(!userAddressId || userAddressId==""){
                    mui.toast('请选择收货地址!');
                    return ;
                }

                var expressId = $('#expressId').val();
                if(!expressId || expressId==""){
                    mui.toast('请选择快递方式!');
                    return ;
                }

                submitData.expressId = expressId;
                submitData.userAddressId = userAddressId;

                var userBalancePay = getUserBalancePay();
                var onlinePayPrice = getOnlinePayPrice();

                if(totalPrice > 0){
                    // 合计金额 大于0

                    if(onlinePayPrice > 0){
                        // 第三方支付金额 大于0(选择支付方式)
                        submitData.onlinePayPrice = onlinePayPrice;
                        paymentShow('payment-method');
                        return ;
                    }

                    if(userBalancePay > 0){
                        // 余额支付 大于0
                        submitData.userBalancePay = userBalancePay;
                        paymentShow('ye-payment');
                        return ;
                    }
                }else{
                    var checkPayPassword = $('#checkPayPassword').val();
                    if(userBalancePay > 0 && (checkPayPassword == "true")){
                        // 校验 支付密码
                        paymentShow('ye-payment');
                        return ;
                    }
                }

            }else if(distrbuteTypeCd == "2"){
                // 到门店自提方式

                var pickupStoreId = $('#pickupStoreId').val();
                if(!pickupStoreId || pickupStoreId==""){
                    mui.toast('请先选择提货门店!');
                    return ;
                }

                var pickupDateList = $('.ctime-date').find('li').filter('.selected');
                if(pickupDateList == undefined || pickupDateList.length < 1){
                    mui.toast('请选择提货日期!');
                    return ;
                }
                var pickupDate = $(pickupDateList.get(0)).attr('data-key');

                var pickupTimeList = $('input[name="pickupTime"]').filter(":checked");
                if(pickupTimeList == undefined || pickupTimeList.length < 1){
                    mui.toast('请选择提货时间!');
                    return ;
                }

                var pickupTimeStr = $(pickupTimeList.get(0)).val();
                var pickupTimeArray = pickupTimeStr.split('-');
                submitData.pickupStartTime = pickupDate + " " + pickupTimeArray[0];
                submitData.pickupEndTime = pickupDate + " " + pickupTimeArray[1];

                submitData.storeId = pickupStoreId;
            }else{
                mui.toast('请选择配货方式!');
                return ;
            }

            submitOrderData();
        })

        // 选择快递 与 门店自提
        $('.distrbuteTypeA').click(function(){
            $('#distrbuteTypeUl').find('li').removeClass('selected');
            $(this).parent().addClass('selected');
            var dataVal = $(this).attr('data-val');
            if(dataVal == "distrbuteTypeCd1"){
                distrbuteTypeCd1();
            }else if(dataVal == "distrbuteTypeCd2"){
                distrbuteTypeCd2();
            }
        });

        // 提货门店选择
        $('#pickupStoreId').on('change', function(){
            $('.ctime-date').find('li').removeClass('selected');
            $('.ctime-date').find('li').first().addClass('selected');

            $('input[name="pickupTime"]').get(0).checked = false;
            $('input[name="pickupTime"]').get(1).checked = false;

            $('input[name="pickupTime"]').get(0).value = storePickupDateTimeMap[$(this).val()+'_am'];
            $('input[name="pickupTime"]').get(1).value = storePickupDateTimeMap[$(this).val()+'_pm'];
            $('#amTime').text(storePickupDateTimeMap[$(this).val()+'_am']);
            $('#pmTime').text(storePickupDateTimeMap[$(this).val()+'_pm']);
        });

        /*提货时间*/
        dTime = $("#deliveryTimeDialogDiv");
        dTime.find(".close").on("click", function () {
            deliveryTimehide();
        });
        $("#deliveryTimeBtn").on("click", function () {
            var pickupStoreId = $('#pickupStoreId').val();
            if(!pickupStoreId || pickupStoreId==""){
                mui.toast('请先选择提货门店!');
                return ;
            }
            deliveryTimeshow();
        });
        $('#confirmDeliveryTime').on("click", function(){
            var pickupDateList = $('.ctime-date').find('li').filter('.selected');
            if(pickupDateList == undefined || pickupDateList.length < 1){
                mui.toast('请选择提货日期!');
                return ;
            }
            var pickupDate = $(pickupDateList.get(0)).text();

            var pickupTimeList = $('input[name="pickupTime"]').filter(":checked");
            if(pickupTimeList == undefined || pickupTimeList.length < 1){
                mui.toast('请选择提货时间!');
                return ;
            }
            var pickupTime = $(pickupTimeList.get(0)).val();

            $('#selectDeliveryTimeTip').text(pickupDate+" "+pickupTime);
            deliveryTimehide();
        });

        $('.ctime-date').on('click', 'li', function(){
            $('.ctime-date').find('li').removeClass('selected');
            $(this).addClass('selected');
        });

        $('#expressId').on('change', function(){
            var expressId = $(this).val();
            console.log(expressId)

            if(!expressId || expressId==""){
                $('#expressPriceTip').text(0);
            }else{
                var expressPrice = expressPriceMap[expressId];
                $('#expressPriceTip').text(expressPrice);
            }

            renderUseUserBalance();
            renderOnlinePay();
        });

        // 账户余额开关
        mui('.mui-content .mui-switch').each(function() { //循环所有toggle
            this.addEventListener('toggle', function(event) {
                renderUseUserBalance();
                renderOnlinePay();
            });
        });
    })


    // 输出 账户余额 使用情况
    function renderUseUserBalance(){
        // 是否使用了余额
        var isUseUserBalance = false;
        var totalPrice = getTotalPrice();
        if(totalPrice <= 0){
            //mui.toast('无需使用账户余额!');
            isUseUserBalance = false;

            $('#useUserBalance').find('.mui-switch-mini').each(function() {
                if($(this).hasClass('mui-active')) {
                    // 去掉勾选的 账户余额支付
                    $(this).removeClass('mui-active');
                    $(this).find('.mui-switch-handle').attr('style','transition-duration: 0.2s; transform: translate(0px, 0px);');
                }
            });
        }else{
            $('#useUserBalance').find('.mui-switch-mini').each(function() {
                if($(this).hasClass('mui-active')) {
                    // 使用了 账户余额支付
                    isUseUserBalance = true;
                }
            });
        }

        if(isUseUserBalance){
            if(userBalance > totalPrice){
                // 余额大于 需要支付金额
                $('#userBalancePay').val(totalPrice);
                $('.userBalancePay').text(totalPrice);
            }else{
                // 余额小于 需要支付金额
                $('#userBalancePay').val(userBalance);
                $('.userBalancePay').text(userBalance);
            }
        }else{
            $('#userBalancePay').val(0);
            $('.userBalancePay').text(0);
        }
    }

    function getUserBalancePay(){
        var userBalancePay = parseFloat($('#userBalancePay').val());
        return userBalancePay;
    }

    function getExpressPrice(){
        var expressPrice = parseFloat($('#expressPriceTip').html().trim());
        return expressPrice;
    }

    // 获取 合计金额
    function getTotalPrice(){
        var totalPrice = 0;

        var expressPrice = getExpressPrice();
        totalPrice = totalPrice + expressPrice;

        return totalPrice;
    }

    // 获取 实付金额
    function getOnlinePayPrice(){
        var onlinePayPrice = parseFloat($('#onlinePayPrice').html().trim());
        return onlinePayPrice;
    }

    // 渲染 实付金额
    function renderOnlinePay(){
        var onlinePayPrice = 0;

        var expressPrice = getExpressPrice();
        var userBalancePay = getUserBalancePay();

        onlinePayPrice = onlinePayPrice + expressPrice;
        onlinePayPrice = onlinePayPrice - userBalancePay;

        if(onlinePayPrice < 0){
            onlinePayPrice = 0;
        }

        $('#onlinePayPrice').text(onlinePayPrice);
    }


    function initPageData(){
        // 门店列表
        $.get("/m/account/pickupOrder/storeList.html", {}, function (data) {
            console.log(data.dateMap)
            var tempDateArray = [];
            $.each(data.dateMap, function(key, val) { tempDateArray[tempDateArray.length] = key;  });
            tempDateArray.sort();
            $.each(tempDateArray, function(i, key) {
                //console.log(key+"-----"+data.dateMap[key])
                // 2017-03-01   "03月01日[周三]"
                $('.ctime-date').append('<li data-key="'+key+'">'+data.dateMap[key]+'</li>');
            });

            if(data && data.rowCount > 0){
                var amStart = "";
                var amEnd = "";
                var pmStart = "";
                var pmEnd = "";

                console.log(data.rows)
                $.each(data.rows, function(i, val){
                    //console.log(val)
                    $('#pickupStoreId').append('<option value="'+val.storeId+'">'+val.storeName+'</option>');

                    amStart = val.deliveryTimeAmStart;
                    amEnd = val.deliveryTimeAmEnd;
                    pmStart = val.deliveryTimePmStart;
                    pmEnd = val.deliveryTimePmEnd;

                    storePickupDateTimeMap[val.storeId+"_am"] = (amStart+"-"+amEnd);
                    storePickupDateTimeMap[val.storeId+"_pm"] = (pmStart+"-"+pmEnd);
                })
            }
        }, "json");

        // 快递列表
        initExpressList();
    }

    function initExpressList(){
        $.get("/m/account/pickupOrder/expressList.html", {cityId: cityId}, function (data) {
            console.log("---------------------");
            if(data && data.rowCount > 0){
                $.each(data.rows, function(i,val){
                    $('#expressId').append('<option value='+val.expressId+'>'+val.expressName + ' ￥' + val.expressPrice+'</option>')
                    expressPriceMap[val.expressId]=val.expressPrice;
                })
            }
        }, "json");
    }

    function deliveryTimeshow(){
        paymentMask.show().animate({opacity:1},{
            duration:80,
            complete: function () {
                dTime.css({
                    top : "100%",
                    opacity : 0,
                    display : "block"
                }).animate({
                    opacity : 1,
                    translateY:"-"+dTime.height() +"px"
                },{
                    duration : 200,
                    easing : "ease-in-out"
                });
            }
        });
        $(document).bind("touchmove",function(e){
            e.preventDefault();
        });
    }

    function deliveryTimehide(callback){
        dTime.animate({
            opacity : 0,
            translateY:0
        },{
            duration : 200,
            easing : "ease-in-out",
            complete : function () {
                dTime.hide();
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

    //跳转到设置支付密码页面
    function setPayPwd(){
        var _url = '${ctx}/m/account/accountSecurity/changePaw_Reset?type=2&successUrl=m/account/pickupOrder/submitOrder';
        window.location.href = _url;
    }

    function clearPwd(){
        $("#pwd-input").val('');
        $('div.ye-payment > div.paymentwrap > div.pwd-box > div > input[type="password"]').val('');
    }

    mui('#ctimewapleftScroll').scroll();
    mui('#ctimewaprightScroll').scroll();
</script>
</body>
</html>