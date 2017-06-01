<div id="main">
    <div class="checkout">
        <div class="checkout-tit">填写并核对订单信息</div>
        <div class="checkout-steps">
            <div class="step-tit">
                <h3>收货人信息</h3>
                <span class="extra-r flr">
                    <a href="javascript:void(0);" class="link" id="newaddressBtn">新增地址</a>
                </span>
            </div>
            <div class="step-addr-wrap">
                <div class="step-addr">
                    <ul id="userAddressListUl">
                    </ul>
                </div>

                <div class="addr-switch" <#--style="display: none;"-->>
                    <span>更多地址</span><b></b>
                </div>
            </div>

            <div class="step-since-wrap">
                <div class="step-since">
                    <div class="since-item">线下自提<b></b></div>

                    <div class="since-selected">
                        <ul id="storeListUl">
                        </ul>
                    </div>
                </div>

                <div class="since-switch" style="display:none;">
                    <span>更多</span><b></b>
                </div>
            </div>

            <div class="step-wrap">
                <div class="step-tit">
                    <h3>套餐清单</h3>
                </div>
                <div class="shoptb">
                    <div class="shoptb-hd">
                        <table>
                            <tbody>
                            <tr>
                                <td class="td-product">礼包名称</td>
                                <td class="td-price">礼包价格</td>
                                <td class="td-amount">数量</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="shoptb-row">
                        <table>
                            <tbody>
                            <tr>
                                <td class="td-product">
                                    <div class="first-column">
                                        <div class="img">
                                            <a href="javascript:void(0);"><img src="${(pickupcouponPackage.packagePicUrl)!}"></a>
                                        </div>
                                        <div class="info">
                                            <div class="name">
                                                <a href="javascript:void(0);" target="_blank">${(pickupcouponPackage.packageName)!}</a>
                                            </div>
                                            <div class="prop">
                                                <span></span>
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td class="td-price">￥${(pickupcouponList.pickupAmt)!}</td>
                                <td class="td-amount">1</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <div class="step-wrap">
                <div class="step-tit">
                    <h3>配送信息</h3>
                </div>

                <div class="formList" id="selectExpressDiv">
                    <div class="item">
                        <div class="hd">快递方式</div>
                        <div class="bd">
                            <select id="expressId" style="width: 140px;">
                                <option value="">--- 请选择 ---</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="formList" id="selectPickDateTimeDiv" style="display: none;">
                    <div class="item">
                        <div class="hd">选择提货时间</div>
                        <div class="bd">
                            <select class="mr20" id="pickupDate" style="width: 140px;">
                                <option value="">请选择日期</option>
                            </select>
                            <select id="pickupTime" style="width: 140px;">
                                <option value="">请选择时间</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>


            <div class="step-wrap">
                <div class="step-tit">
                    <h3>优惠信息</h3>
                </div>
                <div class="order-ft">
                    <div class="order-extra">
                        <div class="formList order-extra">
                            <div class="item">
                                <div class="hd">余额抵扣</div>
                                <div class="bd">
                                    <input type="checkbox" id="useUserBalance" name="useUserBalance">
                                    <label for="useUserBalance"><span class="infotext">当前可用余额 ￥${userBalance?default(0)}，是否使用</span></label>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">订单备注</div>
                                <div class="bd">
                                    <textarea placeholder="订单备注" id="orderRemark" class="textarea w300"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="order-total">
                        <div class="row">
                            <div class="tit">商品总价：</div>
                            <div class="con">￥0</div>
                        </div>
                        <div class="row">
                            <div class="tit">快递费用：</div>
                            <div class="con">￥<span id="expressPriceTip">0</span></div>
                        </div>
                        <div class="row">
                            <div class="tit">余额抵扣：</div>
                            <div class="con">-￥<span id="userBalancePay">0</span></div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <div class="trade-foot">
        <div class="trade-foot-detail">
            <div class="fc-price-info">
                <span class="price-tit">应付总额：</span>
                <span class="price-num">￥<span id="onlinePayPrice">0</span></span>
            </div>

            <div class="fc-price-info">
                <div id="expressConfirmMsg" style="display: none;">
                    寄送至： <span class="mr20" id="expressConfirmMsg_detailAddress"><#--福建 厦门市 思明区   软件园2期观日路24号之二102--></span>
                    收货人：<span id="expressConfirmMsg_receiveName"><#--杨毅强 139****7475--></span>
                </div>

                <div id="selfPickUpConfirmMsg" style="display: none;">
                    <span class="mr20"></span>
                </div>
            </div>
        </div>

        <div class="inner">
            <button type="button" id="doSubmitOrder">提交订单</button>
        </div>
    </div>

    <input type="hidden" id="checkPayPassword" value="${checkPayPassword?default("false")}">
    <input type="hidden" id="userAddressId" value="${(userAddress.addrId)!}"/>

