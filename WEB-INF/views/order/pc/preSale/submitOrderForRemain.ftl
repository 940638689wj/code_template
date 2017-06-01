<!doctype html>
<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<html>
<head>
    <title>尾款支付</title>
    <style>
        .ms-controller {
            visibility: hidden
        }
    </style>
</head>
<body>
<div :controller="app" class="ms-controller">
    <div id="main">
        <div class="checkout">
            <div class="checkout-tit">填写并核对订单信息</div>
            <div class="checkout-steps">
                <div class="step-tit">
                    <h3>收货人信息</h3>
                    <span class="extra-r flr" ms-if="@isExistAddr==false"><a href="javascript:void(0);" class="link" id="newaddressBtn" ms-click="@newaddress">新增地址</a></span>
                </div>
                    <div class="step-addr-wrap">
                    <div class="step-addr">
                        <ul>
                            <li ms-if="@isExistAddr== true">
                                <div >{{receiveName}}
                                    <b></b>
                                    <span class="addr-name">{{receiveName}}</span>
                                    <span class="addr-info">{{combAddr}}</span>
                                    <span class="addr-tel">{{receivePhone}}</span>
                                </div>
                                <div class="addr-detail"></div>
                            </li>

                            <li ms-if="@isExistAddr == false" ms-for="($index,addr) in @addrList"
	                            ms-class="$index == @addrClass && 'step-addr-selected'" ms-mouseenter="@addrClass = $index"
	                            ms-mouseleave="@addrClass = -1">
                                <div ms-class="['addr-item',$index == @addrIndex && 'item-selected']"
                                 	 ms-click="@addrSelect($index,addr.addrId)">{{addr.receiverName}}
                                    <b></b>
                                </div>
                                <div class="addr-detail">
                                    <span class="addr-name">{{addr.receiverName}}</span>
                                    <span class="addr-info">{{addr.receiverProvinceName}}{{addr.receiverCityName}}{{addr.countyName}}{{addr.receiverAddr}}</span>
                                    <span class="addr-tel">{{addr.receiverTel}}</span>
                                    <span class="addr-default" ms-visible="addr.isDefaultAddr == 1">默认地址</span>
                                </div>
                                <div class="op-btns">
                                    <a ms-click="@addrSetDefault(addr.addrId)">设为默认地址</a>
	                                <a ms-click="@addrEdit(addr.addrId)">编辑</a>
	                                <a ms-click="@addrDel(addr.addrId)">删除</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                    <div class="addr-switch" ms-if="@isExistAddr == false">
                        <span>更多地址</span><b></b>
                    </div>
                </div>
           
                <div class="step-wrap">
                    <div class="step-tit">
                        <h3>商品信息</h3>
                    </div>
                    <div class="shoptb">
                        <div class="shoptb-hd">
                            <table>
                                <tbody>
                                <tr>
                                    <td class="td-product">商品</td>
                                    <td>单价</td>
                                    <td class="td-amount">数量</td>
                                    <td class="td-total">尾款小计</td>
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
                                            <div class="img"><a :attr="{href: '/product/' + orderDetail.masterProductId}"><img :attr="{src:orderDetail.productPicUrl}"></a></div>
                                            <div class="info">
                                                <div class="name"><a :attr="{href: '/product/' + orderDetail.masterProductId}" target="_blank"  ms-text="orderDetail.productName"></a></div>
                                                <div class="prop" :if="orderDetail.skuDesc !=null && orderDetail.skuDesc != ''"><span ms-text="orderDetail.skuDesc"></span></div>
                                                
                                            </div>
                                        </div>
                                    </td>
                                    <td ms-text="orderDetail.salePrice">
                                        
                                    </td>
                                    <td class="td-amount" ms-text="orderDetail.quantity"></td>
                                    <td class="td-total"><em>￥</em><em ms-text="orderDetail.orderTotalAmt"></em></td>
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
                        <div class="bd" ms-if="@isExistAddr==true">
                            <select ms-duplex="@form.expressId" disabled="disabled">
                                <option>
                                    {{expressName}}
                                </option>
                            </select>
                        </div>
                        <div class="bd" ms-if="@isExistAddr==false">
                            <select ms-duplex="@form.expressId">
                                <option value="-1">请选择</option>
                                <option ms-for="express in @expressList" ms-attr="{value:express.expressId}">
                                    {{express.expressName}}￥{{express.orderExpressAmt}}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
                
            </div>
        </div>
        <div class="trade-foot">
        	<div class="order-extra">
	                <div class="formList order-extra">
	                    <div class="item">
	                        <div class="hd">余额支付</div>
	                        <div class="bd">
	                            <input id="balancePay" type="checkbox" name="integral"><span class="infotext">当前余额￥<span id="userBalance">{{userBalance}}</span>，是否使用</span>
	                        </div>
	                    </div>
	                </div>
	            </div>
            <div class="trade-foot-detail">
                <div class="fc-price-info">
                    <span class="price-tit">应付尾款：</span>
                    <span>￥</span><span ms-text="orderPayAmt"></span>
                </div>
                <div class="fc-price-info">
                    <span class="price-tit">快递费用：</span>
                    <span ms-if="@isExistAddr==true">￥{{orderExpressAmt}}</span>
                    <span ms-if="@isExistAddr==false">￥{{@expressAmt}}</span>
                </div>
                <div class="fc-price-info">
                    <span class="price-tit">应付总额：</span>
                    <span class="price-num">￥</span><span class="price-num">{{@form.payAmt}}</span>
                </div>
                 <div class="fc-price-info" ms-if="@isExistAddr == false" ms-visible="@form.addrId != -1">
	                <span class="mr20">寄送至： {{@selectAddressData.receiverProvinceName + ' '+ @selectAddressData.receiverCityName + ' ' + @selectAddressData.countyName + ' ' + @selectAddressData.receiverAddr}}</span>
	                <span>收货人：{{@selectAddressData.receiverName + ' ' + @selectAddressData.receiverTel}} </span>
            	</div>
                <div class="fc-price-info" ms-if="@isExistAddr == true" ms-visible="@form.addrId != -1">
                    <span class="mr20">寄送至：{{combAddr}}</span>
                    <span>收货人：{{receiveName + ' ' + receivePhone}} </span>
                </div>
            </div>
            <div class="inner">
                <button id="btnBuy">立即支付</button>
            </div>
        </div>
    </div>
	<input type="hidden" id="orderId" value="${orderId!}">
	
    <div id="payment" class="hidden">
        <div class="paytypes">
            <ul>
            	<li ms-for="($key,$val) in @payTypeList">
                    <a href="javascript:;" ms-if="$key == 'config_alipay_pc'" ms-click="alipay()">支付宝支付</a>
                    <a href="javascript:;" ms-if="$key == 'config_unionpay_pc'" ms-click="unionpay()">银联支付</a>
                    <a href="javascript:;" ms-if="$key == 'weixin_pay_config'" ms-click="wxpay()">微信支付</a>
                </li>
                <!--<li id="balancePayment"><a href="javascript:void(0);">余额支付</a></li>-->
                <!--<li><a href="#" :click="alipay()">支付宝支付</a></li>-->
                <!--<li><a href="#">银联支付</a></li>-->
            </ul>
        </div>
    </div>
    <div id="payPassword"  class="hidden">
        <div class="formList paypassword">
            <div class="item">
                <div class="hd">输入支付密码：</div>
                <div class="bd">
                    <input type="password" class="textfield">
                </div>
            </div>
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <a class="v-btn" href="#">确定</a>
                </div>
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
                        <a href="#" class="btn-action" ms-click="@submitAddress">新增</a>
                    </div>
                </li>
            </ul>
        </div>
    </div>

    <div id="addinvoice" class="hidden">
        <div class="formList">
            <div class="item">
                <div class="hd">发票类型</div>
                <div class="bd">
                    <ul class="invoice-tab">
                        <li class="selected" data-name="normal_pager">普通发票</li>
                        <li data-name="vat" class="">增值税发票</li>
                    </ul>
                </div>
            </div>
        </div>
        <div class="formList">
            <div class="item">
                <div class="hd">发票抬头</div>
                <div class="bd">
                    <div class="whether">
                        <p id="invoiceTitlePersonalLabel"><label><input type="radio" id="invoiceTitlePersonal" name="invoiceTitle" value="personal" checked="">个人</label></p>
                        <p><label><input type="radio" id="invoiceTitleCompany" name="invoiceTitle" value="company">单位</label></p>
                    </div>
                </div>
            </div>
        </div>
        <div class="formList" id="personalDiv">
            <div class="item">
                <div class="hd" id="personalOrCompanyDiv"><i class="text-red">*</i>个人姓名</div>
                <div class="bd">
                    <div class="bd"><input type="text" placeholder="请输入个人姓名" class="textfield personalOrCompanyprompt w300"></div>
                </div>
            </div>
        </div>
        <div class="formList" id="vatInvoiceDiv" style="display: none;">
            <div class="item">
                <div class="hd"><i class="text-red">*</i>单位名称</div>
                <div class="bd">
                    <div class="bd"><input type="text" placeholder="请输入单位名称" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>纳税人识别码</div>
                <div class="bd">
                    <div class="bd"><input type="text" placeholder="请输入纳税人识别码" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>注册地址</div>
                <div class="bd">
                    <div class="bd"><input type="text" placeholder="请输入注册地址" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>注册电话</div>
                <div class="bd">
                    <div class="bd"><input type="number" placeholder="请输入注册电话" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>银行帐户</div>
                <div class="bd">
                    <div class="bd"><input type="number" placeholder="请输入银行帐户" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>开户行</div>
                <div class="bd">
                    <div class="bd"><input type="text" placeholder="请输入开户行" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>发票抬头</div>
                <div class="bd">
                    <div class="bd"><input type="text" placeholder="请输入发票抬头" class="textfield w300"></div>
                </div>
            </div>
            <div class="item">
                <div class="hd"><i class="text-red">*</i>发票配送地址</div>
                <div class="bd">
                    <div class="invoice-ws">
                        <select class="invoice-select">
                            <option>请选择</option>
                            <option>福建省</option>
                        </select>
                        <select class="invoice-select">
                            <option>请选择</option>
                            <option>厦门市</option>
                        </select>
                        <select class="invoice-select">
                            <option>请选择</option>
                            <option>思明区</option>
                        </select>
                        <a class="text-orange" href="javascript:void(0);">默认收货地址</a>
                    </div>
                    <textarea placeholder="街道地址" class="textarea w300"></textarea>
                </div>
            </div>
        </div>
        <div class="formList">
            <div class="item">
                <div class="hd"></div>
                <div class="bd">
                    <div class="bd"><a class="btn-action" href="javascript:void(0);">保存发票信息</a></div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/static/mobile/js/sha1.js"></script>   
