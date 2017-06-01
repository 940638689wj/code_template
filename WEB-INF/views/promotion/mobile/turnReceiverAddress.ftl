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
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a href="${ctx}/m/awards/list" class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">奖品领取地址</h1>
        <a class="mui-icon"></a>
    </header>
</#if>

    <div class="mui-content">
        <form id="J_Form" name="J_Form" action="" method="post">
            <input type="hidden" id="awardsResultId" name="awardsResultId" value="${(awardsResult.id)!}"/>
            <input type="hidden" id="province" name="province" value="${(awardsResult.provinceId)!}"/>
            <input type="hidden" id="city" name="city" value="${(awardsResult.cityId)!}"/>
            <input type="hidden" id="county" name="county" value="${(awardsResult.countyId)!}"/>

            <ul class="tbviewlist">
                <li class="input-wrap">
                    <div class="hd">联系人</div>
                    <div class="bd"><input type="text" placeholder="您的姓名" name="receiverName"
                                           value="${(awardsResult.receiverName)!}"></div>
                    <span class="delete"></span>
                </li>
                <li class="input-wrap">
                    <div class="hd">联系电话</div>
                    <div class="bd"><input id="receiverTel" type="number" placeholder="您的手机号" name="receiverTel"
                                           value="${(awardsResult.mobile)!}"></div>
                    <span class="delete"></span>
                </li>
                <li>
                    <div class="hd">所在地区</div>
                    <div class="bd">
                        <input id="showCityPicker" type="text" placeholder="省-市-区/县" value="${area!}"/>
                    </div>
                </li>
                <li>
                    <div class="hd"></div>
                    <div class="bd"><textarea textarea id="receiverAddr" name="receiverAddr"
                                              placeholder="详细地址（街道/门牌号）">${(awardsResult.address)!}</textarea></div>
                </li>
            </ul>
            <div class="mui-content-padded mt30 align-center">
                <button type="button" class="mui-btn mui-btn-primary mui-btn-block mb20" id="addressSub">确定</button>
            </div>
        </form>
    </div>
</div>

<script>
    (function ($, doc) {
        $.init();
        $.ready(function () {
            var cityPicker = new $.PopPicker({
                layer: 3
            });
            cityPicker.setData(cityData4);
            var showCityPickerButton = doc.getElementById('showCityPicker');
            showCityPickerButton.addEventListener('tap', function (event) {
                var obj = this;
                var province = doc.getElementById('province');
                var city = doc.getElementById('city');
                var county = doc.getElementById('county');
                var items2 = '';
                cityPicker.show(function (items) {
                    items2 = (items[2] || {}).text ? "-" + (items[2] || {}).text : '';
                    obj.value = (items[0] || {}).text + " - " + (items[1] || {}).text + items2;
                    county.value = (items[2] || {}).value ? (items[2] || {}).value : '';
                    province.value = (items[0] || {}).value;
                    city.value = (items[1] || {}).value;
                    //返回 false 可以阻止选择框的关闭
                    //return false;
                });
            }, false);
        });
    })(mui, document);

    $(function () {
        var flag = true;//防止多次提交
        $("#addressSub").click(function () {
            var receiverName = $("input[name='receiverName']").val();
            var receiverTel = $("input[name='receiverTel']").val();
            var receiverAddr = $("#receiverAddr").val() ? $("#receiverAddr").val().replace(/\s+/g, "") : '';
            var province = $("#province").val();
            var city = $("#city").val();
            var county = $("#county").val() ? $("#county").val() : '';
            var id = $("#awardsResultId").val();
            if (receiverName == "") {
                mui.toast('请输入用户名!');
                return false;
            } else if (receiverName.length > 50) {
                mui.toast('用户名长度不能超过50!');
                return false;
            }

            if (!checkTelephone(receiverTel)) {
                mui.toast('手机格式不正确!');
                return;
            }

            if (receiverAddr == "") {
                mui.toast('请输入详细地址!');
                return false;
            } else if (receiverAddr.length > 100) {
                mui.toast('详细地址长度不能超过100!');
                return false;
            }

            if (!flag) {
                return;
            }
            flag = false;

            var data = {};
            data.receiverName = receiverName;
            data.receiverAddr = receiverAddr;
            data.receiverTel = receiverTel;
            data.province = province;
            data.city = city;
            data.county = county;
            data.id = id;
            $.post('${ctx}/m/turn/recordsave', data, function (data) {
                flag = true;
                if (data && data.result == 'success') {
                    mui.toast('成功保存！');
                    window.location.href = "${ctx}/m/awards/list";
                } else {
                    mui.toast('请重新填写！');
                }
            }, "json");
        });

        $(".input-wrap").each(function () {
            var wrap = $(this),
                    input = wrap.find("input"),
                    del = wrap.find(".delete");
            del.on("click", function () {
                input.val("").focus();
                del.hide();
            });
            input.on("input propertychange", function () {
                if ($.trim(this.value) != "") {
                    del.show();
                } else {
                    del.hide();
                }
            });
        });
    });

    // 校验手机号码格式
    function checkTelephone(telephone) {
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
    }

</script>
</body>
</html>