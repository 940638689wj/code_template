<#assign ctx = request.contextPath>

<!doctype html>
<html>
<head>
    <title>选择位置</title>
    <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="format-detection"  content="telephone=no"/>

    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/yrmobile.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/frames.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/module.css" />

    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui/mui.picker.css" />
    <link rel="stylesheet" type="text/css" href="${ctx}/static/mobile/css/mui/mui.poppicker.css" />

    <script type="text/javascript" src="${ctx}/static/mobile/js/zepto.js"></script>
    <script type="text/javascript" src="${ctx}/static/mobile/js/mui.min.js"></script>

</head>
<body>
    <input type="hidden" id="province" name="province" value=""/>
    <input type="hidden" id="city" name="city" value="" />
    <input type="hidden" id="county" name="county" value="" />
    <input id="showCityPicker" type="text" placeholder="省-市-区/县" value="" />
    <div class="mui-content-padded mt30 align-center">
        <button type="button" onclick="selectArea();" class="mui-btn mui-btn-primary mui-btn-block mb20">确定</button>
    </div>

    <script src="${ctx}/static/mobile/js/mui/mui.picker.js"></script>
    <script src="${ctx}/static/mobile/js/mui/mui.poppicker.js"></script>
    <script src="${ctx}/static/mobile/js/mui/city.data-1.js" type="text/javascript" charset="utf-8"></script>
    <script>
        function selectArea(){
            var provinceId = $('#province').val();
            var cityId = $('#city').val();
            if(provinceId == "" || cityId == ""){
                mui.toast("请选择省市!");
                return;
            }

            window.location.href="${ctx}/m/getLocation/confirmLocation?successUrl=${successUrl!}&provinceId="+provinceId+"&cityId="+cityId;
        }

        (function($, doc) {
            $.init();
            $.ready(function() {
                var cityPicker = new $.PopPicker({
                    layer: 3
                });
                cityPicker.setData(cityData3);
                var showCityPickerButton = doc.getElementById('showCityPicker');
                showCityPickerButton.addEventListener('tap', function(event) {
                    var obj = this;
                    var province = doc.getElementById('province');
                    var city = doc.getElementById('city');
                    var county = doc.getElementById('county');
                    cityPicker.show(function(items) {
                        obj.value = (items[0] || {}).text + " - " + (items[1] || {}).text + " - " + (items[2] || {}).text;
                        county.value = (items[2] || {}).value;
                        province.value = (items[0] || {}).value;
                        city.value = (items[1] || {}).value;
                    });
                }, false);
            });
        })(mui, document);
    </script>
</body>
</html>