<script>
	var vm = avalon.define({
        $id: 'app',
        flag: true,
        addrIndex: 0,  //地址下标
        addrClass: -1,  //地址的类
        provinceList: {},//省集合
        cityList: {},//市集合
        countyList: {},//区集合
        expressList:[],
        <#--支付方式-->
        payTypeList:[],
        form: {
        <#--地址Id-->
            addrId: -1,
        <#--快递Id-->
            expressId: -1,
        <#--支付金额-->
            payAmt: 0,
        <#--买家留言-->
            orderRemark: '',
        <#--支付类型-->
            payWay: -1,
        <#--使用的余额-->
            userBlanceValue: 0,
        },
        nowAddrId:'',
        <#--应付尾款-->
        orderPayAmt:'0',
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
        <#--选择的收货地址数据-->
        selectAddressData: {},
        isExistAddr:false,
        combAddr:'',
        receiveName:'',
        receivePhone:'',
        orderExpressAmt:0,
        <#--初始化收货地址数据-->
        initAddressData: {
            addrId: '',
            receiverName: '',
            receiverTel: '',
            receiverProvinceId: -1,
            receiverCityId: -1,
            receiverCountyId: -1,
            receiverAddr: ''
        },
        <#--编辑时的收货地址数据-->
        addressData: this.initAddressData,
        expressAmt:'0',
        realPayAmt:'',
        expressName:'',
    	<#--订单商品详情-->
        orderDetail:'',
        totalWeight:0,
        <#--是否在支付期-->
        isInTime:true,
        userBalance:'',
        addrList:[],
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
                        vm.addrList = result.data;
                        <#--初始化地址-->
				        if(result.data && result.data.length > 0) {
				            vm.form.addrId = result.data[0].addrId;
				            vm.addrSelect(0,result.data[0].addrId);
				        }
				        
                    }
                },
                error: function (XMLHttpResponse) {
                    vm.flag = true;
                    console.log("请求未成功");
                }
            });
        },
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
                data: {"addrId": addrId, "productIds": vm.orderDetail.masterProductId},
                success: function (result) {
                    vm.flag = true;
                    if (result.result == 'success') {
                        vm.selectAddressData = vm.addrList[index];
                        vm.addrIndex = index;
                        vm.form.addrId = addrId;
                        //vm.form.storeId = -1;
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
        <#--弹出新增地址弹出框操作-->
        newaddress: function () {
            this.areaList(0, 0);//初始化省
            this.addressData = this.initAddressData;//恢复初始数据
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
                        layer.msg('新地址添加成功!');
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
            this.areaList(0, 0);
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
                        vm.addressForm.receiverProvinceId = result.data.receiverProvinceId;
                        vm.addressForm.receiverCityId = result.data.receiverCityId;
                        vm.addressForm.receiverCountyId = result.data.receiverCountyId;
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
        <#--获取区域数据：省、市、区-->
        areaList: function (id, type) {
            if (!vm.flag) {
                return;
            }
            $.ajax({
                url: '/admin/sa/common/area/findChildByParentId',
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
                                break;
                            case 1 :
                                vm.cityList = result.rows;
                                vm.countyList = {};//清空镇数据
                                //vm.invoiceForm.invoiceCityId = -1;//发票地址设置默认值
                                vm.addressForm.receiverCityId = -1;//收货地址设置默认值
                                break;
                            case 2 :
                                vm.countyList = result.rows;
                                //vm.invoiceForm.invoiceCountyId = -1;//发票地址设置默认值
                                vm.addressForm.receiverCountyId = -1;//收货地址设置默认值
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
    	<#--运费-->
        getExpressAmt: function () {
            if(!this.expressList) { return 0; }
            if(this.form.expressId == -1) { return 0; }
            for(var i = 0; i < this.expressList.length; i++) {
                if(this.expressList[i].expressId == this.form.expressId) {
                    vm.expressAmt= this.expressList[i].orderExpressAmt;
                }
            }
            vm.realityPay();
        },
        <#--实际支付金额-->
	    realityPay: function () {
	            var realityPay = 0;
	            realityPay = (parseFloat(this.orderPayAmt) + parseFloat(this.expressAmt)).toFixed(2);
	            if (realityPay < 0) {
	                realityPay = 0;
	            }
	            this.form.payAmt = realityPay;
	            vm.realPayAmt = realityPay;
	        },
        <#--支付宝支付-->
        alipay: function(){
	        	var balancePay = $("#balancePay").is(':checked');
	            var userBalance = vm.userBalance;
	        	if(balancePay && (eval(userBalance)>0)){//判断是否余额参与支付
	        		vm.toPay("alipay_balance");
	        	}else{
	        		vm.toPay("alipay");
	        	}
        	
        },
        unionpay: function(){
        	var balancePay = $("#balancePay").is(':checked');
	            var userBalance = vm.userBalance;
	        	if(balancePay && (eval(userBalance)>0)){//判断是否余额参与支付
	        		vm.toPay("unionpay_balance");
	        	}else{
	        		vm.toPay("unionpay");
	        	}
        },
        wxpay: function(){
        	var balancePay = $("#balancePay").is(':checked');
	            var userBalance = vm.userBalance;
	        	if(balancePay && (eval(userBalance)>0)){//判断是否余额参与支付
	        		vm.toPay("wechatpay_balance");
	        	}else{
	        		vm.toPay("wechatpay");
	        	}
        },
        toPay: function(payWay){
        		var orderId = vm.orderDetail.orderId;
	        	$.ajax({
				url:'${ctx}/account/preSaleOrder/dealPreSaleOrder',
				type:'post',
				data:{
					"orderId":orderId,
					"payWay":payWay,
					"addrId":vm.form.addrId,
					"expressId":vm.form.expressId,
				},
				dataType:'json',
				success:function(data){
					if(data.result=='success'){
						if (payWay == 'balancePay') {
	                        layer.alert('支付成功！', function () {
	                            window.location.href='/account/preSaleOrder/toPreSaleOrderList';
	                        });
	                    } else {
	                        window.location.href = '/account/order/goToOrderPayment?payWay=' + data.data.payWay + '&orderNumber=' + data.data.orderNumber;
	                    }
					}else{
						layer.alert(data.message);
					}
				},
				error:function(){
					layer.alert('网络出错，请稍后再试！');
				}
			});
        }
        
        
    });
        
    vm.$watch('onReady',function(){
    	var orderId = $("#orderId").val();
			$.ajax({
					url : '${ctx}/account/preSaleOrder/payForRemain_Json?orderId='+orderId,
					type : 'get',
					success : function(data){
						if(data!=null){
							vm.orderDetail=data.orderDetail;
							vm.userBalance=data.userBalance;
                            if(data.expressName!=null){
                                vm.expressName =data.expressName;
                            }
							if(eval(data.userBalance)<=0){
								$("#balancePay").attr("disabled","true");
							}
							vm.orderExpressAmt=data.orderDetail.orderExpressAmt;
							vm.form.payAmt=data.orderDetail.orderPayAmt;
							vm.orderPayAmt = eval(data.orderDetail.orderPayAmt) - eval(data.orderDetail.orderExpressAmt);
							vm.isInTime=data.isInTime;
							if(data.totalWeight!=null){
								vm.totalWeight = data.totalWeight;
							}
							vm.selectAddressData = data.addrList[0];
                            if(data.combAddr!=null && data.combAddr!=''){
                                vm.isExistAddr = data.isExistAddr;
                                vm.combAddr = data.combAddr;
                                vm.receiveName = data.receiveName;
                                vm.receivePhone = data.receivePhone;
                            }else{
                                vm.addressList();
                            }
							vm.payTypeList=data.onlinePayTypeList;
							if(data.payPassword !=null && data.payPassword!=''){
								vm.hasPwd=data.payPassword;
							}
							
						}
					}
			});
    	
    });
    vm.$watch('form.expressId',function(v){
    	vm.getExpressAmt();
    })
	<#--监听所选的收货地址省-->
    vm.$watch('addressForm.receiverProvinceId', function (v) {
        vm.areaList(v, 1);
    })
    <#--监听所选的收货地址省-->
    vm.$watch('addressForm.receiverCityId', function (v) {
        vm.areaList(v, 2);
    })
    <#--监听所选的收货地址Id-->
    vm.$watch('form.addrId', function (v) {
        if (v == -1) {
            return;
        }
        if (!this.flag) {
            return;
        }
        $.ajax({
            url: '${ctx}/account/order/getExpressList',
            async: true,
            type: 'GET',
            dataType: 'json',
            data: {'cityId': vm.selectAddressData.receiverCityId, 'weight': vm.totalWeight},
            beforeSend: function () {
                this.flag = false;
            },
            success: function (result) {
                if (result.result == 'success') {
                    vm.expressList = result.data.orderExpressList;
                }
            },
            error: function (XMLHttpResponse) {
                vm.flag = true;
                console.log('请求未成功');
            }
        })
    })
    $(function(){
        $(".topshopcart").hover(getCartContent, removeCartContent);
        //地址
        $(".step-addr li").on("mouseenter",function () {
            $(this).addClass("step-addr-selected");
        }).on("mouseleave",function () {
            $(this).removeClass("step-addr-selected");
        })

        $(".step-addr .addr-item").on("click",function(){
            var obj = $(this);
            $(".step-addr .addr-item").removeClass("item-selected");
            obj.addClass("item-selected");
            $(".since-item").removeClass("item-selected");
            $(".since-selected input[type='radio']").removeAttr("checked");
        })


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
        var sincebox = $(".step-since"),sinceopenheight,
            sincecloseheight = sincebox.find("li").eq(0).outerHeight(true);
            sincebox.height(sincecloseheight).addClass("toggled");
        $(".since-switch").on("click",function(){
            if(sincebox.hasClass("toggled")){
                $(".since-switch").removeClass("since-switch-on");
                $(".since-switch").find("span").html("收起");
                sinceopenheight = sincebox[0].scrollHeight;
                sincebox.animate({
                    height : sinceopenheight
                }, function() {
                    sincebox.removeClass("toggled");
                });

            }else{
                $(".addr-switch").addClass("since-switch-on");
                $(".addr-switch").find("span").html("更多");
                sincebox.animate({
                    height : sincecloseheight
                }, function() {
                    sincebox.addClass("toggled");
                });
            }
        });

        $(".since-item").on("click",function(){
            $(this).addClass("item-selected");
            $(".step-addr .addr-item").removeClass("item-selected");
        })


        <#--$("#newaddressBtn").on("click",function(){
            newaddress();
        })-->

        $("#btnBuy").on("click",function(){
           if(!vm.isInTime){
           		layer.alert("不在尾款期内!");
           		return false;
           }
           if(!vm.isExistAddr){
               if(vm.form.addrId ==-1){
                   layer.alert("地址不能为空!");
                   return false;
               }
               if(vm.form.expressId ==-1){
                   layer.alert("请选择配送方式!");
                   return false;
               }
           }
           if(vm.form.payAmt==0){
           		layer.alert("支付异常，请刷新当前页面!");
           		return false;
           }
           var balancePay = $("#balancePay").is(':checked');
        	if(balancePay){
        		var userbalance = vm.userBalance;
        		var nowPayAmt = vm.form.payAmt;
        		if(!vm.hasPwd){
        			layer.confirm('请先设置支付密码',function(){
                        setPayPwd();
                    });
        		}else{
        			paypassword();
        		}
	            
        	}else{
        		payment();
        	}
        });
        
        //校验密码
	    $('#payPassword .v-btn').click(function () {
	        layer.close(payPassword);
	        var reg = /^\d{6}$/;
	        var payPwd = $("#payPassword input").val();
	        if (reg.test(payPwd)) {
	            //SHA1加密
	            var payPwd = CryptoJS.SHA1(payPwd).toString();
	            //执行其他操作
	            $.post('/account/preSaleOrder/check_PayPwd', {payPwd: payPwd}, function (data) {
	                if (data.result == 'success') {
	                	if(eval(vm.userBalance)<eval(vm.form.payAmt)){
	                		layer.msg("当前余额不足,请选择其他支付方式!");
	        				setTimeout("payment()",500);
	                	}else{
	                		vm.toPay("balancePay");
	                	}
	                } else {
	                    layer.msg('支付密码错误！');
	                }
	            })
	        } else {
	            layer.close(payPassword);
	            layer.msg('密码错误！');
	        }
	    });
	    

        $("#balancePayment").on("click",function(){
            paypassword();
        })

        //选择发票地址
        $(".step-invoice .invoice-item").on("click",function(){
            var obj = $(this);
            $(".step-invoice .invoice-item").removeClass("invoice-selected");
            obj.addClass("invoice-selected");
        })

        //弹窗发票点击选择
        $(".invoice-tab li").on("click",function(){
            var obj = $(this);
            obj.addClass("selected").siblings().removeClass("selected");
            if(obj.attr("data-name")=="vat"){
                $('#invoiceTitlePersonalLabel').hide();
                $('#vatInvoiceDiv').show();
                $('#invoiceTitleCompany').prop("checked", true);
                $('#personalOrCompanyDiv').html('<i class="text-red">*</i>单位名称');
                $(".personalOrCompanyprompt").attr('placeholder','请输入单位名称');
                $("#personalDiv").hide();
            }else{
                $('#invoiceTitlePersonalLabel').show();
                $('#vatInvoiceDiv').hide();
                $("#personalDiv").show();
            }
        })
        initInvoiceTitleChangeEvent();

        //发票点击弹窗调用
        $(".addinvoiceBtn").on("click",function(){
            addinvoice();
        })
    })

    //购物车
    function getCartContent(){
        $(".topshopcart").addClass("cart-hover");
    }
    function removeCartContent(){
        $(".topshopcart").removeClass("cart-hover");
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

    function payment(){
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
    function paypassword(){
        payPassword = layer.open({
            type: 1,
            title: '支付密码',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['360px','200px'],
            content: $("#payPassword")
        });
    }
	//跳转到设置支付密码页面
    function setPayPwd() {
        var _url = '/account/userChangePaw?type=2&successUrl=' + encodeURIComponent(window.location.href);
        window.location.href = _url;
    }
    //发票弹窗
    var addInvoice;
    function addinvoice(){
        addInvoice = layer.open({
            type: 1,
            title: '新增发票',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['660px','400px'],
            content: $("#addinvoice")
        });
    }
    //发票
    function initInvoiceTitleChangeEvent(){
        $("input[type='radio'][name='invoiceTitle']").change(function(){
            $('#companyName').val('');
            if($(this).val() == "company"){
                $('#personalOrCompanyDiv').html('<i class="text-red">*</i>单位名称');
                $(".personalOrCompanyprompt").attr('placeholder','请输入单位名称');
            }else{
                $('#personalOrCompanyDiv').html('<i class="text-red">*</i>个人姓名');
                $(".personalOrCompanyprompt").attr('placeholder','请输入个人姓名');
            }
        });
    }

</script>
</body>
</html>