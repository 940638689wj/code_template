<#assign ctx = request.contextPath>
<#assign staticPath = ctx + "/static">
<!doctype html>
<html lang="en">
<head>
    <title>收货地址</title>
</head>
<body>
<div id="page">
<#if showTitle?? && showTitle>
    <header class="mui-bar mui-bar-nav">
        <a class="mui-icon mui-icon-left-nav"></a>
        <h1 class="mui-title">收货地址</h1>
        <a class="mui-icon"></a>
    </header>
</#if>
    <div class="mui-content">
        <input type="hidden" name="addrId" id="addrId" value="${(userReceiveAddressManage.addrId)!}"/>
        <div class="loginform loginlbd logintopborder">
            <ul>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap">
                                <input type="text" id="receiverName" name="receiverName" value="${(userReceiveAddressManage.receiverName)!}"
                                       placeholder="收货人">
                                <span class="delete"></span>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap">
                                <input type="number" value="${(userReceiveAddressManage.receiverTel)!}"
                                       class="textfield" id="receiverTel" name="receiverTel" placeholder="联系电话">
                                <span class="delete"></span>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap jt">
                                <select name="receiverProvinceId" id="receiverProvinceId" datatype="n" errormsg="请选择！">
                                </select>
                            </div>
                            <div class="input-wrap jt">
                                <select name="receiverCityId" id="receiverCityId" datatype="n" errormsg="请选择！">
                                    <option value="">选择城市</option>
                                </select>
                            </div>
                            <div class="input-wrap jt">
                                <select name="receiverCountyId" id="receiverCountyId" datatype="n" errormsg="请选择！">
                                    <option value="">选择县/区</option>
                                </select>
                            </div>
                        </div>
                    </div>
                </li>
                <li>
                    <div class="bd">
                        <div class="info">
                            <div class="input-wrap">
                                <input id="receiverAddr" name="receiverAddr" type="text"
                                       value="${(userReceiveAddressManage.receiverAddr)!}" placeholder="输入详细地址">
                                <span class="delete"></span>
                            </div>
                        </div>
                    </div>
                </li>
            </ul>
        </div>
        <div class="btnbar">
            <a class="mui-btn mui-btn-block mui-btn-primary" href="javascript:void(0)" type="submit"
               id="saveBtn">保存</a>
        </div>
    </div>
</div>
<#include "../../pc/include/addrSelect.ftl"/>
<script>
    $(function () {
        addChangeEven("receiverProvinceId",["receiverCountyId"],["选择县/区"],"receiverCityId","选择城市");
        addChangeEven("receiverCityId",[],[],"receiverCountyId","选择县/区");
        findChildByParentId("receiverProvinceId", 0, "选择省");
        <#if userReceiveAddressManage?? && userReceiveAddressManage?has_content>
            findChildByParentId("receiverCityId", ${userReceiveAddressManage.receiverProvinceId!}, "选择城市");
            $("#receiverProvinceId").val("${userReceiveAddressManage.receiverProvinceId!}");
            findChildByParentId("receiverCountyId", ${userReceiveAddressManage.receiverCityId!}, "选择县/区");
            $("#receiverCityId").val("${userReceiveAddressManage.receiverCityId!}");
            $("#receiverCountyId").val("${userReceiveAddressManage.receiverCountyId!}");
        </#if>

        $("#saveBtn").click(function () {
            var addrId = $("#addrId").val();
            var receiverName = $("#receiverName").val();
            var receiverTel = $("#receiverTel").val();
            var receiverProvinceId = $("#receiverProvinceId").val();
            var receiverCityId = $("#receiverCityId").val();
            var receiverCountyId = $("#receiverCountyId").val();
            var receiverAddr = $("#receiverAddr").val();

            if(!receiverName){
                mui.toast('请输入收货人!');
                return false;
            }
            if(!receiverTel){
                mui.toast('请输入联系方式!');
                return false;
            }
            if(!receiverProvinceId){
                mui.toast('请选择省!');
                return false;
            }
            if(!receiverCityId){
                mui.toast('请选择城市!');
                return false;
            }
            if(!receiverCountyId){
                mui.toast('请选择县/区!');
                return false;
            }
            if(!receiverAddr){
                mui.toast('请输入详细地址!');
                return false;
            }
            $.post("${ctx}/m/account/userAddress/updateAddress", {
                addrId: addrId,
                receiverName: receiverName,
                receiverTel: receiverTel,
                receiverProvinceId: receiverProvinceId,
                receiverCityId: receiverCityId,
                receiverCountyId: receiverCountyId,
                receiverAddr: receiverAddr
            },
            function (data) {
                if (data.result == "success") {
                    <#if returnUrl?? && returnUrl?has_content>
                        window.location.href = "${returnUrl}";
                    <#else>
                        window.location.href = "${ctx}/m/account/userAddress";
                    </#if>
                }else{
                	mui.toast(data.message);
                }
            }, "json");
        });

        $('.mui-icon-left-nav').on('click',function () {
            <#if returnUrl?? && returnUrl?has_content>
                window.location.href = "${returnUrl}";
            <#else>
                window.location.href = "${ctx}/m/account/userAddress";
            </#if>
        });
    });
</script>
</body>
</html>