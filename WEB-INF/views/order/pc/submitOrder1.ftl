<#assign ctx = request.contextPath>
<#include "../../user/pc/include/addrSelect.ftl"/>
<style>
    .ms-controller {
        visibility: hidden;
    }
</style>
<div id="main" ms-controller="main" class="ms-controller">
    <div class="checkout">
        <div class="checkout-tit">填写并核对订单信息</div>
        <div class="checkout-steps">
            <div class="step-tit">
                <h3>收货人信息</h3>
                <span class="extra-r flr"><a href="javascript:void(0);" class="link" id="newaddressBtn"
                                             ms-click="@newaddress">新增地址</a></span>
            </div>
            <div class="step-addr-wrap">
                <div class="step-addr">
                    <ul>
                        <li ms-for="($index,address) in @data.addressList"
                            ms-class="$index == @addrClass && 'step-addr-selected'" ms-mouseenter="@addrClass = $index"
                            ms-mouseleave="@addrClass = -1">
                            <div ms-class="['addr-item',$index == @addrIndex && 'item-selected']"
                                 ms-click="@addrSelect($index,address.addrId)">{{address.receiverName}}
                                <b></b>
                            </div>
                            <div class="addr-detail">
                                <span class="addr-name">{{address.receiverName}}</span>
                                <span class="addr-info">{{address.receiverProvinceName}} {{address.receiverCityName}} {{address.countyName}} {{address.receiverAddr}}</span>
                                <span class="addr-tel">{{address.receiverTel}}</span>
                                <span class="addr-default" ms-visible="address.isDefaultAddr == 1">默认地址</span>
                            </div>
                            <div class="op-btns">
                                <a href="javascript:;" ms-click="@addrSetDefault(address.addrId)">设为默认地址</a>
                                <a href="javascript:;" ms-click="@addrEdit(address.addrId)">编辑</a>
                                <a href="javascript:;" ms-click="@addrDel(address.addrId)">删除</a>
                            </div>
                        </li>
                    </ul>
                </div>
                <div class="addr-switch">
                    <span>更多地址</span><b></b>
                </div>
            </div>
            <div class="step-since-wrap" ms-visible="@data.storeList.length > 0">
                <div class="step-since">
                    <div :class="['since-item',@addrIndex == -1 && 'item-selected']" ms-click="@storeSelect">线下自提<b></b>
                    </div>
                    <div class="since-selected">
                        <ul>
                            <li ms-for="store in @data.storeList"><label><input type="radio" ms-duplex="@form.storeId"
                                                                                name="sinceSelected"
                                                                                ms-attr="{value:store.storeId+''}">
                                <p>{{store.storeName}}</p></label><span>{{store.storeAddress}}</span></li>
                        </ul>
                    </div>
                </div>
                <div class="since-switch">
                    <span>更多</span><b></b>
                </div>
            </div>
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>商品信息</h3>
                    <span class="extra-r flr"><a href="/cart/list" class="link">返回修改购物车</a></span>
                </div>
                <div class="shoptb">
                    <div class="shoptb-hd">
                        <table>
                            <tbody>
                            <tr>
                                <td class="td-product">商品</td>
                                <td>单价</td>
                                <td class="td-amount">数量</td>
                                <td class="td-total">小计</td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="shoptb-row">
                        <table>
                            <tbody>
                            <tr ms-for="($index,cart) in @data.cartList">
                                <td class="td-product">
                                    <div class="first-column">
                                        <div class="img"><a href="javascript:;" ms-attr="{href:'/product/'+cart.masterProductId}"><img ms-attr="{src:cart.productPicUrl}"></a></div>
                                        <div class="info">
                                            <div class="name"><a href="javascript:;" ms-attr="{href:'/product/'+cart.masterProductId}" >{{cart.productName}}</a>
                                            </div>
                                            <div class="prop"><span>{{cart.skuValue}}</span>
                                            </div>
                                            <div class="prop text-orange" ms-if="cart.promotionDesc">
                                                {{cart.promotionDesc}}
                                            </div>
                                        </div>
                                    </div>
                                </td>
                                <td ms-if="cart.productPriceUserLevelXrefList.length > 0">
                                    <select class="select" ms-change="setProductPriceInfo($index,$event)">
                                        <option ms-for="($i,puxref) in cart.productPriceUserLevelXrefList"
                                                ms-attr="{value:$i}">{{puxref.desc}}
                                        </option>
                                    </select>
                                </td>
                                <td class="td-price" ms-if="!cart.productPriceUserLevelXrefList">
                                    ￥{{cart.firstAddedSalePrice}}
                                </td>
                                <td class="td-amount">{{cart.quantity}}</td>
                                <td class="td-total" ms-if="cart.productPriceUserLevelXrefList.length > 0"><em>￥{{cart.productPriceUserLevelXrefList[productPriceIndex[$index]].cash}} </em>
                                </td>
                                <td class="td-total" ms-if="!cart.productPriceUserLevelXrefList">
                                    <em>￥{{cart.subtotal}} </em></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="step-wrap" ms-if="@addrIndex != -1">
                <div class="step-tit">
                    <h3>配送信息</h3>
                </div>
                <div class="formList">
                    <div class="item">
                        <div class="hd">送货方式</div>
                        <div class="bd">
                            <select ms-duplex="@form.expressId">
                                <option value="0">请选择</option>
                                <option ms-for="express in @data.expressList" ms-attr="{value:express.expressId}">
                                    {{express.expressName}}￥{{express.orderExpressAmt}}
                                </option>
                            </select>
                        </div>
                    </div>
                    <div class="item" ms-if="@conditionTwoIsUse == 1">
                        <div class="hd">配送时间</div>
                        <div class="bd">
                            <select ms-duplex="@form.expectSendTime">
                                <option value="0">请选择</option>
                                <option ms-for="($key, $val) in @data.expectSendTimeMap" ms-attr="{value:$key}">
                                    {{$val}}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="step-wrap" ms-if="@addrIndex == -1">
                <div class="formList">
                    <div class="item">
                        <div class="hd">选择提货时间</div>
                        <div class="bd">
                            <select class="mr20" ms-duplex="@storeDate">
                                <option value="-1">日期</option>
                                <option ms-for="($key, $val) in @data.storeDate" ms-attr="{value:$key}">{{$val}}
                                </option>
                            </select>
                            <select ms-duplex="@stotrDataTime">
                                <option value="-1">时间</option>
                                <option ms-attr="{value:@store.deliveryTimeAmStart+'-'+@store.deliveryTimeAmEnd}">
                                    {{@store.deliveryTimeAmStart}}-{{@store.deliveryTimeAmEnd}}
                                </option>
                                <option ms-attr="{value:@store.deliveryTimePmStart+'-'+@store.deliveryTimePmEnd}">
                                    {{@store.deliveryTimePmStart}}-{{@store.deliveryTimePmEnd}}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="step-wrap" ms-if="@conditionOneIsUse == 1">
                <div class="step-tit">
                    <h3>发票信息</h3>
                    <span class="extra-r flr"><a href="javascript:void(0);" class="link addinvoiceBtn"
                                                 ms-click="@newInvoice">新增发票</a></span>
                </div>
                <div class="step-invoice-wrap">
                    <div class="step-invoice">
                        <ul>
                            <li>
                                <div ms-class="['invoice-item',@invoiceIndex == -1 && 'invoice-selected']"
                                     ms-click="@invoiceSelect(-1,-1)">不选择发票
                                    <b></b>
                                </div>
                            </li>
                            <li ms-for="($index,invoice) in @data.invoiceList">
                                <div ms-class="['invoice-item',@invoiceIndex == $index && 'invoice-selected']"
                                     ms-click="invoiceSelect($index,invoice.invoiceId)">{{invoice.invoiceForCd == 1 ?
                                    "个人发票" : "单位发票"}}
                                    <b></b>
                                </div>
                                <div class="invoice-detail">
                                    <span class="addr-name">{{invoice.companyName}}</span>
                                    <span class="addr-info"></span>
                                    <div class="op-btns">
                                        <a href="javascript:;" ms-click="invoiceEdit(invoice.invoiceId)">编辑</a>
                                        <a href="javascript:;" ms-click="invoiceDel(invoice.invoiceId)">删除</a>
                                    </div>
                                </div>
                            </li>

                        </ul>
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
                                <div class="hd">使用活动</div>
                                <div class="bd">
                                    <select ms-duplex="@form.promotionDiscountId">
                                        <option value="-1">请选择</option>
                                        <option ms-for="promotion in @data.promotionList"
                                                ms-attr="{value:promotion.id}">{{promotion.discountDesc}}
                                        </option>
                                    </select>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">使用优惠券</div>
                                <div class="bd">
                                    <select ms-duplex="@form.couponCodeId">
                                        <option value="-1">请选择</option>
                                        <option ms-for="coupon in @data.couponList"
                                                ms-attr="{value:coupon.couponCodeId}">{{coupon.discountDesc}}
                                        </option>
                                    </select>
                                    <p style="margin-top: 5px;">
                                        <input ms-duplex="@couponCode" type="text" class="textfield">&nbsp;&nbsp;
                                        <a href="javascript:void(0)" class="v-btn" ms-click="@useCouponCode">使用</a>
                                    </p>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">使用红包</div>
                                <div class="bd">
                                    <select ms-duplex="@form.redPacketCodeId">
                                        <option value="-1">请选择</option>
                                        <option ms-for="redPacket in @data.redPacketList"
                                                ms-attr="{value:redPacket.couponCodeId}">
                                            {{redPacket.couponCodeValue}}元红包
                                        </option>
                                    </select>&nbsp;&nbsp;
                                <#--已抵扣 8.00 元-->
                                </div>
                            </div>
                            <div class="item" ms-if="@data.userBlance > 0">
                                <div class="hd">余额抵扣</div>
                                <div class="bd">
                                    <input id="integral" type="checkbox" ms-duplex-checked="@switchStatus"
                                           name="integral"><span class="infotext">当前可用余额￥{{@data.userBlance}}，是否使用</span>
                                </div>
                            </div>
                            <div class="item">
                                <div class="hd">订单备注</div>
                                <div class="bd">
                                    <textarea placeholder="订单备注" class="textarea w300"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="order-total">
                        <div class="row">
                            <div class="tit">商品总价：</div>
                            <div class="con">￥{{@productPriceAmt}}</div>
                        </div>
                        <div class="row">
                            <div class="tit">促销折扣：</div>
                            <div class="con">-￥{{@usePromotionValue}}</div>
                        </div>
                        <div class="row">
                            <div class="tit">优惠券抵扣：</div>
                            <div class="con">-￥{{@useCouponValue}}</div>
                        </div>
                        <div class="row">
                            <div class="tit">红包抵扣：</div>
                            <div class="con">-￥{{@useRedpackValue}}</div>
                        </div>
                        <div class="row">
                            <div class="tit">快递费用：</div>
                            <div class="con">￥{{@expressAmt}}</div>
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
                <span class="price-num" ms-if="realityPay - userBlanceValue >= 0">￥{{(@realityPay - @userBlanceValue).toFixed(2)}}<span
                        ms-visible="@productScoreAmt != 0">+积分{{@productScoreAmt}}</span></span>
            </div>
            <div class="fc-price-info" ms-visible="@form.addrId != -1">
                <span class="mr20">寄送至： {{@selectAddressData.receiverProvinceName + ' '+ @selectAddressData.receiverCityName + ' ' + @selectAddressData.countyName + ' ' + @selectAddressData.receiverAddr}}</span>
                <span>收货人：{{@selectAddressData.receiverName + ' ' + @selectAddressData.receiverTel}} </span>
            </div>
        </div>
        <div class="inner">
            <button id="btnBuy">提交订单</button>
        </div>
    </div>

    <div id="payment" class="hidden">
        <div class="paytypes">
            <ul>
                <li ms-for="($key,$val) in @data.payTypeList">
                    <a href="javascript:;" ms-if="$key == 'config_alipay_pc'" ms-click="pay(2)">支付宝支付</a>
                    <a href="javascript:;" ms-if="$key == 'config_unionpay_mobile'" ms-click="pay(4)">银联支付</a>
                    <a href="javascript:;" ms-if="$key == 'weixin_pay_config'" ms-click="pay(1)">微信支付</a>
                </li>
            <#--<li id="balancePayment"><a href="javascript:void(0);">余额支付</a></li>
            <li><a href="#">支付宝支付</a></li>
            <li><a href="#">银联支付</a></li>-->
            </ul>
        </div>
    </div>
    <div id="payPassword" class="hidden">
        <div class="formList paypassword" ms-visible="@data.isPayPassword">
            <input class="hidden" ms-attr="{value:@userBlanceValue}">
            <div class="item">
                <div class="hd">输入支付密码：</div>
                <div class="bd">
                    <input type="password" class="textfield" ms-duplex="payPassword">
                </div>
            </div>
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <a class="v-btn" href="javascript:;" ms-click="@pwdSubmit">确定</a>
                </div>
            </div>
        </div>
        <div class="formList paypassword" style="display: none;" ms-visible="!@data.isPayPassword">
            <div class="set-payment-password">
                您还未设置支付密码，请先设置<a href="/account/userChangePaw?type=2&successUrl=/account/order/submitOrder"
                                 class="text-red">支付密码</a>
            </div>
        </div>
    </div>

    <div id="newddress" class="hidden">
        <div class="reg-form">
            <input class="hidden" ms-duplex="@addressForm.addrId" ms-attr="{value:@addressData.addrId}">
            <ul>
                <li>
                    <div class="hd">姓名</div>
                    <div class="bd">
                        <div class="item"><input ms-duplex="@addressForm.receiverName"
                                                 ms-attr="{value:@addressData.receiverName}" type="text"
                                                 class="textfield"></div>
                    </div>
                </li>
                <li>
                    <div class="hd">所在地区</div>
                    <div class="bd">
                        <select ms-duplex="@addressForm.receiverProvinceId">
                            <option value="-1">请选择</option>
                            <option ms-for="province in @provinceList" ms-attr="{value:province.id}">
                                {{province.areaName}}
                            </option>
                        </select>
                        <select ms-duplex="@addressForm.receiverCityId">
                            <option value="-1">请选择</option>
                            <option ms-for="city in @cityList" ms-attr="{value:city.id}">{{city.areaName}}</option>
                        </select>
                        <select ms-duplex="@addressForm.receiverCountyId">
                            <option value="-1">请选择</option>
                            <option ms-for="county in @countyList" ms-attr="{value:county.id}">{{county.areaName}}
                            </option>
                        </select>
                    </div>
                </li>
                <li>
                    <div class="hd">街道</div>
                    <div class="bd">
                        <textarea ms-duplex="@addressForm.receiverAddr"
                                  ms-attr="{value:@addressData.receiverAddr}"></textarea>
                    </div>
                </li>
                <li>
                    <div class="hd">手机号码</div>
                    <div class="bd">
                        <div class="item"><input ms-duplex="@addressForm.receiverTel"
                                                 ms-attr="{value:@addressData.receiverTel}" type="text"
                                                 class="textfield"></div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <a href="#" class="btn-action" ms-click="@submitAddress">保存地址</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <div id="addinvoice" class="hidden">
        <div class="formList">
            <input class="hidden" ms-duplex="@invoiceForm.invoiceId" ms-attr="{value:@invoiceData.invoiceId}">
            <div class="item">
                <div class="hd">发票类型</div>
                <div class="bd">
                    <ul class="invoice-tab">
                        <li ms-class="{selected:@invoiceData.invoiceTypeCd == 1}" data-name="normal_pager"
                            ms-click="@selectInvoiceTypeCd(1)">普通发票
                        </li>
                        <li ms-class="{selected:@invoiceData.invoiceTypeCd == 2}" data-name="vat"
                            ms-click="@selectInvoiceTypeCd(2)">增值税发票
                        </li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="formList">
            <div class="item">
                <div class="hd">发票抬头</div>
                <div class="bd">
                    <div class="whether">
                        <p id="invoiceTitlePersonalLabel" ms-visible="@invoiceData.invoiceTypeCd == 1"><label>
                            <input type="radio" id="invoiceTitlePersonal"
                                   name="invoiceTitle"
                                   ms-duplex="@invoiceForm.invoiceForCd"
                                   ms-attr="{checked:@invoiceData.invoiceForCd == 1,value:'1'}">个人</label>
                        </p>
                        <p><label><input type="radio" id="invoiceTitleCompany" name="invoiceTitle"
                                         ms-duplex="@invoiceForm.invoiceForCd"
                                         ms-attr="{checked:@invoiceData.invoiceForCd == 2, value:'2'}">单位</label></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="formList" id="personalDiv" ms-visible="@invoiceData.invoiceForCd == 1">
            <div class="item">
                <div class="hd" id="personalOrCompanyDiv"><i class="text-red">*</i>个人姓名</div>
                <div class="bd">
                    <div class="bd"><input type="text" ms-duplex="@invoiceForm.companyName"
                                           ms-attr="{value:@invoiceData.companyName}" placeholder="请输入个人姓名"
                                           class="textfield personalOrCompanyprompt w300"></div>
                </div>
            </div>
        </div>
        <div class="formList" id="vatInvoiceDiv" ms-visible="@invoiceData.invoiceForCd == 2">
            <div class="item">
                <div class="hd"><i class="text-red">*</i>单位名称</div>
                <div class="bd">
                    <div class="bd"><input type="text" ms-duplex="@invoiceForm.companyName"
                                           ms-attr="{value:@invoiceData.companyName}" placeholder="请输入单位名称"
                                           class="textfield w300"></div>
                </div>
            </div>
            <div ms-visible="@invoiceData.invoiceTypeCd == 2">
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>纳税人识别码</div>
                    <div class="bd">
                        <div class="bd"><input type="text" ms-duplex="@invoiceForm.companyTaxpayerIdentifyCode"
                                               ms-attr="{value:@invoiceData.companyTaxpayerIdentifyCode}"
                                               placeholder="请输入纳税人识别码" class="textfield w300"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>注册地址</div>
                    <div class="bd">
                        <div class="bd"><input type="text" ms-duplex="@invoiceForm.companyRegisterAddr"
                                               ms-attr="{value:@invoiceData.companyRegisterAddr}" placeholder="请输入注册地址"
                                               class="textfield w300"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>注册电话</div>
                    <div class="bd">
                        <div class="bd"><input type="number" ms-duplex="@invoiceForm.companyRegisterTel"
                                               ms-attr="{value:@invoiceData.companyRegisterTel}" placeholder="请输入注册电话"
                                               class="textfield w300"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>银行帐户</div>
                    <div class="bd">
                        <div class="bd"><input type="number" ms-duplex="@invoiceForm.companyBankAccount"
                                               ms-attr="{value:@invoiceData.companyBankAccount}" placeholder="请输入银行帐户"
                                               class="textfield w300"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>开户行</div>
                    <div class="bd">
                        <div class="bd"><input type="text" ms-duplex="@invoiceForm.companyOpeningBankName"
                                               ms-attr="{value:@invoiceData.companyOpeningBankName}"
                                               placeholder="请输入开户行"
                                               class="textfield w300"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>发票抬头</div>
                    <div class="bd">
                        <div class="bd"><input type="text" ms-duplex="@invoiceForm.invoiceTitle"
                                               ms-attr="{value:@invoiceData.invoiceTitle}" placeholder="请输入发票抬头"
                                               class="textfield w300"></div>
                    </div>
                </div>
                <div class="item">
                    <div class="hd"><i class="text-red">*</i>发票配送地址</div>
                    <div class="bd">
                        <div class="invoice-ws">
                            <select class="invoice-select" ms-duplex="@invoiceForm.invoiceProvinceId">
                                <option value="-1">请选择</option>
                                <option ms-for="province in @provinceList" ms-attr="{value:province.id}">
                                    {{province.areaName}}
                                </option>
                            </select>
                            <select class="invoice-select" ms-duplex="@invoiceForm.invoiceCityId">
                                <option value="-1">请选择</option>
                                <option ms-for="city in @cityList" ms-attr="{value:city.id}">{{city.areaName}}</option>
                            </select>
                            <select class="invoice-select" ms-duplex="@invoiceForm.invoiceCountyId">
                                <option value="-1">请选择</option>
                                <option ms-for="county in @countyList" ms-attr="{value:county.id}">{{county.areaName}}
                                </option>
                            </select>
                        <#--<a class="text-orange" href="javascript:void(0);">默认收货地址</a>-->
                        </div>
                    <#--<textarea placeholder="街道地址" class="textarea w300"></textarea>-->
                    </div>
                </div>
            </div>
        </div>
        <div class="formList">
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <div class="bd"><a class="btn-action" href="javascript:void(0);" ms-click="@invoiceAdd">保存发票信息</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="Gotop">
    <a href="javascript:void(0);"><img src="${ctx}/static/images/gotop.png"></a>
