<body class="page-list">
<script scr="/static/js/avalon.min.js"></script>
<div id="main" ms-controller="app">
    <div class="checkout">
        <div class="checkout-tit">填写并核对订单信息</div>
        <div class="checkout-steps">
            <div class="step-tit">
                <h3>收货人信息</h3>
                <span class="extra-r flr"><a href="javascript:void(0);" class="link" id="newaddressBtn">新增地址</a></span>
            </div>
            <div class="step-addr-wrap">
                <div class="step-addr">
                    <ul>
                    <#if addrList??>
                        <#list addrList as addr>
                            <li :hover=['step-addr-selected']>
                                <div class="addr-item <#if (addr.isDefaultAddr ==1) >item-selected</#if>"
                                     data-id="${addr_index}">${addr.receiverName!}
                                    <b></b>
                                </div>
                                <div class="addr-detail">
                                    <span class="addr-name">${addr.receiverName!}</span>
                                    <span class="addr-info">${addr.receiverProvinceName!} ${addr.receiverCityName!} ${addr.countyName!} ${addr.receiverAddr!}</span>
                                    <span class="addr-tel">${addr.receiverTel!}</span>
                                    <#if addr.isDefaultAddr ==1>
                                        <span class="addr-default">默认地址</span>
                                    </#if>
                                </div>
                                <div class="op-btns">
                                    <a href="javascript:setDefaultAddr(${addr.addrId!})">设为默认地址</a>
                                    <a href="javascript:editAddr(${addr.addrId!})">编辑</a>
                                    <a href="javascript:deleteAddr(${addr.addrId!})">删除</a>
                                </div>
                            </li>
                        </#list>
                    </#if>
                    </ul>
                </div>
                <div class="addr-switch">
                    <span>更多地址</span><b></b>
                </div>
            </div>
            <div class="step-since-wrap">
                <div class="step-since">
                    <div class="since-item">线下自提<b></b></div>
                    <div class="since-selected">
                        <ul>
                        <#if data.store??>
                            <#list data.store as s>
                                <li>
                                    <label>
                                        <input type="radio" onchange="changeStore(this)" name="sinceSelected"
                                               <#if s_index == 0>checked="checked"</#if>
                                               value="${s.storeId!}" data-id="${s_index}">
                                        <p>${s.storeName!}</p>
                                    </label>
                                    <span>${s.detailAddress!}</span>
                                </li>
                            </#list>
                        </#if>
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
                </div>
                <div class="shoptb">
                    <div class="shoptb-hd">
                        <table>
                            <tbody>
                            <tr>
                                <td class="td-product">众筹商品信息</td>
                                <td>众筹价格</td>
                                <td class="td-amount">数量</td>
                                <td class="td-total">小计</td>
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
                                        <div class="img"><a href="/crowdfunding/detail/${data.promotionId!}"><img
                                                src="${data.picUrl!}"></a></div>
                                        <div class="info">
                                            <div class="name"><a href="/crowdfunding/detail/${data.promotionId!}"
                                                                 target="_blank">${data.promotionName!}</a></div>
                                            <div class="prop"><#if data.sku??><#list data.sku as s><span>${s.skuType!}
                                                <em>${s.skuValue!}</em></span></#list></#if></div>
                                        </div>
                                    </div>
                                </td>
                                <td><em>￥${(data.perAmt?string('#.00'))!} </em></td>
                                <td class="td-amount">${data.quantity!}</td>
                                <td class="td-total"><em>￥${(data.productTotal?string('#.00'))!} </em></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
            <div class="step-wrap" :visible="@isExpress">
                <div class="step-tit">
                    <h3>配送信息</h3>
                </div>
                <div class="formList">
                    <div class="item">
                        <div class="hd">送货方式</div>
                        <div class="bd">
                            <select :duplex="expressSelect">
                                <option value="0">请选择快递</option>
                                <option :for="el in @expressList" :attr="{value:@el.expressId}">{{el.expressName}}
                                    ￥{{el.defaultPrice}}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="step-wrap" :visible="!@isExpress">
                <div class="formList">
                    <div class="item">
                        <div class="hd">选择提货时间</div>
                        <div class="bd">
                            <select class="mr20" :duplex="dateSelect">
                                <option value='0'>日期</option>
                            <#list data.dateList as dl>
                                <option value= ${dl.key!}>${dl.value!}</option>
                            </#list>
                            </select>
                            <select :duplex="timeSelect">
                                <option value="0">时间</option>
                                <option attr="am" :attr="{value:@currnetStoreTime.am}">{{@currnetStoreTime.am}}</option>
                                <option value="pm" :attr="{value:@currnetStoreTime.pm}">{{@currnetStoreTime.pm}}
                                </option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="step-wrap">
                <div class="step-tit">
                    <h3>备注信息</h3>
                </div>
                <div class="formList">
                    <div class="item">
                        <textarea cols="100" rows="8" :duplex="remark" placeholder="请输入备注"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="trade-foot">
        <div class="trade-foot-detail">
            <div class="fc-price-info">
                <span class="price-tit">应付总额（已支付）：</span>
                <span class="price-num">￥${(data.productTotal?string('#.00'))!} </span>
            </div>
            <div class="fc-price-info">
                <span class="mr20" :visible="@isExpress">寄送至：{{@currentAddr.addrName}}</span>
                <span class="mr20" :visible="!@isExpress">门店自提</span>
            </div>
        </div>
        <div class="inner">
            <button id="btnBuy">提交订单</button>
        </div>
    </div>