</div>

<div id="payment_onlineMethod" class="hidden">
    <div class="paytypes">
        <ul>
            <#if onlinePayTypeList?? && onlinePayTypeList?has_content>
                <#list onlinePayTypeList?keys as key>
                    <#assign payName="" />
                    <#assign payWay="4" />
                    <#if key="config_alipay_pc">
                        <#assign payName="支付宝支付" />
                        <#assign payWay="2" />
                    <#elseif key="config_unionpay_mobile">
                        <#assign payName="银联支付" />
                        <#assign payWay="4" />
                    </#if>

                    <li>
                        <a href="javascript:void(0);" onclick="submitOrderByOnline('${payWay}');">${payName!}</a>
                    </li>
                </#list>
            </#if>
        </ul>
    </div>
</div>
<div id="payment_inputPassword"  class="hidden">
    <div class="formList paypassword">
        <div class="item">
            <div class="hd">输入支付密码：</div>
            <div class="bd">
                <input type="password" id="paymentPassword" class="textfield">
            </div>
        </div>
        <div class="item">
            <div class="hd"></div>
            <div class="bd">
                <a class="v-btn" href="javascript:void(0);" id="confirmBalancePay">确定</a>
            </div>
        </div>
    </div>
</div>

<div id="newddress" class="hidden">
    <div class="reg-form">
        <ul>
            <li>
                <div class="hd">姓名</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="addressName"></div>
                </div>
            </li>
            <li>
                <div class="hd">所在地区</div>
                <div class="bd">
                    <select id="addressProvinceId"><#--<option value="">福建省</option>--></select>
                    <select id="addressCityId"><#--<option value="">厦门市</option>--></select>
                    <select id="addressCountryId"><#--<option value="">思明区</option>--></select>
                </div>
            </li>
            <li>
                <div class="hd">街道</div>
                <div class="bd">
                    <textarea id="addressDetail"></textarea>
                </div>
            </li>
            <li>
                <div class="hd">手机号码</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="addressTel"></div>
                </div>
            </li>
            <li>
                <div class="bd">
                    <input type="hidden" id="newAddressId" value="">
                    <a href="javascript:void(0);" id="newAddressSaveBtn" class="btn-action">保存</a>
                </div>
            </li>
        </ul>
    </div>
</div>

