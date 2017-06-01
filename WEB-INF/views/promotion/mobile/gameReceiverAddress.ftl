<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!DOCTYPE HTML>
<html xmlns="http://www.w3.org/1999/html" lang="en">
<head>
    <title>奖品领取地址</title>
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.picker.min.css"/>
    <link rel="stylesheet" type="text/css" href="${staticPath}/mobile/css/mui.poppicker.css"/>
    <script src="${staticPath}/mobile/js/mui.picker.min.js"></script>
    <script src="${staticPath}/mobile/js/mui.poppicker.js"></script>
    <script src="${staticPath}/mobile/js/city.data-4.js" type="text/javascript" charset="utf-8"></script>

</head>
<body>
<div id="page">
    <header class="mui-bar mui-bar-nav">
        <a href="${ctx}/m/account/award/showAward?awardTypeCd=1" class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">奖品领取地址</h1>
        <a class="mui-icon"></a>
    </header>

    <div class="mui-content">
        <form id="J_Form" name="J_Form" action="" method="post">
            <ul class="tbviewlist">
                <li class="input-wrap">
                    <div class="hd">联系人</div>
                    <div class="bd"><input type="text" placeholder="您的姓名" v-model="awardsResult.receiverName"></div>
                    <span class="delete" @click="clearInp('receiverName')"></span>
                </li>
                <li class="input-wrap">
                    <div class="hd">联系电话</div>
                    <div class="bd">
                        <input type="number" placeholder="您的手机号"
                               v-model="awardsResult.mobile"></div>
                    <span class="delete" @click="clearInp('mobile')"></span>
                </li>
                <li>
                    <div class="hd">所在地区</div>
                    <div class="bd">
                        <input id="showCityPicker" type="text" placeholder="省-市-区/县" v-model="area"/>
                    </div>
                </li>
                <li>
                    <div class="hd"></div>
                    <div class="bd">
                        <textarea textarea placeholder="详细地址（街道/门牌号）" v-model="awardsResult.address"></textarea>
                    </div>
                </li>
            </ul>
            <div class="mui-content-padded mt30 align-center">
                <button type="button" class="mui-btn mui-btn-primary mui-btn-block mb20" @click="addressSubClick()">确定
                </button>
            </div>
        </form>
    </div>
</div>

<script>
    var app = new Vue({
        el: '#page',
        data: {
            awardsResult: {
                id: "",
                receiverName: "",
                provinceId: "",
                cityId: "",
                countyId: "",
                address: "",
                mobile: ""
            },
            area: "",
        <#--showTitle:"${showTitle!}",-->
            flag: true
        },
        methods: {
            addressSubClick: function () {
                if (this.awardsResult.receiverName == "") {
                    mui.toast('请输入用户名!');
                    return false;
                }
                if (this.awardsResult.receiverName.length > 50) {
                    mui.toast('用户名长度不能超过50!');
                    return false;
                }
                if (!this.checkTelephone(this.awardsResult.mobile)) {
                    mui.toast('手机格式不正确!');
                    return;
                }

                if (this.awardsResult.address == "") {
                    mui.toast('请输入详细地址!');
                    return false;
                }
                if (this.awardsResult.address.length > 100) {
                    mui.toast('详细地址长度不能超过100!');
                    return false;
                }

                if (!this.flag) {
                    return;
                }
                this.flag = false;
                this.$http.post('/m/account/award/recordSave', this.awardsResult, {emulateJSON: true}).then(
                        function (res) {
                            this.flag = true;
                            if (res && res.body.result == true) {
                                mui.toast('成功保存！');
                                window.location.href = "${ctx}/m/account/award/showAward?awardTypeCd=1";
                            } else {
                                mui.toast(res.body.message);
                            }
                        }
                )
            },
            // 校验手机号码格式
            checkTelephone: function (telephone) {
                var mobileReg = new RegExp("^(1[0-9]{10})$");
                if (!telephone) {
                    mui.toast('请输入联系电话!');
                    return false;
                }
                if (!mobileReg.test(telephone)) {
                    mui.toast('手机号格式不正确!');
                    return false;
                }
                return true;
            },
            clearInp: function (param) {
                this.awardsResult[param] = "";
            }
        },
        created: function () {
            this.$http.post('/m/account/award/recordJson', {id: ${id!}}, {emulateJSON: true}).then(
                    function (res) {
                        if (res.body.result == true) {
                            this.awardsResult.id = res.body.awardsResultId;
                            this.awardsResult.receiverName = res.body.receiverName;
                            this.awardsResult.mobile = res.body.mobile;
                            this.awardsResult.provinceId = res.body.provinceId;
                            this.awardsResult.cityId = res.body.cityId;
                            this.awardsResult.countyId = res.body.countyId;
                            this.awardsResult.address = res.body.address;
                            this.area = res.body.area;
                        } else {
                            mui.toast(res.body.message);
                        }
                    }
            );

            (function ($, doc) {
                $.init();
                $.ready(function () {
                    var cityPicker = new $.PopPicker({
                        layer: 3
                    });
                    cityPicker.setData(cityData4);
                    app.$el.querySelector("#showCityPicker").addEventListener('tap', function (event) {
                        var items2 = '';
                        cityPicker.show(function (items) {
                            items2 = (items[2] || {}).text ? "-" + (items[2] || {}).text : '';
                            app.area = (items[0] || {}).text + " - " + (items[1] || {}).text + items2;
                            app.awardsResult.countyId = (items[2] || {}).value ? (items[2] || {}).value : '';
                            app.awardsResult.provinceId = (items[0] || {}).value;
                            app.awardsResult.cityId = (items[1] || {}).value;
                            //返回 false 可以阻止选择框的关闭
                            //return false;
                        });
                    }, false);
                });
            })(mui, document);
        }
    });


</script>
</body>
</html>