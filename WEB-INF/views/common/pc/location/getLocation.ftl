<#assign ctx = request.contextPath>

<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <title>选择收货地址</title>

    <link rel="stylesheet" href="${ctx}/static/css/style.css">
    <script src="${ctx}/static/js/lib/jquery-1.8.3.min.js"></script>
    <script src="${ctx}/static/layer/layer.js"></script>
    <script src="${ctx}/static/js/jquery.placeholder.min.js"></script>
    <script src="${ctx}/static/js/jquery.nicescroll.js"></script>
</head>
<body>


<!-- 确认收货地址 弹出框-->
<div id="confirmAddressDiv" data-from="" style="display: none;">
    <div class="firsttime">
        <div class="firstinfo">
            <ul>
                <li><p class="info">选择地址后下单时将无法修改收货地址， 是否确认？</p></li>
                <li>
                    <a class="reg-login-btn fl" href="javascript:void(0);" onclick="confirmUseAddress();">确定</a>

                    <a class="reg-reset-btn" href="javascript:void(0);" onclick="closeConfirmAddressDiv();">取消</a>
                </li>
            </ul>
        </div>
    </div>
</div>

<!--登陆 弹出框-->
<div id="loginDiv" style="display: none;">
    <div class="firsttime">
        <div class="firstinfo">
            <ul>
                <li>
                    <div class="reg-text-name">账号：</div>
                    <input type="text" id="loginName" placeholder="请输入用户名/手机号" class="textfield">
                </li>
                <li>
                    <div class="reg-text-name">密码：</div>
                    <input type="password" id="password" placeholder="请输入密码" class="textfield">
                </li>
                <li>
                    <div class="reg-text-name">验证码：</div>
                    <input type="text" id="verifyCode" class="textfield vcode">
                    <div class="reg-text-code"><img src="${ctx}/randomCaptcha" id="randomImage"></div>
                </li>
                <li><a class="reg-login-btn" href="javascript:void(0);" onclick="ajaxLogin();">登录</a></li>
                <li>
                    <p class="fll"><a href="${ctx}/register">注册</a></p>
                    <p class="flr"><a href="${ctx}/forgotPaw">忘记密码？</a></p>
                </li>
            </ul>
        </div>
    </div>
</div>

<!--填写收货地址 弹出框-->
<div id="newAddressDiv" data-from="" style="display: none;">
    <div class="firsttime">
        <div class="firstinfo">
            <form id="selectAddressForm">
                <ul>
                    <#--<li>新增收货地址：</li>-->
                    <li>
                        <select class="mr6" id="selectCountyId" name="selectCountyId">
                            <option value="">-- 区/县 --</option>
                            <#if countyList?? && countyList?has_content>
                                <#list countyList as county>
                                    <option value="${county.id}">${(county.areaName)!}</option>
                                </#list>
                            </#if>
                        </select>

                        <select class="mr6" id="selectTownId" name="selectTownId">
                            <option value="">-- 街道/镇 --</option>
                        </select>

                        <select id="selectVillageId" name="selectVillageId">
                            <option value="">-- 社区/村 --</option>
                        </select>
                    </li>
                    <li>
                        <input type="text" id="addressDetail" class="textfield fistadd" placeholder="输入详细地址">
                    </li>
                    <li>
                        <a class="reg-login-btn fl" href="javascript:void(0);" onclick="confirmAddressFromNewAddressDiv();">确定</a>

                        <a id="newAddressDiv_reset" class="reg-reset-btn" href="javascript:void(0);" onclick="resetSelectAddressForm();">重置</a>

                        <a id="newAddressDiv_cancel" style="display: none;" class="reg-reset-btn" href="javascript:void(0);" onclick="closeNewAddressDiv();">取消</a>
                    </li>
                </ul>
            </form>
        </div>
    </div>
</div>


<!--选择收货地址 弹出框-->
<div id="selectOldAddressDiv" style="display: none;">
    <div class="firsttime">
        <div class="firstinfo">
            <ul>
                <li>是否使用以下收货地址：</li>
                <li id="oldAddress" data-countyId="" data-townId="" data-villageId="" data-addressDetail="">
                    <P id="oldAddressP1"></P>
                    <p id="oldAddressP2"></p>
                </li>
                <li id="showHistoryAddressDiv" style="display: none;">
                    <a href="javascript:void(0);" onclick="showHistoryAddressDiv();" class="orange">选择历史收货地址 >></a>
                </li>
                <li>
                    <a href="javascript:void(0);" onclick="showNewAddressDiv('selectOldAddressDiv');" class="orange">新增收货地址 >></a>
                </li>
                <li>
                    <a class="reg-login-btn" href="javascript:void(0);" onclick="confirmAddressFromSelectOldAddressDiv();">确定</a>
                </li>
            </ul>
        </div>
    </div>