<script>
    var userBalance = ${userBalance?default(0)};
    var cityId = "${(userAddress.receiverCityId)!}";
    var currentSelectAddressId = -1;// 预先选中的收货地址id
    var flagSub = true;//防止表单多次提交
    var hideOrShowMoreAddressFlag = false;
    var distributeTypeCd = "1";

    var storePickupDateTimeMap = {};
    var expressPriceMap = {};
    var submitData = {};

    $(function(){
        initPageData();

        initUserAddressEvent();

        // 收货地址高亮
        $(".step-addr").on("mouseenter", "li", function () {
            $(this).addClass("step-addr-selected");
        }).on("mouseleave", "li", function () {
            $(this).removeClass("step-addr-selected");
        })

        // 快递 - 选择收货地址
        $('#userAddressListUl').on('click', '.addr-item', function(){
            // 快递相关
            $('.addr-item').removeClass('item-selected');

            $('#selectExpressDiv').show();

            // 显示 确认收货地址信息
            showExpressConfirmMsg($(this).attr('data-info'), $(this).attr('data-tel'), $(this).text());

            // 门店自提相关
            $('.since-item').removeClass('item-selected');
            $(".since-selected input[type=radio]").attr("checked", false);
            $('#selectPickDateTimeDiv').hide();
            $('#selfPickUpConfirmMsg').hide();

            $(this).addClass('item-selected');

            currentSelectAddressId = $(this).attr('data-addrId');
            distributeTypeCd = "1";
        });
        // 门店自提
        $('.since-item').click(function(){
            // 快递相关
            $('.addr-item').removeClass('item-selected');
            $('#selectExpressDiv').hide();
            $("#expressId").val("");
            $("#expressId").trigger('change');
            $('#expressConfirmMsg').hide();

            // 门店自提相关
            $('.since-item').removeClass('item-selected');
            $('#selectPickDateTimeDiv').show();
            $('#selfPickUpConfirmMsg').show();

            $(this).addClass('item-selected');
            distributeTypeCd = "2";
        });
        // 门店自提时间
        $('#storeListUl').on('click', '[name="storeId"]', function(){
            $('#pickupTime').empty();
            $('#pickupTime').append('<option value="'+storePickupDateTimeMap[$(this).val()+'_am']+'">'+storePickupDateTimeMap[$(this).val()+'_am']+'</option>');
            $('#pickupTime').append('<option value="'+storePickupDateTimeMap[$(this).val()+'_pm']+'">'+storePickupDateTimeMap[$(this).val()+'_pm']+'</option>');
        });

        // 选择快递方式
        $('#expressId').on('change', function(){
            var expressId = $(this).val();
            if(expressId == undefined || expressId==""){
                $('#expressPriceTip').text(0);
            }else{
                var expressPrice = expressPriceMap[expressId];
                $('#expressPriceTip').text(expressPrice);
            }

            renderUseUserBalance();
            renderOnlinePay();
        });

        // 余额抵扣 选中状态
        $('#useUserBalance').change(function(){
            if($("#useUserBalance").is(":checked")){
            }else{
            }

            renderUseUserBalance(true);
            renderOnlinePay();
        });

        // 提交订单
        $("#doSubmitOrder").click(function(){
            var totalPrice = getTotalPrice();
            submitData.totalPrice = totalPrice;
            submitData.distrbuteTypeCd = distributeTypeCd;
            if(distributeTypeCd == "1"){
                // 快递方式
                submitData.pickupStartTime = "";
                submitData.pickupEndTime = "";
                submitData.storeId = "";

                var addressArray = $('.addr-item').filter('.item-selected');
                if(addressArray == undefined || addressArray.length < 1){
                    layer.msg('请选择收货地址!');
                    return ;
                }

                var userAddressId = $(addressArray.get(0)).attr('data-addrId');
                //console.log("userAddressId="+userAddressId)
                if(!userAddressId || userAddressId==""){
                    layer.msg('请选择收货地址!');
                    return ;
                }

                var expressId = $('#expressId').val();
                if(!expressId || expressId==""){
                    layer.msg('请选择快递方式!');
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
                        paymentShow('onlineMethod');
                        return ;
                    }

                    if(userBalancePay > 0){
                        // 余额支付 大于0
                        submitData.userBalancePay = userBalancePay;
                        paymentShow('inputPassword');
                        return ;
                    }
                }else{
                    var checkPayPassword = $('#checkPayPassword').val();
                    if(userBalancePay > 0 && (checkPayPassword == "true")){
                        // 校验 支付密码
                        paymentShow('inputPassword');
                        return ;
                    }
                }

            }else if(distributeTypeCd == "2"){
                // 到门店自提方式
                submitData.expressId = "";
                submitData.userAddressId = "";
                submitData.onlinePayWay = "";
                submitData.onlinePayPrice = "";
                submitData.userBalancePay = "";

                var pickupStoreId = $("input[name='storeId']:checked").val();
                if(pickupStoreId == undefined ||
                        !pickupStoreId ||
                        pickupStoreId==""){
                    layer.msg('请先选择提货门店!');
                    return ;
                }

                var pickupDate = $('#pickupDate').val();
                if($.trim(pickupDate) == ""){
                    layer.msg('请选择提货日期!');
                    return ;
                }

                var pickupTimeStr = $('#pickupTime').val();
                console.log(pickupTimeStr)
                if(pickupTimeStr == ""){
                    layer.msg('请选择提货时间!');
                    return ;
                }

                var pickupTimeArray = pickupTimeStr.split('-');
                submitData.pickupStartTime = pickupDate + " " + pickupTimeArray[0];
                submitData.pickupEndTime = pickupDate + " " + pickupTimeArray[1];

                submitData.storeId = pickupStoreId;
            }else{
                layer.msg('请选择配货方式!');
                return ;
            }

            submitOrderData();
        })


        initAfterDataLoad();
    })

    function initAfterDataLoad(){
        //

    }

    function paymentShow(dialogName){
        // 支付密码
        // 选择支付方式
        if(dialogName == "onlineMethod"){
            layer.open({
                type: 1,
                title: '选择支付方式',
                skin: 'layui-layer-rim',
                shade: [0.6],
                area: ['360px'],
                content: $("#payment_onlineMethod")
            });
        }else if(dialogName == "inputPassword"){
            layer.open({
                type: 1,
                title: '支付密码',
                skin: 'layui-layer-rim',
                shade: [0.6],
                area: ['360px','200px'],
                content: $("#payment_inputPassword")
            });
        }
    }

    // 提交表单(在线支付方式)
    function submitOrderByOnline(payWay){
        submitData.onlinePayWay = payWay;

        var userBalancePay = getUserBalancePay();
        if(userBalancePay > 0){
            submitData.userBalancePay = userBalancePay;
            paymentShow('inputPassword');
        }else{
            submitOrderData();
        }
    }

    // 输完支付密码,确认支付
    $('#confirmBalancePay').click(function(){
        var paymentPassword = $('#paymentPassword').val();
        <#if !hasSetPayPwd>
            //setPayPwd();
            return ;
        </#if>

        if(paymentPassword.length != 6) {
            layer.msg('支付密码为6位数字!');
            return;
        }

        if(!flagSub) {
            console.log('flagSub='+flagSub)
            return;
        }

        flagSub = false;
        $.ajax({
            url  : '/m/account/order/testPayPwd',
            async : true,
            type : "GET",
            dataType : "json",
            data : {"payPassword" : paymentPassword},
            success : function(result) {
                flagSub = true;

                if(result.result == 'success') {
                    layer.msg('支付成功!');
                    submitOrderData();
                } else {
                    layer.msg(result.message);
                    $('#paymentPassword').val('');
                }
            },
            error:function(XMLHttpResponse ){
                flagSub = true;
                layer.msg("网络繁忙,请稍后再试!");
            }
        });
    });

    // 提交表单数据
    function submitOrderData(){
        var orderRemark = $('#orderRemark').val();
        submitData.orderRemark = orderRemark;

        console.log(submitData)

        if(flagSub) {
            flagSub = false;
            submitForm("/account/pickupOrder/save", submitData);
        }
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

    function initPageData(){
        // 用户收货地址
        loadUserAddress(currentSelectAddressId);

        // 门店列表
        $.get("/m/account/pickupOrder/storeList.html", {}, function (data) {
            console.log(data.dateMap)
            var tempDateArray = [];
            $.each(data.dateMap, function(key, val) { tempDateArray[tempDateArray.length] = key;  });
            tempDateArray.sort();
            $.each(tempDateArray, function(i, key) {
                //console.log(key+"-----"+data.dateMap[key])
                // 2017-03-01   "03月01日[周三]"
                $('#pickupDate').append('<option value="'+key+'">'+data.dateMap[key]+'</option>');
            });

            if(data && data.rowCount > 0){
                if(data.rowCount > 3){
                    $('.since-switch').show();
                }

                var amStart = "";
                var amEnd = "";
                var pmStart = "";
                var pmEnd = "";

                console.log(data.rows)
                $.each(data.rows, function(i, val){
                    //console.log(val)
                    $('#storeListUl').append('<li><label><input type="radio" name="storeId" value="'+val.storeId+'"><p>'+val.storeName+'</p></label><span>'+val.detailAddress+'</span></li>');

                    amStart = val.deliveryTimeAmStart;
                    amEnd = val.deliveryTimeAmEnd;
                    pmStart = val.deliveryTimePmStart;
                    pmEnd = val.deliveryTimePmEnd;

                    storePickupDateTimeMap[val.storeId+"_am"] = (amStart+"-"+amEnd);
                    storePickupDateTimeMap[val.storeId+"_pm"] = (pmStart+"-"+pmEnd);

                    if(i == 0){
                        $('#pickupTime').append('<option value="'+storePickupDateTimeMap[val.storeId+'_am']+'">'+storePickupDateTimeMap[val.storeId+'_am']+'</option>');
                        $('#pickupTime').append('<option value="'+storePickupDateTimeMap[val.storeId+'_pm']+'">'+storePickupDateTimeMap[val.storeId+'_pm']+'</option>');
                    }
                })
            }
        }, "json");

        // 快递列表
        $.get("/m/account/pickupOrder/expressList.html", {cityId: cityId}, function (data) {
            if(data && data.rowCount > 0){
                $.each(data.rows, function(i,val){
                    $('#expressId').append('<option value='+val.expressId+'>'+val.expressName + ' ￥' + val.expressPrice+'</option>')
                    expressPriceMap[val.expressId]=val.expressPrice;
                })
            }
        }, "json");

        // 收货地址 “省” 列表
        $.ajax({
            url : '/common/area/findChildByParentId',
            dataType : 'json',
            type: 'GET',
            data : {parentId: '0'},
            success : function(data){
                if(data.rowCount && data.rowCount >0){
                    $.each(data.rows, function(i, row){
                        $("#addressProvinceId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                    });

                    cleanSelectContent("addressCityId", "-- 请选择城市 --");
                    cleanSelectContent("addressCountryId", "-- 请选择区/县 --");
                }
            }
        });
    }

    // 加载用户收货地址, selectId:预先选中的收货地址id
    function loadUserAddress(selectId){
        $('#userAddressListUl').empty();

        $.get("/account/userAddress/userAddressList.html", {}, function (data) {
            if(data && data.userAddressDTOList){
                var tempStr = "";
                $.each(data.userAddressDTOList, function(i,val){
                    tempStr = tempStr + '<li>';

                    if(selectId > 0){
                        // 预先选中的收货地址id
                        if(selectId == val.addrId){
                            tempStr = tempStr + '<div data-tel="'+val.receiverTel+'" data-info="'+val.addressFullName+'" data-addrId="'+val.addrId+'" class="addr-item item-selected">'+val.receiverName+'<b></b></div>';
                            currentSelectAddressId = parseInt(val.addrId);

                            // 显示 确认收货地址信息
                            showExpressConfirmMsg(val.addressFullName, val.receiverTel, val.receiverName);
                        }else{
                            tempStr = tempStr + '<div data-tel="'+val.receiverTel+'" data-info="'+val.addressFullName+'" data-addrId="'+val.addrId+'" class="addr-item">'+val.receiverName+'<b></b></div>';
                        }
                    }else{
                        if(val.isDefaultAddr == 1){
                            tempStr = tempStr + '<div data-tel="'+val.receiverTel+'" data-info="'+val.addressFullName+'" data-addrId="'+val.addrId+'" class="addr-item item-selected">'+val.receiverName+'<b></b></div>';
                            currentSelectAddressId = parseInt(val.addrId);

                            // 显示 确认收货地址信息
                            showExpressConfirmMsg(val.addressFullName, val.receiverTel, val.receiverName);
                        }else{
                            tempStr = tempStr + '<div data-tel="'+val.receiverTel+'" data-info="'+val.addressFullName+'" data-addrId="'+val.addrId+'" class="addr-item">'+val.receiverName+'<b></b></div>';
                        }
                    }

                    tempStr = tempStr + '<div class="addr-detail">';
                    tempStr = tempStr + '<span class="addr-name">'+val.receiverName+'</span>';
                    tempStr = tempStr + '<span class="addr-info">'+val.addressFullName+'</span>';
                    tempStr = tempStr + '<span class="addr-tel">'+val.receiverTel+'</span>';
                    if(val.isDefaultAddr == 1){
                        tempStr = tempStr + '<span class="addr-default">默认地址</span>';
                    }
                    tempStr = tempStr + '</div>';


                    tempStr = tempStr + '<div class="op-btns">';
                    if(val.isDefaultAddr == 0){
                        tempStr = tempStr + '<a href="javascript:void(0);" data-addrId="'+val.addrId+'" class="userAddressDefault">设为默认地址</a>';
                    }
                    tempStr = tempStr + '<a href="javascript:void(0);" data-addrId="'+val.addrId+'" class="userAddressEdit">编辑</a>';
                    tempStr = tempStr + '<a href="javascript:void(0);" data-addrId="'+val.addrId+'" class="userAddressDel">删除</a>';
                    tempStr = tempStr + '</div>';

                    tempStr = tempStr + '</li>';
                })

                $('#userAddressListUl').append(tempStr);

                hideOrShowMoreAddress();
            }
        }, "json");
    }

    function showExpressConfirmMsg(dataInfo, dataTel, dataUserName){
        // 显示 确认收货地址信息
        $('#expressConfirmMsg_detailAddress').text(dataInfo);
        $('#expressConfirmMsg_receiveName').text(dataUserName+"  "+dataTel);
        $('#expressConfirmMsg').show();
    }

    function hideOrShowMoreAddress(){
        var propsbox = $(".step-addr"),openheight;
        //console.log('propsbox[0].scrollHeight='+propsbox[0].scrollHeight);

        if(!hideOrShowMoreAddressFlag){
            hideOrShowMoreAddressFlag = true;

            var closeheight = propsbox.find("li").eq(0).outerHeight(true);

            propsbox.height(closeheight).addClass("toggled");

            $(".addr-switch").on("click",function(){
                if(propsbox.hasClass("toggled")){
                    $(".addr-switch").removeClass("switch-on");
                    $(".addr-switch").find("span").html("收起地址");
                    openheight = propsbox[0].scrollHeight;
                    propsbox.animate({
                        height : openheight
                    }, function() {
                        propsbox.removeClass("toggled");
                    });

                }else{
                    $(".addr-switch").addClass("switch-on");
                    $(".addr-switch").find("span").html("更多地址");
                    propsbox.animate({
                        height : closeheight
                    }, function() {
                        propsbox.addClass("toggled");
                    });
                }
            });
        }else{
            propsbox.height(propsbox[0].scrollHeight);
        }
    }

    // 收货地址相关事件
    function initUserAddressEvent(){
        $('#addressProvinceId').on('change', function(){
            var selectProvinceId = $(this).val();
            console.log("selectProvinceId="+selectProvinceId);
            linkAgeCitySelect(selectProvinceId);
        });

        $('#addressCityId').on('change', function(){
            var selectCityId = $(this).val();
            console.log("selectCityId="+selectCityId);
            linkAgeCountrySelect(selectCityId);
        })

        // 新增收货地址
        $("#newaddressBtn").on("click",function(){
            $('#newAddressId').val("");
            $('#addressName').val("");
            $('#addressDetail').val("");
            $('#addressTel').val("");

            $('#addressProvinceId').val("1");
            $('#addressProvinceId').trigger('change');

            cleanSelectContent("addressCountryId", "-- 请选择区/县 --");

            newaddress();
        })

        // 设为默认地址
        $('#userAddressListUl').on('click', '.userAddressDefault', function(){
            var addrId = $(this).attr('data-addrId');
            $.post("/m/account/userAddress/setDefaultAddress.html", {addrId: addrId}, function (data) {
                if(data.result == "success"){
                    loadUserAddress(currentSelectAddressId);
                }else{
                    layer.msg(data.message || '网络异常,请稍后再试!');
                }
            })
        });

        // 编辑收货地址
        $('#userAddressListUl').on('click', '.userAddressEdit', function(){
            var addrId = $(this).attr('data-addrId');
            $.get("/account/userAddress/getUserAddress.html", {addrId: addrId}, function (data) {
                if(data && data.userAddressDTO){
                    $('#newAddressId').val(data.userAddressDTO["addrId"]);
                    $('#addressName').val(data.userAddressDTO["receiverName"]);
                    $('#addressDetail').val(data.userAddressDTO["receiverAddr"]);
                    $('#addressTel').val(data.userAddressDTO["receiverTel"]);

                    $('#addressProvinceId').val(data.userAddressDTO["receiverProvinceId"]);
                    $('#addressProvinceId').trigger('change');

                    $('#addressCityId').val(data.userAddressDTO["receiverCityId"]);
                    $('#addressCityId').trigger('change');

                    $('#addressCountryId').val(data.userAddressDTO["receiverCountyId"]);
                }
            }, "json");

            newaddress();
        });

        // 删除收货地址
        $('#userAddressListUl').on('click', '.userAddressDel', function(){
            var addrId = $(this).attr('data-addrId');

            layer.confirm('确认要删除吗？', {
                btn: ['确认','取消'] //按钮
            }, function(){
                layer.closeAll();

                $.post("/m/account/userAddress/deleteAddress.html", {addrId: addrId}, function (data) {
                    if(data.result == "success"){
                        loadUserAddress(currentSelectAddressId);
                    }else{
                        layer.msg(data.message || '网络异常,请稍后再试!');
                    }
                })
            }, function(){
                layer.closeAll();
            });
        });

        $('#newAddressSaveBtn').click(function(){
            var addressId = $('#newAddressId').val();
            var addressName = $('#addressName').val();
            var addressProvinceId = $('#addressProvinceId').val();
            var addressCityId = $('#addressCityId').val();
            var addressCountryId = $('#addressCountryId').val();
            var addressDetail = $('#addressDetail').val();
            var addressTel = $('#addressTel').val();

            var data = {};
            data.addrId = addressId;
            data.receiverName = addressName;
            data.receiverTel = addressTel;
            data.receiverProvinceId = addressProvinceId;
            data.receiverCityId = addressCityId;
            data.receiverCountyId = addressCountryId;
            data.receiverAddr = addressDetail;

            $.post("/m/account/userAddress/saveOrUpdateAddress.html", data, function (data) {
                if(data.result == "success"){
                    layer.closeAll();

                    loadUserAddress(currentSelectAddressId);
                }else{
                    layer.msg(data.message || '网络异常,请稍后再试!');
                }
            })
        });
    }

    var newAddress;
    function newaddress(){
        newAddress = layer.open({
            type: 1,
            title: '新增地址',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['720px'],
            content: $("#newddress")
        });
    }

    function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    }

    function linkAgeCitySelect(selectProvinceId){
        if(selectProvinceId && selectProvinceId != ""){
            $.ajax({
                url : '/common/area/findChildByParentId',
                dataType : 'json',
                type: 'GET',
                async: false,
                data : {parentId: selectProvinceId},
                success : function(data){
                    if(data.rowCount && data.rowCount >0){
                        cleanSelectContent("addressCityId", "-- 请选择城市 --");
                        cleanSelectContent("addressCountryId", "-- 请选择区/县 --");

                        $.each(data.rows, function(i, row){
                            $("#addressCityId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                        });
                    }else{
                        cleanSelectContent("addressCityId", "-- 请选择城市 --");
                        cleanSelectContent("addressCountryId", "-- 请选择区/县 --");
                    }
                }
            });
        }else{
            cleanSelectContent("addressCityId", "-- 请选择城市 --");
            cleanSelectContent("addressCountryId", "-- 请选择区/县 --");
        }
    }

    function linkAgeCountrySelect(selectCityId){
        if(selectCityId && selectCityId != ""){
            $.ajax({
                url : '/common/area/findChildByParentId',
                dataType : 'json',
                type: 'GET',
                async: false,
                data : {parentId: selectCityId},
                success : function(data){
                    if(data.rowCount && data.rowCount >0){
                        cleanSelectContent("addressCountryId", "-- 请选择区/县 --");

                        $.each(data.rows, function(i, row){
                            $("#addressCountryId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                        });
                    }else{
                        cleanSelectContent("addressCountryId", "-- 请选择区/县 --");
                    }
                }
            });
        }else{
            cleanSelectContent("addressCountryId", "-- 请选择区/县 --");
        }
    }

    // 输出 账户余额 使用情况
    function renderUseUserBalance(cancleUseUserBalanceTip){
        // 是否使用了余额
        var isUseUserBalance = false;
        var totalPrice = getTotalPrice();
        if(totalPrice <= 0){
            isUseUserBalance = false;

            if($("#useUserBalance").is(":checked")){
                // 去掉勾选的 账户余额支付
                $("#useUserBalance").attr("checked", false);

                if(cancleUseUserBalanceTip != undefined && cancleUseUserBalanceTip){
                    layer.msg('应付金额为0,不需要使用余额抵扣!');
                }
            }
        }else{
            if($("#useUserBalance").is(":checked")){
                // 使用了 账户余额支付
                isUseUserBalance = true;
            }
        }

        if(isUseUserBalance){
            if(userBalance > totalPrice){
                // 余额大于 需要支付金额
                $('#userBalancePay').text(totalPrice);
            }else{
                // 余额小于 需要支付金额
                $('#userBalancePay').text(userBalance);
            }
        }else{
            $('#userBalancePay').text(0);
        }
    }

    function getUserBalancePay(){
        var userBalancePay = parseFloat($('#userBalancePay').html().trim());
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
</script>