</div>

<script src="${ctx}/static/js/jquery.placeholder.min.js"></script>

<script>
    var vm = avalon.define({
        $id: 'main',
        flag: true,
        addrIndex: 0,  //地址下标
        addrClass: -1,  //地址的类
        invoiceIndex: -1,
        invoiceClass: -1,
        provinceList: {},//省集合
        cityList: {},//市集合
        countyList: {},//区集合
        data: {},//整个下单的数据
        form: {
        <#--商品价格的类型-->
            productPriceType: '',
        <#--地址Id-->
            addrId: -1,
        <#--快递Id-->
            expressId: 0,
        <#--发票Id-->
            invoiceId: -1,
        <#--支付金额-->
            payAmt: 0,
        <#--买家留言-->
            orderRemark: '',
        <#--支付类型-->
            payWay: -1,
        <#--使用的余额-->
            userBlanceValue: 0,
        <#--平台类型-->
            originPlatformCd: 0,
        <#--使用活动Id-->
            promotionId: -1,
        <#--使用活动折扣Id-->
            promotionDiscountId: -1,
        <#--使用优惠券Id-->
            couponCodeId: -1,
        <#--使用优惠券折扣Id-->
            couponDiscountId: -1,
        <#--使用红包Id-->
            redPacketCodeId: -1,
        <#--搭配套餐Id-->
            combinationId: '',
        <#--搭配套餐数量-->
            combinationNum: '',
        <#--配送时间-->
            expectSendTime: 0,
        <#--门店Id-->
            storeId: -1,
        <#--提货起始时间-->
            storeStartDateTime: '',
        <#--提货结束时间-->
            storeEndDateTime: ''
        },
    <#--收货地址保存时的数据-->
        addressForm: {
            addrId: '',
            receiverName: '',
            receiverTel: '',
            receiverProvinceId: -1,
            receiverCityId: -1,
            receiverCountyId: -1,
            receiverAddr: ''
        },
    <#--发票保存时的数据-->
        invoiceForm: {
            invoiceId: '',
            invoiceForCd: 1,
            invoiceTypeCd: 1,
            companyName: '',
            companyTaxpayerIdentifyCode: '',
            companyRegisterAddr: '',
            companyRegisterTel: '',
            companyBankAccount: '',
            companyOpeningBankName: '',
            invoiceTitle: '',
            invoiceProvinceId: '',
            invoiceCityId: '',
            invoiceCountyId: ''
        },
    <#--选择的收货地址数据-->
        selectAddressData: {},
    <#--编辑时的发票数据-->
        invoiceData: this.initInvoiceData,
    <#--编辑时的收货地址数据-->
        addressData: this.initAddressData,
    <#--商品价格的下标-->
        productPriceIndex: [],
    <#--支付密码-->
        payPassword: '',
    <#--支付密码是否正确-->
        isPayPwd: false,
    <#--是否显示支付方式弹出框-->
        showPayType: true,
    <#--开关状态-->
        switchStatus: true,
    <#--是否需要运费-->
        isFreight: true,
    <#--是否使用了优惠码-->
        isUseCouponCode: false,
    <#--使用的优惠码-->
        couponCode: '',
    <#--标识选择的时间-->
        dataIndex: 0,
    <#--提货日期-->
        storeDate: '',
    <#--提货时间-->
        stotrDataTime: '',
    <#--提货开始时间-->
        storeStartTime: '',
    <#--提货结束时间-->
        storeEndTime: '',
    <#--提货日期描述-->
        storeDateDesc: '',
    <#--提货时间描述-->
        storeDateTimeDesc: '',
    <#--发票是否显示 1显示，0不显示-->
        conditionOneIsUse: 0,
    <#--发票是否必填 1必填，0不是必填-->
        conditionOneIsRequired: 0,
    <#--收送货时间是否显示 1显示，0不显示-->
        conditionTwoIsUse: 0,
    <#--收送货时间是否必选  1显示，0不显示-->
        conditionTwoIsRequired: 0,
    <#--选中的自提门店-->
        store: {},
    <#--选择地址-->
        addrSelect: function (index, addrId) {//index:地址下标，addrId：地址Id
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/account/order/testAddress',
                async: true,
                type: "GET",
                dataType: "json",
                data: {"addrId": addrId, "productIds": vm.data.productIds},
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        vm.selectAddressData = vm.data.addressList[index];
                        vm.addrIndex = index;
                        vm.form.addrId = addrId;
                        vm.form.storeId = -1;
                    } else {
                        vm.addrIndex = -2;
                        vm.form.addrId = -1;
                        layer.msg(result.message);
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--选择自提门店-->
        storeSelect: function () {
            this.addrIndex = -1;
            this.form.addrId = -1;
            vm.form.storeId = vm.data.storeList[0].storeId + '';//默认选择第一个
        },
    <#--选择发票-->
        invoiceSelect: function (i, invoiceId) {
            this.invoiceIndex = i;
            this.form.invoiceId = invoiceId;
        },
    <#--处理完整的时间-->
        storeDateTime: function () {
            if (!this.storeDate || !this.storeStartTime || !this.storeEndTime) {
                return;
            }
            this.form.storeStartDateTime = this.storeDate + ' ' + this.storeStartTime + ':00';
            this.form.storeEndDateTime = this.storeDate + ' ' + this.storeEndTime + ':00';
        },
    <#--获取地址列表-->
        addressList: function () {
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/account/order/submitOrder/getAddressList',
                async: true,
                type: "POST",
                dataType: "json",
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        vm.data.addressList = result.data;
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--弹出新增地址弹出框操作-->
        newaddress: function () {
            this.areaList(0, 0);//初始化省
            this.addressData = this.initAddressData;//恢复初始数据
            this.addressForm = this.initAddressData;//恢复初始数据
            newaddress('新增地址');
        },
    <#--新增地址-->
        submitAddress: function () {
            if (!this.addressFormTest()) {
                return;
            }
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/account/order/submitOrder/updateOrInsertAddress',
                async: true,
                type: "POST",
                dataType: "json",
                data: this.addressForm,
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        layer.msg('地址保存成功!');
                        vm.addressList();
                        $('#newddress').addClass('hidden');
                        layer.closeAll();//关闭所有的弹窗
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--编辑地址-->
        addrEdit: function (addrId) {
            vm.addressForm = vm.initAddressData;//恢复初始数据
            vm.addressData = vm.initAddressData;//恢复初始数据
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/account/order/submitOrder/editAddress',
                async: true,
                type: "GET",
                dataType: "json",
                data: {'addressId': addrId},
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {

                        vm.addressData = result.data;
                        vm.areaList(0, 0);
                        newaddress('编辑地址');
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--删除地址-->
        addrDel: function (addrId) {
            layer.confirm('确定要删除该地址吗?', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                if (!vm.flag) {
                    return;
                }
                $.ajax({
                    url: '/account/order/submitOrder/delAddress',
                    async: true,
                    type: "GET",
                    dataType: "json",
                    data: {'addressId': addrId},
                    success: function (result) {
                        vm.flag = true;
                        if (result.result == 'success') {
                            layer.msg('删除成功!');
                            vm.addressList();
                            return false;
                        } else {
                            layer.msg(result.message);
                            return false;
                        }
                        layer.closeAll();
                    },
                    error: function (XMLHttpResponse) {
                        vm.flag = true;
                        console.log("请求未成功");
                    }
                });
            }, function () {
                layer.closeAll();
            });
        },
    <#--设置默认地址-->
        addrSetDefault: function (addrId) {
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/account/order/submitOrder/setDefaultAddress',
                async: true,
                type: "GET",
                dataType: "json",
                data: {'addressId': addrId},
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        layer.msg('默认地址设置成功!');
                        vm.addressList();
                        return false;
                    } else {
                        layer.msg(result.message);
                        return false;
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--选择发票类型-->
        selectInvoiceTypeCd: function (type) {
            vm.invoiceForm.invoiceTypeCd = type;
            vm.invoiceForm.invoiceForCd = type;
            vm.invoiceData.invoiceTypeCd = type;
            vm.invoiceData.invoiceForCd = type;
        },
    <#--重新获取发票列表数据-->
        invoiceList: function () {
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/m/account/invoice/chooseInvoiceList/grid_json',
                async: true,
                type: "GET",
                dataType: "json",
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        vm.data.invoiceList = result.data;
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--新增发票弹窗操作-->
        newInvoice: function () {
            this.areaList(0, 0);
            this.invoiceData = this.initInvoiceData;//恢复初始数据
            addinvoice('新增发票');
        },
    <#--新增发票-->
        invoiceAdd: function () {
            if (!vm.invoiceFormTest()) {
                return;
            }
            if (!vm.flag) {
                return;
            }
            if(vm.invoiceForm.invoiceTypeCd == 1) {
                vm.invoiceForm.companyTaxpayerIdentifyCode =  '';
                vm.invoiceForm.companyRegisterAddr =  '';
                vm.invoiceForm.companyRegisterTel =  '';
                vm.invoiceForm.companyBankAccount =  '';
                vm.invoiceForm.companyOpeningBankName =  '';
                vm.invoiceForm.invoiceTitle =  '';
                vm.invoiceForm.invoiceProvinceId =  '';
                vm.invoiceForm.invoiceCityId = '';
                vm.invoiceForm.invoiceCountyId = '';
            }
            $.ajax({
                url: '/m/account/invoice/addInvoice/save',
                async: true,
                type: "POST",
                dataType: "json",
                data: vm.invoiceForm,
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        layer.msg('发票保存成功!');
                        vm.invoiceList();
                        $('#addinvoice').addClass('hidden');
                        layer.closeAll();
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--编辑发票-->
        invoiceEdit: function (invoiceId) {
            this.invoiceData = this.initInvoiceData;//初始化数据
            this.invoiceForm =  this.initInvoiceData;//初始化数据
            if (!this.flag) {
                return;
            }
            $.ajax({
                url: '/m/account/invoice/eidt/grid_json',
                async: true,
                type: "GET",
                dataType: "json",
                data: {'invoiceId': invoiceId},
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        if(result.data.invoiceTypeCd == 1) {
                            result.data.companyTaxpayerIdentifyCode =  '';
                            result.data.companyRegisterAddr =  '';
                            result.data.companyRegisterTel =  '';
                            result.data.companyBankAccount =  '';
                            result.data.companyOpeningBankName =  '';
                            result.data.invoiceTitle =  '';
                            result.data.invoiceProvinceId =  -1;
                            result.data.invoiceCityId = -1;
                            result.data.invoiceCountyId = -1;
                        }
                        vm.invoiceData = result.data;
                        vm.invoiceForm.invoiceTypeCd = vm.invoiceData.invoiceTypeCd;//初始化类型
                        vm.invoiceForm.invoiceForCd = vm.invoiceData.invoiceForCd;//初始化抬头
                        /*if(vm.invoiceData.invoiceTypeCd == 1) {
                            vm.invoiceData.companyTaxpayerIdentifyCode =  '';
                            vm.invoiceData.companyRegisterAddr =  '';
                            vm.invoiceData.companyRegisterTel =  '';
                            vm.invoiceData.companyBankAccount =  '';
                            vm.invoiceData.companyOpeningBankName =  '';
                            vm.invoiceData.invoiceTitle =  '';
                            vm.invoiceData.invoiceProvinceId =  -1;
                            vm.invoiceData.invoiceCityId = -1;
                            vm.invoiceData.invoiceCountyId = -1;
                        }*/
                        vm.areaList(0, 0);//获取省下拉数据
                        addinvoice('编辑发票');
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });

        },
    <#--删除发票-->
        invoiceDel: function (invoiceId) {
            layer.confirm('确定要删除该发票吗?', {
                btn: ['确定', '取消'] //按钮
            }, function () {
                if (!vm.flag) {
                    return;
                }
                $.ajax({
                    url: '/m/account/invoice/delete',
                    async: true,
                    type: "POST",
                    dataType: "json",
                    data: {"invoiceId": invoiceId},
                    success: function (result) {
                        vm.flag = true;
                        if (result.result == 'success') {
                            vm.invoiceList();
                        } else {
                            layer.msg(result.message);
                        }
                        layer.closeAll();
                    },
                    error: function (XMLHttpResponse) {
                        vm.flag = true;
                        console.log("请求未成功");
                    }
                });
            }, function () {
                layer.closeAll();
            });
        },
    <#--获取区域数据：省、市、区-->
        areaList: function (id, type) {
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/common/area/findChildByParentId',
                async: true,
                type: "POST",
                dataType: "json",
                data: {"parentId": id},
                success: function (result) {
                    vm.flag = true;
                    if (result.rows && result.rows.length > 0) {
                        switch (type) {
                            case 0 :
                                vm.provinceList = result.rows;
                                vm.cityList = {};//清空市数据
                                vm.countyList = {};//清空镇数据
                                if (vm.addressData && vm.addressData.receiverProvinceId != -1) {//收货地址省是否有值
                                    vm.addressForm.receiverProvinceId = vm.addressData.receiverProvinceId;
                                }
                                if (vm.invoiceData && vm.invoiceData.invoiceProvinceId != -1) {//发票地址省是否有值
                                    vm.invoiceForm.invoiceProvinceId = vm.invoiceData.invoiceProvinceId;
                                }
                                break;
                            case 1 :
                                vm.cityList = result.rows;
                                vm.countyList = {};//清空镇数据
                                vm.invoiceForm.invoiceCityId = -1;//发票地址设置默认值
                                vm.addressForm.receiverCityId = -1;//收货地址设置默认值
                                if (vm.addressData && vm.addressData.receiverCityId != -1) {//收货地址市是否有值
                                    vm.addressForm.receiverCityId = vm.addressData.receiverCityId;
                                }
                                if (vm.invoiceData && vm.invoiceData.invoiceCityId != -1) {//发票地址市是否有值
                                    vm.invoiceForm.invoiceCityId = vm.invoiceData.invoiceCityId;
                                }
                                break;
                            case 2 :
                                vm.countyList = result.rows;
                                vm.invoiceForm.invoiceCountyId = -1;//发票地址设置默认值
                                vm.addressForm.receiverCountyId = -1;//收货地址设置默认值
                                if (vm.addressData && vm.addressData.receiverCountyId != -1) {//收货地址区是否有值
                                    vm.addressForm.receiverCountyId = vm.addressData.receiverCountyId;
                                }
                                if (vm.invoiceData && vm.invoiceData.invoiceCountyId != -1) {//发票地址区是否有值
                                vm.invoiceForm.invoiceCountyId = vm.invoiceData.invoiceCountyId;
                            }
                                break;
                        }
                        //vm.invoiceList();
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
    <#--地址提交表单验证-->
        addressFormTest: function () {
            if (!this.addressForm.receiverName) {
                layer.msg('请输入个人姓名!');
                return false;
            } else if (this.addressForm.receiverName.length > 50) {
                layer.msg('姓名长度不能超过50!');
                return false;
            }
            if (this.addressForm.receiverProvinceId == -1) {
                layer.msg('请选择省!');
                return false;
            }
            if (this.addressForm.receiverCityId == -1) {
                layer.msg('请选择市!');
                return false;
            }
            if (this.addressForm.receiverCountyId == -1) {
                layer.msg('请选择区!');
                return false;
            }
            if (!this.addressForm.receiverAddr) {
                layer.msg('请输入街道地址!');
                return false;
            } else if (this.addressForm.receiverAddr.length > 100) {
                layer.msg('街道长度不能超过100!');
                return false;
            }
            if (!this.addressForm.receiverTel) {
                layer.msg('请输入手机号码!');
                return false;
            } else if (this.addressForm.receiverTel.length != 11) {
                layer.msg('请输入正确的手机号码!');
                return false;
            }
            return true;
        },
    <#--发票提交表单验证-->
        invoiceFormTest: function () {
            if (vm.invoiceForm.invoiceForCd == 1 && vm.invoiceForm.companyName == "") {
                layer.msg('请输入个人姓名!');
                return false;
            } else if (vm.invoiceForm.invoiceForCd == 1 && vm.invoiceForm.companyName != "" && vm.invoiceForm.companyName.length > 100) {
                layer.msg('个人姓名长度不能超过100!');
                return false;
            }
            if (vm.invoiceForm.invoiceForCd == 2 && vm.invoiceForm.companyName == "") {
                layer.msg('请输入单位名!');
                return false;
            } else if (vm.invoiceForm.invoiceForCd == 2 && vm.invoiceForm.companyName != "" && vm.invoiceForm.companyName.length > 100) {
                layer.msg('单位名长度不能超过100!');
                return false;
            }
            if (vm.invoiceForm.invoiceTypeCd == 2) {
                if (!vm.invoiceForm.companyTaxpayerIdentifyCode || vm.invoiceForm.companyTaxpayerIdentifyCode.trim() == '') {
                    layer.msg('纳税人识别码不能为空！');
                    return false;
                } else if (vm.invoiceForm.companyTaxpayerIdentifyCode.length > 100) {
                    layer.msg('纳税人识别码长度不能超过100!');
                    return false;
                }

                if (!vm.invoiceForm.companyRegisterAddr || vm.invoiceForm.companyRegisterAddr.trim() == '') {
                    layer.msg('注册地址不能为空!');
                    return false;
                } else if (vm.invoiceForm.companyRegisterAddr.length > 255) {
                    layer.msg('注册地址长度不能超过255!');
                    return false;
                }

                if (!vm.invoiceForm.companyRegisterTel || vm.invoiceForm.companyRegisterTel.trim() == '') {
                    layer.msg('注册电话不能为空!');
                    return false;
                } else if (vm.invoiceForm.companyRegisterTel.length > 20) {
                    layer.msg('注册电话长度不能超过20!');
                    return false;
                }

                if (!vm.invoiceForm.companyBankAccount || vm.invoiceForm.companyBankAccount.trim() == '') {
                    layer.msg('银行账户不能为空!');
                    return false;
                } else if (vm.invoiceForm.companyBankAccount.length > 100) {
                    layer.msg('银行账户长度不能超过100!');
                    return false;
                }

                if (!vm.invoiceForm.companyOpeningBankName || vm.invoiceForm.companyOpeningBankName.trim() == '') {
                    layer.msg('开户行不能为空!');
                    return false;
                } else if (vm.invoiceForm.companyOpeningBankName.length > 50) {
                    layer.msg('开户行长度不能超过50!');
                    return false;
                }

                if (!vm.invoiceForm.invoiceTitle || vm.invoiceForm.invoiceTitle.trim() == '') {
                    layer.msg('发票抬头不能为空!');
                    return false;
                } else if (vm.invoiceForm.invoiceTitle.length > 100) {
                    layer.msg('发票抬头长度不能超过100!');
                    return false;
                }

                if (!vm.invoiceForm.invoiceProvinceId) {
                    layer.msg('请选择省');
                    return false;
                }

                if (!vm.invoiceForm.invoiceCityId) {
                    layer.msg('请选择市');
                    return false;
                }
            }
            return true;
        },
    <#--选择商品的支付方式-->
        setProductPriceInfo: function (i, e) {
            this.productPriceIndex.set(i, e.target.value);//改变存放价格的下标数组
        },
    <#--使用优惠码操作-->
        useCouponCode: function () {
            if (this.isUseCouponCode) {
                layer.msg('您已经使用过优惠码了！');
                return;
            }
            if (!this.couponCode) {
                layer.msg('请填写优惠码！');
                return;
            }
            var reg = /^\d{10,}$/
            if (!reg.test(this.couponCode.trim())) {
                layer.msg('优惠码有误！');
                return;
            }

            var _url = '/m/account/order/checkCouponCode?couponCode=' + this.couponCode.trim() + '&productIds=' + this.data.productIds + '&productAmt=' + this.productPriceAmt;
            if (!vm.flag) {
                return;
            }
            $.get(_url, function (data) {
                vm.flag = true;
                if (data.result == 'success') {
                    //将获取到的优惠券添加到原有的优惠券中
                    vm.data.couponList.push(data.data);
                    vm.form.couponCodeId = data.data.couponCodeId;
                    //setTimeout(function(){$("#couponSelect option:last-child").attr('selected','selected')},200);
                    vm.isUseCouponCode = true;
                } else {
                    layer.msg(data.message);
                }
            });
        },
    <#--计算优惠的金额-->
        countDiacount: function (needMomey, type, value) {
            switch (type) {
                case 1:
                    if (parseFloat(needMomey) < parseFloat(value)) {
                        return needMomey;
                    } else {
                        return value;
                    }
                case 2:
                    value = (parseFloat(needMomey) * (parseFloat(1) - parseFloat(value))).toFixed(2);
                    if (parseFloat(needMomey) < parseFloat(value)) {
                        return needMomey;
                    } else {
                        return value;
                    }
                case 4:
                    if (!this.isFreight) {
                        //layer.msg('只能使用一个包邮活动！');
                        return 0;
                    }
                    this.isFreight = false;
                    return 0;
            }
        },
    <#--订单提交表单时数据的验证-->
        testForm: function () {
            if (this.addrIndex != -1) {//选择地址
                if (this.form.addrId == -1) {
                    layer.msg('请选择收货地址！');
                    return false;
                }
                if (this.form.expressId == 0) {
                    layer.msg('请选择一种快递！');
                    return false;
                }
            } else {
                if (this.form.storeId == -1) {
                    layer.msg('请选择自提门店！');
                    return false;
                }
                if (!this.form.storeStartDateTime || !this.form.storeEndDateTime) {
                    layer.msg('请选择自提时间！');
                    return false;
                }
            }
            if (this.form.payWay == -1) {
                layer.msg('请选择一种支付方式！');
                return false;
            }
            if (this.realityPay < 0) {
                layer.msg('请重刷页面！');
                return false;
            }
            if (this.conditionOneIsUse == 1 && this.conditionOneIsRequired == 1 && this.form.invoiceId == -1) {
                layer.msg('请选择发票！');
                return false;
            }
            if (this.conditionTwoIsUse == 1 && this.conditionTwoIsRequired == 1 && this.form.expectSendTime == 0) {
                layer.msg('请选择配送时间！');
                return false;
            }

            return true;
        },
    <#--支付密码的验证-->
        pwdSubmit: function () {
            if (!this.payPassword) {
                layer.msg("请输入支付密码！");
                return;
            } else if (!new RegExp("^[0-9]{6}$").test(this.payPassword)) {
                layer.msg("格式不正确，请输入6位数字的支付密码！");
                return;
            }
            if (!this.flag) {
                return;
            }
            $.ajax({
                url: '${ctx}/account/order/testPayPwd',
                async: true,
                type: 'GET',
                dataType: 'json',
                data: {'payPassword': vm.payPassword},
                beforeSend: function () {
                    this.flag = false;
                },
                success: function (result) {
                    if (result.result == 'success') {
                        vm.flag = true;
                        vm.isPayPwd = true;
                        vm.pay(5);
                    } else {
                        layer.msg(result.message);
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log('请求未成功');
                }
            });
        },
    <#--订单支付-->
        pay: function (payType) {
            if (!payType) {
                layer.msg('请选择支付方式！')
            }
            if (payType != 5) {//记录不是余额支付的支付类型
                this.form.payWay = payType;
            } else if (this.form.payWay == -1 || this.form.payWay == 0) {//如果直接使用余额支付，则记录
                this.form.payWay = payType;
            }
            if (!this.isPayPwd) {
                paypassword();
                //this.showPayType = false;
                return;
            }
            if (!vm.flag) {
                return;
            }
            vm.flag = false;
            this.submitForm('/account/order/save', this.form);
        },
    <#--表单提交-->
        submitForm: function (action, data) {
            var div = $("<div style='display: none'><form id='_help-my-form'></form></div>");
            $("body").append(div);
            var helpForm = $("#_help-my-form");
            helpForm.attr("action", action);
            helpForm.attr("method", "post");
            $.each(data, function (key, value) {
                var inputObj = $("<input name='" + key + "' value='" + value + "'/>");
                helpForm.append(inputObj);
            });
            helpForm.submit();
        },
        $computed: {
        <#--初始化收货地址数据-->
            initAddressData: function () {
                return {
                    addrId: '',
                    receiverName: '',
                    receiverTel: '',
                    receiverProvinceId: -1,
                    receiverCityId: -1,
                    receiverCountyId: -1,
                    receiverAddr: ''
                }
            },
        <#--初始化发票数据-->
            initInvoiceData: function () {
                return {
                    invoiceId: '',
                    invoiceForCd: 1,
                    invoiceTypeCd: 1,
                    companyName: '',
                    companyTaxpayerIdentifyCode: '',
                    companyRegisterAddr: '',
                    companyRegisterTel: '',
                    companyBankAccount: '',
                    companyOpeningBankName: '',
                    invoiceTitle: '',
                    invoiceProvinceId: '',
                    invoiceCityId: '',
                    invoiceCountyId: ''
                }
            },
        <#--商品支付方式的处理-->
            productPriceTypeInfo: function () {
                var list = [];
                var str = '';
                if (!this.data.cartList) {
                    return list;
                }
                for (var i = 0; i < this.data.cartList.length; i++) {
                    var pIndex = this.productPriceIndex[i];
                    if (pIndex >= 0) {
                        list[i] = this.data.cartList[i].productPriceUserLevelXrefList[pIndex];
                    } else {
                        list[i] = {cash: this.data.cartList[i].firstAddedSalePrice, score: 0, type: 0};
                    }
                    list[i].quantity = this.data.cartList[i].quantity;

                    if (i == 0) {
                        str += list[i].type;
                    } else {
                        str += ',' + list[i].type;
                    }
                }
                this.form.productPriceType = str;
                return list;
            },
        <#--商品总金额-->
            productPriceAmt: function () {
                var productPriceAmt = 0;
                if (!this.productPriceTypeInfo) {
                    return 0;
                }
                for (var i = 0; i < this.productPriceTypeInfo.length; i++) {
                    productPriceAmt = parseFloat(productPriceAmt) + parseFloat(this.productPriceTypeInfo[i].cash) * parseFloat(this.productPriceTypeInfo[i].quantity);
                }
                return productPriceAmt.toFixed(2);
            },
        <#--总积分-->
            productScoreAmt: function () {
                var productScoreAmt = 0;
                if (!this.productPriceTypeInfo) {
                    return 0;
                }
                for (var i = 0; i < this.productPriceTypeInfo.length; i++) {
                    productScoreAmt = parseFloat(productScoreAmt) + parseFloat(this.productPriceTypeInfo[i].score) * parseFloat(this.productPriceTypeInfo[i].quantity);
                }
                return productScoreAmt.toFixed(2);
            },
        <#--使用的活动优惠金额-->
            usePromotionValue: function () {
                this.isFreight = true;
                if (this.form.promotionDiscountId != -1 && this.data.promotionList && this.data.promotionList.length) {
                    for (var i = 0; i < this.data.promotionList.length; i++) {
                        if (this.data.promotionList[i].id == this.form.promotionDiscountId) {
                            this.form.promotionId = this.data.promotionList[i].promotionId;
                            return this.countDiacount(this.productPriceAmt, this.data.promotionList[i].discountTypeCd, this.data.promotionList[i].discountValue);
                        }
                    }
                }
                return 0;
            },
        <#--使用的优惠券优惠金额-->
            useCouponValue: function () {
                if (this.form.couponCodeId != -1 && this.data.couponList && this.data.couponList.length) {
                    for (var i = 0; i < this.data.couponList.length; i++) {
                        if (this.data.couponList[i].couponCodeId == this.form.couponCodeId) {
                            this.form.couponDiscountId = this.data.couponList[i].id;
                            var needMoney = (parseFloat(this.productPriceAmt) - parseFloat(this.usePromotionValue)).toFixed(2);
                            return this.countDiacount(needMoney, this.data.couponList[i].discountTypeCd, this.data.couponList[i].discountValue);
                        }
                    }
                }
                return 0;
            },
        <#--使用的红包优惠金额-->
            useRedpackValue: function () {
                if (this.form.redPacketCodeId != -1 && this.data.redPacketList && this.data.redPacketList.length > 0) {
                    for (var i = 0; i < this.data.redPacketList.length; i++) {
                        if (this.data.redPacketList[i].couponCodeId == this.form.redPacketCodeId) {
                            return this.data.redPacketList[i].couponCodeValue;
                        }
                    }
                }
                return 0;
            },
        <#--总优惠金额-->
            discountAmt: function () {
                return (parseFloat(this.usePromotionValue) + parseFloat(this.useCouponValue) + parseFloat(this.useRedpackValue)).toFixed(2);
            },
        <#--运费-->
            expressAmt: function () {
                if (!this.isFreight) {
                    return 0;
                }//包邮
                if (!this.data.expressList) {
                    return 0;
                }
                if (this.form.expressId == 0) {
                    return 0;
                }
                for (var i = 0; i < this.data.expressList.length; i++) {
                    if (this.data.expressList[i].expressId == this.form.expressId) {
                        return this.data.expressList[i].orderExpressAmt;
                    }
                }
                return 0;
            },
        <#--实际支付金额-->
            realityPay: function () {
                var realityPay = 0;
                realityPay = (parseFloat(this.productPriceAmt) - parseFloat(this.discountAmt)).toFixed(2);
                if (parseFloat(realityPay) < 0) {
                    realityPay = 0;
                }
                realityPay = parseFloat((parseFloat(realityPay) + parseFloat(this.expressAmt)).toFixed(2));//运费单独算
                this.form.payAmt = realityPay;
                return realityPay;
            },
        <#--使用的余额-->
            userBlanceValue: function () {
                var userBlanceValue = 0;
                if (!this.switchStatus || !this.data.userBlance) {
                    this.showPayType = true;
                    this.isPayPwd = true;//没有选择余额抵扣或者没有余额，就不显示支付密码弹出框
                    this.form.userBlanceValue = 0;
                    return 0;
                }
                if (this.data.userBlance < this.realityPay) {//如果余额小于支付的金额
                    this.showPayType = true;
                    this.form.userBlanceValue = this.data.userBlance;
                    return this.data.userBlance;
                } else {
                    this.showPayType = false;
                    this.form.userBlanceValue = this.realityPay;
                    return this.realityPay;
                }
            }
        }
    });
    vm.$watch('onReady', function () {
    <#--加载数据-->
        if (!vm.flag) {
            return;
        }
        $.ajax({
            url: '/account/order/submitOrder/grid_json',
            async: true,
            type: "GET",
            dataType: "json",
            success: function (result) {
                vm.flag = true;
                if (result.result == 'success') {
                    vm.data = result;
                <#--初始化商品价格数组的数据-->
                    for (var i = 0; i < result.cartList.length; i++) {
                        if (result.cartList[i].productPriceUserLevelXrefList) {
                            vm.productPriceIndex.push(0);
                        } else {
                            vm.productPriceIndex.push(-1);
                        }
                    }
                <#--初始化地址Id-->
                    if (result.addressList && result.addressList.length > 0) {
                        vm.form.addrId = result.addressList[0].addrId;
                        vm.addrSelect(0, result.addressList[0].addrId)
                    }
                <#--初始化地址-->
                    vm.selectAddressData = vm.data.addressList[0];
                <#--初始化选择的配送方式-->
                    if(getCookie('order_express_id')) {
                        vm.form.expressId = getCookie('order_express_id');
                    }
                <#--初始化发票Id-->
                    if (result.invoice) {
                        vm.form.invoiceId = result.invoice.invoiceId;
                    }
                <#--初始化是否为搭配套餐-->
                    if (result.combinationId && result.combinationNum) {
                        vm.form.combinationId = result.combinationId;
                        vm.form.combinationNum = result.combinationNum;
                    }
                <#--下单的配置-->
                    if (result.conditionOneIsUse) {//发票配置
                        vm.conditionOneIsUse = result.conditionOneIsUse;
                    }
                    if (result.conditionOneIsRequired) {
                        vm.conditionOneIsRequired = result.conditionOneIsRequired;
                    }
                    if (result.conditionTwoIsUse) {//配送时间设置（选择收货地址时用到）
                        vm.conditionTwoIsUse = result.conditionTwoIsUse;
                    }
                    if (result.conditionTwoIsRequired) {
                        vm.conditionTwoIsRequired = result.conditionTwoIsRequired;
                    }
                } else {
                    if (!getCookie('orderId')) {
                        layer.open({
                            content: '无购买数据，请重新下单！',
                            yes: function (index, layero) {
                                layer.close(index); //如果设定了yes回调，需进行手工关闭
                                window.location.href = '/products/0.html';
                            }
                        });
                        return;
                    }
                }
            },
            error: function (XMLHttpResponse) {
                vm.flag = true;
                console.log("请求未成功");
            }
        });

    });
    <#--监听所选的发票地址省-->
    vm.$watch('invoiceForm.invoiceProvinceId', function (v) {
        if(v) {
            vm.areaList(v, 1);
        }
    })
    <#--监听所选的发票地址市-->
    vm.$watch('invoiceForm.invoiceCityId', function (v) {
        if(v) {
            vm.areaList(v, 2);
        }
    })
    <#--监听所选的收货地址省-->
    vm.$watch('addressForm.receiverProvinceId', function (v) {
        if(v) {
            vm.areaList(v, 1);
        }
    })
    <#--监听所选的收货地址省-->
    vm.$watch('addressForm.receiverCityId', function (v) {
        if(v) {
            vm.areaList(v, 2);
        }
    })
    <#--监听所选的收货地址Id-->
    vm.$watch('form.addrId', function (v) {
        if (v == -1 || !vm.selectAddressData.receiverCityId || !this.flag) {
            return;
        }
        $.ajax({
            url: '${ctx}/account/order/getExpressList',
            async: true,
            type: 'GET',
            dataType: 'json',
            data: {'cityId': vm.selectAddressData.receiverCityId, 'weight': vm.data.totalWeight},
            beforeSend: function () {
                this.flag = false;
            },
            success: function (result) {
                if (result.result == 'success') {
                    vm.data.expressList = result.data.orderExpressList;
                }
            },
            error: function (XMLHttpResponse) {
                vm.flag = true;
                console.log('请求未成功');
            }
        })
    })
    <#--监听所选的门店Id-->
    vm.$watch('form.storeId ', function (v) {
        if (vm.form.storeId != -1 && vm.data.storeList && vm.data.storeList.length > 0) {
            vm.addrIndex = -1;
            for (var i = 0; i < vm.data.storeList.length; i++) {
                if (vm.form.storeId == vm.data.storeList[i].storeId) {
                    vm.store = vm.data.storeList[i];
                }
            }
        }
    })
    <#--监听门店送货时间-->
    vm.$watch('stotrDataTime', function (v) {
        if (!v || v == -1) {
            return;
        }
        var vArr = v.split('-');
        vm.storeStartTime = vArr[0];
        vm.storeEndTime = vArr[1];
        vm.storeDateTime();
    })
    <#--监听门店送货日期-->
    vm.$watch('storeDate', function (v) {
        if (!v || v == -1) {
            return;
        }
        vm.storeDateTime();
    })
    <#--监听是否使用余额-->
    /*vm.$watch('switchStatus', function (v) {
        if (!v) {
            vm.isPayPwd = true;//用户判断是否需要弹出支付密码，没使用余额抵扣，则不弹框
        } else {
            vm.isPayPwd = false;
        }
    })*/
    <#--监听是否选择了快递-->
    vm.$watch('form.expressId', function (v) {
        if (v != -1) {
            setCookie('order_express_id', v);//cookie中保存选择的快递
        }
    })
    <#--监听是否选择了活动-->
    vm.$watch('form.promotionDiscountId', function (v) {
        //console.log(v)
    })
    <#--监听是否选择了优惠券-->
    vm.$watch('form.couponCodeId', function (v) {
        //console.log(v)
    })

    $(function () {
        if (getCookie('orderId')) {
            window.location.href = "${ctx}/account/order/toDetail?orderId=" + getCookie('orderId');
        }
        $(".topshopcart").hover(getCartContent, removeCartContent);

        //地址下拉
        var propsbox = $(".step-addr"), openheight,
                closeheight = propsbox.find("li").eq(0).outerHeight(true);
        propsbox.height(closeheight).addClass("toggled");
        $(".addr-switch").on("click", function () {
            if (propsbox.hasClass("toggled")) {
                $(".addr-switch").removeClass("switch-on");
                $(".addr-switch").find("span").html("收起地址");
                openheight = propsbox[0].scrollHeight;
                propsbox.animate({
                    height: openheight
                }, function () {
                    propsbox.removeClass("toggled");
                });

            } else {
                $(".addr-switch").addClass("switch-on");
                $(".addr-switch").find("span").html("更多地址");
                propsbox.animate({
                    height: closeheight
                }, function () {
                    propsbox.addClass("toggled");
                });
            }
        });

        //门店下拉
        var sincebox = $(".step-since"), sinceopenheight,
                sincecloseheight = sincebox.find("li").eq(0).outerHeight(true);
        sincebox.height(sincecloseheight).addClass("toggled");
        $(document).on("click", ".since-switch", function () {
            if (sincebox.hasClass("toggled")) {
                $(".since-switch").removeClass("since-switch-on");
                $(".since-switch").find("span").html("收起");
                sinceopenheight = sincebox[0].scrollHeight;
                sincebox.animate({
                    height: sinceopenheight
                }, function () {
                    sincebox.removeClass("toggled");
                });

            } else {
                $(".since-switch").addClass("since-switch-on");
                $(".since-switch").find("span").html("更多");
                sincebox.animate({
                    height: sincecloseheight
                }, function () {
                    sincebox.addClass("toggled");
                });
            }
        });

    <#--点击提交订单-->
        $("#btnBuy").on("click", function () {
            vm.form.payWay = 0;//初始化支付类型
            if (!vm.testForm()) {
                return;
            }
            if (vm.showPayType) {
                payment();
            } else {
                paypassword();
            }
        })

        initInvoiceTitleChangeEvent();
    })

    //购物车
    function getCartContent() {
        $(".topshopcart").addClass("cart-hover");
    }
    function removeCartContent() {
        $(".topshopcart").removeClass("cart-hover");
    }

    var newAddress;
    function newaddress(title) {
        newAddress = layer.open({
            type: 1,
            title: title,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['720px'],
            content: $("#newddress")
        });
    }

    function payment() {
        layer.open({
            type: 1,
            title: '选择支付方式',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px'],
            content: $("#payment")
        });
    }

    var payPassword;
    function paypassword() {
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px', '200px'],
            content: $("#payPassword")
        });
    }

    //发票弹窗
    var addInvoice;
    function addinvoice(title) {
        addInvoice = layer.open({
            type: 1,
            title: title,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['660px', '400px'],
            content: $("#addinvoice")
        });
    }
    //发票
    function initInvoiceTitleChangeEvent() {
        $("input[type='radio'][name='invoiceTitle']").change(function () {
            $('#companyName').val('');
            if ($(this).val() == "2") {
                $('#personalOrCompanyDiv').html('<i class="text-red">*</i>单位名称');
                $(".personalOrCompanyprompt").attr('placeholder', '请输入单位名称');
            } else {
                $('#personalOrCompanyDiv').html('<i class="text-red">*</i>个人姓名');
                $(".personalOrCompanyprompt").attr('placeholder', '请输入个人姓名');
            }
        });
    }
    //设置Cookie
    function setCookie(name, value) {
        document.cookie = name + '=' + encodeURIComponent(value) + ';path=/';
    }

    //获取cookie
    function getCookie(name) {
        var arr = document.cookie.split('; ');
        var i = 0;
        for (i = 0; i < arr.length; i++) {
            var arr2 = arr[i].split('=');

            if (arr2[0] == name) {
                var getC = decodeURIComponent(arr2[1]);
                return getC;
            }
        }

        return '';
    }
</script>