</div>

<div id="newddress" class="hidden">
    <div class="reg-form">
        <ul>
            <li>
                <div class="hd">姓名</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="addrName"></div>
                </div>
            </li>
            <li>
                <div class="hd">所在地区</div>
                <div class="bd">
                    <div id="citySelect">
                        <select class="prov"></select>
                        <select class="city" disabled="disabled"></select>
                        <select class="dist" disabled="disabled"></select>
                    </div>
                </div>
            </li>
            <li>
                <div class="hd">街道</div>
                <div class="bd">
                    <textarea id="addrDetail"></textarea>
                </div>
            </li>
            <li>
                <div class="hd">手机号码</div>
                <div class="bd">
                    <div class="item"><input type="text" class="textfield" id="addrTel"></div>
                </div>
            </li>
            <li>
                <div class="bd">
                    <a href="javascript:editOrUpdateAddress()" class="btn-action">新增</a>
                </div>
            </li>
        </ul>
    </div>
</div>
<script type='text/javascript' src="/static/js/citySelect/jquery.cityselect.js"></script>

<script type='text/javascript'>
    var orderId = ${data.orderId?default(0)};
    var promotionId = ${data.promotionId?default(0)};


    var app = avalon.define({
        $id: "app",
        name: 'hello',
        dateSelect: '',
        timeSelect: '',
        expressSelect: '',
        isExpress: true,
        addrIndex: 0,
        storeIndex: 0,
        remark: '',
        addrList: [
        <#if addrList??>
            <#list addrList as addr>
                {
                    addrId:${addr.addrId!},
                    addrName: '${addr.receiverName!}- ${addr.receiverTel!}：${addr.receiverProvinceName!} ${addr.receiverCityName!} ${addr.countyName!} ${addr.receiverAddr!}',
                    receiverCityId:${addr.receiverCityId?default(0)},
                    receiverName: '${addr.receiverName!}',
                    receiverTel: '${addr.receiverTel!}',
                    receiverProvinceName: '${addr.receiverProvinceName!}',
                    receiverCityName: '${addr.receiverCityName!}',
                    countyName: '${addr.countyName!}',
                    receiverAddr: '${addr.receiverAddr!}'
                },
            </#list>
        </#if>],
        storeList: [
        <#if data.store??>
            <#list data.store as s>
                {
                    am: '${s.amStart!}-${s.amEnd!}',
                    pm: '${s.pmStart!}-${s.pmEnd!}',
                    storeId:${s.storeId!}
                },
            </#list>
        </#if>],
        expressList: [
        <#if expressList??>
            <#list expressList as express>
            <#--<option value="${express.expressId!}">${express.expressName!}￥${(express.defaultPrice?string('#.00'))!}</option>-->
                {
                    expressId:${express.expressId!},
                    expressName: '${express.expressName!}',
                    defaultPrice:${express.defaultPrice!}
                },
            </#list>
        </#if>],
        $computed: {
            currentAddr: function () {
                return this.addrList[this.addrIndex];
            },
            currnetStoreTime: function () {
                return this.storeList[this.storeIndex];
            }
        },
        getAddr: function (id) {
            for (var i = 0; i < this.addrList.length; i++) {
                if (this.addrList[i].addrId == id) return this.addrList[i];
            }
        },
    })

    function changeStore(e) {
        app.storeIndex = $(e).attr('data-id');
    }

    $(function () {
        $(".topshopcart").hover(getCartContent, removeCartContent);

        //选择地址
        $(".step-addr .addr-item").on("click", function () {
            var obj = $(this);
            $(".step-addr .addr-item").removeClass("item-selected");
            obj.addClass("item-selected");
            $(".since-item").removeClass("item-selected");
            app.isExpress = true;
            app.addrIndex = obj.attr('data-id');

            //重新加载快递列表
            reloadExpressList();
        })


        //地址下拉
        var propsbox = $(".step-addr"), openheight, closeheight = propsbox.find("li").eq(0).outerHeight(true);
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
        $(".since-switch").on("click", function () {
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
                $(".addr-switch").addClass("since-switch-on");
                $(".addr-switch").find("span").html("更多");
                sincebox.animate({
                    height: sincecloseheight
                }, function () {
                    sincebox.addClass("toggled");
                });
            }
        });

        $(".since-item").on("click", function () {
            if (app.storeList.length == 0) {
                layer.msg('无自提门店');
                return false;
            }
            app.isExpress = false;
            $(this).addClass("item-selected");
            $(".step-addr .addr-item").removeClass("item-selected");
        })


        $("#newaddressBtn").on("click", function () {
            //省市联动
            $("#citySelect").citySelect({
                prov: "北京",
                nodata: "none"
            });
            $('#addrName').val('');
            $('#addrDetail').val('');
            $('#addrTel').val('');
            addrId = 0;
            newaddress();
        })

        $('#btnBuy').click(function () {
            if (app.isExpress) {//快递：地址和快递方式是否为空
                if (app.currentAddr == null) {
                    layer.msg('收货地址不能为空！');
                    return false;
                }
                if (app.expressSelect == null || app.expressSelect == '' || app.expressSelect == 0) {
                    layer.msg('快递方式不能为空！');
                    return false;
                }
            }
            layer.confirm('是否确认提交？', function () {
                var index = layer.load(1, {
                    shade: [0.1, '#fff'] //0.1透明度的白色背景
                });
                var param = {
                    remark: app.remark,
                    orderId: orderId,
                    promotionId: promotionId,
                    isExpress: app.isExpress,
                    storeId: app.currnetStoreTime.storeId,
                    addrId: app.currentAddr.addrId,
                    expressId: app.expressSelect,
                    pickupDate: app.dateSelect,
                    pickupTime: app.timeSelect
                };
//                console.log(data);
                $.ajax({
                    url: '/m/account/crowdfundingOrder/dealAwardOrder',
                    data: param,
                    dataType: 'json',
                    type: 'post',
                    success: function (data) {
                        if (data.result == 'success') {
                            layer.msg('领奖成功！');
                            location.href = '/account/crowdfundingOrder/detail?orderId=' + orderId;
                        } else {
                            layer.alert(data.message);
                        }
                    }
                });
            })
        });

    })

    //重新加载快递列表
    function reloadExpressList() {
        var index = layer.load(1, {
            shade: [0.1, '#fff'] //0.1透明度的白色背景
        });
        $.get('/account/crowdfundingOrder/jsonExpressList', {receiverCityId: app.currentAddr.receiverCityId}, function (data) {
//            console.log(data);
            if (data) {
                app.expressList = data;
                layer.close(index);
            }
        });
    }

    var newAddress;
    function newaddress() {
        newAddress = layer.open({
            type: 1,
            title: '新增地址',
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['720px'],
            content: $("#newddress")
        });
    }

    function deleteAddr(id) {
        $.get('/account/order/submitOrder/delAddress', {addressId: id}, function (data) {
            if (data.result == 'success') {
                layer.msg('删除成功！');
                location.reload();
            } else {
                layer.alert(data.message);
            }
        })
    }

    function setDefaultAddr(id) {
        $.get('/account/order/submitOrder/setDefaultAddress', {addressId: id}, function (data) {
            if (data.result == 'success') {
                layer.msg('设置成功！');
                location.reload();
            } else {
                layer.alert(data.message);
            }
        })
    }

    var addrId;
    function editAddr(id) {
        var cityList = app.getAddr(id);
        if (cityList) {
            $("#citySelect").citySelect({
                prov: cityList.receiverProvinceName,
                city: cityList.receiverCityName,
                dist: cityList.countyName
            });
            $('#addrName').val(cityList.receiverName);
            $('#addrDetail').val(cityList.receiverAddr);
            $('#addrTel').val(cityList.receiverTel);
        }
        addrId = id;
        newaddress();
    }

    var reg = /^1[34578]\d{9}$/;
    function editOrUpdateAddress() {
        var tel = $('#addrTel').val().trim();
        var detail = $('#addrDetail').val().trim();
        var receiveName=$('#addrName').val().trim();
        if(!reg.test(tel)){
            layer.alert('请输入正确的手机号码！');
            return false;
        }
        if(detail == '' || receiveName == ''){
            layer.alert('请输入完整信息！');
            return false;
        }
        var param = {
            addrId:addrId,
            tel:tel,
            detail:detail,
            county:$("#citySelect .dist").val(),
            city:$("#citySelect .city").val(),
            province:$("#citySelect .prov").val(),
            receiveName:receiveName
        };
//        加载动画：
        var index = layer.load(1, {
            shade: [0.1, '#fff'] //0.1透明度的白色背景
        });
        $.post('/account/userAddress/editOrUpdateAddress',param,function (data) {
            if(data.result == 'success'){
                layer.msg('操作成功！');
                location.reload();
            }else{
                layer.alert(e.getMessage());
            }
            layer.close(index);
        })
    }

</script>
</body>
