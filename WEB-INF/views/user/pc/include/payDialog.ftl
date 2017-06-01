<script>
    // 分页组件
    avalon.component('ms-payDialog', {
        template: '<div>' +
        '<div id="payment" class="hidden">' +
        '<div class="paytypes">' +
        '<ul>' +
        '<li :for="(key,value) in @bussinessConfigTypeList">' +
        '<a href="javascript:void(0)" :click="selectPayWay(2)" :if="key == \'config_alipay_pc\'">支付宝支付</a>' +
        '<a href="javascript:void(0)" :click="selectPayWay(5)" :if="key == \'userBalnce\'">余额支付</a>' +
        '</li>' +
        '</ul>' +
        '</div>' +
        '</div>' +
        '<div id="payPassword" class="hidden">' +
        '<div class="formList paypassword" :visible="isPayPassword == 0">' +
        '<div class="item">' +
        '<div class="hd">输入支付密码：</div>' +
        '<div class="bd">' +
        '<input type="password" class="textfield" :duplex="pwdInput">' +
        '</div>' +
        '</div>' +
        '<div class="item">' +
        '<div class="hd"></div>' +
        '<div class="bd">' +
        '<a class="v-btn" href="javascript:void(0)" :click="payByBalance">确定</a>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '<div class="formList paypassword" :visible="isPayPassword == 1">' +
        '<div class="set-payment-password">' +
        '您还未设置支付密码，请先设置<a href="/account/userChangePaw?type=2&successUrl=/account/order?orderTypeCd=1" class="text-red">支付密码</a>' +
        '</div>' +
        '</div>' +
        '</div>' +
        '</div>',
        defaults: {
            orderId: 0,
            bussinessConfigTypeList: {}, // 所有支付类型
            orderNumber: '', // 订单号
            orderPayAmt: -1, // 支付金额
            isPayPassword: -1, // 是否已设置支付密码 0：已设置 1：未设置
            payWayShow: false, // 选择支付类型的弹窗显示状态
            payPasswordShow: false, // 输入支付密码的弹窗显示状态
            payUrl: '/account/order/goToOrderPayment', // 支付地址前缀
            pwdInput: '', // 密码输入框
            isError: true,
            clearOrderId: null,
            // 监听
            // ---数据---
            $computed: {

            },
            // ---方法---
            // 初始化回调
            onInit: function () {
                var obj = this;
                // 监听orderId
                this.$watch("orderId", function (val) {
                    if(val && val > 0) {
                        // 获取所有支付方式
                        $.get('/orderHeader/getBussinessConfigTypeList', {
                            orderId: val
                        }, function (data) {
                            if(data.allowUseEndTime != null){
                                layer.msg("该提购券已过期，无法购买！");
                                obj.clearOrderId();
                                return false;
                            }
                            obj.bussinessConfigTypeList = data.bussinessConfigTypeList;
                            obj.orderNumber = data.orderNumber;
                            obj.orderPayAmt = data.orderPayAmt;
                            obj.isPayPassword = data.isPayPassword;

                            //打开支付弹窗
                            layer.open({
                                type: 1,
                                title: '选择支付方式',
                                skin: 'layui-layer-rim',
                                shade: [0.6],
                                area: ['360px'],
                                content: $("#payment"),
                                end: function () {
                                    if(obj.isError){
                                        obj.clearOrderId();
                                    }
                                }
                            });
                        }, 'json');
                    }
                });
            },
            // 选择支付渠道
            selectPayWay: function (payWay) {
                var obj = this;
                if (payWay !== 5) {
                    // 非余额支付则直接跳转
                    window.location.href = this.payUrl + '?orderNumber=' + this.orderNumber + '&payWay=' + payWay
                } else {
                    // 余额支付需继续输入密码
                    this.isError = false;
                    layer.closeAll();
                    this.isError = true;
                    layer.open({
                        type: 1,
                        title: '支付密码',
                        skin: 'layui-layer-rim',
                        shade: [0.6],
                        area: ['360px','200px'],
                        content: $("#payPassword"),
                        end: function () {
                            if(obj.isError){
                                obj.clearOrderId();
                            }
                        }
                    });
                }
            },
            // 余额支付输入密码后点击确认
            payByBalance: function() {
                var obj = this;
                if (this.pwdInput.length != 6) {
                    layer.msg('请输入六位密码');
                    return false;
                }
                $.post('/m/account/order/testPayPwd', {
                    payPassword: obj.pwdInput
                }, function (data) {
                    if(data.data == true) {
                        window.location.href = obj.payUrl + '?orderNumber=' + obj.orderNumber + '&payWay=5';
                    } else {
                        layer.msg('支付密码错误');
                    }
                },'json');
            }
        }
    });

</script>