</div>


<!--历史地址列表 弹出框-->
<div id="historyAddressDiv" style="display: none;">
    <div class="firsttime">
        <div class="historyaddress">
            <div class="firstinfo">
                <ul>
                    <li class="mb0">选择以下历史收货地址：</li>
                </ul>
            </div>
            <div class="chooesaddress">
                <ul id="chooiceAddressUl"></ul>
            </div>
            <div class="firstinfo">
                <ul>
                    <li class="mb0">
                        <a class="reg-login-btn fl" href="javascript:void(0);" onclick="confirmAddressFromHistoryAddressDiv();">确定</a>
                        <a class="reg-reset-btn" href="javascript:void(0);" onclick="closeHistoryAddressDiv();">取消</a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<input type="hidden" id="confirmCountyId" value=""/>
<input type="hidden" id="confirmTownId" value=""/>
<input type="hidden" id="confirmVillageId" value=""/>
<input type="hidden" id="confirmAddressDetail" value=""/>

<script>
    var loginDiv,
            selectOldAddressDiv,
            newAddressDiv,
            confirmAddressDiv,
            historyAddressDiv;

    function resetSelectAddressForm(){
        document.getElementById("selectAddressForm").reset();
    }

    function ajaxLogin(){
        var loginName = $('#loginName').val();
        var password = $('#password').val();
        var verifyCode = $('#verifyCode').val();

        if(!loginName){
            layer.msg('请输入用户名/手机号!');
            return false;
        }

        if(!password){
            layer.msg('请输入密码!');
            return false;
        }

        if(!verifyCode){
            layer.msg('请输入验证码!');
            return false;
        }

        var index = layer.load(2, {
            shade: [0.1,'#fff']
        });
        $.post("${ctx}/m/login/login_post", {
            loginName : loginName,
            password : password,
            verifyCode : verifyCode,
            getAddressList : "1"
        }, function(data){
            layer.close(index);

            if(data && data.result == "true"){
                // 加载会员的收货地址
                loadUserAddressList();
            }else{
                layer.msg(data.message || "登录失败,请稍后再试!");
            }
        }, "json");
    }

    function confirmAddressFromHistoryAddressDiv(){
        if($("input[name='historyAddress']").filter(":checked").length == 0){
            layer.msg("请选择一个收货地址!");
            return ;
        }

        var obj = $($("input[name='historyAddress']").filter(":checked").get(0));

        var receiverCountyId = obj.attr('data-countyId');
        var receiveTownId = obj.attr('data-townId');
        var receiveVillageId = obj.attr('data-villageId');
        var receiverAddr = obj.attr('data-receiverAddr');

        $('#confirmCountyId').val(receiverCountyId);
        $('#confirmTownId').val(receiveTownId);
        $('#confirmVillageId').val(receiveVillageId);
        $('#confirmAddressDetail').val(receiverAddr);

        showConfirmAddressDiv('historyAddressDiv');
    }

    function confirmAddressFromSelectOldAddressDiv(){
        var oldAddress = $('#oldAddress');
        var confirmCountyId = oldAddress.attr('data-countyId');
        var confirmTownId = oldAddress.attr('data-townId');
        var confirmVillageId = oldAddress.attr('data-villageId');
        var confirmAddressDetail = oldAddress.attr('data-addressDetail');

        $('#confirmCountyId').val(confirmCountyId);
        $('#confirmTownId').val(confirmTownId);
        $('#confirmVillageId').val(confirmVillageId);
        $('#confirmAddressDetail').val(confirmAddressDetail);

        showConfirmAddressDiv('selectOldAddressDiv');
    }

    function confirmAddressFromNewAddressDiv(){
        var selectCountyId = $('#selectCountyId').val();
        if(!selectCountyId || selectCountyId == ""){
            layer.msg("请选择区/县!");
            return ;
        }

        var selectTownId = $('#selectTownId').val();
        if(!selectTownId || selectTownId == ""){
            layer.msg("请选择街道/镇!");
            return ;
        }

        var selectVillageId = $('#selectVillageId').val();
        if(!selectVillageId || selectVillageId == ""){
            layer.msg("请选择社区/村!");
            return ;
        }

        var addressDetail = $('#addressDetail').val();
        if(!addressDetail || $.trim(addressDetail) == ""){
            layer.msg("请输入详细地址!");
            return ;
        }
        if(addressDetail.length > 20){
            layer.msg("详细地址不能超过20个字符!");
            $('#addressDetail').focus();
            return ;
        }

        $('#confirmCountyId').val(selectCountyId);
        $('#confirmTownId').val(selectTownId);
        $('#confirmVillageId').val(selectVillageId);
        $('#confirmAddressDetail').val(addressDetail);

        showConfirmAddressDiv('newAddressDiv');
    }

    <!-- 确认收货地址 弹出框-->
    function showConfirmAddressDiv(fromDiv){
        layer.closeAll();

        $('#confirmAddressDiv').attr('data-form', fromDiv);

        loginDiv = layer.open({
            type: 1,
            title: '确认收货地址',
            closeBtn: 0,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['400px'],
            content: $("#confirmAddressDiv")
        });
    }
    function closeConfirmAddressDiv(){
        var dataFrom = $('#confirmAddressDiv').attr('data-form');
        if(dataFrom == "newAddressDiv"){
            showNewAddressDiv();
        }else if(dataFrom == "selectOldAddressDiv"){
            showSelectOldAddressDiv();
        }else if(dataFrom == "historyAddressDiv"){
            showHistoryAddressDiv();
        }
    }

    function showHistoryAddressDiv(){
        layer.closeAll();
        historyAddressDiv = layer.open({
            type: 1,
            title: '选择收货地址',
            closeBtn: 0,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['400px'],
            content: $("#historyAddressDiv")
        });
        niceScrollReset();
    }
    function closeHistoryAddressDiv(){
        showSelectOldAddressDiv();
    }


    function showLoginDiv(){
        layer.closeAll();

        loginDiv = layer.open({
            type: 1,
            title: '登陆',
            closeBtn: 0,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['400px'],
            content: $("#loginDiv")
        });
    }

    function showNewAddressDiv(fromDiv){
        layer.closeAll();

        if(fromDiv){
            $('#newAddressDiv_cancel').show();
            $('#newAddressDiv_reset').hide();

            $('#newAddressDiv').attr('data-form', fromDiv);
        }

        newAddressDiv = layer.open({
            type: 1,
            title: '新增收货地址',
            closeBtn: 0,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['400px'],
            content: $("#newAddressDiv")
        });
    }
    function closeNewAddressDiv(){
        var dataFrom = $('#newAddressDiv').attr('data-form');
        if(dataFrom){
            if(dataFrom == "selectOldAddressDiv"){
                showSelectOldAddressDiv();
            }else if(dataFrom == "newAddressDiv"){

            }
        }
    }

    // 加载会员的收货地址
    function loadUserAddressList(){
        $.ajax({
            url : '${ctx}/getLocation/getUserAddress',
            dataType : 'json',
            type: 'GET',
            data : {},
            success : function(data){
                if(data.targetAddress){
                    showSelectOldAddressDiv();

                    $('#oldAddress').attr('data-countyId', data.targetAddress.receiverCountyId);
                    $('#oldAddress').attr('data-townId', data.targetAddress.receiveTownId);
                    $('#oldAddress').attr('data-villageId', data.targetAddress.receiveVillageId);
                    $('#oldAddress').attr('data-addressDetail', data.targetAddress.receiverAddr);

                    $('#oldAddressP1').text(data.targetAddress.countyName +" " +data.targetAddress.townName+" "+data.targetAddress.villageName);
                    $('#oldAddressP2').text(data.targetAddress.receiverAddr);

                    if(data.addressList && data.addressList.length > 0){
                        $('#showHistoryAddressDiv').show();

                        $.each(data.addressList, function(i, row){
                            var liStr = "<li><label>";
                            liStr = liStr + "<input type='radio' name='historyAddress' data-countyId='"+row.receiverCountyId+"' data-townId='"+row.receiveTownId+"' data-villageId='"+row.receiveVillageId+"' data-receiverAddr='"+row.receiverAddr+"'>";
                            liStr = liStr + "<div class='c'><p>"+row.countyName +" " +row.townName+" "+row.villageName+"</p><p>"+row.receiverAddr+"</p></div>";
                            liStr = liStr + "</li></label>";
                            $('#chooiceAddressUl').append(liStr);
                        });
                    }
                }else{
                    // 新增地址
                    showNewAddressDiv();
                }
            }
        });
    }
    function showSelectOldAddressDiv(){
        layer.closeAll();

        selectOldAddressDiv = layer.open({
            type: 1,
            title: '选择收货地址',
            closeBtn: 0,
            skin: 'layui-layer-rim',
            shade: [0.6],
            area: ['400px','310px'],
            content: $("#selectOldAddressDiv")
        });
    }

    $(function() {
        <#if errorMsg?? && errorMsg?has_content>
            //layer.msg('${errorMsg}');
            alert('${errorMsg}');
        </#if>

        $('#randomImage').click(function(){
            $("#randomImage").attr("src", "${ctx}/randomCaptcha?" + Math.floor(Math.random() * ( 1000 + 1)));
        });

        <#if isLogin>
            <#if targetAddress?? && targetAddress?has_content>
                loadUserAddressList();
                // 选择旧的收货地址
                //showSelectOldAddressDiv();
            <#else>
                showNewAddressDiv();
            </#if>
        <#else>
            showLoginDiv();
        </#if>

        $('input, textarea').placeholder();
        $("#overlayAd .close").on("click", function () {
            $("#overlayAd").remove();
        });

        $('#selectCountyId').on('change', function(){
            var selectCounty = $(this).val();
            if(selectCounty && selectCounty != ""){
                $.ajax({
                    url : '${ctx}/common/area/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectCounty},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectTownId", "-- 街道/镇 --");
                            cleanSelectContent("selectVillageId", "-- 社区/村 --");

                            $.each(data.rows, function(i, row){
                                $("#selectTownId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectTownId", "-- 街道/镇 --");
                            cleanSelectContent("selectVillageId", "-- 社区/村 --");
                        }
                    }
                });
            }else{
                $('#selectTownId').empty();
                cleanSelectContent("selectTownId", "-- 街道/镇 --");
                cleanSelectContent("selectVillageId", "-- 社区/村 --");
            }
        });

        $('#selectTownId').on('change', function(){
            var selectTownId = $(this).val();
            if(selectTownId && selectTownId != ""){
                $.ajax({
                    url : '${ctx}/common/area/findChildByParentId',
                    dataType : 'json',
                    type: 'GET',
                    data : {parentId: selectTownId},
                    success : function(data){
                        if(data.rowCount && data.rowCount >0){
                            cleanSelectContent("selectVillageId", "-- 社区/村 --");

                            $.each(data.rows, function(i, row){
                                $("#selectVillageId").append("<option value='"+row.id+"'>"+row.areaName+"</option>");
                            });
                        }else{
                            cleanSelectContent("selectVillageId", "-- 社区/村 --");
                        }
                    }
                });
            }else{
                $('#selectVillageId').empty();
                cleanSelectContent("selectVillageId", "-- 社区/村 --");
            }
        })
    });

    function confirmUseAddress(){
        var selectCountyId = $('#confirmCountyId').val();
        var selectTownId = $('#confirmTownId').val();
        var selectVillageId = $('#confirmVillageId').val();
        var addressDetail = $('#confirmAddressDetail').val();

        console.log(selectCountyId)
        console.log(selectTownId)
        console.log(selectVillageId)
        console.log(addressDetail)
        var selectCountyId = $('#confirmCountyId').val();
        var selectTownId = $('#confirmTownId').val();
        var selectVillageId = $('#confirmVillageId').val();
        var addressDetail = $('#confirmAddressDetail').val();
        window.location.href="${ctx}/getLocation/confirmAddress?successUrl=${successUrl!}"
                +"&selectCountyId="+selectCountyId
                +"&selectTownId="+selectTownId
                +"&selectVillageId="+selectVillageId
                +"&addressDetail="+addressDetail;
    }

    function cleanSelectContent(selectId, remark){
        $('#'+selectId+'').empty();
        $('#'+selectId+'').append("<option value=''>"+remark+"</option>");
    }

    function niceScrollReset(){
        $('.chooesaddress').niceScroll({
            cursorcolor: "#ccc",
            mousescrollstep: 40,
            oneaxismousemode: "auto"
        });
    }
</script>

</body>
</html>